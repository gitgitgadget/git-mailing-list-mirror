From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 14/45] Guard against new pathspec magic in pathspec
 matching code
Date: Sun, 17 Mar 2013 15:00:34 -0700
Message-ID: <7vtxo9ptz1.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 23:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHLdY-0005O3-ND
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 23:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729Ab3CQWAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 18:00:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576Ab3CQWAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 18:00:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB8BAF67;
	Sun, 17 Mar 2013 18:00:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MrneQgY4niZi
	4QmSEnmf8v40Nwg=; b=qNvbja7xH0aZy4P+wJ96Kl+zXLZxNkKXWMg8dGXIeZO6
	tgvKLGGwWnkQ8VfF5LOY7FERo6MPmjywzk9htEIGqUkgkRdSb9B0I4YhP5+pp0Sx
	3hfawSKeMEBg3nL5zVMAJ7GbTueEd9EgmPqZWiYuB21onsxCdkSdP5TRLObtdeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PDkmnZ
	hlkYppyEs9axmVQhwfgB0nqfExvjC4wXj3zU5d9Bo+xP12B1lG9l69TZZucfwrrX
	/9tL+khLKDcTxwLfahu79c9NDDRtp6vsmHVuPGdlapBHojvUyjLtTxguAYbHfIin
	XOw/xYoc3WD6UOsQ/xwzIuFn+K+vjH66P/L48=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A17F4AF66;
	Sun, 17 Mar 2013 18:00:36 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD0A7AF5F; Sun, 17 Mar 2013
 18:00:35 -0400 (EDT)
In-Reply-To: <1363327620-29017-15-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Mar
 2013 13:06:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18A8C0C6-8F4E-11E2-AE0C-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218376>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> GUARD_PATHSPEC() marks pathspec-sensitive code (basically anything in
> 'struct pathspec' except fields "nr" and "original"). GUARD_PATHSPEC(=
)
> is not supposed to fail. The steps for a new pathspec magic or
> optimization would be:
>
>  - update parse_pathspec, add extra information to struct pathspec
>
>  - grep GUARD_PATHSPEC() and update all relevant code (or note those
>    that won't work with your new stuff). Update GUARD_PATHSPEC mask
>    accordingly.
>
>  - update parse_pathspec calls to disable new magic early at command
>    parsing level. Make sure parse_pathspec() catches unsupported
>    syntax, not until GUARD_PATHSPEC catches it.
>
>  - add tests to verify supported/unsupported commands both work as
>    expected.

I think Documentation/technical/api-*.txt wants to have all of the
above.  It is not clear from the description what the second bitmask
is supposed to mean, without reading the implementation; I am guessing
that you are supposed to list the kinds of magic that are supported
in the codepath?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/diff.c |  2 ++
>  dir.c          |  2 ++
>  pathspec.h     |  7 +++++++
>  tree-diff.c    | 19 +++++++++++++++++++
>  tree-walk.c    |  2 ++
>  5 files changed, 32 insertions(+)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index 8c2af6c..d237e0a 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -371,6 +371,8 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
>  		die(_("unhandled object '%s' given."), name);
>  	}
>  	if (rev.prune_data.nr) {
> +		/* builtin_diff_b_f() */
> +		GUARD_PATHSPEC(&rev.prune_data, PATHSPEC_FROMTOP);
>  		if (!path)
>  			path =3D rev.prune_data.items[0].match;
>  		paths +=3D rev.prune_data.nr;
> diff --git a/dir.c b/dir.c
> index 1e9db41..6094ba8 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -297,6 +297,8 @@ int match_pathspec_depth(const struct pathspec *p=
s,
>  {
>  	int i, retval =3D 0;
> =20
> +	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
> +
>  	if (!ps->nr) {
>  		if (!ps->recursive ||
>  		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
> diff --git a/pathspec.h b/pathspec.h
> index 1cef9c6..ed5d3a6 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -27,6 +27,13 @@ struct pathspec {
>  	} *items;
>  };
> =20
> +#define GUARD_PATHSPEC(ps, mask) \
> +	do { \
> +		if ((ps)->magic & ~(mask))	       \
> +			die("BUG:%s:%d: unsupported magic %x",	\
> +			    __FILE__, __LINE__, (ps)->magic & ~(mask)); \
> +	} while (0)
> +
>  /* parse_pathspec flags */
>  #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
>  #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everythin=
g */
> diff --git a/tree-diff.c b/tree-diff.c
> index 826512e..5a87614 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -198,6 +198,25 @@ static void try_to_follow_renames(struct tree_de=
sc *t1, struct tree_desc *t2, co
>  	const char *paths[1];
>  	int i;
> =20
> +	/*
> +	 * follow-rename code is very specific, we need exactly one
> +	 * path. Magic that matches more than one path is not
> +	 * supported.
> +	 */
> +	GUARD_PATHSPEC(&opt->pathspec, PATHSPEC_FROMTOP);
> +#if 0
> +	/*
> +	 * We should reject wildcards as well. Unfortunately we
> +	 * haven't got a reliable way to detect that 'foo\*bar' in
> +	 * fact has no wildcards. nowildcard_len is merely a hint for
> +	 * optimization. Let it slip for now until wildmatch is taught
> +	 * about dry-run mode and returns wildcard info.
> +	 */
> +	if (opt->pathspec.has_wildcard)
> +		die("BUG:%s:%d: wildcards are not supported",
> +		    __FILE__, __LINE__);
> +#endif
> +
>  	/* Remove the file creation entry from the diff queue, and remember=
 it */
>  	choice =3D q->queue[0];
>  	q->nr =3D 0;
> diff --git a/tree-walk.c b/tree-walk.c
> index d399ca9..37b157e 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -636,6 +636,8 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  	enum interesting never_interesting =3D ps->has_wildcard ?
>  		entry_not_interesting : all_entries_not_interesting;
> =20
> +	GUARD_PATHSPEC(ps, PATHSPEC_FROMTOP | PATHSPEC_MAXDEPTH);
> +
>  	if (!ps->nr) {
>  		if (!ps->recursive ||
>  		    !(ps->magic & PATHSPEC_MAXDEPTH) ||
