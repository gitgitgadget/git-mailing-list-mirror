Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85BF1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdHPSgA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:36:00 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38509 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdHPSf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:35:59 -0400
Received: by mail-wr0-f176.google.com with SMTP id m57so23733346wrm.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=Rymbdsh2mcQ+humIGPEDErgK8jA3UvBBZVTmEztiYUc=;
        b=vhoNp9zkMCM+rnIsKHn0gZUffm1YY/xwOHggnm87WpeLkyeGMs+Bh53KkPeqgfGA3u
         l8T2ldcuI0IDedalT6ZviLb1ziH8rm7t9PKk7N6nxGQuRtN9FFYMHeV6PjnnkfCzJgXj
         vMVs5youydx/S6oLI/V+I6mnlM20tQi/z9fCtMKf7u0Ukad68Osy6jDezLvkztwHDmRJ
         Elzdriyyz84ByMZXZ6vbaMgNbLkAHPYYDOKyLvMDP/5uyOUfyHEOeAbgrRrUO7CRD5ci
         3vM+q+XsrmhLmveQRCCY83vfc5V458LEjyf9HNt3m9SU6kE9R85TSTypzjqAe10cDmoS
         dfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=Rymbdsh2mcQ+humIGPEDErgK8jA3UvBBZVTmEztiYUc=;
        b=IRQ07aIVKI6/stci73fobZM/WfyCP7CyCYAhqExthyYnyFgTn2sLarMZa+u4hXHa4a
         ZeSmJYhW2hYv7gC2vvn05hLpyYpyRovdWEtFxWlMmf2OSNnwRgJurnft8fh7e6zc72wE
         6reedAUsCl6srCgY11ppFwnXRscRpMmvZqKfdFgD3l6ZFy/QQYyMRIqoMIcUA7vR8UQC
         a5IkAtFAbvfnoVhyFeyyW68RQPm5iwyGb8kmikd8B76or7Vwp4WJnoeceduU/fb40ujt
         yTj/NOJ1i2oSueViDdgBi+chOvz20qcJWPrJSFmZM4g1O6BG5HOj/X0UdRuSiZ11PLdV
         nnFA==
X-Gm-Message-State: AHYfb5ikRezpq6wc8UvKOCOGb4sW4rTvj2PqttvULC0qg/TfbLgtgSDp
        1lk9Txo2Vw6U7VlGANE=
X-Received: by 10.223.150.169 with SMTP id u38mr1774600wrb.0.1502908557688;
        Wed, 16 Aug 2017 11:35:57 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r70sm2435751wmb.35.2017.08.16.11.35.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 11:35:56 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Submodule regression in 2.14?
Date:   Wed, 16 Aug 2017 20:35:56 +0200
Message-Id: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think we discovered a regression in Git 2.14.1 today.
It looks like as if "git submodule update --init --recursive" removes
the "skip submodules" config.

Consider the following steps:

    git clone https://server/repo.git
    cd repo
    git config --local submodule.some/other/repo.update none
    git submodule update --init --recursive
    git pull --recurse-submodules

With Git 2.14 the last "git pull" will clone the "some/other/repo"
submodule. This did not happen with Git 2.13.

Bug or feature? I don't have anymore time for Git today. I am happy to
provide a proper test case tomorrow, though.

Cheers,
Lars
