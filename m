From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 46/67] write_loose_object: convert to strbuf
Date: Wed, 16 Sep 2015 17:39:52 -0400
Message-ID: <20150916213952.GB19658@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915160044.GT29753@sigill.intra.peff.net>
 <xmqq613aoy02.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:40:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKR0-0002xi-42
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbbIPVkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:40:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:60405 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753619AbbIPVkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:40:00 -0400
Received: (qmail 29130 invoked by uid 102); 16 Sep 2015 21:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:40:00 -0500
Received: (qmail 24054 invoked by uid 107); 16 Sep 2015 21:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 17:40:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 17:39:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqq613aoy02.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278072>

On Wed, Sep 16, 2015 at 02:27:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > -	memcpy(buffer, filename, dirlen);
> > -	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
> > -	fd = git_mkstemp_mode(buffer, 0444);
> > +	strbuf_reset(tmp);
> > +	strbuf_add(tmp, filename, dirlen);
> > +	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
> > +	fd = git_mkstemp_mode(tmp->buf, 0444);
> >  	if (fd < 0 && dirlen && errno == ENOENT) {
> > -		/* Make sure the directory exists */
> > -		memcpy(buffer, filename, dirlen);
> > -		buffer[dirlen-1] = 0;
> > -		if (mkdir(buffer, 0777) && errno != EEXIST)
> > +		/*
> > +		 * Make sure the directory exists; note that mkstemp will have
> > +		 * put a NUL in our buffer, so we have to rewrite the path,
> > +		 * rather than just chomping the length.
> > +		 */
> > +		strbuf_reset(tmp);
> > +		strbuf_add(tmp, filename, dirlen - 1);
> > +		if (mkdir(tmp->buf, 0777) && errno != EEXIST)
> >  			return -1;
> 
> I had to read the patch three times before understanding what the
> business with NUL in this comment is about.
> 
> The old code was doing the same thing, i.e. instead of attempting to
> reuse the early part of buffer[] it copied the early part of
> filename[] there again, exactly for the same reason, but it didn't
> even explain why the copy was necessary.  Now the new code explains
> why strbuf_setlen() is not used here pretty nicely.

Exactly (I found this out the hard way by trying to clean that up, and
learned something new about mkstemp).

Mentioning the NUL is probably unnecessarily confusing. That is what our
gitmkstemp does, but mkstemp(3) says "undefined" on my system (POSIX
does not mention it at all, but the NUL seems like a reasonable safety
in case any callers ignore the return value).

I've updated this to:

       /*
        * Make sure the directory exists; note that the contents
        * of the buffer are undefined after mkstemp returns an
        * error, so we have to rewrite the whole buffer from
        * scratch.
        */

-Peff
