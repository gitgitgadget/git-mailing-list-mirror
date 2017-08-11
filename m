Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522FE20899
	for <e@80x24.org>; Fri, 11 Aug 2017 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbdHKPzl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 11:55:41 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:37081 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbdHKPzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 11:55:41 -0400
Received: by mail-lf0-f47.google.com with SMTP id m86so17834661lfi.4
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whiteoctober.co.uk; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EnNOGvKNXZRY4x9OnZJ2X74d0JRJSRUcIWzUMbs1/mQ=;
        b=PDoaqWN+v0Udjcr9lSsHJOLcutNTex2oZ83lhMTdkKr2k+LY0W6XzzgrX9Un0p8hRb
         ibFlVpG21n/VuLEz7Ie6Lt8YO5RGU5DX9F1GyiK57TeXUsZ3K84HoeCPu+Km/9OeLUM6
         SGsdYUKgXTjD0gAUCPB4LrFAfzI45bDr9vrp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EnNOGvKNXZRY4x9OnZJ2X74d0JRJSRUcIWzUMbs1/mQ=;
        b=ktefEphkW123AGdsFVfnzy5Bidm/eAPAdbiY9fEuL1sOxW24V+Z0Z3MhcdJC+1wIRw
         dq4DG+vPh/eHeJhmPACFid6+3V3t6RVY26krzIDb9hKOWarPOYdaelpee4KJPDaAzum9
         rpkqJQw+wUOxmkvpu/SKLeTACLmr4tAZ73muUKzAnkgMuQpQR2Q2Msxip/i/ukzNZH5B
         pDDSt5RfiWCnoS5IED8ek3R5FmteoQANzjERsFg5Gy6a+la/2Vy55jDSKO9KUrvWG80A
         dFvCDUpsxZYTMinRmF+nxUrR34BU8DM37BoYVAq6wx4qqqQ0jAPtzvrUgFohUmMNtlzB
         SndQ==
X-Gm-Message-State: AHYfb5i7qZIy6gq4z65rpEj2YuvZfQQ6xnwRTETGewwFVt2i9E2HNXkI
        PEfHmy8vDyiRhITDiqI6mMMbErCddbwyR7YTqQ==
X-Received: by 10.46.80.18 with SMTP id e18mr6191407ljb.23.1502466939414; Fri,
 11 Aug 2017 08:55:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.83.156 with HTTP; Fri, 11 Aug 2017 08:55:38 -0700 (PDT)
From:   Sam Partington <sam@whiteoctober.co.uk>
Date:   Fri, 11 Aug 2017 16:55:38 +0100
Message-ID: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
Subject: Bug when stashing previously-ignored file plus associated .gitignore change
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I'm running git 2.7.4 on Ubuntu 16.04.  I've found a couple of
problems when "un-ignoring" files in tandem with git stash.

Here's how to reproduce:

Say you have a project using git, with a .gitignore file which
contains the following line:

bin/*

You can then see the problems by doing this:

$ touch bin/mynewfile # this file will be ignored at this point

and then updating .gitignore to look like this (adding that second line):

bin/*
!bin/mynewfile

So far, so good; the new file is no longer ignored.

But now, try stashing the changes and including untracked files in the stas=
h:

$ git stash save -u

Here's the first problem, bin/mynewfile is still there:

$ ls bin/mynewfile
bin/mynewfile

But you'd expect it to not be there and be in the stash, I think.
This is what would normally happen with the untracked-files option for
git stash.

This leads to the second problem - you can't now pop the stash:

$ git stash pop
bin/mynewfile already exists, no checkout
Could not restore untracked files from stash

If you want to apply the stash, you have to remove the file:

$ rm bin/mynewfile
$ git stash pop # this works, and re-creates bin/mynewfile

This is quite an unusual edge case, but I have hit it two or three
times now and so thought it worth reporting, but I'll understand if
it's deemed not worth fixing!

Do let me know if you need any more information from me here.

Thanks
Sam

PS Sorry for the lack of formatting - I'm sending this as plain text
as my original HTML emails was rejected as possible spam by your
mailserver.

Sam Partington
Senior Developer

www.whiteoctober.co.uk
Office: +44 (0)1865 920 707

This email message and any attachments are confidential and solely for
the use of the intended recipient. If you are not the intended
recipient, you have received this message in error. Please notify us
immediately and delete the message from your computer. You should not
distribute, copy or disclose its contents to any other person. Any
views or opinions expressed in this email are solely those of the
author and do not necessarily represent those of White October
Limited. White October is a private limited company registered in
England & Wales under registration number 3982889. The company=E2=80=99s
registered office is at 264 Banbury Road, Oxford, OX2 7DY.
