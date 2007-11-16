From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v2] Fix git-tag test breakage caused by broken sed on Leopard
Date: Fri, 16 Nov 2007 18:25:43 +0100
Message-ID: <E4B5D2FD-5757-4178-B77C-1D61E7B3F589@wincent.com>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site> <90D416F6-A3CA-43C8-B71F-38EA955A762B@wincent.com> <C9DFAD77-DFEF-47AC-83D5-CFDF245D95E4@wincent.com> <7v4pfm3h6f.fsf@gitster.siamese.dyndns.org> <7A6820DE-C6EE-4E3E-A97F-97766F682B85@wincent.com> <03D3DFCD-B5F7-47CF-AFD2-F1408BB11AB3@wincent.com> <20071116165944.GB29272@glandium.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It4y0-0004sQ-F9
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 18:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbXKPR0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 12:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXKPR0h
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 12:26:37 -0500
Received: from wincent.com ([72.3.236.74]:42427 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbXKPR0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 12:26:37 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGHPiME026001;
	Fri, 16 Nov 2007 11:26:00 -0600
In-Reply-To: <20071116165944.GB29272@glandium.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65232>

El 16/11/2007, a las 17:59, Mike Hommey escribi=F3:

> On Fri, Nov 16, 2007 at 02:48:09PM +0100, Wincent Colaiuta wrote:
>> El 16/11/2007, a las 14:45, Wincent Colaiuta escribi=F3:
>>
>>> El 16/11/2007, a las 6:14, Junio C Hamano escribi=F3:
>>>
>>>> Wincent Colaiuta <win@wincent.com> writes:
>>>>
>>>>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>>>>> index 096fe33..b54c2e0 100755
>>>>> --- a/t/t7004-tag.sh
>>>>> +++ b/t/t7004-tag.sh
>>>>> @@ -1007,7 +1007,7 @@ test_expect_failure \
>>>>> test_expect_success \
>>>>> 	'message in editor has initial comment' '
>>>>> 	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
>>>>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>>>>> +	test $(grep -e "^#" -e "^\$" actual | wc -l ) -gt 0
>>>>> '
>>>>
>>>> Heh, doesn't grep exit with zero only when it found some lines
>>>> that match the pattern already?  What's that "wc -l" for?
>>>
>>>
>>> I was just trying to make the minimal change (swapping grep for
>>> sed), but if you want a shorter version then we don't even need the
>>> "test"; it could just be:
>>>
>>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>>> +	grep -e "^#" -e "^\$" actual
>>
>> Although I don't know if we should be testing for empty lines there
>> because an 0-byte empty "actual" file would spuriously pass the test=
=2E
>> Perhaps this would be better:
>>
>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>> +	grep -e "^#" actual
>
> Matching both would as in your previous pseudo patch wouldn't catch
> empty file. On the other hand, both my initial bloated version and =20
> yours
> won't catch a file that doesn't contain the comment.

But if git-tag works then it will contain a comment; and isn't the =20
purpose of the test to confirm the comment's presence?

> grep -e "^$" actual && grep -e "^#" actual would actually be a better
> test.

What are we really trying to test here? The test is labelled as =20
'message in editor has initial comment'. Basically the editor will be =20
prepopulated with a blank line followed by this:

#
# Write a tag message
#

So it's the presence of that text which we want to confirm.

If I understand the intent of the original sed-based test, it was to =20
confirm that there were 1 or more lines that started with "#" or were =20
empty. It also suffered from the bug that an empty message (by which I =
=20
mean a 1-byte file containing only an LF) would pass the test =20
(spuriously in my opinion), and my first attempt faithfully translated =
=20
that bug into grep syntax.

The alternative you suggest will (correctly) fail on a zero byte file, =
=20
and pass on 1-byte file containing only a LF, just like the other =20
approaches. So I'm still wondering, what is it that we're trying to =20
test here? We could test for the exact "Write a tag message" text, but =
=20
that may be brittle (must be updated if/when the text ever changes), =20
but looking at other tests I see there are some which do precise =20
equality tests for expected results.

Cheers,
Wincent
