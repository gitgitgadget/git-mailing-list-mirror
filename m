Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A20EC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 07:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJUHwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJUHw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 03:52:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B257E23B6BE
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 00:52:25 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b25so1540162qkk.7
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=statystyka-net.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/U9mT86Uk6VX6PXRpZkgW5BShmIaaPtqEag1gKqy6s=;
        b=fj75pUSZtYzErYzGGDEN1QqSuV3s6AfXFyML+rJ2w9SPnc+3Xm7A0KhQZzL17pgAoJ
         9jfYHStptaZhS/0tafxD9rexqqe9/uuhyoDxrIjTsH+3oIWxRKfRbF0jbXAStr7SigTQ
         jaFBy+hY+YSBqJGzAWKRu7rC3y9jCD+GiVYUc7hTtz9coSJ94jOzD/nUrJ7pUbnJaLcE
         u13kqJf6Pxa9EfythhQkM1Xt8qyOnAFJacRm+oBFX7GK68JhcvUltpW/WSwnfUtzcz86
         GWJC0MUmLFn/u733TPA4rjf72EiJDEUA8Af/nPm7Tmx2N7H1d+XT0Qme/67P2oGyoRFm
         VJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/U9mT86Uk6VX6PXRpZkgW5BShmIaaPtqEag1gKqy6s=;
        b=FWRoX3RqKHgvgDvNXgTAZBAo1Dn4DpxRY+oCqrDk/EvLZch5Yx9+1Go215L6fFlt23
         krg3gPb3eXV+Jgm8zpSSaylGDq4TF894tBSU4yEoM4wA6hzGR+4X0SfzeFGW2fNPNexE
         56VpxntMeETmoWtCeFD/XQcfiZ+0QQPpDdKabK6+yTMkA2JnB1ZR5XmnXqDTOW06ZvD8
         t6FSNMYv66oeT9QRQLbVyG7S6cHwbelUawS4arWwtEyrGey7oP9KPPjeDk6UdzmN5+0a
         /jom8s1VLftLQ6aCCPSUQz2XTlz/nogX1jnxjU1enDS8fJmKmkjpAk48cDoXEK/6Qyk3
         JsKg==
X-Gm-Message-State: ACrzQf1fonA57RHbtlCiCwZeiAWWGbVNDN9F6QOCFTUVwiKejBz5msw1
        KRaf4/cW/E2gas/bAZIF5MYYruSVZsVyuAc76SDjKh8L1YjtOUzI
X-Google-Smtp-Source: AMsMyM7fVJb/S9b3FH+rfPVxLzT1NrT2gTo1BdY1yDpCg9kbCEJvnPSSA8IztT/zS0VmZwL57i6OSsAjkXtzM3wPdh8=
X-Received: by 2002:a05:620a:254e:b0:6c7:855c:6eb with SMTP id
 s14-20020a05620a254e00b006c7855c06ebmr12901694qko.39.1666338744487; Fri, 21
 Oct 2022 00:52:24 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ryczkowski <adam.ryczkowski@statystyka.net>
Date:   Fri, 21 Oct 2022 09:52:13 +0200
Message-ID: <CAEjZQXRsMaRYrskmpn5zBCrOt3xNOZ5shoVG82kjS7A3MZQtUQ@mail.gmail.com>
Subject: Soft bug: No chance to sign synthetic commits when using git subtree External
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I build a complex project "Monorepo" in an environment that mandates
code signing and monorepository philosophy. In my project I built
several multi-purpose libraries. I track changes to those libraries in
a separate (local) repository, and use git subtree to merge them with
the Monorepo.

Git does not have an option to sign the synthetic commits it generates
when merging and pulling (and does ignore a policy `commit.gpgsign =
true` in `.git/config` present in all repositories that are involved).
It is not that bad in `git subtree pull`, because I can do `git commit
--amend -S --no-edit` on the last commit in the Monorepo, if I find
that the `git subtree pull` added a new commit.

The problem is with `git subtree push`, because it can add more than
one commit on a single invocation, forcing me to edit the history.

Do you confirm this is an inconvenience bug (not a bug in the sense
that I get the repository corrupted)?

I use git 2.38.1 on Ubuntu 20.04 64 bit

Steps to reproduce:

1. In the empty directory, in my example `/home/adam/gitbug`, create
the Monorepo:

```
git init monorepo
```

2. Modify the `monorepo/.git/config` and add user's signing key and
`commit.gpgsign=true`
```
[user]
signingkey = 1234561234567890
email = adam@statystyka.net
[commit]
gpgsign = true
```

3. Add a first commit and verify it gets signed.
```
cd monorepo
git commit -m "Initial commit" --allow-empty
git log --show-signature
cd ..
```

4. Create a feature library "lib1":
```
git init lib1
```

5. Modify the `lib1/.git/config` in a similar way as in Monorepo (step
2) and add `receive.denyCurrentBranch=
updateInstead`
```
[user]
signingkey = 1234561234567890
email = adam@statystyka.net
[commit]
gpgsign = true
[receive]
denyCurrentBranch = updateInstead
```

6. Add a first commit to lib1. Verify it is signed.
```
cd lib1
touch library_code.py
git add library_code.py
git commit -m "Initial commit in lib1"
git log --show-signature
cd ..
```

7. Add lib1 as a subtree repository for Monorepo. Bug #1: The
signature of the subtree split commit IS NOT signed in the Monorepo.
```
cd monorepo
git remote add lib1 "/home/adam/gitbug/lib1"
git subtree add --prefix lib/lib1 lib1 master
git log --show-signature

Merge: 6f06087 cef349f
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 09:35:27 2022 +0200

    Add 'lib/lib1/' from commit 'cef349f0c89b7a506a5558750310d4cb3dc1f307'

    git-subtree-dir: lib/lib1
    git-subtree-mainline: 6f06087ac3d45d18d0651717388906902d6fa74b
    git-subtree-split: cef349f0c89b7a506a5558750310d4cb3dc1f307

```


8. Sign the signature with git amend, and verify all the commits are signed:
```
git commit -S --amend --no-edit
git log --show-signature
cd ..
```

9. Make a commit in lib1 and verify all the commits are signed:
```
cd lib1
echo "First line of code" >> library_code.py
git commit -S -am "Adds first line of code"
git log --show-signature
cd ..
```

10. Pull the changes in the lib1 to the Monorepo and verify all the
commits are signed:
```
cd monorepo
git subtree pull --prefix=lib/lib1 lib1 master
git log --show-signature
```

11. Modify the lib1 from inside the Monorepo and push the changes to
the subtree repository:
```
echo "Another line of code" >> lib/lib1/library_code.py
git commit -S -am "Adds another line of code"
git log --show-signature
git subtree push --prefix=lib/lib1 lib1 master
cd ..
```

12. Bug #2: In the lib1 the added commit "Adds another line of code"
added by the `git subtree push` IS NOT signed:
```
cd lib1
git log --show-signature
```

13. We need to walk around this bug otherwise the `git subtree pull`
will merge UNSIGNED commits.
```
git commit -S --amend --no-edit
git log --show-signature
cd ..
```

14. Go back to the lib1 and subtre pull the last subtree push we did,
otherwise our subsequent subtree push would end with `error: failed to
push some refs to '/home/adam/tmp/gitbug/lib1`. If we hadn't manually
signed the last commit in lib1, this would pull that unsigned commit
and cover it with ANOTHER unsigned commit caused by git subtree pull.
```
cd monorepo
git subtree pull --prefix=lib/lib1 lib1 master
git log --show-signature
```

15. Make a _second_ push to the lib1.
```
echo "Third line of code" >> lib/lib1/library_code.py
git commit -S -am "Adds third line of code"
git log --show-signature # All is signed as expected
git subtree push --prefix=lib/lib1 lib1 master
cd ..
```

16. Go to the lib1 and see a total mayhem: Three unsigned commits:
```
cd lib1
git log --show-signature
```
First two commits and a commit `2de16` are unsigned... The only way of
fixing it is to do rewrite the history:


```
commit b3c5429d2b3f7f4a3643bd577d1c4fd458238a22
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 12:43:18 2022 +0200

    Adds third line of code

commit 53f1d874c542731b7fbb928877034332b57cc6e9
Merge: 2de16ea d80a03e
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 12:42:51 2022 +0200

    Merge commit 'd80a03ef0c1a82e29d94d89c8d7bd1d3f40e8691'

commit d80a03ef0c1a82e29d94d89c8d7bd1d3f40e8691
Primary key fingerprint: C076 B904 25BB FE0B 2718  697B 519B A799 293A 0D76
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 12:42:14 2022 +0200

    Adds another line of code

commit 2de16ead1752dc661904099c34f6b09f495faa94
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 12:42:14 2022 +0200

    Adds another line of code

commit 3d80e8b60eb65378e78fc1bf88e5eed2da703dab
Primary key fingerprint: C076 B904 25BB FE0B 2718  697B 519B A799 293A 0D76
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 12:42:00 2022 +0200

    Adds first line of code

commit cef349f0c89b7a506a5558750310d4cb3dc1f307
Primary key fingerprint: C076 B904 25BB FE0B 2718  697B 519B A799 293A 0D76
Author: Adam Ryczkowski <adam@statystyka.net>
Date:   Thu Oct 20 09:34:57 2022 +0200

    Initial commit in lib1
```

Adam Ryczkowski
