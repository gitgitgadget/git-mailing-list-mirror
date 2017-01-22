Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE1D20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbdAVR5W (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 12:57:22 -0500
Received: from mout.web.de ([212.227.15.14]:61345 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbdAVR5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 12:57:21 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrKIO-1cNQuL3kgW-0135GN; Sun, 22
 Jan 2017 18:57:14 +0100
Subject: [PATCH v2 4/5] string-list: use QSORT_S in string_list_sort()
To:     Git List <git@vger.kernel.org>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <06ff91ec-21c5-f57b-a0ed-3c4b9c8696ff@web.de>
Date:   Sun, 22 Jan 2017 18:57:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vbrQbDXj3mVwW12QyGyBTr4XewBSNfCERi6Vk1xUzF9ccVYyURx
 fCSYhDH7RZKRQQbwq+p6lzwoOlbh2QREui3JNkwuepv6w3sc4Yyq01Fx5DUypFHqmVThWMx
 SGnKsNM+DrDEdD6GKElXkr7wMgq0BY/Oc729r35rncoWMgQorYWxewT4v1euB9TXAWIxJfO
 g1ncvIm7dpLCShsqqW1pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ikk2GbTTSQw=:fYC4huFljMyt51/FfyiGMH
 WITJR27xH66dP8JU5oKRY1Vb+qjDa4t7HFqWW2Pn9qKAskb9BdBtFmcZkD1rU2oiEhBq1RLER
 D2Sw0x/EIxV98ZagpAnJTwOkrqu+ChASlWiZpgHse0a+fKrKE1xRHvkerrChr2MtPHAcp1CmS
 hZkLq4kiTUD27yn1aVG/xVT0DTbDlTqYbolJNqGPX2f6nty3dqI47hx34RLItpOJFanYDzbnD
 /0yKOUqZpoezeIipEExTHU4WTLQDd6SlA088Pd0HSZPnNSFIDTqKCyKUfEhMOO/BYPjVwnW7h
 cdX8vFpEK5/LFskcBtad6sN1zFDtqWxfrcDYXKWiJ/+MSxyp+NCVylAeIrN+kphrwsxp8f/4f
 RFuW/ICH5Pe5kz1mS8wV5ZWaFGSNOZbIDWe6zy70UlnTmLxqdOyOetDAg7/FCw/UYG/Byjzt7
 nXFJbzuSPsxgkyOiAE9jJWh01rIBtsc6gwyqg/GAXJ0PVaHQ+oHER0UdbhNQHzfn05vWyYEA1
 BZ90CDN3dYytgtZzBidihtsda50rd3LIwFAe3jasOR5/AqlxENzI3Vci35zW1+w9k5ustk9zA
 HEUG9XUCL+hGnFRgLwILAM9NoFta35RwT7ro4kJk8v0B3WcGMMBhhgDZl+/H8g7b60Ko+5BeW
 uPya0Itb4gp/KtM2dlpqP8LVbiMPWvrphIxSE9mlxF3fOrcyY7zzyocQl1Tudxum/Bpg0Syn2
 EsasbefLEfxj1Zv2w853W6BLNiKwmXQa6sENohtKiGfLiU7EK+qNec+BmFXU7B811XGYkj1X7
 +EzZX2Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the comparison function to cmp_items() via the context parameter of
qsort_s() instead of using a global variable.  That allows calling
string_list_sort() from multiple parallel threads.

Our qsort_s() in compat/ is slightly slower than qsort(1) from glibc
2.24 for sorting lots of lines:

Test                         HEAD^             HEAD
---------------------------------------------------------------------
0071.2: sort(1)              0.10(0.22+0.01)   0.09(0.21+0.00) -10.0%
0071.3: string_list_sort()   0.16(0.15+0.01)   0.17(0.15+0.00) +6.3%

GNU sort(1) version 8.26 is significantly faster because it uses
multiple parallel threads; with the unportable option --parallel=1 it
becomes slower:

Test                         HEAD^             HEAD
--------------------------------------------------------------------
0071.2: sort(1)              0.21(0.18+0.01)   0.20(0.18+0.01) -4.8%
0071.3: string_list_sort()   0.16(0.13+0.02)   0.17(0.15+0.01) +6.3%

There is some instability -- the numbers for the sort(1) check shouldn't
be affected by this patch.  Anyway, the performance of our qsort_s()
implementation is apparently good enough, at least for this test.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 string-list.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/string-list.c b/string-list.c
index 8c83cac189..45016ad86d 100644
--- a/string-list.c
+++ b/string-list.c
@@ -211,21 +211,18 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
-/* Yuck */
-static compare_strings_fn compare_for_qsort;
-
-/* Only call this from inside string_list_sort! */
-static int cmp_items(const void *a, const void *b)
+static int cmp_items(const void *a, const void *b, void *ctx)
 {
+	compare_strings_fn cmp = ctx;
 	const struct string_list_item *one = a;
 	const struct string_list_item *two = b;
-	return compare_for_qsort(one->string, two->string);
+	return cmp(one->string, two->string);
 }
 
 void string_list_sort(struct string_list *list)
 {
-	compare_for_qsort = list->cmp ? list->cmp : strcmp;
-	QSORT(list->items, list->nr, cmp_items);
+	QSORT_S(list->items, list->nr, cmp_items,
+		list->cmp ? list->cmp : strcmp);
 }
 
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
-- 
2.11.0

