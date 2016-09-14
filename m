Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B770A1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 22:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764962AbcINW6q (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 18:58:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:43433 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762171AbcINW6p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 18:58:45 -0400
Received: (qmail 19235 invoked by uid 109); 14 Sep 2016 22:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 22:58:45 +0000
Received: (qmail 4822 invoked by uid 111); 14 Sep 2016 22:58:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 18:58:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 15:58:30 -0700
Date:   Wed, 14 Sep 2016 15:58:30 -0700
From:   Jeff King <peff@peff.net>
To:     Daniel Hahler <genml+git-2016@thequod.de>
Cc:     git@vger.kernel.org
Subject: Re: Left with empty files after "git stash pop" when system hung
Message-ID: <20160914225828.hlsc2ae4vfghmqv7@sigill.intra.peff.net>
References: <5b203a8e-faa8-9f6e-8cdd-1024194e74a3@thequod.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b203a8e-faa8-9f6e-8cdd-1024194e74a3@thequod.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 11:39:56PM +0200, Daniel Hahler wrote:

> I have used "git stash --include-untracked", checked out another branch,
> went back, and "git stash pop"ed the changes.
> Then my system crashed/hung (music that was playing was repeated in a
> loop).  I have waited for some minutes, and then turned it off.
> 
> Afterwards, the repository in question was in a state where all files
> contained in the stash were empty.
> "git status" looked good on first sight: all the untracked and modified
> files were listed there; but they were empty.
> 
>   % git fsck --lost-found
>   error: object file .git/objects/04/1e659b5dbfd3f0be351a782b54743692875aec is empty
>   error: object file .git/objects/04/1e659b5dbfd3f0be351a782b54743692875aec is empty
>   fatal: loose object 041e659b5dbfd3f0be351a782b54743692875aec (stored in .git/objects/04/1e659b5dbfd3f0be351a782b54743692875aec) is corrupt
>   % find .git/objects -size 0|wc -l
>   12
>
> [...]
> The filesystem in question is ext4, and I am using Arch Linux.

Is your filesystem mounted with data=writeback? Git should never write
an empty object file; it writes the content to a temporary file, and
then hardlinks it into place. If your filesystem does not order data and
metadata writes (i.e., the hardlink may get journaled and picked
up, even though the data did not hit the disk), then you can end up with
empty files. If you set core.fsyncobjectfiles in your config file, then
Git will fsync each object write (at the cost of some performance).

> I would have assumed that the "stash pop" operation would be "atomic",
> i.e. it should not remove the stash object before other objects have
> been written successfully.

Stash does not remove any objects at all; it should only be updating the
stash reflog to delete the entry (which also happens via write to a
tempfile and rename, though I don't think we ever fsync it, even with
core.fsyncobjectfiles).

The empty object you found is probably the result of a write too close
to the crash. In general I wouldn't expect "stash pop" to write, but I
suspect it may in order to populate the index.

> I have removed all empty files in .git/objects and tried to find the
> previous stash with `gitk --all $( git fsck | awk '{print $3}' )` then,
> but it appears to have disappeared.

fsck won't mention the object as dangling if it's reachable from a
reflog. Did you try "git stash list" (or just "git log -g refs/stash")?

-Peff
