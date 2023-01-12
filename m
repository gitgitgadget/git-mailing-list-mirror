Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ACFC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjALJUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbjALJTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:42 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0EA55647
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:53 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s67so12351336pgs.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KryojS0G7P9W6tYC6yBRT5E6nDu36WxkHjsJQBFLPk4=;
        b=TrfJlMUYjs6JWTbGWjBGW6bS36DoSUthgmf+16YLXIxCGdr5hlAIrYtftGIChHLFz1
         iZtq46mpOiTwGh6hrCVThepLU14oAFRtIaxJ0iE6GBn0m2BJ/DLfLSSyUsh27AV7OTGe
         EU/dIL+f3lqQ0z+EE1/joygELOZTz12sup34gHHyLcva27KKPbYtl2dvs00ucaFTSVRy
         U659KOpb16K/E8wI7mjhjToRkadqD2OQJ57QswC2OIOS1Wo6V0DAQUE6615zb5iXMnzU
         eC2cDozvKTSUes1uQFB0c9/13D6CQF1+CXDv9hbSNWJG7HJ5aOH2RZD1PNkEi1v6duOw
         KRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KryojS0G7P9W6tYC6yBRT5E6nDu36WxkHjsJQBFLPk4=;
        b=10TjLXlygUrDNKWJPQhDakQG8WWm9zZzam9HRUCCyUI/7rwGjm+XEsWOpGg2L4SeWH
         YhlnetQhtszlEhqC0ep1a9sd14y8BHktKHhcoZBTNTj/BNEhJ8ZosBYPH3NN7q2WeTft
         A5nf/9gMa0y/DppRTgNriDNRjWzvd1F4Ikn+lJuRX3OViTS3MNSbR8qN4nbPuVKJ2azv
         K3/Jx2T3llgsXr8TjlfHcLkJOMLd1CBY+BK+QCZySHHWs55UDS3QOi45578ECtNFyrLr
         5MYrycUTNO+GJthNpj6vciDGCb9womnBJUVVHjo6iIGKQi52M7/F/Px8Z2Gs+nrqulbC
         xoDA==
X-Gm-Message-State: AFqh2kpPghdN2MTU078v4lcLiozMutc0KFVK/AlXTOhilKZs6tCc+ECU
        yjViRflIcf83hMp3A3a6AeCOAqp3VZnBtTLs
X-Google-Smtp-Source: AMrXdXtRUFa3HhCAsjBhnEh7yM4JJ0+cW8vbHll9B1tzlVo3YRISBLblfQCL4zjjM5As9gwwwE6S/w==
X-Received: by 2002:aa7:93de:0:b0:587:25ea:4fcb with SMTP id y30-20020aa793de000000b0058725ea4fcbmr5968017pff.19.1673514713080;
        Thu, 12 Jan 2023 01:11:53 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:52 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 3/6] ls-tree: fold "show_tree_data" into "cb" struct
Date:   Thu, 12 Jan 2023 17:11:32 +0800
Message-Id: <20230112091135.20050-4-tenglong.tl@alibaba-inc.com>
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

After the the preceding two commits the only user of the
"show_tree_data" struct needed it along with the "options" member,
let's instead fold all of that into a "show_tree_data" struct that
we'll use only for that callback.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 54f7b604cb7..da664eecfb9 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -53,6 +53,7 @@ struct ls_tree_options {
 };
 
 struct show_tree_data {
+	struct ls_tree_options *options;
 	unsigned mode;
 	enum object_type type;
 	const struct object_id *oid;
@@ -60,17 +61,11 @@ struct show_tree_data {
 	struct strbuf *base;
 };
 
-struct show_tree_data_cb {
-	struct ls_tree_options *options;
-	struct show_tree_data *data;
-};
-
 static size_t expand_show_tree(struct strbuf *sb, const char *start,
 			       void *context)
 {
-	struct show_tree_data_cb *wrapper = context;
-	struct ls_tree_options *options = wrapper->options;
-	struct show_tree_data *data = wrapper->data;
+	struct show_tree_data *data = context;
+	struct ls_tree_options *options = data->options;
 	const char *end;
 	const char *p;
 	unsigned int errlen;
@@ -153,17 +148,14 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	int recurse = 0;
 	struct strbuf sb = STRBUF_INIT;
 	enum object_type type = object_type(mode);
-	struct show_tree_data data = {
+	struct show_tree_data cb_data = {
+		.options = options,
 		.mode = mode,
 		.type = type,
 		.oid = oid,
 		.pathname = pathname,
 		.base = base,
 	};
-	struct show_tree_data_cb cb_data = {
-		.data = &data,
-		.options = options,
-	};
 
 	if (type == OBJ_TREE && show_recursive(options, base->buf, base->len, pathname))
 		recurse = READ_TREE_RECURSIVE;
-- 
2.39.0.98.g174eaa53973.dirty

