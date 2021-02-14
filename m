Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA8C433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 09:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9A064E12
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 09:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBNJ1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 04:27:48 -0500
Received: from hh.christian-wolf.click ([109.90.47.193]:57116 "EHLO
        hh.wolf-stuttgart.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNJ1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 04:27:43 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2021 04:27:42 EST
Received: from cwolf-work.localnet (p5ddd54a9.dip0.t-ipconnect.de [93.221.84.169])
        by hh.wolf-stuttgart.net (Postfix) with ESMTPSA id A33D7C006B
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 10:18:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=christian-wolf.click;
        s=202006; t=1613294314;
        bh=0RdFPpQGJ/HVifsTr8HyBofdHeLPPvf1osGr/Kuyi6w=;
        h=From:To:Subject:Date:From;
        b=NiaPuaGNMB07B0az1Z08rpuSJ5Tx01CmkfW96FyumtNbDZhz5KnYeMu0AoQQXoLda
         35bz7w+wfvPbvRK3xNj56vAx0brGfbJvvZP41syrEWidCT/lHVTr9PqPTtvvVngUMn
         Ad2uoqNdOV6VyLEzNz0WI0UVSxT5BLNHckp7C728=
From:   Christian Wolf <account+git@christian-wolf.click>
To:     git@vger.kernel.org
Subject: Bug report: git remote prune does not take negative refspecs into account
Date:   Sun, 14 Feb 2021 10:18:34 +0100
Message-ID: <1729665.CpSNW4ODmt@cwolf-work>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I found an issue with git and wanted to report this. Here is the filled res=
ult=20
from `git bugreport` (sorry for the intermixed German, but I think the Engl=
ish=20
statements should suffice to understand the issue).

Vielen Dank f=FCr das Ausf=FCllen eines Git-Fehlerberichts!
Bitte antworten Sie auf die folgenden Fragen, um uns dabei zu helfen, Ihr
Problem zu verstehen.

Was haben Sie gemacht, bevor der Fehler auftrat? (Schritte, um Ihr Fehler
zu reproduzieren)

1. I have configured a remote `upstream` with a refspec like `+refs/heads/
*:refs/upstream/heads/*`.
2. I have fetched remote `upstream` fetching two branches `foo` and `bar`.
3. I add another line to `.git/config` with a negative refspec
```
fetch =3D ^refs/heads/bar
```
4. I called `git fetch upstream` and `git remote prune upstream`.
5. Remove the refspec from step 2 in `.git/config` with some arbitrary name=
s=20
(e.g. `+refs/heads/baz:refs/upstream/heads/baz`), keep the negative refspec=
 as=20
it is
6. Fetch and prune (see step 4)
7. Undo step 5 and restore the original state as after step 3
8. Fetch and prune (see step 4)

Was haben Sie erwartet, was passieren soll? (Erwartetes Verhalten)
Expected behavior:

After the fetch in step 2 both branches are mirrored locally.

After the prune in line 4 the branch `bar` is dropped from the remotely=20
fetched branches.

After step 6 both both remote branches `foo` and `bar` are no longer visibl=
e.
A possible error about unmatching branch `baz`.

After step 8 again a remote branch `foo` is existing.

Was ist stattdessen passiert? (Wirkliches Verhalten)
Real behavior:

After step 2: As intended

After step 4: Both remote branches are still visible. Nothing is pruned.

After step 6: Both remote branches are gone.

After step 8: Only `foo` is existing/fetched as remote branch.

Was ist der Unterschied zwischen dem, was Sie erwartet haben und was
wirklich passiert ist?
The difference of real and ideal behavior:

The difference is that after step 4 the remote branch `bar` is not pruned.

Sonstige Anmerkungen, die Sie hinzuf=FCgen m=F6chten:

The steps 5~8 are there to verify the negative pathspec is working in gener=
al.
=46etching freshly takes the negativbe pathspec into account.

So the problem is within the pruning code.

[System Info]
git Version:
git version 2.30.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.10-arch1-1 #1 SMP PREEMPT Sat, 23 Jan 2021 23:59:48 +0000=
=20
x86_64
Compiler Info: gnuc: 10.2
libc Info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Aktivierte Hooks]

Thank you for looking into this.
Christian


