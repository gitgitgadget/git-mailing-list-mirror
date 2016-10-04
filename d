Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29BA4207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbcJDFVi (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:21:38 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33947 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbcJDFVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:21:38 -0400
Received: by mail-vk0-f68.google.com with SMTP id 2so2319429vkb.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=zzqcfkKL0CetqDlHcPkad+xGFRNCJupLcaxW13bE5U1VM+q4h8BmxIUVMaQt883/qg
         7dTyr1sI6xx5cjoNlEPntRFr4zUqy+Kl/FPy3vC9U1StIErOYtGxbDXc0tl5mD/2FedU
         /3M4aupryWbXLqPXiDGJD626M7YMoglw4rAXZeJskxPdSMNDJTBmoILGCsCA+vGx6iTH
         uvlA0gjDE5+wcSEBE8ZWFNECaVg9ys0MjYegn2ku91VrfBiyE0wgmiBOkrHOc/cgRInI
         c23ha/ivpPO6Ps3+feuCTWwY9JxfQwkZG2En8tIDpG3pH3k7KRvSILjBQVNySqmbrSqb
         1T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PhILA78hmG5mJl44MnwSNrRF6CICoMzU/K6XHbsDHtnqYI8ceK366L+2ris9h/v7mW
         891etfWF92jHBabwdq6W4azgU30GN0CG0YohSm3lLB5CCu7DdbPnffmI6ndwK1ekUA90
         IXnQe5mMQHdfxBsc+jZf/+Uhe2eTT6RnMayFJFef6PlHX+GGSAwP1sW8o7rs3mYNVblF
         ZmfogDRCkHAlB5qeoHw2iQnxp2RxmBt46L9qPIHYgjrv7jBUZWFcAyxsNbH/hNHOHof2
         Sddhj3lAJH5t8kcRDtaH2xDohsHmElxTV+Q7k7weVAyiKE8T9fwYNQHkpjj99P9qqDBy
         4Rjg==
X-Gm-Message-State: AA6/9Rl7N13AgL52ZQr6jO/CWdk8026Q5IfKiNiUQ32r4f56NqIaW0H59QQF2mO+OyCIqA==
X-Received: by 10.31.213.70 with SMTP id m67mr1026351vkg.43.1475558496968;
        Mon, 03 Oct 2016 22:21:36 -0700 (PDT)
Received: from [192.168.1.14] ([204.195.149.173])
        by smtp.gmail.com with ESMTPSA id u48sm463854uau.5.2016.10.03.22.21.36
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Oct 2016 22:21:36 -0700 (PDT)
From:   Otavio Carvalho <elotta1223@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: 
Message-Id: <F51AB298-1ECE-403E-8E7C-EF3A0334D1A1@gmail.com>
Date:   Mon, 3 Oct 2016 22:20:40 -0700
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

