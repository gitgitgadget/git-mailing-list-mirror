From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] unpack-trees: cache_entry lifetime issue?
Date: Mon, 05 Mar 2012 14:01:21 -0800
Message-ID: <7vaa3uzozy.fsf@alter.siamese.dyndns.org>
References: <4F5102A2.70303@lsrfire.ath.cx>
 <7vk432dd89.fsf@alter.siamese.dyndns.org> <4F522758.9050205@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fyD-00023H-Rb
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 23:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab2CEWBZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 17:01:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338Ab2CEWBY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 17:01:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 910626D3E;
	Mon,  5 Mar 2012 17:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vfc0+yhln/p/
	ffiomp9JL+sldMA=; b=Tg+rOv8NhhwZmfszuSbSN3z5BqaFxMNacj125gY2iGex
	TKlFDPbkkhWLGJgtxeUfRSQ3MSqQNEBShsbk24rzu5I9558+qE4imo//DVEoaQG/
	XI5wiik0e9SyPh1XO2gGNcRsRrDF0DLbHOSl4nK+1/mVg9YKqRaTEDxGR/k1zpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r+iIY3
	tJ9quNcmbgIdaKir7w3j0xlcYQQoc/2lH6swMvEKbTyN9/A13wk8oeasetCPR65Z
	lOk7MFART0MeDw4o8p5/r9ZDStkmzCfgGSB0UXJC9MmxSqiZ8rGsZE39WPKAVk+t
	cSea8c5091xMYu7N0xM3CN0WcyBehMapADw+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882A46D3D;
	Mon,  5 Mar 2012 17:01:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE6EB6D3A; Mon,  5 Mar 2012
 17:01:22 -0500 (EST)
In-Reply-To: <4F522758.9050205@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 03 Mar 2012 15:14:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEE80ECE-670E-11E1-8AA9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192278>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Next question: Should the function fn() in struct unpack_trees_option=
s
> be able to replace src[0], and unpack_callback() is then supposed to
> use the new pointer after calling unpack_nondirectories()?  If not
> then we can clean up things a bit by moving the src array into
> unpack_nondirectories().

Sorry, I have no idea.  What kind of usage pattern do you have in
mind?

> For now, just this patch, which cleans up memory, but not the code:
>
> -- >8 --
> Subject: unpack-trees: plug minor memory leak
>
> The allocations made by unpack_nondirectories() using create_ce_entry=
()
> are never freed.  In the case of a merge, we hand them to
> call_unpack_fn() and never look at them again.

That assumes that whatever callbacks that are called will only look
at but never takes ownership of the cache entry given to them.  I
*think* everybody eventually calls "add_entry()" that duplicates the
cache entry before storing it to the index, but I didn't go through
all the codepaths.  Assuming you did, I think this is a good change.

> In the non-merge case,
> we duplicate them using add_entry() and later only look at the first
> allocated element (src[0]), perhaps even only by mistake.
>
> To clean up after ourselves, explicitly loop through the entries and
> free their memory for merges.  For non-merges, split out the actual
> addition from add_entry() into the new helper do_add_entry().  Then
> call that non-duplicating function instead of add_entry() to avoid th=
e
> leak.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  unpack-trees.c |   35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 7c9ecf6..c594e4a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -102,21 +102,28 @@ void setup_unpack_trees_porcelain(struct unpack=
_trees_options *opts,
>  		opts->unpack_rejects[i].strdup_strings =3D 1;
>  }
> =20
> -static void add_entry(struct unpack_trees_options *o, struct cache_e=
ntry *ce,
> -	unsigned int set, unsigned int clear)
> +static void do_add_entry(struct unpack_trees_options *o, struct cach=
e_entry *ce,
> +			 unsigned int set, unsigned int clear)
>  {
> -	unsigned int size =3D ce_size(ce);
> -	struct cache_entry *new =3D xmalloc(size);
> -
>  	clear |=3D CE_HASHED | CE_UNHASHED;
> =20
>  	if (set & CE_REMOVE)
>  		set |=3D CE_WT_REMOVE;
> =20
> +	ce->next =3D NULL;
> +	ce->ce_flags =3D (ce->ce_flags & ~clear) | set;
> +	add_index_entry(&o->result, ce,
> +			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> +}
> +
> +static void add_entry(struct unpack_trees_options *o, struct cache_e=
ntry *ce,
> +	unsigned int set, unsigned int clear)
> +{
> +	unsigned int size =3D ce_size(ce);
> +	struct cache_entry *new =3D xmalloc(size);
> +
>  	memcpy(new, ce, size);
> -	new->next =3D NULL;
> -	new->ce_flags =3D (new->ce_flags & ~clear) | set;
> -	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_T=
O_REPLACE);
> +	do_add_entry(o, new, set, clear);
>  }
> =20
>  /*
> @@ -582,12 +589,18 @@ static int unpack_nondirectories(int n, unsigne=
d long mask,
>  		src[i + o->merge] =3D create_ce_entry(info, names + i, stage);
>  	}
> =20
> -	if (o->merge)
> -		return call_unpack_fn(src, o);
> +	if (o->merge) {
> +		int rc =3D call_unpack_fn(src, o);
> +		for (i =3D 0; i < n; i++) {
> +			if (src[i + 1] !=3D o->df_conflict_entry)
> +				free(src[i + 1]);
> +		}
> +		return rc;
> +	}
> =20
>  	for (i =3D 0; i < n; i++)
>  		if (src[i] && src[i] !=3D o->df_conflict_entry)
> -			add_entry(o, src[i], 0, 0);
> +			do_add_entry(o, src[i], 0, 0);
>  	return 0;
>  }
