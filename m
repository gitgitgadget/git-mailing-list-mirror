From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] sha1-lookup: fix handling of duplicates in sha1_pos()
Date: Wed, 01 Oct 2014 13:10:12 +0200
Message-ID: <542BE114.9070300@web.de>
References: <542BCBFC.5000509@web.de> <542BCCB9.4050908@web.de> <20141001105006.GB10332@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHoe-0003ue-1T
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbaJALLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 07:11:24 -0400
Received: from mout.web.de ([212.227.15.4]:58446 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbaJALLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 07:11:23 -0400
Received: from [192.168.178.27] ([79.250.168.13]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MgwSG-1XvEVv1JGi-00M5di; Wed, 01 Oct 2014 13:11:07
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <20141001105006.GB10332@peff.net>
X-Provags-ID: V03:K0:uU5kexUUEV4H01C0mML8zqea+yIxPhRR1ESH8OAKK+1aBNLCxih
 Hj/9CUBMStPnwo/Z6G41tc2qry+Q8pozOin5DC1A2nrGhFrrhx7So7R+RbAIm9KDDfRxgO/
 iI7rnX0krgz6RW0HbnIK0VNRdO7Rz/Q8yyi0ri50ytGuRVlLP0vFObyn2Y6KnRxKwIX3Osz
 Fy3KX9BxMMce9G9LpGatw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257739>

Am 01.10.2014 um 12:50 schrieb Jeff King:
> On Wed, Oct 01, 2014 at 11:43:21AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> If the first 18 bytes of the SHA1's of all entries are the same then
>> sha1_pos() dies and reports that the lower and upper limits of the
>> binary search were the same that this wasn't supposed to happen.  Th=
is
>> is wrong because the remaining two bytes could still differ.
>>
>> Furthermore: It wouldn't be a problem if they actually were the same=
,
>> i.e. if all entries have the same SHA1.  The code already handles
>> duplicates just fine otherwise.  Simply remove the erroneous check.
>
> Yeah, I agree that assertion is just wrong.
>
> Regarding duplicates: in sha1_entry_pos, we had to handle the "not
> found" case specially, because we may have found the left-hand or
> right-hand side of a run of duplicates, and we want to return the
> correct slot where the new item would go (see the comment added by
> 171bdac). I think we don't have to deal with that here, because we ar=
e
> just dealing with the initial "mi" selection. The actual binary searc=
h
> is plain-vanilla, which handles that case just fine.
>
> I wonder if it is worth adding a test (you test only that "not found"
> produces a negative index, but not which index). Like:

api-sha1-array.txt says about sha1_array_lookup: "If not found, returns=
=20
a negative integer", and that's what the test checks.

I actually like that the value is not specified for that case because n=
o=20
existing caller actually uses it and it leaves room to implement the=20
function e.g. using bsearch(3).

I agree that adding a "lookup non-existing entry with duplicates" test=20
would make t0064 more complete, though.

> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
> index 3fcb8d8..7781129 100755
> --- a/t/t0064-sha1-array.sh
> +++ b/t/t0064-sha1-array.sh
> @@ -42,12 +42,12 @@ test_expect_success 'lookup' '
>   '
>
>   test_expect_success 'lookup non-existing entry' '
> +	echo -1 >expect &&
>   	{
>   		echo20 "append " 88 44 aa 55 &&
>   		echo20 "lookup " 33
>   	} | test-sha1-array >actual &&
> -	n=3D$(cat actual) &&
> -	test "$n" -lt 0
> +	test_cmp expect actual
>   '
>
>   test_expect_success 'lookup with duplicates' '
> @@ -61,6 +61,17 @@ test_expect_success 'lookup with duplicates' '
>   	test "$n" -le 3
>   '
>
> +test_expect_success 'lookup non-existing entry with duplicates' '
> +	echo -5 >expect &&
> +	{
> +		echo20 "append " 88 44 aa 55 &&
> +		echo20 "append " 88 44 aa 55 &&
> +		echo20 "lookup " 66
> +	} | test-sha1-array >actual &&
> +	test_cmp expect actual
> +'
> +
> +
>   test_expect_success 'lookup with almost duplicate values' '
>   	{
>   		echo "append 5555555555555555555555555555555555555555" &&
>
