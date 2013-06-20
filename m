From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror repos
Date: Thu, 20 Jun 2013 15:46:20 -0700
Message-ID: <7vppvgpfib.fsf@alter.siamese.dyndns.org>
References: <1371763424.17896.32.camel@localhost>
	<1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 00:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upnca-0003n6-86
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 00:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965605Ab3FTWqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 18:46:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965396Ab3FTWqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 18:46:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC3942A154;
	Thu, 20 Jun 2013 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4KHWCWocJN5hn+jTFqbD+Glyje4=; b=fPb5BB
	ymbPBNq395g6fKCiED6C8YnnX7SxhQt2oSGN2IjQa6x/TBt9Y7Kn12YWFCWqHSmC
	WV6pHdhVE9f7UGYuSRh9PleHnwCINXv+/lWg4gJgdSNHY0D1I1P5sbPUvkScLjpD
	nVAlK+bEicGPZNaKaID94UsfyhZzytCbNYCoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6Migfd0SvDrIfRlohLdKYfiYbqgP9MV
	0o9SW0OC2+waowIEY+mm7tNZ+o+I1QF/tma5ef3gp4DVAy5jRmnugw5Hi3P6zcX2
	WzGMj6C/9/DmE4GbR5GCfHjyZxOHgfQ/AkNUNVqd87zOuTNDcw7g0fA+RB6bj8sy
	tCIPtwGgJ3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3D682A153;
	Thu, 20 Jun 2013 22:46:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E83F72A151;
	Thu, 20 Jun 2013 22:46:21 +0000 (UTC)
In-Reply-To: <1371766304-4601-1-git-send-email-dennis@kaarsemaker.net> (Dennis
	Kaarsemaker's message of "Fri, 21 Jun 2013 00:11:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AB6C580-D9FB-11E2-8D63-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228553>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> When cloning a repo with --mirror, and adding more remotes later,
> get_stale_heads for origin would mark all refs from other repos as stale. In
> this situation, with refs-src and refs->dst both equal to refs/*, we should
> ignore refs/remotes/* when looking for stale refs to prevent this from
> happening.

I do not think it is a right solution to single out refs/remotes/*.

Going back to your original example:

    [remote "origin"]
            url = git://github.com/git/git.git
            fetch = +refs/*:refs/*
            mirror = true
    [remote "peff"]
            url = git://github.com/peff/git.git
            fetch = +refs/heads/*:refs/remotes/peff/*

Wouldn't you obtain "refs/remotes/github/html" from your "origin"
via "git pull origin"?  What happens to your local copy of that ref,
when it goes away from the origin and then you try to "fetch --prune
origin" the next time with this patch (and without this patch)?

What should happen?

What if you had this instead of the above version of remote.peff.*?

    [remote "peff"]
            url = git://github.com/peff/git.git
            fetch = +refs/heads/*:refs/remotes/github/*

I think this is an unsolvable problem, and I _think_ the root cause
of the issue is the configuration above that allows the RHS of
different fetch refspecs to overlap.  refs/* is more generic and
covers refs/remotes/peff/* and refs/remotes/github/*.  You cannot
even know, just by looking at "origin" and your local repository,
if refs/remotes/github/html you have should go away or it might have
come from somewhere else.

The best we _could_ do, without contacting all the defined remotes,
is probably to check each ref that we did not see from "origin" (for
example, you find "refs/remotes/peff/frotz" that your origin does
not have) and see if it could match RHS of fetch refspec of somebody
else (e.g. RHS of "refs/heads/*:refs/remotes/peff/*" matches that
ref).  Then we can conclude that refs/remotes/peff/frotz _might_
have come from Peff's repository and not from "origin", and then we
can optionally issue a warning and refrain from removing it.

This inevitably will have false positives and leave something that
did originally came from "origin", because peff may no longer have
'frotz' branch in his repository.  I do not think we can do better
than that, because we are trying to see if we can improve things
without having to contact all the remotes.

But if you go that route, the logic needs to go the same way when
you are pruning against 'peff', and anything that you do not see in
his repository right now but you have in refs/remotes/peff/ cannot
be pruned, because it might have come from your origin via more
generic refs/*:refs/* mapping.  It follows that you could never
prune anything under refs/remotes/peff/* hierarchy.

You could introduce a "assume that more specific mapping never
overlaps with a more generic mapping" rule (i.e. refs/* from RHS of
remote.origin.fetch is more generic than refs/remotes/peff/* from
RHS of remote.peff.fetch, and assume everything that you see in your
local refs/remotes/peff/* came from peff and not from origin, I
think, but at that point, is it worth the possible complexity to
code that rule in the prune codepath and brittleness of that
assumption that your origin will never add a new ref under that
hierarchy, e.g. refs/remotes/peff/xyzzy?

So, I dunno.

> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  remote.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index e71f66d..863c183 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1884,6 +1884,7 @@ struct stale_heads_info {
>  	struct ref **stale_refs_tail;
>  	struct refspec *refs;
>  	int ref_count;
> +	int ignore_remotes;
>  };
>  
>  static int get_stale_heads_cb(const char *refname,
> @@ -1903,7 +1904,8 @@ static int get_stale_heads_cb(const char *refname,
>  	 * remote we consider it to be stale.
>  	 */
>  	if (!((flags & REF_ISSYMREF) ||
> -	      string_list_has_string(info->ref_names, query.src))) {
> +	      string_list_has_string(info->ref_names, query.src) ||
> +	      (info->ignore_remotes && !prefixcmp(refname, "refs/remotes/")))) {
>  		struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
>  		hashcpy(ref->new_sha1, sha1);
>  	}
> @@ -1917,6 +1919,8 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
>  	struct ref *ref, *stale_refs = NULL;
>  	struct string_list ref_names = STRING_LIST_INIT_NODUP;
>  	struct stale_heads_info info;
> +	if(!strcmp(refs->src, "refs/*") && !strcmp(refs->dst, "refs/*"))
> +		info.ignore_remotes = 1;
>  	info.ref_names = &ref_names;
>  	info.stale_refs_tail = &stale_refs;
>  	info.refs = refs;
