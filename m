From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] diffcore-delta.c: Ignore CR in CRLF for text files
Date: Thu, 28 Jun 2007 23:36:01 -0700
Message-ID: <1183098962312-git-send-email-gitster@pobox.com>
References: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 08:36:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4A5c-0004Tp-Ju
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761553AbXF2GgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760378AbXF2GgJ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:36:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40400 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083AbXF2GgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:36:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629063603.CKQA22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Jun 2007 02:36:03 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HJc11X00M1kojtg0000300; Fri, 29 Jun 2007 02:36:02 -0400
X-Mailer: git-send-email 1.5.2.2.1414.g1e7d9
In-Reply-To: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51155>

This ignores CR byte in CRLF sequence in text file when
computing similarity of two blobs.

Usually this should not matter as nobody sane would be checking
in a file with CRLF line endings to the repository (they would
use autocrlf so that the repository copy would have LF line
endings).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-delta.c       |   14 +++++++++++---
 t/t0022-crlf-rename.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100755 t/t0022-crlf-rename.sh

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7116df0..a038b16 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -122,11 +122,14 @@ static struct spanhash_top *add_spanhash(struct spanhash_top *top,
 	}
 }
 
-static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz)
+static struct spanhash_top *hash_chars(struct diff_filespec *one)
 {
 	int i, n;
 	unsigned int accum1, accum2, hashval;
 	struct spanhash_top *hash;
+	unsigned char *buf = one->data;
+	unsigned int sz = one->size;
+	int is_text = !one->is_binary;
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
@@ -140,6 +143,11 @@ static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz)
 		unsigned int c = *buf++;
 		unsigned int old_1 = accum1;
 		sz--;
+
+		/* Ignore CR in CRLF sequence if text */
+		if (is_text && c == '\r' && sz && *buf == '\n')
+			continue;
+
 		accum1 = (accum1 << 7) ^ (accum2 >> 25);
 		accum2 = (accum2 << 7) ^ (old_1 >> 25);
 		accum1 += c;
@@ -169,14 +177,14 @@ int diffcore_count_changes(struct diff_filespec *src,
 	if (src_count_p)
 		src_count = *src_count_p;
 	if (!src_count) {
-		src_count = hash_chars(src->data, src->size);
+		src_count = hash_chars(src);
 		if (src_count_p)
 			*src_count_p = src_count;
 	}
 	if (dst_count_p)
 		dst_count = *dst_count_p;
 	if (!dst_count) {
-		dst_count = hash_chars(dst->data, dst->size);
+		dst_count = hash_chars(dst);
 		if (dst_count_p)
 			*dst_count_p = dst_count;
 	}
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
new file mode 100755
index 0000000..430a1d1
--- /dev/null
+++ b/t/t0022-crlf-rename.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='ignore CR in CRLF sequence while computing similiarity'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	cat ../t0022-crlf-rename.sh >sample &&
+	git add sample &&
+
+	test_tick &&
+	git commit -m Initial &&
+
+	sed -e "s/\$/
/" ../t0022-crlf-rename.sh >elpmas &&
+	git add elpmas &&
+	rm -f sample &&
+
+	test_tick &&
+	git commit -a -m Second
+
+'
+
+test_expect_success 'diff -M' '
+
+	git diff-tree -M -r --name-status HEAD^ HEAD |
+	sed -e "s/R[0-9]*/RNUM/" >actual &&
+	echo "RNUM	sample	elpmas" >expect &&
+	diff -u expect actual
+
+'
+
+test_done
-- 
1.5.2.2.1414.g1e7d9
