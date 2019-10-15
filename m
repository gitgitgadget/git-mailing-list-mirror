Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712EC1F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 01:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfJOBux (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 21:50:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37442 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfJOBux (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 21:50:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 16BE61F4C0;
        Tue, 15 Oct 2019 01:50:53 +0000 (UTC)
Date:   Tue, 15 Oct 2019 01:50:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ds/sparse-cone, was Re: What's cooking in git.git (Oct 2019,
 #03; Fri, 11)
Message-ID: <20191015015052.GA19636@dcvr>
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 11 Oct 2019, Junio C Hamano wrote:
> > * ds/sparse-cone (2019-10-08) 17 commits
> >  - sparse-checkout: cone mode should not interact with .gitignore
> >  - sparse-checkout: write using lockfile
> >  - sparse-checkout: update working directory in-process
> >  - sparse-checkout: sanitize for nested folders
> >  - read-tree: show progress by default
> >  - unpack-trees: add progress to clear_ce_flags()
> >  - unpack-trees: hash less in cone mode
> >  - sparse-checkout: init and set in cone mode
> >  - sparse-checkout: use hashmaps for cone patterns
> >  - sparse-checkout: add 'cone' mode
> >  - trace2: add region in clear_ce_flags
> >  - sparse-checkout: create 'disable' subcommand
> >  - sparse-checkout: add '--stdin' option to set subcommand
> >  - sparse-checkout: 'set' subcommand
> >  - clone: add --sparse mode
> >  - sparse-checkout: create 'init' subcommand
> >  - sparse-checkout: create builtin with 'list' subcommand
> >
> >  Management of sparsely checked-out working tree has gained a
> >  dedicated "sparse-checkout" command.
> >
> >  Seems not to play well with the hashmap updates.
> 
> Hrm. I had sent out links to the three fixups needed to make the build
> green:
> 
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1910081055210.46@tvgsbejvaqbjf.bet/
> 
> In particular, the patches to squash were:
> 
> https://github.com/git-for-windows/git/commit/f74259754971b427a14e6290681e18950824b99d
> https://github.com/git-for-windows/git/commit/124c8bc08e974e76ca7d956dc07eb288e71d639e
> https://github.com/git-for-windows/git/commit/45948433d1b48ff513fbd37f134c0f1491c78192

> diff --git a/dir.c b/dir.c
> index 0135f9e2180..9efcdc9aacd 100644
> --- a/dir.c
> +++ b/dir.c

<snip>
> @@ -706,8 +710,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
> 
>  clear_hashmaps:
>  	warning(_("disabling cone pattern matching"));
> -	hashmap_free(&pl->parent_hashmap, 1);
> -	hashmap_free(&pl->recursive_hashmap, 1);
> +	hashmap_free(&pl->parent_hashmap);
> +	hashmap_free(&pl->recursive_hashmap);

I just took a brief look, but that appears to leak memory.

"hashmap_free(var, 1)" should be replaced with
"hashmap_free_entries(var, struct foo, member)"

Only "hashmap_free(var, 0)" can become "hashmap_free(var)"
