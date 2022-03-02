Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DAFC4332F
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbiCBRLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbiCBRLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B755BC5
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n14so3830625wrq.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBhrM9/6AP3wQ5oRbfd9Nk5I+0uqjVQstoGUPGX6BTk=;
        b=bFQl2Vf6sNfZhxz1igmPemr/Q1wQ9mYTe/UQfWhQ2BcEN7uP6PBNVdgkquiF6HmOce
         6xtPK99cZ2ki7jxP4HmBeBlwSXg2pxPwGZ4qPw7/1xtRRPo9ZeigH7Cm8v3PS/bKIrvA
         rNhvPHkhSkONLqJL+6yLnF4cOk4ZuMHb1W/4nvPZNb8Czk6rQxDSeY+yxHn4FEVSIW1+
         6T+1W64SMpDKRqnohL4ayK7VSYCj/2pVpWYk3gN/ljvb2dcLfvkn/1SbnXo8fZhwUoBT
         yCmuuT558iEMfgBG4m5g2xr4/PTXGBooTq4bRtn2AV7pNx+d0r3vCd0AhZZTorPSrOqd
         h54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBhrM9/6AP3wQ5oRbfd9Nk5I+0uqjVQstoGUPGX6BTk=;
        b=DJGFpt6A4Mr72ufCbwSHvUampwnnaj/0hRza5O/vhPVVxlITt/KHIh4wWpMliksDiL
         mHNOJi0TH7TFtf1GvrNadABhZo7cQruGBh6OBPn12g7qB3i7nSgyfQLZ7mLpw7hU+NbA
         d6UBR3pXt4oWdy9+nkTStJv5tfsy0am+A0IH2I2C6jj0bnSUah1OKdbPXRXuCNY2VewR
         PXEuzcQGGjm1vhcoVfSVi0g27OB8FnGwZsatzIn8z7fNMloxYjB4xh3+TGVo5e90C2ey
         uKU2N9QtxqOFFpJBcpmxGz+5akBcU/FtayQOxUxaL3QIn6Z2lhrQtC5u0FwhXpkhsIC0
         pOMQ==
X-Gm-Message-State: AOAM533RVumwunavy/A4IMV323xI1EdH9BqcEWB5wTe74LJNlus5zv3p
        FMDvNDxq5Y4T1g9ncM6PypI2GINFkowUDA==
X-Google-Smtp-Source: ABdhPJw3vSKyAJ/WtPLErJScedCdRg41v9fHIIbm859vN90oPVJgZQzyyEAtrMGc9yeVva5DOY+qkA==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr23745424wrp.299.1646241025230;
        Wed, 02 Mar 2022 09:10:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/14] index-pack: fix memory leaks
Date:   Wed,  2 Mar 2022 18:10:07 +0100
Message-Id: <patch-01.14-bcba06e1d28-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various memory leaks in "git index-pack", due to how tightly
coupled this command is with the revision walking this doesn't make
any new tests pass, but e.g. this now passes, and had several failures before:

    ./t5300-pack-object.sh --run=1-2,4,6-27,30-42

it is a bit odd that we'll free "opts.anomaly", since the "opts" is a
"struct pack_idx_option" declared in pack.h. In pack-write.c there's a
reset_pack_idx_option(), but it only wipes the contents, but doesn't
free() anything.

Doing this here in cmd_index_pack() is correct because while the
struct is declared in pack.h, this code in builtin/index-pack.c (in
read_v2_anomalous_offsets()) is what allocates the "opts.anomaly", so
we should also free it here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..5fe1adb3681 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1109,6 +1109,7 @@ static void *threaded_second_pass(void *data)
 			list_add(&child->list, &work_head);
 			base_cache_used += child->size;
 			prune_base_data(NULL);
+			free_base_data(child);
 		} else {
 			/*
 			 * This child does not have its own children. It may be
@@ -1131,6 +1132,7 @@ static void *threaded_second_pass(void *data)
 
 				p = next_p;
 			}
+			FREE_AND_NULL(child);
 		}
 		work_unlock();
 	}
@@ -1424,6 +1426,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		 * object).
 		 */
 		append_obj_to_pack(f, d->oid.hash, data, size, type);
+		free(data);
 		threaded_second_pass(NULL);
 
 		display_progress(progress, nr_resolved_deltas);
@@ -1703,6 +1706,7 @@ static void show_pack_info(int stat_only)
 			  i + 1,
 			  chain_histogram[i]);
 	}
+	free(chain_histogram);
 }
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
@@ -1932,6 +1936,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (do_fsck_object && fsck_finish(&fsck_options))
 		die(_("fsck error in pack objects"));
 
+	free(opts.anomaly);
 	free(objects);
 	strbuf_release(&index_name_buf);
 	strbuf_release(&rev_index_name_buf);
-- 
2.35.1.1228.g56895c6ee86

