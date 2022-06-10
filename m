Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B0C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 22:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbiFJWTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiFJWTe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 18:19:34 -0400
Received: from mx-out2.deshaw.net (mx-out2.deshaw.net [149.77.95.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89831220
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 15:19:33 -0700 (PDT)
Received: from mx-relay2.deshaw.net (localhost [127.0.0.1])
        by mx-out2.deshaw.net (Postfix) with ESMTPS id 1608D806E9A
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 18:19:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deshaw.com; s=k001;
        t=1654899572; bh=yM9RbJpX2ESBMTbUQKW8sXqisK42r0jCwEt5jA3PA4g=;
        h=From:To:CC:Subject:Date:From;
        b=JL7Mc2w1eRbFsXRpuxEBgPkcT/+81D8IY/2UX90X39wXIAHo5+tia8es6zpUeVesj
         vxsbsKycWuVI6tSNM8gZoRH22mHk+pMLyUF1fRQ0jjGyQ9Gli8dH5NFR86VtMnl+r4
         5az6LguhY42t0AVrmw6A6AEQtFXJZpEC7p2nernQ=
Received: from deshaw.com (mail-multi.nyc.deshaw.com [10.219.243.66])
        by mx-relay2.deshaw.net (Postfix) with ESMTPS id 0E58E1408400
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 18:19:32 -0400 (EDT)
Received: from exchmbxtoa1a.deshaw.com (exchmbxtoa1a.deshaw.com [10.219.74.16])
        by mail-multi.nyc.deshaw.com (Postfix) with ESMTPS id 067BD2573
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 18:19:32 -0400 (EDT)
Received: from exchmbxpsc1c.deshaw.com (10.218.74.18) by
 exchmbxtoa1a.deshaw.com (10.219.74.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 18:19:31 -0400
Received: from exchmbxpsc1c.deshaw.com ([fe80::a151:8073:ccf0:c19e]) by
 exchmbxpsc1c.deshaw.com ([fe80::a151:8073:ccf0:c19e%4]) with mapi id
 15.01.2308.027; Fri, 10 Jun 2022 18:19:31 -0400
From:   "Udoff, Marc" <Marc.Udoff@deshaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
Subject: git filter bug
Thread-Topic: git filter bug
Thread-Index: Adh9GBnXLc9Gl6ZqSU6yhtlNhZ2wRw==
Date:   Fri, 10 Jun 2022 22:19:31 +0000
Message-ID: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.66.97]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Content-Scanned: Fidelis Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I believe there is a bug in git status that happens when a file changes but=
 the filtered version of the file does not. Correctly, git diff does not sh=
ow anything as different and git commit believes there is nothing to commit=
.

Reproducer:
$ git init
$ touch bar
$ git add bar
$ git commit -am 'Bar'
[main (root-commit) dd12b3e] Bar
1 file changed, 0 insertions(+), 0 deletions(-)
create mode 100644 bar
$ echo -en '\n[filter "noat"]\n=A0=A0=A0=A0 clean =3D grep -v "@"\n' >> .gi=
t/config
$ cat .git/config=20
[core]
=A0=A0=A0=A0=A0=A0=A0 repositoryformatversion =3D 0
=A0=A0=A0=A0=A0=A0=A0 filemode =3D true
=A0=A0=A0=A0=A0=A0=A0 bare =3D false
=A0=A0=A0=A0=A0=A0=A0 logallrefupdates =3D true

[filter "noat"]
=A0=A0=A0=A0 clean =3D grep -v "@"
$ echo -en 'abc\n@def\nghi\n' > bar=20
$ cat bar=20
abc
@def
ghi
$ echo "* filter=3Dnoat" > .gitattributes
$ git commit -am 'No at bar'
[main e81ee3b] No at bar
2 files changed, 3 insertions(+)
create mode 100644 .gitattributes
$ git show HEAD:bar
abc
ghi
$ echo "@another line" >> bar # Add another @ which will be filtered. touch=
 doesn't cause this bug
$ git status --porcelain
M bar
$ git diff # no output as there is no diff
$ git commit -am "I did not update"
On branch main
nothing to commit, working tree clean


While this reproducer is a bit contrived, the real world examples are with =
Jupyter notebooks filtering output, so I expect this is a somewhat common o=
ccurrence. I think it also may be the same as https://stackoverflow.com/que=
stions/62641222/how-to-make-git-status-consider-the-clean-filter.

Git version: 2.35.1
OS: Linux


Note: I also logged this here, but I believe this mailing list is the corre=
ct place to raise the issue: https://github.com/gitgitgadget/git/issues/125=
6

Thanks,
Marc

