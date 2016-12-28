Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C326320441
	for <e@80x24.org>; Wed, 28 Dec 2016 17:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbcL1RVM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 12:21:12 -0500
Received: from imap.thunk.org ([74.207.234.97]:51292 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750976AbcL1RVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 12:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Hpek/Hgb+4Vqtj1ZvgPpGhNeFpKYbNiUtV6kEJzSDGY=;
        b=AoeQCMSN+BwwUK6GgR8LZBFOt0eH3jU3XZgToe3tj2jPxmGDaZoNaeMpaBZT5hsvY64fR7Bka2Gr2v8xNwj5TCDgAYHwBFnzJh8Bgv9We3wOf7Fe1flNf9zOG3vGNadkh9fID49WFnH4wugrnyQmD3a4N3hSesw1jwKrWI/wWQ4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1cMGjB-00053y-TD; Wed, 28 Dec 2016 16:05:21 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1B40AC00B0A; Wed, 28 Dec 2016 11:05:21 -0500 (EST)
Date:   Wed, 28 Dec 2016 11:05:21 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFH] gpg --import entropy while running tests
Message-ID: <20161228160520.dsybuqljzkzsik2d@thunk.org>
References: <20161228072303.4wbhkwf37fvgpi7h@sigill.intra.peff.net>
 <20161228080230.wygcmdmwvifcthvl@sigill.intra.peff.net>
 <20161228083930.5li6cb6yplusc26m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161228083930.5li6cb6yplusc26m@sigill.intra.peff.net>
User-Agent: NeoMutt/20161126 (1.7.1)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 03:39:30AM -0500, Jeff King wrote:
> >   https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=commit;h=4473db1ef24031ff4e26c9a9de95dbe898ed2b97
> > 
> > So this does seem like a gpg bug.
> 
> I've submitted a bug report to gpg:
> 
>   https://bugs.gnupg.org/gnupg/issue2897
> 
> so we'll see what they say.

Yeah, they are definitely doing something very.... hard to explain.

Pid 8348 is the gpg-agent process which the main gpg program (pid
8344) connected to.  It starts trying to get randomness in response to
a KEYWRAP command:

8348  10:58:57.882909 access("/dev/random", R_OK) = 0
8348  10:58:57.883205 access("/dev/urandom", R_OK) = 0
8348  10:58:57.883472 open("/dev/urandom", O_RDONLY) = 9
8348  10:58:57.883729 fcntl(9, F_GETFD) = 0
8348  10:58:57.883914 fcntl(9, F_SETFD, FD_CLOEXEC) = 0

It opens /dev/urandom, but then never uses fd 9 ever again.  Instead,
it uses getrandom, but in a pretty silly fashion, with lots of sleeps
in between, and not between each progress report, either:

8348  10:58:57.884129 write(8, "S PROGRESS need_entropy X 30 120", 32 <unfinished ...>
8344  10:58:57.884338 <... read resumed> "S PROGRESS need_entropy X 30 120", 1002) = 32
8348  10:58:57.884424 <... write resumed> ) = 32
8344  10:58:57.884488 read(5,  <unfinished ...>
8348  10:58:57.884550 write(8, "\n", 1 <unfinished ...>
8344  10:58:57.884715 <... read resumed> "\n", 970) = 1
8348  10:58:57.884800 <... write resumed> ) = 1
8344  10:58:57.884883 read(5,  <unfinished ...>
8348  10:58:57.884951 nanosleep({0, 100000000}, NULL) = 0
8348  10:58:57.985363 select(10, [9], NULL, NULL, {0, 100000}) = 1 (in [9], left {0, 99994})
8348  10:58:57.985593 getrandom("&\275\354^\256\320\3w\21:R]`eJ\t\t\350\245\202>\255\237\324\324\340\24^c\323\210\376"..., 90, 0) = 90
8348  10:58:57.985751 write(8, "S PROGRESS need_entropy X 120 12"..., 33) = 33
8344  10:58:57.985885 <... read resumed> "S PROGRESS need_entropy X 120 12"..., 1002) = 33
8348  10:58:57.985934 write(8, "\n", 1 <unfinished ...>
8344  10:58:57.985982 read(5,  <unfinished ...>
8348  10:58:57.986015 <... write resumed> ) = 1
8344  10:58:57.986048 <... read resumed> "\n", 969) = 1
8348  10:58:57.986090 nanosleep({0, 100000000},  <unfinished ...>
8344  10:58:57.986142 read(5,  <unfinished ...>
8348  10:58:58.086253 <... nanosleep resumed> NULL) = 0
8348  10:58:58.086370 write(8, "S PROGRESS need_entropy X 30 120", 32) = 32
8344  10:58:58.086502 <... read resumed> "S PROGRESS need_entropy X 30 120", 1002) = 32
8348  10:58:58.086541 write(8, "\n", 1 <unfinished ...>
8344  10:58:58.086579 read(5,  <unfinished ...>
8348  10:58:58.086604 <... write resumed> ) = 1
8344  10:58:58.086630 <... read resumed> "\n", 970) = 1
8348  10:58:58.086661 nanosleep({0, 100000000},  <unfinished ...>
8344  10:58:58.086703 read(5,  <unfinished ...>
8348  10:58:58.186815 <... nanosleep resumed> NULL) = 0
8348  10:58:58.186894 select(10, [9], NULL, NULL, {0, 100000}) = 1 (in [9], left {0, 99995})
8348  10:58:58.187038 getrandom("\365\221\374m\360\235\27\330\264\223\365\363<6\302\324F\5\354Q|,\366\253\337u\226\265\345\250CA"..., 90, 0) = 90

The worst part of this is that the commit description claims this is a
workaround for libgcrypt using /dev/random, but it's not using
/dev/random --- it's using getrandom, and it pointlessly opened
/dev/urandom first (having never opened /dev/random).

This looks like a classic case of Lotus Notes / Websphere disease ---
to many d*mned layers of abstraction....

						- Ted
