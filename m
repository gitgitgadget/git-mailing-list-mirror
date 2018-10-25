Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5C11F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeJZAv6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:51:58 -0400
Received: from mail.ao2.it ([92.243.12.208]:44349 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbeJZAv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=fu5L5xMU7n2eQ6/vkhRYQDCY2FvgNNErOBtXtL5N+qc=;
        b=liUoFTwD4QRjL5UaUnhMnzl+rHs32Po72/ZLt6VAqqGFfFAUioczI3tgwlhbIXLay8Y8sApndG8OoxtS0uv3Oq1FtSMpqFDOJa6PiE5MYfFap7Cihy3570C2DDtJdD3ueyKDzGyGWWBy4b/nHMOrVhIiD5/7VXzhSFtDmFziktH9gx/LJZ9HD1RUU/uor6wnA4GfW2n4Aac+2APSiuL9yqY30cXGKGfEq0IqYUtMaW+bRSmuhEA12GeyyS/h1W/w9LCP47g9J1LygAYTE7MxD+Mhgp1HaDjMJ/oe3wu1vCBYvXNafpWcC1fv7nrQx+v97cK3HwfWO7iGkg4WR8c8VQ==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKn-0003Kx-Tm; Thu, 25 Oct 2018 18:18:10 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VB-1k; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 01/10] submodule: add a print_config_from_gitmodules() helper
Date:   Thu, 25 Oct 2018 18:18:04 +0200
Message-Id: <20181025161813.17252-2-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
References: <20181025161813.17252-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new print_config_from_gitmodules() helper function to print values
from .gitmodules just like "git config -f .gitmodules" would.

This will be used by a new submodule--helper subcommand to be able to
access the .gitmodules file in a more controlled way.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 submodule-config.c | 25 +++++++++++++++++++++++++
 submodule-config.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index b132f7a80b..e36d4e2271 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -692,6 +692,31 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
+static int config_print_callback(const char *var, const char *value, void *cb_data)
+{
+	char *wanted_key = cb_data;
+
+	if (!strcmp(wanted_key, var))
+		printf("%s\n", value);
+
+	return 0;
+}
+
+int print_config_from_gitmodules(struct repository *repo, const char *key)
+{
+	int ret;
+	char *store_key;
+
+	ret = git_config_parse_key(key, &store_key, NULL);
+	if (ret < 0)
+		return CONFIG_INVALID_KEY;
+
+	config_from_gitmodules(config_print_callback, repo, store_key);
+
+	free(store_key);
+	return 0;
+}
+
 struct fetch_config {
 	int *max_children;
 	int *recurse_submodules;
diff --git a/submodule-config.h b/submodule-config.h
index dc7278eea4..031747ccf8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -48,6 +48,7 @@ const struct submodule *submodule_from_path(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *path);
 void submodule_free(struct repository *r);
+int print_config_from_gitmodules(struct repository *repo, const char *key);
 
 /*
  * Returns 0 if the name is syntactically acceptable as a submodule "name"
-- 
2.19.1

