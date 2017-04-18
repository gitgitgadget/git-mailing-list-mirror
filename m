Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8E91FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754379AbdDRDxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:53:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:35065 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbdDRDxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:53:47 -0400
Received: (qmail 9357 invoked by uid 109); 18 Apr 2017 03:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 03:53:46 +0000
Received: (qmail 8437 invoked by uid 111); 18 Apr 2017 03:54:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 23:54:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Apr 2017 23:53:44 -0400
Date:   Mon, 17 Apr 2017 23:53:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 3/3] config: correct file reading order in
 read_early_config()
Message-ID: <20170418035344.feu27cwogvdbdwyj@sigill.intra.peff.net>
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
 <20170417101002.18272-1-pclouds@gmail.com>
 <20170417101002.18272-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170417101002.18272-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 05:10:02PM +0700, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 8e3ed6a76c..696d0a52fd 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -84,6 +84,10 @@ int cmd_main(int argc, const char **argv)
>  	struct config_set cs;
>  
>  	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
> +		const char *cmdline_config = getenv("CMDL_CFG");
> +
> +		if (cmdline_config)
> +			git_config_push_parameter(cmdline_config);

I think you can do without this hunk by just setting:

  GIT_CONFIG_PARAMETERS="'foo.bar=from-cmdline'"

(note the single-quotes which must be there). See how t1308 does it.

> +test_expect_success 'read config file in right order' '
> +	echo "[test]source = home" >>.gitconfig &&
> +	git init foo &&
> +	(
> +		cd foo &&
> +		echo "[test]source = repo" >>.git/config &&
> +		CMDL_CFG=test.source=cmdline test-config \
> +			read_early_config test.source >actual &&
> +		cat >expected <<-\EOF &&
> +		home
> +		repo
> +		cmdline
> +		EOF
> +		test_cmp expected actual
> +	)
> +'

This looks good (modulo the CMDL_CFG above).

If we wanted to trigger it in a real-world test, we'd have to use pager
config (since it's the only thing that uses early-config; alias lookup
probably should do, but that's for another time). But I think this
synthetic test is fine; it makes the output easy to verify.

-Peff
