Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A2A20401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdFONvY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:51:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:40665 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdFONvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:51:24 -0400
Received: (qmail 29801 invoked by uid 109); 15 Jun 2017 13:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:51:23 +0000
Received: (qmail 23250 invoked by uid 111); 15 Jun 2017 13:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:51:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:51:22 -0400
Date:   Thu, 15 Jun 2017 09:51:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] t0006: check --date=format zone offsets
Message-ID: <20170615135121.jrrxng6ktjfe3wth@sigill.intra.peff.net>
References: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615134958.mzmdmhonjsnconu2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already test that "%z" and "%Z" show the right thing, but
we don't actually check that the time we display is the
correct one. Let's add two new tests:

  1. Test that "format:" shows the time in the author's
     timezone, just like the other time formats.

  2. Test that "format-local:" shows time in the local
     timezone. We don't want to use our normal UTC for this,
     because its offset is zero (so the result would be
     "correct" even if the code forgot to apply the offset
     or applied it in the wrong direction).

     We'll use the EST5 zone, which is already used
     elsewhere in the script (and so is assumed to be
     available everywhere).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0006-date.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 71082008f..9f81bec7a 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -31,9 +31,11 @@ check_show () {
 	format=$1
 	time=$2
 	expect=$3
-	test_expect_success $4 "show date ($format:$time)" '
+	prereqs=$4
+	zone=$5
+	test_expect_success $prereqs "show date ($format:$time)" '
 		echo "$time -> $expect" >expect &&
-		test-date show:$format "$time" >actual &&
+		TZ=${zone:-$TZ} test-date show:"$format" "$time" >actual &&
 		test_cmp expect actual
 	'
 }
@@ -57,6 +59,9 @@ check_show 'format:%Z' "$TIME" ''
 check_show 'format:%%z' "$TIME" '%z'
 check_show 'format-local:%%z' "$TIME" '%z'
 
+check_show 'format:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 16:13:20'
+check_show 'format-local:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 09:13:20' '' EST5
+
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
 check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-- 
2.13.1.766.g6bea926c5

