From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] fetch: honor the user-provided refspecs when pruning
 refs
Date: Wed, 12 Oct 2011 14:39:24 -0700
Message-ID: <7vsjmx7uur.fsf@alter.siamese.dyndns.org>
References: <1318027869-4037-1-git-send-email-cmn@elego.de>
 <1318027869-4037-4-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, mathstuf@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6Wy-0001sc-9x
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab1JLVjc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 17:39:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342Ab1JLVj1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 17:39:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF9305968;
	Wed, 12 Oct 2011 17:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kx4XtI4ayNI+
	pzwR8BwZ5KOjVGc=; b=BvGu1MXtAhYT3ybZI0nMUqybj7PdpD+o2tE+AnEQh+iH
	B0hx0jUD02lcoGru6L5P1QHeYNv8oBau7O4TvI856BGNoCK5bFQqd6vX6LLK71hS
	xwGDgHD5Mf987LboIa1Z2mjTjK8EopUdcZG0fOYNOieUNLOmZiVs4g12AKZYGM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xF3SED
	yMKKe5SYgseSm68ZEta0kTDlTO7809jE7a1FiJW++nFNLKPG6hIn6n7OCkGEtLWK
	c+Te3FMaW+TcFzy8Si3Tl6ENdKjs2Kl/xZC5ip6u1LXBoKhVHsI8Gu6hX4k1fXwY
	hjqJ+4TbaLFX01RGBeyzBsjGKP23ikwI8v90s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A72085967;
	Wed, 12 Oct 2011 17:39:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA69B5966; Wed, 12 Oct 2011
 17:39:25 -0400 (EDT)
In-Reply-To: <1318027869-4037-4-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sat, 8 Oct 2011 00:51:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A81FD07A-F51A-11E0-A7FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183417>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> -static int prune_refs(struct transport *transport, struct ref *ref_m=
ap)
> +static int prune_refs(struct refspec *refs, int ref_count, struct re=
f *ref_map)
>  {
>  	int result =3D 0;
> -	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote,=
 ref_map);
> +	struct ref *ref, *stale_refs =3D get_stale_heads(ref_map, refs, ref=
_count);

So in short, get_state_heads() used to take a ref_map and a remote. The
ref_map is what we actually observed from the remote after talking
ls-remote with it. It tried to see if any existing ref in our refspace =
may
have come from that remote by inspecting the fetch refspec associated w=
ith
that remote (and the ones that does not exist anymore are queued in the
stale ref list).

Now get_state_heads() takes a ref_map and <refs, ref_count> (you made t=
he
patch unnecessarily harder to read by swapping the order of parameters)=
=2E
The latter "pair" roughly corresponds to what the "remote" parameter us=
ed
to mean, but instead of using the refspec associated with that remote, =
we
would use the refspec used for this particular fetch to determine which
refs we have are stale.

> @@ -699,8 +699,12 @@ static int do_fetch(struct transport *transport,
>  		free_refs(ref_map);
>  		return 1;
>  	}
> -	if (prune)
> -		prune_refs(transport, ref_map);
> +	if (prune) {
> +		if (ref_count)
> +			prune_refs(refs, ref_count, ref_map);
> +		else
> +			prune_refs(transport->remote->fetch, transport->remote->fetch_ref=
spec_nr, ref_map);
> +	}

And this is consistent to my two paragraph commentary above.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index f2a9c26..79d898b 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -349,7 +349,8 @@ static int get_ref_states(const struct ref *remot=
e_refs, struct ref_states *stat
>  		else
>  			string_list_append(&states->tracked, abbrev_branch(ref->name));
>  	}
> -	stale_refs =3D get_stale_heads(states->remote, fetch_map);
> +	stale_refs =3D get_stale_heads(fetch_map, states->remote->fetch,
> +				     states->remote->fetch_refspec_nr);

So is this.

> diff --git a/remote.c b/remote.c
> index b8ecfa5..13c9153 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1681,36 +1681,84 @@ struct ref *guess_remote_head(const struct re=
f *head,
>  }
> =20
>  struct stale_heads_info {
> -	struct remote *remote;
>  	struct string_list *ref_names;
>  	struct ref **stale_refs_tail;
> +	struct refspec *refs;
> +	int ref_count;
>  };
> =20
> +/* Returns 0 on success, -1 if it couldn't find a match in the refsp=
ecs. */
> +static int find_in_refs(struct refspec *refs, int ref_count, struct =
refspec *query)
> +{
> +	int i;
> +	struct refspec *refspec;

This function replaces the role remote_find_tracking() used to play in =
the
old code and the difference in the behaviour (except the obvious lack o=
f
"find_src/find_dst") feels gratuitous.

The original code in remote_find_tracking() uses "->pattern" to see if =
a
pattern match is necessary, but this scans the refspec for an asterisk,
assuring a breakage when the refspec language is updated to understand
other glob magic in the future. Why isn't refspec->pattern used here?

Can't these two functions share more logic?  It appears to me that by
enhancing the logic here a little bit, it may be possible to implement
remote_find_tracking() ed in terms of this function as a helper.

> +	for (i =3D 0; i < ref_count; ++i) {
> +		refspec =3D &refs[i];
> +
> +		/* No dst means it can't be used for prunning. */
> +		if (!refspec->dst)
> +			continue;
> +
> +		/*
> +		 * No '*' means that it must match exactly. If it does
> +		 * have it, try to match it against the pattern. If
> +		 * the refspec matches, store the ref name as it would
> +		 * appear in the server in query->src.
> +		 */
> +		if (!strchr(refspec->dst, '*')) {
> +			if (!strcmp(query->dst, refspec->dst)) {
> +				query->src =3D xstrdup(refspec->src);
> +				return 0;
> +			}
> +		} else if (match_name_with_pattern(refspec->dst, query->dst,
> +						    refspec->src, &query->src)) {
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
