Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887CC34372
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0298224715
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfLMNY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:24:29 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:44595 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMNY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:24:29 -0500
Received: from [84.131.47.212] (helo=[192.168.2.6])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ifkcH-0000vj-Jo; Fri, 13 Dec 2019 14:04:21 +0100
Subject: Re: [PATCH v3] grep: support the --pathspec-from-file option
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191213041254.13202-1-emilyshaffer@google.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <e4e81dba-d861-0e7c-c06c-4041e903f8ea@syntevo.com>
Date:   Fri, 13 Dec 2019 14:04:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213041254.13202-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, the patch looks solid to me, just a few code style rants :)

On 13.12.2019 5:12, Emily Shaffer wrote:

> +	if (patterns_from_file && pathspec_from_file &&
> +	    !strcmp(pathspec_from_file, "-") &&
> +	    !strcmp(patterns_from_file, "-"))
> +		die(_("cannot specify both patterns and pathspec via stdin"));
> +
> +	if (patterns_from_file)
> +		read_pattern_file(&opt, patterns_from_file);
> +
> +

That looks a lot more solid now, thanks!

> @@ -549,6 +549,10 @@ test_expect_success 'grep -f, non-existent file' '
>   	test_must_fail git grep -f patterns
>   '

Could also benefit from testing for specific error here.

> +test_expect_success 'setup pathspecs-file tests' '
> +cat >excluded-file <<EOF &&
> +bar
> +EOF
> +cat >pathspec-file <<EOF &&
> +foo
> +bar
> +baz
> +EOF
> +cat >unrelated-file <<EOF &&
> +xyz
> +EOF
> +git add excluded-file pathspec-file unrelated-file
> +'

Please use <<-EOF and tabulate the code properly. I suggest that you 
have a look at `t/t7107-reset-pathspec-file.sh`, last test.

> +
> +cat >pathspecs <<EOF
> +pathspec-file
> +unrelated-file
> +EOF
> +
> +cat >expected <<EOF
> +pathspec-file:bar
> +EOF

The general approach nowadays is to write `expect` file in every test. 
Note that the standard name is `expect`, so please remove `ed` from your 
name. I think that this is also reasonable for `pathspecs` file, it's 
only used in two places. Again, please refer to 
`t/t7107-reset-pathspec-file.sh`.
