Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C1C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhLHRnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:43:39 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:17737 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhLHRni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:43:38 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2021 12:43:37 EST
Received: from [209.85.167.54] (helo=mail-lf1-f54.google.com)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <deniz@code.bahadir.email>)
        id 1mv0ol-0006XW-Kg
        for git@vger.kernel.org; Wed, 08 Dec 2021 18:33:23 +0100
Received: by mail-lf1-f54.google.com with SMTP id l22so6994478lfg.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 09:33:22 -0800 (PST)
X-Gm-Message-State: AOAM531mjL7B5ev14o917vHZzs4VU8KPQe5ggofISIFLM6w9VQUEC4+J
        pEOtIDjU/Kb+xpsd/wq4TYRN8cZXO2nRIPAMJ/w=
X-Google-Smtp-Source: ABdhPJxtLfis8+KSnxVB1w6tK2S/pLJ116LjKcdQqdSgBbA+5kTGhHGXB8v3OJb3hfgBRPlh5heHr+6niofOMMlLwUk=
X-Received: by 2002:a05:6512:130d:: with SMTP id x13mr793101lfu.466.1638984802256;
 Wed, 08 Dec 2021 09:33:22 -0800 (PST)
MIME-Version: 1.0
From:   Deniz Bahadir <deniz@code.bahadir.email>
Date:   Wed, 8 Dec 2021 18:32:56 +0100
X-Gmail-Original-Message-ID: <CAFhJ7yv4F6gwXh3PgKaYQGOcAq7ryqVhXhGdBTBjGRScHUo9=A@mail.gmail.com>
Message-ID: <CAFhJ7yv4F6gwXh3PgKaYQGOcAq7ryqVhXhGdBTBjGRScHUo9=A@mail.gmail.com>
Subject: git apply: Not reliably working as `patch` replacement when `.git`
 file/directory exists
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Df-Sender: ZGVuaXpAY29kZS5iYWhhZGlyLmVtYWls
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git developers,

thank your for that great developer tool!
I noticed a behavior with git apply which I assume is a bug. So I am
going to report it here.

Thanks for reading,
Deniz Bahadir


## What did you do before the bug happened? (Steps to reproduce your issue)

1. `git clone` a Git repository which contains a Git submodule.
2. Initialize the submodule by using `git submodule update --init`.
3. Change into that Git submodule directory and create a patch for a
   file in it.
   (Note: Here we assume the directory is called `submodule` and the
   to-be-patched file is called `file.txt`.)
   ```
   cd submodule
   echo "extra-tokens" >> file.txt
   git diff -u file.txt > file.txt.patch
   git checkout file.txt
   ```
4.a) Copy the directory of this Git submodule into another directory
     which itself is not located in or beneath a directory under Git
     control.
4.b) Same as 4.a) but additionally remove the `.git` file in that
     copied directory.
4.c) Rename the directory of this submodule but do not inform Git
     about it (e.g. do a `mv submodule submodule_renamed`).
4.d) Same as 4.c) but additionally remove the `.git` file in that
     moved directory.
5. For each directory created under step 4 change into it and run:
   ```
   git apply --unsafe-paths -v file.txt.patch
   ```


## What did you expect to happen? (Expected behavior)

I expected all four different scenarios to succeed and to successfully
patch `file.txt` in step 5.


## What happened instead? (Actual behavior)

Case 5.a) fails with the following message:
```
fatal: not a git repository: /tmp/submodule/../.git/modules/submodule
```

Case 5.b) succeeds with the following message:
```
Checking patch file.txt...
Applied patch file.txt cleanly.
```

Case 5.c) fails with the following message:
```
fatal: cannot chdir to '../../../submodule': No such file or directory
```

Case 5.d) fails with the following message:
```
Skipped patch 'file.txt'.
```


## What's different between what you expected and what actually happened?

I would have expected that option `--unsafe-paths` allows me to patch
any file using `git apply` not matter where the directory is located
and whether there is a `.git` file or directory in any of its parent
directories or not.
That would have allowed me to use `git apply --unsafe-paths` as an
alternative to `patch` (which might not be available on all platforms)
as written on `git apply`'s man page.


## Anything else you want to add:

Alternatively, maybe it would be better if `git apply` provides an
extra option `--simulate-patch` or something similar which really
works as a `patch` replacement in all situations (and does not
consider `.git` files or directories at all).


## Additional system info.

[System Info]
git version:
git version 2.33.1.windows.1 and 2.25.1 (ubuntu)
cpu: x86_64
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
