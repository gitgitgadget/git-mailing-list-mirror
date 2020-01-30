Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DBAC35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C365320658
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="XLzz/ey1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3Luy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:50:54 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33963 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgA3Lux (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 06:50:53 -0500
Received: by mail-wr1-f51.google.com with SMTP id t2so3713533wrr.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 03:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMw5CDJhN0WdD2nSTe81d6Jz8WCInXbLgP2rc6apFak=;
        b=XLzz/ey19Wb2MTFvu6nJkr92A9WtvI3Et9OdBjCdCsZZYylGv4OQA5DV4JSebotrSo
         Sij5B7TobDvYWX9X2vpWAGjVKN7bv9nOeO2sF5tTaHN5pwg88euk6GMgerZstR8gHvwY
         hYWaVPDE6LDydSiHJjRa3dKZCsnR+zDK9mTPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMw5CDJhN0WdD2nSTe81d6Jz8WCInXbLgP2rc6apFak=;
        b=JVNN3GIcqN2HbU7/688zhKggnh5Tm4+OAeQv30f2nJrsXceBs/ge2gAOUlvUeQGhDH
         6t3rZ1zFigSGW5vqXT94vn/LFUMriBzGZqk3l4yL9do7lM01wv2Vb+CaXwtJR/XbruzT
         dHz0S4ttqyPgCWXrDjDMP+CO/xW0uU/sDnVs+q6ntINfyGQ93I064QUzDtAnSqkGLksM
         94tPA11EFcydlto1DgnWiVvHQS5LQT0zosEFaBb0if7ELjmX3i6QmuIqbYpl2Z5n0+YI
         Ah12riLv1uB5AQ14ycx7rIHp1otBSLSB0YcMER1DLUaXQ7suN3Axg1G/teWwl32rgwOF
         Sumw==
X-Gm-Message-State: APjAAAVYA4Oxd2Hfi7Kp9KEdGRZp6CPn3uxAiMiX6Zuocm4iQg7/t5WP
        SK7ZZdmouY+DwH+0Qrjd7+wWRr4DQqQ=
X-Google-Smtp-Source: APXvYqzZ/Feu/MODXQJ0CH7z6Lnz8NePamJFfNW8cE0drBOUnNtoAJZFhP1ubGHhcnLpyk37yvz9PQ==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr5040756wrv.259.1580385051259;
        Thu, 30 Jan 2020 03:50:51 -0800 (PST)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id 11sm6453949wmb.14.2020.01.30.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 03:50:50 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/1] git-p4: avoid leak of file handle when cloning
Date:   Thu, 30 Jan 2020 11:50:34 +0000
Message-Id: <20200130115034.6191-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200130115034.6191-1-luke@diamand.org>
References: <20200130115034.6191-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Spotted by Eric Sunshine:

    https://public-inbox.org/git/CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com/

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index eb5bc28cf9..9a71a6690d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3563,7 +3563,8 @@ def importRevisions(self, args, branch_arg_given):
         changes = []
 
         if len(self.changesFile) > 0:
-            output = open(self.changesFile).readlines()
+            with open(self.changesFile) as f:
+                output = f.readlines()
             changeSet = set()
             for line in output:
                 changeSet.add(int(line))
-- 
2.20.1.390.gb5101f9297

