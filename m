Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879CB1F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeIBLi7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 07:38:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:36546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725834AbeIBLi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 07:38:59 -0400
Received: (qmail 11981 invoked by uid 109); 2 Sep 2018 07:24:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 07:24:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16645 invoked by uid 111); 2 Sep 2018 07:24:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 03:24:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 03:24:09 -0400
Date:   Sun, 2 Sep 2018 03:24:09 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
Message-ID: <20180902072408.GA18787@sigill.intra.peff.net>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180902071204.GA2868@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 09:12:04AM +0200, Duy Nguyen wrote:

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 0d9828e29e..779c5e2cb5 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -359,13 +359,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
> >  
> >  		discard_cache();
> >  		read_cache_from(get_lock_file_path(&index_lock));
> > -		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
> > -			if (reopen_lock_file(&index_lock) < 0)
> > -				die(_("unable to write index file"));
> > -			if (write_locked_index(&the_index, &index_lock, 0))
> > -				die(_("unable to update temporary index"));
> > -		} else
> > -			warning(_("Failed to update main cache tree"));
> >
> 
> Narrowing down to this does help. This patch seems to fix it to me. I
> guess we have some leftover from the interactive add that should not
> be there after we have written the new index.
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2be7bdb331..60f30b3780 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -432,6 +432,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
>  			if (reopen_lock_file(&index_lock) < 0)
>  				die(_("unable to write index file"));
> +			ftruncate(index_lock.tempfile->fd, 0);
>  			if (write_locked_index(&the_index, &index_lock, 0))
>  				die(_("unable to update temporary index"));
>  		} else

Doh, of course. I even thought about this issue and dug all the way into
reopen_lock_file(), but for some reason temporarily forgot that O_WRONLY
does not imply O_TRUNC.

Arguably this should be the default for reopen_lockfile(), as getting a
write pointer into an existing file is not ever going to be useful for
the way Git uses lockfiles. Opening with O_APPEND could conceivably be
useful, but it's pretty unlikely (and certainly not helpful here, and
this is the only caller). Alternatively, the function should just take
open(2) flags.

At any rate, I think this perfectly explains the behavior we're seeing.

-Peff
