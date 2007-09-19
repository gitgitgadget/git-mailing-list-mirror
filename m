From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 01:28:47 -0700
Message-ID: <7v1wcvqcsg.fsf@gitster.siamese.dyndns.org>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224122.2B55D344AB3@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuvb-000342-2g
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbXISI2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754351AbXISI2y
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:28:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbXISI2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:28:53 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 85930137DE6;
	Wed, 19 Sep 2007 04:29:11 -0400 (EDT)
In-Reply-To: <20070918224122.2B55D344AB3@madism.org> (Pierre Habouzit's
	message of "Wed, 19 Sep 2007 00:00:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58696>

Pierre Habouzit <madcoder@debian.org> writes:

> ...
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-apply.c          |   83 +++++--------
>  builtin-blame.c          |    3 +-
>  builtin-check-attr.c     |    2 +-
>  builtin-checkout-index.c |    4 +-
>  builtin-ls-files.c       |   13 +--
>  builtin-ls-tree.c        |    6 +-
>  combine-diff.c           |   16 +--
>  diff.c                   |  303 +++++++++++++++++-----------------------------
>  quote.c                  |  198 +++++++++++++++++-------------
>  quote.h                  |    8 +-
>  10 files changed, 268 insertions(+), 368 deletions(-)
> ...
> diff --git a/builtin-apply.c b/builtin-apply.c
> index cffbe52..0328863 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1378,61 +1377,50 @@ static const char minuses[]= "--------------------------------------------------
>  
>  static void show_stats(struct patch *patch)
>  {
> -	const char *prefix = "";
> -	char *name = patch->new_name;
> -	char *qname = NULL;
> -	int len, max, add, del, total;
> -
> -	if (!name)
> -		name = patch->old_name;
> +	struct strbuf qname;
> +	char *cp = patch->new_name ? patch->new_name : patch->old_name;
> +	int max, add, del;
>  
> -	if (0 < (len = quote_c_style(name, NULL, NULL, 0))) {
> -		qname = xmalloc(len + 1);
> -		quote_c_style(name, qname, NULL, 0);
> -		name = qname;
> -	}
> +	strbuf_init(&qname, 0);
> +	quote_c_style(cp, &qname, NULL, 0);
>  
>  	/*
>  	 * "scale" the filename
>  	 */
> -	len = strlen(name);
>  	max = max_len;
>  	if (max > 50)
>  		max = 50;
> -	if (len > max) {
> -		char *slash;
> -		prefix = "...";
> -		max -= 3;
> -		name += len - max;
> -		slash = strchr(name, '/');
> -		if (slash)
> -			name = slash;
> +
> +	if (qname.len > max) {
> +		cp = strchr(qname.buf + qname.len + 3 - max, '/');
> +		if (cp)
> +			cp = qname.buf + qname.len + 3 - max;
> +		strbuf_splice(&qname, 0, cp - qname.buf, "...", 3);
> +	}

At this point, you have max that is larger by 3 than what old
code had.  That would make the next two printf() you added as
expected.  This affects scaling of add/delete code.  Is this
intentional?  I _think_ the change is correct (there is no
reason that name display being cliped should affect the length
of the bar graph), but that should have been documented as a
separate bugfix in the commit log.

> diff --git a/quote.c b/quote.c
> index 67c6527..a8a755a 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -114,83 +114,142 @@ char *sq_dequote(char *arg)
>  	}
>  }
>  
> +/* 1 means: quote as octal
> + * 0 means: quote as octal if (quote_path_fully)
> + * -1 means: never quote
> + * c: quote as "\\c"
> + */
> +#define X8(x)   x, x, x, x, x, x, x, x
> +#define X16(x)  X8(x), X8(x)
> +static signed char const sq_lookup[256] = {
> +	/*           0    1    2    3    4    5    6    7 */
> +	/* 0x00 */   1,   1,   1,   1,   1,   1, 'a',   1,

Isn't BEL == 0x07, not 0x06?

> +	/* 0x08 */ 'b', 't', 'n', 'v', 'f', 'r',   1,   1,
> +	/* 0x10 */ X16(1),
> +	/* 0x20 */  -1,  -1, '"',  -1,  -1,  -1,  -1,  -1,
> +	/* 0x28 */ X16(-1), X16(-1), X16(-1),
> +	/* 0x58 */  -1,  -1,  -1,  -1,'\\',  -1,  -1,  -1,
> +	/* 0x60 */ X16(-1), X16(-1),

Shouldn't you quote DEL == 0177 here?

> +	/* 0x80 */ /* set to 0 */
> +};
> +
> +static inline int sq_must_quote(char c) {
> +	return sq_lookup[(unsigned char)c] + quote_path_fully > 0;
> +}
> +
> +/* returns the longest prefix not needing a quote up to maxlen if positive.
> +   This stops at the first \0 because it's marked as a character needing an
> +   escape */
> +static size_t next_quote_pos(const char *s, ssize_t maxlen)
> +{
> +	size_t len;
> +	if (maxlen < 0) {
> +		for (len = 0; !sq_must_quote(s[len]); len++);
> +	} else {
> +		for (len = 0; len < maxlen && !sq_must_quote(s[len]); len++);
> +	}
> +	return len;
> +}
> +
>  /*
>   * C-style name quoting.
>   *
> - * Does one of three things:
> - *
>   * (1) if outbuf and outfp are both NULL, inspect the input name and
>   *     counts the number of bytes that are needed to hold c_style
>   *     quoted version of name, counting the double quotes around
>   *     it but not terminating NUL, and returns it.  However, if name
>   *     does not need c_style quoting, it returns 0.
>   *

You need to update this comment; you do not have outbuf nor
outfp anymore, you have something else.
