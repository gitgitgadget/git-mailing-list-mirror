Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BFEC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67C9206F9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLCPfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:35:50 -0500
Received: from mail.javad.com ([54.86.164.124]:43396 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgLCPfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:35:50 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 9D1413E8C8;
        Thu,  3 Dec 2020 15:35:07 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkqdN-0003wJ-Qs; Thu, 03 Dec 2020 18:35:05 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 03/27] revision: factor out initialization of
 diff-merge related settings
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-4-sorganov@gmail.com>
        <xmqqmtyvk9jv.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 18:35:05 +0300
In-Reply-To: <xmqqmtyvk9jv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 16:39:00 -0800")
Message-ID: <874kl2j42e.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Move initialization code related to diffing merges into new
>> init_diff_merge_revs() function.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  revision.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 739295bb9ff4..bc568fb79778 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1805,6 +1805,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
>>  	return 1;
>>  }
>>  
>> +static void init_diff_merge_revs(struct rev_info *revs);
>> +
>
> It is not wrong per-se, but I do not see why we do not define the
> function here, not just forward-declare it like so.

I wanted to keep merge-diff functions definitions at one place to
simplify future refactoring by moving all of them into separate file, to
avoid scatter-gathering definitions from multiple places in the
original file.

>
>>  void repo_init_revisions(struct repository *r,
>>  			 struct rev_info *revs,
>>  			 const char *prefix)
>> @@ -1813,7 +1815,7 @@ void repo_init_revisions(struct repository *r,
>>  
>>  	revs->repo = r;
>>  	revs->abbrev = DEFAULT_ABBREV;
>> -	revs->ignore_merges = -1;
>> +	init_diff_merge_revs(revs);
>>  	revs->simplify_history = 1;
>>  	revs->pruning.repo = r;
>>  	revs->pruning.flags.recursive = 1;
>> @@ -2153,6 +2155,10 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>>  	add_grep(revs, pattern, GREP_PATTERN_BODY);
>>  }
>>  
>> +static void init_diff_merge_revs(struct rev_info *revs) {
>> +	revs->ignore_merges = -1;
>> +}
>
> Style.  A brace that begins a function body begins its own line.

Oops! There are a few cases in the git sources where this style is used,
and somehow my eye catch it and I did entire series in this style.

Now the question is: what do I do about it? Do I need to rework the
entire series in the correct style, or would it be enough to fix the
style as a separate commit at the end of the series?

> In any case, I'd move this new definition before its sole caller; that
> way we do not even need an extra forward-declaration.

I'd do it too, except in this particular case, first, it actually makes
some sense to have function definition here, see above, and second, it'd
disappear along with declaration in the next commit anyway. I'm OK to
change this though if you still find this issue essential.

Thanks,
-- Sergey Organov
