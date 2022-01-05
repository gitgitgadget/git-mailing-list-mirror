Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBAAC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiAEU6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:58:50 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:8397 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244298AbiAEU6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:58:31 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4JThfC4Zyfz5tl9;
        Wed,  5 Jan 2022 21:58:27 +0100 (CET)
Message-ID: <478ed4c7-467d-384d-b6d9-68956dc39c41@kdbg.org>
Date:   Wed, 5 Jan 2022 21:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 00/11] Factorization of messages with similar meaning
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
 <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.01.22 um 21:02 schrieb Jean-Noël Avila via GitGitGadget:
> This series is a meager attempt at rationalizing a small fraction of the
> internationalized messages. Sorry in advance for the dull task of reviewing
> these insipide patches.
> 
> Doing so has some positive effects:
> 
>  * non-translatable constant strings are kept out of the way for translators
>  * messages with identical meaning are built identically
>  * the total number of messages to translate is decreased.
> 
> Changes since V1:
> 
>  * took into account the comments, except for ref-filter.c where the
>    proposed refactoring is not obvious.
>  * added even more strings to the "cannot be used together" crowd.
> 
> Changes since V2:
> 
>  * fixed change of behaviour in tag.c
>  * reverted sam changes as per Johannes Sixt comments
> 
> Changes since V3:
> 
>  * apply Oxford comma where needed
>  * switch all options to " '%s' " style where i18n is applied.
> 
> Changes since V4:
> 
>  * Apply changes by René on tag.c
>  * cosmetic changes

This round looks good to me, with one caveat: I am not a translator, nor
do I use a translated version of Git. So, I haven't verified the claim
that the number translatable strings was reduced greatly, nor whether
there are any accidential duplicates due to typos. I infer the
correctness only by looking at the changes.

There's one small nit visible in the range-diff; not worth a reroll IMHO:

>   5:  a9d8a50d666 !  5:  ad58bc8d8a9 i18n: tag.c factorize i18n strings
>      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
>       -		die(_("--no-contains option is only allowed in list mode"));
>       -	if (filter.points_at.nr)
>       -		die(_("--points-at option is only allowed in list mode"));
>      +-	if (filter.reachable_from || filter.unreachable_from)
>      +-		die(_("--merged and --no-merged options are only allowed in list mode"));
>       +		only_in_list = "-n";
>       +	else if (filter.with_commit)
>       +		only_in_list = "--contains";
>      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
>       +		only_in_list = "--no-contains";
>       +	else if (filter.points_at.nr)
>       +		only_in_list = "--points-at";
>      ++	else if (filter.reachable_from)
>      ++		only_in_list = "--merged";
>      ++	else if  (filter.unreachable_from)

An extra blank after the 'if'.

>      ++		only_in_list = "--no-merged";
>       +	if (only_in_list)
>       +		die(_("the '%s' option is only allowed in list mode"), only_in_list);
>      - 	if (filter.reachable_from || filter.unreachable_from)
>      --		die(_("--merged and --no-merged options are only allowed in list mode"));
>      -+		die(_("'--merged' and '--no-merged' options are only allowed in list mode"));
>        	if (cmdmode == 'd') {
>        		ret = delete_tags(argv);
>        		goto cleanup;

-- Hannes
