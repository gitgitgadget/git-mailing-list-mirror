Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E5C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 22:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhLQWnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhLQWne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 17:43:34 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA8C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 14:43:34 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t83so3651765qke.8
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiGWXJL1yPMa6N510oIGj4F/0x1x9+1p+2d3Z+JMEHg=;
        b=Cf5igSpRlRiEGo3JpE+rJQT0S+CR/pvBeacZ5VbFjKPibQz3ZrzLdaJfJd6AJX/VIJ
         ZqlDs7L3ykI5mdq9mHfWeK4wadwCiFHzVomrjhx0hNGP8OxeWAwedUZxplyWaVmbs6GT
         iNycU2b7KS911iOTAuqnTnXK+Fquxub0I9S1j1iZMG9SIJDvZjKrA5F6GCbztsfTTRKp
         mG1JuvdV34SKmhX3/BTzmzJJnKEG4xR/vi53G5qzsxCM7j+s8NHenCVAi4+TvNhTCIkb
         9nZi79K9RLy+3BC1wNTUqkl20hvfcMxZ9zaT3lCXCwg2BTvRMJamljKDtl4st+rO7sfd
         8gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiGWXJL1yPMa6N510oIGj4F/0x1x9+1p+2d3Z+JMEHg=;
        b=X7DdQIIX+l3fLcH90oLj91NgjqYU2NBr1ZYoSbigjVYt6CQQbJkPfBsxBLPDqn7cTP
         qU0uifg12p7Cgp17HPIswKMAaTUE4RtAKBvT0WhEs4BZlQ14UbjIszIVrTDO2qsr74GW
         xYNERTrDbixQ9PfRibwIquJ0UAWMGwT1+az0yL9N9Wfs/E2VBb1VBu0I4B8glwBVpOSf
         hlGrumHo1BksoHXzsbwJ4oF64erF0TfV3tU+t2qyi9x/51yyiR3sP13iFb8jcHXiLJvy
         r4Tb7SlXFEVZBwuBtLlwBxaFwbnZMDFdpJe4bKoK2f8CL32iBoOgF2UM061uw6KLUSq4
         ZxxQ==
X-Gm-Message-State: AOAM531GWWawLM6cEj20ZmlyB580qEBOb7u0yJVZY+d1ncFd3mDrtnFA
        IOHddC+lcAFEeITr6urZBvcg20ihGD+Opg==
X-Google-Smtp-Source: ABdhPJyu7sWoHOOuS/e4lkVWX26rodlzv9CicF7SyfzYakvh6g8AvRRyZnUyRLed0mjE7DJBGwrmpQ==
X-Received: by 2002:a05:620a:2891:: with SMTP id j17mr3337693qkp.386.1639781013045;
        Fri, 17 Dec 2021 14:43:33 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id y12sm5686494qko.36.2021.12.17.14.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:43:32 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     i@zenithal.me, Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3] git-apply: skip threeway in add / rename cases
Date:   Fri, 17 Dec 2021 14:43:28 -0800
Message-Id: <20211217224328.7646-1-jerry@skydio.com>
X-Mailer: git-send-email 2.34.1.301.ga59952dcdd.dirty
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

Signed-off-by: Jerry Zhang <jerry@skydio.com>
(test provided by <i@zenithal.me>)
---
V2->V3:
- Updated commit title and message to be more
general, and indicate that it also fixes the
delete-then-new bug. Added test.

 apply.c                   |  4 +++-
 t/t4108-apply-threeway.sh | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index cc3aa3314a..daad50d2d2 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -273,6 +273,20 @@ test_expect_success 'apply full-index patch with 3way' '
 
 	# Apply must succeed.
 	git apply --3way --index bin.diff
 '
 
+test_expect_success 'apply delete then new patch with 3way' '
+	git reset --hard main &&
+    test_write_lines 1 > delnew &&
+	git add delnew &&
+    git commit -m "delnew" &&
+    rm delnew &&
+    git diff >> delete-then-new.patch &&
+    git diff HEAD~ HEAD >> delete-then-new.patch &&
+
+    git checkout -- . &&
+	# Apply must succeed.
+	git apply --3way delete-then-new.patch
+'
+
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

