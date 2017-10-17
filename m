Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C64202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755776AbdJQB1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:27:21 -0400
Received: from ikke.info ([178.21.113.177]:37164 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754361AbdJQB1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 21:27:20 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id DA922440392; Tue, 17 Oct 2017 03:27:18 +0200 (CEST)
Date:   Tue, 17 Oct 2017 03:27:18 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171017012718.GC19335@alpha.vpn.ikke.info>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 07:45:46PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> [..]
> 
> diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
> index 1e5f9835f0..4e62852089 100644
> --- a/builtin/check-ref-format.c
> +++ b/builtin/check-ref-format.c
> @@ -38,12 +38,22 @@ static char *collapse_slashes(const char *refname)
>  
>  static int check_ref_format_branch(const char *arg)
>  {
> +	int nongit, malformed;
>  	struct strbuf sb = STRBUF_INIT;
> +	const char *name = arg;
>  
> -	setup_git_directory();
> -	if (strbuf_check_branch_ref(&sb, arg))
> +	setup_git_directory_gently(&nongit);
> +
> +	if (!nongit)
> +		malformed = (strbuf_check_branch_ref(&sb, arg) ||
> +			     !skip_prefix(sb.buf, "refs/heads/", &name));
> +	else
> +		malformed = check_branch_ref_format(arg);
> +

Would it make sense to swap the logic and get rid of the double
negative (!nongit)?

> +	if (malformed)
>  		die("'%s' is not a valid branch name", arg);
> -	printf("%s\n", sb.buf + 11);
> +	printf("%s\n", name);
> +	strbuf_release(&sb);
>  	return 0;
>  }
>  
