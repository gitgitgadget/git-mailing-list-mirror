From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 15:21:55 +0200
Message-ID: <539AFAF3.9040707@viscovery.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net> <20140613114615.GE14066@sigill.intra.peff.net> <539AE8CA.50009@drmicha.warpmail.net> <539AED0C.8050107@drmicha.warpmail.net> <539AEF7E.1050402@drmicha.warpmail.net> <539AF49F.3010309@viscovery.net> <539AF748.3000901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:22:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvRQg-0003C9-NH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 15:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbaFMNV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 09:21:59 -0400
Received: from so.liwest.at ([212.33.55.14]:44911 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbaFMNV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 09:21:58 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WvRQZ-0005uU-LC; Fri, 13 Jun 2014 15:21:55 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5CC6316613;
	Fri, 13 Jun 2014 15:21:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <539AF748.3000901@drmicha.warpmail.net>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251594>

Am 6/13/2014 15:06, schrieb Michael J Gruber:
> Johannes Sixt venit, vidit, dixit 13.06.2014 14:54:
>> Am 6/13/2014 14:33, schrieb Michael J Gruber:
>>> .... with this loop, sorry:
>>>
>>> for X in true false; do
>>>      for Y in false true; do
>>>        ($X && $Y || exit 1)
>>>      done
>>>      echo "$X/last inner $Y: $?"
>>> done
>>>
>>> gives
>>>
>>> true/last inner true: 0
>>> false/last inner true: 1
>>>
>>> even though on both cases we have at least one failure of Y. (failure of
>>> one subtest = failure of the test)
>>
>> Place the loop(s) inside the subshell, and you observe termination on the
>> first failure, and a failure exit code of the subshell.
>>
>> The change proposed in this patch should not be necessary. Something else
>> must be wrong with your tests.
> 
> I know I started this (or Jeff did, who knows ;) ), but we keep
> confusing each other more and more:
> 
>> Ah, here it is:
>>
>> @@ -58,7 +58,7 @@ test_expect_success GPG 'show signatures' '
>>  	(
>>  		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
>>  		do
>> -			git show --pretty=short --show-signature $commit >actual &&
>> +			git show --pretty=short --show-signature $commit >actual || exit 1
>>  			grep "Good signature from" actual && exit 1
> 
> This is as in the original, it tests invalid signatures, so "Good
> signature" should not be in the response.
> 
>>  			! grep "BAD signature from" actual || exit 1
>>  			echo $commit OK
>>
>> Notice the '&& exit 1'! It should be '|| exit 1', right?
>>
>> -- Hannes
> 
> In other words, the original tests already had
> 
> grep foo && exit 1
> ! grep bar || exit 1
> 
> to test that we have neither foo nor bar. The reason is (supposedly) to
> have this portion of the test mostly analogous to the previous one,
> where we want foo and do want bar.
> 
> So this is completely unrelated.

I don't think so. What is the outcome of

	false &&  # simulate a regression
	grep foo && exit 1
	! grep bar || exit 1

assuming that the '! grep bar' happens to be true? Answer: The regression
is not diagnosed because the &&-chain is broken.

*That* is what I think you described earlier in this thread as "I put
something failing on the first line of the original version, and the test
succeeded."

-- Hannes
