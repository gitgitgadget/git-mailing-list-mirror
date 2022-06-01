Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B4EC433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 12:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiFAMwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiFAMwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 08:52:47 -0400
X-Greylist: delayed 746 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 05:52:43 PDT
Received: from h3.fbrelay.privateemail.com (h3.fbrelay.privateemail.com [131.153.2.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23FF4E38A
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 05:52:43 -0700 (PDT)
Received: from MTA-06-3.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 167E01800C97
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:40:17 -0400 (EDT)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id C036318000B3
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:40:15 -0400 (EDT)
Received: from mail-wr1-f51.google.com (unknown [10.20.151.169])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 9C1C318000AF
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:40:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gfxmonk.net;
        s=default; t=1654087215;
        bh=pa6YyQXk6Ei6QlvW7o45Szq7BJXMDNhZg1hjio+bfTE=;
        h=From:Date:Subject:To:From;
        b=UcCJJ5q7WWIT3955gFIAh1Xj58V2V6sjFL9QXovtnVbmbwJYWxD5A4Qm81Uqstdvp
         ztEii5T6TekIYeTmnwtXlSWxJQ5GhrgaQNpnQ+QixKofKNAuk/pW076zicLHXWyKGk
         Cd38Jtwt4eJlCVSVFjdE0fAwuD6UYtdC9A/ikp3Etb4e58gjpqCiJn6RcKLU/qhE6y
         fTU9LlW1qnYtN1Kh/HzW0mMs4x91i6PkwQgjUVAnOgeAaWzcH3yoeYVKM1pZSKDEqN
         EPtz2DYdNN3ptlW9hNmSH6Bbao5MuJCrw4pPqMRs1TLSn18ty8N0oWv9pjFXHexqv5
         ex0TORbEkGtCQ==
Received: by mail-wr1-f51.google.com with SMTP id h5so2221568wrb.0
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 05:40:15 -0700 (PDT)
X-Gm-Message-State: AOAM533omy4DNP1Jk2tElmc3DJ0oKUB8jU0FtN5YH7Vw+ZFSUMeNIOA7
        BAEeqeTXe2UceSJQ6el5dkX9pvbRMCCJ0+FANQ0=
X-Google-Smtp-Source: ABdhPJxDQQlUDBe0cvQa893rv8ipzqXGR71NDIbTRXlnGYXT8La93HdCbxwmPTBZIvpHoTzf9sU3aHZvJhFNL+TobRU=
X-Received: by 2002:a05:6000:1f87:b0:20f:fe12:acae with SMTP id
 bw7-20020a0560001f8700b0020ffe12acaemr29843082wrb.175.1654087210230; Wed, 01
 Jun 2022 05:40:10 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Cuthbertson <tim@gfxmonk.net>
Date:   Wed, 1 Jun 2022 22:39:53 +1000
X-Gmail-Original-Message-ID: <CAC-LLDiu9D7Ea-HaAsR4GO9PVGAeXOc8aRoebCFLgDKow=hPTQ@mail.gmail.com>
Message-ID: <CAC-LLDiu9D7Ea-HaAsR4GO9PVGAeXOc8aRoebCFLgDKow=hPTQ@mail.gmail.com>
Subject: [bug] docs claim git fetch --deepen doesn't fetch tags, but it does
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs for git fetch `--depth` say:

> Tags for the deepened commits are not fetched.

And shallow.txt says:

> - If you deepen a history, you'd want to get the tags of the
> newly stored (but older!) commits. This does not work right now.

However it seems like this has been implemented, and the corresponding
docs should instead declare that tags for the fetched commits are
fetched. It certainly looks that way from my testing:

```
$ git --version
git version 2.32.1 (Apple Git-133)

$ git clone --depth=1 https://github.com/git/git
Cloning into 'git'...
# < ... >

$ cd git

$ git describe --tags --always
1bcf4f6

$ git fetch --deepen 8
# < ... >
Unpacking objects: 100% (12/12), 9.02 KiB | 9.02 MiB/s, done.
From https://github.com/git/git
* [new tag] v2.31.3 -> v2.31.3
* [new tag] v2.32.1 -> v2.32.1
* [new tag] v2.32.2 -> v2.32.2
* [new tag] v2.33.2 -> v2.33.2
* [new tag] v2.33.3 -> v2.33.3
* [new tag] v2.34.1 -> v2.34.1
* [new tag] v2.34.2 -> v2.34.2
* [new tag] v2.34.3 -> v2.34.3
* [new tag] v2.35.1 -> v2.35.1
* [new tag] v2.35.2 -> v2.35.2
* [new tag] v2.35.3 -> v2.35.3
* [new tag] v2.36.0 -> v2.36.0

$ git describe --tags --always
v2.35.3-35-g1bcf4f6
```

(I get the same results using `git clone --depth` or `git fetch --depth`)

It'd be good to have someone who understands the code confirm this
(and what version it was implemented, in case it's accidental, or
doesn't always work as expected.

I found a stackoverflow from a couple years ago implying this didn't
work at the time, though it doesn't say what git version they were
using:
https://stackoverflow.com/questions/56477321/can-i-make-git-fetch-a-repository-tag-list-without-actually-pulling-the-commit-d
