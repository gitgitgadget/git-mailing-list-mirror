From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/4] tag: speed up --contains calculation
Date: Wed, 13 Oct 2010 17:07:53 -0500
Message-ID: <20101013220753.GA8674@burratino>
References: <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123335.GA25699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:11:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69Xj-0005Wz-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab0JMWLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:11:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36339 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab0JMWLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:11:19 -0400
Received: by qwa26 with SMTP id 26so1275059qwa.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=K0lY8TbajTmAltaMwdFLww7IVs6bahwcBwN8FrF5MjA=;
        b=Y63q2SJdRxGhtmVNaOp6J9zKlAytomwvCt0Fw0njVpyFci3jHcoCAiMxwAhfy2MWOH
         i0Ow/i7Hw0nuHjG1DEN3I+QINrdtHgnfm4uakV6fgoZ4+MwRmXO0Emx4Q69MAD0g+MmK
         5bjlTlKi0rHpj07syknyOrCD742zUi6CZNZJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cr1qZ4nkY41c5o6hhmFhkSXssWRKuQdoDSo0Bfyzfzv6FWSZyY5GIa1YVq22aVsmB6
         sDcn7wpMwRccijc96Kfsa5GWAdq6rfP1Tio91vu4E53j6DVc1EyOheqRJk5y6vyuOVtR
         997UfOyJa7FtjDJ0s7P3UUKu4SGr8S0Aj2tME=
Received: by 10.224.67.193 with SMTP id s1mr3123135qai.86.1287007878015;
        Wed, 13 Oct 2010 15:11:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e18sm3189181vcf.36.2010.10.13.15.11.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 15:11:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100705123335.GA25699@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158992>

Hi,

Jeff King wrote:

> When we want to know if commit A contains commit B (or any
> one of a set of commits, B through Z),

Let's revive this old thread.  Sorry for the long silence (the last
time this topic was visited was a couple months ago [1] afaict).

> Instead, let's leverage the fact that we are going to use
> the same --contains list for each tag, and mark areas of the
> commit graph is definitely containing those commits, or
> definitely not containing those commits. Later tags can then
> stop traversing as soon as they see a previously calculated
> answer.

Makes sense.  And the resulting timings are exciting.

> ---
> Note that this is a depth first search, whereas we generally traverse in
> a more breadth-first way. So it can actually make things slightly slower
> than the current merge-base code, if:
> 
>   1. You don't have any merge base calculations that involve going very
>      far back in history.
> 
>   2. We depth-first down the wrong side of a merge.
> 
> However, in the usual cases, I think it will perform much better.

Nit: Wouldn't this (or a summary of it) belong in the log message, too,
to avoid headscratching when a person tries to bisect a performance
regression down the line?

>   1. This can probably be a one-liner change to use in "git branch
>      --contains", as well. I didn't measure it, as that already tends to
>      be reasonably fast.

These days "branch -r --contains" has been _sloow_ for me.  So once
this is tuned, that wouldn't be a bad idea, methinks.

>   2. It uses commit marks, which means it doesn't behave well with other
>      traversals. I have no idea if I should be using alternate marks or
>      not.

This is what Junio was referring to with "the use of TMP_MARK smelled
somewhat bad to me", right?

>   3. We never clear the marks, or check them against the "want" list.

This too, I suppose.

> So
>      we just assume that repeated calls to contains will have the same
>      "want" list.

As long as this is advertised, I think it is fine.  If someone needs
to use --contains for multiple purposes in a builtin, that can be
dealt with then (maybe with a separate function to reset the marks).

Maybe it would make sense to keep this static in builtin/tag.c for
now, and defer cleaning up the interface to a separate patch.

> --- a/commit.c
> +++ b/commit.c

Now the meat of the patch.  git has a few algorithms for checking if
one commit is an ancestor of another.

is_descendant_of::

	1. find merge bases.  This is breadth-first search in
	   date order, but it walks through all ancestors as far
	   as I can tell.
	2. make them independent (seems pointless...).
	3. check if ancestor is one of them.

get_revision after setting UNINTERESTING (i.e., rev-list -1 ^tag cmit)::

	1. find interesting and uninteresting commits.  This is
	   breadth-first search in date order.
	2. when the first interesting commit is found, emit it
	   and stop.

Neither is optimized to check a batch of commits to find which contain
the commit of interest.

join_revs of show-branch::

	1. color the tag and cmit.
	2. let colors propagate back to all their ancestors, stopping
	   propagation along a given path when a commit has all colors.
	   This is breadth-first traversal in date order.
	3. for each commit with all colors, propagate that knowledge
	   to all parents we've encountered before.
	4. check what colors cmit has.

limit_to_ancestry::

	1. compute rev-list ^cmit tag in the usual way.
	2. reverse the revision list.
	3. color cmit with TMP_MARK and let that color permeate
	   up the backwards revision list.
	4. repeat! until no progress is made.
	4. check what color tag has.

None of these seem to tolerate timestamp skew. :(

Am I understanding correctly?

If so, just making is_descendant_of less stupid (e.g., not traversing
all history) would presumably help a lot.  Another approach would be
to try the show-branch tactic repeatedly with small enough batches of
tags to fit in the flag bitfield.  Yet another approach would be to
take the limit_to_ancestry one, but if the revision list is not
topologically sorted, it could be slow.

Hopefully your approach will be even better...

> @@ -845,3 +845,45 @@ int commit_tree(const char *msg, unsigned char *tree,
[...]
> +static int contains_recurse(struct commit *candidate,
> +			    const struct commit_list *want)
> +{
> +	struct commit_list *p;
> +
> +	/* was it previously marked as containing a want commit? */
> +	if (candidate->object.flags & TMP_MARK)
> +		return 1;
> +	/* or marked as not possibly containing a want commit? */
> +	if (candidate->object.flags & UNINTERESTING)
> +		return 0;
> +	/* or are we it? */
> +	if (in_commit_list(want, candidate))
> +		return 1;
> +
> +	if (parse_commit(candidate) < 0)
> +		return 0;
> +
> +	/* Otherwise recurse and mark ourselves for future traversals. */
> +	for (p = candidate->parents; p; p = p->next) {
> +		if (contains_recurse(p->item, want)) {
> +			candidate->object.flags |= TMP_MARK;
> +			return 1;
> +		}
> +	}
> +	candidate->object.flags |= UNINTERESTING;

Nice.  We cache the "is wanted" result using TMP_MARK and
UNINTERESTING.  It cannot be slower than is_descendant_of if I
understood correctly because the latter is a little crazy.

Possible unprincipled approach:

 1. Mark the wanted commits with TMP_MARK.
 2. Perform a breadth-first, date-order search starting at
    candidate to find a commit with TMP_MARK.
    a. If not found, mark the commits involved as UNINTERESTING
    b. If found, let the TMP_MARK permeate up using the
       limit_to_ancestry algorithm.
 3. Repeat with each other candidate.
 4. (If needed) walk starting at each candidate to clear the
    temporary flags.

I am not sure if that would be any faster, though.  What do you think?

[...]
> +int contains(struct commit *, const struct commit_list *);

Thanks for a pleasant read.

[1] http://thread.gmane.org/gmane.comp.version-control.git/152607/focus=152701
