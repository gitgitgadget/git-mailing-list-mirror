Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46364C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E088206DC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgIQO5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:57:25 -0400
Received: from verein.lst.de ([213.95.11.211]:56629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgIQO5C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:57:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69B996736F; Thu, 17 Sep 2020 16:56:53 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:56:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeff King <peff@peff.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917145653.GA30972@lst.de>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-2-avarab@gmail.com> <20200917140912.GA27653@lst.de> <20200917145523.GB3076467@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917145523.GB3076467@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 10:55:23AM -0400, Jeff King wrote:
> On Thu, Sep 17, 2020 at 04:09:12PM +0200, Christoph Hellwig wrote:
> 
> > On Thu, Sep 17, 2020 at 01:28:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > > Change the behavior of core.fsyncObjectFiles to also sync the
> > > directory entry. I don't have a case where this broke, just going by
> > > paranoia and the fsync(2) manual page's guarantees about its behavior.
> > 
> > It is not just paranoia, but indeed what is required from the standards
> > POV.  At least for many Linux file systems your second fsync will be
> > very cheap (basically a NULL syscall) as the log has alredy been forced
> > all the way by the first one, but you can't rely on that.
> 
> Is it sufficient to fsync() just the surrounding directory? I.e., if I
> do:
> 
>   mkdir("a");
>   mkdir("a/b");
>   open("a/b/c", O_WRONLY);
> 
> is it enough to fsync() a descriptor pointing to "a/b", or should I
> also do "a"?

You need to fsync both to be fully compliant, even if just fsyncing b
will work for most but not all file systems.  The good news is that
for those common file systems the extra fsync of a is almost free.
