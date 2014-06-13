From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 15:06:16 +0200
Message-ID: <539AF748.3000901@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net> <20140613114615.GE14066@sigill.intra.peff.net> <539AE8CA.50009@drmicha.warpmail.net> <539AED0C.8050107@drmicha.warpmail.net> <539AEF7E.1050402@drmicha.warpmail.net> <539AF49F.3010309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvRBY-0004yK-6m
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 15:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbaFMNGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 09:06:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37547 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750811AbaFMNGT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 09:06:19 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EA20820BC2;
	Fri, 13 Jun 2014 09:06:18 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 13 Jun 2014 09:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=9gjKmgeVXsE5Y3O5pyDv3f
	OVQiQ=; b=Ce0ZVA+oJOxJdFeBiEwzbI5GxFwUcGx5YwyYsym6xKu44rDVhWAHYp
	BJOKLIDEQFGtqhGP3h35u4BaS61CADZZe7BPyHsTLBy4/vnugU4GIYUpy/5VanO5
	c5npWH3rRoDHilteiVVqbnf+d1MSf465ZZvt15hYeQ8H4IASTNI8I=
X-Sasl-enc: Pt20kyQZove3zFZsYDKQOwDauBTIeXVxkNGXcHC916ik 1402664778
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 254E66800AC;
	Fri, 13 Jun 2014 09:06:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <539AF49F.3010309@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251593>

Johannes Sixt venit, vidit, dixit 13.06.2014 14:54:
> Am 6/13/2014 14:33, schrieb Michael J Gruber:
>> .... with this loop, sorry:
>>
>> for X in true false; do
>>      for Y in false true; do
>>        ($X && $Y || exit 1)
>>      done
>>      echo "$X/last inner $Y: $?"
>> done
>>
>> gives
>>
>> true/last inner true: 0
>> false/last inner true: 1
>>
>> even though on both cases we have at least one failure of Y. (failure of
>> one subtest = failure of the test)
> 
> Place the loop(s) inside the subshell, and you observe termination on the
> first failure, and a failure exit code of the subshell.
> 
> The change proposed in this patch should not be necessary. Something else
> must be wrong with your tests.

I know I started this (or Jeff did, who knows ;) ), but we keep
confusing each other more and more:

> Ah, here it is:
> 
> @@ -58,7 +58,7 @@ test_expect_success GPG 'show signatures' '
>  	(
>  		for commit in merge^2 fourth-unsigned sixth-unsigned seventh-unsigned
>  		do
> -			git show --pretty=short --show-signature $commit >actual &&
> +			git show --pretty=short --show-signature $commit >actual || exit 1
>  			grep "Good signature from" actual && exit 1

This is as in the original, it tests invalid signatures, so "Good
signature" should not be in the response.

>  			! grep "BAD signature from" actual || exit 1
>  			echo $commit OK
> 
> Notice the '&& exit 1'! It should be '|| exit 1', right?
> 
> -- Hannes

In other words, the original tests already had

grep foo && exit 1
! grep bar || exit 1

to test that we have neither foo nor bar. The reason is (supposedly) to
have this portion of the test mostly analogous to the previous one,
where we want foo and do want bar.

So this is completely unrelated.

Otoh, it seems the original test could have had

a &&
b &&
c || exit 1

or

a || exit 1
b || exit 1
c || exit 1

rather than

a &&
b || exit 1
c || exit 1

which I thought was incorrect (but I can't recreate the proof right
now). I'd say both of the former versions are preferable to the last one
unless there is a difference that neither Jeff nor I see.

I need a break before looking at this again ;)

Michael
