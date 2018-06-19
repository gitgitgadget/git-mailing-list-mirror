Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FF31F403
	for <e@80x24.org>; Tue, 19 Jun 2018 21:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967138AbeFSVvZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 17:51:25 -0400
Received: from avasout08.plus.net ([212.159.14.20]:48419 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755466AbeFSVvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 17:51:23 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id VOX2f51cOhRmOVOX3fW4mW; Tue, 19 Jun 2018 22:51:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=TMRrtWta c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=EBOSESyhAAAA:8 a=O-cJoVu8a9UVi2Q7dz0A:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] ewah: delete unused 'rlwit_discharge_empty()'
Message-ID: <7bfb528f-ef65-4de6-7d01-6ca91f0072e7@ramsayjones.plus.com>
Date:   Tue, 19 Jun 2018 22:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKuyThgzqOBi4YniuWfa8RWJkjXCr/VzYzAZnFwz9LM0DzcPD4Gp3FAaUQyBrOgWvgHj5qqk9OcuSypX5St5JQtPp1tdxRzfPw+TJD7j2BfcsQyCfWE5
 UO945kqRg5Xe41dm6bzXFHiCi/oMLGqXE4eNvTIywqPsv2gugpGZXZp6DAfoEsGi3yHE4onAEwyeKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Complete the removal of unused 'ewah bitmap' code by removing the now
unused 'rlwit_discharge_empty()' function. Also, the 'ewah_clear()'
function can now be made a file-scope static symbol.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Can you please add this to the 'ds/ewah-cleanup' branch, before
we forget to do so! ;-)

Thanks!

ATB,
Ramsay Jones

 ewah/ewah_bitmap.c | 20 ++++++++++++--------
 ewah/ewah_rlw.c    |  8 --------
 ewah/ewok.h        |  6 ------
 ewah/ewok_rlw.h    |  1 -
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 017c677f9..d59b1afe3 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -276,6 +276,18 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 	}
 }
 
+/**
+ * Clear all the bits in the bitmap. Does not free or resize
+ * memory.
+ */
+static void ewah_clear(struct ewah_bitmap *self)
+{
+	self->buffer_size = 1;
+	self->buffer[0] = 0;
+	self->bit_size = 0;
+	self->rlw = self->buffer;
+}
+
 struct ewah_bitmap *ewah_new(void)
 {
 	struct ewah_bitmap *self;
@@ -288,14 +300,6 @@ struct ewah_bitmap *ewah_new(void)
 	return self;
 }
 
-void ewah_clear(struct ewah_bitmap *self)
-{
-	self->buffer_size = 1;
-	self->buffer[0] = 0;
-	self->bit_size = 0;
-	self->rlw = self->buffer;
-}
-
 void ewah_free(struct ewah_bitmap *self)
 {
 	if (!self)
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
index b9643b7d0..5093d43e2 100644
--- a/ewah/ewah_rlw.c
+++ b/ewah/ewah_rlw.c
@@ -104,11 +104,3 @@ size_t rlwit_discharge(
 
 	return index;
 }
-
-void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out)
-{
-	while (rlwit_word_size(it) > 0) {
-		ewah_add_empty_words(out, 0, rlwit_word_size(it));
-		rlwit_discard_first_words(it, rlwit_word_size(it));
-	}
-}
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 0c504f28e..84b2a29fa 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -72,12 +72,6 @@ void ewah_pool_free(struct ewah_bitmap *self);
  */
 struct ewah_bitmap *ewah_new(void);
 
-/**
- * Clear all the bits in the bitmap. Does not free or resize
- * memory.
- */
-void ewah_clear(struct ewah_bitmap *self);
-
 /**
  * Free all the memory of the bitmap
  */
diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index bb3c6ff7e..7cdfdd0c0 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -98,7 +98,6 @@ void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *bitmap);
 void rlwit_discard_first_words(struct rlw_iterator *it, size_t x);
 size_t rlwit_discharge(
 	struct rlw_iterator *it, struct ewah_bitmap *out, size_t max, int negate);
-void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out);
 
 static inline size_t rlwit_word_size(struct rlw_iterator *it)
 {
-- 
2.17.0
