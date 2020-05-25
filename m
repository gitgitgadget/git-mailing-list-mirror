Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7611BC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9DA2073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ns/QWGMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbgEYT7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38720 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390398AbgEYT7t (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5AC0160D01;
        Mon, 25 May 2020 19:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436788;
        bh=TGhOMPz35SRRFxjnBdGILqgto6hXnSxBir9T4tn1EIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ns/QWGMcac4ai4socEVvd4I6phcBLv7CXh6Hi5nHmWVg8mE5QzSakHbZqR0Rk1tZS
         XYo1M6Pta4JU+TZF6H6LeGVpV+cCphRCG3p0QvBufYK9hGoyC636xT19dLp26AJ0ER
         SArhMbEq2lQF06rC6zyCyJTg8UwIBfkTuZl6fOlKA2WTKWOrSZjMc2NB6WnIGER5p2
         ExFT+pGpSI1d/j4SKJK3b1hPe5Jxz+ism/jUEyt0sdwQWyBSHJ3V1/3g2yjzDs7xZ/
         +eRwj7qAlUleMeUeRR1Ifk8iF91QAVfgEsT11NdrM7/IOtWWUOA5WCJ84F8hL7hVFa
         MaBiuk2AIVDhR0SHqNFBNG0UjTwd7xmB74bLXMCV7xsvX7tFYLkfnKURnqykli9TOd
         Vp/en8oZhgV1fMfq5/zOG2BjQcGPbvIDdHMpc424D6NUqF4a00BRxujqTetSD0X89O
         xwvB18zuEt9iNgB3w/0s8A8XXL/c1tzkXDwcA8vgVusiR9VEn4o
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 13/44] fetch-pack: detect when the server doesn't support our hash
Date:   Mon, 25 May 2020 19:58:59 +0000
Message-Id: <20200525195930.309665-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Detect when the server doesn't support our hash algorithm and abort.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7eaa19d7c1..34c339a5fe 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1040,6 +1040,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		print_verbose(args, _("Server supports %s"), "deepen-relative");
 	else if (args->deepen_relative)
 		die(_("Server does not support --deepen"));
+	if (!server_supports_hash(the_hash_algo->name, NULL))
+		die(_("Server does not support this repository's object format"));
 
 	if (!args->no_dependents) {
 		mark_complete_and_common_ref(negotiator, args, &ref);
