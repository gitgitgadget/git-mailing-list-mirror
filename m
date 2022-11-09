Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A59C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 09:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKIJH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiKIJHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 04:07:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E6201B3
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 01:07:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so16514547plb.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kcp0avixyt8FiH5IsRry0jPYvkgZv/52fDkRIrZESCw=;
        b=UTyTJkjepdvmgSkIEdkmYxhr61OUDg+JOZ/D0DyB7UIJzOH+srt2QugxX2hBI1DLwi
         tuAsW+JXTxnXuYqs82nAhAXXRscGYZtpbaLXAhtrYveT3vqMCa7LQWelDEToqsQT6PH9
         g7S+pFuPoA2ewA47ocNbheYejtMcuUE5dfC5Qe6FLG9Nx6ZgLXIo2u+fdfuZJx6HXd2p
         b/zN7Z3tsaOT9UaOLjRlruzghVwvGds5DcleX4LLbKmG6HAksRYDgOWKNOhQ4UCYJlSs
         AvuIirFUElqawvp0ADJPk/F3evwXR0ZV69jTrpCzgkqu8V/v1ct/7t9Py6ElfLgDbjHy
         tcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kcp0avixyt8FiH5IsRry0jPYvkgZv/52fDkRIrZESCw=;
        b=Xdy42OKEG+UAzrCVzucSmcC7iVXgcqe+m0w6zR8lfShiPcA6wAWMnnNwPyxwibvYWL
         6csT3Mx0NluyMCwE0UHns8Wz4zGGkeH9ZilclmrccRp67pPgtUnNDDkZHlVWSodKih5J
         TtuE3JFuUatLUhivHWIjRN2nLVuSpuJVxeUnWng6ql4FS+TNB1aWS7a5gcUH199Q8KGz
         lulBy8h1mqaBH2qY/I9fOvUB92yCVFnELhbUuldjhADktJ/tdUaseCLsKG0XqCi2PGAJ
         tDqC1uhz8SqzBf53/pc6UY9e5h1fNqnfxzp0JFyMEtTmlpJ9ojqYg7HaiHuC3j0QeGNv
         Tu7A==
X-Gm-Message-State: ANoB5pkqxFcsX+rmEnn+iRDLueo/aM1zsX2S4/CoWD8OCbXB7R0ENek1
        X1UjLS4wYfNhTwn1z76reJo=
X-Google-Smtp-Source: AA0mqf4wBRZ4jfuIrgsYxlb2H1c8g5aBQWOgotoFlBHZOrAisvKEBwXvwkhAIdoH1z40SxaBRaBvvA==
X-Received: by 2002:a17:902:9f98:b0:188:6593:17fb with SMTP id g24-20020a1709029f9800b00188659317fbmr27960374plq.173.1667984825094;
        Wed, 09 Nov 2022 01:07:05 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm727509pjb.22.2022.11.09.01.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:07:04 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 1/5] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Wed,  9 Nov 2022 17:06:52 +0800
Message-Id: <8ae58934a1d98fa2bb5b9383d32b72ddd1855eb9.1667980450.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
"strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
"\n");" will do the "grow" for us.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index be51f69225..f4bab3b2f2 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -618,7 +618,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
-		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
-- 
2.38.1.386.g196e80358e8

