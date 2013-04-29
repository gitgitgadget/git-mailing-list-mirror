From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Mon, 29 Apr 2013 11:11:32 -0700
Message-ID: <7v1u9tjjfv.fsf@alter.siamese.dyndns.org>
References: <517AD304.6020807@bracey.fi>
	<1367004718-30048-1-git-send-email-kevin@bracey.fi>
	<7vppxfsirl.fsf@alter.siamese.dyndns.org> <517CC9AE.30407@bracey.fi>
	<7v61z6sdpz.fsf@alter.siamese.dyndns.org> <517EB205.6090804@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsY8-0003G1-JY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308Ab3D2SLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:11:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab3D2SLf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:11:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAF441A0BA;
	Mon, 29 Apr 2013 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GZoLzfFJKnGDEG8yMvXytYpgELs=; b=rtifmR
	EQuHYxctSuj6PZXmRcSjCJw08KgbrcGdFOlFNa9UemWeG1zD4/fZAGWruGAZUWmn
	9Unn4aWxDfpLXfEmHOAagl8DF9XGuDbNEQQlSy17qJn4+PsRkOAF4uZv9N7eW6m3
	M20ubi3QANDeU0M6Uk5YfBPTMwPhwJ8aB2FqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ameSAhP6UAH1jyMALgPM2N0lRSvEOj1r
	qdzhVen04zsk3UMvpcpjdm/wDrZvRqlxxlap+5VhhjjQ7nJQN0D+iYa+CepL9eni
	N+FPeo+wqeJuwE5GpDa/kOfaNkDH0SZUq2upqNOonvlLorJf+jDJq8wIOfeWmgRW
	OTX2wKaY+QM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97D51A0B9;
	Mon, 29 Apr 2013 18:11:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A0771A0B8;
	Mon, 29 Apr 2013 18:11:34 +0000 (UTC)
In-Reply-To: <517EB205.6090804@bracey.fi> (Kevin Bracey's message of "Mon, 29
	Apr 2013 20:46:45 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39B617F2-B0F8-11E2-BEED-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222834>

Kevin Bracey <kevin@bracey.fi> writes:

> At present, either query will show lots of really boring merge commits
> of topic branches at the boundary, with 1 INTERESTING parent that
> they're TREESAME too, and 1 UNINTERESTING parent that they may or may
> not be TREESAME to, depending on how old the base of that topic branch
> was. Most such commits are of no relevance to our history
> whatsoever. In the case of "--simplify-merges", the fact that they're
> UNINTERESTING actually _prevented_ their simplification - if it had
> been allowed to follow the UNINTERESTING path back further, it would
> have reached an ancestor, and been found redundant. So limiting the
> rev-list actually increases the number of merges shown.
>
> We can lose all those boring commits with these two changes:
>
> 1) Previously TREESAME was defined as "this commit matches at least 1
> parent". My first patch changes it to "this commit matches all
> parents". It should be refined further to "this commit matches all
> INTERESTING parents, if it has any, else all (UNINTERESTING)
> parents". (Can we word that better?) Note that this fancy rule
> collapses to the same straightforward TREESAME check as ever for 0- or
> 1-parent commits.
>
> 2) simplify_merges currently will not simplify commits unless they
> have exactly 1 parent. That's not what we want. We only need to
> preserve commits that don't have exactly 1 INTERESTING parent.
>
> Those 2 rules produce the desirable result: if we have a merge commit
> with exactly 1 INTERESTING parent it is TREESAME to, it is always
> simplified away - any other UNINTERESTING parents it may have did not
> affect our code, so we don't care about whether we were TREESAME to
> them or not, and as we don't want to see any of the UNINTERESTING
> parents themselves, the merge is not worth showing.
>
> This makes a massive difference on some of my searches, reducing the
> total commits shown by a factor of 5 to 10, greatly improving the
> signal-to-noise ratio.
>
> I'll put together a trial patch at the end of the next iteration of
> the series that implements this logic. I need to think a bit more - I
> think "get_commit_action" needs a similar INTERESTING check for merges
> too, to get the same sort of effect without relying on
> simplify_merges. Parent rewriting shouldn't necessitate keeping all
> merges - only merges with 2+ INTERESTING parents.

Everything you wrote above makes tons of sense.

One small worry is how this new simplification interacts with the
first parent mode. For the purpose of showing the merge commit
itself, the second and subsequent parents are treated as "not
INTERESTING" in the above discussion, but that should not propagate
back to their parents like the normal UNINTERESTING-ness does.
