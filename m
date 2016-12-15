Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8281FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 19:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbcLOTIk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 14:08:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53498 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753393AbcLOTIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 14:08:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30AAC58A2D;
        Thu, 15 Dec 2016 14:08:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=1wUsqJI16t3R6GaDYQzHkgEi1as=; b=KSwpl8
        UWO8QPGfRjp7MIPD9mSKrC6kKNWgRP/iU7DpND8Snb+Eokel3WQ2suI0Z3dpjwjg
        9LdKbInuPMmqfD1FDO1ePv1kZiIWQTEO7kcXXdCYMRZH+ZpTOvOusgdfQK9wEIM7
        xcrSL6aIe7cEmvp791wUO/CkwwYFZvAiAxAcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rHDJ6XtljUQivTQpxHT9kb6RDZCAKw0I
        yhEk+rgIppQ8Pgn/qi53SZtT8TuEdz/g0UrFkVsFLzHqwh37kcjIwKsSXJv2+Z2G
        231kSJzqWyTgFuWLY+DP8nYgW1WLXVso9bLaqjhF2RGWFd2e/AZej++u6OnnPihF
        ZyN4PbbkrpE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 289FC58A2C;
        Thu, 15 Dec 2016 14:08:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9359A58A28;
        Thu, 15 Dec 2016 14:08:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 10/34] sequencer (rebase -i): allow continuing with staged changes
In-Reply-To: <9978c32139c522c08d5a8f685011829cc830bfc0.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:30:30 +0100
        (CET)")
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <9978c32139c522c08d5a8f685011829cc830bfc0.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Thu, 15 Dec 2016 11:08:34 -0800
Message-ID: <xmqq1sx9ui19.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0D6E7F2-C2F9-11E6-9A1F-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When an interactive rebase is interrupted, the user may stage changes
> before continuing, and we need to commit those changes in that case.
>
> Please note that the nested "if" added to the sequencer_continue() is
> not combined into a single "if" because it will be extended with an
> "else" clause in a later patch in this patch series.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 80469b6954..855d3ba503 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1829,6 +1829,42 @@ static int continue_single_pick(void)
>  	return run_command_v_opt(argv, RUN_GIT_CMD);
>  }
>  
> +static int commit_staged_changes(struct replay_opts *opts)
> +{
> +	int amend = 0;
> +
> +	if (has_unstaged_changes(1))
> +		return error(_("cannot rebase: You have unstaged changes."));

The scripted one from 'master' seems to say

	$path_to_the_file: needs update
	You must edit all merge conflicts and then
	mark them as resolved using git add

when editing an existing commit in this case.  The updated message
looks more sensible for the situation, but I wonder if the control
should even reach at this point.  

One bad thing about reviewing this series is that all the comments
are about codepaths that are not exercised, so they cannot be more
than "they look good".  A comment "If the caller does X, this will
be better than the original" (or this will regress, for that matter)
cannot be validated for its relevance because we won't know the what
the caller does in the endgame while reviewing these earlier steps.



