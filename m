From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/7 v3] merge-base: add "--bisect-replace" option to use
 fixed up revs
Date: Sat, 8 Nov 2008 08:51:10 +0100
Message-ID: <20081108085110.4e4b47de.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 08:50:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyia3-00088W-B2
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 08:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYKHHsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 02:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYKHHst
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 02:48:49 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:35737 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbYKHHst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 02:48:49 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E4EB41AB2D5;
	Sat,  8 Nov 2008 08:48:47 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id A4ABA1AB2D0;
	Sat,  8 Nov 2008 08:48:47 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100387>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-merge-base.txt |    6 +++++-
 builtin-merge-base.c             |    8 +++++++-
 t/t6035-bisect-replace.sh        |    7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2f0c525..af174f7 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,7 +8,7 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
-'git merge-base' [--all] <commit> <commit>...
+'git merge-base' [--all] [--bisect-replace] <commit> <commit>...
 
 DESCRIPTION
 -----------
@@ -32,6 +32,10 @@ OPTIONS
 --all::
 	Output all merge bases for the commits, instead of just one.
 
+--bisect-replace::
+	Use fixed up history from "bisect-replace-*" branches when
+	computing merge bases.
+
 DISCUSSION
 ----------
 
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 03fc1c2..31c0015 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -46,9 +46,13 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	struct commit **rev;
 	int rev_nr = 0;
 	int show_all = 0;
+	int bisect_replace = 0;
 
 	struct option options[] = {
-		OPT_BOOLEAN('a', "all", &show_all, "outputs all common ancestors"),
+		OPT_BOOLEAN('a', "all", &show_all,
+			    "outputs all common ancestors"),
+		OPT_BOOLEAN(0, "bisect-replace", &bisect_replace,
+			    "use revs from 'bisect-replace-*' branches"),
 		OPT_END()
 	};
 
@@ -56,6 +60,8 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, options, merge_base_usage, 0);
 	if (argc < 2)
 		usage_with_options(merge_base_usage, options);
+	if (bisect_replace)
+		bisect_replace_all();
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
index bc07206..8fe7cc5 100755
--- a/t/t6035-bisect-replace.sh
+++ b/t/t6035-bisect-replace.sh
@@ -137,6 +137,13 @@ test_expect_success '"git rev-list --bisect-replace" works' '
      test_cmp rev_list.expect rev_list.output
 '
 
+test_expect_success '"git merge-base --bisect-replace" works' '
+     hash=$(git merge-base --all --bisect-replace $HASH7 $HASHFIX3) &&
+     test "$hash" = "$HASHFIX3" &&
+     hash=$(git merge-base --all --bisect-replace $HASH7 $HASH3) &&
+     test "$hash" = "$HASH1"
+'
+
 #
 #
 test_done
-- 
1.6.0.3.619.g9a6a
