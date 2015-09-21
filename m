From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 56/67] avoid sprintf and strcpy with flex arrays
Date: Mon, 21 Sep 2015 11:15:21 -0400
Message-ID: <20150921151521.GA25286@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915160956.GD29753@sigill.intra.peff.net>
 <CAPig+cSL3W58TSYEAFz3twvxt_brB=kY=LEwX6m5RhBsg6VV6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 17:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze2oT-0005F3-FK
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 17:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbbIUPPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 11:15:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:33953 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753224AbbIUPPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 11:15:24 -0400
Received: (qmail 15607 invoked by uid 102); 21 Sep 2015 15:15:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 10:15:23 -0500
Received: (qmail 27753 invoked by uid 107); 21 Sep 2015 15:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 11:15:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Sep 2015 11:15:21 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSL3W58TSYEAFz3twvxt_brB=kY=LEwX6m5RhBsg6VV6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278304>

On Sun, Sep 20, 2015 at 06:48:32PM -0400, Eric Sunshine wrote:

> > diff --git a/archive.c b/archive.c
> > index 01b0899..4ac86c8 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -171,13 +171,14 @@ static void queue_directory(const unsigned char *sha1,
> >                 unsigned mode, int stage, struct archiver_context *c)
> >  {
> >         struct directory *d;
> > -       d = xmallocz(sizeof(*d) + base->len + 1 + strlen(filename));
> > +       size_t len = base->len + 1 + strlen(filename) + 1;
> > +       d = xmalloc(sizeof(*d) + len);
> 
> Mental note: The new code makes this one longer than the original code...
>
> >         d->up      = c->bottom;
> >         d->baselen = base->len;
> >         d->mode    = mode;
> >         d->stage   = stage;
> >         c->bottom  = d;
> > -       d->len = sprintf(d->path, "%.*s%s/", (int)base->len, base->buf, filename);
> > +       d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
> 
> Considering that we need space for the '/' and the NUL, the new code
> seems to be correct, and the old code was under-allocating, right?

Not quite. The original uses xmallocz, which handles the NUL itself. But
the purpose of this patch is to pull the total length into a variable
that we can use both for the malloc and for the xsnprintf, so we have
to account for it ourselves.

We do lose the setting of the final byte to '\0' that xmallocz does, but
it doesn't matter here because xsnprintf will add the NUL itself.

> > diff --git a/fast-import.c b/fast-import.c
> > index d0c2502..895c6b4 100644
> > --- a/fast-import.c
> > +++ b/fast-import.c
> > @@ -863,13 +863,15 @@ static void start_packfile(void)
> >  {
> >         static char tmp_file[PATH_MAX];
> >         struct packed_git *p;
> > +       int namelen;
> >         struct pack_header hdr;
> >         int pack_fd;
> >
> >         pack_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
> >                               "pack/tmp_pack_XXXXXX");
> > -       p = xcalloc(1, sizeof(*p) + strlen(tmp_file) + 2);
> > -       strcpy(p->pack_name, tmp_file);
> > +       namelen = strlen(tmp_file) + 2;
> 
> You mentioned this specially in the commit message, but from a brief
> read of the code, it's still not obvious (to me) why this is +2 rather
> than +1. Since you're touching the code anyhow, perhaps add an in-code
> comment explaining it?

To be honest, I'm not sure what's going on with the "+ 2" here.

In many cases with packed_git we allocate with "foo.idx" and want to be
able to later write "foo.pack" into the same buffer. But here we are
putting in a tmpfile name. This comes from 8455e48, but I don't see any
clue there. I wonder if the "+2" was simply cargo-culted from other
instances.

I'm loath to change it in the middle of this patch, because it would be
hard to see amidst the other changes. I'd rather make this a straight
conversion, and worry about it in a separate patch.

> > -       strcpy((char *)update->refname, refname);
> > +       memcpy((char *)update->refname, refname, len); /* includese NUL */
> 
> s/includese/includes/

Thanks, fixed.

-Peff
