From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] patch-id: Add support for mbox format
Date: Fri, 16 Apr 2010 18:22:28 +0200
Message-ID: <1271434948-14134-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:22:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oJW-00087z-CG
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539Ab0DPQWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:22:34 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:41078 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530Ab0DPQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:22:33 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1O2oJM-0007tu-Om
	for git@vger.kernel.org; Fri, 16 Apr 2010 12:22:32 -0400
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145070>

I have an alias that takes two arguments and compares their patch IDs.
I would like to use to make sure I've tested exactly what I submit
(patch by patch), like

   git patch-cmp origin/master.. file-being-sent

However, I cannot do that because git patch-id is fooled by the
"-- " trailer that git format-patch puts.

This patch adds a bit of lookahead to git patch-id in order to detect
the trailer and split the patch when it comes.  In addition, commit
ids in the "From " lines are considered and printed in the output.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
	I couldn't resist testing it right away:

	$ git format-patch -1
	0001-patch-id-Add-support-for-mbox-format.patch

	### With the git I have installed:
	$ git patch-cmp HEAD^! 0001-patch-id-Add-support-for-mbox-format.patch
	HEAD^! and 0001-patch-id-Add-support-for-mbox-format.patch differ

	### With this patch:
	$ PATH=.:$PATH !!
	HEAD^! and 0001-patch-id-Add-support-for-mbox-format.patch are the same

 builtin/patch-id.c  |   23 ++++++++++++++++++++++-
 t/t4204-patch-id.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index af0911e..895c526 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -34,17 +34,22 @@ static void generate_id_list(void)
 	static char line[1000];
 	git_SHA_CTX ctx;
 	int patchlen = 0;
+	int have_line = 0;
 
 	git_SHA1_Init(&ctx);
-	while (fgets(line, sizeof(line), stdin) != NULL) {
+	while (!feof (stdin) &&
+	       (have_line || fgets(line, sizeof(line), stdin) != NULL)) {
 		unsigned char n[20];
 		char *p = line;
 		int len;
 
+		have_line = 0;
 		if (!memcmp(line, "diff-tree ", 10))
 			p += 10;
 		else if (!memcmp(line, "commit ", 7))
 			p += 7;
+		else if (!memcmp(line, "From ", 5))
+			p += 5;
 
 		if (!get_sha1_hex(p, n)) {
 			flush_current_id(patchlen, sha1, &ctx);
@@ -67,6 +72,22 @@ static void generate_id_list(void)
 
 		/* Compute the sha without whitespace */
 		len = remove_space(line);
+
+		/* Split at -- followed by version number.  */
+		if (len == 2 && line[0] == '-' && line[1] == '-') {
+			if (fgets(line, sizeof(line), stdin) != NULL &&
+			    isdigit (*line)) {
+				flush_current_id(patchlen, sha1, &ctx);
+				patchlen = 0;
+			} else {
+				/* Just a normal unified diff line.  */
+				patchlen += 2;
+				git_SHA1_Update(&ctx, "--", 2);
+				have_line = 1;
+			}
+			continue;
+		}
+
 		patchlen += len;
 		git_SHA1_Update(&ctx, line, len);
 	}
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 04f7bae..2110eac 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -18,6 +18,11 @@ test_expect_success 'patch-id output is well-formed' '
 	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
 '
 
+get_text_patch_id () {
+	tr % '\n' | git patch-id |
+		sed "s# .*##" > patch-id_"$1"
+}
+
 get_patch_id () {
 	git log -p -1 "$1" | git patch-id |
 		sed "s# .*##" > patch-id_"$1"
@@ -35,4 +40,31 @@ test_expect_success 'patch-id detects inequality' '
 	! test_cmp patch-id_master patch-id_notsame
 '
 
+test_expect_success 'patch-id does not discard meaningful -- line' '
+	echo "diff a b%--%-ab%-cd" | get_text_patch_id first &&
+	echo "diff a b%-ab%-cd" | get_text_patch_id second &&
+	! test_cmp patch-id_first patch-id_second
+'
+
+test_expect_success 'patch-id does not discard meaningful final -- line' '
+	echo "diff a b%-ab%-cd%--" | get_text_patch_id first &&
+	echo "diff a b%-ab%-cd" | get_text_patch_id second &&
+	! test_cmp patch-id_first patch-id_second
+'
+
+test_expect_success 'whitespace is irrelevant in footer' '
+	echo "diff a b%--%-ab%-cd%-- %1.2" | get_text_patch_id first &&
+	echo "diff a b%--%-ab%-cd%--%1.2" | get_text_patch_id second &&
+	test_cmp patch-id_first patch-id_second
+'
+
+test_expect_success 'patch-id supports git-format-patch output' '
+	get_patch_id master &&
+	git checkout same &&
+	git format-patch -1 --stdout | get_text_patch_id same &&
+	test_cmp patch-id_master patch-id_same &&
+	set `git format-patch -1 --stdout | git patch-id` &&
+	test "$2" = `git rev-parse HEAD`
+'
+
 test_done
-- 
1.6.6.1
