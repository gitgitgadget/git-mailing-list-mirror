Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B20DC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 16:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbiAKQkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiAKQko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 11:40:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07876C061751
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c66so11474943wma.5
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orgxBX0mwCtQkgYN6zXHuMRCLyNHwgGkwcNyG2r7Yxc=;
        b=l0Nr3ApAkn9q6tXTuMqNNbyJiJJ4yFedqL4J2R7BFr3CWG2cvei0ZcXfAD0uELI06a
         uu/jUZnbFgHhOdiYZfW9OUI6l4exIoEBoN/KkRzT0DCrXyIhpXAxmNl2GlTnJe13Xuvm
         +OhBptJ5iA11ut5WUHFCdKPrMKodTViCNDsNhoNZLsdnzSXKPzl0wOyEV8Tt7T8tWYSh
         hoonnBLIZ2DfJLpAhdVZ2vzVnYM+Cd+Q9PeAu9otox2VS40HC65I9bdcExFf7RSN7Fze
         N/I8O3UDK1Ll9nI8UgajvOScejMMXsd8GA7kLO04qbBMPLI2P9AY30S/SL58++r5v7Q8
         bFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orgxBX0mwCtQkgYN6zXHuMRCLyNHwgGkwcNyG2r7Yxc=;
        b=K1NtafKl26PB+w33n+AyADhGoVn8hjC8fY7EVXo0+MgFx9KJVhqXcdZ2088OK5akFZ
         O4seLt5p1FWhJv/PpDIz52ROzZQ/Saru51gxE5EnMr02Cl7yhF+jnGlH6QpTFVgMxfUi
         FrT1caMClHppWa56He91OJ6/D54LJSPIB3Tn1TyPSNis6M3dSuHTKf5HAktJLOiySjfe
         PsM7GjMCAXn3uncUQ+Ir0w2vOvf13Up8sePd/7XFvF/FiHvl9TbrCJKo06x+TXEYkZbH
         PHO2S8W/4C2NrJvYnxPJFMVvLUTxB+Snv9vxdAajpfr7gREBPU4LpGLGsz9k+M2AfFIE
         i3zw==
X-Gm-Message-State: AOAM5316QVkRARGnCE01eb7j9T7Moow8JGQtEuKzhlt0bexQn7Ot8SHI
        QR9roC44IBIwM/5CgJwo63xEk7lwzpg1KQ==
X-Google-Smtp-Source: ABdhPJwMUMdNxlQO523REuU/8Vr/gFwFYNFDLgj/qg5GKC3jTCHDA3es/MpCPSJ7pR9Fjo4nnLIdcQ==
X-Received: by 2002:a1c:f316:: with SMTP id q22mr3180098wmq.33.1641919242413;
        Tue, 11 Jan 2022 08:40:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o38sm2536934wms.11.2022.01.11.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:40:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Date:   Tue, 11 Jan 2022 17:40:23 +0100
Message-Id: <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.844.gb5945183dcf
In-Reply-To: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 1ae2b8cda84 (reftable: add merged table view,
2021-10-07) to consistently use the "uint64_t" type. These "min" and
"max" variables get passed in the body of this function to a function
whose prototype is:

    [...] reftable_writer_set_limits([...], uint64_t min, uint64_t max

This avoids the following warning on SunCC 12.5 on
gcc211.fsffrance.org:

    "reftable/merged_test.c", line 27: warning: initializer does not fit or is out of range: 0xffffffff

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reftable/merged_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 24461e8a802..b87ff495dfd 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -24,8 +24,8 @@ license that can be found in the LICENSE file or at
 static void write_test_table(struct strbuf *buf,
 			     struct reftable_ref_record refs[], int n)
 {
-	int min = 0xffffffff;
-	int max = 0;
+	uint64_t min = 0xffffffff;
+	uint64_t max = 0;
 	int i = 0;
 	int err;
 
-- 
2.35.0.rc0.844.gb5945183dcf

