Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6CC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79970207A5
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgLCQpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:45:16 -0500
Received: from mail.javad.com ([54.86.164.124]:58430 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLCQpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:45:16 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 9C5C63E8C8;
        Thu,  3 Dec 2020 16:44:33 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkria-0003xF-2V; Thu, 03 Dec 2020 19:44:32 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 05/27] revision: move diff merges functions to its
 own diff-merges.c
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-6-sorganov@gmail.com>
        <xmqqa6uvk8mv.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 19:44:32 +0300
In-Reply-To: <xmqqa6uvk8mv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 16:58:48 -0800")
Message-ID: <87k0tyhma7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> diff --git a/diff-merges.h b/diff-merges.h
>> new file mode 100644
>> index 000000000000..e0cca3d935d3
>> --- /dev/null
>> +++ b/diff-merges.h
>> @@ -0,0 +1,12 @@
>> +#ifndef DIFF_MERGES_H
>> +#define DIFF_MERGES_H
>
> Describe what "diff-merges" module is about in a comment here.

Sure, will do.

> This matters because in 07/27 the log message complains that the
> first-parent traversal option is checked in the module but it is out
> of place.  Without defining what the "module" is about, the readers
> would have a hard time agreeing with the justification.

Yes, agreed.

>
> My guess is that this is about deciding how a merge commit is shown
> in 'log -p' and 'show' output, comparing the commit with its
> parent(s) in patch output.  With that explained, it may make sense
> for 07/27 to complain that --first-parent that is primarily a
> traversal option does also affect how a merge is shown (I do not
> necessarily agree with the complaint, though)

The is no complaint that --first-parent affects how merge is shown, at
least I didn't ever mean to complain about it.

From me there is a complaint that there is no way (before this series)
to make merge to be shown in the same manner without affecting
traversal, but that's not the problem of --first-parent user-visible
behavior.

I believe that in general, it'd be best that if an option makes more
than 1 thing, it does them by simply implying other options, so that
user is able to fine-tune each aspect of behavior independently.

For example, the design of --first-parent could have been that it simply
implies --follow-first-parent and --diff-merges=first-parent, each of
which do exactly one thing: the first defines how graph traversal is
performed, and the second defines how merge commits are shown.

OTOH, the resulting design of --first-parent after this series is an
example of another approach, also acceptable, where an option performs
its 1 primary action directly, and the rest -- by implying other
options. This design also covers all the possibilities, provided each
implicit option could be overridden.

Thanks,
Sergey Organov
