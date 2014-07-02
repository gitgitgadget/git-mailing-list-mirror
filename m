From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 02 Jul 2014 21:57:25 +0200
Message-ID: <53B46425.3030000@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:57:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Qev-0002nZ-1v
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 21:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbaGBT5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2014 15:57:33 -0400
Received: from mout.web.de ([212.227.15.3]:61344 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbaGBT5c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 15:57:32 -0400
Received: from [192.168.178.41] ([84.132.187.74]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M7n5k-1WgW7t2NMm-00vPZP; Wed, 02 Jul 2014 21:57:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B41D42.2090805@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:h+wbNbUul8unWXsHHJEgMFHbXk0sqEb+SkyEJleMtAajsY1b8Lm
 7gp/5q/Nu/zb2XipHMjpuJ5CE1rt0KHG1zTj6aUXcCbFNIZiRVKvEZszcMUIGpeADz38veK
 8F9cJepW7aIF9jHSrSVWUQnakWQ5tONxMUx5E7/xius0vpQo77eKYCp2Bu9cxR5bClS95q2
 VdTLeLyOvBCr4mFrKsrRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252834>

Am 02.07.2014 16:54, schrieb Torsten B=F6gershausen:
> (Not sure if this is the right thread)
> (I haven't checked if this is fixed in your latest version)

Yes, this is the right thread and no, it isn't fixed yet.

> On what I have on pu 7a0da7902cbbc9a876b90c9, Tue Jul 1 14:51:53 2014=
 -0700
>=20
> Many submodule tests are broken.
> One problem is here:
>=20
> lib-submodule-update.sh:264: possible problem: echo -n is not portabl=
e (please use printf):                     echo -n >sub1 &&
> lib-submodule-update.sh:507: possible problem: echo -n is not portabl=
e (please use printf):                     echo -n >sub1 &&
>=20
> You can remove the "empty" "echo -n" to create an empty file:
>> sub1 &&

Thanks for spotting and diagnosing this. Running "make lint" in the
test directory only feeds the tests to check-non-portable-shell.pl,
but not the *lib*.sh helper scripts, which made me miss this one.

The following diff should fix it for you. Am I understanding you
correctly that you are experiencing other failures too? I see no
other incompatibilities when running ./check-non-portable-shell.pl
on all the shell scripts in the repo.

-----8<----
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 24c9fd7..3584755 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -304,7 +304,7 @@ test_submodule_switch () {
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			echo -n >sub1 &&
+			>sub1 &&
 			test_must_fail $command add_sub1 &&
 			test_superproject_content origin/no_submodule &&
 			test_must_be_empty sub1
@@ -547,7 +547,7 @@ test_submodule_forced_switch () {
 		(
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
-			echo -n >sub1 &&
+			>sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1
--=20
2.0.1.458.gf680257.dirty
