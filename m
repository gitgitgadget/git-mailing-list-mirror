Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D68C193FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197CC207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgLCQET (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:04:19 -0500
Received: from mail.javad.com ([54.86.164.124]:53304 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgLCQES (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:18 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id AE07F3E92A;
        Thu,  3 Dec 2020 16:03:35 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkr4w-0003wj-EV; Thu, 03 Dec 2020 19:03:34 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 04/27] revision: provide implementation for diff
 merges tweaks
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-5-sorganov@gmail.com>
        <xmqqim9jk8zf.fsf@gitster.c.googlers.com>
        <xmqqblfbihl9.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 19:03:34 +0300
In-Reply-To: <xmqqblfbihl9.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 21:28:18 -0800")
Message-ID: <87r1o6ho6h.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Is your naming convention that "rev_diff_" is the common prefix?
>> What's the significance of "_diff" part?  After all, these are about
>> tweaking the setting in the rev_info structure, so how about
>>
>> 	revinfo_show_merges_in_dense_combined_by_default(rev);
>> 	revinfo_show_merges_by_default_with_first_parent(rev);
>>
>> perhaps, using just "revinfo_" as the common prefix?
>
> Actually, I'd like to take these suggestions back.  I do not think
> these names that describe "what the function does" are good names at
> all.  If we can name them after what they are for, we'd be much
> better off.
>
> Given that one is part of the tweak for "show" and the other part of
> "log", I presume that one is to set-up default for showing a merge
> in the context of the "show" command, and the other is the same for
> the "log" (actually "log -p") command.  So perhaps
>
> 	diff_merges_set_default_for_show(revs);
> 	diff_merges_set_default_for_log(revs);
>
> are good names that tells us where they should be used and what for.

Sorry, here I disagree, see below.

> The former is to set up the default parameters to handle a merge
> commit in the context of the "show" command, and the latter is the
> same for the "log" command.  Naming them that way, we can then tweak
> what should happen for "show" by default without touching the caller
> if we wanted to (perhaps, "when doing first-parent traversal, really
> pretend that all the commits we see are single-parent, so show the
> change relative to its first parent by default without even
> requiring -m" might be something the latter can learn later).

I have multiple objections to this:

1. diff-merges, as a module or unit, is designed to provide needed
services to callers, not to dictate where exactly these services are
to be used.

2. diff-merges, as a module, should not care nor know if "git log" or
"git show" (or whatever top-level command), exists at all, so the
suggested names are not a good idea to have in the module.

3. The decision how exactly merge commits are to be shown for given user
command should better be expressed in that command, not hidden in the
implementation of diff-merges module.

4. Giving functions names by their place of call won't allow to sensibly
reuse them in other places, if needed, without renaming.

Overall, I believe the functions in the diff-merges unit must be called
after what they are doing to the format of the diff output for merges,
not after the places they are (currently) called at.

The functions you suggest, on the other hand, are fine and may have
their place, but they are at higher level of abstraction and should not
be part of the low-level diff-merges module.

Thanks,
-- Sergey Organov
