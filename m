Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967571FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 00:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762235AbdADAkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 19:40:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:34860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbdADAke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 19:40:34 -0500
Received: (qmail 10258 invoked by uid 109); 4 Jan 2017 00:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 00:40:34 +0000
Received: (qmail 28094 invoked by uid 111); 4 Jan 2017 00:41:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Jan 2017 19:41:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2017 19:40:31 -0500
Date:   Tue, 3 Jan 2017 19:40:31 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] archive-zip: load userdiff config
Message-ID: <20170104004031.ccm6skvfe3u4kkbw@sigill.intra.peff.net>
References: <20170102222509.ho7motscnffrtnfh@sigill.intra.peff.net>
 <7710c564-6b53-1908-7205-210d80eda59b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7710c564-6b53-1908-7205-210d80eda59b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 06:24:39PM +0100, René Scharfe wrote:

> Am 02.01.2017 um 23:25 schrieb Jeff King:
> > Since 4aff646d17 (archive-zip: mark text files in archives,
> > 2015-03-05), the zip archiver will look at the userdiff
> > driver to decide whether a file is text or binary. This
> > usually doesn't need to look any further than the attributes
> > themselves (e.g., "-diff", etc). But if the user defines a
> > custom driver like "diff=foo", we need to look at
> > "diff.foo.binary" in the config. Prior to this patch, we
> > didn't actually load it.
> 
> Ah, didn't think of that, obviously.
> 
> Would it make sense for userdiff_find_by_path() to die if userdiff_config()
> hasn't been called, yet?

Yeah, perhaps. That makes it impossible for a program to intentionally
ignore the config. But it looks like even plumbing diff commands load
userdiff (which makes sense; they control its behavior through things
like ALLOW_TEXTCONV). So it's probably fine to have it everywhere.

Other options include:

  1. Just loading it always as part of git_default_config.

  2. Lazy-loading it on the first call. This seems elegant, though it
     does open up hidden cache-invalidation issues. E.g., somebody asks
     for userdiff_find_by_path(), we load the values, then they
     setup_git_repository(), and we would need to reload. That's
     far-fetched for userdiff, but it makes lazy-loading as a general
     pattern a bit of a potential maintenance trap.

     We could also introduce some infrastructure to deal with that
     (e.g., if callers could ask the config machinery "have you been
     invalidated"). That would help here and in other places (e.g., I
     considered this when dealing with get_shared_repository()).

> > I also happened to notice that zipfiles are created using the local
> > timezone (because they have no notion of the timezone, so we have to
> > pick _something_). That's probably the least-terrible option, but it was
> > certainly surprising to me when I tried to bit-for-bit reproduce a
> > zipfile from GitHub on my local machine.
> 
> That reminds me of an old request to allow users better control over the
> meta-data written into archives.  Being able to specify a time zone offset
> could be a start.

I did it with:

  TZ=PST8PDT git archive ...

which let me get a bit-for-bit match with what GitHub generates. The
real problem was just knowing that I needed to do that. OTOH, we're
considering having GitHub generate all archives in UTC for sanity's
sake, and it would be nice to do that by setting zip.timezone instead of
hacking $TZ for each invocation.

> > +static int archive_zip_config(const char *var, const char *value, void *data)
> > +{
> > +	return userdiff_config(var, value);
> > +}
> > +
> >  static int write_zip_archive(const struct archiver *ar,
> >  			     struct archiver_args *args)
> >  {
> >  	int err;
> > 
> > +	git_config(archive_zip_config, NULL);
> > +
> 
> I briefly thought about moving this call to archive.c with the rest of the
> config-related stuff, but I agree it's better kept here.

That was my first thought, but there are already two config calls:
write_archive() loads default config, but then archive-tar loads
tar-specific config. Since only zip cares about userdiff, I patterned it
after the latter. But arguably everybody _could_ end up calling into
userdiff. If we take that philosophy, though, I'd be more inclined to
push it into git_default_config(). That covers archive writers _and_ any
other programs which might happen to call into the diff code.

> Looks good, thanks!

Thanks for reviewing.

-Peff
