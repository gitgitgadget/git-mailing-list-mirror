Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E2DC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiCBRLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbiCBRLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C910D5F4ED
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r10so3851502wrp.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQs9Z3GcyDIx9fOolmCiohM3Y53IaKwUIseiNP7K6mg=;
        b=FMsdrpqfyJAVvHA7gT7jvTJ39hZORaRgc+GATsSGsfq87a3loMYS5GFrTMhwQmAeyZ
         P9jpb43hcBxnXNfY9XDRInd1SVw+7TVhSBT2iSEUAhF5ppaB9WN0QjZr+cdZxCj3Ipn7
         SqM47OIa+oqVJcj6I6xryzYmG7LSxm1qgooSGBDzZNAFmwUp2qHQxjpbKa9pv1pr7Jyi
         XRv3VyQ6BraDGGppHwj+cTepU2EFZgpPCDJsEemkG2rfntUSqfUrSo9L9SmxWeNKA22M
         IsRN8yvtI6npeeZVfapPdKjhIHfh1KlSTQrGXDGEyK1h15VTgpP8E21N3ccy0DIRlklB
         Iahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQs9Z3GcyDIx9fOolmCiohM3Y53IaKwUIseiNP7K6mg=;
        b=0ZZVZ+UCtfaRxOR9960zQuCdDo+cT6T8jaqr98WMy0jzq7uL89Gx6ML7e9NwP22UI/
         914PXz8uUtDFUf1oKMFpkeP+DExwVYy8uIpy4UVqVcPuwW36O7/nAuFjFkAxlntiB1iY
         ekIfFzTEt0seBMZPo5QVX5MqrZ1NcW9QXxNnHswOUl95dI6PmSi/NIGhmNPcLKOApxPU
         AzvRn9veQin3tc9o88RGKlMZrReqdgrHJzoJ04QPd70vxN49Xk8TkhtmvoGIB8KMwmYc
         znvtD38KYdzzlfSYmaiMlacti7sLP/V20zz60c2UPsqAI9KqwYaXF8u6AEZ/BRlWx3N5
         rEEQ==
X-Gm-Message-State: AOAM531+xqBeCi67A0rZt5wtdQfAeVZhNAbTaik1HVKnIitOYV1cd+E6
        Kjkre7/LEVwwDfI+CtpKEAkH4u7/3IcT+Q==
X-Google-Smtp-Source: ABdhPJzobgGP95RK4n6NVWajL+/mofa1cJyfoI10CEpl8KVREeiGIKcpGW3pW4ohR2DnS9RE3KMeyQ==
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id t6-20020adfeb86000000b001e68c92af6bmr23735749wrn.116.1646241033175;
        Wed, 02 Mar 2022 09:10:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/14] commit-graph: stop fill_oids_from_packs() progress on error and free()
Date:   Wed,  2 Mar 2022 18:10:16 +0100
Message-Id: <patch-10.14-27f0883e8d8-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in fill_oids_from_packs(), we should always stop_progress(),
but did not do so if we returned an error here. This also plugs a
memory leak in those cases by releasing the two "struct strbuf"
variables the function uses.

While I'm at it stop hardcoding "-1" here and just use the return
value of error() instead, which happens to be "-1".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d0c94600bab..aab0b292774 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1685,6 +1685,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	struct strbuf progress_title = STRBUF_INIT;
 	struct strbuf packname = STRBUF_INIT;
 	int dirlen;
+	int ret = 0;
 
 	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
 	dirlen = packname.len;
@@ -1703,12 +1704,12 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		strbuf_addstr(&packname, pack_indexes->items[i].string);
 		p = add_packed_git(packname.buf, packname.len, 1);
 		if (!p) {
-			error(_("error adding pack %s"), packname.buf);
-			return -1;
+			ret = error(_("error adding pack %s"), packname.buf);
+			goto cleanup;
 		}
 		if (open_pack_index(p)) {
-			error(_("error opening index for %s"), packname.buf);
-			return -1;
+			ret = error(_("error opening index for %s"), packname.buf);
+			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,
 					FOR_EACH_OBJECT_PACK_ORDER);
@@ -1716,11 +1717,12 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		free(p);
 	}
 
+cleanup:
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 	strbuf_release(&packname);
 
-	return 0;
+	return ret;
 }
 
 static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
-- 
2.35.1.1228.g56895c6ee86

