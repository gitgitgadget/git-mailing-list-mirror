From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/2] patch-id: Add support for mbox format
Date: Mon, 19 Apr 2010 10:46:14 +0200
Message-ID: <1271666774-11619-2-git-send-email-bonzini@gnu.org>
References: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org>
 <1271666774-11619-1-git-send-email-bonzini@gnu.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 10:46:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3mcb-0004rg-BO
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 10:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0DSIqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 04:46:20 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:38112 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab0DSIqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 04:46:19 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1O3mcU-00021i-JL; Mon, 19 Apr 2010 04:46:18 -0400
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1271666774-11619-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145283>

I have an alias that takes two arguments and compares their patch IDs.
I would like to use to make sure I've tested exactly what I submit
(patch by patch), like

   git patch-cmp origin/master.. file-being-sent

However, I cannot do that because git patch-id is fooled by the "-- "
trailer that git format-patch puts, or likely by the MIME boundary.

This patch adds hunk parsing logic to git patch-id in order to detect an
out of place "-" line and split the patch when it comes.  In addition,
commit ids in the "From " lines are considered and printed in the output.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin/patch-id.c  |   70 +++++++++++++++++++++++++++++++++++++++++++++-----
 t/t4204-patch-id.sh |   28 ++++++++++++++++++++
 2 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 78d24dc..c3ecf8f 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -28,10 +28,40 @@ static int remove_space(char *line)
 	return dst - line;
 }
 
+static int scan_hunk_header(const char *p, int *p_before, int *p_after)
+{
+	static const char digits[] = "0123456789";
+	const char *q, *r;
+	int n;
+
+	q = p + 4;
+	n = strspn(q, digits);
+	if (q[n] == ',') {
+		q += n + 1;
+		n = strspn(q, digits);
+	}
+	if (n == 0 || q[n] != ' ' || q[n+1] != '+')
+		return 0;
+
+	r = q + n + 2;
+	n = strspn(r, digits);
+	if (r[n] == ',') {
+		r += n + 1;
+		n = strspn(r, digits);
+	}
+	if (n == 0)
+		return 0;
+
+	*p_before = atoi(q);
+	*p_after = atoi(r);
+	return 1;
+}
+
 int get_one_patchid (unsigned char *next_sha1, git_SHA_CTX *ctx)
 {
 	static char line[1000];
 	int patchlen = 0;
+	int before = -1, after = -1;
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		char *p = line;
 		int len;
@@ -40,6 +70,8 @@ int get_one_patchid (unsigned char *next_sha1, git_SHA_CTX *ctx)
 			p += 10;
 		else if (!memcmp(line, "commit ", 7))
 			p += 7;
+		else if (!memcmp(line, "From ", 5))
+			p += 5;
 
 		if (!get_sha1_hex(p, next_sha1))
 			break;
@@ -48,13 +80,37 @@ int get_one_patchid (unsigned char *next_sha1, git_SHA_CTX *ctx)
 		if (!patchlen && memcmp(line, "diff ", 5))
 			continue;
 
-		/* Ignore git-diff index header */
-		if (!memcmp(line, "index ", 6))
-			continue;
-
-		/* Ignore line numbers when computing the SHA1 of the patch */
-		if (!memcmp(line, "@@ -", 4))
-			continue;
+		/* Parsing diff header?  */
+		if (before == -1) {
+			if (!memcmp(line, "index ", 6))
+				continue;
+			else if (!memcmp(line, "--- ", 4))
+				before = after = 1;
+			else if (!isalpha(line[0]))
+				break;
+		}
+
+		/* Looking for a valid hunk header?  */
+		if (before == 0 && after == 0) {
+			if (!memcmp (line, "@@ -", 4)) {
+				/* Parse next hunk, but ignore line numbers.  */
+				scan_hunk_header (line, &before, &after);
+				continue;
+			}
+
+			/* Split at the end of the patch.  */
+			if (memcmp (line, "diff ", 5))
+				break;
+
+			/* Else we're parsing another header.  */
+			before = after = -1;
+		}
+
+		/* If we get here, we're inside a hunk.  */
+		if (line[0] == '-' || line[0] == ' ')
+			before--;
+		if (line[0] == '+' || line[0] == ' ')
+			after--;
 
 		/* Compute the sha without whitespace */
 		len = remove_space(line);
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 04f7bae..68e2652 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -18,6 +18,11 @@ test_expect_success 'patch-id output is well-formed' '
 	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
 '
 
+calc_patch_id () {
+	git patch-id |
+		sed "s# .*##" > patch-id_"$1"
+}
+
 get_patch_id () {
 	git log -p -1 "$1" | git patch-id |
 		sed "s# .*##" > patch-id_"$1"
@@ -35,4 +40,27 @@ test_expect_success 'patch-id detects inequality' '
 	! test_cmp patch-id_master patch-id_notsame
 '
 
+test_expect_success 'patch-id supports git-format-patch output' '
+	get_patch_id master &&
+	git checkout same &&
+	git format-patch -1 --stdout | calc_patch_id same &&
+	test_cmp patch-id_master patch-id_same &&
+	set `git format-patch -1 --stdout | git patch-id` &&
+	test "$2" = `git rev-parse HEAD`
+'
+
+test_expect_success 'whitespace is irrelevant in footer' '
+	get_patch_id master &&
+	git checkout same &&
+	git format-patch -1 --stdout | sed "s/ \$//" | calc_patch_id same &&
+	test_cmp patch-id_master patch-id_same
+'
+
+test_expect_success 'patch-id supports git-format-patch MIME output' '
+	get_patch_id master &&
+	git checkout same &&
+	git format-patch -1 --attach --stdout | calc_patch_id same &&
+	test_cmp patch-id_master patch-id_same
+'
+
 test_done
-- 
1.6.6.1
