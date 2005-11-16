From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: fail if a patch cannot be applied.
Date: Wed, 16 Nov 2005 14:15:31 -0800
Message-ID: <7vmzk444u4.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 23:16:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcVZ2-0003UP-HC
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 23:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVKPWPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 17:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVKPWPd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 17:15:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61419 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751270AbVKPWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 17:15:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116221500.KGTX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 17:15:00 -0500
To: git@vger.kernel.org
In-Reply-To: <7vr79g8mys.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 16 Nov 2005 10:30:19 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12062>

Recently we fixed 'git-apply --stat' not to barf on a binary
differences.  But it accidentally broke the error detection when
we actually attempt to apply them.

This commit fixes the problem and adds test cases.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Junio C Hamano <junkio@cox.net> writes:

 > Catalin Marinas <catalin.marinas@gmail.com> writes:
 >
 >> ... When pushing a patch, if
 >> a merge is needed (like in your case, the base of the foo patch has
 >> changed), StGIT first tries "git-diff-tree | git-apply" for speed
 >> reasons. If this fails, it falls back to a three-way merge.
 >
 > I think many of the scripts rely on git-apply failing reliably
 > for unapplicable patches.  I'll do a new test script in git.git/t
 > and if it fails on binary files, try to fix it today.

 apply.c                 |   11 ++++---
 t/t4103-apply-binary.sh |   78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 4 deletions(-)
 create mode 100644 t/t4103-apply-binary.sh

applies-to: 4dda103301d7b70ec6e6e361d4a8d2cac24eccb4
92927ed0aac56a86f85049215791fcd106af4b62
diff --git a/apply.c b/apply.c
index 590adc6..a002e15 100644
--- a/apply.c
+++ b/apply.c
@@ -891,7 +891,7 @@ static int parse_chunk(char *buffer, uns
 
 	patchsize = parse_single_patch(buffer + offset + hdrsize, size - offset - hdrsize, patch);
 
-	if (!patchsize && !metadata_changes(patch)) {
+	if (!patchsize) {
 		static const char binhdr[] = "Binary files ";
 
 		if (sizeof(binhdr) - 1 < size - offset - hdrsize &&
@@ -899,9 +899,12 @@ static int parse_chunk(char *buffer, uns
 			    sizeof(binhdr)-1))
 			patch->is_binary = 1;
 
-		if (patch->is_binary && !apply && !check)
-			;
-		else
+		/* Empty patch cannot be applied if:
+		 * - it is a binary patch or
+		 * - metadata does not change and is not a binary patch.
+		 */
+		if ((apply || check) &&
+		    (patch->is_binary || !metadata_changes(patch)))
 			die("patch with only garbage at line %d", linenr);
 	}
 
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
new file mode 100644
index 0000000..948d5b5
--- /dev/null
+++ b/t/t4103-apply-binary.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-apply handling binary patches
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat >file1 <<EOF
+A quick brown fox jumps over the lazy dog.
+A tiny little penguin runs around in circles.
+There is a flag with Linux written on it.
+A slow black-and-white panda just sits there,
+munching on his bamboo.
+EOF
+cat file1 >file2
+cat file1 >file4
+
+git-update-index --add --remove file1 file2 file4
+git-commit -m 'Initial Version' 2>/dev/null
+
+git-checkout -b binary
+tr 'x' '\0' <file1 >file3
+cat file3 >file4
+git-add file2
+tr '\0' 'v' <file3 >file1
+rm -f file2
+git-update-index --add --remove file1 file2 file3 file4
+git-commit -m 'Second Version'
+
+git-diff-tree -p master binary >B.diff
+git-diff-tree -p -C master binary >C.diff
+
+test_expect_success 'stat binary diff -- should not fail.' \
+	'git-checkout master
+	 git-apply --stat --summary B.diff'
+
+test_expect_success 'stat binary diff (copy) -- should not fail.' \
+	'git-checkout master
+	 git-apply --stat --summary C.diff'
+
+test_expect_failure 'check binary diff -- should fail.' \
+	'git-checkout master
+	 git-apply --check B.diff'
+
+test_expect_failure 'check binary diff (copy) -- should fail.' \
+	'git-checkout master
+	 git-apply --check C.diff'
+
+# Now we start applying them.
+
+test_expect_failure 'apply binary diff -- should fail.' \
+	'git-checkout master
+	 git-apply B.diff'
+
+git-reset --hard
+
+test_expect_failure 'apply binary diff -- should fail.' \
+	'git-checkout master
+	 git-apply --index B.diff'
+
+git-reset --hard
+
+test_expect_failure 'apply binary diff (copy) -- should fail.' \
+	'git-checkout master
+	 git-apply C.diff'
+
+git-reset --hard
+
+test_expect_failure 'apply binary diff (copy) -- should fail.' \
+	'git-checkout master
+	 git-apply --index C.diff'
+
+test_done
---
0.99.9.GIT
