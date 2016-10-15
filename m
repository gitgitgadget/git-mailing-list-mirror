Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE3820988
	for <e@80x24.org>; Sat, 15 Oct 2016 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbcJOQXc (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 12:23:32 -0400
Received: from mout.web.de ([212.227.17.11]:53420 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754268AbcJOQXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 12:23:31 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MHXxg-1bykaz4908-003NMa; Sat, 15 Oct 2016 18:23:14
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject:  [PATCH] avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM
Message-ID: <ccb15072-d949-fc84-ee45-45ba013f53c4@web.de>
Date:   Sat, 15 Oct 2016 18:23:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:J/zH1mXQcNBYBqztD57zCy7R4d5JNbOfFC/11KC0YGggam5f9AK
 rLihlSpfwOKtlM8xMxF/8UvKHnvebk9oPqUMVnLv+IrxS38CtuGkKPbB4AjYK3bqXVbr6Jq
 0b6MXBDRa4dMzH19mwX07ccDuO9JIzOoWL4p5MMJxGSxGdUsetoSLjx4/uRKEH6+eHOazju
 OG+Uiu/xPY/aIba+kSYTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ut0RHVCidsk=:aYsHxG5KRiHAI+v6Kp3u0N
 BEqGyN3SfjiC6dE1Sfd7NlxsVReys0B0fC+kZlvVteSPR8iUvpXnyYLIVcQBptwli2owCL/+q
 BCGnH7NNCGrAQDH7W+yVCBQstnHNoXCLmZOP2CyPG/gKonAgyAsAsfoFbxBLdnbYGsk5WK7Tp
 FCdUfk7ENKgR7h8Gd1FBSBBmY5ToJJ+lCbiVWLVdHbJE3FhpfcpCR18B6Bg6QOkvEKfr5QY6q
 REJbQqJOh/nBgszy1zY3vIR8lC95DuzobCzImLf0GN0DPZ8vCslOTJ6JvkHwMGN5QixaS4ta6
 tUU4/2ezF+NzJFUAfFx8XT07Z1Io17lJgX1ke14/GJPS7jGjsNykxEqiVnmPdZObmVyTQwypN
 cj8Viom1Zu6SMwEARF7Nk9JYtMdEfZ7ZU0i7orZiLFbbLAV8PeJQBE84N1ZrBKYk6tXitSwH7
 YDolAUFJfnawra0zOd/nrpHo/QytOcbKVCSdW7VWvIbQ6q02z619Udtfon8WjKu5lCeBH02Go
 3CYhue1xLYKpMn/d2kUP1YRzt7b575IdQqu81dgxZB3iLK0duPUC06MgUuFWS28bqGl1qwgtI
 arAhQ0tZDYTFVV5Hazqt6Rf9COfNPZnNfY+kRpmL9RmpvgaMkTvJFongZqs+qA6+HohdOU84U
 UbO21iizAKAYmSResNvQWwH3YXWKyaClmrctyOt0B4iEggXADU/V3RhjasNIchmKB25YBGK0r
 7vospTFudLqg/pu0viCyJDv/3vfcyCFghoiFeKS7FrhjZOEic3qTw50N1m2ZQNuFVRbYDZFFd
 9XEAp9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calculating offsets involving a NULL pointer is undefined.  It works in
practice (for now?), but we should not rely on it.  Allocate first and
then simply refer to the flexible array member by its name instead of
performing pointer arithmetic up front.  The resulting code is slightly
shorter, easier to read and doesn't rely on undefined behaviour.

NB: The cast to a (non-const) void pointer is necessary to keep support
for flexible array members declared as const.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This patch allows the test suite to largely pass (t7063 still fails)
for clang 3.8 with -fsanitize=undefined and -DNO_UNALIGNED_LOADS.

 git-compat-util.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 43718da..f964e36 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -851,8 +851,9 @@ static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
  * times, and it must be assignable as an lvalue.
  */
 #define FLEX_ALLOC_MEM(x, flexname, buf, len) do { \
-	(x) = NULL; /* silence -Wuninitialized for offset calculation */ \
-	(x) = xalloc_flex(sizeof(*(x)), (char *)(&((x)->flexname)) - (char *)(x), (buf), (len)); \
+	size_t flex_array_len_ = (len); \
+	(x) = xcalloc(1, st_add3(sizeof(*(x)), flex_array_len_, 1)); \
+	memcpy((void *)(x)->flexname, (buf), flex_array_len_); \
 } while (0)
 #define FLEXPTR_ALLOC_MEM(x, ptrname, buf, len) do { \
 	(x) = xalloc_flex(sizeof(*(x)), sizeof(*(x)), (buf), (len)); \
-- 
2.10.1

