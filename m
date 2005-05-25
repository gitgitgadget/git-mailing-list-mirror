From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Mode only changes from diff.
Date: Wed, 25 May 2005 16:00:04 -0700
Message-ID: <7v1x7uj4i3.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050525111711.GA27492@vrfy.org>
	<Pine.LNX.4.58.0505251054110.2307@ppc970.osdl.org>
	<20050525183546.GA4241@vrfy.org>
	<7vzmujjdq4.fsf@assigned-by-dhcp.cox.net>
	<20050525222622.GA8552@vrfy.org>
	<Pine.LNX.4.58.0505251544250.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 01:00:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db4qF-0003mg-82
	for gcvg-git@gmane.org; Thu, 26 May 2005 00:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVEYXAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 19:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVEYXAl
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 19:00:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25270 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261603AbVEYXAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 19:00:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525230006.JADX7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 19:00:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505251544250.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 25 May 2005 15:47:10 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes another bug.

 - Mode-only changes were pruned incorrectly from the output.
 - Added test to catch the above problem.
 - Normalize rename/copy similarity score in the diff-raw output
   to per-cent, no matter what scale we internally use.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-helper.c        |    2 ++
diff.c               |    6 ++++--
t/t4006-diff-mode.sh |   34 ++++++++++++++++++++++++++++++++++
3 files changed, 40 insertions(+), 2 deletions(-)
new file (100755): t/t4006-diff-mode.sh

diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "diff.h"
+#include "diffcore.h" /* just for MAX_SCORE */
 
 static const char *pickaxe = NULL;
 static int line_termination = '\n';
@@ -77,6 +78,7 @@ int main(int ac, const char **av) {
 			if (status == 'R' || status == 'C') {
 				two_paths = 1;
 				sscanf(cp, "%d", &score);
+				score = score * MAX_SCORE / 100;
 				if (line_termination) {
 					cp = strchr(cp,
 						    inter_name_termination);
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -517,7 +517,8 @@ static void diff_flush_raw(struct diff_f
 	switch (p->status) {
 	case 'C': case 'R':
 		two_paths = 1;
-		sprintf(status, "%c%1d", p->status, p->score);
+		sprintf(status, "%c%03d", p->status,
+			(int)(0.5 + p->score * 100.0/MAX_SCORE));
 		break;
 	default:
 		two_paths = 0;
@@ -750,7 +751,8 @@ static void diff_resolve_rename_copy(voi
 			if (!p->status)
 				p->status = 'R';
 		}
-		else if (memcmp(p->one->sha1, p->two->sha1, 20))
+		else if (memcmp(p->one->sha1, p->two->sha1, 20) ||
+			 p->one->mode != p->two->mode)
 			p->status = 'M';
 		else
 			/* this is a "no-change" entry */
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
new file mode 100755
--- /dev/null
+++ b/t/t4006-diff-mode.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test mode change diffs.
+
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'echo frotz >rezrov &&
+     git-update-cache --add rezrov &&
+     tree=`git-write-tree` &&
+     echo $tree'
+
+test_expect_success \
+    'chmod' \
+    'chmod +x rezrov &&
+     git-update-cache rezrov &&
+     git-diff-cache $tree >current'
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sed -e 's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /' <current >check
+echo ":100644 100755 X X M	rezrov" >expected
+
+test_expect_success \
+    'verify' \
+    'diff -u expected check'
+
+test_done
+
------------------------------------------------

