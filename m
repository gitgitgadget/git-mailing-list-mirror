Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629E8C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DEB2076D
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PRdALIvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgH2TbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:31:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53485 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgH2TbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 15:31:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBC04704A3;
        Sat, 29 Aug 2020 15:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1hp7SbyioiMz0a3ZNsdymQ8GQsQ=; b=PRdALIvAQeSM9cYtYv4S
        ViFC1SrXyckXudln183hsTYasrVgkKYOgngyfVXBuFW1qpzOIrFcFZhDHchGGbX+
        dYNDVXQibcZkHRd2AKL7eSmHnW2WAVZRSeWMP5Br4EBYGTLnS8y0JxiiiKQmnyYV
        McEcyVMMy3I3WgMn5xqEo1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=spBr+U8tB121Pe9a11blv0BpiwvWLKD3ELVsT6oiW12Uwh
        PIKvacdTg8D/NFWofs9msAFM6HkHqHyPA1lEUVLkg2KjHhO1Cbejqvt59qP3piXt
        Q2YAozofc61Dn7yfTCGWxvJG+RkogVyEVBovE7yVR2PYD43oOLWXhAoVMF5g8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB5D9704A2;
        Sat, 29 Aug 2020 15:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20CFD704A1;
        Sat, 29 Aug 2020 15:31:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v6 06/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200828124617.60618-1-mirucam@gmail.com>
        <20200828124617.60618-7-mirucam@gmail.com>
Date:   Sat, 29 Aug 2020 12:31:17 -0700
Message-ID: <xmqq8sdxi70a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35E09E5A-EA2E-11EA-8444-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> diff --git a/bisect.c b/bisect.c
> index c6aba2b9f2..f0fca5c6f3 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -988,6 +988,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
>   * the bisection process finished successfully.
>   * In this case the calling function or command should not turn a
>   * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or a non zero exit code.
> + *
> + * Checking BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND
> + * in bisect_helper::bisect_next() and only transforming it to 0 at
> + * the end of bisect_helper::cmd_bisect__helper() helps bypassing
> + * all the code related to finding a commit to test.
> + *
>   * If no_checkout is non-zero, the bisection process does not
>   * checkout the trial commit but instead simply updates BISECT_HEAD.
>   */

Not a problem introduced by this step, but the above description on
no_checkout describes a parameter that no longer exists.  

The comments before a function is to guide the developers how to
call the function correctly, so it should have been removed, moved
to where no_checkout is used in the function, or moved to where
BISECT_HEAD ref gets created, as necessary, but by mistake be5fe200
(cmd_bisect__helper: defer parsing no-checkout flag, 2020-08-07),
forgot to do any of the three.


> +static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
> +{
> +	int no_checkout;
> +	enum bisect_error res;
> +
> +	bisect_autostart(terms);
> +	if (bisect_next_check(terms, terms->term_good))
> +		return BISECT_FAILED;
> +
> +	no_checkout = ref_exists("BISECT_HEAD");
> +
> +	/* Perform all bisection computation */
> +	res = bisect_next_all(the_repository, prefix);
> +
> +	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +		res = bisect_successful(terms);
> +		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
> +	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
> +		res = bisect_skipped_commits(terms);
> +		return res ? res : BISECT_ONLY_SKIPPED_LEFT;
> +	}
> +	return res;
> +}
> +

The no_checkout local variable is assigned but never used.  It is
understandable if a variable that used to be used becomes unused
when some part (i.e. the part that used to use the variable) of a
function is factored out, but it is rather unusual how a brand new
function has such an unused code and stay to be that way throughout
a topic.  Makes a reviewer suspect that there may be a code missing,
that has to use the variable to decide to do things differently, in
this function.  It seems to break -Werror builds.

Thanks.


