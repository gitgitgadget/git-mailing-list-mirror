Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023CEC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiGFOip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiGFOim (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 10:38:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00FC639D
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 07:38:41 -0700 (PDT)
Received: (qmail 3627 invoked by uid 109); 6 Jul 2022 14:38:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 14:38:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24350 invoked by uid 111); 6 Jul 2022 14:38:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 10:38:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 10:38:37 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
Message-ID: <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705092514.hsm7cou5bqvajvgq@carbon>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 12:25:14PM +0300, Konstantin Khomoutov wrote:

> > because SHA sum is hard to memorize, so I have to use copy and past,
> > which is too boring. So, I wonder if there is a way to let "git log"
> > display commits like following:
> > 
> >   HEAD   <one line commit message>
> >   HEAD~1 <one line commit message>
> > HEAD~2 <one line commit message>
> > HEAD~3 <one line commit message>
> >   ...
> > 
> > With these "HEAD~*", I can easily directly type them and no need to
> > move my fingers out of keyboard.
> 
> You can script this. Provided you have a POSIX-compatible shell (such as
> Bash), the encantation would read something like
> 
>  $ git log --oneline | { n=0; while read line; do printf '%d\t%s\n' $n "$line"; done; }

That will just number the commits linearly as they are printed. If your
history has any branches or merges, eventually it will get out of sync.

You can use "name-rev" to annotate commits with names that respect the
history. It only matches full oids, so try:

  git log --oneline --no-abbrev | git name-rev --stdin

If you want shorter hex oids, you can work around it with "--name-only"
and a custom format:

  git log --format='%h (%H) %s' | git name-rev --stdin --name-only

Note that the names will be based on the nearest branches/tags. You can
use "--refs" to limit it, but sadly there doesn't seem to be a way to
specify just HEAD. That might be a fun and easy feature to add.

And finally, if you really like this, you can configure git-log's pager
to always pipe through name-rev, like this:

  [pager]
        log = "git name-rev --stdin | less"

Then the usual "medium" output from git-log will have the annotations on
the "commit" lines. Arguably git-log ought to be able to do this
internally, but I don't think anybody has ever implemented it (and I
wouldn't be surprised if it's a little challenging, just because you'd
have two traversals going on at once in the same program).

Note that I don't use any of those myself. Long ago I taught my terminal
to do keyboard selection of object ids for cut-and-paste. I think there
are probably solutions for tmux and other programs you can find online.
I shared mine for urxvt a while ago:

  https://lore.kernel.org/git/20170120192539.7jts6xqzx46unn7y@sigill.intra.peff.net/

though if anybody is interested in it, let me know because I can share a
new version with some bug fixes and improvements since then.

-Peff
