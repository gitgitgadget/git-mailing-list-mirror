From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: avoid unncessary match_pathspec calls
Date: Sat, 23 Mar 2013 23:47:40 -0700
Message-ID: <7vr4j52t0z.fsf@alter.siamese.dyndns.org>
References: <1364036142-3031-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 07:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJej6-0003q2-AA
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 07:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab3CXGro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 02:47:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3CXGrn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Mar 2013 02:47:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 573168904;
	Sun, 24 Mar 2013 02:47:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yb8yXdMJ3eRQ
	S6ssf+TqJoK9nvw=; b=I+m8uVY/gL+jiVoYpSbphfNmxRbmiHs6OY3WstAVRRmd
	0Cn4DijYRvs99yT2OXqNEKtlaEen/uhj8C9eIxnZiBd4qqJZsMIcPm0XCeJgJt73
	uRdF0AWjm8hzRRl4mJVTO8PMUW35drJ8D4fMzpuOLoUfA3EVIaWuAIcTZv4KYkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LIq3iQ
	xIEYuVpwE3/ZL1WK8wjBqh7ZaUTuDS3676ID5VU1ZEvQo5PROBeXqG52tR5EaDt/
	a89rBc6jeMnfUeadKfbyg2F5QRmmT43BHl4Q0M/jo6KOSXtk/6E4dtWwiNP2oX6A
	cK9wzs9fxuxjtx5pGTzazfHSjAP1cIjK0hw94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CAED8902;
	Sun, 24 Mar 2013 02:47:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 981F68900; Sun, 24 Mar 2013
 02:47:41 -0400 (EDT)
In-Reply-To: <1364036142-3031-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 23 Mar
 2013 17:55:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B992D4B8-944E-11E2-B20F-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218940>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> ---
>  Junio, this patch clearly conflicts wih nd/magic-pathspecs. Do you
>  want me to:
>
>   - hold it off until nd/magic-pathspecs graduates
>   - rebase on top of nd/magic-pathspecs and repost
>   - leave it to you to handle conflicts
>  ?

I'd prefer to take small, independent and clear improvements first
and worry about larger ones later, so if there were another choice,
i.e.

 - eject nd/magic-pathspecs for now, cook this (and other small
   independent and clear improvements you may come up with, some of
   which might come out of nd/magic-pathspecs itself) and let it
   graduate first, and later revisit rerolld nd/magic-pathspecs

that would be the ideal among the given choices ;-).

>  	for (pos =3D 0; pos < active_nr; pos++) {
>  		struct cache_entry *ce =3D active_cache[pos];
> +		ce->ce_flags &=3D ~CE_MATCHED;
>  		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
>  			continue;
> -		match_pathspec(opts->pathspec, ce->name, ce_namelen(ce), 0, ps_mat=
ched);
> +		if (match_pathspec(opts->pathspec, ce->name,
> +				   ce_namelen(ce), 0, ps_matched))
> +			ce->ce_flags |=3D CE_MATCHED;
>  	}
> =20
>  	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
>  		return 1;
> =20
> +	/*
> +	 * call match_pathspec on the remaining entries that have not
> +	 * been done in the previous loop
> +	 */
> +	for (pos =3D 0; pos < active_nr; pos++) {
> +		struct cache_entry *ce =3D active_cache[pos];
> +		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE) &&
> +		    match_pathspec(opts->pathspec, ce->name,
> +				   ce_namelen(ce), 0, ps_matched))
> +			ce->ce_flags |=3D CE_MATCHED;
> +	}
> +

The above is a faithful rewrite, but I have to wonder why you need
two separate loops.

Do you understand what the original loop is doing with ps_matched,
and why the code excludes certain paths while doing so?  I didn't
when I read your patch for the first time, as I forgot, until I
checked with 0a1283bc3955 (checkout $tree $path: do not clobber
local changes in $path not in $tree, 2011-09-30)

You don't use ps_matched after report_path_error(); the new loop
shouldn't have to record which pathspec matched.

Also I notice that I forgot to free ps_matched.  Perhaps doing it
this way is easier to maintain?

	/*
         * Make sure all pathspecs participated in locating the
	 * paths to be checked out.
         */
	for (pos =3D 0; pos < active_nr; pos++) {
		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
			/*
                         * "git checkout tree-ish -- path", but this en=
try
                         * is in the original index; it will not be che=
cked
                         * out to the working tree and it does not matt=
er
			 * if pathspec matched this entry.  We will not do
			 * anything to this entry at all.
                	 */
			verify_psmatch =3D NULL;
		else
			/*
                         * Either this entry came from the tree-ish
                         * we are checking the paths out of, or we
			 * are checking out of the index.
                	 */
                        verify_psmatch =3D ps_matched;
		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce),
				   0, verify_psmatch))
			ce->ce_flags |=3D CE_MATCHED;
	}

	if (report_path_error(ps_matched, opts->pathspec, opts->prefix))
		return 1;
	free(ps_matched);

After commenting on the above, it makes me wonder if we even need to
bother marking entries that were in the index that did not come from
the tree-ish we are checking paths out of, though.  What breaks if
you did not do the rewrite above and dropped the second loop in your
patch?
