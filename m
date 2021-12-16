Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D00C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhLPNpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbhLPNp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B95C061401
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s1so10176722wrg.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKESWjN/5CVTLv61q+ZNLCOIKKNH7iAHlARqxWxTPzo=;
        b=ODkNh6odZTrnRP1GJKL5kbdT2tE1ZvENvfUdWWmHTUwty37ND8bkoYLI1wywJHl01D
         L0hRuTA+VwM/DDDt9XeOsNCGkorW8PKkP0V89cM3JBllFqUAGEaiVR3i0cCaNtvQXV3C
         nl7cswnW6bU63WriAAGeAZx+Dy1NA76PBuUROSgg+2tdk3h5Jc1xi6yWuBQnb6mo1e2u
         /yRda3UbQC96nsuxQmyHpKGLbpFYASpcxmJ9nSLaQ2DsBPDpFJCbUWJx6JPTsDGz9Xbd
         UjvAo4Dz7RhOuZNfgWKwrZcUB2lcceSjiHwRNGBlZovGGpP0WCQYieP+FbphBV7LDvIW
         1j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKESWjN/5CVTLv61q+ZNLCOIKKNH7iAHlARqxWxTPzo=;
        b=iGe+LGAo7gvNsKnfjcjM3FBrKKR5bEYF0z7ll4ITxozvq0bXzlJq9dOqcwViGO7LxH
         fYJjZ6nQHIklPHFW4im3IHjBM9POeH9y2po+niNG4XlemnPMjn46rY0kbcZezCooRCZG
         mg/B5HgVC9MHwMkcuzekjYn8rf4CiuNS6h0v0+FP9ycgo0yD769ccBsaTomPzjNmgYWe
         weXGHfp+pgpqpVFC7M8U+RxK/G/OOKCQ8gpMPkbYXqDJsmqQmvS81CHyMFLK+2hW4NDA
         h/zWbd5BAmk/iQDATC1HEe4LA8zI0vCcUZ8i02b27BV9K63v9LEb5APVljUOu8c66e8w
         W6TQ==
X-Gm-Message-State: AOAM533oGzJsffrQ7uWP800iH5Z34np8iyaYrU+Ox77oF6BVutYMF2nt
        7HKD9+olCxym1mzifaDM5QuC+W/khaJTjg==
X-Google-Smtp-Source: ABdhPJzA4EXsOSRmGA1+O8N3kFldJDaU2KEexWmmmxyivEPyUY8hbNIJ/edIHTNlZ58Tugqr3R3Ltw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr8644619wrr.493.1639662326913;
        Thu, 16 Dec 2021 05:45:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] reflog expire: don't use lookup_commit_reference_gently()
Date:   Thu, 16 Dec 2021 14:45:15 +0100
Message-Id: <patch-v2-6.9-c71aab5845e-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the initial implementation of "git reflog" in 4264dc15e19 (git
reflog expire, 2006-12-19) we had this
lookup_commit_reference_gently().

I don't think we've ever found tags that we need to recursively
dereference in reflogs, so this should at least be changed to a
"lookup commit" as I'm doing here, although I can't think of a way
where it mattered in practice.

I also think we'd probably like to just die here if we have a NULL
object, but as this code needs to handle potentially broken
repositories let's just show an "error" but continue, the non-quiet
lookup_commit() will do for us. None of our tests cover the case where
"commit" is NULL after this lookup.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index ec0c6051135..29dcd91abca 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -359,8 +359,7 @@ static void reflog_expiry_prepare(const char *refname,
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		commit = lookup_commit_reference_gently(the_repository,
-							oid, 1);
+		commit = lookup_commit(the_repository, oid);
 		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
 	}
 
-- 
2.34.1.1020.gc80c40b6642

