From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sun, 24 Jun 2012 17:47:01 +0200
Message-ID: <4FE73675.2000901@web.de>
References: <201201212036.57632.tboegi@web.de> <7vsjj8acmh.fsf@alter.siamese.dyndns.org> <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com> <CACsJy8AucS9ez=-zej=72dr+0AVvGFR_eZgQcabitXgmQTJOCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 17:47:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sip1q-0006w3-Uc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 17:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab2FXPrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 11:47:06 -0400
Received: from mout.web.de ([212.227.17.12]:49652 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab2FXPrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 11:47:04 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LgYi5-1S3vt23YPt-00oZCk; Sun, 24 Jun 2012 17:47:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CACsJy8AucS9ez=-zej=72dr+0AVvGFR_eZgQcabitXgmQTJOCA@mail.gmail.com>
X-Provags-ID: V02:K0:wHpzlxZ+mdt1xNFIqYcv4clNCo2T3wa6xt8YTA+W6Ku
 0qB4Bdx2M5FDX/gBUrSoYyJ04jBEbkNeqt1TMGIzeR6KFadXsD
 B+muOQgZcuRCVfj/PgY51BeFSDNhjycVoW0avqZ/DetPNsirP8
 tZGg8byDgtsHQjpZo5DEjijJwCxKnwVfGyvdAqTm5Ngtt1iZH3
 1iv8Ql0I978igxZmoIKEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200533>

On 22.01.12 11:03, Nguyen Thai Ngoc Duy wrote:
> 2012/1/22 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>>>> In order to prevent that ever a file name in decomposed unicode is
>>>> entering the index, a "brute force" attempt is taken: all argument=
s into
>>>> git (argv[1]..argv[n]) are converted into precomposed unicode.
>=20
> Forgot one more thing. We have case-insensitive support in place
> already, we can hook precomposed form conversion there before
> comparing. In other words we just need to support
> {pre,de}composed-insensitive string compare.
>=20
>Forgot one more thing. We have case-insensitive support in place
>already, we can hook precomposed form conversion there before
>comparing. In other words we just need to support
>{pre,de}composed-insensitive string compare.
>-- Duy=20

Yes, I like that idea.
After doing some experiments with precomposed and decomposed file names=
,
the motvation for the fix, or so to say the root cause, changed.

The Mac OS X file system on VFAT has a kind of schizophrenia:
- unicode file names are written as precomposed onto the disk
  and Linux/Windows see them as precomposed.
- readdir() returns always decomposed.
- open()/fopen() stat() lstat() works for both pre- and decomposed

Therefore a repository on VFAT under Mac OS X looks as follows:

- file names on disk are precomposed
- file names in the index are decomposed

As long as only Mac OS uses that device, there is no problem.

When we now move the e.g. USB stick using VFAT to Linux
the "decomposed" in the index seem to be deleted and the
precomposed on disk are untracked.
A complete desaster.

To keep the file names in the index and how they are stored
on disk the same, we can can set "core.precomposedunicode" =3D true.
(Side note: should we rename it to "i18n.precomposedunicode" ?)

Now we keep the index and file names on disk the same, and can move the
USB stick between Linux, Mac OS X, or Windows (since msysGit-1.7.10-
now called Git for Windows, or git under cygwin 1.7)

The same problem occurs when Mac OS mounts a network share from linux
using SAMBA:
readdir() returns decomposed, creat() stores file names in precomposed
on the remote linux machine.

If we put a file name with decomposed unicode on the linux machine,
it will be listed as decomposed by readdir() on the Mac OS side.
Trying to access this file failes, because Mac OS tries to open
the precomposed version, and that does not exist.


Another thing:
There are some reasons to avoid decomposed unicode in Linux and Windows=
:
Many user space programs don't handle decomposed unicode very well.
When e.g. an "=C3=BB" should be displayed, the output looks like "u^" i=
n many
programs.
And if we need more motivations: decomposed unicode is hard to enter on
the keyboard.



Then I went back to my original problem=20
(versioning the "Documents" folder on my Linux $HOME under git
and access it from Windows and Mac OS using SAMBA, or cloning it
to a laptop...)

Knowing that
a) Mac OS X handles precomposed and decomposed the same in open()...
b) The user space program on Mac OS handle precomposed just fine
c) Many user space programs don't presentate decomposed as it should be
d) It is hard to enter decomposed unicode at the keyboard
e) and therefore decomposed unicode is seldom used on Linux
f) Mac OS using SAMBA puts file names in precomposed unicode on the=20
   remote side

Do we have a motivation for pushing a solution that ignores=20
the unicode composition ?

I'll send a V5 version with hopefully a better motivation
