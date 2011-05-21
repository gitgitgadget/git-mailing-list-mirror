From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/4] streaming filter: ident filter and filter cascading
Date: Sat, 21 May 2011 23:05:53 +0200
Message-ID: <4DD82931.6000101@lsrfire.ath.cx>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com> <1305961127-26540-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 23:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNtNS-0004ok-JV
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab1EUVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 17:06:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:57831 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab1EUVGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 17:06:14 -0400
Received: from [192.168.2.106] (p579BE3D8.dip.t-dialin.net [87.155.227.216])
	by india601.server4you.de (Postfix) with ESMTPSA id B31AF2F8086;
	Sat, 21 May 2011 23:06:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1305961127-26540-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174175>

Am 21.05.2011 08:58, schrieb Junio C Hamano:
> Add support for "ident" filter on the output codepath. Because we now have
> more than one filter active, also add support to cascade them together.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * There is one known issue in this "ident" filter implementation. If the
>    input data ends while the filter is still in the "SKIPPING" state, it
>    should go to the "DRAINING" codepath using the same logic that triggers
>    when it gets to the end of line, copying out what was already queued.
>    However, the API does not offer an explicit way for the input side to
>    say "that's all". We probably need to make a zero-byte input to the
>    filter function as an explicit EOF signal or something---currently I
>    think it will loop forever, but it is getting late, so I will not be
>    further touching this code tonight.

AFAIU it will leave skipping mode once there is no input data anymore
instead of looping forever.  The accumulated stuff will be discarded.

The test suite is passed, by the way, even though t0021 seems to contain
a test for this issue (NoTerminatingSymbolAtEOF).  It uses echo to
create the files so there will be a terminating newline before the end
of the file, though, so this subtest probably needs to be changed.

> 
>  convert.c |  254 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 246 insertions(+), 8 deletions(-)
> 

Perhaps split off the cascading part into its own patch?

> diff --git a/convert.c b/convert.c
> index 82fb75b..6b90c4d 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -868,6 +868,10 @@ int is_null_stream_filter(struct stream_filter *filter)
>  	return filter == &null_filter_singleton;
>  }
>  
> +
> +/*
> + * LF-to-CRLF filter
> + */
>  static int lf_to_crlf_filter_fn(struct stream_filter *filter,
>  				const char *input, size_t *isize_p,
>  				char *output, size_t *osize_p)
> @@ -901,6 +905,237 @@ static struct stream_filter lf_to_crlf_filter_singleton = {
>  	&lf_to_crlf_vtbl,
>  };
>  
> +
> +/*
> + * Cascade filter
> + */
> +#define FILTER_BUFFER 1024
> +struct cascade_filter {
> +	struct stream_filter filter;
> +	struct stream_filter *one;
> +	struct stream_filter *two;
> +	char ibuf[FILTER_BUFFER];
> +	char obuf[FILTER_BUFFER];
> +	int i_end, i_ptr;
> +	int o_end, o_ptr;
> +};
> +
> +static int cascade_filter_fn(struct stream_filter *filter,
> +			     const char *input, size_t *isize_p,
> +			     char *output, size_t *osize_p)
> +{
> +	struct cascade_filter *cas = (struct cascade_filter *) filter;
> +	size_t filled = 0;
> +	size_t sz = *osize_p;
> +	size_t to_feed, remaining;
> +
> +	/*
> +	 * input --> ibuf --(one)--> obuf --(two)--> output
> +	 */
> +	while (filled < sz) {
> +		/* do we already have output to feed two? */
> +		if (cas->o_ptr < cas->o_end) {
> +			to_feed = cas->o_end - cas->o_ptr;
> +			remaining = sz - filled;
> +			if (stream_filter(cas->two,
> +					  cas->obuf + cas->o_ptr, &to_feed,
> +					  output + filled, &remaining))
> +				return -1;
> +			cas->o_ptr += (cas->o_end - cas->o_ptr) - to_feed;
> +			filled = sz - remaining;
> +			continue;
> +		}
> +		cas->o_end = cas->o_ptr = 0;
> +
> +		/* do we have anything to feed one? */
> +		if (cas->i_ptr < cas->i_end) {
> +			to_feed = cas->i_end - cas->i_ptr;
> +			remaining = sizeof(cas->obuf);
> +			if (stream_filter(cas->one,
> +					  cas->ibuf + cas->i_ptr, &to_feed,
> +					  cas->obuf, &remaining))
> +				return -1;
> +			cas->i_ptr += (cas->i_end - cas->i_ptr) - to_feed;
> +			cas->o_end = sizeof(cas->obuf) - remaining;
> +			continue;
> +		}
> +		cas->i_end = cas->i_ptr = 0;
> +
> +		/* read from our upstream */
> +		to_feed = *isize_p;
> +		if (sizeof(cas->ibuf) < to_feed)
> +			to_feed = sizeof(cas->ibuf);
> +		if (!to_feed)
> +			break;
> +		memcpy(cas->ibuf, input, to_feed);
> +		input += to_feed;
> +		*isize_p -= to_feed;
> +		cas->i_end = to_feed;
> +	}
> +	*osize_p -= filled;
> +	return 0;
> +}
> +
> +static void cascade_free_fn(struct stream_filter *filter)
> +{
> +	struct cascade_filter *cas = (struct cascade_filter *)filter;
> +	free_stream_filter(cas->one);
> +	free_stream_filter(cas->two);
> +	free(filter);
> +}
> +
> +static struct stream_filter_vtbl cascade_vtbl = {
> +	cascade_filter_fn,
> +	cascade_free_fn,
> +};
> +
> +static struct stream_filter *cascade_filter(struct stream_filter *one,
> +					    struct stream_filter *two)
> +{
> +	struct cascade_filter *cascade;
> +
> +	if (!one || is_null_stream_filter(one))
> +		return two;
> +	if (!two || is_null_stream_filter(two))
> +		return one;

The is_null_stream_filter() check could be left out initially.  This
would allow for testing the cascading part with null filters.

> +
> +	cascade = xmalloc(sizeof(*cascade));
> +	cascade->one = one;
> +	cascade->two = two;
> +	cascade->i_end = cascade->i_ptr = 0;
> +	cascade->o_end = cascade->o_ptr = 0;
> +	cascade->filter.vtbl = &cascade_vtbl;
> +	return (struct stream_filter *)cascade;
> +}
> +
> +/*
> + * ident filter
> + */
> +#define IDENT_DRAINING (-1)
> +#define IDENT_SKIPPING (-2)
> +struct ident_filter {
> +	struct stream_filter filter;
> +	struct strbuf left;
> +	int state;
> +	char ident[45]; /* ": x40 $" */
> +};
> +
> +static int is_foreign_ident(const char *str)
> +{
> +	int i;
> +
> +	if (prefixcmp(str, "$Id: "))
> +		return 0;
> +	for (i = 5; str[i]; i++) {
> +		if (isspace(str[i]) && str[i+1] != '$')
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static int ident_filter_fn(struct stream_filter *filter,
> +			   const char *input, size_t *isize_p,
> +			   char *output, size_t *osize_p)
> +{
> +	struct ident_filter *ident = (struct ident_filter *)filter;
> +	static const char head[] = "$Id";
> +
> +	while (*isize_p || (ident->state == IDENT_DRAINING)) {
> +		int ch;
> +
> +		if (ident->state == IDENT_DRAINING) {
> +			/* Draining what is in left */
> +			size_t to_drain = ident->left.len;
> +
> +			if (!to_drain) {
> +				ident->state = 0;
> +				continue;
> +			}
> +			if (!*osize_p)
> +				break;
> +			if (*osize_p < to_drain)
> +				to_drain = *osize_p;
> +			memcpy(output, ident->left.buf, to_drain);
> +			strbuf_remove(&ident->left, 0, to_drain);
> +			output += to_drain;
> +			(*osize_p) -= to_drain;
> +			continue;
> +		}
> +
> +		ch = *(input++);
> +		(*isize_p)--;
> +
> +		if (ident->state == IDENT_SKIPPING) {
> +			/*
> +			 * Skipping until '$' or LF, but keeping them
> +			 * in case it is a foreign ident.
> +			 */
> +			strbuf_addch(&ident->left, ch);
> +			if (ch != '\n' && ch != '$')
> +				continue;
> +			if (ch == '$' && !is_foreign_ident(ident->left.buf)) {
> +				strbuf_reset(&ident->left);
> +				strbuf_addstr(&ident->left, head);
> +				strbuf_addstr(&ident->left, ident->ident);
> +			}
> +			ident->state = IDENT_DRAINING;
> +			continue;
> +		}
> +
> +		if (ident->state < sizeof(head) &&

		// minus one because otherwise we'd compare the
		// terminating NUL as well even though we're not
		// actually looking for a NUL
		if (ident->state < sizeof(head) - 1 &&

> +		    head[ident->state] == ch) {
> +			ident->state++;
> +			continue;
> +		}
> +
> +		if (ident->state)
> +			strbuf_add(&ident->left, head, ident->state);
> +		if (ident->state == sizeof(head) - 1) {
> +			if (ch != ':' && ch != '$') {
> +				strbuf_addch(&ident->left, ch);
> +				ident->state = 0;

				// clean the plate right here and now;
				// can be combined with the case at the
				// end of the loop
				ident->state = IDENT_DRAINING;

> +				continue;
> +			}
> +
> +			if (ch == ':') {
> +				strbuf_addch(&ident->left, ch);
> +				ident->state = IDENT_SKIPPING;
> +			} else {
> +				strbuf_addstr(&ident->left, ident->ident);
> +				ident->state = IDENT_DRAINING;
> +			}
> +			continue;
> +		}
> +
> +		strbuf_addch(&ident->left, ch);
> +		ident->state = IDENT_DRAINING;
> +	}
> +	return 0;
> +}
> +
> +static void ident_free_fn(struct stream_filter *filter)
> +{
> +	struct ident_filter *ident = (struct ident_filter *)filter;
> +	strbuf_release(&ident->left);
> +	free(filter);
> +}
> +
> +static struct stream_filter_vtbl ident_vtbl = {
> +	ident_filter_fn,
> +	ident_free_fn,
> +};
> +
> +static struct stream_filter *ident_filter(const unsigned char *sha1)
> +{
> +	struct ident_filter *ident = xmalloc(sizeof(*ident));
> +
> +	sprintf(ident->ident, ": %s $", sha1_to_hex(sha1));
> +	strbuf_init(&ident->left, 0);
> +	ident->filter.vtbl = &ident_vtbl;
> +	ident->state = 0;
> +	return (struct stream_filter *)ident;
> +}
> +
>  /*
>   * Return an appropriately constructed filter for the path, or NULL if
>   * the contents cannot be filtered without reading the whole thing
> @@ -913,23 +1148,26 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
>  {
>  	struct conv_attrs ca;
>  	enum crlf_action crlf_action;
> +	struct stream_filter *filter = NULL;
>  
>  	convert_attrs(&ca, path);
>  
> -	if (ca.ident ||
> -	    (ca.drv && (ca.drv->smudge || ca.drv->clean)))
> -		return NULL;
> +	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
> +		return filter;
> +
> +	if (ca.ident)
> +		filter = ident_filter(sha1);
>  
>  	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
>  	if ((crlf_action == CRLF_BINARY) || (crlf_action == CRLF_INPUT) ||
>  	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
> -		return &null_filter_singleton;
> +		filter = cascade_filter(filter, &null_filter_singleton);
>  
> -	if (output_eol(crlf_action) == EOL_CRLF &&
> -	    !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS))
> -		return &lf_to_crlf_filter_singleton;
> +	else if (output_eol(crlf_action) == EOL_CRLF &&
> +		 !(crlf_action == CRLF_AUTO || crlf_action == CRLF_GUESS))
> +		filter = cascade_filter(filter, &lf_to_crlf_filter_singleton);
>  
> -	return NULL;
> +	return filter;
>  }
>  
>  void free_stream_filter(struct stream_filter *filter)
