Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04565C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhLVEHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhLVEHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05919C061746
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t26so2094963wrb.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYqbqqszUzX8Lt+NCCEFNwddmny2BbFeiQ7i+mMf/7s=;
        b=kxRngXq9Pyt9RGB9vbe31WWjWwOPRjgzZ8MSY/gxUz96OD/mbtvPAAKV5ZkbVr7MjO
         zi5f9164Zb/aH3kuUsij5lOvws8ObESUQ7rvC4BoT2jDs604nMuwO3UMpiqEyqxBOaJm
         yD12IajdFmpzgAFV94aYSUZXVcv9tQ0OlI5+r3HNbv9Xke+zJHce9aKiXngubDggTjQR
         C3SJJYFKPIG5zNZhEnTuYGs5YQ2U4HXjkccjvTkhcvItnzPjcIEjgKPbDwkQdMkpa0r4
         iZUarw5oV070LUBqo0NxZ8I4TAByLTo3IE0LT2RDxyfp7f02Od1nY4aba3YwieT0zpmG
         m+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYqbqqszUzX8Lt+NCCEFNwddmny2BbFeiQ7i+mMf/7s=;
        b=AFL9XhLsD853fckudQV/+fQpds71z0oECZ9Mg8Pc6meD+9x6Ml6lfGJkxfxnNJU3zp
         AZLkZyDzlfc7iEvw7ej7HC41+p/E1zs7ms8LPoAL0/tvcC3xxKxa5E4nnxB93rkLjH1I
         nFnj+Vbmep9dsrSKNTMPfOcsT+fF+134r42CpTfrzZszcisi46idJZuC5INrt9wRdeBc
         fCSd2jm5y/9ALgmEq5fcdDPwXIjN/lZ+J7i6ACO5qKyYs+BPhTNdbWCbR3nk29WqpjG/
         H349pFNiQuAWDmfSiwahRZxSvqenlQXk6O7bdLeXuDWfYvUu9RZaJc3fVizOpCo+Hz14
         XnOw==
X-Gm-Message-State: AOAM533JrbALtc6rw5qvmTCumo1Y6VCnujJX25bSoTJMKAZuRloq5/sy
        X0spl4UOfDk20kDV02Hrpx+/LW1SXh6A6A==
X-Google-Smtp-Source: ABdhPJy+xBSRKMgTAttvcvrmbvIxocZuE1SkbnsBOEB1CKxboNLzF7WPRxH3Zh/vSUl6E0GfWhcjMg==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr689323wru.241.1640146029457;
        Tue, 21 Dec 2021 20:07:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] reflog expire: don't use lookup_commit_reference_gently()
Date:   Wed, 22 Dec 2021 05:06:45 +0100
Message-Id: <patch-v3-6.9-cfa80e84c6d-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
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
index f18a63751f3..fe0bd353829 100644
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
2.34.1.1146.gb52885e7c44

