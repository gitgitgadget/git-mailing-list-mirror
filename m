From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 20/27] update-ref --stdin: Reimplement using reference transactions
Date: Tue, 01 Apr 2014 12:46:11 -0700
Message-ID: <xmqqppl0zvcs.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-21-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4da-00061p-2C
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaDATqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:46:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbaDATqO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:46:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85FB79BA8;
	Tue,  1 Apr 2014 15:46:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FuGnKjkN5EuqTkgqB6Krf3Fs2pQ=; b=XX0/mA
	mQwWQ4AiDSPaFfVCT2F27/eHnxR1wjF4p1s6xtpp5vY1v8UbGtbzsEjWBxzeHw2o
	R81fEDO90oLRnisuLAZM/HQ0KpeAazMRR/UPywBtQBsAN/eIm1bC4JEy/uXpzyI6
	h6/BzbsXqprN481zNd/KQep/M8oNpkCvso20Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PriM87j2TYl03zu6gRJlDByU43u81XRS
	iv7XXS5DVEXmk2nuuuRiDQxgDprzsSznz+n2RV0lFPzR0tWTax+dqytl+1g7fwuM
	x5J2ML6hUsySsgXNX3sZBgc5kyE/Cb3bVRKhWowOZ0Hvk6IMSlqs5J150sg4ckW3
	t8YzLlAfYnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F0AD79BA7;
	Tue,  1 Apr 2014 15:46:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9804779BA4;
	Tue,  1 Apr 2014 15:46:12 -0400 (EDT)
In-Reply-To: <1395683820-17304-21-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 479F9AA4-B9D6-11E3-B5A5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245640>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This change is mostly clerical: the parse_cmd_*() functions need to
> use local variables rather than a struct ref_update to collect the
> arguments needed for each update, and then call ref_transaction_*() to
> queue the change rather than building up the list of changes at the
> caller side.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

With the implementation of ref_transaction at this point in the
series it does not matter, but the updated code in this patch means
that it is perfectly acceptable to do this sequence:

    ref_transaction_begin();
    ref_transaction_update();
    ...
    ref_transaction_update();
    die();

without ever calling ref_transaction_rollback() API function.
Depending on the future backends, we may want to ensure rollback is
called, no?  And if that is the case, we would want to prepare
callers of the API with some at-exit facility to call rollback, no?

Other than that, the code looks straight-forward.

Thanks.

>  builtin/update-ref.c | 142 +++++++++++++++++++++++++++------------------------
>  1 file changed, 75 insertions(+), 67 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index bbc04b2..2c8678b 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -12,29 +12,11 @@ static const char * const git_update_ref_usage[] = {
>  	NULL
>  };
>  
> -static int updates_alloc;
> -static int updates_count;
> -static struct ref_update **updates;
> +static struct ref_transaction *transaction;
>  
>  static char line_termination = '\n';
>  static int update_flags;
>  
> -static struct ref_update *update_alloc(void)
> -{
> -	struct ref_update *update;
> -
> -	/* Allocate and zero-init a struct ref_update */
> -	update = xcalloc(1, sizeof(*update));
> -	ALLOC_GROW(updates, updates_count + 1, updates_alloc);
> -	updates[updates_count++] = update;
> -
> -	/* Store and reset accumulated options */
> -	update->flags = update_flags;
> -	update_flags = 0;
> -
> -	return update;
> -}
> -
>  /*
>   * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
>   * and append the result to arg.  Return a pointer to the terminator.
> @@ -196,97 +178,119 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
>  
>  static const char *parse_cmd_update(struct strbuf *input, const char *next)
>  {
> -	struct ref_update *update;
> -
> -	update = update_alloc();
> +	char *refname;
> +	unsigned char new_sha1[20];
> +	unsigned char old_sha1[20];
> +	int have_old;
>  
> -	update->ref_name = parse_refname(input, &next);
> -	if (!update->ref_name)
> +	refname = parse_refname(input, &next);
> +	if (!refname)
>  		die("update: missing <ref>");
>  
> -	if (parse_next_sha1(input, &next, update->new_sha1,
> -			    "update", update->ref_name,
> +	if (parse_next_sha1(input, &next, new_sha1, "update", refname,
>  			    PARSE_SHA1_ALLOW_EMPTY))
> -		die("update %s: missing <newvalue>", update->ref_name);
> +		die("update %s: missing <newvalue>", refname);
>  
> -	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
> -					    "update", update->ref_name,
> -					    PARSE_SHA1_OLD);
> +	have_old = !parse_next_sha1(input, &next, old_sha1, "update", refname,
> +				    PARSE_SHA1_OLD);
>  
>  	if (*next != line_termination)
> -		die("update %s: extra input: %s", update->ref_name, next);
> +		die("update %s: extra input: %s", refname, next);
> +
> +	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +			       update_flags, have_old);
> +
> +	update_flags = 0;
> +	free(refname);
>  
>  	return next;
>  }
>  
>  static const char *parse_cmd_create(struct strbuf *input, const char *next)
>  {
> -	struct ref_update *update;
> -
> -	update = update_alloc();
> +	char *refname;
> +	unsigned char new_sha1[20];
>  
> -	update->ref_name = parse_refname(input, &next);
> -	if (!update->ref_name)
> +	refname = parse_refname(input, &next);
> +	if (!refname)
>  		die("create: missing <ref>");
>  
> -	if (parse_next_sha1(input, &next, update->new_sha1,
> -			    "create", update->ref_name, 0))
> -		die("create %s: missing <newvalue>", update->ref_name);
> +	if (parse_next_sha1(input, &next, new_sha1, "create", refname, 0))
> +		die("create %s: missing <newvalue>", refname);
>  
> -	if (is_null_sha1(update->new_sha1))
> -		die("create %s: zero <newvalue>", update->ref_name);
> +	if (is_null_sha1(new_sha1))
> +		die("create %s: zero <newvalue>", refname);
>  
>  	if (*next != line_termination)
> -		die("create %s: extra input: %s", update->ref_name, next);
> +		die("create %s: extra input: %s", refname, next);
> +
> +	ref_transaction_create(transaction, refname, new_sha1, update_flags);
> +
> +	update_flags = 0;
> +	free(refname);
>  
>  	return next;
>  }
>  
>  static const char *parse_cmd_delete(struct strbuf *input, const char *next)
>  {
> -	struct ref_update *update;
> +	char *refname;
> +	unsigned char old_sha1[20];
> +	int have_old;
>  
> -	update = update_alloc();
> -
> -	update->ref_name = parse_refname(input, &next);
> -	if (!update->ref_name)
> +	refname = parse_refname(input, &next);
> +	if (!refname)
>  		die("delete: missing <ref>");
>  
> -	if (parse_next_sha1(input, &next, update->old_sha1,
> -			    "delete", update->ref_name, PARSE_SHA1_OLD)) {
> -		update->have_old = 0;
> +	if (parse_next_sha1(input, &next, old_sha1, "delete", refname,
> +			    PARSE_SHA1_OLD)) {
> +		have_old = 0;
>  	} else {
> -		if (is_null_sha1(update->old_sha1))
> -			die("delete %s: zero <oldvalue>", update->ref_name);
> -		update->have_old = 1;
> +		if (is_null_sha1(old_sha1))
> +			die("delete %s: zero <oldvalue>", refname);
> +		have_old = 1;
>  	}
>  
>  	if (*next != line_termination)
> -		die("delete %s: extra input: %s", update->ref_name, next);
> +		die("delete %s: extra input: %s", refname, next);
> +
> +	ref_transaction_delete(transaction, refname, old_sha1,
> +			       update_flags, have_old);
> +
> +	update_flags = 0;
> +	free(refname);
>  
>  	return next;
>  }
>  
>  static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  {
> -	struct ref_update *update;
> -
> -	update = update_alloc();
> +	char *refname;
> +	unsigned char new_sha1[20];
> +	unsigned char old_sha1[20];
> +	int have_old;
>  
> -	update->ref_name = parse_refname(input, &next);
> -	if (!update->ref_name)
> +	refname = parse_refname(input, &next);
> +	if (!refname)
>  		die("verify: missing <ref>");
>  
> -	if (parse_next_sha1(input, &next, update->old_sha1,
> -			    "verify", update->ref_name, PARSE_SHA1_OLD)) {
> -		update->have_old = 0;
> +	if (parse_next_sha1(input, &next, old_sha1, "verify", refname,
> +			    PARSE_SHA1_OLD)) {
> +		hashclr(new_sha1);
> +		have_old = 0;
>  	} else {
> -		hashcpy(update->new_sha1, update->old_sha1);
> -		update->have_old = 1;
> +		hashcpy(new_sha1, old_sha1);
> +		have_old = 1;
>  	}
>  
>  	if (*next != line_termination)
> -		die("verify %s: extra input: %s", update->ref_name, next);
> +		die("verify %s: extra input: %s", refname, next);
> +
> +	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +			       update_flags, have_old);
> +
> +	update_flags = 0;
> +	free(refname);
>  
>  	return next;
>  }
> @@ -355,13 +359,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  		die("Refusing to perform update with empty message.");
>  
>  	if (read_stdin) {
> +		int ret;
> +		transaction = ref_transaction_begin();
> +
>  		if (delete || no_deref || argc > 0)
>  			usage_with_options(git_update_ref_usage, options);
>  		if (end_null)
>  			line_termination = '\0';
>  		update_refs_stdin();
> -		return update_refs(msg, updates, updates_count,
> -				   UPDATE_REFS_DIE_ON_ERR);
> +		ret = ref_transaction_commit(transaction, msg,
> +					     UPDATE_REFS_DIE_ON_ERR);
> +		return ret;
>  	}
>  
>  	if (end_null)
