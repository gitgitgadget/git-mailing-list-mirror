From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 06 Mar 2013 13:32:28 -0800
Message-ID: <7vmwugp637.fsf@alter.siamese.dyndns.org>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLxK-0006ei-ER
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab3CFVcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:32:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab3CFVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:32:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85EB7B084;
	Wed,  6 Mar 2013 16:32:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TN8+cavMctFTCepKwZJCE9hRBaI=; b=v7IO89
	ruL/1bE41hJQY/wjGxKkTagowikLSG/SQgkgcW38/PmmKbsn4mySUOrJLLGlGRJW
	RvswxAKuVnu2y7AYnwmjqtkGREitaJqxgQ1hq1uWhJNJ7IqcKT+OKXoZzo1pHVrK
	JCYFgIxlwEpH+7EwYIjt5EbXKElcDxtXKAmns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wm/Rl808Y8L8JcND8mwMGOEODVP1fXrz
	xUiqcP0PT5AfhP6atamNEtbIX8uwA720fYbifIiQjd8s1ZWZ/3Bh6gSPRni5iYEq
	WykpmHC0qof5UHfjAeOMM/FGyuPKKzKe5zsFYNuyNuavnQeFmI2mve66d/xPuUU3
	DxyKEu5STss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7981CB083;
	Wed,  6 Mar 2013 16:32:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD522B081; Wed,  6 Mar 2013
 16:32:29 -0500 (EST)
In-Reply-To: <7vr4jsp756.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Mar 2013 13:09:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 592EAF90-86A5-11E2-A0FC-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217550>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But it would apply to the content that is outside
>> of the hunk marker; we have changed the concept of what is in the base
>> and what is in the conflict by shrinking the conflict to its smallest
>> size.
>
> Hmm, unless you mean by "base" something entirely different from
> "what was in the common ancestor version", I do not think I can
> agree.  The point of diff3 mode is to show how it looked line in the
> common ancestor and what the conflicting sides want to change that
> common version into; letting the user view three versions to help
> him decide what to do by only looking at the part inside conflict
> markers.
>
> We show "both sides added, either identically or differently" as
> noteworthy events, but the patched code pushes "both sides added
> identically" case outside the conflicting hunk, as if what was added
> relative to the common ancestor version (in Uwe's case, is it 1-14
> that is common, or just 10-14?) is not worth looking at when
> considering what the right resolution is.  If it is not worth
> looking at what was in the original for the conflicting part, why
> would we be even using diff3 mode in the first place?

I vaguely recall we did this "clip to eager" as an explicit bugfix
at 83133740d9c8 (xmerge.c: "diff3 -m" style clips merge reduction
level to EAGER or less, 2008-08-29).  The list archive around that
time may give us more contexts.
