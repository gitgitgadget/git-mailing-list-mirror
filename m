Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368B520281
	for <e@80x24.org>; Mon,  6 Nov 2017 02:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdKFCaw (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 21:30:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751734AbdKFCal (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 21:30:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA1F6B4A05;
        Sun,  5 Nov 2017 21:30:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gEPcFginMUC1bn2TzuDu1N/MPyI=; b=FCAJbv
        bAoOXCpgGHjjSrYY0pmHMZ2dfMLxC1EpM3doiVj9hoqR93axt4n0KK9PMcDQKGGl
        qG23xHB+JDOP1h2pCzXnYP31X0Q5GFM9JGHiXtLj2mUVujnO+D3OxYBJb9MZV1bf
        nCVMR6Klc5LZ+lVAShALkUeX2nnEwKLvLqsP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PVQNIqpHcYVlIX8BNCYzuGQoTIIB+mhn
        0aQ0lis0Qi+KynuPZYDlrOoWEILMWskHZIfpM1tstpG6/E/NmUukqABqDD1E1fbs
        hLO02wBj//fjPmxfyCCM684XzsaXWlYUBmN9SE4UunVFOg3wfHg3XB+PCLJ/mp6H
        JRtMeJeJRRo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1678B4A04;
        Sun,  5 Nov 2017 21:30:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 501E9B4A03;
        Sun,  5 Nov 2017 21:30:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [RFC PATCH v3 4/4] builtin/branch: give more useful error messages when renaming
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
        <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20171102065407.25404-5-kaartic.sivaraam@gmail.com>
Date:   Mon, 06 Nov 2017 11:30:39 +0900
In-Reply-To: <20171102065407.25404-5-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 2 Nov 2017 12:24:07 +0530")
Message-ID: <xmqq375sjfzk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B0F578C-C29A-11E7-ABEA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7018e5d75..c2bbf8c3d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -458,11 +458,42 @@ static void reject_rebase_or_bisect_branch(const char *target)
>  	free_worktrees(worktrees);
>  }
>  
> +static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
> +			  const char* newname, enum branch_validation_result res)
> +{
> +	const char* connector_string = _(", and ");
> +
> +	if (!old_branch_exists) {
> +		strbuf_addf(error_msg, _("branch '%s' doesn't exist"), oldname);
> +	}

No {} around a single statement block of "if", especially when there
is no "else" that has multi-statement block that needs {}.

> +	switch (res) {
> +		case BRANCH_EXISTS_NO_FORCE:
> +			strbuf_addf(error_msg, "%s", (!old_branch_exists) ? connector_string : "");
> +			strbuf_addf(error_msg,_("branch '%s' already exists"), newname);
> +			break;

The case arms and their statements are indented by one level too much.
The lines are getting overlong.  Find a good place to split, e.g.

    		strbuf_addf(error_msg, "%s",
			!old_branch_exists ? connector_string : "");

Leave a single SP after each "," in an arguments list.

As Eric pointed out, this certainly smells like a sentence lego that
we would be better off without.

>  static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
>  {
>  	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
>  	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
>  	int recovery = 0;
> +	struct strbuf error_msg = STRBUF_INIT, empty = STRBUF_INIT;
> +	enum branch_validation_result res;
>  
>  	if (!oldname) {
>  		if (copy)
> @@ -471,15 +502,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  			die(_("cannot rename the current branch while not on any."));
>  	}
>  
> -	if (strbuf_check_branch_ref(&oldref, oldname)) {
> +	if (strbuf_check_branch_ref(&oldref, oldname) && ref_exists(oldref.buf))
> +	{

Opening brace { that begins a block comes at the end of the line
that closes the condition of "if"; if you found that your line is
overlong, perhaps do it like so instead:

	if (strbuf_check_branch_ref(&oldref, oldname) &&
	    ref_exists(oldref.buf)) {
