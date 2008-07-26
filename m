From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] merge-base: teach "git merge-base" to accept more than
 2 arguments
Date: Sat, 26 Jul 2008 05:59:20 +0200
Message-ID: <20080726055920.3a2fc8e7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 05:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMatT-0007np-C7
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 05:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbYGZDzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 23:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbYGZDzb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 23:55:31 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:58698 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbYGZDza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 23:55:30 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 17A561AB2B5;
	Sat, 26 Jul 2008 05:55:28 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id A68FC1AB2BB;
	Sat, 26 Jul 2008 05:55:27 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90166>

Before this patch "git merge-base" accepted only 2 arguments, so
only merge bases between 2 references could be computed.

The purpose of this patch is to make "git merge-base" accept more
than 2 arguments so that the merge bases between the first given
reference and all the other references can be computed.

This is easily implemented because the "get_merge_bases_many"
function in "commit.c" already implements the computation.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-merge-base.c |   51 ++++++++++++++++++++++++++++++++++++-------------
 commit.h             |    2 +
 2 files changed, 39 insertions(+), 14 deletions(-)

	I suspect this patch may be usefull to simplify my
	"bisect: add merge bases check" series and perhaps
	also generally usefull.

	I will add documentation and perhaps tests too if
	people are ok with something like that.

	By the way perhaps such a patch has already been
	posted by someone else. In this case sorry for the
	noise and thanks for any pointer to the previous
	patch.

diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 1cb2925..9c41849 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -2,9 +2,14 @@
 #include "cache.h"
 #include "commit.h"
 
-static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
+static struct commit *rev1, **prev2;
+static size_t prev2_nr, prev2_alloc;
+
+
+static int show_merge_base(int show_all)
 {
-	struct commit_list *result = get_merge_bases(rev1, rev2, 0);
+	struct commit_list *result = get_merge_bases_many(rev1, prev2_nr,
+							  prev2, 0);
 
 	if (!result)
 		return 1;
@@ -20,12 +25,24 @@ static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_al
 }
 
 static const char merge_base_usage[] =
-"git merge-base [--all] <commit-id> <commit-id>";
+"git merge-base [--all] <commit-id> <commit-id>...";
+
+static void append_rev2(struct commit *rev)
+{
+	ALLOC_GROW(prev2, prev2_nr + 1, prev2_alloc);
+	prev2[prev2_nr++] = rev;
+}
+
+static struct commit *get_commit_reference(const char *arg)
+{
+	unsigned char revkey[20];
+	if (get_sha1(arg, revkey))
+		die("Not a valid object name %s", arg);
+	return lookup_commit_reference(revkey);
+}
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
-	struct commit *rev1, *rev2;
-	unsigned char rev1key[20], rev2key[20];
 	int show_all = 0;
 
 	git_config(git_default_config, NULL);
@@ -38,15 +55,21 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 			usage(merge_base_usage);
 		argc--; argv++;
 	}
-	if (argc != 3)
+	if (argc < 3)
 		usage(merge_base_usage);
-	if (get_sha1(argv[1], rev1key))
-		die("Not a valid object name %s", argv[1]);
-	if (get_sha1(argv[2], rev2key))
-		die("Not a valid object name %s", argv[2]);
-	rev1 = lookup_commit_reference(rev1key);
-	rev2 = lookup_commit_reference(rev2key);
-	if (!rev1 || !rev2)
+
+	rev1 = get_commit_reference(argv[1]);
+	if (!rev1)
 		return 1;
-	return show_merge_base(rev1, rev2, show_all);
+	argc--; argv++;
+
+	do {
+		struct commit *rev2 = get_commit_reference(argv[1]);
+		if (!rev2)
+			return 1;
+		append_rev2(rev2);
+		argc--; argv++;
+	} while (argc > 1);
+
+	return show_merge_base(show_all);
 }
diff --git a/commit.h b/commit.h
index 77de962..4829a5c 100644
--- a/commit.h
+++ b/commit.h
@@ -121,6 +121,8 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_merge_bases_many(struct commit *one,
+		int n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 extern int register_shallow(const unsigned char *sha1);
-- 
1.6.0.rc0.43.g62478.dirty
