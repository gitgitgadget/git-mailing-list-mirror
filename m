Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B05C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbhLETGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbhLETGj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 14:06:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A3C061714
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 11:03:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y196so6508558wmc.3
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=woCvfZqswmgkxxSRbPi88bk+pTKsT2cljDLSNLT21/k=;
        b=JWD+qA4kzBjheTqVviGPaL2QiPEqxiOqSwaHdTG0ibUZsi8LjwGmB5M2AuPOgnljBx
         JmhDIgKx9cUUzo/wXBp/i8gkw42RVLl3vIcHUYF11ZRrJbNeGwKqIK3gNAHxGk0jn2e4
         i62+Fv8jufrghE4tNTF6x1m6pxyBWzo+lKH4i2fFR+u8BP/uhSnCNjEuJpRX4sGQqjtu
         fRCDEto/kfeJg+T4SkF90oboE+lNkgiJ2iZDgJP1he5rI1E3uM7HFeDcegnx0urblOUr
         qTtfAEt4+keM3nNSjs/hYHCV5xMTjvlWAcAisINx1VUU1S29+DAugrcqda6WWInVwDAo
         V9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=woCvfZqswmgkxxSRbPi88bk+pTKsT2cljDLSNLT21/k=;
        b=gigN8zIVmcENhmJl5Jd4X+lycs+cXOaJROQ1ATLcRXmJF8O05L7vU0pKCd0prElSlZ
         sbRjyKcf0epek6vFd0FPMokO7rh1TtnVnMTmIxoATtVsEuSHLkUxVC874XYycdJJjHrs
         QEVWPw44PLdUOtQ3KcpA6NIUzFlSIL6u1ZWhtGuBBdWFV7uxyUq9F+s71auOhm6Zj4lE
         J26gnMcj6MUiLu7GOLJRgqFIbcfF9lVsvkvSaCkdNZQQkZ0Kdeqn7uRYbnuxsD9w5n6I
         Qm12YsUSluAPdpUFqgDCbyvnIUfekgZwS37bnY2kUq7iLPbafuWswzyQHPn6qTMIlStP
         Upsw==
X-Gm-Message-State: AOAM533UMquT6FTpUU43euxRJ1Zd0OQmmNtvRMEdNEBWjYiO9n/SgJDm
        DEjIOi49l6+iIq6v6nXhZikrAFC+a6t3qQ==
X-Google-Smtp-Source: ABdhPJw4UlLJgdFqoKqzBAbTusHq2+hzFTg+gAlgOnnAijJjPYBLuI/ZEM/FIQ7IT7Ua4eEhi/Ek+A==
X-Received: by 2002:a05:600c:3788:: with SMTP id o8mr31983254wmr.82.1638730989441;
        Sun, 05 Dec 2021 11:03:09 -0800 (PST)
Received: from smtpclient.apple (97e1ccf3.skybroadband.com. [151.225.204.243])
        by smtp.gmail.com with ESMTPSA id d2sm9128964wmb.31.2021.12.05.11.03.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Dec 2021 11:03:09 -0800 (PST)
From:   Anastasios Andronidis <anastasios.andronidis@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Git stash pop with untracked files doesn't unpack untracked if a
 conflict happens
Message-Id: <52179A8B-CAA8-4729-9BD6-C297CD00BF08@gmail.com>
Date:   Sun, 5 Dec 2021 19:03:07 +0000
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear team,

I want to report some weird behaviour regarding git stash pop and =
untracked files committed with git stash -u. See the git report below:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1) Created an empty git repo: `git init`
2) Created 1 commit with a single file: `echo "test" >test.txt && git =
commit -a -m "init"`
3) Made some changes in the file i committed + created a new file: `echo =
"test2" >test.txt && echo "test2" >test2.txt`
4) Used stash -u to save my changes: `git stash -u`
5) Created a second commit with a different change on the existing file =
in order to force a conflict: `echo "test3" >test.txt && git commit -a =
-m "2"`
6) I git stash pop to create a conflict between the second commit and my =
stash from my first commit: `git stash pop`

What did you expect to happen? (Expected behavior)

I was expecting to have 1 file in conflict stage and the untracked file =
to be created in my current working directory.

What happened instead? (Actual behavior)

The untracked file is missing.

What's different between what you expected and what actually happened?

The untracked file is missing.

Anything else you want to add:

N/A

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.1.0 Darwin Kernel Version 21.1.0: Wed Oct 13 17:33:23 =
PDT 2021; root:xnu-8019.41.5~1/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


Kindly,
Anastasios
Andronidis


