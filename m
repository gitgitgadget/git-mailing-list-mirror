From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Sat, 22 Dec 2012 17:38:46 +0100
Message-ID: <50D5E216.4080006@drmicha.warpmail.net>
References: <20121211153903.7522d6b0@chalon.bertin.fr> <7vd2yg8ngk.fsf@alter.siamese.dyndns.org> <20121212094432.6e1e48c8@chalon.bertin.fr> <7v38zb3ux0.fsf@alter.siamese.dyndns.org> <877goht6eu.fsf@pctrast.inf.ethz.ch> <20121217114058.449cbc3c@chalon.bertin.fr> <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com> <m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org> <20121218120058.0c558ba5@chalon.bertin.fr> <7vehinibpc.fsf@alter.siamese.dyndns.org> <87ip7yp4mf.fsf@pctrast.inf.ethz.ch> <7vvcbx956f.fsf@alter.siamese.dyndns.org> <50D45A78.3020104@drmicha.warpmail.net> <7vzk171gvh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Yann Dirson <dirson@bertin.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 17:39:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmS6S-00022m-Ks
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 17:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab2LVQi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 11:38:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38631 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659Ab2LVQiy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 11:38:54 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3B8F9204F9;
	Sat, 22 Dec 2012 11:38:53 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Sat, 22 Dec 2012 11:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=n630MrzBQpI/fFb2qZU0B0
	OzHwc=; b=Z4Yq3xTV+mlmAVWA769i8rGpfLboEADxenAcw8UgBFuzkUShMHBhvh
	2QjUPrZJQs4hGuka/wU3qU0r8hAv0Am0lJFkSom1s5XpVEgPecO/Zpo2Bd2LXc1R
	LBg+kaxaiRpT6GsYoM2vbdZAZ46SSV8rrfb3s4fKX6k0uBVsfXZAo=
X-Sasl-enc: zdtgRZtnZ7wT2dNRjVrBJ38eDBVN5c1YwPNG/yfAzcMp 1356194332
Received: from localhost.localdomain (unknown [88.70.134.107])
	by mail.messagingengine.com (Postfix) with ESMTPA id F1D6D8E06FF;
	Sat, 22 Dec 2012 11:38:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vzk171gvh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212056>

Junio C Hamano venit, vidit, dixit 21.12.2012 17:58:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> While replace refs are much more general than grafts, it seems the two
>> main uses are:
>>
>> - grafts (change the recorded parents for a commit)
>> - svn cleanup (convert tagging commits into tag objects)
>>
>> The latter one being quite a special case already.
>>
>> The script below has helped me move from grafts to replace objects.
>> While not being super clean, something like it may be fit for contrib.
>>
>> I think we ought to help John Doe get along with parents, while we can
>> safely leave most more advanced operations to people who know how to
>> edit a raw object file. Putting that facility into "git-commit" seems to
>> be too encouraging, though - people would use replace when they should
>> use amend or rebase-i. I'd prefer a special git-replace mode (be it
>> "--graft" or "--graft-commit") which does just what my script does. We
>> could add things like "--commit-tag" later, a full blown
>> "object-factory" seems like overkill.
>>
>> Michael
>>
>> --->%---
>>
>> #!/bin/sh
>>
>> die () {
>> 	echo "$@"
>> 	rm -f "$commitfile"
>>  	exit 1
>> }
>>
>> warn () {
>> 	echo "$@"
>> }
>>
>> test $# -gt 0 || die "Usage: $0 <commit> [<parent>]*"
>>
>> for commit
>> do
>> 	git rev-parse --verify -q "$commit" >/dev/null || die "Cannot parse
>> $commit."
>> 	test x$(git cat-file -t $commit) == "xcommit" || die "$commit is no
>> commit."
> 
> s/==/=/ or you have to say #!/bin/bash on the first line, I think.
> Appears multiple times throughout this script.
> 
> 
>> done
>>
>> commit="$1"
>> shift
>>
>> commitfile=$(mktemp)
>>
>> git cat-file commit "$commit" | while read a b
>> do
>> 	if test "$a" != "parent"
>> 	then
>> 		echo $a $b
> 
> You are losing information on non-header lines by reading without
> "-r" in the above, and also multi-line headers (e.g. mergetag),
> aren't you?
>

Oh yes, it has bashisms and imperfections. It's not a submitted patch,
not even RFC. It's meant to show the git-replace mode that many users
could benefit from: works for commits only and replaces the parent list,
but takes any rev arguments as the new parents, rather than forcing the
user to specify a full sha1.

>> 	fi
>> 	if test "$a" == "tree"
>> 	then
>> 		for parent
>> 		do
>> 			echo "parent $(git rev-parse $parent)"
>> 		done
>> 	fi
>> done >$commitfile
>> hash=$(git hash-object -t commit -w "$commitfile") || die "Cannot create
>> commit object."
>> git replace "$commit" $hash
>> rm -f $commitfile
