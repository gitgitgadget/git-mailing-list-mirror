From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] verify-pack -v: do not report "chain length 0"
Date: Fri,  7 Aug 2009 20:36:33 -0700
Message-ID: <1249702594-7815-2-git-send-email-gitster@pobox.com>
References: <1249702594-7815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 05:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZcjs-00062d-Dq
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 05:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933147AbZHHDgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 23:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbZHHDgk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 23:36:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020AbZHHDgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 23:36:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B06921B92
	for <git@vger.kernel.org>; Fri,  7 Aug 2009 23:36:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97B9F21B91 for
 <git@vger.kernel.org>; Fri,  7 Aug 2009 23:36:37 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.151.g786db
In-Reply-To: <1249702594-7815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AE8D0976-83CC-11DE-B341-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125241>

When making a histogram of delta chain length in the pack, the program
collects number of objects whose delta depth exceeds the MAX_CHAIN limit
in histogram[0], and showed it as the number of items that exceeds the
limit correctly.  HOWEVER, it also showed the same number labeled as
"chain length = 0".

In fact, we are not showing the number of objects whose chain length is
zero, i.e. the base objects.  Correct this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-verify-pack.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index ebd6dff..b5bd28e 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -8,10 +8,13 @@
 
 static void show_pack_info(struct packed_git *p)
 {
-	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN+1];
+	uint32_t nr_objects, i;
+	int cnt;
+	unsigned long chain_histogram[MAX_CHAIN+1], baseobjects;
 
 	nr_objects = p->num_objects;
 	memset(chain_histogram, 0, sizeof(chain_histogram));
+	baseobjects = 0;
 
 	for (i = 0; i < nr_objects; i++) {
 		const unsigned char *sha1;
@@ -30,9 +33,11 @@ static void show_pack_info(struct packed_git *p)
 						 &delta_chain_length,
 						 base_sha1);
 		printf("%s ", sha1_to_hex(sha1));
-		if (!delta_chain_length)
+		if (!delta_chain_length) {
 			printf("%-6s %lu %lu %"PRIuMAX"\n",
 			       type, size, store_size, (uintmax_t)offset);
+			baseobjects++;
+		}
 		else {
 			printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
 			       type, size, store_size, (uintmax_t)offset,
@@ -44,15 +49,21 @@ static void show_pack_info(struct packed_git *p)
 		}
 	}
 
-	for (i = 0; i <= MAX_CHAIN; i++) {
-		if (!chain_histogram[i])
+	if (baseobjects)
+		printf("non delta: %lu object%s\n",
+		       baseobjects, baseobjects > 1 ? "s" : "");
+
+	for (cnt = 1; cnt <= MAX_CHAIN; cnt++) {
+		if (!chain_histogram[cnt])
 			continue;
-		printf("chain length = %"PRIu32": %"PRIu32" object%s\n", i,
-		       chain_histogram[i], chain_histogram[i] > 1 ? "s" : "");
+		printf("chain length = %d: %lu object%s\n", cnt,
+		       chain_histogram[cnt],
+		       chain_histogram[cnt] > 1 ? "s" : "");
 	}
 	if (chain_histogram[0])
-		printf("chain length > %d: %"PRIu32" object%s\n", MAX_CHAIN,
-		       chain_histogram[0], chain_histogram[0] > 1 ? "s" : "");
+		printf("chain length > %d: %lu object%s\n", MAX_CHAIN,
+		       chain_histogram[0],
+		       chain_histogram[0] > 1 ? "s" : "");
 }
 
 static int verify_one_pack(const char *path, int verbose)
-- 
1.6.4.151.g786db
