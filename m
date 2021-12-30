Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B853EC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbhL3Wgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:36:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56813 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbhL3Wgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:36:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5049E180E80;
        Thu, 30 Dec 2021 17:36:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=iDXIbjFoVj2+1yVPiOAPZB2BsuHsf4//QeYe40kpZ2Y=; b=wmpn
        W55FUssAjmnPPqoKMqNj+tg30ndswTxh0pSI7BaHWJi0Mgvkt+4YnPZ9fodKzVeL
        ifeboHENLM0imFZhx1lnCIHEC5QtsJcnmoAUUj9mp+EyTIKatcaZZ0SkEZE+7UBv
        aonfQlq+k26P7+svF3wAFieiR36wxgjelYB7hQM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42B9F180E7F;
        Thu, 30 Dec 2021 17:36:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6927180E7E;
        Thu, 30 Dec 2021 17:36:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] name-rev: deprecate --stdin in favor of
 --annotate-text
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
        <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
        <e8063284b4d0d410d1ee8337c60f5ce3b48efb11.1640759021.git.gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 14:36:47 -0800
Message-ID: <xmqqsfu9oh34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9D3241E-69C0-11EC-8371-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Introduce a --annotate-text that is functionally equivalent of --stdin.
> --stdin does not behave as --stdin in other subcommands, such as
> pack-objects whereby it takes one argument per line. Since --stdin can
> be a confusing and misleading name, rename it to --annotate-text.
>
> This change adds a warning to --stdin warning that it will be removed in
> the future.

The above (including the title) uses --annotate-TEXT; the
documentation and the code seems to use --annotate-STDIN.

>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>  Documentation/git-name-rev.txt | 29 ++++++++++++++++++++++++++++-
>  builtin/name-rev.c             | 19 ++++++++++++++-----
>  2 files changed, 42 insertions(+), 6 deletions(-)

We probably would want to fix existing tests that use --stdin for
its originally intended purpose to use its new spelling instead, and
a single new test to ensure that use of --stdin gives a warning as
expected.

> @@ -613,8 +622,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  	for_each_ref(name_ref, &data);
>  	name_tips();
>  
> -	if (transform_stdin) {
> -		char buffer[2048];
> +	if (annotate_stdin) {
> +		struct strbuf sb = STRBUF_INIT;
>  
>  		while (!feof(stdin)) {
>  			char *p = fgets(buffer, sizeof(buffer), stdin);

This block probably would not compile well.
