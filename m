From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Tue, 15 Sep 2015 14:42:11 -0400
Message-ID: <20150915184211.GA31939@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <55F8643D.6040800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 20:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbvBQ-0005Oz-HC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 20:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbbIOSmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 14:42:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59545 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751806AbbIOSmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 14:42:16 -0400
Received: (qmail 23527 invoked by uid 102); 15 Sep 2015 18:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 13:42:16 -0500
Received: (qmail 8941 invoked by uid 107); 15 Sep 2015 18:42:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 14:42:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 14:42:11 -0400
Content-Disposition: inline
In-Reply-To: <55F8643D.6040800@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277977>

On Tue, Sep 15, 2015 at 07:32:29PM +0100, Ramsay Jones wrote:

> > diff --git a/archive-tar.c b/archive-tar.c
> > index b6b30bb..d543f93 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -301,7 +301,7 @@ static int write_global_extended_header(struct archiver_args *args)
> >  	memset(&header, 0, sizeof(header));
> >  	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
> >  	mode = 0100666;
> > -	strcpy(header.name, "pax_global_header");
> > +	xsnprintf(header.name, sizeof(header.name), "pax_global_header");
> 
> How about using strlcpy() instead? Thus:
> 
> -	strcpy(header.name, "pax_global_header");
> +	strlcpy(header.name, "pax_global_header", sizeof(header.name));
> 
> Ditto for other similar (strcpy->xsnprintf) hunks below.

That misses the "assert" behavior of xsnprintf. We are preventing
overflow here, but also truncation. What should happen if
"pax_global_header" does not fit in header.name? I think complaining
loudly and immediately is the most helpful thing, because it is surely a
programming error.

We could make xstrlcpy(), of course, but I don't see much point when
xsnprintf does the same thing (and more).

-Peff
