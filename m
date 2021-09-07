Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE7C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED35761103
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbhIGUeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:34:07 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:7812 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243733AbhIGUeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:34:05 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4H3xm56WK3z5tlF;
        Tue,  7 Sep 2021 22:32:53 +0200 (CEST)
Subject: Re: diff-index --cc no longer permitted, gitk is now broken
 (slightly)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
 <87h7f4tf0b.fsf@osv.gnss.ru>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <efcba5ef-d79d-ebc0-3bbb-f86eee08db05@kdbg.org>
Date:   Tue, 7 Sep 2021 22:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87h7f4tf0b.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.09.21 um 18:52 schrieb Sergey Organov:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
>> to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
>> breaks gitk: it invokes
>>
>>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>>
>> to show the staged changes (when the line "Local changes checked in to
>> index but not committed" is selected).
>>
>> The man page of git diff-index does not mention --cc as an option. I
>> haven't fully grokked the meaning of --cc, so I cannot tell whether this
>> absence has any significance (is deliberate or an omission).
>>
>> Is gitk wrong to add --cc unconditionally? Should it do so only when
>> there are conflicts? Or not at all?
>>
> 
> Here is a patch that fixes diff-index to accept --cc again:
> 
> Subject: [PATCH] diff-index: restore -c/--cc options handling
> 
> This fixes git:19b2517f95a0a908a8ada7417cf0717299e7e1aa
> "diff-merges: move specific diff-index "-m" handling to diff-index"
> 
> That commit disabled handling of all diff for merges options in
> diff-index on an assumption that they are unused. However, it later
> appeared that -c and --cc, even though undocumented and not being
> covered by tests, happen to have had particular effect on diff-index
> output.
> 
> Restore original -c/--cc options handling by diff-index.

Thank you! I can confirm that gitk works again as expected with this patch.

-- Hannes

> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/diff-index.c |  6 +++---
>  diff-merges.c        | 14 ++++----------
>  diff-merges.h        |  2 +-
>  3 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index cf09559e422d..5fd23ab5b6c5 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -29,10 +29,10 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>  	prefix = precompose_argv_prefix(argc, argv, prefix);
>  
>  	/*
> -	 * We need no diff for merges options, and we need to avoid conflict
> -	 * with our own meaning of "-m".
> +	 * We need (some of) diff for merges options (e.g., --cc), and we need
> +	 * to avoid conflict with our own meaning of "-m".
>  	 */
> -	diff_merges_suppress_options_parsing();
> +	diff_merges_suppress_m_parsing();
>  
>  	argc = setup_revisions(argc, argv, &rev, NULL);
>  	for (i = 1; i < argc; i++) {
> diff --git a/diff-merges.c b/diff-merges.c
> index d897fd8a2933..5060ccd890bd 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -6,7 +6,7 @@ typedef void (*diff_merges_setup_func_t)(struct rev_info *);
>  static void set_separate(struct rev_info *revs);
>  
>  static diff_merges_setup_func_t set_to_default = set_separate;
> -static int suppress_parsing;
> +static int suppress_m_parsing;
>  
>  static void suppress(struct rev_info *revs)
>  {
> @@ -91,9 +91,9 @@ int diff_merges_config(const char *value)
>  	return 0;
>  }
>  
> -void diff_merges_suppress_options_parsing(void)
> +void diff_merges_suppress_m_parsing(void)
>  {
> -	suppress_parsing = 1;
> +	suppress_m_parsing = 1;
>  }
>  
>  int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
> @@ -102,10 +102,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  	const char *optarg;
>  	const char *arg = argv[0];
>  
> -	if (suppress_parsing)
> -		return 0;
> -
> -	if (!strcmp(arg, "-m")) {
> +	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
>  		set_to_default(revs);
>  	} else if (!strcmp(arg, "-c")) {
>  		set_combined(revs);
> @@ -153,9 +150,6 @@ void diff_merges_set_dense_combined_if_unset(struct rev_info *revs)
>  
>  void diff_merges_setup_revs(struct rev_info *revs)
>  {
> -	if (suppress_parsing)
> -		return;
> -
>  	if (revs->combine_merges == 0)
>  		revs->dense_combined_merges = 0;
>  	if (revs->separate_merges == 0)
> diff --git a/diff-merges.h b/diff-merges.h
> index b5d57f6563e3..19639689bb05 100644
> --- a/diff-merges.h
> +++ b/diff-merges.h
> @@ -11,7 +11,7 @@ struct rev_info;
>  
>  int diff_merges_config(const char *value);
>  
> -void diff_merges_suppress_options_parsing(void);
> +void diff_merges_suppress_m_parsing(void);
>  
>  int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
>  
> 
