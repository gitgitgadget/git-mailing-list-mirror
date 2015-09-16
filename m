From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 29/67] use strip_suffix and xstrfmt to replace suffix
Date: Wed, 16 Sep 2015 06:50:38 -0400
Message-ID: <20150916105037.GI13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154714.GC29753@sigill.intra.peff.net>
 <CAPig+cRefYKBOLJMsu+yAp7D=GYh4Pr5eXEeHXR0b-4hhOfxPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcAId-000448-5d
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 12:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbbIPKur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 06:50:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:59874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752557AbbIPKuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 06:50:46 -0400
Received: (qmail 18803 invoked by uid 102); 16 Sep 2015 10:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:50:47 -0500
Received: (qmail 16847 invoked by uid 107); 16 Sep 2015 10:50:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 06:50:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 06:50:38 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRefYKBOLJMsu+yAp7D=GYh4Pr5eXEeHXR0b-4hhOfxPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278020>

On Wed, Sep 16, 2015 at 12:38:12AM -0400, Eric Sunshine wrote:

> > @@ -1524,9 +1525,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
> >                 lst = &((*lst)->next);
> >         *lst = (*lst)->next;
> >
> > -       tmp_idx = xstrdup(preq->tmpfile);
> > -       strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
> > -              ".idx.temp");
> > +       if (!strip_suffix(preq->tmpfile, ".pack.temp", &len))
> > +               die("BUG: pack tmpfile does not end in .pack.temp?");
> > +       tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);
> 
> These instances of repeated replacement code may argue in favor of a
> general purpose replace_suffix() function:
> 
>     char *replace_suffix(const char *s, const char *old, const char *new)
>     {
>         size_t n;
>         if (!strip_suffix(s, old, &n))
>             die("BUG: '%s' does not end with '%s', s, old);
>         return xstrfmt("%.*s%s", (int)n, s, new);
>     }
> 
> or something.

Yeah, that is tempting, but I think the "die" here is not at all
appropriate in a reusable function. I'd probably write it as:

  char *replace_suffix(const char *s, const char *old, const char *new)
  {
	size_t n;
	if (!strip_suffix(s, old, &n))
		return NULL;
	return xstrfmt("%.*s%s", (int)n, s, new);
  }

and do:

  tmp_idx = replace_suffix(preq->tmpfile, ".pack.temp", ".idx.temp");
  if (!tmp_idx)
	die("BUG: pack tmpfile does not end in .pack.temp?");

but then we are not really saving much. And it is not clear whether
that is even a sane output for replace_suffix. I can easily imagine
three behaviors when we do not end in the original suffix:

  - return NULL to signal error

  - return the original with no replacement

  - return the original with "new" appended

So I'm not sure it makes a good reusable function beyond these three
call-sites.

-Peff
