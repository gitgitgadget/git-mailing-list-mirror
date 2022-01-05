Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC2C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbiAEXat (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245397AbiAEXao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 18:30:44 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21CCC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 15:30:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id p12so687445qvj.6
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 15:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2IK0oHZqYK/PSRImmuXCP9nslrDsWJuKH/gsCGwm90=;
        b=KdSfh6vsjLF2UZzyxLanwJbrSKye7cjQ3/1P41XTrfHT2JGLQMg3xUw0wS0/doQvQl
         hOSPrPywpcXHs22bSd4X8ao2OHCJVUhvl2Uqel1yz6DkQ7a598cPl+1UZjlLwXfmpf1M
         YYhcNNFZq3g1riMTqNDvghXkoFacibG6Tpz4HmQNdl9p4AtczkrHmgOXTKf4xjGnPLPV
         /IJNTk3xRd1grgKM7l7TFYrDXCXOlHf0fWgkaeiwgy91uap+pj7Me+a8TzFa2MpaUheN
         +8E4n8dqa1Coll44D45++ZhvvEikmAlK92ZZqY+WrTLfgogRZvKxGiKj2OHspoc3VckT
         9mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2IK0oHZqYK/PSRImmuXCP9nslrDsWJuKH/gsCGwm90=;
        b=BBXAYyUCJ6AYEAEeRcbIjvY2RndAcgzdlTxtaBbwBzUqgx5YoGc5lY55xBWNw2RuvP
         0mcAiyDW64rSZB1Rw+XwVdzklcb8snZ/EQsfDlxPTLlFeVjbF6bfpDTPCksUd8w11x7w
         VdkyeEFbnWmBAc6khSwzBmzh8JVMfCJTDwBB+cyYcROABY2B9v7w3ukb7eVeQboHs9Ex
         oF9hyx3DRqDnqZQHCQz+STTNtmvCDvEXVxuz28zI97IXWMlFU9mJAhJrnsSwv8m07HN6
         a+XKDP57emKRNJhRCXqJTBE2lytRY6Egjogy7b0gSJvnn+Tv23zAs/8ETAb370DU3ByB
         TP0Q==
X-Gm-Message-State: AOAM533gdkRYiTs7MrDD2dEWAk+yxzngKP0i8FhFoi1qweM3yfVCXNte
        f8Wvpo5bo8Prjtrra+WcQuC5QQTlpYUO8w==
X-Google-Smtp-Source: ABdhPJzZuAh0SYZeaLPYp9Oq9jRCkdMzk3UGPUUqu5ZImwDDMlZMi+7JG8DWU3tru+MHpBuVwJRnuw==
X-Received: by 2002:a05:6214:d04:: with SMTP id 4mr32374402qvh.37.1641425442754;
        Wed, 05 Jan 2022 15:30:42 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id r16sm219514qkp.42.2022.01.05.15.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 15:30:42 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com, i@zenithal.me
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V5] git-apply: skip threeway in add / rename cases
Date:   Wed,  5 Jan 2022 15:30:35 -0800
Message-Id: <20220105233035.27561-1-jerry@skydio.com>
X-Mailer: git-send-email 2.34.1.392.geaff969b2d
In-Reply-To: <20211217232902.7604-1-jerry@skydio.com>
References: <20211217232902.7604-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Certain invocations of "git apply --3way"
will attempt threeway and fail due to
missing objects, even though git is able
to fall back on apply_fragments and
apply the patch successfully with a return
value of 0. To fix, return early from
try_threeway() in the following cases:

When the patch is a rename and no lines have
changed. In this case, "git diff" doesn't
record the blob info, so 3way is neither
possible nor necessary.

When the patch is an addition and there is
no add/add conflict, i.e. direct_to_threeway
is false. In this case, threeway will fail
since the preimage is not in cache, but isn't
necessary anyway since there is no conflict.

This fixes a few unecessary error prints
when applying these kinds of patches with
--3way.

It also fixes a reported issue where applying
a concatenation of several git produced patches
will fail when those patches involve a deletion
followed by creation of the same file. Added a
test for this case too.

Reported-by: Hongren (Zenithal) Zheng <i@zenithal.me>
Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V5: updated reported-by

 apply.c                   |  4 +++-
 t/t4108-apply-threeway.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index fed195250b..afc1c6510e 100644
--- a/apply.c
+++ b/apply.c
@@ -3580,11 +3580,13 @@ static int try_threeway(struct apply_state *state,
 	char *img;
 	struct image tmp_image;
 
 	/* No point falling back to 3-way merge in these cases */
 	if (patch->is_delete ||
-	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
+	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode) ||
+	    (patch->is_new && !patch->direct_to_threeway) ||
+	    (patch->is_rename && !patch->lines_added && !patch->lines_deleted))
 		return -1;
 
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
 		write_object_file("", 0, blob_type, &pre_oid);
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index cc3aa3314a..c558282bc0 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -273,6 +273,24 @@ test_expect_success 'apply full-index patch with 3way' '
 
 	# Apply must succeed.
 	git apply --3way --index bin.diff
 '
 
+test_expect_success 'apply delete then new patch with 3way' '
+	git reset --hard main &&
+	test_write_lines 2 > delnew &&
+	git add delnew &&
+	git diff --cached >> new.patch &&
+	git reset --hard &&
+	test_write_lines 1 > delnew &&
+	git add delnew &&
+	git commit -m "delnew" &&
+	rm delnew &&
+	git diff >> delete-then-new.patch &&
+	cat new.patch >> delete-then-new.patch &&
+
+	git checkout -- . &&
+	# Apply must succeed.
+	git apply --3way delete-then-new.patch
+'
+
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

