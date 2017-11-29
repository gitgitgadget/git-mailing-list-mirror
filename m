Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACB720954
	for <e@80x24.org>; Wed, 29 Nov 2017 00:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbdK2Ad4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 19:33:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:64172 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdK2Adz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 19:33:55 -0500
Received: from localhost ([82.251.162.233]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Mey7N-1eVDEp0BwX-00OXUu; Wed, 29
 Nov 2017 01:33:46 +0100
From:   mwnx <mwnx@gmx.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, mwnx <mwnx@gmx.com>
Subject: [PATCH] pretty: fix buffer over-read with %> and %<
Date:   Wed, 29 Nov 2017 01:32:51 +0100
Message-Id: <20171129003251.1981-1-mwnx@gmx.com>
X-Mailer: git-send-email 2.15.0.319.gb3398b820
X-Provags-ID: V03:K0:nnciNO0L3XiAhTki5DU1vhO1EcBpFDjwDgKYBcojLmnigpI76tY
 TfbMYyOBQUT1bMrxNacW9qN+ttRr9BqvTW8ySuFANulmu3r3I6TlWiPpO2Xu1YFkspLNNlV
 of1hjgaNnV0UW/7DxVXZGnpzDNN5D6r6QPvhYcUadoCZaK45VOgYcrr5Heg1zN0cLbbBefX
 lUFn2xi/ppwosiOgM5U7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pSBrt5tNy0M=:u/Qpzfgema8Ake/inJBJwr
 1c3F8zBNmqAZIMgC2Prlnh3nr+rvYKXdT1Zq1OKOjtiSFub3cNUgydb50huBOO9X5aEJp4qiH
 h15dqpxJn7nwaiBfIC8fK9LFMG9v5jz5x2/nEqn9lPnhA/wJt37IR3oRlFZOpMdOUuNL0ychH
 P5ZPvDvUT+SNH0IZXDCoZ43oDW3xvtRzudEwnPHedF29fPCPHfKZv5ZGzTXPZJzs+DefIwHmF
 UaWi+W7hdPymvLqJR5jYaniLamnRrEEpotiBjK35tTbQ3B3y8z/BTtyoXrcJOyiQqh43zW6A0
 ntlu+UdZ225inTeYawlupwf9zKwXlLfFUmdDgDBHtoZLdwUZNbP18kAZyCRirkwBMKbvNLXu5
 dWu7ggGQXOPNV5akatQ1IM3vr+EeHSBe5jlMDBF4k2vty2FKmfXefsRHoxa+0iuRjtrKUeKKp
 C4rX7hnsRWJS3vt6D2y2qHhm0y/RXQvp3y4zEtjmtOkT1b2waGvS3AH87+pMxnZtQJBPWVQKz
 VwELbB5scTlmxI01umwChWeaEbZpCZWtn0O7p/ThrMC4tcxhq2wxcBuM9LP8OlaPKCGFRTAKo
 LgV+JaKOj0OWws/7ZGJeCyxAF1MfXqlBKIqe7FjPhS/TZBzc/f9FLphWCosNx59gYYODMIrZ9
 JFqS5VsPkCMl193vxTT8JNhzUOZ6KQv5gsJ7NLI+9yAP1heOSq+DZfwDFAN0Kh1bb5yL1Pp2E
 k3LIc7msIuYPUoahfFmGXg9k6on20ejOIC6Gq8aDc00qCwN4FAOEQIsRHwEkg+fTl5sCix6Tb
 x9WozMd3vpB8Alagqd1saMmuSvWgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A buffer over-read of the format string would occur with unterminated
formats of the form '%>(#' and '%<(#', where '#' represents a number.

This error can be witnessed by running git log under valgrind like so:

    valgrind git log -n1 --format='%<(42'

This was due to the fact that the "not found" case for strcspn() was
being checked in the same way that one checks the "not found" case for
strchr(), i.e. by checking for a NULL pointer return value. Instead, one
must check for the end of the string since strcspn() points to the
character where it finished its search (which will be a '\0' if
unsuccessful).

Signed-off-by: Maxwell Nixie <mwnx@gmx.com>
---
Hope I got everything right.

 pretty.c                      | 2 +-
 t/t4205-log-pretty-formats.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 2f6b0ae6c..4c70bad45 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1021,7 +1021,7 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 		const char *end = start + strcspn(start, ",)");
 		char *next;
 		int width;
-		if (!end || end == start)
+		if (!*end || end == start)
 			return 0;
 		width = strtol(start, &next, 10);
 		if (next == start || width == 0)
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 591f35daa..4d9555962 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -598,4 +598,10 @@ test_expect_success ':only and :unfold work together' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unterminated alignment formatting' '
+	git log -n1 --format="%<(42" >actual &&
+	echo "%<(42" >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.15.0.319.gb3398b820

