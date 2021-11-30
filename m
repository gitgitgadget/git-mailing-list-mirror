Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FFBC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbhK3VmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344276AbhK3VmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:42:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD4C061758
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d24so47537312wra.0
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DP63MMqOmC7x5EJLWOeRwhcZIybmuP1+Q7/INmQuWI=;
        b=qquNEjT7JqwuQyoqGmdjednJUuSPAMg601VAS982UJpBQDEgyIm2w3kgupKzZdHiGT
         ZRvMECIvO/bkUuz6Uf8ZLazPhDauMGZdeLyoblavsJsgjjktENQ3MaDc7meY7pd5Szn6
         tWGZCFD+w7fm7GkKO/YJF7UWrehEgdh889D9MlpOqK/vxEbSvpnHgqnOEPPyRTHIcZQE
         7kx2JSp7kZDLQpl6NVh7NlLaRXcP/XynbNniZGDBjf7xh4Kqdt5E7QDMLH07p3tcj85h
         OJHv0LZVYyYt/TDVN3rWBIerGHYZGyY5mgNZZ5bT6moUrvgckH3hFHn22kFnm0eyBIaa
         fuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DP63MMqOmC7x5EJLWOeRwhcZIybmuP1+Q7/INmQuWI=;
        b=bIGcLiPDCVDQKLJQv/RsjyKvsowp4PU5F/wS080elGh2ujJ5jXeZQBrRrRpOS+pzzN
         n41mMzAwkz9D6+e9ijm7cM0t99ndnSPHv9K40TyKu1Xne5TtvvThnE5OrY2pX3NW1/Nn
         16iRC/6zqJatccKgdxC89GL0ISlVhZHhe5u00FOh/mUPmJb+onx7Zjc1qwVfSBTz86g4
         3ufwY2HrP/oAnMcFdfkSyYDUSDaFUx3jdUqwAxOSG9Ok/Gq/sWzNlNvePRBZthVaQHos
         SkhYg4Z8Ko+cyNMxXRa7OAonYR76dmufV/SNvhO+E6t+/s5oTK872O7f2sRebyDh5Zvo
         pphA==
X-Gm-Message-State: AOAM5319FFib/ekIgI8P4C1DPoZRrXlrVD48U85GdPLrwwU9QfnbimPp
        FyNgBwX2tGUwXrCySm0aS7FX0TPo1OEv0Q==
X-Google-Smtp-Source: ABdhPJwMSKK7CQ2qG3okDGDMBG9VWWvVAoJiIksIocaT+JCB5VF1mUOKG4DyzUhG02K6InyJkNDOgQ==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr1714837wrr.389.1638308305725;
        Tue, 30 Nov 2021 13:38:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/12] refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
Date:   Tue, 30 Nov 2021 22:38:10 +0100
Message-Id: <patch-08.12-adbec242a7a-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for "cb->newlog" to be NULL if
!EXPIRE_REFLOGS_DRY_RUN, since files_reflog_expire() would have
error()'d and taken the "goto failure" branch if it couldn't open the
file. By not using the "newlog" field private to "file-backend.c"'s
"struct expire_reflog_cb", we can move this verbosity logging to
"builtin/reflog.c" in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b14f30d48f..451c4e2a052 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3099,12 +3099,12 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 
 	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
 				   message, policy_cb)) {
-		if (!cb->newlog)
+		if (cb->flags & EXPIRE_REFLOGS_DRY_RUN)
 			printf("would prune %s", message);
 		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("prune %s", message);
 	} else {
-		if (cb->newlog) {
+		if (!(cb->flags & EXPIRE_REFLOGS_DRY_RUN)) {
 			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
 				oid_to_hex(ooid), oid_to_hex(noid),
 				email, timestamp, tz, message);
-- 
2.34.1.877.g7d5b0a3b8a6

