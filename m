Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A40C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbiCBRLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiCBRLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7647550
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so3802440wrg.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dvx46+SeENqlGoHs+qZJ9oaF+B3m5vw7Era7zwkR4CI=;
        b=BmzCN4eAmfsV7DWLhJn1npoElbNk7N1GbgEH1PwLqwxnkMdAeRUKuKVHgywpbp7qmO
         Wecu87dqDBrTe4lc3zJhwahTsFZ/9rtP2nOrQxyD+yPLHQW8Vx3qC+qb4PcNOfKwGvfM
         Dy1rHxf9Mk8QVZFmQGeDQTodJ+AOS6QL6g5pqbDA32L/RYV5rApexnZczMzGmLYTrnBi
         3eS7ow9Oda2+t1ej0FQji7GHr2ZJD3vY9vieQOyGvaxOLTwwVRw/r5E4g7pWPTwfQ9z/
         UW+e4DIpvu4bfzJ3Sz3ElGdJGViggDTJJRmNizovmrEjZ2H68HsZ5LKgPIiSyGWBiXOJ
         FcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvx46+SeENqlGoHs+qZJ9oaF+B3m5vw7Era7zwkR4CI=;
        b=jTs/NCbhweYuOnmdcY4+Skn6el1h2u1v5ZzadPEyLlf16QbchLyomi9Ub7O+i8jPrc
         sFen9k7PC1UGkiBZXFnj0DOEgoUnvh60Je29Aky12dDw6eJrzT8C5yZDb+ZIhjtlK83m
         OmxhbjnaoAZKxHYkoXncKF07pgriiKeKtuwiiR1GuGYrYcbJ+t8aCUmKaVWeOqwJ/aDF
         hiP11MNrtLuUV2+wIuOn3KtGo724/GVF8A/d3jiibbCe61Rxv3+h/IWgIf8rtSivENwV
         ZyzuKaoQaPEYmdM/7bqDpw4C63g8a1De0siSxfmnd4+YSETyeCZMvV+XTlMYDCd0qGuo
         kpzA==
X-Gm-Message-State: AOAM531UCOCxIpZVmIPNOa2HjmJki1GZzKXvyd+QOVKG9YMO8tgjfPh3
        tAmSzMA6ABFPhRb5jdpKBV/ESFMPTS05/A==
X-Google-Smtp-Source: ABdhPJwAtpSv5cM6MXNKeKaajT/VpYDVlk3SnBQe42dnBWqmc2BFle3rJqXLJq/Yu3jugYc/SCpOVQ==
X-Received: by 2002:adf:ed0c:0:b0:1f0:4a32:4d0d with SMTP id a12-20020adfed0c000000b001f04a324d0dmr438098wro.136.1646241026105;
        Wed, 02 Mar 2022 09:10:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/14] merge-base: free() allocated "struct commit **" list
Date:   Wed,  2 Mar 2022 18:10:08 +0100
Message-Id: <patch-02.14-4c28f056ec2-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in 53eda89b2fe (merge-base: teach "git merge-base"
to drive underlying merge_bases_many(), 2008-07-30) by calling free()
on the "struct commit **" list used by "git merge-base".

This gets e.g. "t6010-merge-base.sh" closer to passing under
SANITIZE=leak, it failed 8 tests before when compiled with that
option, and now fails only 5 tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 26b84980dbd..a11f8c6e4bb 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -138,6 +138,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int rev_nr = 0;
 	int show_all = 0;
 	int cmdmode = 0;
+	int ret;
 
 	struct option options[] = {
 		OPT_BOOL('a', "all", &show_all, N_("output all common ancestors")),
@@ -186,5 +187,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	ALLOC_ARRAY(rev, argc);
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
-	return show_merge_base(rev, rev_nr, show_all);
+	ret = show_merge_base(rev, rev_nr, show_all);
+	free(rev);
+	return ret;
 }
-- 
2.35.1.1228.g56895c6ee86

