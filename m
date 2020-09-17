Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE8C35263
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9AD206DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 19:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgIQOpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:45:38 -0400
Received: from verein.lst.de ([213.95.11.211]:56536 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgIQOY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:24:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0339868BEB; Thu, 17 Sep 2020 16:12:58 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:12:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
Message-ID: <20200917141257.GB27653@lst.de>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917112830.26606-3-avarab@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  core.fsyncObjectFiles::
> +	This boolean will enable 'fsync()' when writing loose object
> +	files. Both the file itself and its containng directory will
> +	be fsynced.
> ++
> +When git writes data any required object writes will precede the
> +corresponding reference update(s). For example, a
> +linkgit:git-receive-pack[1] accepting a push might write a pack or
> +loose objects (depending on settings such as `transfer.unpackLimit`).
> ++
> +Therefore on a journaled file system which ensures that data is
> +flushed to disk in chronological order an fsync shouldn't be
> +needed. The loose objects might be lost with a crash, but so will the
> +ref update that would have referenced them. Git's own state in such a
> +crash will remain consistent.

While this is much better than what we had before I'm not sure it is
all that useful.  The only file system I know of that actually had the
above behavior was ext3, and the fact that it always wrote back that
way made it a complete performance desaster.  So even mentioning this
here will probably create a lot more confusion than actually clearing
things up.

> ++
> +This option exists because that assumption doesn't hold on filesystems
> +where the data ordering is not preserved, such as on ext3 and ext4
> +with "data=writeback". On such a filesystem the `rename()` that drops
> +the new reference in place might be preserved, but the contents or
> +directory entry for the loose object(s) might not have been synced to
> +disk.

As well as just about any other file system.  Which is another argument
on why it needs to be on by default.  Every time I install a new
development system (aka one that often crashes) and forget to enable
the option I keep corrupting my git repos.  And that is with at least
btrfs, ext4 and xfs as it is pretty much by design.

> +However, that's highly filesystem-dependent, on some filesystems
> +simply calling fsync() might force an unrelated bulk background write
> +to be serialized to disk. Such edge cases are the reason this option
> +is off by default. That default setting might change in future
> +versions.

Again the only "some file system" that was widely used that did this
was ext3.  And ext3 has long been removed from the Linux kernel..
