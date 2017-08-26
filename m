Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6521C20285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbdHZI2n (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:43 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54564 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754499AbdHZI2l (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:41 -0400
X-AuditID: 1207440e-bf9ff70000007085-f0-59a13139624b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.7B.28805.93131A95; Sat, 26 Aug 2017 04:28:41 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHir004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:39 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/12] hex_to_bytes(): simpler replacement for `get_oid_hex_segment()`
Date:   Sat, 26 Aug 2017 10:28:11 +0200
Message-Id: <86a8617cf78e456b6f119d8820479b6d82094124.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsUixO6iqGtpuDDS4MsSSYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CV8WxxH2vBA7GKMzua2BoYjwl2MXJySAiYSFz4/5Kxi5GLQ0hgB5PEgr3LmCGcU0wS3y6v
        ZAWpYhPQlVjU08wEYosIqElMbDvEAlLELLCcUaLj7XmwhLBAmMTuBX2MIDaLgKrEnGdHweK8
        AlESv8/uYodYJy+xq+0i2FBOAQuJG1s/s4HYQgLmEn0/F7FMYORZwMiwilEuMac0Vzc3MTOn
        ODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkdPh2MLavlznEKMDBqMTDu6F4QaQQa2JZcWXuIUZJ
        DiYlUV4HjYWRQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4VygB5XhTEiurUovyYVLSHCxK4rxq
        S9T9hATSE0tSs1NTC1KLYLIyHBxKErwd+kCNgkWp6akVaZk5JQhpJg5OkOE8QMMzQGp4iwsS
        c4sz0yHypxgVpcR5HUASAiCJjNI8uF5YbL9iFAd6RZj3NUgVDzAtwHW/AhrMBDRYURBscEki
        QkqqgXFWfMNH+2ihnrNiWuJXV55LdhfWmH/H6YL4vkKVWSIpZx4KTToy3Xe92axTs9Pn/d+z
        KvaoQbihHNu2ZQeMxTacWBpbPEE/UGdF2cy3Qg6Xuy8q/IxdnvvsUfdj9t/Lc/8EvFuxa/9B
        PlHBaWw7f1WFPo3jf7DDed9qjsvHtk54PpNZcdJmad9HSizFGYmGWsxFxYkA9iHtEMgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that `get_oid_hex_segment()` does less, it makes sense to rename
it and simplify its semantics:

* Instead of a `hex_len` parameter, which was the number of hex
  characters (and had to be even), use a `len` parameter, which is the
  number of resulting bytes. This removes then need for the check that
  `hex_len` is even and to divide it by two to determine the number of
  bytes. For good hygiene, declare the `len` parameter to be `size_t`
  instead of `unsigned int`.

* Change the order of the arguments to the more traditional (dst,
  src, len).

* Rename the function to `hex_to_bytes()`.

* Remove a loop variable: just count `len` down instead.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/notes.c b/notes.c
index ce9ba36179..d5409b55e3 100644
--- a/notes.c
+++ b/notes.c
@@ -335,25 +335,18 @@ static void note_tree_free(struct int_node *tree)
 }
 
 /*
- * Convert a partial SHA1 hex string to the corresponding partial SHA1 value.
- * - hex      - Partial SHA1 segment in ASCII hex format
- * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
- * - oid      - Partial SHA1 value is written here
- * Return 0 on success or -1 on error (invalid arguments or input not
- * in hex format).
+ * Read `len` pairs of hexadecimal digits from `hex` and write the
+ * values to `binary` as `len` bytes. Return 0 on success, or -1 if
+ * the input does not consist of hex digits).
  */
-static int get_oid_hex_segment(const char *hex, unsigned int hex_len,
-		unsigned char *oid)
+static int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 {
-	unsigned int i, len = hex_len >> 1;
-	if (hex_len % 2 != 0)
-		return -1;
-	for (i = 0; i < len; i++) {
+	for (; len; len--, hex += 2) {
 		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+
 		if (val & ~0xff)
 			return -1;
-		*oid++ = val;
-		hex += 2;
+		*binary++ = val;
 	}
 	return 0;
 }
@@ -438,8 +431,8 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				/* notes must be blobs */
 				goto handle_non_note;
 
-			if (get_oid_hex_segment(entry.path, path_len,
-						object_oid.hash + prefix_len))
+			if (hex_to_bytes(object_oid.hash + prefix_len, entry.path,
+					 GIT_SHA1_RAWSZ - prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			type = PTR_TYPE_NOTE;
@@ -451,8 +444,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				/* internal nodes must be trees */
 				goto handle_non_note;
 
-			if (get_oid_hex_segment(entry.path, 2,
-						object_oid.hash + len++))
+			if (hex_to_bytes(object_oid.hash + len++, entry.path, 1))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			/*
-- 
2.11.0

