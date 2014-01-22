From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make 'git request-pull' more strict about matching local/remote branches
Date: Wed, 22 Jan 2014 13:46:54 -0800
Message-ID: <xmqq1tzzy9ip.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 22:47:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W65da-0007LM-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbaAVVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:47:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbaAVVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 16:47:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E179264F1F;
	Wed, 22 Jan 2014 16:46:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CAP5hvj1qLgrCKoKM+JBz3ACidA=; b=kRte/x
	xGjH8mpMoWIvhir3jp8dI0PndWK5eupe8zbk5f2ipJ6E3yNxWGRxcr1pMLPwgN4g
	PTxI4LL1ypB7XVLjR555kvNpG5Cnzj2oP98YM+9DuTZ+55IUh/TARjYwbj6BGhp4
	y0kjLWYRJA5iFKUnfMA98Q6Ss1+B4F9WNMONw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qmDmqP6Z2S/N5K/5Vspu8IIzefVOGuAN
	TlfgnC+pbDCo8TpVbKWw5aSo/WpfjK8sQqzZAG+M9914Ag6oa97mrnnfaQOHcTEI
	mwWhfqiPNiZNgu5w3Etfu6DXAAT+BgVwQUkqHGPSxFMPOV+goAfpisOXq5SIRYfU
	vR/luM0w9wo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4E9D64F1E;
	Wed, 22 Jan 2014 16:46:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C52864F1C;
	Wed, 22 Jan 2014 16:46:57 -0500 (EST)
In-Reply-To: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 22 Jan 2014 13:08:54 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B77210AE-83AE-11E3-8A5D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240864>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This means that git request-pull will never rewrite the ref-name you gave 
> it.  If the local branch name is "xyzzy", that is the only branch name 
> that request-pull will ask the other side to fetch.
>
> If the remote has that branch under a different name, that's your problem 
> and git request-pull will not try to fix it up (but git request-pull will 
> warn about the fact that no exact matching branch is found, and you can 
> edit the end result to then have the remote name you want if it doesn't 
> match your local one).
>
> The new "find local ref" code will also complain loudly if you give an
> ambiguous refname (eg you have both a tag and a branch with that same
> name, and you don't specify "heads/name" or "tags/name").

I agree with the basic direction, especially the part "we will never
rewrite", is quite attractive.

But this part might be a bit problematic.  $3=master will almost
always have refs/heads/master and refs/remotes/origin/master listed
because the call to "show-ref" comes before "rev-parse --verify",
no?

> +head=$(git symbolic-ref -q "${3-HEAD}")
> +head=${head:-$(git show-ref "${3-HEAD}" | cut -d' ' -f2)}
> +head=${head:-$(git rev-parse --quiet --verify "$3")}
> +
> +# None of the above? Bad.
> +test -z "$head" && die "fatal: Not a valid revision: $3"
> +
> +# This also verifies that the resulting head is unique:
> +# "git show-ref" could have shown multiple matching refs..
>  headrev=$(git rev-parse --verify --quiet "$head"^0)
> -if test -z "$headrev"
> +test -z "$headrev" && die "fatal: Ambiguous revision: $3"

... and it would die here.  $3=for-linus may be the most common case
on the kernel list, and remotes/origin/for-linus may be unlikely to
appear in the real life (hmph, really?  perhaps people keep track of
what they pushed out the last time with it, I dunno).
