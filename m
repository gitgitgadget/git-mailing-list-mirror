From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] sha1-array: add test-sha1-array and basic tests
Date: Wed, 01 Oct 2014 16:21:22 +0200
Message-ID: <542C0DE2.6060502@web.de>
References: <542BCBFC.5000509@web.de> <CAPig+cQxXccnQCwr7oVfccAQn3sTUpv=b=qHEX1H7abng--=0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZKnb-00047n-0V
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 16:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaJAOWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 10:22:30 -0400
Received: from mout.web.de ([212.227.17.11]:58486 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaJAOWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 10:22:30 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MKa6N-1XZ3Pj0cA3-001wjH; Wed, 01 Oct 2014 16:22:16
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <CAPig+cQxXccnQCwr7oVfccAQn3sTUpv=b=qHEX1H7abng--=0A@mail.gmail.com>
X-Provags-ID: V03:K0:9Tr+yukkg+hUs6mLPmOCRX+yXd2vzqJJr70WjkbdEuexu0t75Qk
 pFTSZcOFw8PNmA0u+EaB1SrwRh2/1GMf9Tou0olUiZfjtFzi/0KMiq0TBwdosk//wxcVp4p
 /m0NCiR3BLZNFHY55kwSSjauGEV/gLZqA7CuMtcustPS7JbDHzNqJSwlfr0Oyg2FMwMOaFS
 TN9c0OQPQyws4858YxI2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257751>

Am 01.10.2014 um 16:11 schrieb Eric Sunshine:
> On Wed, Oct 1, 2014 at 5:40 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
>> new file mode 100755
>> index 0000000..bd68789
>> --- /dev/null
>> +++ b/t/t0064-sha1-array.sh
>> @@ -0,0 +1,64 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'basic tests for the SHA1 array implementation'
>> +. ./test-lib.sh
>> +
>> +echo20() {
>> +       prefix=3D"$1"
>> +       shift
>> +       while test $# -gt 0
>> +       do
>> +               echo "$prefix$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$=
1"
>
> Each caller of echo20() manually includes a space at the end of
> $prefix. Would it make sense to instead have echo20() do this on
> behalf of the caller?
>
>      echo "$prefix $1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"

That wouldn't work if the prefix is the empty string; we don't want a=20
space in that case (see the next echo20 call below).

But ${prefix:+$prefix } would do the trick.  Thanks for the idea. :)

>
>> +               shift
>> +       done
>> +}
>> +
>> +test_expect_success 'ordered enumeration' '
>> +       echo20 "" 44 55 88 aa >expect &&
>> +       {
>> +               echo20 "append " 88 44 aa 55 &&
>
> Which would slightly reduce the burden on the caller and make it read
> (very slightly) nicer:
>
>      echo20 append 88 44 aa 55 &&
>
>> +               echo for_each_unique
>> +       } | test-sha1-array >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'ordered enumeration with duplicate suppression=
' '
>> +       echo20 "" 44 55 88 aa >expect &&
>> +       {
>> +               echo20 "append " 88 44 aa 55 &&
>> +               echo20 "append " 88 44 aa 55 &&
>> +               echo for_each_unique
>> +       } | test-sha1-array >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'lookup' '
>> +       {
>> +               echo20 "append " 88 44 aa 55 &&
>> +               echo20 "lookup " 55
>> +       } | test-sha1-array >actual &&
>> +       n=3D$(cat actual) &&
>> +       test "$n" -eq 1
>> +'
>> +
>> +test_expect_success 'lookup non-existing entry' '
>> +       {
>> +               echo20 "append " 88 44 aa 55 &&
>> +               echo20 "lookup " 33
>> +       } | test-sha1-array >actual &&
>> +       n=3D$(cat actual) &&
>> +       test "$n" -lt 0
>> +'
>> +
>> +test_expect_success 'lookup with duplicates' '
>> +       {
>> +               echo20 "append " 88 44 aa 55 &&
>> +               echo20 "append " 88 44 aa 55 &&
>> +               echo20 "lookup " 55
>> +       } | test-sha1-array >actual &&
>> +       n=3D$(cat actual) &&
>> +       test "$n" -ge 2 &&
>> +       test "$n" -le 3
>> +'
>> +
>> +test_done
