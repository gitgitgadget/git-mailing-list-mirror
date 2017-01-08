Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4785820756
	for <e@80x24.org>; Sun,  8 Jan 2017 05:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934330AbdAHF0Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 00:26:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:36590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbdAHF0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 00:26:23 -0500
Received: (qmail 3125 invoked by uid 109); 8 Jan 2017 05:26:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Jan 2017 05:26:22 +0000
Received: (qmail 29078 invoked by uid 111); 8 Jan 2017 05:27:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Jan 2017 00:27:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jan 2017 00:26:20 -0500
Date:   Sun, 8 Jan 2017 00:26:20 -0500
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
Subject: Re: "git fsck" not detecting garbage at the end of blob object
 files...
Message-ID: <20170108052619.4ucjamsqad4g5add@sigill.intra.peff.net>
References: <CAEBDL5Uc39JagdmXUxfxh1TPSK3H5wxoTfjK-pfLRYjciBnHpA@mail.gmail.com>
 <1483825623.31837.9.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483825623.31837.9.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 07, 2017 at 10:47:03PM +0100, Dennis Kaarsemaker wrote:

> On Sat, 2017-01-07 at 07:50 -0500, John Szakmeister wrote:
> > I was perusing StackOverflow this morning and ran across this
> > question: http://stackoverflow.com/questions/41521143/git-fsck-full-only-checking-directories/
> > 
> > It was a simple question about why "checking objects" was not
> > appearing, but in it was another issue.  The user purposefully
> > corrupted a blob object file to see if `git fsck` would catch it by
> > tacking extra data on at the end.  `git fsck` happily said everything
> > was okay, but when I played with things locally I found out that `git
> > gc` does not like that extra garbage.  I'm not sure what the trade-off
> > needs to be here, but my expectation is that if `git fsck` says
> > everything is okay, then all operations using that object (file)
> > should work too.
> > 
> > Is that unreasonable?  What would be the impact of fixing this issue?
> 
> If you do this with a commit object or tree object, fsck does complain.
> I think it's sensible to do so for blob objects as well.

The existing extra-garbage check is in unpack_sha1_rest(), which is
called as part of read_sha1_file(). And that's what we hit for commits
and trees. However, we check the sha1 of blobs using the streaming
interface (in case they're large). I think you'd want to put a similar
check into read_istream_loose(). But note if you are grepping for it, it
is hidden behind a macro; look for read_method_decl(loose).

I'm actually not sure if this should be downgrade to a warning. It's
true that it's a form of corruption, but it doesn't actually prohibit us
from getting the data we need to complete the operation. Arguably fsck
should be more picky, but it is just relying on the same parse_object()
code path that the rest of git uses.

I doubt anybody cares too much either way, though. It's not like this is
a common thing.

I did notice another interesting case when looking at this. Fsck ends up
in fsck_loose(), which has the sha1 and path of the loose object. It
passes the sha1 to fsck_sha1(), and ignores the path entirely!

So if you have a duplicate copy of the object in a pack, we'd actually
find and check the duplicate. This can happen, e.g., if you had a loose
object and fetched a thin-pack which made a copy of the loose object to
complete the pack).

Probably fsck_loose() should be more picky about making sure we are
reading the data from the loose version we found.

-Peff
