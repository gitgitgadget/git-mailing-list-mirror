From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Thu, 06 Feb 2014 16:03:10 -0800
Message-ID: <xmqqr47fx001.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.96525.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:03:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBYuc-0003PY-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbaBGADP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:03:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbaBGADO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:03:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39D46AF9D;
	Thu,  6 Feb 2014 19:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I1ETij2gobefr3oVVcDWqD8sx/E=; b=MQIwXw
	Oo7f6lYBwZaFDDd3z4x5G32gCFTjsHmT0xxoM7EPg0f/SpFbIopFBSZmAvgUMzxn
	SgrNsW66JR+gL16rzoIjf4pAiE3m7DsNWisH39qqpG26HC+HrKMfCEqi+5mdi6eg
	8CarkUT8R2Bb87Ubwr4t5ofqyEzsw0/4adm4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NU5XCazx5SRtBRdtWRqmPVY0fIJMsVWx
	27J6Ru2CDZgn8TUbPf8pPMERpj6LidyKUEZN7LHePP+apDGeFzLVFQ5P/e9DPiwW
	T+WRqCGcborS+V3NOJVwPrhWQZYlUp2N/pVWJgSFbpytRK5n9eCFp32cpgVR3QW+
	0q9URd/nZk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7A06AF9B;
	Thu,  6 Feb 2014 19:03:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F0BD6AF98;
	Thu,  6 Feb 2014 19:03:12 -0500 (EST)
In-Reply-To: <20140206202004.325.96525.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3C230384-8F8B-11E3-A48F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241750>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch implements the logic that process trailers
> from file and arguments.
>
> At the beginning trailers from file are in their own
> infile_tok doubly linked list, and trailers from
> arguments are in their own arg_tok doubly linked list.
>
> The lists are traversed and when an arg_tok should be
> "applied", it is removed from its list and inserted
> into the infile_tok list.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  trailer.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
>
> diff --git a/trailer.c b/trailer.c
> index f129b5a..ba0cfe0 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -46,3 +46,190 @@ static inline size_t alnum_len(const char *buf, int len)
>  	while (--len >= 0 && !isalnum(buf[len]));
>  	return (size_t) len + 1;
>  }
> +
> +static void add_arg_to_infile(struct trailer_item *infile_tok,
> +			      struct trailer_item *arg_tok)
> +{
> +	if (arg_tok->conf->where == WHERE_AFTER) {
> +		arg_tok->next = infile_tok->next;
> +		infile_tok->next = arg_tok;
> +		arg_tok->previous = infile_tok;
> +		if (arg_tok->next)
> +			arg_tok->next->previous = arg_tok;
> +	} else {
> +		arg_tok->previous = infile_tok->previous;
> +		infile_tok->previous = arg_tok;
> +		arg_tok->next = infile_tok;
> +		if (arg_tok->previous)
> +			arg_tok->previous->next = arg_tok;
> +	}
> +}
> +
> +static int check_if_different(struct trailer_item *infile_tok,
> +			      struct trailer_item *arg_tok,
> +			      int alnum_len, int check_all)
> +{
> +	enum action_where where = arg_tok->conf->where;
> +	do {
> +		if (!infile_tok)
> +			return 1;
> +		if (same_trailer(infile_tok, arg_tok, alnum_len))
> +			return 0;
> +		/*
> +		 * if we want to add a trailer after another one,
> +		 * we have to check those before this one
> +		 */
> +		infile_tok = (where == WHERE_AFTER) ? infile_tok->previous : infile_tok->next;
> +	} while (check_all);
> +	return 1;
> +}
> +
> +static void apply_arg_if_exist(struct trailer_item *infile_tok,
> +			       struct trailer_item *arg_tok,
> +			       int alnum_len)
> +{
> +	switch (arg_tok->conf->if_exist) {
> +	case EXIST_DO_NOTHING:
> +		free(arg_tok);
> +		break;
> +	case EXIST_OVERWRITE:
> +		free((char *)infile_tok->value);
> +		infile_tok->value = xstrdup(arg_tok->value);
> +		free(arg_tok);
> +		break;
> +	case EXIST_ADD:
> +		add_arg_to_infile(infile_tok, arg_tok);
> +		break;
> +	case EXIST_ADD_IF_DIFFERENT:
> +		if (check_if_different(infile_tok, arg_tok, alnum_len, 1))
> +			add_arg_to_infile(infile_tok, arg_tok);
> +		else
> +			free(arg_tok);
> +		break;
> +	case EXIST_ADD_IF_DIFFERENT_NEIGHBOR:
> +		if (check_if_different(infile_tok, arg_tok, alnum_len, 0))
> +			add_arg_to_infile(infile_tok, arg_tok);
> +		else
> +			free(arg_tok);
> +		break;

Makes me wonder if people want a rule to say "if the same key
already exists, regardless of the value".

> +	}
> +}
> +
> +static void remove_from_list(struct trailer_item *item,
> +			     struct trailer_item **first)
> +{
> +	if (item->next)
> +		item->next->previous = item->previous;
> +	if (item->previous)
> +		item->previous->next = item->next;
> +	else
> +		*first = item->next;
> +}

Will callers free the item that now is not on the list?

> +static struct trailer_item *remove_first(struct trailer_item **first)
> +{
> +	struct trailer_item *item = *first;
> +	*first = item->next;
> +	if (item->next) {
> +		item->next->previous = NULL;
> +		item->next = NULL;
> +	}
> +	return item;
> +}
> +
> +static void process_infile_tok(struct trailer_item *infile_tok,
> +			       struct trailer_item **arg_tok_first,
> +			       enum action_where where)
> +{
> +	struct trailer_item *arg_tok;
> +	struct trailer_item *next_arg;
> +
> +	int tok_alnum_len = alnum_len(infile_tok->token, strlen(infile_tok->token));
> +	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
> +		next_arg = arg_tok->next;
> +		if (same_token(infile_tok, arg_tok, tok_alnum_len) &&
> +		    arg_tok->conf->where == where) {
> +			remove_from_list(arg_tok, arg_tok_first);
> +			apply_arg_if_exist(infile_tok, arg_tok, tok_alnum_len);
> +			/*
> +			 * If arg has been added to infile,
> +			 * then we need to process it too now.
> +			 */
> +			if ((where == WHERE_AFTER ? infile_tok->next : infile_tok->previous) == arg_tok)
> +				infile_tok = arg_tok;
> +		}
> +	}
> +}
> +
> +static void update_last(struct trailer_item **last)
> +{
> +	if (*last)
> +		while((*last)->next != NULL)
> +			*last = (*last)->next;
> +}
> +
> +static void update_first(struct trailer_item **first)
> +{
> +	if (*first)
> +		while((*first)->previous != NULL)
> +			*first = (*first)->previous;
> +}
> +
> +static void apply_arg_if_missing(struct trailer_item **infile_tok_first,
> +				 struct trailer_item **infile_tok_last,
> +				 struct trailer_item *arg_tok)
> +{

Makes me wonder if it would make the code simpler to keep an anchor
item "struct trailer_item" that is off heap, and pass that single
anchor item around, using its next/prev fields as the first and the
last.  Wouldn't it let you remove the special cases for the first
and last item?

> +	struct trailer_item **infile_tok;
> +	enum action_where where;
> +
> +	switch (arg_tok->conf->if_missing) {
> +	case MISSING_DO_NOTHING:
> +		free(arg_tok);
> +		break;
> +	case MISSING_ADD:
> +		where = arg_tok->conf->where;
> +		infile_tok = (where == WHERE_AFTER) ? infile_tok_last : infile_tok_first;
> +		if (*infile_tok) {
> +			add_arg_to_infile(*infile_tok, arg_tok);
> +			*infile_tok = arg_tok;
> +		} else {
> +			*infile_tok_first = arg_tok;
> +			*infile_tok_last = arg_tok;
> +		}
> +		break;

This piece makes me wonder if "after" is a good name.  prepend and
append, perhaps?
