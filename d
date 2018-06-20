Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56FE1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 08:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbeFTIoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 04:44:44 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:41540 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbeFTIom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 04:44:42 -0400
Received: by mail-pl0-f46.google.com with SMTP id w8-v6so1375936ply.8
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=hAQkGVNiZtm+WKC+ZAObgn1Z8AMudPg/z+8p3dEUr9crz+EaAO43Q7OFzmgkcXtq22
         /5thkP6hqO3/uuZfUAiRTtZIiGvi3qyC54Uu2pFf8X3CBfQSnHNPbInItqX9wBLwds09
         ZWNxpCuRAwi7XFIMZYaXdFt+jWLdHuHAAeicIxRmLvTnySZLhBWpLGMze3TjLEeth3Y1
         c76wOINIt6dfzakmxVAioue1Q/nKQM+B5QidSgCTLKnaMHe29pNCfUf46Avp7cTo96+q
         mIT4n84c/B3k04Iv/Y+GRp6JxaOElkFtI/BlLEFu4j8cGu8hYEzVc3yhUJ6GNPwBWTOT
         H/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=CssxaqqjzU3JFd5Pye/NT43wrbRGeBE+MHgVpuFazzzdMCOmTV+3gbwWpBPeLKZD7o
         6H4dVZs2rkGTEOLONxqvWYeIa475mKExnZcNlNByPnUCG7Kt/5E0ziVcHmMeOfl9mbE2
         lEyvIjlPix9pePyCbVhDrGNWNuk1iKrCbHaJ4aDhYsUOUPIZTVDDulDdW2DrLAvZ/zrO
         GntULdoaHL+PTiYqikJ8j9/8fiVJiQ5FDx7ooxTaU/EK2tzRkZ74u7djKHQd3H5n9RuJ
         EoXS5oRU1mNq4ZadPcdFU/Bo1KySMHKoE9OrqRuQGZMa7ui7T3t0cDtIlqBatQ0QryBe
         EbqQ==
X-Gm-Message-State: APt69E3tQfVqwJsfPTbiZwCkCjo2n08YgbGUg7WtPOQHM3nXP88tFI3M
        //U41zEh+kiJqlt8V/DWbmc5kn7L
X-Google-Smtp-Source: ADUXVKI9o776mHecPoBJq2vntC/rDov6W9i5/iZwQKYcs/eZ72hyLY9QEd2JchDT2fCPHuY0H+QmPw==
X-Received: by 2002:a17:902:d697:: with SMTP id v23-v6mr22443572ply.193.1529484281376;
        Wed, 20 Jun 2018 01:44:41 -0700 (PDT)
Received: from [192.168.1.36] (ppp-110-169-68-182.revip5.asianet.co.th. [110.169.68.182])
        by smtp.gmail.com with ESMTPSA id g66-v6sm4488621pfk.99.2018.06.20.01.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:44:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   KoiAnocha <sanoocha@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 20 Jun 2018 15:44:38 +0700
Subject: Org
Message-Id: <6F04C920-0A85-4C10-9D62-0015BF5AC13D@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (15F79)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
