Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED47E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 22:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756574AbcHXWkf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 18:40:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63163 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751789AbcHXWkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 18:40:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF8D13830A;
        Wed, 24 Aug 2016 18:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CTt2IKfa3JBelbDDBWguHlGm3ZE=; b=oY8+TX
        bJF8F80RWic6D6vCjbHO3oP09pKmSHCF7LTt/+00vbgyOmh9qBsSFoNnGnUWkTEm
        e+JkZ724oTbSbA5+JSrIGdtzOHrAjM0S4si2ZM4l2PuMj06FgDWiQr9Cd9f5GFcD
        DI12RkwuA1faueQmuTWu8fSagJuR7B4qJCkU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=suWWAJ8LE5zZKhs0Wuop+VTHN7vUT9xT
        aFE/Rv/dgufET70Fl/sCDKuIvyDPYf3guCu2U1O/0DTXHk6WvMZj/14q3VSesFjf
        ZlxqYHr2LL9WA8Zgsslay3UmyOUrUQ3ABZ8rwFfPbqEWBQs0QiWOijsLBOgXUuVg
        BuKVJX6HAN0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B780038309;
        Wed, 24 Aug 2016 18:40:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FA9638308;
        Wed, 24 Aug 2016 18:40:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 11/27] bisect--helper: `bisect_next_check` & bisect_voc shell function in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6ae-27df9d50-59b2-4ee2-8c5b-89e7e70a2dd0-000000@eu-west-1.amazonses.com>
Date:   Wed, 24 Aug 2016 15:40:31 -0700
In-Reply-To: <01020156b73fe6ae-27df9d50-59b2-4ee2-8c5b-89e7e70a2dd0-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqbn0hoko0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C479281A-6A4B-11E6-B94A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int mark_good(const char *refname, const struct object_id *oid,
> +		     int flag, void *cb_data)
> +{
> +	int *m_good = (int *)cb_data;
> +	*m_good = 0;
> +	return 1;
> +}
> +
> +static char *bisect_voc(char *revision_type)
> +{
> +	if (!strcmp(revision_type, "bad"))
> +		return "bad|new";
> +	if (!strcmp(revision_type, "good"))
> +		return "good|old";
> +
> +	return NULL;
> +}
> +
> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good = 1, missing_bad = 1;
> +	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad.buf);
> +	char *good_glob = xstrfmt("%s-*", terms->term_good.buf);
> +	char *bad_syn, *good_syn;
> +
> +	if (ref_exists(bad_ref))
> +		missing_bad = 0;
> +	free(bad_ref);
> +
> +	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> +			     (void *) &missing_good);
> +	free(good_glob);
> +
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
> +		fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
> +			terms->term_bad.buf);
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
> +
> +		return 0;
> +	}
> +	bad_syn = xstrdup(bisect_voc("bad"));
> +	good_syn = xstrdup(bisect_voc("good"));
> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
> +		error(_("You need to give me at least one %s and "
> +			"%s revision. You can use \"git bisect %s\" "
> +			"and \"git bisect %s\" for that. \n"),
> +			bad_syn, good_syn, bad_syn, good_syn);
> +		free(bad_syn);
> +		free(good_syn);
> +		return -1;
> +	}
> +	else {
> +		error(_("You need to start by \"git bisect start\". You "
> +			"then need to give me at least one %s and %s "
> +			"revision. You can use \"git bisect %s\" and "
> +			"\"git bisect %s\" for that.\n"),
> +			good_syn, bad_syn, bad_syn, good_syn);
> +		free(bad_syn);
> +		free(good_syn);
> +		return -1;
> +	}
> +	free(bad_syn);
> +	free(good_syn);
> +
> +	return 0;

This one looks OK, but I think the same "Wouldn't it become cleaner
to have a 'finish:' label at the end and jump there?" comment
applies to this implementation, too.

