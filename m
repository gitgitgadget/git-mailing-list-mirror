Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22659C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbiCBRLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbiCBRLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A858C4B53
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so3802833wrg.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34K6Qm7dV1coFuW70L/I/cIbGt3NGNRX8Z7AyHX2ybc=;
        b=J0CRwnDPuYxABi46kjFjvlnq4xBHMTZHKQberBXT7SLrWT/2gH3+FAg387yggAEwXZ
         VErWTDU6BLy+iFLH3payVoEAPm78q+5N8sms3z86yxayrjsIsT28aoZXKT4wxxiyApgr
         uwEVH6fBi8pdxHLpLYJCSE/2WTLTaZ+ZGW+gY3Aq4NVJmlJwPSAxRYCD5BNqWMlK1o3J
         zcWpwGjd/KzQDQkm54HTi31qy6AGMAOepDxx2N7Zh8KFc/yoWkXbDK6VRmb7Loi0dfJa
         NedaveJZhWjvikHNXBPKNcVGC3LzGl1xL0bMat6Vt48G+SaMqRxPPrYkrIJUPGikvuYM
         ubKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34K6Qm7dV1coFuW70L/I/cIbGt3NGNRX8Z7AyHX2ybc=;
        b=5eirMcsYI+1OyaNxcg1y90lOu4PdJk2d1DN1WmYXs3AqZb0DS1Xb4CBQ+4jkyCx0NE
         sXHiVDf5xYFIHpbT3KDYdNpUFMrzwYUpnlwZlUj3TvfBbMSmkEUv9HXaDM/c8ZlccMLz
         9jZdcmhHsO5Dv3V4Jl95h5Ajn4KTlIag/fFCTvF6zJo+VEWDa/G4BQ4BHbb/WcnS5biB
         s5c1+S8GR68WD1AxD62rD453fCBaDAb2hdK3znWhW+mR/TEzJis+ubkrW+vv6GnRN07q
         SLF+S+Fy7bhiGeSEaV03qxBmgSBQCW0wauz0RGTwltkByodPTOok8gUe5EmJij9zI7P4
         3gBw==
X-Gm-Message-State: AOAM532V/oPeYIhgbtKQH2ZWP4WzhFVvFl7diZfuqoUU+Kst3lt4OV9I
        yF2aOiFGtBb1qqJLonj1h6JCW9S2qTNtXA==
X-Google-Smtp-Source: ABdhPJzAKfbzt6kjK0EF/J+++Jn447ve1+L2iM7Po7ewRP4bKygf1r0+GTTAlsyELQ0arDgTl16FWg==
X-Received: by 2002:adf:cd02:0:b0:1ef:7498:bcbd with SMTP id w2-20020adfcd02000000b001ef7498bcbdmr19449477wrm.278.1646241031391;
        Wed, 02 Mar 2022 09:10:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/14] submodule--helper: fix trivial leak in module_add()
Date:   Wed,  2 Mar 2022 18:10:14 +0100
Message-Id: <patch-08.14-122fdf7bb41-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in a6226fd772b (submodule--helper:
convert the bulk of cmd_add() to C, 2021-08-10). If "realrepo" isn't a
copy of the "repo" member we should free() it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eeacefcc383..13b4841327d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3309,6 +3309,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 {
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
+	char *to_free = NULL;
 
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
@@ -3360,7 +3361,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 			      "of the working tree"));
 
 		/* dereference source url relative to parent's url */
-		add_data.realrepo = resolve_relative_url(add_data.repo, NULL, 1);
+		to_free = resolve_relative_url(add_data.repo, NULL, 1);
+		add_data.realrepo = to_free;
 	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
 		add_data.realrepo = add_data.repo;
 	} else {
@@ -3413,6 +3415,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	}
 	configure_added_submodule(&add_data);
 	free(add_data.sm_path);
+	free(to_free);
 
 	return 0;
 }
-- 
2.35.1.1228.g56895c6ee86

