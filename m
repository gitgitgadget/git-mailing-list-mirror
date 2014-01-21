From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/16] trailer: process command line trailer arguments
Date: Tue, 21 Jan 2014 14:41:01 -0800
Message-ID: <xmqqd2jlt0ua.fsf@gitster.dls.corp.google.com>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
	<20140119085355.2734.58646.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:41:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5k0S-0005Y0-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbaAUWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 17:41:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbaAUWlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 17:41:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5083B6539A;
	Tue, 21 Jan 2014 17:41:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fOgArDY3frQd6EmALquHz2wrmqI=; b=ZP43Io
	uw/TpcO3y9V0ZWD1s3YXB27yzz9BZUi18owwFUxEhjnDObkLEZm0+JeyMfhXsvKJ
	cHHoVuqHGGQh/DI96yFp7BHMU5qkv5370yhY+ShbFmI688w4pRsg2pds7e5+CsPe
	eCo3mir0qorAvAU4DjdVEwQc9R6hjNDN6vF8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxQ8YfNgCbiSIU411+ForbMDnuqEnf+L
	95dR3oJfJ8ZfXGpBE5A5BNdXWhoYplUoA8DThH3Mdgg6esPhxtmf+pkKqcsbEHAG
	JfYdv2P74yVikfb70QiW0fgWcc1P8XqY6rX+QYaZAcAvDcJwc8xowdk0yjpBsY5A
	VNaJsoMttQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B5A165399;
	Tue, 21 Jan 2014 17:41:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99C6E65397;
	Tue, 21 Jan 2014 17:41:06 -0500 (EST)
In-Reply-To: <20140119085355.2734.58646.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 19 Jan 2014 09:53:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DDFFF80-82ED-11E3-B4D7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240782>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch parses the trailer command line arguments
> and put the result into an arg_tok doubly linked
> list.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  trailer.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/trailer.c b/trailer.c
> index e7d8244..bb1fcfb 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -363,3 +363,80 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
>  	}
>  	return 0;
>  }
> +
> +static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
> +{
> +	char *end = strchr(trailer, '=');
> +	if (!end)
> +		end = strchr(trailer, ':');
> +	if (end) {
> +		strbuf_add(tok, trailer, end - trailer);
> +		strbuf_trim(tok);
> +		strbuf_addstr(val, end + 1);
> +		strbuf_trim(val);
> +	} else {
> +		strbuf_addstr(tok, trailer);
> +		strbuf_trim(tok);
> +	}
> +}
> +
> +static struct trailer_item *create_trailer_item(const char *string)
> +{
> +	struct strbuf tok = STRBUF_INIT;
> +	struct strbuf val = STRBUF_INIT;
> +	struct trailer_item *new;
> +
> +	parse_trailer(&tok, &val, string);
> +
> +	int tok_alnum_len = alnum_len(tok.buf, tok.len);

decl-after-stmt.

> +
> +	/* Lookup if the token matches something in the config */
> +	struct trailer_item *item;
> +	for (item = first_conf_item; item; item = item->next)
> +	{
> +		if (!strncasecmp(tok.buf, item->conf->key, tok_alnum_len) ||
> +		    !strncasecmp(tok.buf, item->conf->name, tok_alnum_len)) {
> +			new = xcalloc(sizeof(struct trailer_item), 1);
> +			new->conf = item->conf;
> +			new->token = xstrdup(item->conf->key);
> +			new->value = strbuf_detach(&val, NULL);
> +			strbuf_release(&tok);
> +			return new;
> +		}
> +	}
> +
> +	new = xcalloc(sizeof(struct trailer_item), 1);
> +	new->conf = xcalloc(sizeof(struct conf_info), 1);
> +	new->token = strbuf_detach(&tok, NULL);
> +	new->value = strbuf_detach(&val, NULL);
> +
> +	return new;
> +}
> +
> +static void add_trailer_item(struct trailer_item **first,
> +			     struct trailer_item **last,
> +			     struct trailer_item *new)
> +{
> +	if (!*last) {
> +		*first = new;
> +		*last = new;
> +	} else {
> +		(*last)->next = new;
> +		new->previous = *last;
> +		*last = new;
> +	}
> +}
> +
> +static struct trailer_item *process_command_line_args(int argc, const char **argv)
> +{
> +	int i;
> +	struct trailer_item *arg_tok_first = NULL;
> +	struct trailer_item *arg_tok_last = NULL;
> +
> +	for (i = 0; i < argc; i++) {
> +		struct trailer_item *new = create_trailer_item(argv[i]);
> +		add_trailer_item(&arg_tok_first, &arg_tok_last, new);
> +	}
> +
> +	return arg_tok_first;
> +}
