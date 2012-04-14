From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: do not expect file arguments
Date: Sat, 14 Apr 2012 16:48:56 -0700
Message-ID: <7vehrp27tj.fsf@alter.siamese.dyndns.org>
References: <20120414190448.GA26209@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:49:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJCiF-0005y1-Lw
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 01:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494Ab2DNXs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 19:48:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab2DNXs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 19:48:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275366517;
	Sat, 14 Apr 2012 19:48:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dLYvGuJ0J5Nvj8YHE2o0Gqq7/c0=; b=qZ/Ls7
	EYK6tS1sMRl3nBIkDddd/QNN7q2Fn9oLCzRlIgk4pM9Yuu5lomUVbmP/2s0F+3O1
	wrYz6PGJrtvDuJsU4aZrcgX3CaSI4J/+mhDCewpXl2sXWQh+MCkJt9c/cGHsQtbO
	g8CMijZFIL/34aNVOHAjY6y71yfjw9kAHI1eA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lfEO+yd6m8lrK2z6i3/QgHoDSXuc925j
	PGA75h1cqIKibe7jRvz99gH4fvV7VBOSWMQ4gH8yV+QPYLF+0PbTa8wW4y+nlkcV
	VD1Wk5ppRrcbM3UeLALaGtLk38yd1Yx4HPYa3fvOE3szDODxBm29PU6paaqFywUQ
	DZ+UzCQbE8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CE056516;
	Sat, 14 Apr 2012 19:48:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 839BA6515; Sat, 14 Apr 2012
 19:48:57 -0400 (EDT)
In-Reply-To: <20120414190448.GA26209@ecki> (Clemens Buchacher's message of
 "Sat, 14 Apr 2012 21:04:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66C41420-868C-11E1-B4AF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195536>

Clemens Buchacher <drizzd@aon.at> writes:

> If a commit-ish passed to cherry-pick or revert happens to have a file
> of the same name, git complains that the argument is ambiguous and
> advises to use '--'. To make things worse, the '--' argument is removed
> by parse_options, und so passing '--' has no effect.

Thanks.

I can see how this patch is one way to solve it, but if the command knows
that it is feedling only revs and no pathspecs, isn't the caller the one
that is responsible for adding "--" to the argv_array it is passing to
setup_revisions()?

With s/assume_dashdash/no_pathspecs/, the damage to the revision traversal
machinery does not look _too_ bad, but I am not convinced (yet) that this
patch is the best way to solve the issue.

> Instead, always interpret cherry-pick/revert arguments as revisions.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>  builtin/revert.c |    5 ++++-
>  revision.c       |   24 ++++++++++++++----------
>  revision.h       |    1 +
>  3 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index e6840f2..92f3fa5 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -181,12 +181,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  	if (opts->subcommand != REPLAY_NONE) {
>  		opts->revs = NULL;
>  	} else {
> +		struct setup_revision_opt s_r_opt;
>  		opts->revs = xmalloc(sizeof(*opts->revs));
>  		init_revisions(opts->revs, NULL);
>  		opts->revs->no_walk = 1;
>  		if (argc < 2)
>  			usage_with_options(usage_str, options);
> -		argc = setup_revisions(argc, argv, opts->revs, NULL);
> +		memset(&s_r_opt, 0, sizeof(s_r_opt));
> +		s_r_opt.assume_dashdash = 1;
> +		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
>  	}
>  
>  	if (argc > 1)
> diff --git a/revision.c b/revision.c
> index b3554ed..9a0d9c7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1715,17 +1715,21 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		submodule = opt->submodule;
>  
>  	/* First, search for "--" */
> -	seen_dashdash = 0;
> -	for (i = 1; i < argc; i++) {
> -		const char *arg = argv[i];
> -		if (strcmp(arg, "--"))
> -			continue;
> -		argv[i] = NULL;
> -		argc = i;
> -		if (argv[i + 1])
> -			append_prune_data(&prune_data, argv + i + 1);
> +	if (opt && opt->assume_dashdash) {
>  		seen_dashdash = 1;
> -		break;
> +	} else {
> +		seen_dashdash = 0;
> +		for (i = 1; i < argc; i++) {
> +			const char *arg = argv[i];
> +			if (strcmp(arg, "--"))
> +				continue;
> +			argv[i] = NULL;
> +			argc = i;
> +			if (argv[i + 1])
> +				append_prune_data(&prune_data, argv + i + 1);
> +			seen_dashdash = 1;
> +			break;
> +		}
>  	}
>  
>  	/* Second, deal with arguments and options */
> diff --git a/revision.h b/revision.h
> index b8e9223..1a08384 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -183,6 +183,7 @@ struct setup_revision_opt {
>  	const char *def;
>  	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
>  	const char *submodule;
> +	int assume_dashdash;
>  };
>  
>  extern void init_revisions(struct rev_info *revs, const char *prefix);
