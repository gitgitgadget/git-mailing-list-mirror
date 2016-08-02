Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5E21F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 19:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbcHBTRl (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 15:17:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754472AbcHBTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 15:17:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9D3833B83;
	Tue,  2 Aug 2016 15:17:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rchs4ubOhBII/q67GX0Vtlsw2Ao=; b=P/FQ2H
	0eR8Uiyl2G0J+4nz4CfAhqL7okNlvcNbadfWehu1MBJ59sc8ckH/Plj/LDQQ6Fw0
	GD7tnEwtZ5HL3nm5KjF8YvmUn3901RfC3DxXU390odo+sYjczU9n+fxmdRhBp8AH
	Lwy665kbiw448BH6jUofyrow+R8jmRxQQU09U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5KyjXe6m98mSVrDF+fZbbFXLkYcU1YO
	x4X+2Ac7XlBIT0TIjogxHi9g+QiBiNFh0XRun0N0qurwqkWP1C7PEBruY/A/dtYB
	++HIvc9mmZctRNzhSBPLti0nrUHhgzqjLHwNz8dVCHSFXHjuuxKqnCo37YFkRIJA
	o673jwP+LxM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A016A33B82;
	Tue,  2 Aug 2016 15:17:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A6EE33B81;
	Tue,  2 Aug 2016 15:17:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 11/13] bisect--helper: `bisect_next_check` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423d08-3af7e66f-4104-4b0c-a3c7-dff29b843b2d-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 12:17:23 -0700
In-Reply-To: <0102015640423d08-3af7e66f-4104-4b0c-a3c7-dff29b843b2d-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqq60rjdlq4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF461C44-58E5-11E6-87E5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int mark_good(const char *refname, const struct object_id *oid,
> +		     int flag, void *cb_data)
> +{
> +	int *m_good = (int *)cb_data;
> +	*m_good = 0;
> +	return 0;
> +}

See below.

> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good = 1, missing_bad = 1;

It is somewhat unusual to start with "assume we are OK" and then
"it turns out that we are not".

> +	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad.buf);
> +	char *good_glob = xstrfmt("%s*", terms->term_good.buf);

The original runs

    git for-each-ref "refs/bisect/$TERM_GOOD-*

but this one lacks the final dash.

> +	if (ref_exists(bad_ref))
> +		missing_bad = 0;
> +	free(bad_ref);
> +
> +	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> +			     (void *) &missing_good);
> +	free(good_glob);

The for-each helper does not return until it iterates over all the
matching refs, but you are only interested in seeing if at least one
exists.  It may make sense to return 1 from mark_good() to terminate
the traversal early.

> +	if (!missing_good && !missing_bad)
> +		return 0;
> +
> +	if (!current_term)
> +		return -1;
> +
> +	if (missing_good && !missing_bad && current_term &&
> +	    !strcmp(current_term, terms->term_good.buf)) {
> +		char *yesno;
> +		/*
> +		 * have bad (or new) but not good (or old). We could bisect
> +		 * although this is less optimum.
> +		 */
> +		fprintf(stderr, "Warning: bisecting only with a %s commit\n",
> +			terms->term_bad.buf);

In the original, this message goes through gettext.

> +		if (!isatty(0))
> +			return 0;
> +		/*
> +		 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +		 * translation. The program will only accept English input
> +		 * at this point.
> +		 */
> +		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
> +		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
> +			return -1;
> +		return 0;
> +	}

When the control falls into the above if(){} block, the function
will always return.  It will clarify that this is the end of such a
logical block to have a blank line here.

> +	if (!is_empty_or_missing_file(git_path_bisect_start()))
> +		return error(_("You need to give me at least one good|old and "
> +				"bad|new revision. You can use \"git bisect "
> +				"bad|new\" and \"git bisect good|old\" for "
> +				"that. \n"));
> +	else
> +		return error(_("You need to start by \"git bisect start\". "
> +				"You then need to give me at least one good|"
> +				"old and bad|new revision. You can use \"git "
> +				"bisect bad|new\" and \"git bisect good|old\" "
> +				" for that.\n"));

The i18n on these two messages seem to be different from the
original, which asks bisect_voc to learn what 'bad' and 'good' are
called and attempts to use these words from the vocabulary.
