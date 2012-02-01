From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3] grep: Add the option '--exclude'
Date: Tue, 31 Jan 2012 16:31:42 -0800
Message-ID: <7vsjiv5r81.fsf@alter.siamese.dyndns.org>
References: <1328021108-4662-1-git-send-email-surfingalbert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Albert Yale <surfingalbert@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsO75-0003Wz-1C
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 01:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab2BAAbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 19:31:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab2BAAbp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 19:31:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 763ED6C99;
	Tue, 31 Jan 2012 19:31:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IWhcZfiO4s/m
	TxwIo7lK/FX55mM=; b=UrnXbZ6fS88mp4AZMIyPg+M5I7u5OmU4ac9ILYqV9k6n
	0LWj6jepOgxF07yN0m/nTGR7+DhnVY4hHO2Jwg8l/sdTJs6PD9RtRbGrOnXg/ooV
	xo10+5nfP0ejtrgo5bv4kRGd9LHT9bowWgScEi2SbteOwUEB2jJtbNTtookcca8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ncj3cx
	wtDv21QaLPsM2puVVGhqKkhbZek+rDDU5qzbjDaaWJ4WNeUDNvKAcayAjMKL7DBZ
	wVz7k2s8Y0hOU4Ie2OrdFV2pKCD0SMmYz+TKU2l9gDJ3/zdIfGMwD0ugIDmJtdHv
	HUwFyc9bJSCxYhyoqd0i1QtD+ZjcGGz4PGSG8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D8066C98;
	Tue, 31 Jan 2012 19:31:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEC236C96; Tue, 31 Jan 2012
 19:31:43 -0500 (EST)
In-Reply-To: <1328021108-4662-1-git-send-email-surfingalbert@gmail.com>
 (Albert Yale's message of "Tue, 31 Jan 2012 09:45:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DCC25F0-4C6C-11E1-8911-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189486>

Albert Yale <surfingalbert@gmail.com> writes:

> @@ -124,6 +125,12 @@ OPTIONS
>  	Use fixed strings for patterns (don't interpret pattern
>  	as a regex).
> =20
> +-x <pattern>::
> +--exclude <pattern>::
> +	In addition to those found in .gitignore (per directory) and
> +	$GIT_DIR/info/exclude, also consider these patterns to be in the
> +	set of the ignore rules in effect.

That makes it sound as if "git grep" will not produce hits for a path t=
hat
was forcibly added despite it matches a pattern in .gitignore file, whi=
ch
is not true at all.

>  -n::
>  --line-number::
>  	Prefix the line number to matching lines.
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9ce064a..e9e1ac1 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -528,7 +528,8 @@ static int grep_cache(struct grep_opt *opt, const=
 struct pathspec *pathspec, int
>  		struct cache_entry *ce =3D active_cache[nr];
>  		if (!S_ISREG(ce->ce_mode))
>  			continue;
> -		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, N=
ULL))
> +		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce),
> +					  0, NULL, 1))
>  			continue;
>  		/*
>  		 * If CE_VALID is on, we assume worktree file and its cache entry
> @@ -566,6 +567,11 @@ static int grep_tree(struct grep_opt *opt, const=
 struct pathspec *pathspec,
>  	while (tree_entry(tree, &entry)) {
>  		int te_len =3D tree_entry_len(&entry);
> =20
> +		if (match_pathspec_depth(pathspec->exclude,
> +					 entry.path, strlen(entry.path),
> +					 0, NULL, 0))
> +			continue;
> +

Why???

IOW, why isn't this

	if (!match_pathspec_depth(pathspec, ...))
		continue;=09

My point of the two previous review messages was that it would be nice =
if
we can make it so that nobody outside match_pathspec_depth() should eve=
n
need to know existence of pathspec->exclude. Either that was ignored, o=
r
perhaps you found a compelling reason why that is not a good idea, but =
if
so I'd like to know why.

I suspect that you do not need to add the extra 0 at the end (it makes =
the
caller even harder to read) if you go that route. The extra parameter
defeats the whole point of encapsulating the new "negative match" featu=
re
behind match_pathspec_depth() implementation.

> +	if (obj->type =3D=3D OBJ_BLOB) {
> +		const char *name_without_sha1 =3D strchr(name, ':') + 1;
> +
> +		if (match_pathspec_depth(pathspec->exclude,
> +					 name_without_sha1,
> +					 strlen(name_without_sha1),
> +					 0, NULL, 0))
> +			return 0;

Likewise.

> diff --git a/cache.h b/cache.h
> index 9bd8c2d..683458a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -533,9 +533,12 @@ struct pathspec {
>  		int len;
>  		unsigned int use_wildcard:1;
>  	} *items;
> +
> +	struct pathspec *exclude; /* This is never NULL. */
>  };

"This is never NULL" is blatantly wrong, as pathspec->exclude->exclude
will very likely be NULL.

I've been assuming that the resulting structure would be more like this=
:=20

 struct pathspec_set {
         int nr;
         unsigned int has_wildcard:1;
         unsigned int recursive:1;
         struct pathspec_item {
                 const char *match;
                 int len;
                 unsigned int use_wildcard:1;
         } *items;
 };

 struct pathspec {
         const char **raw; /* get_pathspec() result, not freed by free_=
pathspec() */
         int max_depth;
         struct pathspec_set include;
         struct pathspec_set exclude;
 };
=20
I am not including "raw" in the include/exclude because its use should =
be
deprecated away over time.

The various helpers used in match_pathspec_depth() that know _only_ abo=
ut
matching and not about excluding will be changed to take a pointer to
"struct pathspec_set" (and possibly max_depth). The top-level callers
would not have to know any of these changes if we structure the API tha=
t
way, no?

I think something like that was more or less the structure we discussed
when Nguy=E1=BB=85n brought up his negative pathspec work the last time=
=2E
