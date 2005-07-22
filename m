From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] apply.c: handle incomplete lines correctly.
Date: Fri, 22 Jul 2005 09:56:39 -0700
Message-ID: <7vsly6wzi0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 18:56:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw0pM-0005xw-MB
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 18:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVGVQ4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 12:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVGVQ4m
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 12:56:42 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58085 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262118AbVGVQ4l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 12:56:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722165636.YDUP550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 12:56:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The parsing code had a bug that failed to recognize an
incomplete line at the end of a fragment, and the fragment
application code had a comparison bug to recognize such.  Fix
them to handle incomplete lines correctly.

Add a test script for patches with various combinations of
complete and incomplete lines to make sure the fix works.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 apply.c               |    9 ++++++++-
 t/t4101-apply-nonl.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletions(-)
 create mode 100755 t/t4101-apply-nonl.sh

9b378103b8ba89d697cdf368d29a6113929b127a
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -679,6 +679,13 @@ static int parse_fragment(char *line, un
 			break;
 		}
 	}
+	/* If a fragment ends with an incomplete line, we failed to include
+	 * it in the above loop because we hit oldlines == newlines == 0
+	 * before seeing it.
+	 */
+	if (12 < size && !memcmp(line, "\\ No newline", 12))
+		offset += linelen(line, size);
+
 	patch->lines_added += added;
 	patch->lines_deleted += deleted;
 	return offset;
@@ -900,7 +907,7 @@ static int apply_one_fragment(struct buf
 		 * last one (which is the newline, of course).
 		 */
 		plen = len-1;
-		if (len > size && patch[len] == '\\')
+		if (len < size && patch[len] == '\\')
 			plen--;
 		switch (*patch) {
 		case ' ':
diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
new file mode 100755
--- /dev/null
+++ b/t/t4101-apply-nonl.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-apply should handle files with incomplete lines.
+
+'
+. ./test-lib.sh
+
+# setup
+
+(echo a; echo b) >frotz.0
+(echo a; echo b; echo c) >frotz.1
+(echo a; echo b | tr -d '\012') >frotz.2
+(echo a; echo c; echo b | tr -d '\012') >frotz.3
+
+for i in 0 1 2 3
+do
+  for j in 0 1 2 3
+  do
+    test $i -eq $j && continue
+    diff -u frotz.$i frotz.$j |
+    sed -e '
+	/^---/s|.*|--- a/frotz|
+	/^+++/s|.*|+++ b/frotz|' >diff.$i-$j
+    cat frotz.$i >frotz
+    test_expect_success \
+        "apply diff between $i and $j" \
+	"git-apply <diff.$i-$j && diff frotz.$j frotz"
+  done
+done
