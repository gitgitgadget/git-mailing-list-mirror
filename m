Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D02203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 18:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbcGVSK2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 14:10:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:48751 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751795AbcGVSK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 14:10:28 -0400
Received: (qmail 17446 invoked by uid 102); 22 Jul 2016 18:10:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 14:10:27 -0400
Received: (qmail 8156 invoked by uid 107); 22 Jul 2016 18:10:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 14:10:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 14:10:24 -0400
Date:	Fri, 22 Jul 2016 14:10:24 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] diff: do not reuse worktree files that need "clean"
 conversion
Message-ID: <20160722181024.GA16595@sigill.intra.peff.net>
References: <1469134747-26785-1-git-send-email-larsxschneider@gmail.com>
 <20160721213740.GB4604@sigill.intra.peff.net>
 <20160722152753.GA6859@sigill.intra.peff.net>
 <xmqq60rxbmaf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60rxbmaf.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 10:44:08AM -0700, Junio C Hamano wrote:

> > diff --git a/diff.c b/diff.c
> > index 7d03419..b43d3dd 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2683,6 +2683,13 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
> >  	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
> >  		return 0;
> >  
> > +	/*
> > +	 * Similarly, if we'd have to convert the file contents anyway, that
> > +	 * makes the optimization not worthwhile.
> > +	 */
> > +	if (!want_file && would_convert_to_git(name))
> > +		return 0;
> 
> The would_convert_to_git() function is not a free operation.  It
> needs to prime the attribute stack, so it needs to open/read/parse a
> few files ($GIT_DIR/info/attributes and .gitattributes at least, and
> more if your directory hierarchy is deep) on the filesystem.  The
> cost is amortized across paths, but we do not even enable the
> optimization if we have to pay the cost of reading the index
> ourselves.

Yeah, I almost commented on that, and its position in the function, but
forgot to.

The only code path which will trigger this is diff_populate_filespec.
After reuse_worktree_file() says "yes, we can reuse", we drop into a
conditional that will end in us calling convert_to_git() anyway, which
will do the same lookup. We don't need to cache, because the expensive
parts of the attribute-lookup are already cached for us by the attribute
code.

So my initial thought was to put it at the end of reuse_worktree_file(),
where it would have the least impact. If we find we cannot reuse the
file, then we would skip both this new attr lookup and the one in
diff_populate_filespec().

But in practice, I think we'll already have cached those attrs before we
even hit this function, because we'll hit the userdiff_find_by_path()
code earlier in the diff process (e.g., to see if it's binary, if we
need to textconv, etc). Those look for different attributes, but I think
the expensive bits (finding, opening, reading attribute files) are
cached across all lookups.

So I think we actually _can_ think of would_convert_to_git() as
basically free. Or as free as other efficient-lookup functions we call
like cache_name_pos(). And so I moved it further up in the function,
where it lets us avoid doing more out-of-process work (like calling
lstat() so we can ce_match_stat() on the result).

Possibly it should go after the cache_name_pos() call, though. That's
likely to be less expensive than the actual walk of the attr tree.

> I suspect that we may be better off disabling this optimization if
> we need to always call the helper.

The thought "does this tree reuse even speed things up enough to justify
its complexity" definitely crossed my mind. It's basically swapping
open/mmap for zlib inflating the content.

But I do think it helps in the "want_file" case (i.e., when we are
writing out a tempfile for an external command via prepare_temp_file()).
There it helps us omit writing a tempfile to disk entirely, including
any possible conversion.

-Peff
