From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] push: add 'prune' option
Date: Fri, 17 Feb 2012 14:34:24 -0800
Message-ID: <7vobsxqebz.fsf@alter.siamese.dyndns.org>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 23:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyWNu-0004nX-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 23:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2BQWe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 17:34:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab2BQWe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 17:34:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E4C16D23;
	Fri, 17 Feb 2012 17:34:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/bcMqM7RYxSUwxKI3z0q+/YM0Lw=; b=ssP+LOEY0wSYU28qjvzH
	HeBUbysr2H7xpLSeIDTxfbhY3ldPiiqKuMxpvFzCBXkPm9MZkEGEIt7jx7N1Lim7
	c6eMIVDN3LUYfnegJ/Oqr3dahdUxUBPANoAswofNg/9Xm7Q72K5L/X0IVDa+fyLI
	Ru9QfEYu51Sr1Tr6IST/S8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VNSKPJmI9HzK5bTnMnsPbPqEks9+s6Wi3YIpVac7W7KdvJ
	ny3yfguwSEveGqSWx+4iLTfBHTMgODZnN8ZvIoXeIvaKtU1YsXlN5j4iy5nQCe4P
	ikeN8qJ1oeYVBha2FJjLFycHvemFZ0E9B3lFTECuvqVuYo/Kxbb5IC1kNssZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45D666D22;
	Fri, 17 Feb 2012 17:34:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 762166D21; Fri, 17 Feb 2012
 17:34:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BAADF6E-59B7-11E1-8D3F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190985>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This will allow us to remove refs from the remote that have been removed
> locally.

Can you enhance this a bit more to summarize the gist of what the semantic
of this new feature is, perhaps like this:

	After pushing refs, "git push --prune" will remove refs from the
	remote that existed before the push and would have been pushed
	from us if we had some local refs that would have matched the
	refspecs used.  For example,

           $ git push --prune remote refs/heads/*:refs/remotes/repo1/*

	will push all local branches in our repository to refs with
	corresponding names under refs/remotes/repo1/ at the remote, and
	removes remote's refs in refs/remotes/repo1/ that no longer have
        corresponding local branches in our repository.  The refs at the
        remote outside refs/remotes/repo1/ are not affected.

In order to alley the worries raised in the previous discussion, something
to the effect of the last sentence above is crucial to have, I would think. 

> It's useful to conveniently synchronize all the local branches to
> certain remote.

When an update to this patch comes with a documentation update to
illustrate how to exercise this useful feature with an example, it will
start to make sense to write "this is useful" in the log message.  I know
you haven't gotten around the documentation part while the patch is marked
as RFC, and that is OK.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c |    2 ++
>  remote.c       |   29 ++++++++++++++++++++++++++---
>  remote.h       |    3 ++-
>  transport.c    |    2 ++
>  transport.h    |    1 +
>  5 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 35cce53..46b99b1 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -261,6 +261,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
>  			TRANSPORT_PUSH_SET_UPSTREAM),
>  		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
> +		OPT_BIT('p', "prune", &flags, "prune locally removed refs",
> +			TRANSPORT_PUSH_PRUNE),

Please refrain from squatting on a short-and-sweet one letter option
before this new feature proves to be popular and useful in a few cycles,
especially when there already is a long option that begins with 'p'.

>  		OPT_END()
>  	};
>  
> diff --git a/remote.c b/remote.c
> index 019aafc..0900bb5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1111,7 +1111,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
>  }
>  
>  static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref *ref,
> -		int send_mirror, const struct refspec **ret_pat)
> +		int send_mirror, int dir, const struct refspec **ret_pat)

Can we name this a bit better?  I first thought "Huh? directory?", and had
to scratch my head, wondering if it is an offset into refs/heads/* string
or something....

>  {
>  	const struct refspec *pat;
>  	char *name;
> @@ -1126,7 +1126,12 @@ static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref
>  
>  		if (rs[i].pattern) {
>  			const char *dst_side = rs[i].dst ? rs[i].dst : rs[i].src;
> -			if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name)) {
> +			int match;
> +			if (dir == 0)
> +				match = match_name_with_pattern(rs[i].src, ref->name, dst_side, &name);
> +			else
> +				match = match_name_with_pattern(dst_side, ref->name, rs[i].src, &name);

....until the code told us that it is some sort of direction of the
matching.  A symbolic constant or two would be even better.

Originally this funcion was fed a list of refs in the source (i.e. on our
end, as this is only used in 'push') and matched them against the source
side of the refspec, rs[i].src, to see under what name the destination
side will store it (i.e. give dst_side as value to find out the result in
&name).  This patch adds a new caller, who feeds a list of refs in the
destination (i.e. on the remote end) to find out how they map to the names
on our end (i.e. source).  So "direction" is not necessarily incorrect; it
is the direction this function maps the names (either src-to-dst for the
original caller, or dst-to-src for the new caller).

Perhaps "enum map_direction { SRC_TO_DST, DST_TO_SRC }" or something?

> +			if (match) {
>  				matching_refs = i;
>  				break;
>  			}

So what is the updated semantics of this function?  Is it still
appropriate to name it "check_pattern_match()"?

It seems that by now this does a lot more than just "check if a pattern
matches".  Since your patch 2/3, it is a function that finds out the
refname in the remote that the given one refspec would try to update, and
with this patch, it can also map in the reverse direction, given the list
of remote refs, finding out which local ref a refspec would use to update
them.

At the same time, to reduce risk of future breakage, we probably should
rename this function to make it clear that this function is to be only
used by the push side.

Perhaps rename this to "map_push_refs()" or something in the patch 2/3?

> @@ -1173,6 +1178,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  	struct refspec *rs;
>  	int send_all = flags & MATCH_REFS_ALL;
>  	int send_mirror = flags & MATCH_REFS_MIRROR;
> +	int send_prune = flags & MATCH_REFS_PRUNE;
>  	int errs;
>  	static const char *default_refspec[] = { ":", NULL };
>  	struct ref *ref, **dst_tail = tail_ref(dst);
> @@ -1193,7 +1199,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  		if (ref->peer_ref)
>  			continue;
>  
> -		dst_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, &pat);
> +		dst_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, 0, &pat);
>  		if (!dst_name)
>  			continue;
>  
> @@ -1220,6 +1226,23 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  	free_name:
>  		free(dst_name);
>  	}
> +	if (send_prune) {
> +		/* check for missing refs on the remote */
> +		for (ref = *dst; ref; ref = ref->next) {
> +			char *src_name;
> +
> +			if (ref->peer_ref)
> +				/* We're already sending something to this ref. */
> +				continue;
> +
> +			src_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, 1, NULL);
> +			if (src_name) {
> +				if (!find_ref_by_name(src, src_name))
> +					ref->peer_ref = try_explicit_object_name("");

Yuck.  You do not want it to "try" as its name says.  You just want to
trigger its "delete" codepath.

Please extract the body of "if (!*name) { ... }" block out of that
function into a separate helper function, i.e.

	static struct ref *deleted_ref(void)
        {
		struct ref *ref = alloc_ref("(delete)");
                hashclr(ref->new_sha1);
                return ref;
        }

then update try_explicit_...() to call it, and call the same helper here.

This is not for runtime efficiency; feeding a constant to a function that
says try_foo() or check_bar() that makes decision on the parameter only to
trigger a partial codepath hurts readability.

> +				free(src_name);
> +			}
> +		}
> +	}
>  	if (errs)
>  		return -1;
>  	return 0;
> diff --git a/remote.h b/remote.h
> index b395598..341142c 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int n, const char *);
>  enum match_refs_flags {
>  	MATCH_REFS_NONE		= 0,
>  	MATCH_REFS_ALL 		= (1 << 0),
> -	MATCH_REFS_MIRROR	= (1 << 1)
> +	MATCH_REFS_MIRROR	= (1 << 1),
> +	MATCH_REFS_PRUNE	= (1 << 2),
>  };
>  
>  /* Reporting of tracking info */
> diff --git a/transport.c b/transport.c
> index cac0c06..c20267c 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1028,6 +1028,8 @@ int transport_push(struct transport *transport,
>  			match_flags |= MATCH_REFS_ALL;
>  		if (flags & TRANSPORT_PUSH_MIRROR)
>  			match_flags |= MATCH_REFS_MIRROR;
> +		if (flags & TRANSPORT_PUSH_PRUNE)
> +			match_flags |= MATCH_REFS_PRUNE;

Does it make sense to specify --prune when --mirror is in effect?  If so,
how would it behave differently from a vanilla --mirror?  If not, should
it be detected as an error?

I couldn't infer from the context shown in the patch, but how in general
does this new feature interact with the codepath for --mirror?

>  		if (match_push_refs(local_refs, &remote_refs,
>  				    refspec_nr, refspec, match_flags)) {
> diff --git a/transport.h b/transport.h
> index 059b330..5d30328 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -101,6 +101,7 @@ struct transport {
>  #define TRANSPORT_PUSH_MIRROR 8
>  #define TRANSPORT_PUSH_PORCELAIN 16
>  #define TRANSPORT_PUSH_SET_UPSTREAM 32
> +#define TRANSPORT_PUSH_PRUNE 64
>  #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64

Hrm...?

>  #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
