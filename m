Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD510C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 18:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbiAESWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbiAESWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 13:22:37 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27400C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 10:22:37 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so268591oti.11
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boostpro-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Xa+YJo79J7SNLQmJ6vl6t0QGqUDI5REVQ4udzEakkKM=;
        b=7xovnyBbJl6xnlWJjI3GVgW/b9U3pTkblanzN6JGZ4JIXzCzLI/DsFkBJD0ZSzQOoj
         Tia0lwa+Z0A/TK3/vgXRxXwnryDspoBjMwBo/+c+OOCtSSDY1hnaroJ74vOmJWYfoitn
         UQotz70MUoyHYBPExxLYp15B+ti14YUcWv/MqPVF1GH4Eg7SFc4KwOHiqFV2Mdwjvzob
         Otkl5wl2QZBJ8EScEXOualnlkLWELly6QYjwF+6YZuvcJaUIiD6jJpo9E3Y9dX0EDuc0
         ecqyDkhBuIx3yFc/8SwnzU8sqLtkFyXz/nmX7FbvHpC27MvH5twjxv0tWFD6Wm8hgDvj
         jIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Xa+YJo79J7SNLQmJ6vl6t0QGqUDI5REVQ4udzEakkKM=;
        b=QOourUiygp66L3kNkRFv/n2AGWoWrK5Q1y0Y9G4QCNxO042v07ny+IKyuFUXsvzTXW
         jlCogYAhcTj9e0heu4OWQiViWYgO78F+KCiGfz8v/pndmfezPOSkzIadEGpNhy4wUgml
         Y3jifxjcOLxsId+oZ4HonQjcxfU765tnReTUyn/gAXXyq2zPJYuavIuvkezCFKJB9whj
         tdx1kIuXfJ/sQ30AoLPR+ylaSnfRB8wZ0GhlMaB3QVStd9mdJZm879Oqyn+iAcMD3YGO
         /Ungc2Y7BLJ1XfxeF+P68FbLSGfDqxLejFDaUivHFwYnONpFcfMMDjKLYCRfrkZGxOgw
         UUNw==
X-Gm-Message-State: AOAM532zV4lB6hhfOe7+8yBelqHeJsDxvGMVts+MbjLSkBZWzA7jdlj1
        ywJHGVXQyPIYXpJi8hppBKAD0QkhSkX1D2wD
X-Google-Smtp-Source: ABdhPJxPgDbmkbZtyf93xKjnuIVNBOFGlnylVMHn6kJ7MbQBntC/EqYMbNgXFAcPPR9k7jo+v73mWQ==
X-Received: by 2002:a05:6830:1e25:: with SMTP id t5mr41608059otr.291.1641406955641;
        Wed, 05 Jan 2022 10:22:35 -0800 (PST)
Received: from smtpclient.apple (69-209-31-205.lightspeed.sntcca.sbcglobal.net. [69.209.31.205])
        by smtp.gmail.com with ESMTPSA id v41sm8205851ooi.0.2022.01.05.10.22.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 10:22:35 -0800 (PST)
From:   Dave Abrahams <dave@boostpro.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Apparent interaction between recursive submodule push and
 self-submodules
Message-Id: <8FFD3227-2811-486C-A305-90C4988A0A1A@boostpro.com>
Date:   Wed, 5 Jan 2022 10:22:34 -0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In your .gitconfig, have
  [submodule]
	recurse =3D true

Then follow this script:

```
$ mkdir x
$ cd x; git init
Initialized empty Git repository in /private/tmp/x/.git/
$ touch a
$ git add a
$ git commit -m 'initial'
[main (root-commit) 0afd184] initial
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
$ cd ..
$ git clone x y
Cloning into 'y'...
done.
$ cd y
$ git branch -c b
$ git submodule add ../x self
Cloning into '/private/tmp/y/self'...
done.
$ git submodule update --init
$ git push origin HEAD:refs/heads/b
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To /private/tmp/x
 * [new branch]      HEAD -> b
$ cd self
$ echo 'first change' >> a
$ git commit -a -m 'first change on main'
[main 80466da] first change on main
 1 file changed, 1 insertion(+)
$ cd ..
$ git add .gitmodules self
$ git commit -m 'update to point at new submodule'
[main 4f5a1b7] update to point at new submodule
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 self
$ git push origin HEAD:b
Pushing submodule 'self'
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Writing objects: 100% (3/3), 252 bytes | 252.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /private/tmp/x
   0afd184..80466da  HEAD -> b
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 10 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 357 bytes | 357.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
remote: error: cannot lock ref 'refs/heads/b': is at =
80466da48f71630dc87553ca75e216cf6f1dfda9 but expected =
0afd18466f353590ae52219e32a712691a59b60b
To /private/tmp/x
 ! [remote rejected] HEAD -> b (failed to update ref)
error: failed to push some refs to '/private/tmp/x'
$
```

What did you expect to happen? (Expected behavior)

No error

What happened instead? (Actual behavior)

See error above.

What's different between what you expected and what actually happened?

Anything else you want to add:

If I do this with a repository cloned via ssh and a submodule cloned via =
https,
I get a different error:

```
$ git push -v origin refs/heads/gh-pages\:refs/heads/gh-pages
Pushing to github.com:stlab/adobe-reveal-theme
fatal: bad object f7cc6f9014af46fb9cfcaae26b82ac830593df6d
error: remote unpack failed: eof before pack header was fully read
To github.com:stlab/adobe-reveal-theme
 ! [remote rejected] gh-pages -> gh-pages (failed)
error: failed to push some refs to 'github.com:stlab/adobe-reveal-theme'
```

The issue appears to be an interaction between recursive submodule push =
and the fact
that the submodule comes from the same repository as its super-module.

[System Info]
git version:
git version 2.32.0 (Apple Git-132)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.2.0 Darwin Kernel Version 21.2.0: Sun Nov 28 20:28:41 =
PST 2021; root:xnu-8019.61.5~1/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.0.0 (clang-1300.0.29.30)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show

