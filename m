From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 07 Mar 2013 10:21:52 -0800
Message-ID: <7vk3pjm5of.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 19:22:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfSX-0007eP-8D
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759336Ab3CGSV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:21:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756744Ab3CGSVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:21:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4DC2AA51;
	Thu,  7 Mar 2013 13:21:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jcZzfY1jQ7hP42RPTn9uJQtNNGU=; b=J63M25
	enJfPPvf5fw/qjPQlAuKyctz8XooKlApkDVX6Q/XDFJPj3wu/oiSoBnJEftHvYRm
	DUYkJLjzFqMA57gkW5y/H8+GjJNVAMsWsAl/rhA6xgdj5Ppr7p44LRY81rclcGxP
	oKCJ6l0Zv7FOwkasvM6ttzYeCgQU1g1P1OuGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UhuYPl7M+/GuQhoU4jjOdjL1XQoFsCD9
	7xtifbUhp82/B2oBxDV6qSA2PYifXJGpA7ayhrIlG6Fv6tz5glyfWd86p6uiNCdw
	wM4hrRVLzweKpiqEweQMQCOelIaRJc8UfWb8xmRIS+TrgdPk/ALJHwa9+E12eWHT
	HXCtEruP4ME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D212AAA4F;
	Thu,  7 Mar 2013 13:21:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2458AAA4E; Thu,  7 Mar 2013
 13:21:54 -0500 (EST)
In-Reply-To: <7v1ubrnmtu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 07 Mar 2013 09:26:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3647EFC-8753-11E2-8618-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217605>

Junio C Hamano <gitster@pobox.com> writes:

> You could make it "1234<AB|5=AX><C|=C><DE|6=YE>789", and that is
> technically correct (what there were in the shared original for the
> conflicted part is 5 and then 6), but the representation pretends
> that it knows more than there actually is information, which may be
> somewhat misleading.  All these three are equally plausible split of
> the original "56":
>
> 	1234<AB|=AX><C|=C><DE|56=YE>789
> 	1234<AB|5=AX><C|=C><DE|6=YE>789
> 	1234<AB|56=AX><C|=C><DE|=YE>789
>
> and picking one over others would be a mere heuristic.  All three
> are technically correct representations and it is just the matter of
> which one is the easiest to understand.  So, this is the kind of
> "misleading but not incorrect".

I forgot to say that youu could even do something silly like:

	1234<AB|=AX><C|56=C><DE|=YE>789

;-)

> In all these cases, the middle part would look like this:
>
>       <<<<<<< ours
>       C
>       ||||||| base
>       =======
>       C
>       >>>>>>> theirs
>
> in order to honor the explicit "I want to view all three versions to
> examine the situation" aka "--conflict=diff3" option.  We cannot
> reduce it to just "C".  That will make it "not just misleading but
> is actively wrong".

I also forgot to say that the issue is the same to reduce

 	1234<AB|=AX><C|=C><DE|56=YE>789

to

 	1234<A|=A><B|=X><C|=C><D|56=Y><E|=E>789

which is unconditionally correct and then for all x reduce <x|=x> to
x, yielding

 	1234A<B|=X>C<D|56=Y>E789

which your zealous-diff3 would do.  So squashing that <C|=C> in the
middle would be consistent if you take the zealous-diff3 route.

But again, that is discarding the information of the original, which
the user explicitly asked from "diff3 -m", i.e. show all three to
examine the situation. If the user wants to operate _without_ the
original, the user would have asked for "RCS merge" style output, so
I am still not sure if that is a sensible mode of operation for diff3
to begin with.



	
