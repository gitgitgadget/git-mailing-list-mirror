Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC1BC35274
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 11:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiDELex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354555AbiDEKOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 06:14:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB936B0BC
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 03:00:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h4so18424870wrc.13
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtMX/gwoMvbP+ZN/ppzk+M7hwtXEoHbDEAgE0NeikKY=;
        b=cRSgQDhOQC9/IOLnZByngJVb5SRUvK9mitevIL2yDpHzhlPRWPxHQV8g3uZtf+yCoA
         DZ0V13m+4ap8u6MP9VqR+Ll9bzu0+22aMdBOvMVbj8yyxOOrVSw0eFxO8r/ui9glGwto
         ROj0/wiJkz0Bs903k80RqtALrHe8vbOkcXMww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtMX/gwoMvbP+ZN/ppzk+M7hwtXEoHbDEAgE0NeikKY=;
        b=VaWCEOfZ8r7QkNsk0bYUqj4Z89IaIINKhHyIc0RsD4132J7QgJ8muvPBaAYEu+wNiu
         PJ7G0FtDMH0VQ8PTKPuKC/k/zbUCgacrnndtAxHpNaQAcwITIoVNSAmeAbJmFBBvQOxC
         6c5Akc+bbZ1IzmXX22d1qkIJUo+XKftj0X4Qt4O+FCYUaIERbOEcIzNX4L0+9gtb/T2j
         cVgzuPKU8DkweOcyZZ3jh3BSXfJjkc/tuarweyr8ZePZhik99bDgzd1fEfr1FC2Tl+Aq
         eNxa0mRXYNdPGrMsmTlkIkk5he/DVlhLZfHWzuNVT70FAAR9ffwNv8iiKGLhGJ5cNUt8
         5Paw==
X-Gm-Message-State: AOAM530s1cNG2XS+pDwRiYa4u7RNFAO35PnoE5W1Pw2+4lkxLjMGttfU
        nXAyVPiw5FEUYiHoDTb+ivBnZ1oybgcWvRnM
X-Google-Smtp-Source: ABdhPJzWo5f49oUcbmz9u25KYhgkG4rqhOgVD2EPG+TJI/OVirwyuB5rHorDANNeq9BE2Jm3Uwf4WQ==
X-Received: by 2002:adf:f881:0:b0:203:f9b1:a6ab with SMTP id u1-20020adff881000000b00203f9b1a6abmr2039292wrp.410.1649152855133;
        Tue, 05 Apr 2022 03:00:55 -0700 (PDT)
Received: from localhost.localdomain (2.8.b.4.e.9.0.f.c.e.f.7.5.4.1.7.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:de15:20ad:7145:7fec:f09e:4b82])
        by smtp.gmail.com with ESMTPSA id s17-20020adfdb11000000b001f02d5fea43sm11927916wri.98.2022.04.05.03.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:00:54 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Neeraj Singh <neerajsi@microsoft.com>
Subject: [PATCH] configure.ac: fix HAVE_SYNC_FILE_RANGE definition
Date:   Tue,  5 Apr 2022 11:00:20 +0100
Message-Id: <20220405100020.48663-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If sync_file_range is not available when building the configure script,
there is a cosmetic bug when running that script reporting
"HAVE_SYNC_FILE_RANGE: command not found".  Remove that error message by
defining HAVE_SYNC_FILE_RANGE to an empty string, rather than generating
a script where that appears as a bare command.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6bd6bef1c4..316a31d231 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1087,7 +1087,7 @@ GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
 # Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
 GIT_CHECK_FUNC(sync_file_range,
 	[HAVE_SYNC_FILE_RANGE=YesPlease],
-	[HAVE_SYNC_FILE_RANGE])
+	[HAVE_SYNC_FILE_RANGE=])
 GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
 
 #
-- 
2.35.1

