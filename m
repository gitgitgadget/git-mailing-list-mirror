Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4AC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbjALJUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbjALJTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F452C59
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a30so13335537pfr.6
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0arj68Lj9hpU0ub5Z6NeHHKErrCvPeDV4kiysNNwpEA=;
        b=GeOU7NMMKh8eN6FtdvaacqTnF3nJSKwVWiwVUPMRy+jaRq9QJ146faExmnIAJ6BJYj
         KnNg+98/MLzikDdy/+TGkoRb07dPDAYiSvcrcQEEij4H2qNs30LE0v3uWOV5+rcs2Tc1
         Y6hArJpQL37cALH/Svh+8WWMUgWFUj5YKMt1RDbjXpqMZkQWbdzDCiGXtzLcaG0LbuLY
         efoNQuYYFEa5Nqv+QYaN2kwCI95d8D+OvYQiROC1tpVOGLNU7b4qv8wZdmi5tyNh8fCL
         /S5+mm1kHxebYZ8z7kL4Bit/32KsqYLGoUhFvyPFpp1FnJeDPSnakCAl1fV/TpBn7Lo6
         Leyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0arj68Lj9hpU0ub5Z6NeHHKErrCvPeDV4kiysNNwpEA=;
        b=ikM18HoxqNlLLHBMWTKsHqTYT97Avqu6OFw5sqNG/SsXhpeOft8GoR9g8eYtp2340R
         POS14l9YmqVwejCNw97l050apacBnN6onyPT1HWA2PAuXCbkhJuxDYceA0Dx4VrwwgKn
         MrNC6hRhTGEFQT6qcLBB7xd1BDu6ChBWfxOl2EU5/giyCg7/N7tCQT62JdBRMqxTwHiU
         9sHfztoJhAl0xXKTIH42eC6A2Yf+tCYEIK6KFQga1yPa5LUcIvWtC1OyLa+CkCyLGYT3
         bIVoUfDJBcHhbnAIwSk5dUH97fMvOrUxQqRsHTeo+fUd/eptTQfBbL/iWoT6+P+5ZiPL
         f/6g==
X-Gm-Message-State: AFqh2kpRldi/3yJyhUxZMRqzK+UDx5cX4o9x2j/hHNK6r0P75hYeX2+s
        umobIRusa/sOg0fy2PicbzPWyXuxLZQuEcyz
X-Google-Smtp-Source: AMrXdXsuSJWiTI/Daje0kcd3mTpUBpfuNCctu6XdcA6iKWTflca9CPXP3Zrhfet7JpYvdPb5il+NJQ==
X-Received: by 2002:aa7:850e:0:b0:583:39ca:82f3 with SMTP id v14-20020aa7850e000000b0058339ca82f3mr23865900pfn.18.1673514708255;
        Thu, 12 Jan 2023 01:11:48 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:47 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyronteng@gmail.com>
Subject: [PATCH 1/6] ls-tree: don't use "show_tree_data" for "fast" callbacks
Date:   Thu, 12 Jan 2023 17:11:30 +0800
Message-Id: <20230112091135.20050-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.98.g174eaa53973.dirty
In-Reply-To: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

As noted in [1] the code that made it in as part of
9c4d58ff2c3 (ls-tree: split up "fast path" callbacks, 2022-03-23) was
a "maybe a good idea, maybe not" RFC-quality patch. I hadn't looked
very carefully at the resulting patterns.

The implementation shared the "struct show_tree_data data", which was
introduced in e81517155e0 (ls-tree: introduce struct "show_tree_data",
2022-03-23) both for use in 455923e0a15 (ls-tree: introduce "--format"
option, 2022-03-23), and because the "fat" callback hadn't been split
up as 9c4d58ff2c3 did.

Now that that's been done we can see that most of what
show_tree_common() was doing could be done lazily by the callbacks
themselves, who in the pre-image were often using an odd mis-match of
their own arguments and those same arguments stuck into the "data"
structure. Let's also have the callers initialize the "type", rather
than grabbing it from the "data" structure afterwards.

1. https://lore.kernel.org/git/cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyronteng@gmail.com>
---
 builtin/ls-tree.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c3ea09281af..cbb6782f9a5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,19 +173,11 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_tree_common(struct show_tree_data *data, int *recurse,
-			    const struct object_id *oid, struct strbuf *base,
-			    const char *pathname, unsigned mode)
+static int show_tree_common(int *recurse, struct strbuf *base,
+			    const char *pathname, enum object_type type)
 {
-	enum object_type type = object_type(mode);
 	int ret = -1;
-
 	*recurse = 0;
-	data->mode = mode;
-	data->type = type;
-	data->oid = oid;
-	data->pathname = pathname;
-	data->base = base;
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
@@ -217,15 +209,15 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 {
 	int early;
 	int recurse;
-	struct show_tree_data data = { 0 };
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	printf("%06o %s %s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev));
-	show_tree_common_default_long(base, pathname, data.base->len);
+	printf("%06o %s %s\t", mode, type_name(object_type(mode)),
+	       find_unique_abbrev(oid, abbrev));
+	show_tree_common_default_long(base, pathname, base->len);
 	return recurse;
 }
 
@@ -235,16 +227,16 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 {
 	int early;
 	int recurse;
-	struct show_tree_data data = { 0 };
 	char size_text[24];
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	if (data.type == OBJ_BLOB) {
+	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
+		if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 			xsnprintf(size_text, sizeof(size_text), "BAD");
 		else
 			xsnprintf(size_text, sizeof(size_text),
@@ -253,9 +245,9 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 		xsnprintf(size_text, sizeof(size_text), "-");
 	}
 
-	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
-	       find_unique_abbrev(data.oid, abbrev), size_text);
-	show_tree_common_default_long(base, pathname, data.base->len);
+	printf("%06o %s %s %7s\t", mode, type_name(type),
+	       find_unique_abbrev(oid, abbrev), size_text);
+	show_tree_common_default_long(base, pathname, base->len);
 	return recurse;
 }
 
@@ -266,9 +258,9 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 	int early;
 	int recurse;
 	const size_t baselen = base->len;
-	struct show_tree_data data = { 0 };
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
@@ -286,9 +278,9 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 {
 	int early;
 	int recurse;
-	struct show_tree_data data = { 0 };
+	enum object_type type = object_type(mode);
 
-	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	early = show_tree_common(&recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-- 
2.39.0.98.g174eaa53973.dirty

