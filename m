From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 03 Jul 2014 23:14:20 +0200
Message-ID: <53B5C7AC.4040701@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de> <53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:14:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2oL0-0005pX-1I
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 23:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759674AbaGCVOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 17:14:34 -0400
Received: from mout.web.de ([212.227.17.12]:50565 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759670AbaGCVOd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 17:14:33 -0400
Received: from [192.168.178.41] ([84.132.191.233]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lh6M7-1WFUk30ElT-00oZyn; Thu, 03 Jul 2014 23:14:24
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B4F0AA.10809@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Orrzjug8r+7i2/J0T8lXQp42oHmSENbWKutxDG+l6tWdBieKiFd
 KBY/rGljEL0UEExL9iVLM9Jdjy/2nBr0jpZe73Wy8pard7B6jGLg76nrJ0BBbSQky6EusGc
 w+XipNQttvGgUFsdFAdVdf00R/qm9isOKB/JwiSzQ/jbKQMKRT6yPDNcuR3FEUXg8gbasGT
 LmyQm7BG8MqUKZxrRqauA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252880>

Am 03.07.2014 07:56, schrieb Torsten B=F6gershausen:
> On 07/02/2014 09:57 PM, Jens Lehmann wrote:
>> Am 02.07.2014 16:54, schrieb Torsten B=F6gershausen:
>>> (Not sure if this is the right thread)
>>> (I haven't checked if this is fixed in your latest version)
>> Yes, this is the right thread and no, it isn't fixed yet.
>>
>>> On what I have on pu 7a0da7902cbbc9a876b90c9, Tue Jul 1 14:51:53 20=
14 -0700
>>>
>>> Many submodule tests are broken.
>>> One problem is here:
>>>
>>> lib-submodule-update.sh:264: possible problem: echo -n is not porta=
ble (please use printf):                     echo -n >sub1 &&
>>> lib-submodule-update.sh:507: possible problem: echo -n is not porta=
ble (please use printf):                     echo -n >sub1 &&
>>>
>>> You can remove the "empty" "echo -n" to create an empty file:
>>>> sub1 &&
>> Thanks for spotting and diagnosing this. Running "make lint" in the
>> test directory only feeds the tests to check-non-portable-shell.pl,
>> but not the *lib*.sh helper scripts, which made me miss this one.
>>
>> The following diff should fix it for you. Am I understanding you
>> correctly that you are experiencing other failures too? I see no
>> other incompatibilities when running ./check-non-portable-shell.pl
>> on all the shell scripts in the repo.
> The longer story is that I run the test suite once a week or so.
> Most often under Mac OS, sometimes cygwin or Linux.
> Whenever there is a breakage under Mac OS which I can not
> debug within some minutes, I run it under Linux to see if there
> is the same breakage.

Thanks, that really helps a lot and is more than I could ask for.

> The ./check-non-portable-shell.pl can sometimes give an indication
> why some test fail.
> You can run it from command line:
>  ./check-non-portable-shell.pl *.sh
> and it will find the "echo -n" which I reported.
> On the longer run it could probably check all *.sh files,
> not only the ones under t/

That is exactly what I thought when I tried to find out why I missed
this. Will cook up a patch to at least check the test helpers too.

> I do not have the time to test the snipped patch below, but I can che=
ck pu
> when the next round of your patch is in and give you some more info.

That'd be great!

Junio, do you want me to resend 02/14 without the non-portable "echo -n=
"
or could you just squash the following diff in?

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
-- 2.0.1.458.gf680257.dirty
