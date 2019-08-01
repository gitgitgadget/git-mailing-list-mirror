Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C04E1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 00:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfHAAta (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 20:49:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:57890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725942AbfHAAt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 20:49:29 -0400
Received: (qmail 22397 invoked by uid 109); 1 Aug 2019 00:49:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Aug 2019 00:49:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23570 invoked by uid 111); 1 Aug 2019 00:51:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 20:51:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 20:49:28 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] config: work around bug with includeif:onbranch
 and early config
Message-ID: <20190801004928.GA6351@sigill.intra.peff.net>
References: <pull.300.git.gitgitgadget@gmail.com>
 <pull.300.v2.git.gitgitgadget@gmail.com>
 <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
 <20190731220204.GA1933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
 <20190731231257.GB1933@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731231257.GB1933@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 07:12:57PM -0400, Jeff King wrote:

> Hrm. But common-main calls initialize_the_repository(), which points it
> at &the_repo. And I can't find any other assignments. So how does it
> become NULL? And is every caller of have_git_dir() at risk of
> segfaulting?
> 
> Ah, I see. I think it is that trace2 reads the configuration very early.
> I think we ought to do this:
> 
> diff --git a/common-main.c b/common-main.c
> index 582a7b1886..89fd415e55 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -39,14 +39,14 @@ int main(int argc, const char **argv)
>  
>  	git_resolve_executable_dir(argv[0]);
>  
> +	initialize_the_repository();
> +
>  	trace2_initialize();
>  	trace2_cmd_start(argv);
>  	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
>  
>  	git_setup_gettext();
>  
> -	initialize_the_repository();
> -
>  	attr_start();
>  
>  	result = cmd_main(argc, argv);

By the way, I wondered why trace2's existing config reading did not
cause us to segfault because of this. It is because it invented the
"very early config" function which always ignores some config sources
(working around this problem, but also making it weirdly unlike most
other config).

-Peff
