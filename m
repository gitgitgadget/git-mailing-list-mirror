From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] grep: cache userdiff_driver in grep_source
Date: Thu, 2 Feb 2012 14:37:56 -0500
Message-ID: <20120202193756.GA9246@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
 <20120202082043.GF6786@sigill.intra.peff.net>
 <7v4nv9xexs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 20:38:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2U4-0000n2-HS
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227Ab2BBTiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:38:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53627
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137Ab2BBTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:38:00 -0500
Received: (qmail 24528 invoked by uid 107); 2 Feb 2012 19:45:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 14:45:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 14:37:56 -0500
Content-Disposition: inline
In-Reply-To: <7v4nv9xexs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189681>

On Thu, Feb 02, 2012 at 10:34:07AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > -		grep_attr_lock();
> > -		drv = userdiff_find_by_path(gs->name);
> > -		grep_attr_unlock();
> > -		if (drv && drv->funcname.pattern) {
> > -			const struct userdiff_funcname *pe = &drv->funcname;
> > +		grep_source_load_driver(gs);
> > +		if (gs->driver->funcname.pattern) {
> > +			const struct userdiff_funcname *pe = &gs->driver->funcname;
> 
> When we load driver, gs->driver gets at least "default" driver, so we no
> longer need to check for drv != NULL as we used to?  Is that the reason
> for the slight difference here?

Yes, exactly.

We could just leave gs->driver NULL instead of looking up "default", and
then use NULL to signal to the calling code that defaults should be
used. But NULL is interpreted by grep_source_load_driver as "we did not
look up the driver yet", so the common case of "no driver" would mean we
accidentally do the lookup multiple times.  The diff_filespec code uses
the same convention to solve the same problem.

Speaking of which, there was some notion in my mind that a "grep_source"
and a "diff_filespec" were very similar objects, and that we could
possibly unify the implementations. I decided against that route with
this series, as it would have involved pretty heavy refactoring of the
diff code to prevent a fairly small amount of code duplication.

-Peff
