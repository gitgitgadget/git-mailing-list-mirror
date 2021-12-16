Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F81C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhLPNpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhLPNpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D7C061748
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e5so10879703wrc.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQlhnL+dH7K9BLiy1SJ8PSBAPN2vrs2GrQdk5nRL7ws=;
        b=Lkq7rdZnW+FZn0vBZrFmHdkhgkskZTgKeHU3GKOCnkFRUc8rhX4I/GQmK9JOjBNAi4
         2aDS4NTFj7CXS24pmt/96wX2f25xSP+gNEFsj+kWOhogxRChjXKf4oJ3FyHWddnel7nM
         mYKG+etmyUHSULNopG+xHA6XxMp+1esFbvO/dMRwYfQEs1plAj6I9hBZhkQR8+uTngbp
         GUpm63jK7neN5xFAFhIPWFxyLD8GTI8f0hcWpTQqEUAEjS9dVLbfMcarZZvQsl7kq3RI
         gNrBKC40QcmHwNrLvtNAnAQdY8bCVbZLSCQBSHwlqODfFB8LkgzZnfzCxgN02H3pU8L0
         8tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQlhnL+dH7K9BLiy1SJ8PSBAPN2vrs2GrQdk5nRL7ws=;
        b=aBpNf644ZUycXxtN0Lr+YYCYbP9BIOoUNQx16jDUJEvfi4ATiJEy6vnxPmyjqG/oIE
         7zjsb6FDeNh58yHUz58nfNSsza0mE2nuMFDWqUamVAmqW17qN+IJATlKvkUB9TayERBl
         j5vPoVHLIOudK3blcbjJGX9swo5FMYKH/Vzlkw9grhqFRRuDij4FgU7tJnSdeYqoA/zO
         6q2f3NGb5C3+im05dwnIcRkHzZdZqXJgSraLCtao96AIkO6WVUnRPtaeTS60s/2A8sKK
         qm0cwlVYjwf6SKT4jFKzh4H8WXM3yDVICJLs1DIbzEOV3cUoXssiO1eBIJInpJw2tUGO
         FS7Q==
X-Gm-Message-State: AOAM530uVdlpeq9pH70mWbpyhnC+oWPb9nocHURBZwLMxdv73IlJlO3K
        E4T5Z/RfdeqVqhUqUbumSYoONS46SSs4KQ==
X-Google-Smtp-Source: ABdhPJyN7GJDc8rZgk4//gvCGB2OqyTKjX+bUknMlpu0M5QTagwtMkwm3KEWQ7FRu+Ca60nDzQCVmQ==
X-Received: by 2002:adf:f40c:: with SMTP id g12mr9240960wro.287.1639662328781;
        Thu, 16 Dec 2021 05:45:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
Date:   Thu, 16 Dec 2021 14:45:17 +0100
Message-Id: <patch-v2-8.9-f9fe6a2cfb0-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
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
index 90b671025a7..5f8586a36e3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3105,12 +3105,12 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 
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
2.34.1.1020.gc80c40b6642

