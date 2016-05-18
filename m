From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 12:47:50 -0700
Message-ID: <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
References: <20160518190222.28105-1-sbeller@google.com>
	<20160518190222.28105-6-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 21:48:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37Rn-0005N6-Td
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbcERTrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:47:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752013AbcERTry (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:47:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 713A51CA06;
	Wed, 18 May 2016 15:47:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wRllnjPSj/wO6vbds8KobvNJwmU=; b=ZFNc09
	cbhnwNnRV12zhDoi/K3dzNJ6cUuQD5X5sXL2eYzpup50cdqRhyua6f5OtfIVHNMQ
	YzzC6qFX4OsQBeKxeCI0k2XSFt5otP0JTniP4Nmx7MberwxBBakdfW3MufoHfwPL
	4/+5960cuzeqWR9c639oJcJxggmHEaVS4KFPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1caCuXQG8C3oteo/ZlALmweSBS8pLYP
	/dSOAsFodEnrEGkud24p9jHVNiAA+quyvQFfgV0eBxKEs2vSdnf3c/6m2zaysVOi
	m5ht1Mxrf3ehTRkCQnvO1Sa5iO6JZhJgmaFVrXEj+IsMRN0B9dJYralg7u4XtYue
	nJBwoonh83w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 677D91CA05;
	Wed, 18 May 2016 15:47:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7DD61CA04;
	Wed, 18 May 2016 15:47:52 -0400 (EDT)
In-Reply-To: <20160518190222.28105-6-sbeller@google.com> (Stefan Beller's
	message of "Wed, 18 May 2016 12:02:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 689B5002-1D31-11E6-98B8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294997>

Stefan Beller <sbeller@google.com> writes:

> + - "`+`" the attribute must be set
> + - "`-`" the attribute must be unset
> + - "`~`" the attribute must be unspecified

I think using these three, not the way how .gitattributes specify
them, is highly confusing to the users.

> + - "`?`" the attribute must not be unspecified, i.e. set, unset or value matches

The choice of '?' is OK, as there is no reason .gitattributes wants
to say something fuzzy like "this is set or unset or has value".
The last part "set, unset or value matches" does not make sense,
though.  Did you mean "set, unset or set to value"?

> + - an empty "`[mode]`" matches if the attribute is set or has a value

The same comment as +/-/~ above applies.

> + - an empty "`[mode]`" combined with "`[=value]`" matches if the attribute has
> +   the given value.

I.e. "eol=crlf" matches only for paths whose eol attribute is set to
"crlf".  Makes perfect sense.


> diff --git a/dir.c b/dir.c
> index 996653b..3141a5a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -9,6 +9,7 @@
>   */
>  #include "cache.h"
>  #include "dir.h"
> +#include "attr.h"
>  #include "refs.h"
>  #include "wildmatch.h"
>  #include "pathspec.h"
> @@ -215,6 +216,48 @@ int within_depth(const char *name, int namelen,
>  	return 1;
>  }
>  
> +static int match_attrs(const char *name, int namelen,
> +		       const struct pathspec_item *item)
> +{
> +	char *path;
> +	int i;
> +
> +	path = xmemdupz(name, namelen);
> +	git_check_attr(path, item->attr_check);
> +
> +	for (i = 0; i < item->attr_match_nr; i++) {
> +		const char *value;
> +		int matched;
> +		enum attr_match_mode match_mode;
> +
> +		value = item->attr_check->check[i].value;
> +
> +		match_mode = item->attr_match[i].match_mode;

Mental note: there is a one-to-one correspondence between
attr_check->check[] and attr_match[].

> +		if (!matched)
> +			return 0;

So this ANDs together.  OK.

> +	}
> +
> +	free(path);

Let me see how involved a change would be to allow passing a counted
string to git_check_attr().

> diff --git a/pathspec.c b/pathspec.c
> index 4dff252..32fb6a8 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "dir.h"
>  #include "pathspec.h"
> +#include "attr.h"
>  
>  /*
>   * Finds which of the given pathspecs match items in the index.
> @@ -88,12 +89,82 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
>  	strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }
>  

Mental note after skiming the caller:

The "value" here is like "VAR1=VAL1 VAR2 !VAR3" in a pathspec
":(attr:VAR1=VAL1 VAR2 !VAR3)path/to/limit", i.e. the source string
to be compiled into a list of conditionals that will be evaluated by
match_attr() in dir.c

> +static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
> +{
> +	struct string_list_item *si;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +
> +	if (!value || !strlen(value))
> +		goto err;
> +
> +	string_list_split(&list, value, ' ', -1);
> +	string_list_remove_empty_items(&list, 0);

At this point, we got "VAR1=VAL1", "VAR2", "!VAR3" as elements in
this list.

> +	if (!item->attr_check)
> +		item->attr_check = git_attr_check_alloc();

Given more than one "attr" magic, e.g. ":(attr:A=a,attr:B)/path",
the check may not be empty when we process the second one; we just
extend it without losing the existing contents.

> +	ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->attr_match_alloc);

Likewise, we extend attr_match[] array.

> +	for_each_string_list_item(si, &list) {
> +		size_t val_len;
> +
> +		int j = item->attr_match_nr++;
> +		const char *val = si->string;
> +		struct attr_match *am = &item->attr_match[j];
> +
> +		if (val[0] == '?')
> +			am->match_mode = MATCH_NOT_UNSPECIFIED;
> +		else if (val[0] == '~')
> +			am->match_mode = MATCH_UNSPECIFIED;
> +		else if (val[0] == '+')
> +			am->match_mode = MATCH_SET;
> +		else if (val[0] == '-')
> +			am->match_mode = MATCH_UNSET;
> +		else
> +			am->match_mode = MATCH_SET_OR_VALUE;
> +
> +		if (am->match_mode != MATCH_SET_OR_VALUE)
> +			/* skip first character */
> +			val++;
> +
> +		val_len = strcspn(val, "=,)");

I understand "=", but can "," and ")" appear here?

> +		if (val[val_len] == '=') {
> +			am->match_mode = MATCH_VALUE;
> +			am->value = xstrdup(&val[val_len + 1]);
> +			/*
> +			 * NEEDSWORK:
> +			 * Do we want to allow escaped commas to search
> +			 * for comma separated values?
> +			 */

No, we don't ;-).

> +			if (strchr(am->value, '\\'))
> +				die(_("attr spec values must not contain backslashes"));

But this is a good escape hatch to reserve for our own use, until we
decide what the quoting mechanism will be (or if it is necessary).

> +		} else
> +			am->value = NULL;
> +
> +		if (invalid_attr_name(val, val_len)) {
> +			am->match_mode = INVALID_ATTR;
> +			goto err;
> +		}
> +
> +		am->attr = git_attr(xmemdupz(val, val_len));
> +		git_attr_check_append(item->attr_check, am->attr);

GOOD!

I think val and val_len should be renamed to attr and attr_len (in
the VARIABLE=VALUE context, these two identifiers are about parsing
the variable side, not the value side).

> +	}
> +
> +	string_list_clear(&list, 0);
> +	return;
> +err:
> +	die(_("attr spec '%s': attrs must not start with '-' and "
> +	      "be composed of [-A-Za-z0-9_.]."), value);

What is "value" at this point?  If you failed to parse the second
element in "VAR1=VAL1 FR*TZ=VAL2 !VAR3", I think you would want to
say "'FR*TZ' is malformed".

Existing users of the function seems to say this:

		if (invalid_attr_name(cp, len)) {
			fprintf(stderr,
				"%.*s is not a valid attribute name: %s:%d\n",
				len, cp, src, lineno);
			return NULL;
		}

when parsing .gitattribute file.  The source file:line reference
does not apply to this context, but it would be better to unify the
message.  I do not mind spelling the rules out explicitly like you
did, but I do not want to see it spread across many places (which
forces us to update them when we have to change the rule later).

Perhaps we want a helper function in attr.c side that takes the
attribute name string (val, val_len in your code above, which I
suggest to be renamed to attr, attr_len) and formats the error
message into a strbuf, or something?

	void
	attr_name_error(struct strbuf *err, const char *name, size_t len)
        {
		strbuf_addf(_("invalid attribute name: '%.*s'"), len, name);
	}

then this one can say

	err: {
        	struct strbuf err = STRBUF_INIT;
		attr_name_error(&err, attr, attr_len);
                die(err.buf);
	}

while the error routines can do a similar thing using cp and len,
and then append "%s:%d" % (src, lineno) at the end themselves.

>  static void eat_long_magic(struct pathspec_item *item, const char *elt,
>  		unsigned *magic, int *pathspec_prefix,
>  		const char **copyfrom_, const char **long_magic_end)
>  {
>  	int i;
>  	const char *copyfrom = *copyfrom_;
> +	const char *body;
>  	/* longhand */
>  	const char *nextat;
>  	for (copyfrom = elt + 2;
> @@ -108,15 +179,21 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
>  		if (!len)
>  			continue;
>  
> -		if (starts_with(copyfrom, "prefix:")) {
> +		if (skip_prefix(copyfrom, "prefix:", &body)) {
>  			char *endptr;
> -			*pathspec_prefix = strtol(copyfrom + 7,
> -						  &endptr, 10);
> +			*pathspec_prefix = strtol(body, &endptr, 10);
>  			if (endptr - copyfrom != len)
>  				die(_("invalid parameter for pathspec magic 'prefix'"));
>  			continue;
>  		}
>  
> +		if (skip_prefix(copyfrom, "attr:", &body)) {
> +			char *pass = xmemdupz(body, len - strlen("attr:"));
> +			parse_pathspec_attr_match(item, pass);
> +			free(pass);
> +			continue;

Makes me wonder what "pass" stands for.  From the look of xmemdupz(),
given ":(attr:VAR1=VAL1 VAR2 !VAR3)path/to/limit" to parse, len
points at ")" and xmemdupz() gives "VAR1=VAL1 VAR2 !VAR3" to it.

> @@ -502,6 +589,14 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
>  
>  void free_pathspec(struct pathspec *pathspec)
>  {
> +	int i, j;
> +	for (i = 0; i < pathspec->nr; i++) {
> +		for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
> +			free(pathspec->items[i].attr_match[j].value);
> +		free(pathspec->items[i].attr_match);
> +		git_attr_check_free(pathspec->items[i].attr_check);
> +	}

OK.

Overall very nicely done (modulo nits mentioned above, none of which
is unfixable).

Thanks.
