Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790A21F406
	for <e@80x24.org>; Wed, 17 Jan 2018 23:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeAQXw2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 18:52:28 -0500
Received: from imap.thunk.org ([74.207.234.97]:58860 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754589AbeAQXw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 18:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fTIFRzVqLoTHJug6ikuEfHYHMHiOMfNsEcViZu0UmD8=; b=Lh5pV6x5unnt/9N+bN4ClHYufp
        taCmIrIsLxhlImyiwIZLsTlxmoWXVKaok+XnOcNmzqsOv99WHoYotYqXFt8rTFFIAzv3aRyZFUiCX
        e+brSzoVASZHRdQNgpygfCxSNUw6KrMSad5C3P3Cz6he8E0BnZCnYd7SNKDL5eJ3oYJk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ebxVF-00052h-Uh; Wed, 17 Jan 2018 23:52:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DE603C012D3; Wed, 17 Jan 2018 18:52:20 -0500 (EST)
Date:   Wed, 17 Jan 2018 18:52:20 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180117235220.GD6948@thunk.org>
References: <20180117184828.31816-1-hch@lst.de>
 <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com>
 <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 02:07:22PM -0800, Linus Torvalds wrote:
> 
> Now re-do the test while another process writes to a totally unrelated
> a huge file (say, do a ISO file copy or something).
> 
> That was the thing that several filesystems get completely and
> horribly wrong. Generally _particularly_ the logging filesystems that
> don't even need the fsync, because they use a single log for
> everything (so fsync serializes all the writes, not just the writes to
> the one file it's fsync'ing).

Well, let's be fair; this is something *ext3* got wrong, and it was
the default file system back them.  All of the modern file systems now
do delayed allocation, which means that an fsync of one file doesn't
actually imply an fsync of another file.  Hence...

> The original git design was very much to write each object file
> without any syncing, because they don't matter since a new object file
> - by definition - isn't really reachable. Then sync before writing the
> index file or a new ref.

This isn't really safe any more.  Yes, there's a single log.  But
files which are subject to delayed allocation are in the page cache,
and just because you fsync the index file doesn't mean that the object
file is now written to disk.  It was true for ext3, but it's not true
for ext4, xfs, btrfs, etc.

The good news is that if you have another process downloading a huge
ISO image, the fsync of the index file won't force the ISO file to be
written out.  The bad news is that it won't force out the other git
object files, either.

Now, there is a potential downside of fsync'ing each object file, and
that is the cost of doing a CACHE FLUSH on a HDD is non-trivial, and
even on a SSD, it's not optimal to call CACHE FLUSH thousands of times
in a second.  So if you are creating thousands of tiny files, and you
fsync each one, each fsync(2) call is a serializing instruction, which
means it won't return until that one file is written to disk.  If you
are writing lots of small files, and you are using a HDD, you'll be
bottlenecked to around 30 files per second on a 5400 RPM HDD, and this
is true regardless of what file system you use, because the bottle
neck is the CACHE FLUSH operation, and how you organize the metadata
and how you do the block allocation, is largely lost in the noise
compared to the CACHE FLUSH command, which serializes everything.

There are solutions to this; you could simply not call fsync(2) a
thousand times, and instead write a pack file, and call fsync once on
the pack file.  That's probably the smartest approach.

You could also create a thousand threads, and call fsync(2) on those
thousand threads at roughly the same time.  Or you could use a
bleeding edge kernel with the latest AIO patch, and use the newly
added IOCB_CMD_FSYNC support.

But I'd simply recommend writing a pack and fsync'ing the pack,
instead of trying to write a gazillion object files.  (git-repack -A,
I'm looking at you....)

					- Ted
