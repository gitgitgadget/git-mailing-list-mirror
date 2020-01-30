Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A8CC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A98206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="RbEeRopw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA3Lux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:50:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50917 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Luw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 06:50:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so3454617wmb.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 03:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dS2gBwmzwomLr20B5xaTmFCs7UI/UotfHwredqfTOxM=;
        b=RbEeRopwZOEgTpFhVAcuJfuDJ/ubRBYzYfJzNcZE6fEsbZnst5M49RbF+yDXHKGLZQ
         JLjhkLKdT5A5QwZYs8UEnQW0p4zceZOBBv0PHWliFjUdj8T27+5bGbG0ZEkhJsLTVPMr
         uwz9NRZHPC9mo1CXDiMitW1JMxY0mddFyY3o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dS2gBwmzwomLr20B5xaTmFCs7UI/UotfHwredqfTOxM=;
        b=k7+MUSCwukc8a3j4z1+kPJyJ/Tlo58k2RspZB/cWXEmB6S4YD/4ppx7A6wPYwkgWCa
         daw2uG/GQjVLIut396gXrsOyDO44X+HsM68Mbx8FEs9XCq7LzjG++dwuq1Mu08hhH2zn
         ZKRBZpzOX0yix65s15shl7EWvB9k4/8Bd10i99XLtsNAwKbv+7o+tqhvwZFrC94BTnG6
         ZhJjo4dqPKQ01+S4YkaqW4o5KS3kodF9DJhtAZgIcweGzyW4WKz49Wt0asn0KIDwARmK
         Sj3MFJ7mTRQERWT44T4zFJn1mUifmXN8xoduzES4gLbEVC3qRNxCqlc+JpC1mVOTruFV
         nyRg==
X-Gm-Message-State: APjAAAVqI18o2aJ9PcVsmR+mWoiMtPvKtS8muZcy/JUVDAGmME7hlo3z
        WWucuWKRjPKNcyLIb15t9OMuWJ7DtPc=
X-Google-Smtp-Source: APXvYqwxqyxUN+1tzl4UIoN0biknTCNMA0rS1G1UMcT/C8cCD2TzrOrxoigl9rqAYi9ahzGbM9VILA==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr5409594wmc.78.1580385050448;
        Thu, 30 Jan 2020 03:50:50 -0800 (PST)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id 11sm6453949wmb.14.2020.01.30.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 03:50:49 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/1] git-p4: fix file descriptor leak
Date:   Thu, 30 Jan 2020 11:50:33 +0000
Message-Id: <20200130115034.6191-1-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Spotted by Eric Sunshine here:

    https://public-inbox.org/git/CAPig+cRx3hG64nuDie69o_gdX39F=sR6D8LyA7J1rCErgu0aMA@mail.gmail.com/

There are at least two more of these, but I would prefer to leave them
alone until the python3 changes have been merged.

Luke Diamand (1):
  git-p4: avoid leak of file handle when cloning

 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.20.1.390.gb5101f9297

