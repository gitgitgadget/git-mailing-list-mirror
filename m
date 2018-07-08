Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6455B1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933264AbeGHXhF (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54380 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933174AbeGHXhD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 24E4D60747;
        Sun,  8 Jul 2018 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093022;
        bh=ztqasaOmoQDGH6jIPHFZ0M63zs0LMlOFPASYjnLT6NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tYnJK4l3+CsQd4q7VFXHcbFMtCrl7IXH0XScd5N88I79nfS+CyxqGI79A+8NWijU8
         TEHFHfmgtjzYD510wr40GqNghWzV2TabypX0pGAzRTQ2w+9vTMF595ZwQZ/r+S+Z4y
         BNHI8AE2BdLKoInI+1ZuGCfb/W4BqJRQlTErhZ5aKdQRZbCHQYerkxpJINgp02qAtu
         GvXrwqFO1cLoTwtdwqTE/PWxCMdfm/+MmrIW6M+rBwufJGLl3sW0ga5cUOATuxJ2+u
         FkPnWryUks6U5f0fhlz9UHeCmF8b93hJRiN4NJWe/fJmf/yyQXr85H+kf5MF9TDem5
         hcsyygdNyxS+vRoxlBt7x1k5doXD3tgAQ/z3qviJqlPzLbgNrakkvpFGCJPc9XajsJ
         /DSDbWH6JycVeevlcIm2IjI002RsRF8pdda+21Jqy+cMYODA+pmP6YwtaBQthlmv5Q
         VBuXcljGHXYDJYGUgs/Y0Tgp9TM0fuSBLlSlmAa6Vwg1Qj3piBr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/17] builtin/merge-recursive: make hash independent
Date:   Sun,  8 Jul 2018 23:36:34 +0000
Message-Id: <20180708233638.520172-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use GIT_MAX_HEXSZ instead of GIT_SHA1_HEXSZ for an allocation so that it
is sufficiently large.  Switch a comparison to use the_hash_algo to
determine the length of a hex object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge-recursive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 0dd9021958..9b2f707c29 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -9,10 +9,10 @@ static const char builtin_merge_recursive_usage[] =
 
 static const char *better_branch_name(const char *branch)
 {
-	static char githead_env[8 + GIT_SHA1_HEXSZ + 1];
+	static char githead_env[8 + GIT_MAX_HEXSZ + 1];
 	char *name;
 
-	if (strlen(branch) != GIT_SHA1_HEXSZ)
+	if (strlen(branch) != the_hash_algo->hexsz)
 		return branch;
 	xsnprintf(githead_env, sizeof(githead_env), "GITHEAD_%s", branch);
 	name = getenv(githead_env);
