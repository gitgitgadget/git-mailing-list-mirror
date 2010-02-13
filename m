From: Jonathan Nieder <jrnieder@gmail.com>
Subject: t7400.24 git submodule 'update --init' test fails on some machines
Date: Sat, 13 Feb 2010 03:05:45 -0600
Message-ID: <20100213090544.GA29850@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 10:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgDwz-0002v3-2t
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 10:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab0BMJFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 04:05:52 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:61980 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab0BMJFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 04:05:46 -0500
Received: by iwn13 with SMTP id 13so2873258iwn.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=75waw1uVH677C6lNUksS8POtMnDwcFg5aoIEVvEiDdM=;
        b=CfxCR8X+C+CYD7TE2hLcsxD8ku4yfrTzjksuWndvr2LZyLCn9mQuzjeZ406cnnvz0r
         ii5uz3zQgNyUtBzs3g980bQUN0SOKJ/kQrpBzQiqmNdzJuv50kSEDL2OGb/U2HTZ/5GA
         2/jaE/Vb9/G7d6t/ZdbKADPQJeq9qm4WooYyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=kkH0GLDmlyParxPpoLmL5RJmX5Xq+H9E90n98yURogHPqYj15SFHXB5+sCJVuwcxVv
         7F672GVgxtD2iFS4VNya+xiqKvOCOgu5DdgJX7OhkYbD9AnxsXERHELzQhHt2mfHnFpT
         0k39bTlbAA2hT77wsNTA28AtMLCsZrJ0W0BsA=
Received: by 10.231.153.1 with SMTP id i1mr1827225ibw.35.1266051944913;
        Sat, 13 Feb 2010 01:05:44 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3777612iwn.12.2010.02.13.01.05.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 01:05:44 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139782>

Some machines I don=E2=80=99t have access to have been hitting a test f=
ailure
when building git 1.6.6.2 and 1.7.0-rc2.  I am looking for ideas.

The failed test is #24 from t7400-submodule-basic.sh:

 test_expect_success 'update --init' '

	mv init init2 &&
	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
	git config --remove-section submodule.example
	git submodule update init > update.out &&
	grep "not initialized" update.out &&
	test ! -d init/.git &&
	git submodule update --init init &&
	test -d init/.git

 '

That is supposed to produce output like

| Submodule path 'init' not initialized
| Submodule 'example' (<top>/t/trash directory.t7400-submodule-basic/in=
it2) registered for path 'init'
| Initialized empty Git repository in <top>/t/trash directory.t7400-sub=
module-basic/init/.git/
| Submodule path 'init': checked out 'OBJID'
| *   ok 24: update --init

but instead it just produces

| * FAIL 24: update --init

The silence suggests that the =E2=80=98git submodule update init=E2=80=99=
 command does
not perceive the submodule not to be initialized, or in other words,
that one of the earlier =E2=80=98git config=E2=80=99 commands is failin=
g.

None of the earlier tests fail, and none of the other t7400 tests
fail.

Recent results for the =E2=80=98update --init=E2=80=99 test (note that =
even for the
same arch, different builds are usually on different machines):

result	git		arch	libc		log
ok	1.6.6.1		i386	2.10.2-5	[1]
ok	1.6.6.1		s390	2.10.2-5	[2]
ok	1.6.6.1		ia64	2.10.2-5	[3]
ok	1.6.6.1		hppa	2.10.2-5	[4]
ok	1.6.6.2		i386	2.10.2-5	[5]
ok	1.6.6.2		s390	2.10.2-6	[6]
=46AIL	1.6.6.2		ia64	2.10.2-6	[7]
=46AIL	1.6.6.2		hppa	2.10.2-5	[8]
ok	1.7.0-rc2	i386	2.10.2-6	[9]
=46AIL	1.7.0-rc2	s390	2.10.2-6	[10]

The two s390=E2=80=99s are particularly strange.  Same kernel image, sa=
me
libc, different machines, different results.

Unfortunately, the logs with =E2=80=9Cok=E2=80=9D (except for ia64 1.6.=
6.1) do
not include =E2=80=9Cmake test GIT_TEST_OPTS=3D-v=E2=80=9D output.

Johan, from staring at the code, I don=E2=80=99t think commit 65807ee
(builtin-config: Fix crash when using "-f <relative path>" from
non-root dir, 2010-01-26) would have anything to do with this, but
nothing else related has changed recently so I CCed you anyway.

It is hard to blame git for something so architecture-dependent
and inconsistent, but one has to start somewhere.

Thoughts?
Jonathan

[1] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.1=
-1&arch=3Di386&stamp=3D1264681049&file=3Dlog
[2] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.1=
-1&arch=3Ds390&stamp=3D1264681505&file=3Dlog
[3] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.1=
-1&arch=3Dia64&stamp=3D1264690704&file=3Dlog
[4] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.1=
-1&arch=3Dhppa&stamp=3D1264695557&file=3Dlog
[5] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.2=
-1&arch=3Di386&stamp=3D1265992804&file=3Dlog
[6] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.2=
-1&arch=3Ds390&stamp=3D1265994666&file=3Dlog
[7] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.2=
-1&arch=3Dia64&stamp=3D1265994466&file=3Dlog
[8] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.6.6.2=
-1&arch=3Dhppa&stamp=3D1266038878&file=3Dlog
[9] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.7.0~r=
c2-1&arch=3Di386&stamp=3D1265996497&file=3Dlog
[10] https://buildd.debian.org/fetch.cgi?&pkg=3Dgit-core&ver=3D1:1.7.0~=
rc2-1&arch=3Ds390&stamp=3D1266025527&file=3Dlog

Recent point release builds:
https://buildd.debian.org/status/package.php?p=3Dgit-core

All builds:
https://buildd.debian.org/build.php?arch=3D&pkg=3Dgit-core
