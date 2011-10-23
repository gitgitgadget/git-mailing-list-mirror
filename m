From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sun, 23 Oct 2011 15:25:17 +0200
Message-ID: <4EA415BD.1040109@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: John Hsing <tsyj2007@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 15:25:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHy3c-0005j5-86
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 15:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520Ab1JWNZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 09:25:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:60069 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1JWNZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 09:25:25 -0400
Received: from [192.168.2.104] (p4FFD9D8D.dip.t-dialin.net [79.253.157.141])
	by india601.server4you.de (Postfix) with ESMTPSA id 1C1E42F8061;
	Sun, 23 Oct 2011 15:25:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4EA3D1BB.2010802@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184139>

Am 23.10.2011 10:35, schrieb John Hsing:
> ok,when i finish compiling git 1.7.7.431.g89633=EF=BC=8CI use it to c=
heck
> Cyanogenod=EF=BC=88an Android mod source=EF=BC=89 by =E2=80=9Cgit sta=
tus=E2=80=9D=EF=BC=8Cit happend this
> error=EF=BC=81but when i reuse git v1.7.7=EF=BC=8Cit is OK=EF=BC=81so=
 i think it is a bug in
> git 1.7.7.431.g89633=EF=BC=81My OS is Ubuntu Linux 10.10=EF=BC=8Csorr=
y for my bad
> english=EF=BC=81 If you want to reproduce this error,please excute "g=
it status"
> in https://github.com/CyanogenMod/android_packages_apps_DSPManager.gi=
t
> repo!

I can reproduce the malloc crash on Ubuntu 11.10 with these simple step=
s:

	$ a=3Dandroid_packages_apps_DSPManager
	$ git-v1.7.7 clone https://github.com/CyanogenMod/$a.git
	Cloning into android_packages_apps_DSPManager...
	remote: Counting objects: 902, done.
	remote: Compressing objects: 100% (412/412), done.
	remote: Total 902 (delta 367), reused 838 (delta 324)
	Receiving objects: 100% (902/902), 136.78 KiB | 264 KiB/s, done.
	Resolving deltas: 100% (367/367), done.
	$ cd $a

	$ git-v1.7.7 status
	# On branch gingerbread
	nothing to commit (working directory clean)

	$ git-master status
	git: malloc.c:3096: sYSMALLOc: Assertion `(old_top =3D=3D (((mbinptr) =
(((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struct m=
alloc_chunk, fd)))) && old_size =3D=3D 0) || ((unsigned long) (old_size=
) >=3D (unsigned long)((((__builtin_offsetof (struct malloc_chunk, fd_n=
extsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t))) - 1)=
)) && ((old_top)->size & 0x1) && ((unsigned long)old_end & pagemask) =3D=
=3D 0)' failed.
	Aborted

Bisect points to 2548183ba, "fix phantom untracked files when
core.ignorecase is set" from Jeff (cc:d).  If I revert that patch from
master (8963314c), git status works fine.

The following experimental patch fixes it for me as well, but I can't
claim to know exactly why.  In any case, estimate_cache_size() seems
to guess too low.

Ren=C3=A9


---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 01a0e25..b143bd3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1257,7 +1257,7 @@ static inline size_t estimate_cache_size(size_t o=
ndisk_size, unsigned int entrie
 	 * Alignment can cause differences. This should be "alignof", but
 	 * since that's a gcc'ism, just use the size of a pointer.
 	 */
-	per_entry +=3D sizeof(void *);
+	per_entry +=3D 2 * sizeof(void *);
 	return ondisk_size + entries*per_entry;
 }
=20
