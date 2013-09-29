From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Sun, 29 Sep 2013 15:32:45 -0400
Message-ID: <20130929193245.GB17644@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
 <20130928083405.GA2782@sigill.intra.peff.net>
 <CAPig+cQVQ6iY8onvb--88W0XHofC815NZHTb=L744hANtT8mVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, "Kyle J. McKay" <mackyle@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 21:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQMka-0006ew-0n
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 21:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab3I2Tcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 15:32:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:48642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542Ab3I2Tcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 15:32:47 -0400
Received: (qmail 26392 invoked by uid 102); 29 Sep 2013 19:32:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Sep 2013 14:32:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Sep 2013 15:32:45 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQVQ6iY8onvb--88W0XHofC815NZHTb=L744hANtT8mVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235605>

On Sun, Sep 29, 2013 at 03:26:45PM -0400, Eric Sunshine wrote:

> On Sat, Sep 28, 2013 at 4:34 AM, Jeff King <peff@peff.net> wrote:
> > diff --git a/http.c b/http.c
> > index 65a0048..8775b5c 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -921,11 +921,71 @@ static int http_request_reauth(const char *url,
> > +static int update_url_from_redirect(struct strbuf *base,
> > +                                   const char *asked,
> > +                                   const struct strbuf *got)
> > +{
> > +       const char *tail;
> > +       size_t tail_len;
> > +
> > +       if (!strcmp(asked, got->buf))
> > +               return 0;
> > +
> > +       if (strncmp(asked, base->buf, base->len))
> > +               die("BUG: update_url_from_redirect: %s is not a superset of %s",
> > +                   asked, base->buf);
> 
> Is there something non-obvious going on here? die(...,base->buf) takes
> advantage of the terminating NUL promised by strbuf, but then
> strncmp(...,base->buf,base->len) is used rather than the simpler
> strcmp(...,base->buf).

Yes, we are not checking for equality, but rather making sure that
"asked" begins with "base->buf". It might be more clearly written as:

  if (prefixcmp(asked, base->buf))

I was trying to take advantage of the fact that we know base->len
already, but this it not a particularly performance-critical code path.
We can afford the extra strlen that prefixcmp will do.

-Peff
