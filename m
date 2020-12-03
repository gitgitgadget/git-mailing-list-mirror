Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E88C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970E2206F9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgLCRyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:54:18 -0500
Received: from mail.javad.com ([54.86.164.124]:38730 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgLCRyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 12:54:18 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id F0BF43E96D;
        Thu,  3 Dec 2020 17:53:35 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kksnO-0003yB-Fq; Thu, 03 Dec 2020 20:53:34 +0300
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
Date:   Thu, 03 Dec 2020 20:53:34 +0300
In-Reply-To: <xmqqim9jk8zf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 16:51:16 -0800")
Message-ID: <87blfahj35.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> -	if (rev->ignore_merges < 0) {
>> -		/* There was no "-m" variant on the command line */
>> -		rev->ignore_merges = 0;
>> -		if (!rev->first_parent_only && !rev->combine_merges) {
>> -			/* No "--first-parent", "-c", or "--cc" */
>> -			rev->combine_merges = 1;
>> -			rev->dense_combined_merges = 1;
>> -		}
>> -	}
>> +	rev_diff_merges_default_to_dense_combined(rev);
>
> The name makes sense.  "Unless otherwise specified, we do not ignore
> merges.  Further, when we are not doing first-parent traversal,
> default to dense combined merges, unless told otherwise" is what the
> code says, and the name of the helper captures it well.
>
>> @@ -731,8 +723,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>>  	if (!rev->diffopt.output_format && rev->combine_merges)
>>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
>>  
>> -	if (rev->first_parent_only && rev->ignore_merges < 0)
>> -		rev->ignore_merges = 0;
>> +	rev_diff_merges_first_parent_defaults_to_enable(rev);
>
> This on the other hand is not so great a name.  "When we are doing
> first-parent traversal, do not exclude merge commits from being
> shown" is what log_setup_revisions_tweak() does here.  "default to
> enable" is not clear at all what we are enabling.

As this name goes away later, let's relax this one, and focus on the
final name?

>
> Is your naming convention that "rev_diff_" is the common prefix?
> What's the significance of "_diff" part?  After all, these are about
> tweaking the setting in the rev_info structure, so how about
>
> 	revinfo_show_merges_in_dense_combined_by_default(rev);
> 	revinfo_show_merges_by_default_with_first_parent(rev);
>
> perhaps, using just "revinfo_" as the common prefix?

The prefixes here were selected just to have some to aid in refactoring,
without much thought. As all the prefixes change pretty soon in the
series anyway, can we let these be?

Thanks,
-- Sergey Organov
