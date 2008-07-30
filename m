From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 1/2] merge-base: teach "git merge-base" to accept
 more than 2 arguments
Date: Wed, 30 Jul 2008 07:04:14 +0200
Message-ID: <20080730070414.f7b36eec.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3oY-0005ON-On
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYG3FAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYG3FAa
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:00:30 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:36059 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYG3FA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:00:29 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 6060112B6D8;
	Wed, 30 Jul 2008 07:00:26 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id E70BB12B6D7;
	Wed, 30 Jul 2008 07:00:25 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90738>

Before this patch "git merge-base" accepted only 2 arguments, so
only merge bases between 2 references could be computed.

The purpose of this patch is to make "git merge-base" accept more
than 2 arguments, so that the merge bases between the first given
reference and all the other references can be computed.

This is easily implemented because the "get_merge_bases_many"
function in "commit.c" already implements the needed computation.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-merge-base.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

	Changes since previous version are:

	- the patch is simpler because it now goes on top of
	a fix that added the "get_commit_reference" function,

	- documentation has been removed from the first patch
	and Junio's documentation has been added in a new 2/2
	patch.

	There are still no tests. I need to find time to work
	on them before friday otherwise it will probably have
	to wait until I come back from vacation.

diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 3382b13..b08da51 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -2,9 +2,11 @@
 #include "cache.h"
 #include "commit.h"
 
-static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
+static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
-	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
+	struct commit_list *result;
+
+	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 0);
 
 	if (!result)
 		return 1;
@@ -20,7 +22,7 @@ static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_al
 }
 
 static const char merge_base_usage[] =
-"git merge-base [--all] <commit-id> <commit-id>";
+"git merge-base [--all] <commit-id> <commit-id>...";
 
 static struct commit *get_commit_reference(const char *arg)
 {
@@ -38,7 +40,8 @@ static struct commit *get_commit_reference(const char *arg)
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
-	struct commit *rev1, *rev2;
+	struct commit **rev;
+	int rev_nr = 0;
 	int show_all = 0;
 
 	git_config(git_default_config, NULL);
@@ -51,10 +54,15 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 			usage(merge_base_usage);
 		argc--; argv++;
 	}
-	if (argc != 3)
+	if (argc < 3)
 		usage(merge_base_usage);
-	rev1 = get_commit_reference(argv[1]);
-	rev2 = get_commit_reference(argv[2]);
 
-	return show_merge_base(rev1, rev2, show_all);
+	rev = xmalloc((argc - 1) * sizeof(*rev));
+
+	do {
+		rev[rev_nr++] = get_commit_reference(argv[1]);
+		argc--; argv++;
+	} while (argc > 1);
+
+	return show_merge_base(rev, rev_nr, show_all);
 }
-- 
1.6.0.rc0.42.g186458.dirty
