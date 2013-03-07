From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 07 Mar 2013 09:26:05 -0800
Message-ID: <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 18:26:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDeaS-0001hg-Rb
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 18:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab3CGR0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 12:26:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab3CGR0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 12:26:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C32FA820;
	Thu,  7 Mar 2013 12:26:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOXnz5mQq/8iISDm40/RIMmWtdQ=; b=uagJD6
	B6Ggi75ma1uhhmsAj9uUJkig+INgqOBFMIlAuRD3DoqCeP/CurEeej3HSODEw3QZ
	FkUTiR5rEx5+hq2XqwsGD/iJIniraioaj91nRkSFbBmhoYunTR4+4FvFEh+ufAgh
	ZLWAR1SKemRnsmkVqjsVQ8a7hyILKjyp7u0B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B206tyBof1tBXanfnrMHXzlwUKgJub/r
	ZMRrHUiiK/JNXcK1X/nDBrVXeLhvb6XXOy3QLl9qUaCqBn8Mm8j08GAo8v7vrlpa
	gYUfsDs/qt+LBoDgwzkgHTo0054Fulh1I2uzCkFPn0MpxPUZDekwHkMTKgjPmFxs
	W6JsVJetTfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EA1BA81E;
	Thu,  7 Mar 2013 12:26:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D6B1A819; Thu,  7 Mar 2013
 12:26:07 -0500 (EST)
In-Reply-To: <20130307080411.GA25506@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 7 Mar 2013 03:04:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1890AF2C-874C-11E2-A6A3-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217601>

Jeff King <peff@peff.net> writes:

> I was also curious whether it would the diff3/zealous combination would
> trigger any weird corner cases. In particular, I wanted to know how the
> example you gave in that commit of:
>
>   postimage#1: 1234ABCDE789
>                   |    /
>                   |   /
>   preimage:    123456789
>                   |   \
>                   |    \
>   postimage#2: 1234AXCYE789
>
> would react with diff3 (this is not the original example, but one with
> an extra "C" in the middle of postimage#2, which could in theory be
> presented as split hunks). However, it seems that we do not do such hunk
> splitting at all, neither for diff3 nor for the "merge" representation.

Without thinking about it too deeply,...

I think the "RCS merge" _could_ show it as "1234A<B=X>C<D=Y>E789"
without losing any information (as it is already discarding what was
in the original in the part that is affected by the conflict,
i.e. "56 was there").

Let's think aloud how "diff3 -m" _should_ split this. The most
straight-forward representation would be "1234<ABCDE|56=AXCYE>789",
that is, where "56" was originally there, one side made it to
"ABCDE" and the other "AXCYE".

You could make it "1234<AB|5=AX><C|=C><DE|6=YE>789", and that is
technically correct (what there were in the shared original for the
conflicted part is 5 and then 6), but the representation pretends
that it knows more than there actually is information, which may be
somewhat misleading.  All these three are equally plausible split of
the original "56":

	1234<AB|=AX><C|=C><DE|56=YE>789
	1234<AB|5=AX><C|=C><DE|6=YE>789
	1234<AB|56=AX><C|=C><DE|=YE>789

and picking one over others would be a mere heuristic.  All three
are technically correct representations and it is just the matter of
which one is the easiest to understand.  So, this is the kind of
"misleading but not incorrect".

In all these cases, the middle part would look like this:

	<<<<<<< ours
        C
        ||||||| base
        =======
	C
        >>>>>>> theirs

in order to honor the explicit "I want to view all three versions to
examine the situation" aka "--conflict=diff3" option.  We cannot
reduce it to just "C".  That will make it "not just misleading but
is actively wrong".
