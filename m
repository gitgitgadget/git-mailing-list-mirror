From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 4/5] make get_short_ref a public function
Date: Tue, 07 Apr 2009 09:57:46 +0200
Message-ID: <49DB077A.1060506@drmicha.warpmail.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <20090407071420.GD2924@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6EB-0007T4-KY
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbZDGH5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbZDGH5y
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:57:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60097 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754925AbZDGH5x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 03:57:53 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id E8FA8313E2C;
	Tue,  7 Apr 2009 03:57:50 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 07 Apr 2009 03:57:50 -0400
X-Sasl-enc: QXlOIMBr4d34Sq8tLd7enLM3PC8hIBsRQrdIp74+eSn9 1239091070
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0F8D071AB;
	Tue,  7 Apr 2009 03:57:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090407 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090407071420.GD2924@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115925>

Jeff King venit, vidit, dixit 07.04.2009 09:14:
> Often we want to shorten a full ref name to something "prettier"
> to show a user. For example, "refs/heads/master" is often shown
> simply as "master", or "refs/remotes/origin/master" is shown as
> "origin/master".
> 
> Many places in the code use a very simple formula: skip common
> prefixes like refs/heads, refs/remotes, etc. This is codified in
> the prettify_ref function.
> 
> for-each-ref has a more correct (but more expensive) approach:
> consider the ref lookup rules, and try shortening as much as
> possible while remaining unambiguous.
> 
> This patch makes the latter strategy globally available as
> shorten_unambiguous_ref.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Actually, I am not quite sure that this function is "more correct". It
> looks at the rev-parsing rules as a hierarchy, so if you have
> "refs/remotes/foo" and "refs/heads/foo", then it will abbreviate the
> first to "remotes/foo" (as expected) and the latter to just "foo".
> 
> This is technically correct, as "refs/heads/foo" will be selected by
> "foo", but it will warn about ambiguity. Should we actually try to avoid
> reporting refs which would be ambiguous?
> 
> Should this simply replace prettify_ref (and other places which should
> be using prettify_ref but aren't)? It is definitely more expensive, as
> it has to resolve refs to look for ambiguities, but I don't know if we
> care in most code paths.

I would think that as long as the default is to warn about ambiguous
refs we should not generate ambiguous refs...

Other than that it's very nice, it can be used in many places.

> 
>  builtin-for-each-ref.c |  105 +-----------------------------------------------
>  refs.c                 |   99 +++++++++++++++++++++++++++++++++++++++++++++
>  refs.h                 |    1 +
>  3 files changed, 101 insertions(+), 104 deletions(-)
> 
> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index 277d1fb..8c82484 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -546,109 +546,6 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
>  }
>  
>  /*
> - * generate a format suitable for scanf from a ref_rev_parse_rules
> - * rule, that is replace the "%.*s" spec with a "%s" spec
> - */
> -static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
> -{
> -	char *spec;
> -
> -	spec = strstr(rule, "%.*s");
> -	if (!spec || strstr(spec + 4, "%.*s"))
> -		die("invalid rule in ref_rev_parse_rules: %s", rule);
> -
> -	/* copy all until spec */
> -	strncpy(scanf_fmt, rule, spec - rule);
> -	scanf_fmt[spec - rule] = '\0';
> -	/* copy new spec */
> -	strcat(scanf_fmt, "%s");
> -	/* copy remaining rule */
> -	strcat(scanf_fmt, spec + 4);
> -
> -	return;
> -}
> -
> -/*
> - * Shorten the refname to an non-ambiguous form
> - */
> -static char *get_short_ref(const char *ref)
> -{
> -	int i;
> -	static char **scanf_fmts;
> -	static int nr_rules;
> -	char *short_name;
> -
> -	/* pre generate scanf formats from ref_rev_parse_rules[] */
> -	if (!nr_rules) {
> -		size_t total_len = 0;
> -
> -		/* the rule list is NULL terminated, count them first */
> -		for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
> -			/* no +1 because strlen("%s") < strlen("%.*s") */
> -			total_len += strlen(ref_rev_parse_rules[nr_rules]);
> -
> -		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
> -
> -		total_len = 0;
> -		for (i = 0; i < nr_rules; i++) {
> -			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules]
> -					+ total_len;
> -			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
> -			total_len += strlen(ref_rev_parse_rules[i]);
> -		}
> -	}
> -
> -	/* bail out if there are no rules */
> -	if (!nr_rules)
> -		return xstrdup(ref);
> -
> -	/* buffer for scanf result, at most ref must fit */
> -	short_name = xstrdup(ref);
> -
> -	/* skip first rule, it will always match */
> -	for (i = nr_rules - 1; i > 0 ; --i) {
> -		int j;
> -		int short_name_len;
> -
> -		if (1 != sscanf(ref, scanf_fmts[i], short_name))
> -			continue;
> -
> -		short_name_len = strlen(short_name);
> -
> -		/*
> -		 * check if the short name resolves to a valid ref,
> -		 * but use only rules prior to the matched one
> -		 */
> -		for (j = 0; j < i; j++) {
> -			const char *rule = ref_rev_parse_rules[j];
> -			unsigned char short_objectname[20];
> -			char refname[PATH_MAX];
> -
> -			/*
> -			 * the short name is ambiguous, if it resolves
> -			 * (with this previous rule) to a valid ref
> -			 * read_ref() returns 0 on success
> -			 */
> -			mksnpath(refname, sizeof(refname),
> -				 rule, short_name_len, short_name);
> -			if (!read_ref(refname, short_objectname))
> -				break;
> -		}
> -
> -		/*
> -		 * short name is non-ambiguous if all previous rules
> -		 * haven't resolved to a valid ref
> -		 */
> -		if (j == i)
> -			return short_name;
> -	}
> -
> -	free(short_name);
> -	return xstrdup(ref);
> -}
> -
> -
> -/*
>   * Parse the object referred by ref, and grab needed value.
>   */
>  static void populate_value(struct refinfo *ref)
> @@ -704,7 +601,7 @@ static void populate_value(struct refinfo *ref)
>  		if (formatp) {
>  			formatp++;
>  			if (!strcmp(formatp, "short"))
> -				refname = get_short_ref(refname);
> +				refname = shorten_unambiguous_ref(refname);
>  			else
>  				die("unknown %.*s format %s",
>  					formatp - name, name, formatp);
> diff --git a/refs.c b/refs.c
> index 59c373f..1e5e7b4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1652,3 +1652,102 @@ struct ref *find_ref_by_name(const struct ref *list, const char *name)
>  			return (struct ref *)list;
>  	return NULL;
>  }
> +
> +/*
> + * generate a format suitable for scanf from a ref_rev_parse_rules
> + * rule, that is replace the "%.*s" spec with a "%s" spec
> + */
> +static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
> +{
> +	char *spec;
> +
> +	spec = strstr(rule, "%.*s");
> +	if (!spec || strstr(spec + 4, "%.*s"))
> +		die("invalid rule in ref_rev_parse_rules: %s", rule);
> +
> +	/* copy all until spec */
> +	strncpy(scanf_fmt, rule, spec - rule);
> +	scanf_fmt[spec - rule] = '\0';
> +	/* copy new spec */
> +	strcat(scanf_fmt, "%s");
> +	/* copy remaining rule */
> +	strcat(scanf_fmt, spec + 4);
> +
> +	return;
> +}
> +
> +char *shorten_unambiguous_ref(const char *ref)
> +{
> +	int i;
> +	static char **scanf_fmts;
> +	static int nr_rules;
> +	char *short_name;
> +
> +	/* pre generate scanf formats from ref_rev_parse_rules[] */
> +	if (!nr_rules) {
> +		size_t total_len = 0;
> +
> +		/* the rule list is NULL terminated, count them first */
> +		for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
> +			/* no +1 because strlen("%s") < strlen("%.*s") */
> +			total_len += strlen(ref_rev_parse_rules[nr_rules]);
> +
> +		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
> +
> +		total_len = 0;
> +		for (i = 0; i < nr_rules; i++) {
> +			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules]
> +					+ total_len;
> +			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
> +			total_len += strlen(ref_rev_parse_rules[i]);
> +		}
> +	}
> +
> +	/* bail out if there are no rules */
> +	if (!nr_rules)
> +		return xstrdup(ref);
> +
> +	/* buffer for scanf result, at most ref must fit */
> +	short_name = xstrdup(ref);
> +
> +	/* skip first rule, it will always match */
> +	for (i = nr_rules - 1; i > 0 ; --i) {
> +		int j;
> +		int short_name_len;
> +
> +		if (1 != sscanf(ref, scanf_fmts[i], short_name))
> +			continue;
> +
> +		short_name_len = strlen(short_name);
> +
> +		/*
> +		 * check if the short name resolves to a valid ref,
> +		 * but use only rules prior to the matched one
> +		 */
> +		for (j = 0; j < i; j++) {
> +			const char *rule = ref_rev_parse_rules[j];
> +			unsigned char short_objectname[20];
> +			char refname[PATH_MAX];
> +
> +			/*
> +			 * the short name is ambiguous, if it resolves
> +			 * (with this previous rule) to a valid ref
> +			 * read_ref() returns 0 on success
> +			 */
> +			mksnpath(refname, sizeof(refname),
> +				 rule, short_name_len, short_name);
> +			if (!read_ref(refname, short_objectname))
> +				break;
> +		}
> +
> +		/*
> +		 * short name is non-ambiguous if all previous rules
> +		 * haven't resolved to a valid ref
> +		 */
> +		if (j == i)
> +			return short_name;
> +	}
> +
> +	free(short_name);
> +	return xstrdup(ref);
> +}
> diff --git a/refs.h b/refs.h
> index 68c2d16..2d0f961 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -80,6 +80,7 @@ extern int for_each_reflog(each_ref_fn, void *);
>  extern int check_ref_format(const char *target);
>  
>  extern const char *prettify_ref(const struct ref *ref);
> +extern char *shorten_unambiguous_ref(const char *ref);
>  
>  /** rename ref, return 0 on success **/
>  extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
