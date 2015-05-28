From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config.c: rewrite ENODEV into EISDIR when mmap fails
Date: Thu, 28 May 2015 16:44:37 -0400
Message-ID: <20150528204436.GB29148@peff.net>
References: <20150528075142.GB3688@peff.net>
 <20150528080300.GD23395@peff.net>
 <xmqq7frsiq3o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 22:44:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4fU-0006xK-7i
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbbE1Uok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:44:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:37400 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751556AbbE1Uoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:44:39 -0400
Received: (qmail 19649 invoked by uid 102); 28 May 2015 20:44:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 15:44:39 -0500
Received: (qmail 19077 invoked by uid 107); 28 May 2015 20:44:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 16:44:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 16:44:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7frsiq3o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270197>

On Thu, May 28, 2015 at 10:11:55AM -0700, Junio C Hamano wrote:

> >  		if (contents == MAP_FAILED) {
> > +			if (errno == ENODEV && S_ISDIR(st.st_mode))
> > +				errno = EISDIR;
> >  			error("unable to mmap '%s': %s",
> >  			      config_filename, strerror(errno));
> >  			ret = CONFIG_INVALID_FILE;
> 
> I think this patch places the "magic" at the right place, but I
> would have preferred to see something more like this:
> 
> 	if (contents == MAP_FAILED) {
>         	if (errno == ENODEV && S_ISDIR(st.st_mode))
> 			error("unable to mmap a directory '%s',
>                         	config_filename);
> 		else
>                 	error("unable to mmap '%s': %s",
>                         	config_filename, strerror(errno));
> 		ret = CONFIG_INVALID_FILE;
> 
> But that is a very minor preference.  I am OK with relying on our
> knowledge that strerror(EISDIR) would give something that says "the
> thing is a directory which is not appropriate for the operation", as
> nobody after that strerror() refers to 'errno' in this codepath.

I am OK if you want to switch it. Certainly EISDIR produces good output
on my system, but I don't know if that is universal.

We also know S_ISDIR(st.st_mode) _before_ we actually mmap. So I was
tempted to simply check it beforehand, under the assumption that the
mmap cannot possibly work if we have a directory. But by doing it in the
error code path, then we _know_ we are not affecting the outcome, only
the error message. :)

-Peff
