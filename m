Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13861FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbcHJWJ5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:09:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932392AbcHJWJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:09:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A15AF3511A;
	Wed, 10 Aug 2016 18:05:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tEExxg98IwfYK/s1VH2PB6bIO2k=; b=UocBHN
	La94/YlqBG+E9xOUOGo9K6JN3/xBDWO0K4MDH/gKztHkfAlzASWQCXvvfdHqkP4N
	rxbQ6asCZn++bKLVN7wZXF5ZZYVIrL9XOfvFOxxOQQAuyIGZL7qR7aHJCNHscjm6
	OVUhlVv2Ym+ykjfeZ0FzS6nNEIuaLPPCs6gng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IuluF5e2r7FQ3rybOeb+lS8WRuwQPeOj
	D8b0vsa9JJxyLhuuoyU6rgzByiDaUXXRZbW4g3YGUCPIe2LjWemCFuIJzUI5CUrG
	lSimbHJ5Cno2DsdlmSEvq6KfZiJXrUfnA87eKpAIQxsAUD1OGGV0C9oPpgWKCMUV
	oT2bz+D8QuQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9918435119;
	Wed, 10 Aug 2016 18:05:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19E0635118;
	Wed, 10 Aug 2016 18:05:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/2] diff: add SUBMODULE_DIFF format to display submodule diff
References: <20160810211710.23173-1-jacob.e.keller@intel.com>
	<20160810211710.23173-2-jacob.e.keller@intel.com>
Date:	Wed, 10 Aug 2016 15:05:23 -0700
In-Reply-To: <20160810211710.23173-2-jacob.e.keller@intel.com> (Jacob Keller's
	message of "Wed, 10 Aug 2016 14:17:10 -0700")
Message-ID: <xmqqziok2sbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A21984C-5F46-11E6-B97E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> @@ -2305,6 +2311,15 @@ static void builtin_diff(const char *name_a,
>  	struct strbuf header = STRBUF_INIT;
>  	const char *line_prefix = diff_line_prefix(o);
>  
> +	diff_set_mnemonic_prefix(o, "a/", "b/");
> +	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
> +		a_prefix = o->b_prefix;
> +		b_prefix = o->a_prefix;
> +	} else {
> +		a_prefix = o->a_prefix;
> +		b_prefix = o->b_prefix;
> +	}
> +

Hmph, is it safe to raise this when SUBMODULE_DIFF is not in effect?
Not objecting, just asking.

>  	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
> ...
> +	} else if (DIFF_OPT_TST(o, SUBMODULE_DIFF) &&

This makes clear that SUBMODULE_LOG and SUBMODULE_DIFF should not be
independent bits in the diff-opt flag word.  We used to run
something like "log --oneline --left-right A...B" and your new code
runs "diff A B", but the next month somebody else would want to do
"log -p --left-right A...B" or something else, and they are clearly
mutually exclusive.

> diff --git a/diff.h b/diff.h
> index 6a91a1139686..65df44b1fcba 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>  #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
>  #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
>  #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
> -/* (1 <<  9) unused */
> +#define DIFF_OPT_SUBMODULE_DIFF      (1 <<  9)

So I'd really prefer not to see this change; instead, we should move
in the direction where we _REMOVE_ DIFF_OPT_SUBMODULE_LOG from these,
and introduce an enum to hold "how would we show submodule changes"
in the diff_options structure.
