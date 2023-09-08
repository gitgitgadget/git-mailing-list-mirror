Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D7EE57E0
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 09:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjIHJJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHJJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 05:09:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20311997
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 02:09:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcc0adab4so228066866b.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=milientsoftware.com; s=google; t=1694164162; x=1694768962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dquRx79/K2fXctJ23hh/3In537PFQHaAj20xnhmeBY4=;
        b=HcO4hzBhJWMc5c5RW0sSWgCphr2ngQMdYB90ZP6BBh7jzUUGDvCA6j6FteMG/+cP2j
         EI2FpdTs+yne/bGuWVJyoQbGRpnA5PgP9K7z3bWd3P2ZCamQmHqT7JTwOE+JiAp3Kx21
         xhJU7+bQeCYJ6TIMoXyzEb2IN1IINZ+MG9snCG1JQXmsTVXs+yVAV3LyI5Ma+WggpcB4
         CAnmWcNJqJcEAId9brwWjv7P358iO29weS/n053IFNprdKQCIjItzI3insJLziImQxfo
         mynTT6HrHOwNf4sxcokw4NZAu6t6FlHZzga64NHAoBAnIzPxLIuBAluBPCRwWmlqjBUG
         BHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694164162; x=1694768962;
        h=content-transfer-encoding:mime-version:organization:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dquRx79/K2fXctJ23hh/3In537PFQHaAj20xnhmeBY4=;
        b=IBJ8mbcdD4pXjvfayELF+7eiTIGYFTsGJA6/kxt+g2eE3tyi4S7ms8hEMZvVpbXJaB
         8xT2eoie4vjYM9h9MxIt7kvWIcpN2jUHKOqjPO3/gSCVfV8BiP3AQP54FNw5NXK1HAL5
         Kxw3nD3s+PnIfAMEOs2Q4Yx/UlCiYi/AnZPA0kQ78IDxS8SlIeCfcYsBPUp65QWmGnQ/
         4wEeUYsk06GX6k2FMKIQQ2SqMS+AIzHtkjOoypTEigx/mTQv0f1dFcSmdS8AVj7C13ON
         bElBAafzx+Sg4gfQaP6qcc2VeiJiLNttH0J/lqCK2y9vT5govFmgAOiznLOq5PB48n05
         hJnw==
X-Gm-Message-State: AOJu0Ywk2iEwdUof7YSvgB0wSC9F65WCQyBwMQZbFyrDt2RGxGuXOxxu
        4EnMus0kD6kQlboaIqez6bZ7GplYGScoFfRQKDs=
X-Google-Smtp-Source: AGHT+IEBP6iP/mnCzywlgDrVRQ4NF4C65TQFJmm7vITZWOavMK9X4uvY4K1F0qssEDAsbEBRjJ37Cg==
X-Received: by 2002:a17:907:7756:b0:9a5:852f:10ae with SMTP id kx22-20020a170907775600b009a5852f10aemr1304926ejc.60.1694164161992;
        Fri, 08 Sep 2023 02:09:21 -0700 (PDT)
Received: from utklippan.localnet ([2a02:5120:1005:1::21f9])
        by smtp.gmail.com with ESMTPSA id ko11-20020a170907986b00b0097073f1ed84sm745957ejc.4.2023.09.08.02.09.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 02:09:21 -0700 (PDT)
From:   Magnus Holmgren <magnus.holmgren@milientsoftware.com>
To:     git@vger.kernel.org
Subject: Please explain avoiding history simplifications when diffing merges
Date:   Fri, 08 Sep 2023 11:09:20 +0200
Message-ID: <3337579.YDm8p7mPUg@utklippan>
Organization: Milient Software AB
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi (and thanks for a great free tool).

QGit was bitten by=20
https://github.com/git/git/commit/0dec322d31db3920872f43bdd2a7ddd282a5be67

It looks like passing --simplify-merges to override the default solves the=
=20
problem, but I still want to ask here because I'm not sure I fully understa=
nd=20
the reasoning:

> the default history simplification would remove merge commits from=20
> consideration if the file "path" matched the second parent.

I guess that means that even if there was a difference relative to the firs=
t=20
parent, which you wanted to see, the merge commit would be omitted if there=
's=20
no diff relative to the second parent? That's fine, and history simplificat=
ion=20
isn't trivial, but now every merge commit ever is included in the commit lo=
g=20
of an individual file, even if that file was only added somewhere in the=20
middle and never changed since. Is that really desirable? Shouldn't it be=20
possible to include only merge commits that are not TREESAME to *all* paren=
ts?

Thanks,
=2D-=20
Magnus Holmgren
=2E/=AF\_/=AF\. Milient
(also holmgren@debian.org)


