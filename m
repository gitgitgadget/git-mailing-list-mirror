Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3AC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 08:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5B62072C
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 08:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgCUIzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 04:55:06 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:60890 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgCUIzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 04:55:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 48kvbq0NbPz5tlD;
        Sat, 21 Mar 2020 09:55:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B6B222817;
        Sat, 21 Mar 2020 09:55:02 +0100 (CET)
Subject: Re: [PATCH] test-lib: allow short options to be stacked
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2a54d866-c40e-da5e-4c0c-6bfcb56eb8f7@kdbg.org>
Date:   Sat, 21 Mar 2020 09:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.03.20 um 04:07 schrieb Matheus Tavares:
> +
> +# Parse options while taking care to leave $@ intact, so we will still
> +# have all the original command line options when executing the test
> +# script again for '--tee' and '--verbose-log' below.
> +store_arg_to=
> +prev_opt=
> +for opt
> +do
> +	if test -n "$store_arg_to"
> +	then
> +		eval $store_arg_to=\$opt
> +		store_arg_to=
> +		prev_opt=
> +		continue
> +	fi
> +
> +	case "$opt" in
> +	--*)

Can we please have a case arm for -? here:

	--* | -?)

so that we do not pay the price of many sub-processes when options are
_not_ stacked?

> +		parse_option "$opt" ;;
> +	-?*)
> +		# stacked short options must be fed separately to parse_option
> +		for c in $(echo "${opt#-}" | sed 's/./& /g')
> +		do
> +			parse_option "-$c"
> +		done
> +		;;
> +	*)
> +		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
> +	esac
>  
>  	prev_opt=$opt
>  done
> 

-- Hannes
