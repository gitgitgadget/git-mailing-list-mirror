From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] remote: reorganize check_pattern_match()
Date: Fri, 17 Feb 2012 14:34:02 -0800
Message-ID: <7vvcn5qecl.fsf@alter.siamese.dyndns.org>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 23:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyWNZ-0004W6-CK
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 23:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab2BQWeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 17:34:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab2BQWeF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 17:34:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 183936D11;
	Fri, 17 Feb 2012 17:34:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=xZzUAfFk2FTJX5p9zIwRMtNdfXM=; b=jesSPqKZwmMWz6K6gEra
	0mAqITts/PqimO9DBGk5egEOiy09RKgGMfF2FDNLDZZK1joXVZfxBa15ib5fI0ol
	AV9M5rKqJjTzXFTTJtMW5jaCZVnfL9HQzoALrYpA7XTw0nev3T265CIL9w2zEAjL
	m/ZxNhd00Ob4RZ+yG/NM1Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=sO8K62tfkcBqS+US2Q7yOWL3P1ILvmO7IUQFjNKAM9/pci
	+Eez0O6k7j7JByYHerSH+recxCNVIjz5FcVNCyF8H+kRyl/GVbIrTnABN3OyZ0tR
	+a8DoTjWXiAHbxvtoaenepx7FfXz3aNBVqRGme11nH4EOnbxRi5Kc0yUE4xJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7896D10;
	Fri, 17 Feb 2012 17:34:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17E9D6D0B; Fri, 17 Feb 2012
 17:34:04 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EEBBD16-59B7-11E1-89B0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190984>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> There's a lot of code that can be consolidated there, and will be useful
> for next patches.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  remote.c |   59 ++++++++++++++++++++++++++++++-----------------------------
>  1 files changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 55d68d1..019aafc 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1110,10 +1110,11 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
>  	return errs;
>  }
>  
> -static const struct refspec *check_pattern_match(const struct refspec *rs,
> -						 int rs_nr,
> -						 const struct ref *src)
> +static char *check_pattern_match(const struct refspec *rs, int rs_nr, struct ref *ref,
> +		int send_mirror, const struct refspec **ret_pat)
>  {

For a change that not just adds parameters but removes an existing one, 
this is way under-described with neither in-code comment nor log message.

So I'll have to think aloud in this review.  Take it as a chance to learn
how the thought process of other people with lessor intelligence than you
have might work, and how to help those slower than you are ;-)

> +	const struct refspec *pat;
> +	char *name;
>  	int i;
>  	int matching_refs = -1;
>  	for (i = 0; i < rs_nr; i++) {
> @@ -1123,14 +1124,31 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
>  			continue;
>  		}
>  
> -		if (rs[i].pattern && match_name_with_pattern(rs[i].src, src->name,
> -							     NULL, NULL))
> -			return rs + i;
> +		if (rs[i].pattern) {
> +			const char *dst_side = rs[i].dst ? rs[i].dst : rs[i].src;
> +			if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name)) {
> +				matching_refs = i;
> +				break;

We used to discard what match_name_with_pattern() finds out by matching a
wildcard refspec against the ref by passing two NULLs.  This updates the
code to capture what destination ref ref->name is mapped to, by using the
same logic as the original and only caller, i.e. 'foo' without destination
maps to the same 'foo' destination, 'foo:bar' maps to the named 'bar'.

This function is not used by fetching side of the codepath, so we do not
have to worry about its need to use different dst_side selection logic
(i.e. 'foo' without destination maps to "do not store anywhere other than
FETCH_HEAD").  Good.

> +			}
> +		}
>  	}
> -...
> +	if (matching_refs == -1)
>  		return NULL;
> +
> +	pat = rs + matching_refs;
> +	if (pat->matching) {
> +		/*
> +		 * "matching refs"; traditionally we pushed everything
> +		 * including refs outside refs/heads/ hierarchy, but
> +		 * that does not make much sense these days.
> +		 */
> +		if (!send_mirror && prefixcmp(ref->name, "refs/heads/"))
> +			return NULL;
> +		name = xstrdup(ref->name);
> +	}

So you are moving some code from what the sole caller of this function
does after calling us, and that is where the new parameters come from.
And by doing so, you do not have to run the same match_name_with_pattern()
again.  OK.

> +	if (ret_pat)
> +		*ret_pat = pat;
> +	return name;
>  }

You did not initialize name to anything at the beginning, but if the
earlier match_name_with_pattern() didn't find anything, we could only come
here after matching_refs is set by the if (rs[i].matching) codepath; by
the time we come here, we would have xstrdup(ref->name) in name, so we
would never return a garbage pointer to the caller.  OK.

>  static struct ref **tail_ref(struct ref **head)
> @@ -1171,36 +1189,19 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  		struct ref *dst_peer;
>  		const struct refspec *pat = NULL;
>  		char *dst_name;
> +
>  		if (ref->peer_ref)
>  			continue;
>  
> -		pat = check_pattern_match(rs, nr_refspec, ref);
> -		if (!pat)
> +		dst_name = check_pattern_match(rs, nr_refspec, ref, send_mirror, &pat);
> +		if (!dst_name)
>  			continue;
>  
> -		if (pat->matching) {
> -			/*
> -			 * "matching refs"; traditionally we pushed everything
> -			 * including refs outside refs/heads/ hierarchy, but
> -			 * that does not make much sense these days.
> -			 */
> -			if (!send_mirror && prefixcmp(ref->name, "refs/heads/"))
> -				continue;
> -			dst_name = xstrdup(ref->name);
> -
> -
> -		} else {
> -			const char *dst_side = pat->dst ? pat->dst : pat->src;
> -			if (!match_name_with_pattern(pat->src, ref->name,
> -						     dst_side, &dst_name))
> -				die("Didn't think it matches any more");
> -		}
>  		dst_peer = find_ref_by_name(*dst, dst_name);
>  		if (dst_peer) {
>  			if (dst_peer->peer_ref)
>  				/* We're already sending something to this ref. */
>  				goto free_name;
> -
>  		} else {
>  			if (pat->matching && !(send_all || send_mirror))
>  				/*

OK, it is easy to tell that the patch is trivially correct, once a reader
figures out that the patch is really about:

	Move code to check_pattern_match() from its sole caller to make it
	unnecessary to call match_name_with_pattern() twice.

Saying so in the log message would have prepared the reader, instead of
the "There's a lot of code that can be consolidated there." which does not
give hints on what to look for in the patch.

Also this changes the semantics (because it changed the meaning of its
return value) of check_pattern_match() so much that it would deserve a
rename, which I will address in my review of 3/3.

Otherwise this step looks good.
