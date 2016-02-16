From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 22:15:54 -0500
Message-ID: <20160216031554.GB13606@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
 <20160215215244.GG10287@sigill.intra.peff.net>
 <CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 04:16:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVW7O-0003Y0-1c
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 04:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbcBPDP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 22:15:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:42726 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750897AbcBPDP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 22:15:57 -0500
Received: (qmail 18488 invoked by uid 102); 16 Feb 2016 03:15:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:15:57 -0500
Received: (qmail 15606 invoked by uid 107); 16 Feb 2016 03:16:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:16:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 22:15:54 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286308>

On Mon, Feb 15, 2016 at 09:17:05PM -0500, Eric Sunshine wrote:

> > ---
> > diff --git a/builtin/reflog.c b/builtin/reflog.c
> > @@ -412,8 +410,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
> >                     !memcmp(ent->pattern, pattern, len))
> >                         return ent;
> >
> > -       ent = xcalloc(1, (sizeof(*ent) + len));
> > -       memcpy(ent->pattern, pattern, len);
> > +       FLEX_ALLOC_MEM(ent, pattern, pattern, len);
> 
> Does the incoming 'len' already account for the NUL terminator, or was
> the original code underallocating?
> 
> Answering my own question: Looking at reflog_expire_config() and
> parse_config_key(), I gather that 'len' already accounts for the NUL,
> thus the new code is overallocating (which should not be a problem).

Actually, I think the original underallocates. If we have
gc.foobar.reflogExpire, then "pattern" will poitn to "foobar" and "len"
will be 6. Meaning we allocate without a trailing NUL.

That _should_ be OK, because the struct has a "len" field, and readers
can be careful not to go past it. And indeed, in the loop above, we
check the length and use memcmp().

But later, in set_reflog_expiry_param(), we walk through the list and
hand ent->pattern directly to wildmatch, which assumes a NUL-terminated
string. In practice, it probably works out 7 out of 8 times, because
malloc will align the struct, and we're on a zeroed page, so unless the
string is exactly 8 characters, we'll get some extra NULs afterwards.
But I could demonstrate it by doing:

  gdb --args git -c gc.foobar12.reflogexpire=never reflog expire --all

and breaking on wildmatch, which yields:

  Breakpoint 1, wildmatch (pattern=0x85eb70 "foobar12Q", text=0x85e4d4
	"refs/heads/master", flags=0, wo=0x0)

So this is in fact fixing a bug. I can't say I'm terribly surprised
nobody noticed it, as per-ref reflog expiration is pretty obscure.

I hope this increases confidence in my patch series. Even though I
didn't _know_ there was a bug here, I did know that malloc computations
are a potential source of errors. And the FLEX_ALLOC helpers are
designed to remove that work and have a simple interface. We don't know
whether the caller will want a NUL afterwards or not, but we err on the
side of over-allocating by a byte (just as we over-allocate
read_sha1_file() output by a byte), because safety is better than
squeezing out a single byte.

> > diff --git a/hashmap.c b/hashmap.c
> > @@ -256,10 +256,9 @@ const void *memintern(const void *data, size_t len)
> >         e = hashmap_get(&map, &key, data);
> >         if (!e) {
> >                 /* not found: create it */
> > -               e = xmallocz(sizeof(struct pool_entry) + len);
> > +               FLEX_ALLOC_MEM(e, data, data, len);
> 
> Ditto. I guess the new code is overallocating (which should be okay).

It is, but so was the original (it used xmallocz to get an extra NUL).

-Peff
