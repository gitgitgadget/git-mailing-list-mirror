From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Clean up reflog unreachability pruning decision
Date: Tue, 31 Mar 2009 10:44:58 -0700
Message-ID: <7vab7160yt.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903310958000.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loi34-0003AO-2K
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 19:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602AbZCaRpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 13:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbZCaRpJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 13:45:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbZCaRpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 13:45:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ED4D2A6A19;
	Tue, 31 Mar 2009 13:45:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C532AA6A18; Tue,
 31 Mar 2009 13:44:59 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903311003490.4093@localhost.localdomain>
 (Linus Torvalds's message of "Tue, 31 Mar 2009 10:09:55 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9CDBB0E-1E1B-11DE-9928-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115291>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 31 Mar 2009 09:45:22 -0700
>
> This clarifies the pruning rules for unreachable commits by having a 
> separate helpder function for the unreachability decision.
>
> It's preparation for actual bigger changes to come to speed up the
> decision when the reachability calculations become a bottleneck.
>
> In the process it also _does_ change behavior, although in a way that I 
> think is much saner than the old behavior (which was in my opinion not 
> designed, just a result of how the tests were written). It now will prune 
> reflog entries that are older than that 'prune_unreacable' time _and_ that 
> have commit references that can't be even looked up.

> Of course, "--stale-fix" also does that, and does it regardless of the age 
> of the reflog entry is, but I really think this is the right thing to do. 
> If we can't even look it up, we should consider it to be unreachable.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  builtin-reflog.c |   32 ++++++++++++++++++++++++++------
>  1 files changed, 26 insertions(+), 6 deletions(-)
>
> Note the behavioural change. I think it's sane and "ObviouslyCorrect(tm)", 
> but maybe somebody disagrees.

I did not recall initially when I was discussing this with you last night
but I think this "no commit? not prune" is intentional.  The codepath is
not about logs/heads but logs/*anything*, and we allow pointers to non
commit objects (like v2.6.11-tree).

Also even if we limit ourselves to commits, @{-N} notation can be used to
see the history of branch switching, and that does not need any underlying
objects.  I do not think it is interesting to be able to see which branch
you were on 30 days abo, though ;-)


> diff --git a/builtin-reflog.c b/builtin-reflog.c
> index d95f515..0355ce6 100644
> --- a/builtin-reflog.c
> +++ b/builtin-reflog.c
> @@ -209,6 +209,31 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
>  	return 1;
>  }
>  
> +static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsigned char *sha1)
> +{
> +	/*
> +	 * We may or may not have the commit yet - if not, look it
> +	 * up using the supplied sha1.
> +	 */
> +	if (!commit) {
> +		if (is_null_sha1(sha1))
> +			return 0;
> +
> +		commit = lookup_commit_reference_gently(sha1, 1);
> +
> +		/* We can't even look it up - consider it unreachable */
> +		if (!commit)
> +			return 1;

	/* If it is not a commit, keep it. */
        if (!commit)
        	return 0;

> +	}
> +
> +	/* Reachable from the current reflog top? Don't prune */

That's "tip of the ref", not necessarily "reflog top".

> +	if (in_merge_bases(commit, &cb->ref_commit, 1))
> +		return 0;
> +
> +	/* We can't reach it - prune it. */
> +	return 1;
> +}
> +
>  static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  		const char *email, unsigned long timestamp, int tz,
>  		const char *message, void *cb_data)
> @@ -230,12 +255,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  	if (timestamp < cb->cmd->expire_unreachable) {
>  		if (!cb->ref_commit)
>  			goto prune;
> -		if (!old && !is_null_sha1(osha1))
> -			old = lookup_commit_reference_gently(osha1, 1);
> -		if (!new && !is_null_sha1(nsha1))
> -			new = lookup_commit_reference_gently(nsha1, 1);
> -		if ((old && !in_merge_bases(old, &cb->ref_commit, 1)) ||
> -		    (new && !in_merge_bases(new, &cb->ref_commit, 1)))
> +		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
>  			goto prune;
>  	}
>  
> -- 
> 1.6.2.1.404.gb0085.dirty
