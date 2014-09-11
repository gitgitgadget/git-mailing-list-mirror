From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] log-tree: make format_decorations more flexible
Date: Thu, 11 Sep 2014 15:39:55 -0700
Message-ID: <xmqq7g19dbno.fsf@gitster.dls.corp.google.com>
References: <5410C998.5060701@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSD22-0008N9-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 00:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbaIKWj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 18:39:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60473 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaIKWj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 18:39:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 588973A0C7;
	Thu, 11 Sep 2014 18:39:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T/P8kHKMHUX/65OQR2fZED1hVT8=; b=ksAylz
	K1B9OojX08JgW30/ZHK3DEaf3T2swmrT3rbbUTmSaNM2nJQppgnY8+w9GK2KL9kx
	kuL+PYblSoN/d/5o5iVSy3AomLcbTovkXqPCuGuuKTTL87ER2Coi9/5kTZaRlH44
	vj/diZ3I+QqvNUbuINBDQf1GCdnhgXi2Qo/0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EHcB6bDfhSfbMMozb3sJVOfZrdSqMu/+
	2mn9JP4nA+4FvN080R7npCBmoVR88D7jrlCAdQTDYGWQhS8i+edt7z3JceMtaoEn
	zM03Bj3Z+vozCSRlDhfDl9fGCCchdM9ZUuIHUK21ppwFnJd+kyGanqe/WRNwLYCU
	u7ua+SxA7u4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E2853A0C6;
	Thu, 11 Sep 2014 18:39:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B7E8B3A0C4;
	Thu, 11 Sep 2014 18:39:56 -0400 (EDT)
In-Reply-To: <5410C998.5060701@exec64.co.uk> (Harry Jeffery's message of "Wed,
	10 Sep 2014 22:58:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E2E2DE2-3A04-11E4-8810-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256885>

Harry Jeffery <harry@exec64.co.uk> writes:

> The prefix, separator and suffix for decorations are hard-coded. Make
> format_decorations more flexible by having the caller specify the
> prefix, separator and suffix.
>
> Signed-off-by: Harry Jeffery <harry@exec64.co.uk>
> ---
>  log-tree.c | 16 +++++++++-------
>  log-tree.h |  2 +-
>  pretty.c   |  2 +-
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 95e9b1d..860694c 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -184,9 +184,11 @@ static void show_children(struct rev_info *opt,
> struct commit *commit, int abbre
>   */
>  void format_decorations(struct strbuf *sb,
>  			const struct commit *commit,
> -			int use_color)
> +			int use_color,
> +			const char* prefix,
> +			const char* sep,
> +			const char* suffix)

In our codebase, please make asterisks stick to the variable not the
type, i.e.

	const char *prefix,
        const char *separator,
        const char *suffix)

Was there a reason why "sep" alone needed to be abbreviated?

>  	if (!decoration)
>  		return;
> -	prefix = " (";
> +	strbuf_addstr(sb, prefix);
>  	while (decoration) {
>  		strbuf_addstr(sb, color_commit);
> -		strbuf_addstr(sb, prefix);
>  		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
>  		if (decoration->type == DECORATION_REF_TAG)
>  			strbuf_addstr(sb, "tag: ");
>  		strbuf_addstr(sb, decoration->name);
> +		if(decoration->next)

Have SP between the control statement (i.e. not a function name) and
its opening parenthesis, i.e.

		if (decoration->next)

> +			strbuf_addstr(sb, sep);
>  		strbuf_addstr(sb, color_reset);
> -		prefix = ", ";
>  		decoration = decoration->next;
>  	}

Hmph.  I was kind of found of the nice trick to use a punctuation,
which first points at the prefix " (" and then later points at the
separator ", ", to allow the code that prefixes the punctuation
before showing a new item.  It is now lost.

>  	strbuf_addstr(sb, color_commit);
> -	strbuf_addch(sb, ')');
> +	strbuf_addstr(sb, suffix);
>  	strbuf_addstr(sb, color_reset);
>  }
>
> @@ -221,7 +223,7 @@ void show_decorations(struct rev_info *opt, struct
> commit *commit)
>  		printf("\t%s", (char *) commit->util);
>  	if (!opt->show_decorations)
>  		return;
> -	format_decorations(&sb, commit, opt->diffopt.use_color);
> +	format_decorations(&sb, commit, opt->diffopt.use_color, " (", ", ", ")");
>  	fputs(sb.buf, stdout);
>  	strbuf_release(&sb);
>  }
> diff --git a/log-tree.h b/log-tree.h
> index d6ecd4d..4816911 100644
> --- a/log-tree.h
> +++ b/log-tree.h
> @@ -13,7 +13,7 @@ int log_tree_diff_flush(struct rev_info *);
>  int log_tree_commit(struct rev_info *, struct commit *);
>  int log_tree_opt_parse(struct rev_info *, const char **, int);
>  void show_log(struct rev_info *opt);
> -void format_decorations(struct strbuf *sb, const struct commit
> *commit, int use_color);
> +void format_decorations(struct strbuf *sb, const struct commit
> *commit, int use_color, const char* prefix, const char* sep, const

Linewrapped by your MUA, perhaps?

Again, please check where your asterisks are.

> char* suffix);
>  void show_decorations(struct rev_info *opt, struct commit *commit);
>  void log_write_email_headers(struct rev_info *opt, struct commit *commit,
>  			     const char **subject_p,
> diff --git a/pretty.c b/pretty.c
> index 44b9f64..e4dc093 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1195,7 +1195,7 @@ static size_t format_commit_one(struct strbuf
> *sb, /* in UTF-8 */
>  		return 1;
>  	case 'd':
>  		load_ref_decorations(DECORATE_SHORT_REFS);
> -		format_decorations(sb, commit, c->auto_color);
> +		format_decorations(sb, commit, c->auto_color, " (", ", ", ")");

My eyes hurt staring at this line and the same one in the other
file, trying to see which comma is which.

I wonder if doing something like this once at a single place:

#define format_decorations_std(strbuf, commit, color) \
		format_decorations((strbuf), (commit), (color), " (", ", ", ")")

and using

	format_decorations_std(sb, commit, opt->diffopt.use_color);
	format_decorations_std(sb, commit, c->auto_color);

or even better, name the one that takes three extra parameters as
format_decorations_extended(), and keep the behaviour of the
original one the same, i.e.

	#define format_decorations(strbuf, commit, color) \
		format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")

That way you do not have to touch the original callers, nor you
would have to worry about breaking any topic that somebody else may
be preparing that adds new calls to format_decorations().

>  		return 1;
>  	case 'g':		/* reflog info */
>  		switch(placeholder[1]) {
