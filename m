From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: Allow to omit refs/tags/ part in --refs option when --tags used
Date: Mon, 17 Jun 2013 08:27:39 -0700
Message-ID: <7vip1chi50.fsf@alter.siamese.dyndns.org>
References: <1371455636-1378-1-git-send-email-namhyung.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 17:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UobLT-0005v7-40
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 17:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab3FQP1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 11:27:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3FQP1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 11:27:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEB262884E;
	Mon, 17 Jun 2013 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V2YQvGt9oUdWBtoU2+lY7X6JqGc=; b=g/CAaW
	4GFndy1gU88gdektkdpfXs4oeZT53BoLFvSqnHgjIu4niA3k0IP9TBwTx2sm+tgA
	wZ8+aNaMAVddLlJFkPBhlOwbkgx26uYK+QftdN0JktuVLSmWLiAqQjnnhY3bk2a2
	8tw6Bry22TVj72GB4CIbsxdDbIiaBStLaF6eY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xu6WZPEtBkkVL4Cj5UnoDl4JLeEqWzkt
	ATIwe+Kn9cEfQWNaFm6iFSWCw1L7227/EW1JVIegXE3VzvctDkKH+xq9FSZJqn2w
	13eBraFFHpwOwflkmPAxS48Jj84HR91PhVaUHBjiL04XsLVY7SNtgxilB90uvNZ3
	i8zvt5aPyX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4DD22884D;
	Mon, 17 Jun 2013 15:27:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEFFB2884A;
	Mon, 17 Jun 2013 15:27:41 +0000 (UTC)
In-Reply-To: <1371455636-1378-1-git-send-email-namhyung.kim@lge.com> (Namhyung
	Kim's message of "Mon, 17 Jun 2013 16:53:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 738C5BD6-D762-11E2-B365-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228077>

Namhyung Kim <namhyung.kim@lge.com> writes:

> In its current form, when an user wants to filter specific ref using
> --refs option, she needs to give something like --refs=refs/tags/v1.*.
>
> This is not intuitive as users might think it's enough to give just
> actual tag name part like --refs=v1.*.

I do not think "Users might think" is not particularly a good
justification, but I agree that it would be useful to allow
--refs=v1.\* to match refs/heads/v1.4-maint and refs/tags/v1.4.0; it
is easy for the users to disambiguate with longer prefix if they
wanted to.

> It applies to refs other than
> just tags too.  Change it for users to be able to use --refs=sth or
> --refs=remotes/sth.
>
> Also remove the leading 'tags/' part in the output when --tags option
> was given since the option restricts to work with tags only.

This part is questionable, as it changes the output people's scripts
have been reading from the command since eternity ago.

If the pattern asks to match with v1.* (not tags/v1.* or
refs/tags/v1.*) and you find refs/tags/v1.*, it might be acceptable
to strip "refs/tags/" part.  Existing users are _expected_ to feed a
pattern with full refname starting with refs/, so they will not be
negatively affected by such a usability enhancement on the output
side.

> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 6238247..446743b 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -97,7 +97,8 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
>  	if (data->tags_only && prefixcmp(path, "refs/tags/"))
>  		return 0;
>  
> -	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
> +	if (data->ref_filter && !prefixcmp(data->ref_filter, "refs/")
> +	    && fnmatch(data->ref_filter, path, 0))
>  		return 0;

What does this mean?  "When --refs is specified, if it begins with
refs/ then do not show unmatching path, but let any path be subject
to the following if --refs does not begin with refs/" sounds like a
broken logic, unless you add another fnmatch() later in the codepath
to compensate.  And you indeed do so, but then at that point, do we
still need this "if(...) return 0" at all?

I think it can and should be improved here, and then the one in the
main logic you added can be removed.

Wouldn't it make more sense to see if the given pattern matches a
tail substring of the ref, instead of using the hardcoded "strip
refs/heads/, refs/tags or refs/, and then match once" logic?  That
way, --refs=origin/* can find refs/remotes/origin/master by running
fnmatch of origin/* against its substrings, i.e.

	refs/remotes/origin/master
        remotes/origin/master
        origin/master

and find that the pattern matches it.

Perhaps it is just the matter of adding something like:

	static int subpath_matches(const char *path, const char	*filter)
	{        
		const char *subpath = path;
		while (subpath) {
                	if (!fnmatch(data->ref_filter, subpath, 0))
				return subpath - path;
			subpath = strchr(path, '/');
                        if (subpath)
	                        subpath++;
		}
		return -1;
	}

and then at the beginning of name_ref() do this:

	int can_abbreviate_output = data->name_only;

	if (data->tags_only && prefixcmp(path, "refs/tags/"))
		return 0;
	if (data->ref_filter) {
        	switch (subpath_matches(path, data->ref_filter)) {
		case -1: /* did not match */
			return 0;
		default: /* matched subpath */
			can_abbreviate_output = 1;
			break;
		case 0: /* matched fully */
                	break;
		}
	}

The logic before calling name_rev() will be kept as "only decide how
the output looks like", without mixing the unrelated "decide if we
want to use it" logic in.

>  	while (o && o->type == OBJ_TAG) {
> @@ -113,12 +114,15 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
>  		if (!prefixcmp(path, "refs/heads/"))
>  			path = path + 11;
>  		else if (data->tags_only
> -		    && data->name_only
>  		    && !prefixcmp(path, "refs/tags/"))
>  			path = path + 10;
>  		else if (!prefixcmp(path, "refs/"))
>  			path = path + 5;
>  
> +		if (data->ref_filter && prefixcmp(data->ref_filter, "refs/")
> +		    && fnmatch(data->ref_filter, path, 0))
> +			return 0;
>  		name_rev(commit, xstrdup(path), 0, 0, deref);
>  	}
>  	return 0;
