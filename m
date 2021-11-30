Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004DFC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbhK3Vl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344240AbhK3Vlo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90B0C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q3so24607469wru.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csE09GodBkuoeSRAxjaJaIiEth9kRVv4P1MZIeR98io=;
        b=CAqdylGnFhE6W43gFD/j4IG1O/pkrk4H/3EBhllFJW56stYgj/gqv7oHvBhSY4y6Gc
         CSIxkr4Ddk0lK2p/iA0u/uq3+PoZBi8VH9BVnvGJusiMS1tAjrT4VqZboMBurZjtfBwF
         dptT60aOn08GAS3CDWi9jazFtTaTf1r/l6o+kWfIyugTnY0QLKd9t9YIWMRR9p5swPr4
         oS7yKUZp55faBMaraPaxzQFM1gsSpYqMbOQNQvlfIxSNHtntmPUE9TTh5E8l3eyB/ZEf
         Ys4O6E4/Vc/BxMueygzfTgAw0OlBUt6sYIcCMNee2aCGUGMV/DD4J7BYORgRF7QFgXKa
         WtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csE09GodBkuoeSRAxjaJaIiEth9kRVv4P1MZIeR98io=;
        b=tE5ilBhxTaqF6B16FG83iir6LP6H6Sj0AVVXONRlYZncTbp86vyrIkZ+Reh0UrBoqN
         +9EyvQLfXUaqjut51tXwgO0G4FpqcaJVekQSlqrHbhwxUm6kOrKdXGHju3ln0wA5hMJT
         X/Tx00slc6flST9RoxFE8OTZcqWlXzoukXLrp3ZHCEaOfXdXLs8ATF31ABEXjaX7M6g2
         vTtp8nyJ9QNEutC39uMUmlugoLmFRFLxY5OaQ8loRa7pDug+MtAUz+4cQz1NdZWW6YrU
         xm+mD+C3NWlufBM6Htxd/vadIdREnHJ2JjP+BT5zIpmvIpnfOgL4yNE6DQxGutUmzQt9
         kj4w==
X-Gm-Message-State: AOAM533fTrow/IAXcTBXWd3dlJWwMY7iH8LCH5/J4mjjZCdVhwOLV1KW
        Q30XGeJFdUFDjm/TbAAUC7p4W0FXc4BHZg==
X-Google-Smtp-Source: ABdhPJyBOAwpib+wNm+9AQpc4/3c4Hbn/X9iyEnq8ZPb5I7w5aYeP1n49/OWsWyskpwIGAxHJbB7kA==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr1678291wrw.591.1638308303216;
        Tue, 30 Nov 2021 13:38:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/12] reflog expire: don't use lookup_commit_reference_gently()
Date:   Tue, 30 Nov 2021 22:38:08 +0100
Message-Id: <patch-06.12-eb3dd3fa8b9-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
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
2.34.1.877.g7d5b0a3b8a6

