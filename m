Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6176420248
	for <e@80x24.org>; Fri,  1 Mar 2019 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfCAXIX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 18:08:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:35148 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725934AbfCAXIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 18:08:23 -0500
Received: (qmail 28973 invoked by uid 109); 1 Mar 2019 23:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 23:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2471 invoked by uid 111); 1 Mar 2019 23:08:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 18:08:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 18:08:21 -0500
Date:   Fri, 1 Mar 2019 18:08:21 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190301230821.GA16294@sigill.intra.peff.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net>
 <20190301221551.GD31362@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301221551.GD31362@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 05:15:51PM -0500, Todd Zullinger wrote:

> Hmm.  The comments in list_cmds_by_config() made me wonder
> if not using a local repo config was intentional:
> 
>         /*
>          * There's no actual repository setup at this point (and even
>          * if there is, we don't really care; only global config
>          * matters). If we accidentally set up a repository, it's ok
>          * too since the caller (git --list-cmds=) should exit shortly
>          * anyway.
>          */

Well, let's see what Duy says. :)

I've never used completion.commands myself, but it seems reasonable that
somebody might want different completion in different repos (e.g., if
they never use "mergetool" in one repo, but do in another).

> Is the cost of setting up a repository something which might
> noticeably slow down interactive completion?  In my testing
> today I haven't felt it, but I have loads of memory on this
> system.

I'd doubt it. It is a few syscalls (and might have to walk up the
filesystem if you're not actually in a repository), but it's something
that basically every Git process does, and I don't think it's ever been
noticeable.

> I did apply your change and that allows the test to use
> test_config() rather than test_config_global().  The full
> test suite passes, so the change doesn't trigger any new
> issues we have covered by a test, at least.
> 
> If we wanted to respect local configs, how does this look?

Looks good, with two minor commit message nits:

> -- 8< --
> From: Jeff King <peff@peff.net>
> Subject: [PATCH] git: read local config in --list-cmds
> 
> Normally code that is checking config before we've decide to do

s/decide/&d/

> setup_git_directory() would use read_early_config(), which uses
> discover_git_directory() to tentatively see if we're in a repo,
> and if so to add it to the config sequence.
> 
> But list_cmds() uses the caching configset mechanism and
> (rightly) does not use read_early_config(), because it has no
> idea if it's being called early.

I'd say "mechanism _which_ rightly does not use read_early_config..." to
make it clear we're talking about configset, not list_cmds().

-Peff
