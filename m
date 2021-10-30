Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7609C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BB260F22
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJ3Uon (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJ3Uon (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 16:44:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A18C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:42:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j35-20020a05600c1c2300b0032caeca81b7so7558845wms.0
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mfaw8VhZuQ9w+Kudt0Ftdz/5k9PkTJdkS1bCKns/FhE=;
        b=Ee4NMB7dZanTMtUSagKu6YFdeiIHENMe5lD/j0R7Lt54xePlhuwjRYx6kWleiFAJJm
         T50gqAgAqt387DweTRtW6RxdEtv3EpWqDkh8QkikU/932ITvT4C69LHPQNfbz8OyfBwv
         GW4cx9yKPU5drrt657pVAJ5lYqLCcfCGwi3X29l7b8FrWBcJKuAjYVJGpVS0rJNV4fwg
         X0y+Gq4NaC/z/u4anVa6CYKiazsz7Ku9iiMiRTN9POGxZ+1mzaBggLX0HcllsAWRKPCv
         MizKmRKdLQw9pUNiu8qTWzIBcK0xf6OeoRDLW8WYBO8ch/LIp8wevTdMkeHOdlniEttV
         GrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mfaw8VhZuQ9w+Kudt0Ftdz/5k9PkTJdkS1bCKns/FhE=;
        b=XCYK02ICXQvo1Ava4K36MH+UrGx4CiqrYgBJnzChcqvVhdP30U+r/f/uE3dNv0+b8R
         biSPVpasGtHZ7sqi+DoqAL2zymhDYkOcbV15kdCRoFqAy+z5q7JP6G8z71hWLCfwsAf4
         nbk7KORVDLLgAgUxI8P5Q0ERgbamDksSmt7g95bon1sKJRLOWu2vejE2zTAW8pZzdDx3
         wSuqsAtv/aI0/RAp48MESv123kBfMUQEetE8YlKgQySMWelH0h5UvFxhjCLMOX+0g6w+
         xBLAn9iogAeGAGLrhIVWCB/dB3YINA3ztwUXQgt7/isYJjP+zJntgcHYFAZeSN6hdYxG
         kZSA==
X-Gm-Message-State: AOAM531TBm0ZXLbKLuyGMiOtxo3yQYUM4rDpL72/25kN2QnnOmCbMqRr
        FErhMK350Pb7ztkqvvILz+E=
X-Google-Smtp-Source: ABdhPJzEiEEbYhTwG8GyzHAZXYy5K9Kiw9lE/+u4URug48Yay4RUAdIcNDPaTrP6jD4OfhfFijYjcQ==
X-Received: by 2002:a05:600c:244:: with SMTP id 4mr20140035wmj.167.1635626530969;
        Sat, 30 Oct 2021 13:42:10 -0700 (PDT)
Received: from lesale.home (62-47-13-59.adsl.highway.telekom.at. [62.47.13.59])
        by smtp.gmail.com with ESMTPSA id m12sm8925154wrq.69.2021.10.30.13.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 13:42:10 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     rhodges@cisco.com
Cc:     git@vger.kernel.org, rhodges@gmail.com,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ryan Hodges <rphodges@cisco.com>
Subject: [PATCH] apply: make --intent-to-add not stomp index
Date:   Sat, 30 Oct 2021 22:41:55 +0200
Message-Id: <20211030204155.2500624-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
References: <0DB10E05-094D-4382-AD1F-657878B06A80@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cff5dc09ed (apply: add --intent-to-add, 2018-05-26) introduced
"apply -N" plus a test to make sure it behaves exactly as "add -N"
when given equivalent changes.  However, the test only checks working
tree changes. Now "apply -N" forgot to read the index, so it left
all tracked files as deleted, except for the ones it touched.

Fix this by reading the index file, like we do for "apply --cached".
and test that we leave no content changes in the index.

Reported-by: Ryan Hodges <rphodges@cisco.com>
Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 apply.c               | 2 +-
 t/t2203-add-intent.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 43a0aebf4e..4f740e373b 100644
--- a/apply.c
+++ b/apply.c
@@ -4771,7 +4771,7 @@ static int apply_patch(struct apply_state *state,
 					       LOCK_DIE_ON_ERROR);
 	}
 
-	if (state->check_index && read_apply_cache(state) < 0) {
+	if ((state->check_index || state->ita_only) && read_apply_cache(state) < 0) {
 		error(_("unable to read index file"));
 		res = -128;
 		goto end;
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index cf0175ad6e..035ce3a2b9 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -307,7 +307,7 @@ test_expect_success 'apply --intent-to-add' '
 	grep "new file" expected &&
 	git reset --hard &&
 	git apply --intent-to-add expected &&
-	git diff >actual &&
+	(git diff && git diff --cached) >actual &&
 	test_cmp expected actual
 '
 
-- 
2.33.1

