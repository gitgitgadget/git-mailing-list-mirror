Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFF7E776E5
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 00:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjJCAwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 20:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJCAwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 20:52:55 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B0B0
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 17:52:51 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 720DB1F55F;
        Tue,  3 Oct 2023 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1696294371;
        bh=HfHXaOywkFFKMyI45y9JoFkpgp/2/tnJgeXDmQZP3g4=;
        h=Date:From:To:Cc:Subject:From;
        b=5MmwwfnaVBKJVW+tuz26jYa1oPX3FXTyx0V0bFRwT5bsvB7prKHpysqYrlhFD0QV3
         /DAWD28P8zUtIOvDtBKa93OPbmdp81TKxrzVK6VUKQVARLCccLqi+UDvzuC7+Bi7wn
         FlFItsw0vGdjo883Pno6gPgKb8nYITYyU+/t4n3w=
Date:   Tue, 3 Oct 2023 00:52:51 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: batch-command wishlist [was: [TOPIC 02/12] Libification Goals and
 Progress]
Message-ID: <20231003005251.M353509@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:
> * (Jonathan Tan) back to process isolation: is the short lifetime of the process
>   important?
> * (Taylor Blau) seems like an impossible goal to be able to do multi-command
>   executions in a single process, the code is just not designed for it.

-- Split out from https://lore.kernel.org/git/ZRrfN2lbg14IOLiK@nand.local/
Thanks for posting in an accessible format for non-JS/video users.

> * (Junio) is anybody using the `git cat-file --batch-command` mode that switches
>   between batch and batch-check.

I've started using --batch-command, but still have to test
backwards compatibility with git 2.35 to ensure users of older
git aren't left out.  I still try to support git 1.8.x, even...

But it would be nice if --batch-command grew more functionality:

* ability to add/remove alternates
* ability to specify a preferred alternate for a lookup[1]
* detect unlinked packs/removed repos

Not sure if cat-file is the place for it, but a persistent
process to deal with:

* `git config -f FILENAME ...' (especially --get-urlmatch --type=FOO)
* approxidate parsing for other tools[2]

Would also be nice...

Maybe I'll find the time and patience to implement this... *shrug*
Building C projects is pretty slow for me, even with -O0.

[1] I'm potentially dealing with 50-100k alternates, after all;
    and potentially config files in the 300-500k line range...

> * (Patrick Steinhardt) they are longer lived, but only "middle" long-lived.
>   GitLab limits the maximum runtime, on the order of ~minutes, at which point
>   they are reaped.
> * (Taylor Blau) lots of issues besides memory leaks that would become an issue
> * (Jeff Hostetler) would be nice to keep memory-hungry components pinned across
>   multiple command-equivalents.
> * (Taylor Blau): same issue as reading configuration.

sidenote: __attribute__((cleanup)) found in gcc + clang + tinycc
has greatly improved my life.  Perhaps only supporting Free software
compilers and cross-compiling for everything else is in order :P

The only gotcha I've noticed with ((cleanup)) is it doesn't fire
on longjmp, but that's not a problem for git.

I've also been abusing more Perl5 over the years as a code
generator and better CPP to make dealing with tedious tasks
more acceptable.


[2] I did recently license the code of a standalone C++ executable
    as GPL-2+ so I can copy approxidate parsing from git and
    perhaps figure out enough C++ to use Xapian query parser
    bindings instead of the hacky `git rev-parse --since=' thing
    I do.
