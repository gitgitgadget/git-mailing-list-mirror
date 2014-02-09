From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and
 arguments
Date: Sun, 09 Feb 2014 14:52:05 +0100 (CET)
Message-ID: <20140209.145205.1882309246743951569.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.96525.chriscool@tuxfamily.org>
	<xmqqr47fx001.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 09 14:52:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCUnt-00058U-P7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 14:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbaBINwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 08:52:09 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:33602 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbaBINwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 08:52:08 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id D299859;
	Sun,  9 Feb 2014 14:52:05 +0100 (CET)
In-Reply-To: <xmqqr47fx001.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241876>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> +static void apply_arg_if_exist(struct trailer_item *infile_tok,
>> +			       struct trailer_item *arg_tok,
>> +			       int alnum_len)
>> +{
>> +	switch (arg_tok->conf->if_exist) {
>> +	case EXIST_DO_NOTHING:
>> +		free(arg_tok);
>> +		break;
>> +	case EXIST_OVERWRITE:
>> +		free((char *)infile_tok->value);
>> +		infile_tok->value = xstrdup(arg_tok->value);
>> +		free(arg_tok);
>> +		break;
>> +	case EXIST_ADD:
>> +		add_arg_to_infile(infile_tok, arg_tok);
>> +		break;
>> +	case EXIST_ADD_IF_DIFFERENT:
>> +		if (check_if_different(infile_tok, arg_tok, alnum_len, 1))
>> +			add_arg_to_infile(infile_tok, arg_tok);
>> +		else
>> +			free(arg_tok);
>> +		break;
>> +	case EXIST_ADD_IF_DIFFERENT_NEIGHBOR:
>> +		if (check_if_different(infile_tok, arg_tok, alnum_len, 0))
>> +			add_arg_to_infile(infile_tok, arg_tok);
>> +		else
>> +			free(arg_tok);
>> +		break;
> 
> Makes me wonder if people want a rule to say "if the same key
> already exists, regardless of the value".

This is what "if_exists" and "if_missing" are all about.

Either:

	the same key already exists regardless of the value

and, in this case, what happens depends on what has been specified using
the "if_exists" configuration variable.

Or:

	the same key DOES NOT already exists regardless of the value

and in this case, what happens depends on what has been specified
using the "if_missing" configuration variable.

>> +static void remove_from_list(struct trailer_item *item,
>> +			     struct trailer_item **first)
>> +{
>> +	if (item->next)
>> +		item->next->previous = item->previous;
>> +	if (item->previous)
>> +		item->previous->next = item->next;
>> +	else
>> +		*first = item->next;
>> +}
> 
> Will callers free the item that now is not on the list?

Yes, or the item will be inserted into another list.

>> +static struct trailer_item *remove_first(struct trailer_item **first)
>> +{
>> +	struct trailer_item *item = *first;
>> +	*first = item->next;
>> +	if (item->next) {
>> +		item->next->previous = NULL;
>> +		item->next = NULL;
>> +	}
>> +	return item;
>> +}
>> +
>> +static void process_infile_tok(struct trailer_item *infile_tok,
>> +			       struct trailer_item **arg_tok_first,
>> +			       enum action_where where)
>> +{
>> +	struct trailer_item *arg_tok;
>> +	struct trailer_item *next_arg;
>> +
>> +	int tok_alnum_len = alnum_len(infile_tok->token, strlen(infile_tok->token));
>> +	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
>> +		next_arg = arg_tok->next;
>> +		if (same_token(infile_tok, arg_tok, tok_alnum_len) &&
>> +		    arg_tok->conf->where == where) {
>> +			remove_from_list(arg_tok, arg_tok_first);
>> +			apply_arg_if_exist(infile_tok, arg_tok, tok_alnum_len);
>> +			/*
>> +			 * If arg has been added to infile,
>> +			 * then we need to process it too now.
>> +			 */
>> +			if ((where == WHERE_AFTER ? infile_tok->next : infile_tok->previous) == arg_tok)
>> +				infile_tok = arg_tok;
>> +		}
>> +	}
>> +}
>> +
>> +static void update_last(struct trailer_item **last)
>> +{
>> +	if (*last)
>> +		while((*last)->next != NULL)
>> +			*last = (*last)->next;
>> +}
>> +
>> +static void update_first(struct trailer_item **first)
>> +{
>> +	if (*first)
>> +		while((*first)->previous != NULL)
>> +			*first = (*first)->previous;
>> +}
>> +
>> +static void apply_arg_if_missing(struct trailer_item **infile_tok_first,
>> +				 struct trailer_item **infile_tok_last,
>> +				 struct trailer_item *arg_tok)
>> +{
> 
> Makes me wonder if it would make the code simpler to keep an anchor
> item "struct trailer_item" that is off heap, and pass that single
> anchor item around, using its next/prev fields as the first and the
> last.  Wouldn't it let you remove the special cases for the first
> and last item?

Yeah, that could work. On the other hand the other fields of this
special item would not be used for anything.
I will have a look at it.

>> +	struct trailer_item **infile_tok;
>> +	enum action_where where;
>> +
>> +	switch (arg_tok->conf->if_missing) {
>> +	case MISSING_DO_NOTHING:
>> +		free(arg_tok);
>> +		break;
>> +	case MISSING_ADD:
>> +		where = arg_tok->conf->where;
>> +		infile_tok = (where == WHERE_AFTER) ? infile_tok_last : infile_tok_first;
>> +		if (*infile_tok) {
>> +			add_arg_to_infile(*infile_tok, arg_tok);
>> +			*infile_tok = arg_tok;
>> +		} else {
>> +			*infile_tok_first = arg_tok;
>> +			*infile_tok_last = arg_tok;
>> +		}
>> +		break;
> 
> This piece makes me wonder if "after" is a good name.  prepend and
> append, perhaps?

The problem is that "prepend" and "append" could be confusing when
related to EXISTS_DO_NOTHING, MISSING_DO_NOTHING and EXISTS_OVERWRITE.

Also WHERE_MIDDLE and WHERE_SORTED could perhaps be added later in the
same enum as WHERE_AFTER and WHERE_BEFORE, and in this case, we would
need to find names for those that are like "prepend" and "append", but
that are also difficult to confuse with the EXISTS_XXX and MISSING_XXX
names.

Thanks,
Christian.
