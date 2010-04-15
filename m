From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: git fetch over http:// left my repo broken
Date: Thu, 15 Apr 2010 11:51:25 +0200
Message-ID: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jan.sievers@sap.com, "Sohn, Matthias" <matthias.sohn@sap.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 11:51:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Ljm-0005oO-0l
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 11:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab0DOJvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 05:51:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:12038 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab0DOJvq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 05:51:46 -0400
Received: by fg-out-1718.google.com with SMTP id 22so523217fge.1
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=EBB7tqIuxgwsi3ZUo3l1di9ZUNMtIgYFRqm/DNe04m8=;
        b=hN263KC1E4Rnr5y4jEL9ZtBHUGnW5WJt9JiMb2e/WBVqBrUXkTSgP0JQ7qeunZ5sZA
         e9QrG/ZtuEYtTFX1yd7oT0mEBdTBypi5Y3ThBVXJ0CEmcJsEcGljnvG7QSju5N801ReV
         UJfz+PGTi5yI1/4/TdByY5AhEqzRpLwdM6v94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=kf3ExlU2l/bDs1FlFJnkwyasgWNWedDVmSI1Bko9Ql67fW00ShzFCehqf/+1P7l0Ha
         B+Byx6J9hM8Caih/i41/r/s0K8cWm6zda4ZXYBFFzJWaD+x5oBrrnu/ZFQU3YgpRvHFV
         3oSn3AS1MXAmGwGJzMdMAiun1C2KnEunWX38k=
Received: by 10.239.156.72 with HTTP; Thu, 15 Apr 2010 02:51:25 -0700 (PDT)
Received: by 10.239.181.205 with SMTP id n13mr496582hbg.66.1271325105103; Thu, 
	15 Apr 2010 02:51:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144968>

Hi,

some days back I fetched from a github repo with http protocol and
afterwards my local repo was broken. Since the fetch was done by a
cronjob I don't know whether the fetch reported an error. Problem is
that one pack file was corrupted because the github servers put the
repo I wanted to clone into some maintenance mode while I was
fetching. The pack file includes at the end the html source code -
which makes these files clearly corrupted.

Git should detect this error and let the fetch fail, right?

All this done on Linux (CentOS) with git version 1.6.6.1. Github repo
was http://github.com/sonatype/sonatype-tycho.git. This is not easy to
reproduce - because you have to hit the maintenance times of github.

Here is what I did:

> git --version
git version 1.6.6.1
> uname --all
Linux wdfd00220954a.wdf.sap.corp 2.6.18-164.15.1.el5 #1 SMP Wed Mar 17
11:30:06 EDT 2010 x86_64 x86_64 x86_64 GNU/Linux

> git remote -v
origin =C2=A0http://github.com/sonatype/sonatype-tycho.git (fetch)
origin =C2=A0http://github.com/sonatype/sonatype-tycho.git (push)
> git fetch origin
=2E..
> git fsck --full
error: packfile
=2E/objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0b.pack doe=
s
not match index
error: packfile
=2E/objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0b.pack
cannot be accessed
error: packfile
=2E/objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0b.pack doe=
s
not match index
fatal: packfile
=2E/objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0b.pack
cannot be accessed

# get the size of the corrupted pack file
> ls -l ./objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0b.pa=
ck
-rw-r--r-- 1 git git 766920900 Apr 13 16:22
=2E/objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0b.pack

# dump the start of the corrupted file: looks ok
> xxd -l 64 ./objects/pack/pack-b5dceb0bae390d6540f881be686839f7e691fa0=
b.pack
0000000: 5041 434b 0000 0002 0000 4bef 962b 789c =C2=A0PACK......K..+x.
0000010: 9591 cb72 dc20 1045 f77c 457f 8067 8a41 =C2=A0...r. .E.|E..g.A
0000020: 1a21 a552 a954 5cce 63e5 2adb 9b2c 7934 =C2=A0.!.R.T\.c.*..,y4
0000030: 2332 8856 00d9 99bf 37a3 781c 2f9d 0d05 =C2=A0#2.V....7.x./...

# dump a section near the end of the corrupted file: html source code
included here?
> =C2=A0xxd -s 766911990 -l 128 ./objects/pack/pack-b5dceb0bae390d6540f=
881be686839f7e691fa0b.pack
2db625f6:d64b 2752 e70f 8f1a 6161 3c21 444f 4354 =C2=A0.K'R....aa<!DOCT
2db62606:5950 4520 6874 6d6c 2050 5542 4c49 4320 =C2=A0YPE html PUBLIC
2db62616:222d 2f2f 5733 432f 2f44 5444 2058 4854 =C2=A0"-//W3C//DTD XHT
2db62626:4d4c 2031 2e30 2054 7261 6e73 6974 696f =C2=A0ML 1.0 Transitio
2db62636:6e61 6c2f 2f45 4e22 0a20 2022 6874 7470 =C2=A0nal//EN". =C2=A0=
"http
2db62646:3a2f 2f77 7777 2e77 332e 6f72 672f 5452 =C2=A0://www.w3.org/TR
2db62656:2f78 6874 6d6c 312f 4454 442f 7868 746d =C2=A0/xhtml1/DTD/xhtm
2db62666:6c31 2d74 7261 6e73 6974 696f 6e61 6c2e =C2=A0l1-transitional.

# search for the string "maintenance" in the binary pack file
> grep -C5 -a "maintenance" ./objects/pack/pack-b5dceb0bae390d6540f881b=
e686839f7e691fa0b.pack

<div id=3D"error" class=3D"status404">
  <img alt=3D"Repo unavailable due to maintenanace" height=3D"219"
src=3D"http://assets3.github.com/images/error/octocat_construction.gif?=
5cb2cfa6f35ac1b0c322a78a129d7531177b36d7"
width=3D"243" />
  <h1>Repository temporarily unavailable.</h1>
  <p>The backend storage is temporarily offline. Usually this means the=
<br />
     storage server is undergoing maintenance. Your repository should <=
br />
     be available again very soon.</p>
</div>

        </div>
>


Ciao
=C2=A0Chris
