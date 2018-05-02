Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E79E921847
	for <e@80x24.org>; Wed,  2 May 2018 00:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeEBA1z (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753462AbeEBA0q (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E360360B3A;
        Wed,  2 May 2018 00:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220805;
        bh=audNftlfZhrH0d5w7/AWLOJk03xZkTLimPG9WKlnSmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wiULorcoviYaSB/yGZvmCeTC/yThjCXkNRn53qQrjyZMJyLFWQ4D0bcXoYMQZOzFX
         8fpv/zhRbnSuWPA9xwrvJJ6zUCAwOoxvL70KaAAwtjBPi4dS0koOnTkMe3pqB/965I
         SqcZr5P6lQAMcrNQ8eiikPtNEUIQaBe5rxUg1KqNJ2NjhDeMUsblrWnwJpsvs6ViaR
         wy7Hw4+5CkHt5Rn17SBD30rCkgWxYF9kPwsE26p1qhBlMsurdezxhPO90/HrOphXIt
         3LvVJ5ArgVJJUqb83nFUnIlhwyawhTVui68GuCninMrXHeHUy26YSC2X0hFBKrkY6y
         wmi4jKr5fdnJHOYjrJIzG/urO9NQZJl6GeTCdd77cuGZ9UL+ERbnUAmVlNH3tTVqnu
         m82SIdHhXiPiuJMvH6Wfvm+839rzSU6gTZPz5y+gKov+ZoW9TNOWXdigP93lCKfyjd
         FehQ6Qxa2UAZ718ZLESB+Nw6S7BhBymassxciuy2HO3nvOqDIIB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 24/42] diff: specify abbreviation size in terms of the_hash_algo
Date:   Wed,  2 May 2018 00:25:52 +0000
Message-Id: <20180502002610.915892-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using hard-coded 40 constants, refer to the_hash_algo for the
current hash size.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 314c57e3c0..b1666b9b2d 100644
--- a/diff.c
+++ b/diff.c
@@ -3897,13 +3897,14 @@ static void fill_metainfo(struct strbuf *msg,
 		*must_show_header = 0;
 	}
 	if (one && two && oidcmp(&one->oid, &two->oid)) {
-		int abbrev = o->flags.full_index ? 40 : DEFAULT_ABBREV;
+		const unsigned hexsz = the_hash_algo->hexsz;
+		int abbrev = o->flags.full_index ? hexsz : DEFAULT_ABBREV;
 
 		if (o->flags.binary) {
 			mmfile_t mf;
 			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
-				abbrev = 40;
+				abbrev = hexsz;
 		}
 		strbuf_addf(msg, "%s%sindex %s..%s", line_prefix, set,
 			    diff_abbrev_oid(&one->oid, abbrev),
@@ -4138,6 +4139,11 @@ void diff_setup_done(struct diff_options *options)
 			      DIFF_FORMAT_NAME_STATUS |
 			      DIFF_FORMAT_CHECKDIFF |
 			      DIFF_FORMAT_NO_OUTPUT;
+	/*
+	 * This must be signed because we're comparing against a potentially
+	 * negative value.
+	 */
+	const int hexsz = the_hash_algo->hexsz;
 
 	if (options->set_default)
 		options->set_default(options);
@@ -4218,8 +4224,8 @@ void diff_setup_done(struct diff_options *options)
 			 */
 			read_cache();
 	}
-	if (40 < options->abbrev)
-		options->abbrev = 40; /* full */
+	if (hexsz < options->abbrev)
+		options->abbrev = hexsz; /* full */
 
 	/*
 	 * It does not make sense to show the first hit we happened
@@ -4797,8 +4803,8 @@ int diff_opt_parse(struct diff_options *options,
 		options->abbrev = strtoul(arg, NULL, 10);
 		if (options->abbrev < MINIMUM_ABBREV)
 			options->abbrev = MINIMUM_ABBREV;
-		else if (40 < options->abbrev)
-			options->abbrev = 40;
+		else if (the_hash_algo->hexsz < options->abbrev)
+			options->abbrev = the_hash_algo->hexsz;
 	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
 		options->a_prefix = optarg;
