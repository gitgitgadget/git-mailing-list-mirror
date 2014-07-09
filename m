From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 20:19:31 +0200
Message-ID: <53BD87B3.8050901@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de> <53BCDDE2.1080301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:19:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4wT4-00035L-DB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 20:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbaGISTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 14:19:42 -0400
Received: from mout.web.de ([212.227.15.4]:60630 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaGISTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 14:19:41 -0400
Received: from [192.168.178.41] ([84.132.188.65]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LhhVB-1WIBMr2Ywj-00mqqO; Wed, 09 Jul 2014 20:19:32
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BCDDE2.1080301@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:GqERfpnLoR5yv+mxn+PCFrDJn8sQfG0w9DophlOueYe14pgM0F/
 PMIj9ijy/iGkQZDbDk3mo+ZyQIlptuqiSFHgGyrVRJss/B3CP11DUaFuLPZFhFSN4ZdQdo7
 QmSIUjifJerE95+GqBMmClpvEVlHtDnTdZTKtZNFrrwNd9ozwdGUUhnhI2hqu4SkFxFlU46
 eiP604QMpskaiOW5TYLBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253138>

Am 09.07.2014 08:14, schrieb Torsten B=F6gershausen:
>=20
>>> There seems to be some other trouble under Mac OS, not yet fully tr=
acked down,
>>> (may be related to the "diff -r")
>> Torsten sees failures of this kind under Mac OS:
>>
>> diff -r .git/modules/sub1/config sub1/.git/config
>> 6d5
>> <     worktree =3D ../../../sub1
>> 8a8
>>>      worktree =3D ../../../sub1
>> So the config contains the same content, but the worktree setting mo=
ved
>> to a different line. This seems to be the result of setting core.wor=
ktree
>> in the test_git_directory_is_unchanged function just before the "dif=
f -r",
>> but only under Mac OS.
>>
> So I was suspecting diff -r beinng non-portable, but that doesn't see=
m to be the problem here.
> (But I wouldn't be surprised if there where problems with diff -r on =
some Unix systems)
> Anyway, checking all the files in the working tree seems to be a good=
 thing to do,
> but that does not necessarily work for .git/config.

I agree, but this case is special. The test asserts that nobody
added, modified or removed *anything* inside the .git directory.
The reason for problem we are seeing here is that I have to
remove the core.worktree setting when moving the git directory
from .git/modules into the submodule work tree. So the test adds
it again to be able to diff it, and this happens in a different
line only on Mac OS as comparing the two core sections shows:

> ---------------------
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D true
>         bare =3D false
>         logallrefupdates =3D true
>         worktree =3D ../../../sub1
>         ignorecase =3D true
>         precomposeunicode =3D true
> [remote "origin"]

vs.

> ----------------
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D true
>         bare =3D false
>         logallrefupdates =3D true
>         ignorecase =3D true
>         precomposeunicode =3D true
>         worktree =3D ../../../sub1
> [remote "origin"]

And now it's clear what happens here: On Mac OS the ignorecase
and precomposeunicode settings are added behind the worktree
line, then re-adding worktree later for the comparison adds it
after these two.

Could you please test the following? It should avoid this kind
of problem by removing the core.worktree setting temporarily
from the original config in .git/modules instead of adding it
temporarily to .git/config:
-----------------------8<-----------------------
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 3584755..98c86e3 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -143,18 +143,18 @@ replace_gitfile_with_git_dir () {
 }

 # Test that the .git directory in the submodule is unchanged (except f=
or the
-# core.worktree setting, which we temporarily restore). Call this func=
tion
+# core.worktree setting, which we temporarily remove). Call this funct=
ion
 # before test_submodule_content as the latter might write the index fi=
le
 # leading to false positive index differences.
 test_git_directory_is_unchanged () {
 	(
-		cd "$1" &&
-		git config core.worktree "../../../$1"
+		cd ".git/modules/$1" &&
+		git config --unset core.worktree
 	) &&
 	diff -r ".git/modules/$1" "$1/.git" &&
 	(
-		cd "$1" &&
-		GIT_WORK_TREE=3D. git config --unset core.worktree
+		cd ".git/modules/$1" &&
+		git config core.worktree "../../../$1"
 	)
 }
