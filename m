Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737EDC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiCBRLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbiCBRLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FB35DE77
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y5so1599357wmi.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFTRjv+Tp9GmqiVW02D61xwhBz+MzgqN6vtzFCFWDn0=;
        b=fuvGJoB0m/bW/w7y6wlFeL+uPeo3w7pls8AJQ22ChaBhAfxBzBZpAsVLfPFUkrV9ms
         GlSO9u+ALIZnKQLxSxRe3k0/nAR4eSbHrIuCoPSA3WrwE1cRxaw4b4S//IEevdK2OZo7
         bPnXSSaVqOBd88Hb7IrKE30vhbfWR4gzY2rYwF/AJQjK3cEaEgRwJwFP7S7VaYN0FXNQ
         ahkkOf8dqE8laVFCTETwyU1e2YagAHVlrhfCQYLa5aSAhjgSUfi5sbOpAqA//w6Wy4VZ
         VWP9vPheKgkUsLxL4uGgcQ7Edrf7+tiqkjI9nQYgI2KBbwOwQBbOutJk4YcFAPx9Tp2n
         /LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFTRjv+Tp9GmqiVW02D61xwhBz+MzgqN6vtzFCFWDn0=;
        b=wtEp7HHQS6RSIanpOWll7r5jFafgsjTGjomPn7iAIakdTlmenlZjns54EQW5+aa40F
         h9vif00Ssa0yUHzXw2d15zeDsEW9CanrljSSPx6C3M0fFA6dQQIIFN4CP69N97iw8/8I
         902GleVoKAse26ySlKViOdmSzQVZ8YZLnInOLzN9b8eVizdweX9b/rMBFRF1MeuyjS6f
         1P81K/fzwNAM+9VIVkwQJuiL9wqtqYSlLl2a7CAmS9UhtG3aXBsmN6AuACdpoQANPrU6
         AUORDZUvJu+JZ7/Hkho3VUmjj1c5AgJEZC0Ee+whhNMwWoBGfG+JAZEMWz40WQwko9go
         0QGQ==
X-Gm-Message-State: AOAM533XyfFQ4lo7+Rv5TXDMwmUqllgdS9GAukZRpopLKZul0Vl6zlyw
        D2eNUzMdQyLou9wyfdI7iRYuZoeb+497FQ==
X-Google-Smtp-Source: ABdhPJy2pcd6k0k8e8yLvNOcs1ZgPG2RJ8x0bGDsw1zeRTbFDmCywncqBLTKqTKTnKNMh/uQkUMafA==
X-Received: by 2002:a7b:cb8a:0:b0:386:26b5:f9a8 with SMTP id m10-20020a7bcb8a000000b0038626b5f9a8mr623375wmi.55.1646241029697;
        Wed, 02 Mar 2022 09:10:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/14] bundle: call strvec_clear() on allocated strvec
Date:   Wed,  2 Mar 2022 18:10:12 +0100
Message-Id: <patch-06.14-52e2c2a8281-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixing this small memory leak in cmd_bundle_create() gets
"t5607-clone-bundle.sh" closer to passing under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5a85d7cd0fe..2adad545a2e 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -93,6 +93,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
 	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+	strvec_clear(&pack_opts);
 	free(bundle_file);
 	return ret;
 }
-- 
2.35.1.1228.g56895c6ee86

