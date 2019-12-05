Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED5C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4550C20675
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfLEL6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:58:25 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:8365 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEL6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 06:58:24 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1icpm0-0007bi-Tz; Thu, 05 Dec 2019 12:58:21 +0100
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20191204203911.237056-1-emilyshaffer@google.com>
X-Otrs-Customeruser: Emily Shaffer <emilyshaffer@google.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <6af006eb-6d67-4eb5-c4f5-1677d6cbd120@syntevo.com>
Date:   Thu, 5 Dec 2019 12:58:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204203911.237056-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm excited to see someone else join my effort, thanks for continuing my 
effort! Also, less work for me :)

On 04.12.2019 21:39, Emily Shaffer wrote:

>   static int file_callback(const struct option *opt, const char *arg, int unset)
>   {
>   	struct grep_opt *grep_opt = opt->value;
> -	int from_stdin;
>   	FILE *patterns;
>   	int lno = 0;
>   	struct strbuf sb = STRBUF_INIT;
>   
>   	BUG_ON_OPT_NEG(unset);
>   
> -	from_stdin = !strcmp(arg, "-");
> -	patterns = from_stdin ? stdin : fopen(arg, "r");
> +	patterns_from_stdin = !strcmp(arg, "-");
> +
> +	if (patterns_from_stdin && pathspec_from_stdin)

To my understanding, this check will not work as expected. 
`file_callback` will be called at the moment of parsing args. 
`pathspec_from_stdin` is only initialized later.

Maybe it would be better to convert `file_callback` into a regular 
function and call it after the options were parsed, similar to how 
`pathspec_from_file` is parsed later?

This will also allow to move global variables into local scope and 
resolve other small issues raised by other reviewers.

> +test_expect_success 'grep with two stdin inputs fails' '
> +	test_must_fail git grep --pathspec-from-file - --patterns-from-file - <pathspecs
> +'
> +

It is usually a good idea to test for specific error, like this:

   test_must_fail git grep --pathspec-from-file - --patterns-from-file - 
<pathspecs 2>err &&
   test_i18ngrep "cannot specify both patterns and pathspec via stdin" 
err &&
