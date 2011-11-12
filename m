From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reset reports file as modified when it's in fact deleted
Date: Fri, 11 Nov 2011 16:11:29 -0800
Message-ID: <7vhb2aqjwu.fsf@alter.siamese.dyndns.org>
References: <20111107094330.GB10936@beez.lab.cmartin.tk>
 <20111107162642.GA27055@sigill.intra.peff.net>
 <20111111140834.GA10025@beez.lab.cmartin.tk>
 <7vr51er4nd.fsf@alter.siamese.dyndns.org>
 <20111111182109.GB16055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 12 01:13:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP1Dy-0005B9-1J
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 01:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab1KLALd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 19:11:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab1KLALc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 19:11:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8178A60A8;
	Fri, 11 Nov 2011 19:11:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yxdVlOl4RV76JRWRIYoUD/KccnQ=; b=IAn96P
	ugGP7Yriqdrh6FRkGI6qycreiz3x2lO93YYiYTYyOO4cucarYsQj/e9CEmR2ARfx
	bxR9m+nHQMMkIj03t1p/4hivSoMNKPU9E4RxSaUCYQbHYulvZygXZv4Xk/yZdTca
	SQSNOTng/k4ZYFV4XU1RHdf4w2Y4R/OLXiY8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oUUhxZyxL2YLLuvxyVWL4MOZKlOm7xo7
	rGwpH6UfzMrLn7jTPTQ3miIvwj0kB8hd8vsxXTcFveANf7VnZoVCrYzB01fcoirX
	z6sMhlUBdRrCTkbXVYuzx6aDGtp0GXhgZu9UCppjLxV4Sb2tc7gh6dMwytkIlBqZ
	lVFhKinn0sU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78EB760A7;
	Fri, 11 Nov 2011 19:11:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF41C60A5; Fri, 11 Nov 2011
 19:11:30 -0500 (EST)
In-Reply-To: <20111111182109.GB16055@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 11 Nov 2011 13:21:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF5F8DE0-0CC2-11E1-AB78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185295>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 11, 2011 at 08:43:34AM -0800, Junio C Hamano wrote:
>
> I agree the naming is awkward (but then, I think the "needs update"
> message is awkward ;) ). But my interpretation was: if you want the
> index to be in sync with the working tree, you must do this. Hence:
>
>   $EDITOR file             ;# triggers needs_update
>   git update-index file    ;# and do update in index
>   rm file                  ;# triggers needs rm
>   git rm --cached file     ;# and do rm in index

The word "update" at the plumbing level simply means "update the path in
the index". At the Porcelain level you have to use "git add" or "git rm"
depending on different kind of "needs update", which may be argued an
inconsistency, but at the plumbing level everything is done with the same
update-index command, and "needs update" is the word that matches your
interpretation.

I however think the topic was about updating the Porclain-ish output that
is similar to "status -s" output. And at that level, paths marked with M/T
and D are dealt differently by end users ("add" vs "rm").

And the ? : expressions the patch is touching is about mapping the state
of the path to your "you must do this" interpretation. What is being
mapped is the state, so it would be more natural to have the variable
"modified_fmt" hold the result of the mapping "you must do...", instead of
calling the variable in terms of "you must do this if you were working at
the plumbing level", which is where the original needs_update_fmt naming
comes from.

>> An obvious solution would be to rename all of them to be based on "what
>> happened to the path". E.g. "modified_fmt" would be set to either "M" or
>> "needs update", and "removed_fmt" would be set to either "D" or "needs
>> update", etc.
>
> I'm happy to make that change. What do you think of the feature overall?

The "feature" is more or less "Meh" to me; I do not mind differentiating M
and D there because the necessary information is already there in the
codepath, but if we were to really do that, then the variables must be
renamed. We shouldn't name them after "you must do this at the plumbing
level" like we have done so far, and instead use "the path is in this
state". This is even more so if we were to further split a single "state"
that plumbing layer considers the same and gives the same "needs X" to
different states that Porcelains would give different messages in the
future.

> And should typechanges also be handled here (it's no extra work for git
> to detect them; we just have to pass the TYPE_CHANGED flag back up the
> stack)?

As long as "pass ... back up the stack" does not result in too much
ugliness in the code, I am OK with it.
