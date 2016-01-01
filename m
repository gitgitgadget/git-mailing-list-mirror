From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: t6023 broken under Mac OS
Date: Fri, 1 Jan 2016 21:14:17 +0000
Message-ID: <5686EC29.3080901@ramsayjones.plus.com>
References: <56869D10.9090105@web.de> <5686B400.7000800@ramsayjones.plus.com>
 <5686BC3B.5080302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	dev+git@drbeat.li, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 22:16:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF73U-0004zQ-HQ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 22:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcAAVPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jan 2016 16:15:32 -0500
Received: from avasout07.plus.net ([84.93.230.235]:54367 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbcAAVPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 16:15:31 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 0lEP1s0064mu3xa01lEQb6; Fri, 01 Jan 2016 21:14:25 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=BZklqeZ2 c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=GjuXkeGn7_C3mJEy3xMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <5686BC3B.5080302@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283261>



On 01/01/16 17:49, Torsten B=C3=B6gershausen wrote:
> On 2016-01-01 18.14, Ramsay Jones wrote:
>> Hi Torsten,
>>
>> On 01/01/16 15:36, Torsten B=C3=B6gershausen wrote:
>>> The (last) test case
>>> 'conflict markers contain CRLF when core.eol=3Dcrlf'
>>>
>>> does not work as expected under Mac OS: "wc -l" is not portable and=
 the line
>>> test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
>>> fails.
>>
>> Hmm, I have never used a Mac, so I'm just guessing here, but
>> you could try something like (obviously untested!):
>>
>> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
>> index 245359a..68b306f 100755
>> --- a/t/t6023-merge-file.sh
>> +++ b/t/t6023-merge-file.sh
>> @@ -350,7 +350,7 @@ test_expect_success 'conflict at EOF without LF =
resolved by --union' \
>>  test_expect_success 'conflict markers contain CRLF when core.eol=3D=
crlf' '
>>  	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>>  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>> -	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
>> +	test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l) -eq =
3
>>  '
>> =20
>>  test_done
> Yes, this works.
>=20
>>
>> [The 'wc -l' portability should only be a problem if you rely on the
>> exact textual form of the output, rather than the integer count.
>> 'wc -l' is used in many many tests ...]
>>
>> Note that this test is not checking all conflict markers (the
>> =3D=3D=3D=3D=3D=3D=3D marker does not have a filename appended). Sho=
uld that
>> be fixed also?
> This is may attempt (against pu)
>=20
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 68b306f..b1f8e41 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -350,7 +350,13 @@ test_expect_success 'conflict at EOF without LF =
resolved by
> --union' \
>  test_expect_success 'conflict markers contain CRLF when core.eol=3Dc=
rlf' '
>         test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>                 nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.t=
xt &&
> -       test $(tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" | wc -l)=
 -eq 3
> +       tr "\015" Q <output.txt | sed -n "/\.txtQ$/p" >out &&
> +       cat >exp <<\EOF  &&
> +<<<<<<< nolf-diff1.txtQ
> +||||||| nolf-orig.txtQ
> +>>>>>>> nolf-diff2.txtQ
> +EOF
> +        test_cmp exp out
>  '
>=20

This still doesn't test the '=3D=3D=3D=3D=3D=3D=3D conflict marker', ho=
w about
something like this (again not tested on Mac - is the re in the
sed invocation OK on the Mac?):

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 245359a..0697b22 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -350,7 +350,14 @@ test_expect_success 'conflict at EOF without LF re=
solved by --union' \
 test_expect_success 'conflict markers contain CRLF when core.eol=3Dcrl=
f' '
 	test_must_fail git -c core.eol=3Dcrlf merge-file -p \
 		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
-	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) =3D 3
+	tr "\015" Q <output.txt | sed -n "/^[<=3D>|].*Q$/p" >out.txt &&
+	cat >expect.txt <<-\EOF &&
+	<<<<<<< nolf-diff1.txtQ
+	||||||| nolf-orig.txtQ
+	=3D=3D=3D=3D=3D=3D=3DQ
+	>>>>>>> nolf-diff2.txtQ
+	EOF
+	test_cmp expect.txt out.txt
 '
=20
 test_done

ATB,
Ramsay Jones
