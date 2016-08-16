Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FF01F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcHPQeX (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:34:23 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:39634 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222AbcHPQeU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2016 12:34:20 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 00A84232F4;
	Tue, 16 Aug 2016 17:33:42 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id E780833CA;
	Tue, 16 Aug 2016 17:33:42 +0100 (BST)
X-Quarantine-ID: <RgAAeSzrYpMs>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RgAAeSzrYpMs; Tue, 16 Aug 2016 17:33:40 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.10])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 7FF20334B;
	Tue, 16 Aug 2016 17:33:34 +0100 (BST)
Date:	Tue, 16 Aug 2016 17:33:34 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Ralf Thielow <ralf.thielow@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
	me@jnm2.com, philipoakley@iee.org
Subject: Re: [PATCH v3] help: make option --help open man pages only for Git
 commands
Message-ID: <20160816163334.xkkuffjwzc6mw663@john.keeping.me.uk>
References: <20160815053628.3793-1-ralf.thielow@gmail.com>
 <20160816162030.27754-1-ralf.thielow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160816162030.27754-1-ralf.thielow@gmail.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 06:20:30PM +0200, Ralf Thielow wrote:
> If option --help is passed to a Git command, we try to open
> the man page of that command.  However, we do it even for commands
> we don't know.  Make sure it is a Git command by using "help_unknown_cmd"
> which is even able to assume a command if the user made a typo.
> 
> This breaks "git <concept> --help" while "git help <concept>" still works.
> 
> As "<cmd> --help" will internally be turned into "help <cmd>",
> introduce the hidden option "--swapped" in order to know which
> version has been called.
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Thanks, all, for the help!
> 
> Changes since v2:
> - don't check for common guides as the list is very incomplete
> - only check for git commands when called via <cmd> --help (introduce
>   option --swapped for that), as suggested by Junio
> - change test case to check for --help being passed to a concept
>   used as a git command
> 
>  builtin/help.c  | 30 +++++++++++++++++++++++-------
>  git.c           | 15 ++++++++++++++-
>  t/t0012-help.sh | 15 +++++++++++++++
>  3 files changed, 52 insertions(+), 8 deletions(-)
>  create mode 100755 t/t0012-help.sh
> 
> diff --git a/builtin/help.c b/builtin/help.c
> index 8848013..76f07c7 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -37,7 +37,9 @@ static int show_all = 0;
>  static int show_guides = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
> +static int swapped = 0;
>  static struct option builtin_help_options[] = {
> +	OPT_BOOL('s', "swapped", &swapped, "mark as being called by <cmd> --help"),

OPT_HIDDEN_BOOL maybe?

>  	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>  	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
>  	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
