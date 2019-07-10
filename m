Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DABAF1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfGJH64 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 03:58:56 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:61676 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGJH64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 03:58:56 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 154A851089;
        Wed, 10 Jul 2019 09:58:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id zpW2gV112P7C; Wed, 10 Jul 2019 09:58:37 +0200 (CEST)
Date:   Wed, 10 Jul 2019 09:58:35 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
Message-ID: <20190710075835.GB65621@book.hvoigt.net>
References: <20190704080907.GA45656@book.hvoigt.net>
 <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
 <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
 <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 08, 2019 at 10:16:50PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The "--all" in rev-list family (including "git log") unconditionally
> > include HEAD.  The glitch here is that "--all" in rev-parse does
> > not.  And 4d5e1b1319 was an attempt to "fix" that, i.e. make "--all"
> > imply "HEAD".
> 
> And it becomes really tempting to get rid of that "let's tweak
> --all" hack and declare that "rev-parse --all" is simply buggy,
> proposing a simple "bugfix" that may look like this (not even
> compile tested, but you get the idea).

Thanks for this nice pointer.

Lets think about this a little more, because this would give us a proper
solution. There would be a need to be backwards compatible to not break
peoples scripts right? The documentation says --all "Show all refs found
in refs/" so IMO we need some extra option that changes the '--all'
behavior. How about '--all-include-head'. Then e.g.

    git rev-parse --all-include-head --all --not origin/master

would include the head ref like you proposed below?

What do you think? Or would you rather go the route of changing
rev-parse behavior?

Cheers Heiko

> 
>  builtin/rev-parse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index f8bbe6d47e..94f9a6efba 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -766,6 +766,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			}
>  			if (!strcmp(arg, "--all")) {
>  				for_each_ref(show_reference, NULL);
> +				head_ref(show_reference, NULL);
>  				clear_ref_exclusion(&ref_excludes);
>  				continue;
>  			}
