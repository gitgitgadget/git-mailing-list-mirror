Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA301F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 02:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfJBCjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 22:39:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55820 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfJBCjH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 22:39:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35078813A7;
        Tue,  1 Oct 2019 22:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fEpxGotISM77k72trfzTX87gnpc=; b=x9CXca
        jJ/oTtzww3ZMYl96ppeEwKm1fMCndCQhkTGUAs88ra64CZQml4TS+QZTKotQoOLF
        MwwaFQl6tDDTpQe2H5oobHkqEvfWt1Yo6ULmp/lRLmawPqmWJCiU/GD5BrBxMOfZ
        Autrsy74J19EnmGT+Gm354KZFeNwf7EiK8LYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VU/OMrctTQQMDmy7MVY97qenqq/KQf/y
        cBCvOSI6duh50RX6WJieCo4YjEuF20Pk2GO1nAYtX49CQcC2qVLoBhoxZYT74ha5
        NLXkAF02thDeKFiTGGIV2g8swPgjK4w+o4UeFjs7kO7i+Qp7kuCfrKKB/W211uyW
        pEWrspd3s8o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E95F813A6;
        Tue,  1 Oct 2019 22:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 587BA813A4;
        Tue,  1 Oct 2019 22:38:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from complete_action()
References: <20190925201315.19722-1-alban.gruin@gmail.com>
        <20190925201315.19722-6-alban.gruin@gmail.com>
Date:   Wed, 02 Oct 2019 11:38:57 +0900
In-Reply-To: <20190925201315.19722-6-alban.gruin@gmail.com> (Alban Gruin's
        message of "Wed, 25 Sep 2019 22:13:15 +0200")
Message-ID: <xmqq5zl7hnwe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C999869C-E4BD-11E9-8AB5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Currently, complete_action() calls sequencer_continue() to do the
> rebase.  Even though the former already has the todo list, the latter
> loads it from the disk and parses it.  Calling directly pick_commits()
> from complete_action() avoids this unnecessary round trip.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

All the earlier steps in this series are necessary because the
inconsistencies caused by not doing things the code updated by the
earlier steps do (e.g. leaving number of commits recorded in
total_nr and done_nr stale) were masked by re-reading the info from
the on-disk file.  And this step exposes these inconsistencies
because the extra reading from the file no longer happens.

That is my reading of the series---did I get it right?

I wonder if that can be stated clearly in the log message of the
earlier steps.

For example, by reading 1/5 or 2/5 alone, it would be natural for
readers to wonder why the original code that did not update done_nr
correctly terminated after going through the todo list (you would
expect that when done reaches total you are finished, so if one of
these variables are not maintained correctly, your termination
condition may be borked), and then by knowing that the current code
more-or-less works correctly by not terminating too early or barfing
to say it ran out of things to do prematurely, the next thing
readers would wonder is if these patches introduce new bugs by
incrementing these variables twice (iow, "does the author of the
patch missed other places where these variables are correctly
updated?")

1/5 for example talks about the variable mostly being used by
prompts, which may be useful to reduce worries by readers about
correctness (iow, "well, if it is only showing wrong number in the
prompts and does not affect correctness otherwise, perhaps that was
why the current code that is buggy did not behave incorrectly").
But I suspect that it is not why these changes in the earlier steps
are acceptable or are right things to do.  So, perhaps replace the
"these are used only in prompts and the numbers being wrong does not
affect correctness" comments from them with:

    By forgetting to update the variable, the original code made it
    not reflect the reality, but this flaw was masked by the code
    calling (sometimes unnecessarily) read_todo_list() again to
    update the variable to its correct value before the next action
    happens.  At the end of this series, the unnecessary call will
    be removed and the inconsistency addressed by this patch would
    start to matter.

or something like that (assuming that the answer to the first
question I asked in this message is "yes", that is), or a more
concise version of it?

Thanks.
