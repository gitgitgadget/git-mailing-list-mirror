Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B321C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhLMQCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhLMQB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:01:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99067C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t9so27872303wrx.7
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=Lltsq/qtcTg8Gy4liF7YqAs2Vhh9c7BQ3SWosFZcZghIsfKyNxOd5I1NfP7zpzu56f
         g8mtxl5OtyM1u8m+ApL5j/CPtnQPHFisFUQ7ylHcEQ2Oa1kFbWDd82ab52HQL4GN30My
         2NYZx9JAI0fVDTEhr1+6etiikWbW+G9GqSfDKoUpaNg/BHsBVWVXcBCuCTgXhcEOSeY8
         dnPnbn23xIOK7n/D/yKzyDGrDCj0fof1Nv8HYEy/4DyAhphyh5a02ExgM/IgdlBkCe60
         VG81p0l2dvJjaS5z3gPIpDIAX/EEy2KU67M2b6ZpIz68MxiDKLTEqnjqkfjk457udvod
         ll1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=SICdf5DHgScO09rqOcL3GFTHhe+Z7nRAI83mRqIq9/NvBlAXadE6jemWTArmUolitU
         GkR/9xM2U45hg0SU35gPJsKelWfKnInx4YZzZ8duguCwEK4kxGgD4QOou1qkNX/RpClo
         jB35rpxAAlXYSq3FTw5Ggvov8erLlawhb2NC6uzX/BIZIyLk/i8sNfLYWGGRHlKFmY6V
         3wnASf9wVGcczmnDIKeo8tp8Hp2R+oTp7WIBsd30cK9A0jX6VFBCpCumrHrc6xlGXEvI
         NONFMhXG9z5NV/tDfiEdBJGBpkSQR1RE1JbINVP0CPBc9GCgJuYO/OMbNMI1RgLcVRrl
         VmvQ==
X-Gm-Message-State: AOAM532gianKICHVNbzi7WVZ15qgy6PJHwFYQwvYhYGbEDR4pEkSjK7B
        LtNm4UbwJsocxAmR/SxFEBB9wWaY3q4=
X-Google-Smtp-Source: ABdhPJy5A2IUfTN0F8TVk0LEawEhAiNxcZgKHOhtTKpLHdJO6y6aYGrduUMXf26bWALFoxP2ubzGRw==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr34250185wrw.253.1639411316055;
        Mon, 13 Dec 2021 08:01:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm10853188wrh.16.2021.12.13.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:55 -0800 (PST)
Message-Id: <0b9c7176d7122253e20f0bc88fb1c79c3efb5dcf.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:41 +0000
Subject: [PATCH v3 03/11] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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

