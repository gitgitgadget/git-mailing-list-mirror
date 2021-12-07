Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1FCC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbhLGRtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhLGRtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC029C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d24so31274917wra.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=NnjPRbF6qQrn29yw9QZ2+8Dm2ZkZ8LohFKHCms32wj3lrqmyb0yc3j61Av7Lf8BfN2
         MaAB4AKVRRr9Zanfmw9Yy73xOoOHzzfWgLechGYUFrryr0bveKRt/n9rbjeVMhSSUBvf
         uTepn0klt2jXfRFXQL/IeMnCa4fMBRYEYYvUtkTTH5dfbsFFACW/9wYQpK6+trpaTv+d
         M/oRVeWiGPO7NdZjOEK2Sr0ChtgLa/5YxfLxLPelUtjS3lr5iAguuV03JzT1EetbBcfB
         tLuA+Q3oN6vJXczmehXIdN3gxJlU9fTglaRy2EFLjREKmLCXIHM8ZMm65f7IcM5IiXyc
         Bm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=aDEzDo9iOHcf2rlUHhQ04N/ak6BPdeaMIip6tSeUtQZOpd8Qf93DnoeWv39xDvkVJx
         7H74jFVAJLtX2M+bsf0rIehiJQc4J8lLFfGkm9NsJd2I/ZydB6ph03k0a91BBoO2t46U
         S8DpOHULyvcLCuY2xFNuqY29f/ghdMNuY6Uo1xGUSO7/L3Dy+zlxwF15iEG9LP7pAL7u
         nifa5hubMBnfCI653zoFfvPfzhZTsBbiHLytXQYefqZsDF3WOAyYNujgzMaQuo+jPdMz
         T1pECXc5scxi+WT3Y77iKoG+5qrNQsHsCPo1Irvm8awobYTJNIh6Gwx8MYbL0BIITF+u
         8YKA==
X-Gm-Message-State: AOAM531nqzeaycc9gWAzBr/GyiEvv+P7LObFakFXkJ3Q6bwSVSpbxrwl
        RIT5tt5mxMVOzpA7kglmB59D6Ge+PJE=
X-Google-Smtp-Source: ABdhPJzOTiRaX75qcA6b68L9KX1OyURB3V+Mwm7B+YMdcU5s1cAL10LPlDamx8dS3C+oZ+msUrlz4g==
X-Received: by 2002:adf:b355:: with SMTP id k21mr50977586wrd.451.1638899128138;
        Tue, 07 Dec 2021 09:45:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm299176wmq.32.2021.12.07.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:27 -0800 (PST)
Message-Id: <97279040dded376c110299cc8f2a6a9f7fc4950a.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:17 +0000
Subject: [PATCH 03/10] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered in the unlikely event of fstat() failing on an opened
file.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/blocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..2605371c28d 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -134,8 +134,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	err = fstat(fd, &st);
-	if (err < 0)
-		return -1;
+	if (err < 0) {
+		close(fd);
+		return REFTABLE_IO_ERROR;
+	}
 
 	p = reftable_calloc(sizeof(struct file_block_source));
 	p->size = st.st_size;
-- 
gitgitgadget

