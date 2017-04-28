Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6867C1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164165AbdD1Ia3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:30:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:41575 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968264AbdD1Ia0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:30:26 -0400
Received: (qmail 3662 invoked by uid 109); 28 Apr 2017 08:30:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 08:30:17 +0000
Received: (qmail 17474 invoked by uid 111); 28 Apr 2017 08:30:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 04:30:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 04:30:15 -0400
Date:   Fri, 28 Apr 2017 04:30:15 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Submodule/contents conflict
Message-ID: <20170428083015.m2vowojjcdgfkcak@sigill.intra.peff.net>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
 <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
 <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
 <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
 <20170425032242.wlmqrkgkeg3ytfle@sigill.intra.peff.net>
 <B12D69ADE0C84BBBB9A35C50F1C74A01@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B12D69ADE0C84BBBB9A35C50F1C74A01@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 11:52:24PM +0100, Philip Oakley wrote:

> > But note that none of that should ever affect _what_ gets checked out at
> > a file or content level. It may only affect the timestamps on the
> > resulting files. And I think those timestamps are not something Git
> > makes any promises about.
> 
> It's not actually clear to users what Git promises in cases like this which
> confuses user expectations - the make file issue does appear to come up
> quite often.

Yeah, I wouldn't mind a documentation update there. I have no idea where
to put it that people would find it, though.

> > So if Git can elide a write and keep a timestamp up to date, that is a
> > great optimization and we should do that. But from an outside viewer's
> > perspective, we guarantee nothing. We might choose to rewrite a
> > stat-dirty file (updating its timestamp) rather than read its contents
> > to see if it might have the same content that we're about to write. And
> > the file may look stat dirty only because of the racy-git file/index
> > timestamp problem, even if it wasn't actually modified.
> 
> I'm not sure how in this case we would get the stat-dirty state? We should
> be able to determine that the file has existed, as originally checked out,
> for some while (i.e. past the racy FS time) and is unmodified, so that as
> long as the original checkout OID and the required new OID are the same we
> should be able to avoid the file overwrite (or merge).
> 
> It would require that the now time be used as a stand-in for the new OID
> file's stat time (given the object store doesn't store date stamps for
> files) to check for the racy-git situation. These negative information
> scenarios can be tricky.

I don't think the "now" time during the read is relevant for racy git.
The problem is the timestamp of the index versus the timestamp of the
file itself. So updating the index in the same second the file was
touched (like a test script often does):

  echo foo >bar && git add bar

will have a racily-dirty entry, and a subsequent index refresh will
re-read the file. You can verify this with strace:

  $ echo foo >bar && git add bar
  $ strace git update-index --refresh 2>&1 | grep '"bar"'
  lstat("bar", {st_mode=S_IFREG|0644, st_size=4, ...}) = 0
  open("bar", O_RDONLY|O_CLOEXEC)         = 4

  [now update the index so it has a later timestamp]
  $ sleep 1
  $ echo foo >unrelated && git add unrelated
  $ strace  git update-index --refresh 2>&1 | grep '"bar"'
  lstat("bar", {st_mode=S_IFREG|0644, st_size=4, ...}) = 0

Interestingly, I would have thought that the first update-index call
would "de-racify" the entry by rewriting the index. But we don't
actually write, presumably because we eventually realize that there are
no entries to update. But it might actually be worth doing the write,
because it avoids further file-content reads later on (and most
workflows tend to do a lot of reads; every git-status is going to rehash
the file until the next index update).

-Peff
