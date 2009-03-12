From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7] rev-list: don't find all bisect commits if there are no
 skipped commits
Date: Thu, 12 Mar 2009 08:51:37 +0100
Message-ID: <20090312085137.f58fa54b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhfkm-0007QV-Gh
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbZCLHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbZCLHwf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:52:35 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54871 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbZCLHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:52:34 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id E5C3C4B016F;
	Thu, 12 Mar 2009 08:52:24 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id C86F94B009D;
	Thu, 12 Mar 2009 08:52:21 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113018>

This patch optimizes the behavior of the "--bisect-skip" option of
"git rev-list", so that it does not try to find all possible bisection
points when only one is needed because there are no skipped commits.

This makes the behavior of "git rev-list --bisect-skip" similar as
what is done in "git-bisect.sh" to choose if it should pass the
"--bisect-all" option to "git rev-list". So this has the added
benefit that it will make the test suite pass as is when we will
use "--bisect-skip" in "git-bisect.sh" in a later patch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect-skip.c      |    5 +++++
 bisect.h           |    1 +
 builtin-rev-list.c |    4 +++-
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/bisect-skip.c b/bisect-skip.c
index 9228465..789ee09 100644
--- a/bisect-skip.c
+++ b/bisect-skip.c
@@ -28,6 +28,11 @@ void register_skipped(const char *skipped)
 	strbuf_release(&sb);
 }
 
+int skipped_nr(void)
+{
+	return skipped_sha1_nr;
+}
+
 static int skipcmp(const void *a, const void *b)
 {
 	return hashcmp(a, b);
diff --git a/bisect.h b/bisect.h
index c5f9fe1..ff9c781 100644
--- a/bisect.h
+++ b/bisect.h
@@ -2,6 +2,7 @@
 #define BISECT_H
 
 void register_skipped(const char *skipped);
+int skipped_nr(void);
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
 				   int show_all);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6e0466e..4af70d7 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -337,7 +337,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!prefixcmp(arg, "--bisect-skip=")) {
 			bisect_list = 1;
 			bisect_show_vars = 1;
-			bisect_find_all = 1;
 			bisect_skip = 1;
 			register_skipped(arg + 14);
 			continue;
@@ -384,6 +383,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches = reaches, all = all;
 
+		if (bisect_skip && !bisect_find_all)
+			bisect_find_all = !!skipped_nr();
+
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
 
-- 
1.6.2.83.g012a16.dirty
