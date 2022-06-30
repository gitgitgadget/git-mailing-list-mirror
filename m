Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36109C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiF3SAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiF3SAb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F828739
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cl1so4717494wrb.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E0HFoCBdWkhlbrT8Ou+VgAigUTtm94fGTUj59Bz//o=;
        b=gN+xXuLVRFsyk2wAnJXlWUeYBNoXEbrP8uSPvxI6gJOGLk3HEhFJeY9poNDnFEeLGC
         oDrCYpeWaHH5yMxrXIw/Y5pOfCGZLB5S/vheclEiFPpZA7yPcl1+oCIJaz9F7a002OIR
         Xpf1oUXhW8+HIp2KPkws3XzzqnjCZGukK00wuI+ME9czmo84mhi6jswoujWcQbmsVQ5d
         qxkaVx9jde1sIhRAT6IpP61C1zVZ3Y98pMhKAhrY4aWm+/YLN7pg7a87b8tA4U6hHTNO
         r1nwsJGQEzyCJ+8P7h7IrMiiJULhNxnPJOKbAVT7k+RR6Rg9qXU2r1Rs5uhafuzFFoKX
         aE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E0HFoCBdWkhlbrT8Ou+VgAigUTtm94fGTUj59Bz//o=;
        b=8MbHxgBY54I1NDs2Rg1BimCKT8iyCspIihz7BoH4IZz6DdFB5SM/Pq8i/Y64fmxOtX
         l4ApMRC1YQc0ytsKBpUYAg1QdecPaMjR91XrN20KxYuEekCnHMsAN55QU3OkY08/LzTE
         srVs7IPgokdGRHWhH7Bwvr7VIYZk5JqgJgh3s1U9nlE3n4jjua8PQuyHnvHx0F6Njrbt
         lRt0BVm1bdMQHVqKylcYYbEdjZowEgw2fNg5opUdtndpjXs+LJxovZe/eZ23nQeyztmU
         9H0/DyTkKOjirunXla/D44Jgg91uQUEfPUVjx5kfPY95bO05IBtdVWNIhlb5SrLbD6Lb
         Ts3w==
X-Gm-Message-State: AJIora//LquNkH84mbi7DgpeSbxbZ+ebB6gm1IBJNtxDnEbR8YaAZqJi
        HDdzSd9jsHEW3UJNaLcOBWPY/8sivx8Vwg==
X-Google-Smtp-Source: AGRyM1uuFpZhe++sceJkLYLMuTyFLcxms9UGQ85+70qPLNTkof+2doiPmlrQPsG+DWECBvF1zVli3g==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr9853814wrr.472.1656612028324;
        Thu, 30 Jun 2022 11:00:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/11] revert: free "struct replay_opts" members
Date:   Thu, 30 Jun 2022 20:00:14 +0200
Message-Id: <patch-04.11-c9c2380be34-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call the release_revisions() function added in
1878b5edc03 (revision.[ch]: provide and start using a
release_revisions(), 2022-04-13) in cmd_revert(), as well as freeing
the xmalloc()'d "revs" member itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index f84c253f4c6..2554f9099cc 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -246,6 +246,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
+	if (opts.revs)
+		release_revisions(opts.revs);
+	free(opts.revs);
 	return res;
 }
 
-- 
2.37.0.874.g7d3439f13c4

