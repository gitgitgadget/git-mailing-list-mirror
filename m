Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA5BC38BFA
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033072176D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q28XYmgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBXWFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:05:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55031 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXWFq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 17:05:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F2F8A7D9D;
        Mon, 24 Feb 2020 17:05:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PMlV7occX1koFZdv5tM+8un8d0A=; b=q28XYm
        gDsfTZcBZuIAy+zX9kvJTNegqYXzgPZmazZbrNkrnqHmwbVhiStzJeCLgzhdZO3p
        RTBZkY4zKsv+4EoCUfqh7fmQxFZU2g1b7pbjROC1i6cNh27slS2MnDVkH2YBTZKx
        tZ7/yIxr7PCbaDpqDE1O51evcY6aEQ4GBp0+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZvfSEedyN6w30jvpZDgk8nOztM/+asPw
        wlI4aVICSkhrM3OvkEaatPsLK4jAWznPiKst5aU59IgNXPqrMv9uZO+SqzK6LFj3
        8o6cGWngkfAtqbbAF25217GTYNruTkv34bsOU+d4+ExJz+hPwehsqVzdqUSktb9I
        02lANVfZ3Y4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47C6EA7D9C;
        Mon, 24 Feb 2020 17:05:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C84BA7D9B;
        Mon, 24 Feb 2020 17:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v4 2/3] advice: revamp advise API
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
        <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 14:05:32 -0800
In-Reply-To: <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Mon, 24 Feb 2020 15:13:17
        +0000")
Message-ID: <xmqqftezod3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7D1D772-5751-11EA-AF22-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static void vadvise(const char *advice, va_list params)
> +static const char *advice_config_keys[] = {
> +	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
> +	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
> +	/* make this an alias for backward compatibility */
> +	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
> +...
> +	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
> +	[NESTED_TAG]				 = "nestedTag",
> +	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
> +};

Terminate the last entry of the array with a trailing comma ',', so
that the next person who adds one new advise key to the table at the
end has to just add only one line without changing any existing lines.

As you are using the designated initializers for this array, we are
free to order the lines in any way that makes most sense to us and
do not have to order the lines in numerical order.  In what order
are these lines sorted right now?  I am tempted to suggest that we
should sort alphabetically on the values, i.e. run the contents of
the table through "LC_ALL=C sort -k2,2 -t=".

> +
> +static const char turn_off_instructions[] =
> +N_("\n"
> +   "Disable this message with \"git config %s false\"");
> +
> +static void vadvise(const char *advice, va_list params,
> +		    int display_instructions, char *key)

It may be just me, but I feel uneasy when I see va_list in the
middle of the parameter list.  As it is a mechanism to allow us
handle "the remainder of the arguments", it logically makes more
sense to have it as the last parameter.

>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *cp, *np;
>  
>  	strbuf_vaddf(&buf, advice, params);
>  
> +	if(display_instructions)
> +		strbuf_addf(&buf, turn_off_instructions, key);

Style.  We always have one SP between a syntactic keyword like "if"
and open parenthesis.

> +
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
>  		fprintf(stderr,	_("%shint: %.*s%s\n"),
> @@ -119,8 +161,42 @@ void advise(const char *advice, ...)
>  {
>  	va_list params;
>  	va_start(params, advice);
> -	vadvise(advice, params);
> +	vadvise(advice, params, 0, "");
> +	va_end(params);
> +}
> +
> +static int get_config_value(enum advice_type type)
> +{
> +	int value = 1;
> +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);

Have a blank line between the decl and the first statement, i.e. here.

> +	git_config_get_bool(key, &value);
> +	free(key);
> +	return value;
> +}
> +
> +int advice_enabled(enum advice_type type)
> +{
> +	switch(type) {

Style.

> +	case PUSH_UPDATE_REJECTED:
> +		return get_config_value(PUSH_UPDATE_REJECTED) &&
> +		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
> +	default:
> +		return get_config_value(type);
> +	}
> +}
> +
> +void advise_if_enabled(enum advice_type type, const char *advice, ...)
> +{
> +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> +	va_list params;
> +
> +	if(!advice_enabled(type))

Stile.

> +		return;
> +
> +	va_start(params, advice);
> +	vadvise(advice, params, 1, key);
>  	va_end(params);
> +	free(key);
>  }
>  
>  int git_default_advice_config(const char *var, const char *value)
> @@ -159,8 +235,8 @@ void list_config_advices(struct string_list *list, const char *prefix)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
> -		list_config_item(list, prefix, advice_config[i].name);
> +	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
> +		list_config_item(list, prefix, advice_config_keys[i]);
>  }
>  
>  int error_resolve_conflict(const char *me)
> diff --git a/advice.h b/advice.h
> index b706780614d..61a7ee82827 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -32,9 +32,61 @@ extern int advice_checkout_ambiguous_remote_branch_name;
>  extern int advice_nested_tag;
>  extern int advice_submodule_alternate_error_strategy_die;
>  
> +/**
> + To add a new advice, you need to:
> + - Define an advice_type.
> + - Add a new entry to advice_config_keys list.
> + - Add the new config variable to Documentation/config/advice.txt.
> + - Call advise_if_enabled to print your advice.
> + */

    /*
     * Our multi-line comments should look
     * more like this (multiple style violations
     * in this patch).
     */

> +enum advice_type {
> +	FETCH_SHOW_FORCED_UPDATES = 0,
> +	PUSH_UPDATE_REJECTED = 1,
> +	PUSH_UPDATE_REJECTED_ALIAS = 2,
> +	PUSH_NON_FF_CURRENT = 3,

Do we need to spell out the values, or is it sufficient to let the
compiler automatically count up?  Does any code depend on the exact
numeric value of the advice type, or at least at the source code
level the only thing we care about them is that they are distinct?

I'd really want to get rid of these exact value assignments---they
are source of unnecessary conflicts when two or more topics want to
add new advice types of their own.

I also suggest that these are sorted alphabetically.

> + ...
> +	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
> +};

> +++ b/t/t0018-advice.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +
> +test_description='Test advise_if_enabled functionality'
> +
> +. ./test-lib.sh
> +
> +cat > expected <<EOF
> +hint: This is a piece of advice
> +hint: Disable this message with "git config advice.nestedTag false"
> +EOF
> +test_expect_success 'advise should be printed when config variable is unset' '
> +	test-tool advise "This is a piece of advice" 2>actual &&
> +	test_i18ncmp expected actual
> +'

 - Prepare the expected output inside test_expect_success block that
   uses it.

 - There should be no SP between a redirection operator and the
   filename.

 - Here-doc that does not use parameter expansion should use a
   quoted EOF marker.

 - The file that gets compared with "actual" is by convention called
   "expect", not "expected".

i.e.

test_expect_success 'advise should be printed when config variable is unset' '
	cat >expect <<-\EOF &&
	hint: ...
	hint: ...
	EOF
	test-tool advise "This is a piece of advice" 2>actual &&
	test_i18ncmp expected actual
'
