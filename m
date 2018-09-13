Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2C31F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIMK0J (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:26:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54422 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMK0J (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:26:09 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02E5D60748;
        Thu, 13 Sep 2018 05:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815897;
        bh=r8E+oKIgjP7htHY8IvAtKJhOR+w4aDcUyxphfIhFFjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vfZ0MyptjD+IBMondSzW1WuY0KFNqOywoJUD5XffAhnCJkOl1+X5EuTOZB7doNKnp
         iY2txURByu3NomLcULk4/ylw4wpbfVwhxJykRfkJG+CxWqOClq5VQv1EaAe1QP/21V
         IOOmbebFshESIgzkC0QzkIoCrfhnv6uDp0gsbRXnLX96PjRA+IpMKO9lR9UrsL7M7Z
         bB+Nmtj1Z8XGrbntcGag9/uFhkBfO6FDTs5tk+vA0zLier5I9+BndbmnHqRadFaBBo
         xqXtB2J2veWKw45tgu92nPGnvmBxhJe2BScnnM3VowruqwWdfTo5chIK1Q2O7MX13f
         RFaLPTre74g76eU9vIYWSUdQwBPeJAKZnV0RvI2VFVtgnpwkGtab/QGnj6xrdQ9XTT
         NLl9d7x+zApgXTM/7YosqMX3hhbUpRhkWNpg/JZnMB7ixK9kTuSNuxjNZWq1OtArQL
         5vby6qE1u/zfQcs30wNXWQ9rkDSIZHWicjpg5HTMI3rMvxOoxE3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 05/12] t0027: make hash size independent
Date:   Thu, 13 Sep 2018 05:17:35 +0000
Message-Id: <20180913051742.252276-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We transform various object IDs into all-zero object IDs for comparison.
Adjust the length as well so that this works for all hash algorithms.

While it would be slightly more efficient to use a sed y/// expression
instead of both the tr and sed, retain the tr in both cases for
parallelism and compactness.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0027-auto-crlf.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index beb5927f77..dfb46bbe86 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -15,7 +15,8 @@ compare_ws_file () {
 	pfx=$1
 	exp=$2.expect
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
+		sed -e "s/0000*/$ZERO_OID/" >"$exp" &&
 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
 	test_cmp "$exp" "$act" &&
 	rm "$exp" "$act"
