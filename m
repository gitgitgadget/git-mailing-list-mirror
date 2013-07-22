From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: use true parents for diff even when rewriting
Date: Mon, 22 Jul 2013 14:48:25 -0700
Message-ID: <7v61w2clli.fsf@alter.siamese.dyndns.org>
References: <20130722090854.GA22222@pengutronix.de>
	<a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 22 23:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ny4-0002wG-LD
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 23:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349Ab3GVVs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 17:48:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab3GVVs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 17:48:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6627833127;
	Mon, 22 Jul 2013 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=90xAxiHZQ68G
	Qlq6ZChyk001rao=; b=QlH8SW3UIFawfDD8bZwkMAz35rx8NJlqK+0ahmSYDt4z
	f/eu021cLh1aw9Lm+/Kez657llWZsYax2Cyd/YKrj5kLSvuuC6jVwwxmgMNXjJ7v
	VmKS83GCrlYPXFSOzi2BApE12mg726BKZwxVX4hBFX5QjYJdaEh3p8/QykbJjD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h0JTtH
	j3WqD289l5Lpuiif74deI2sYS30o6IUc62dEqCL8t0HwEp5yBIRB0Fwkdkv+N+Fq
	bPgfVUrLQatYVsOF7Up/uKUyOxyB9i/EgojQQiIXpffYNw5SIOMV3On041NJhVEZ
	tZKA2hXZveDNAmFNYxY4URyOa0BpqbrN9hxZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA9F33126;
	Mon, 22 Jul 2013 21:48:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E5F333125;
	Mon, 22 Jul 2013 21:48:26 +0000 (UTC)
In-Reply-To: <a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Mon, 22 Jul 2013 23:22:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 707DE410-F318-11E2-8914-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230995>

Thomas Rast <trast@inf.ethz.ch> writes:

> When using pathspec filtering in combination with diff-based log
> output, parent simplification happens before the diff is computed.
> The diff is therefore against the *simplified* parents.
>
> This works okay, arguably by accident, in the normal case: the pruned
> commits did not affect the paths being filtered, so the diff against
> the prune-result is the same as against the diff against the true
> parents.
>
> However, --full-diff breaks this guarantee, and indeed gives pretty
> spectacular results when comparing the output of
>
>   git log --graph --stat ...
>   git log --graph --full-diff --stat ...
>
> (--graph internally kicks in parent simplification, much like
> --parents).
>
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>
> Perhaps like this.  It's getting a bit late, so I'm not sure if I'm
> missing another user of the "true" parent list, but it does fix the
> issue you reported.

Conceptually I can see how this will change the history
simplification in the vertical direction (skipping the ancestry
chain and jumping directly to the closest grandparent that touched
the specified path), but I am not sure how well this interacts with
history simplification in the horizontal direciton (culling
irrelevant side branches from the merge).

> @@ -2820,6 +2821,7 @@ enum commit_action simplify_commit(struct rev_i=
nfo *revs, struct commit *commit)
>  	if (action =3D=3D commit_show &&
>  	    !revs->show_all &&
>  	    revs->prune && revs->dense && want_ancestry(revs)) {
> +		save_parents(commit);
>  		if (rewrite_parents(revs, commit, rewrite_one) < 0)
>  			return commit_error;
>  	}

After this, rewritten parent list may have shrunk by dropping
irrelevant side branches, but saved parents would have the full
parents list.  When we decide how to show diff depending on the
number of remaining parents, we would still use the rewritten
parents (which may have been reduced to a single strand of pearls)
and your change will use the original parents (which may be
multiple).

I also have to wonder if we always want to incur this save-parents
overhead, or we are better off limiting it to only when --full-diff
is in effect.

Thanks for getting the ball rolling, anyway.
