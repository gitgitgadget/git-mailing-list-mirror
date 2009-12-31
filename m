From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Wed, 30 Dec 2009 23:01:11 -0800
Message-ID: <7v637nzky0.fsf@alter.siamese.dyndns.org>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 08:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQF3q-0005w2-Jc
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 08:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZLaHBT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 02:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZLaHBT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 02:01:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbZLaHBS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2009 02:01:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16AB68CE2C;
	Thu, 31 Dec 2009 02:01:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=toElNG9sFgND
	gVSDkfiatKEc+0M=; b=wqenqkQXVlOWubMyH6sdT5avJB2PpxLMKZKylsBOeQc8
	m73XG585foH7ECm4cffv/koRfRLkUsBP8eifZTTnmoqXkv5E5gkqgsZpxGHX1wG1
	7OLY3SeItO7e4kSu61T2om1+1t3lDRY9msxmyz5YuHFN68i537ls4nvl7qyVuTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IcZf3L
	tC6/qui3jf98TilMbkQji6zHp8Sk/6CjTzd6svVIO2gkt/T8xwkS085vyms0x6gO
	ijI5dHK3p0ZxB1hc2B2YmGHG1bmGg+EZn4ovyzB5pn4O812aXgVku2/ZaPydGEh7
	8pgkJ8AGjSEKYoXopVmdxDzu8yNxyzjPIlHlU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E922B8CE2B;
	Thu, 31 Dec 2009 02:01:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B168CE2A; Thu, 31 Dec
 2009 02:01:13 -0500 (EST)
In-Reply-To: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 30 Dec
 2009 21\:11\:44 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49E72F30-F5DA-11DE-85E5-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135935>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Skip-worktree entries are not on disk. There is no reason to call
> external grep in such cases.
>
> A trace message is also added to aid debugging external grep cases.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin-grep.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-grep.c b/builtin-grep.c
> index d582232..d49c637 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -488,17 +488,34 @@ static int grep_cache(struct grep_opt *opt, con=
st char **paths, int cached,
>  	read_cache();
> =20
>  #if !NO_EXTERNAL_GREP
> +	if (cached)
> +		external_grep_allowed =3D 0;
> +	if (external_grep_allowed) {
> +		for (nr =3D 0; nr < active_nr; nr++) {
> +			struct cache_entry *ce =3D active_cache[nr];
> +			if (!S_ISREG(ce->ce_mode))
> +				continue;
> +			if (!pathspec_matches(paths, ce->name, opt->max_depth))
> +				continue;
> +			if (ce_skip_worktree(ce)) {
> +				external_grep_allowed =3D 0;
> +				break;
> +			}
> +		}
> +	}
>  	/*
>  	 * Use the external "grep" command for the case where
>  	 * we grep through the checked-out files. It tends to
>  	 * be a lot more optimized
>  	 */
> -	if (!cached && external_grep_allowed) {
> +	if (external_grep_allowed) {
>  		hit =3D external_grep(opt, paths, cached);
>  		if (hit >=3D 0)
>  			return hit;
>  		hit =3D 0;
>  	}

This looks a bit wrong for a couple of reasons:

 - external_grep() is designed to return negative without running exter=
nal
   grep when it shouldn't be used (see the beginning of the function fo=
r
   how it refuses to run when opt->extended is set and other conditions=
).
   The new logic seems to belong there, i.e. "in addition to the existi=
ng
   case we decline, if ce_skip_worktree() entry exists in the cache, we
   decline";

 - It should be a separate helper function, has_skip_worktree_entry(pat=
hs);
   I wouldn't be surprised if there are some other codepaths that want =
to
   check for the same condition and do things differently, not just gre=
p.

Originally I thought S_ISREG() check and pathspec_matches() check were
also questionable, but they actually are good things to have, as we ski=
p
symbolic links (or submodules) and we do want to use external grep if t=
he
subtree we are grepping in do not have skip_worktree entries even when
some other parts of the index are marked as skip_worktree.

> +	else
> +		trace_printf("grep: external grep not used\n");
>  #endif
> =20
>  	for (nr =3D 0; nr < active_nr; nr++) {
> --=20
> 1.6.6.315.g1a406
