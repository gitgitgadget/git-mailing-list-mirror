Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B405C5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09AF2222A
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 14:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=patrickstevens.co.uk header.i=@patrickstevens.co.uk header.b="RQ6MHnmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKTOVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 09:21:47 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:52852 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgKTOVr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 09:21:47 -0500
Date:   Fri, 20 Nov 2020 14:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=patrickstevens.co.uk; s=protonmail; t=1605882103;
        bh=s6GmLdR1AiTQtVAkTJBzIhOcIAXqVhIl2TbFy+y8uUE=;
        h=Date:To:From:Reply-To:Subject:From;
        b=RQ6MHnmhjZHB/ph6Lw7/0ECq2lY53W7Ve4e+Rg3mF5CxO5IqwGVYugQRKjob4in4K
         b1m6CZVdGQ/Ej76JDR75r+4JJIsFdznG/nQU6kLgswBesOLvBg78yT6Id4L1G/8HpP
         5uMr1WvnNv5zg0um5i3K6a9rDesPnZKAkijTY6Rs=
To:     git@vger.kernel.org
From:   Patrick Stevens <patrick@patrickstevens.co.uk>
Reply-To: Patrick Stevens <patrick@patrickstevens.co.uk>
Subject: Bug report: git apply --cached --reject
Message-ID: <31599b45-cf4e-be77-22bb-8fa03f0a52d6@patrickstevens.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Below the fold is a `git bugreport`-generated report of a bug with `git
apply --cached --reject`, which I have reproduced in three different
environments. Summary: we do not correctly stage the removal of a file
if there is also an unrelated change that cannot be applied.

I don't think this behaviour is intended; in the report I give a couple
of variations which correctly do what I expected, and this one breaks
the semantics I expect, given the behaviour of those variations. I have
not tried to find the source of the bug.

Thanks,
Patrick Stevens

---

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Complete reproduction instructions:

```
mkdir badrepo && cd badrepo && git init
echo "start" >> file.txt && git add file.txt && git commit -m "Initial
commit"
git tag initialcommit
echo "another" >> another.txt && git add another.txt && git commit -m
"Something else"
git tag commit2
git rm another.txt && git rm file.txt && git commit -m "Remove both"
git tag commit3
git checkout initialcommit
git diff commit2 commit3 | git apply --reject --cached
```

What did you expect to happen? (Expected behavior)

We should be left detached at tag `initialcommit`, with the working copy
clean (i.e. containing only `file.txt`), and with the deletion of
`file.txt` staged.

What happened instead? (Actual behavior)

The final `git apply` correctly leaves us detached at tag
`initialcommit`, with a clean working copy, but incorrectly the deletion
of `file.txt` is not staged: the index is also clean.

What's different between what you expected and what actually happened?

The file `file.txt` should have had its deletion staged, because this is
part of the diff which could apply cleanly.

Anything else you want to add:

If I delete the `--cached` from the last line, the right thing happens:
the working copy has `file.txt` deleted in the working copy but the
deletion is not staged.
If instead I remove the `git rm another.txt`, then similarly the right
thing happens: now we end up with the deletion of `file.txt` staged (but
the working copy is correctly unchanged).

I have reproduced this using git version 2.24.1.windows.2, as well as
2.29.2 built on Windows using the WSL and invoked through WSL, as well
as from the Mac HomeBrew install where I produced this bug report.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.29.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 18.7.0 Darwin Kernel Version 18.7.0: Mon Aug 31 20:53:32
PDT 2020; root:xnu-4903.278.44~1/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.0 (clang-1100.0.33.17)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


