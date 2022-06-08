Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 13:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiFHNHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiFHNHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 09:07:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353812506F2
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 06:07:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so41400975ejk.5
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y0fhxBWkV0/jyjT7gXvQi0c25AIJd7FhVYsrN9S6554=;
        b=ApDuRRlv+vcwhe8aud+QezYz9siS59csVuIc8gT/vBJeg6xwp5jZjIAZMPPeaBAnZz
         FvtviUJ+vgtbDKCrpoX8re8FN41QSvukzAKvxrIN0eMnt4hEwfk1sz48x+BeJY6z0WLQ
         3bp0WeH+i/LL97rSeBM3vSggsTzpG46n1GDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y0fhxBWkV0/jyjT7gXvQi0c25AIJd7FhVYsrN9S6554=;
        b=778V73WTLMnJiequYrAlmbkkK04fyYqVAtcKGby/wRO2ztAEqpAvxC05QqldGIVnHJ
         ABl+0gDZfAF9GEMNQYlWcRRl1noU0rcapc/32UQBglYDJrIKeeoO3l3g2ggYcVjz3X65
         hlH4paEuRlDiNXzerW3QFB4mqmiixMWK6PTgufHeUGUssUhS7XJHMtb+tHY4goh6mc3f
         ugyJLc8domAOXzQwNVObwgsjp35GoY2Y5YbiySiy501LCw1F6H2iSd50HhSTKyYtHnIb
         Ybyc5HsqxkTtTJNh6baAldsvZDClX53o/Prv07e7QZkSSKoSnMWT1xHwCnjE3s+u0Qxf
         Kl1g==
X-Gm-Message-State: AOAM530msFuYAXUnfNj6Eeb3JDlfR9IaiFrlyg2CFY4Cq4MVMmikIPXn
        f0xKDS+f96U4oRHOBFkYItA62UkwXurJ+gXe7DWoKlpCMcVZRXFm
X-Google-Smtp-Source: ABdhPJzxslQ7e3yEQBr3T4mqpN2p1WvGIGSIpQTOacWGXE9JpQRdm60/3hCut9MSz3CzI7rgu4cvFUdRzn/Gv8JBsTo=
X-Received: by 2002:a17:907:a420:b0:6ff:1541:8d34 with SMTP id
 sg32-20020a170907a42000b006ff15418d34mr7278804ejc.447.1654693636560; Wed, 08
 Jun 2022 06:07:16 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 8 Jun 2022 15:07:05 +0200
Message-ID: <CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com>
Subject: Git apply fails on case-only rename on case-insensitive filesystem
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I just found out that "git apply" has a faulty existence check on
case-insensitive filesystems (or, at least, windows?).

Simplest repro I could come up with:

git init renamefun
cd renamefun
echo "Test" > file1
git add .
git commit -m "first commit"
git mv file1 File1
git commit -m "second commit"
git checkout master~1
git diff master~1..master | git apply

-> error:
error: File1: already exists in working directory

(on linux, the same sequence of commands completes correctly)

I was able to work around this for my purposes by avoiding rename
detection on the diff, and only passing the "Add" (and "Modify")
operations through to the "apply", after having separately/manually
handled the deletions.

Is this a known issue that someone might be working on, or worth
digging into / trying to fix?

Thanks,
Tao
