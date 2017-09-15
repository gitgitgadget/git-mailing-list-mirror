Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A047620281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdIOQAq (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:00:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58032 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751211AbdIOQAp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Sep 2017 12:00:45 -0400
X-AuditID: 12074411-f7dff70000007f0a-f0-59bbf92c2417
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.75.32522.C29FBB95; Fri, 15 Sep 2017 12:00:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE5E5.dip0.t-ipconnect.de [84.170.229.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8FG0f9p016427
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 15 Sep 2017 12:00:43 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] for_each_string_list_item(): behave correctly for empty list
Date:   Fri, 15 Sep 2017 18:00:38 +0200
Message-Id: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsUixO6iqKvzc3ekQedjI4uuK91MFg29V5gt
        bq+Yz2zxv+0dmwOLx9/3H5g8ds66y+5x8ZKyx+dNcgEsUVw2Kak5mWWpRfp2CVwZL+/eYStY
        Jlyx5+5N1gbGFfxdjJwcEgImEo3/DjB2MXJxCAnsYJJoP/wFyjnFJDHl9DxGkCo2AV2JRT3N
        TCC2iICaxMS2QywgNrNAtsThIzvYQWxhAV+Jq4/fg9WwCKhKvJj/DCzOKxAl0b3rGxvENnmJ
        cw9uM09g5FrAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTI8TvgjsYZ5yU
        O8QowMGoxMPbcHl3pBBrYllxZe4hRkkOJiVRXvPXQCG+pPyUyozE4oz4otKc1OJDjBIczEoi
        vIrfgXK8KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4OJQle+x9AjYJFqemp
        FWmZOSUIaSYOTpDhPEDDb4ANLy5IzC3OTIfIn2LU5ei4efcPkxBLXn5eqpQ47zWQIgGQoozS
        PLg5sHh9xSgO9JYwbwLIOh5grMNNegW0hAloyZnTO0CWlCQipKQaGJded856KOd997eV6dk7
        zy8X6fpMZjhY3Dx7ltqiHeLm8Y+dHTIXLc7gPTdvCf8x9eD1j+R/PdTz+33f/G0cn2pY0nKt
        OmXxK6umnBJ/t/1NmXMx/7/Vl19bP6xyMC02rDliXrd63fPKknuO2hzc/Lx+fVPfrJ9u//tn
        e7YX1/u2GRYKLFbPC5RYijMSDbWYi4oTAQZ/r1GyAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you pass a newly-initialized or newly-cleared `string_list` to
`for_each_string_list_item()`, then the latter does

    for (
            item = (list)->items; /* note, this is NULL */
            item < (list)->items + (list)->nr; /* note: NULL + 0 */
            ++item)

Even though this probably works almost everywhere, it is undefined
behavior, and it could plausibly cause highly-optimizing compilers to
misbehave.

It would be a pain to have to change the signature of this macro, and
we'd prefer not to add overhead to each iteration of the loop. So
instead, whenever `list->items` is NULL, initialize `item` to point at
a dummy `string_list_item` created for the purpose.

This problem was noticed by Coverity.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Just a little thing I noticed in a Coverity report. This macro has
been broken since it was first introduced, in 2010.

This patch applies against maint. It is also available from my Git
fork [1] as branch `iter-empty-string-list`.

Michael

[1] https://github.com/mhagger/git

 string-list.c | 2 ++
 string-list.h | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 806b4c8723..7eacf6037f 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "string-list.h"
 
+struct string_list_item dummy_string_list_item;
+
 void string_list_init(struct string_list *list, int strdup_strings)
 {
 	memset(list, 0, sizeof(*list));
diff --git a/string-list.h b/string-list.h
index 29bfb7ae45..79bb78d80a 100644
--- a/string-list.h
+++ b/string-list.h
@@ -32,8 +32,11 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
-#define for_each_string_list_item(item,list) \
-	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
+extern struct string_list_item dummy_string_list_item;
+#define for_each_string_list_item(item,list)                                 \
+	for (item = (list)->items ? (list)->items : &dummy_string_list_item; \
+	     item < (list)->items + (list)->nr;                              \
+	     ++item)
 
 /*
  * Apply want to each item in list, retaining only the ones for which
-- 
2.14.1

