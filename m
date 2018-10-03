Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C6D1F454
	for <e@80x24.org>; Wed,  3 Oct 2018 02:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJCJCZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 05:02:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:39380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726510AbeJCJCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 05:02:25 -0400
Received: (qmail 28538 invoked by uid 109); 3 Oct 2018 02:16:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 02:16:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8703 invoked by uid 111); 3 Oct 2018 02:15:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 22:15:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 22:16:07 -0400
Date:   Tue, 2 Oct 2018 22:16:07 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/3] git.c: handle_alias: prepend alias info when
 first argument is -h
Message-ID: <20181003021607.GB20553@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-2-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001112107.28956-2-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 01:21:06PM +0200, Rasmus Villemoes wrote:

> Most git commands respond to -h anywhere in the command line, or at
> least as a first and lone argument, by printing the usage
> information. For aliases, we can provide a little more information that
> might be useful in interpreting/understanding the following output by
> prepending a line telling that the command is an alias, and for what.
> 
> When one invokes a simple alias, such as "cp = cherry-pick"
> with -h, this results in
> 
> $ git cp -h
> 'cp' is aliased to 'cherry-pick'
> usage: git cherry-pick [<options>] <commit-ish>...
> ...
> 
> When the alias consists of more than one word, this provides the
> additional benefit of informing the user which options are implicit in
> using the alias, e.g. with "cp = cherry-pick -n":
> 
> $ git cp -h
> 'cp' is aliased to 'cherry-pick -n'
> usage: git cherry-pick [<options>] <commit-ish>...
> ...
> 
> For shell commands, we cannot know how it responds to -h, but printing
> this line to stderr should not hurt, and can help in figuring out what
> is happening in a case like
> 
> $ git sc -h
> 'sc' is aliased to '!somecommand'
> somecommand: invalid option '-h'

Nicely explained.

> diff --git a/git.c b/git.c
> index a6f4b44af5..0211c2d4c0 100644
> --- a/git.c
> +++ b/git.c
> @@ -318,6 +318,9 @@ static int handle_alias(int *argcp, const char ***argv)
>  	alias_command = (*argv)[0];
>  	alias_string = alias_lookup(alias_command);
>  	if (alias_string) {
> +		if (*argcp > 1 && !strcmp((*argv)[1], "-h"))
> +			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
> +				   alias_command, alias_string);
>  		if (alias_string[0] == '!') {
>  			struct child_process child = CHILD_PROCESS_INIT;
>  			int nongit_ok;

And the implementation makes sense.

-Peff
