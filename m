Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF4C20954
	for <e@80x24.org>; Sun, 26 Nov 2017 02:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdKZCy7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 21:54:59 -0500
Received: from mout.gmx.net ([212.227.15.18]:53665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbdKZCy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 21:54:58 -0500
Received: from localhost ([82.251.162.233]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LgZRV-1exsYP3Won-00nv4b; Sun, 26
 Nov 2017 03:54:56 +0100
From:   mwnx <mwnx@gmx.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, mwnx <mwnx@gmx.com>
Subject: [PATCH] pretty: fix buffer over-read with %> and %<
Date:   Sun, 26 Nov 2017 03:52:22 +0100
Message-Id: <20171126025222.7831-1-mwnx@gmx.com>
X-Mailer: git-send-email 2.15.0.90.g6559daec7
X-Provags-ID: V03:K0:XhW2qqDN+FLmLoLs9s4mtcrrQjvx1nrVVtu/2h7ec+uHhqOZrMp
 Y480IAJLlcgBktTNVjgSK0BHZQnXKELJL5f8zgkTHSNRCNLPJ+2T3ZKmVi8vdB8ekRfSIqI
 45UuSiKGcbz0sfKxOei4Me72v5WrIZhpALpL5QnJHvBRJ98JfQPdIaIdE3S3U/h7Gpu/dJR
 PpD9KkTH1+H0XKkLpzM0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d4buRbn0MBw=:ypc/r+u336hMD+7Ggjy7+s
 A47Q/2tx8z96aukT8RY2rGOPS7kzXT9nIqBgeyg8w5YKkBWGVfb4cSTyIHOFGoukR+mDHhQf0
 ++LXh5FeOWUDIx+zpJM8kxiAydYgvp7VYnBeXaE8kWvVKwu9PfqQmXInMapv/j9ALGhiPaixr
 vweqqIh+gebN46LItd5LuUcv3yYzGc6tIXEH8udXn7m3Q+MP/ZEEQe2SVQAL1cwnBArFhFuuR
 E+oCF0jSAuXxdaS7Y3L+66LVV2jUDnFx/N3+tmap5jFjkNkU+iIZxDD4JLwxMA+MXII0SMB5u
 Hmd0xH4HV93hG0fpPHA9+R3W6TCR13taMas7kM80BuOEo6ODDn0VxJuZgK213D1vC1Z8zbVwB
 H/FDAUtHg66lXtdwkxvEK+9iSnh2tKlBADX0tJd+Azk3SANpbXX0lSb7dbihzxkJpy5L+3wb2
 VY/HTIKnb2FSaB39DePGgrJGSnJxPAX8SpYT8mgG9JuIATKwZwC7ytzJK3uFDjBKvcSagz7Je
 gNCcZrN0fLIJWnEyUhni0Mg9pG9RuQzg05Jimz80JB/MWDJFwYfuYXSnV/heKlW4J4HtSZN6p
 df14ZkfdusCjkkjiMKXtLct/AOlHhETGolNtyuBpCk7O0C4wMhdvtx2jLJPxqlzS2bc4i3I/D
 XS2HdkTYKZ4JH6LBFjZP23X2CQyZBOJno2sQZNhgmWGaVF1rGACc0SAupWAM11D0VcMMzPU9/
 Vt26OLy0FYqUG66n9PuNjqqrs/yxApw6EA7ZKBTUcJ3LG4Uy/o+f1NBGfJPeYPX0EewmM3W5u
 UGVP4CxiauRuU4pYuvY62T8nhVPniQ8w5ApySRpbpejN6Ct2ls=
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

Signed-off-by: mwnx <mwnx@gmx.com>
---
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
2.15.0.90.g6559daec7

