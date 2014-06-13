From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 14:33:02 +0200
Message-ID: <539AEF7E.1050402@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net> <20140613114615.GE14066@sigill.intra.peff.net> <539AE8CA.50009@drmicha.warpmail.net> <539AED0C.8050107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:33:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQfR-0006Ei-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbaFMMdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 08:33:08 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38349 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750841AbaFMMdH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 08:33:07 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 79D2B2112F;
	Fri, 13 Jun 2014 08:33:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 13 Jun 2014 08:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=p1Uw8dduMIfG++MN7WX9Xb
	t0eNY=; b=jRtX6vq23n/Whx+scc0nzi9ROvZrt41A4dRwbgxIZqDEZjllmx8zdT
	laPlGmyTvoWNQfiBKUQag76KW5XwmkOuEOeEP5xcLPvnaEGe5YHjo1WRKr0IIusB
	6sDjcQawpFvGx3qxv9pOheK+UuQPtCNLBXHeWrsHRD68P/6Epb1CY=
X-Sasl-enc: yzBv1K9TIkA2CEdxh16dC1n+vtYYt5zhfUY0SuMf1QqG 1402662784
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A97446800AC;
	Fri, 13 Jun 2014 08:33:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <539AED0C.8050107@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251590>

Michael J Gruber venit, vidit, dixit 13.06.2014 14:22:
> Michael J Gruber venit, vidit, dixit 13.06.2014 14:04:
>> Jeff King venit, vidit, dixit 13.06.2014 13:46:
>>> On Fri, Jun 13, 2014 at 12:42:46PM +0200, Michael J Gruber wrote:
>>>
>>>> When t7510 was introduced, the author made sure that a for loop in
>>>> a subshell would return with the appropriate error code.
>>>>
>>>> Make sure this is true also the for the first line in each loop, which
>>>> was missed.
>>>>
>>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>>> ---
>>>>  t/t7510-signed-commit.sh | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
>>>> index 5ddac1a..a5ba48e 100755
>>>> --- a/t/t7510-signed-commit.sh
>>>> +++ b/t/t7510-signed-commit.sh
>>>> @@ -49,7 +49,7 @@ test_expect_success GPG 'show signatures' '
>>>>  	(
>>>>  		for commit in initial second merge fourth-signed fifth-signed sixth-signed master
>>>>  		do
>>>> -			git show --pretty=short --show-signature $commit >actual &&
>>>> +			git show --pretty=short --show-signature $commit >actual || exit 1
>>>>  			grep "Good signature from" actual || exit 1
>>>
>>> Hrm. The original is:
>>>
>>>   X &&
>>>   Y || exit 1
>>>
>>> Won't that still exit (i.e., it is already correct)? Doing:
>>>
>>>   for X in true false; do
>>>     for Y in true false; do
>>>       ($X && $Y || exit 1)
>>>       echo "$X/$Y: $?"
>>>     done
>>>   done
>>>
>>> yields:
>>>
>>>   true/true: 0
>>>   true/false: 1
>>>   false/true: 1
>>>   false/false: 1
>>>
>>> (and should still short-circuit Y, because we go from left-to-right).
>>>
>>> I do not mind changing it to keep the style of each line consistent,
>>> though. I would have written it as a series of "&&"-chains, with a
>>> single exit at the end, but I think that is just a matter of preference.
>>
>> If I remember correctly, I put something failing on the first line of
>> the original version, and the test succeeded. I think the point is that
>> we have a for loop in a subshell, and we need to make sure that the
>> false of one iteration is not overwritten by the true of the next one -
>> "exit 1" makes sure to "break" the for loop and exit the subshell.
>> (The chain should do that as well, I'll recheck.)
> 
> ... the chain does not, which is the point :)
> 
> With X && Y || exit 1 inside the loop, the loop statement will return
> false, but the loop will continue (if X returns false), which is exactly
> the problem that the exit avoids.
> 
> Make your example iterate over false true instead in the inner loop and
> you'll see ;)
> 
> Michael

... with this loop, sorry:

for X in true false; do
     for Y in false true; do
       ($X && $Y || exit 1)
     done
     echo "$X/last inner $Y: $?"
done

gives

true/last inner true: 0
false/last inner true: 1

even though on both cases we have at least one failure of Y. (failure of
one subtest = failure of the test)

Looping in the other order:

for X in true false; do
     for Y in true false; do
       ($X && $Y || exit 1)
     done
     echo "$X/last inner $Y: $?"
done

gives

true/last inner false: 1
false/last inner false: 1

as it should be.
