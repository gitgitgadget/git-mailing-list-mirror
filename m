Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B7C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 23:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhLQX3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 18:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhLQX3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 18:29:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB6C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 15:29:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so4554592pjj.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 15:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCN19lnAT1eUQAN6qDfXWKb9eWaZevMb6bd1QYVjNOw=;
        b=QOIOCo4ueEfr0W2kkOAURmkJXS1ABnRCEvgH+ixf5AMkSamSRGzmJComKOqlfuST1Y
         BRRgGRlMkjjX9Wch0RhFUeJVrRUXWeGKwVXzem7JvtsFqjFaYYQNbnlDcZO2wH0eaF9P
         n15GAtk4l101Qg6/cWv1CglSNT4ndb+Y/lUksrNXEDAHyE5HcCfrVUz2YD1j4tooeCLK
         BFQHs+IGRD3JHlODgMjzv1grLO3SfbOVabfZcirJ/AyxBPkGfZB7JWTwP0t2t3oSI9Qa
         E3NXkBuU1eFejpDkPWUUrGT89UuaAxjOl5LvLlLcFwlqg+WTMXEoLsLlfBBHHNEJJ/Hw
         Dncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCN19lnAT1eUQAN6qDfXWKb9eWaZevMb6bd1QYVjNOw=;
        b=dXoN6udNCTPWnYKTlIBGp/FHH69QpiONYLAHX3W9EUkzINeE1aYCI4MNf2xEpvdoo4
         0fRNvnhDwDup455+9UYIKr34voE0TLhCo44tATzBU4uGpyvL8D8DfhZwZSHzqsRqfGNi
         cq6/yrsC3iWNhgIvwIdlbtcjiw74Wg2D3pGLpVrMuA7f+3cLc43SwlG7u5V1CkwL9DT7
         DcqYqwvIzy89Xu2USr4r7cvdXDHNwuHAte1+prmf2RMh4zOwOXzWq/J1E4GWpJjSiRFp
         VF+98s9yxacZfqY2ug57C0ovWJpQ9A9q+Tch4DiAmHva2aIo8WMHa87XdhMjhUn+vnkb
         RGJQ==
X-Gm-Message-State: AOAM531qW/GWjIukV4p0eouDs2B8XTGnoNzIyQGzX1VNH7YfimLeNyfo
        PmBBoLE86sR9dCtqIooVpINCfMEu6ugy5g==
X-Google-Smtp-Source: ABdhPJxEPkg28wy5HcFRogRte7EYJ8ouAT1nC46TFOrqQ0uN8weBYkIScJgneik/aHavfZXcV9o8nQ==
X-Received: by 2002:a17:90b:3845:: with SMTP id nl5mr6335197pjb.102.1639783746032;
        Fri, 17 Dec 2021 15:29:06 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id s25sm1043072pfg.208.2021.12.17.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 15:29:05 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     i@zenithal.me, Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V4] git-apply: skip threeway in add / rename cases
Date:   Fri, 17 Dec 2021 15:29:02 -0800
Message-Id: <20211217232902.7604-1-jerry@skydio.com>
X-Mailer: git-send-email 2.34.1.301.gf1e4b6b18f
In-Reply-To: <20211217224328.7646-1-jerry@skydio.com>
References: <20211217224328.7646-1-jerry@skydio.com>
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
(test provided by <i@zenithal.me>)

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V3->V4:
- Fix test bug where it wasn't actually
exercising the correct failure mode.

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

