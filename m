Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E1CC54EE9
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIPMu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIPMuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 08:50:55 -0400
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Sep 2022 05:50:49 PDT
Received: from smtp.tumbleweed.org.za (smtp.tumbleweed.org.za [IPv6:2001:470:c91e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9777AA9C30
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=rivera.za.net;
 i=@rivera.za.net; q=dns/txt; s=smtp-ed25519; t=1663332158; h=date :
 from : to : subject : message-id : mime-version : content-type : from;
 bh=WES/4qqqm3q2fdnvZ56NuFqlv6h6iiVld72czSX2azQ=;
 b=BiAbtFPHa7jiwqIKU1OXXTCcin5HlObKnSpDdD8f7ljr2TDRYJRsbRzKKCrxkA5KtLIIB
 OtEESeNpMbljrYzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rivera.za.net;
 i=@rivera.za.net; q=dns/txt; s=smtp-rsa; t=1663332158; h=date : from :
 to : subject : message-id : mime-version : content-type : from;
 bh=WES/4qqqm3q2fdnvZ56NuFqlv6h6iiVld72czSX2azQ=;
 b=imC2CM7K5NCPXbwXDjqqJVUf6OnGoiA2kR7gBKAUcnMePNr7JjFykbq4xIwE7vTKXZEMc
 QeBqPCFrbRK+PW0Y2wWdx16rYoMAYDhHSL7pWpkDurhfcD3JVciUzvvSOsAXf1pjUX4XL1W
 G5QPihb7fqpAz0xNignBR929Mq0gcc3x+nZT4JGI5nwuLCHMyWqmw2NUm0Lc4k/mErpYelR
 7C6RemUbCmP7DmwnSU5xiLsAnsvToy6oZZH3yAfqJf2tV2jikNyXHAhnJG1bhuD6QxZDxgb
 6bgULN0RHPH/2tqunGsrKJeHDrg1Or62qKcOt/1f7/kRlQUiGuietRRtOS0Q==
Received: from haydn.kardiogramm.net (102-65-159-205.dsl.web.africa [102.65.159.205])
        by smtp.tumbleweed.org.za (Postfix) with ESMTPSA id 4918F40009
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 12:42:38 +0000 (UTC)
Received: by haydn.kardiogramm.net (Postfix, from userid 1000)
        id 353783B358AC; Fri, 16 Sep 2022 14:42:34 +0200 (SAST)
Date:   Fri, 16 Sep 2022 14:42:34 +0200
From:   Stefano Rivera <stefano@rivera.za.net>
To:     git@vger.kernel.org
Subject: git rebase crash: merge-ort.c:2622:
 apply_directory_rename_modifications: Assertion `ci->dirmask == 0' failed.
Message-ID: <20220916124234.h57p67mwywzok23s@haydn.kardiogramm.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="c74pmcxmgbmb742k"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--c74pmcxmgbmb742k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, I got a crash in git-rebase, a failed assertion in merge-ort.c

$ git rebase renamed-parent
git: merge-ort.c:2622: apply_directory_rename_modifications: Assertion `ci->dirmask == 0' failed.

I was rebasing a branch that replaced a directory with a symlink, onto a
branch that renamed a parent directory of the modification.

Reproducer script attached.

Using --strategy=recursive avoids the crash, so it's a bug in ort.

Not subscribed, please CC me in replies.

Thanks,

SR

[System Info]
git version:
git version 2.38.0.rc0.373.g21cbab7515
cpu: x86_64
built from commit: 21cbab75150d71ca294e09180c59ee529ca53957
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.18.0-3-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.18.14-1 (2022-07-23) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]

--c74pmcxmgbmb742k
Content-Type: application/x-sh
Content-Disposition: attachment; filename="reproduce.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Aset -eufx=0A=0A# rm -rf repo=0Agit init repo=0A=0Acd repo=0A=
git checkout --orphan main=0Amkdir -p dir/subdir=0Aecho 1 > dir/subdir/file=
=0Agit add dir=0Agit commit -m "Initial commit"=0Agit checkout -b renamed=
=0Agit mv dir renamed-dir=0Agit commit -m "Rename directory"=0Agit checkout=
 main=0Agit rm -r dir/subdir=0Amkdir dir=0Aln -s /dev/null dir/subdir=0Agit=
 add dir/subdir=0Agit commit -m "Replace with symlink"=0Agit rebase renamed=
=0A# succeeds:=0A# git rebase --strategy=3Drecursive renamed=0A
--c74pmcxmgbmb742k--
