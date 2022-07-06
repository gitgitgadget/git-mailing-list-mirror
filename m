Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32083C43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 20:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiGFUlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiGFUlC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 16:41:02 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354381E3FF
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 13:41:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w193so21229546oie.5
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=includedhealth.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Iv9CVMXU8iGlGxteszo+HkVwDzBZf089SzUcYpPgYg0=;
        b=Eg0WWeadZ6N1jAfx12nqenp65uLFsao47S7YLeTF9ujHD324RZO7bPr+j3/6Xj66vt
         KSLziTPejHgvljTHsI/TbuwOIkbYJ5HoPRPJ+sILVocI4E1vytdQJZRVoxu0B6gvZWZD
         b+7sM1kOYTMPRpAihYmeDmEhEIXHb4MXyMRHvtYvi4s287YXDpFdOrCTQenAJxuoWJLn
         jYug9a3KUPnJEIhbkUIG02tyyogEJvlvydiRoY3erTE/9Wn3OzHqaSAgrtTY0dUsiH3b
         9ZbMjGtbvsAi/w+gerKQo75FHWHPptMN5HMU2dOTr2cTUHSJAt1NIwljPvQpJuvnVL5i
         trLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Iv9CVMXU8iGlGxteszo+HkVwDzBZf089SzUcYpPgYg0=;
        b=1V7ZDWvmyJ9yD8meucThoGi/aSevTv0Sx3cR5a63lY4Qu0LcfOc8Oa3lVRuo7rpZiy
         psB230p40gn1jSF2s/UmzQaCXkyVO/4gt22/CQUeHLoUfAweLoCQ35z9v8zodaLTlLQ5
         6ckgWNwYKjTdH3ST7LmrZghGPkrn5n+y5PakMh1O1EuqwPx1myLrcMUvVp6llke7btcS
         Z4tOIv6LqLg3TBMCJGOvdiWqCb6044TZpI4ocKkTHJeivxxBWKe38wAQX6uqedRsvIIX
         XTIVpnOyTEBQE3oNdzPxl6KAzNTME7CeQEkEJtgFFQaOqslI+2hica4VVZOwjRq1yzzj
         vEpw==
X-Gm-Message-State: AJIora85S4B+H6Yh51txo9g3qrup3dLQWi8Ahm5UzmHkPnMd/cdIqDY1
        S24ltlHAcqsEiD+GYGi+1pzTbSk2a/YpUNV5zuDW34FerUdxZg==
X-Google-Smtp-Source: AGRyM1vr/4Qm4/2vlhZbWq1hDS6SexxajW/YhFEKZLTpoWPD6HyLTqv8+aQsBdhM/QsOVmIyHKEY+m64ULDirD9KdTg=
X-Received: by 2002:aca:abc9:0:b0:335:796f:abba with SMTP id
 u192-20020acaabc9000000b00335796fabbamr300543oie.35.1657140061349; Wed, 06
 Jul 2022 13:41:01 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Zethraeus <adam.zethraeus@includedhealth.com>
Date:   Wed, 6 Jul 2022 13:40:45 -0700
Message-ID: <CAP4e5TNdvE1gmt9bERT5sL+D3r4Fbypk57KJJ+wYHD=M=T+uWA@mail.gmail.com>
Subject: bug report: pre-commit & pre-push hook output is redirected differently
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Installed identical pre-commit and pre-push hooks:

```
#!/bin/bash

>&1 echo "stdout"
>&2 echo "stderr"
exit 1
```

What did you expect to happen? (Expected behavior)

`git push` and `git commit` should have the same hook behavior.

What happened instead? (Actual behavior)

The pre-commit hook was run with stdout redirected to stderr but the
pre-push hook's output was unaltered.

```
> git commit -m "-" 1>/dev/null
stdout
stderr
> git commit -m "-" 2>/dev/null
> git commit -m "-" --no-verify
> git push 1>/dev/null
stderr
error: failed to push some refs to 'github.com:org/repo.git'
> git push 2>/dev/null
stdout
```

What's different between what you expected and what actually happened?

There was inconsistency in the behavior when I expected consistency.

Anything else you want to add:

```
> /bin/bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin21)
```

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:22
PDT 2022; root:xnu-8020.121.3~4/RELEASE_X86_64 x86_64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
pre-push
