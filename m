Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5DEC4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA25206D8
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 15:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgLCPRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:17:30 -0500
Received: from mail.javad.com ([54.86.164.124]:37656 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgLCPR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 10:17:28 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8DC613E8C8;
        Thu,  3 Dec 2020 15:16:47 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkqLe-0003vw-9e; Thu, 03 Dec 2020 18:16:46 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 01/27] revision: factor out parsing of diff-merge
 related options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-2-sorganov@gmail.com>
        <xmqqv9djk9tv.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 18:16:46 +0300
In-Reply-To: <xmqqv9djk9tv.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 16:33:00 -0800")
Message-ID: <87a6uuj4wx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Move all the parsing code related to diffing merges into new
>> parse_diff_merge_opts() function.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  revision.c | 66 ++++++++++++++++++++++++++++++++----------------------
>>  1 file changed, 39 insertions(+), 27 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index aa6221204081..a09f4872acd7 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2153,6 +2153,44 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
>>  	add_grep(revs, pattern, GREP_PATTERN_BODY);
>>  }
>>  
>> +static int parse_diff_merge_opts(struct rev_info *revs, const char **argv) {
>> +	int argcount;
>> +	const char *optarg;
>> +	const char *arg = argv[0];
>> +
>> +	if (!strcmp(arg, "-m")) {
>> +		/*
>> +		 * To "diff-index", "-m" means "match missing", and to the "log"
>> +		 * family of commands, it means "show full diff for merges". Set
>> +		 * both fields appropriately.
>> +		 */
>> +		revs->ignore_merges = 0;
>> +		revs->match_missing = 1;
>> +	} else if (!strcmp(arg, "-c")) {
>> +		revs->diff = 1;
>> +		revs->dense_combined_merges = 0;
>> +		revs->combine_merges = 1;
>> +	} else if (!strcmp(arg, "--cc")) {
>> +		revs->diff = 1;
>> +		revs->dense_combined_merges = 1;
>> +		revs->combine_merges = 1;
>> +	} else if (!strcmp(arg, "--no-diff-merges")) {
>> +		revs->ignore_merges = 1;
>> +	} else if (!strcmp(arg, "--combined-all-paths")) {
>> +		revs->diff = 1;
>> +		revs->combined_all_paths = 1;
>> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>
> The reordering of if/else if/ cascade from the original, which
> serves no apparent purpose, makes reviewing a tad harder than
> necessary, but the conversion at this point seems wrong.

Sorry for the reordering, I didn't notice it when I cleared up the
series.

>
> The original allowed parse_long_opt() to potentially return 2
> (i.e. "diff-merges" and "off" appear as separate tokens on the
> command line), but the return value stored in argcount here is
> discarded, without affecting the return value from this function,
> which is fed back to the original in handle_revision_opt() below.

Nice catch!

>
>> +		if (!strcmp(optarg, "off")) {
>> +			revs->ignore_merges = 1;
>> +		} else {
>> +			die(_("unknown value for --diff-merges: %s"), optarg);
>> +		}
>
> To correct the above bug, it probably is sufficient to add
>
> 		return argcount;
>
> here.

Right, but not enough. "argcount" should also be set to 1 at the
beginning of the function, to avoid returning uninitialized value here.

Fixed for the next series.

Thanks,
-- Sergey Organov
