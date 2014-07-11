From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] add object_as_type helper for casting objects
Date: Fri, 11 Jul 2014 12:59:56 -0400
Message-ID: <20140711165956.GA7856@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
 <20140711084823.GD5625@sigill.intra.peff.net>
 <53BFC066.2090102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eBH-00037G-NO
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbaGKRAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:00:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:60229 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754568AbaGKRAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:00:00 -0400
Received: (qmail 11028 invoked by uid 102); 11 Jul 2014 16:59:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 11:59:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 12:59:56 -0400
Content-Disposition: inline
In-Reply-To: <53BFC066.2090102@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253294>

On Fri, Jul 11, 2014 at 11:45:58AM +0100, Ramsay Jones wrote:

> > @@ -1729,9 +1729,8 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
> >  
> >  	if (o->type == OBJ_NONE) {
> >  		int type = sha1_object_info(name, NULL);
> > -		if (type < 0)
> > +		if (type < 0 || !object_as_type(o, type, 0))
> --------------------------------------------------------^^^
> 
> It is not possible here for object_as_type() to issue an error()
> report, but I had to go look at the code to check. (It would have
> been a change in behaviour, otherwise). So, it doesn't really matter
> what you pass to the quiet argument, but setting it to 1 _may_ help
> the next reader. (No, I'm not convinced either; the only reason I
> knew it had anything to do with error messages was because I had
> just read the code ...) Hmm, dunno.

Right, as I mentioned in the commit message, the type-check part of
object_type is a noop here. In that sense you could write this as just:

  object_as_type(o, type. 1);

and ignore the return value. However, I'd rather err on the side of
checking for and reporting the error, even if we expect it to do nothing
right now. That decouples the two functions, and if object_as_type ever
learns to report other errors, then we automatically do the right
thing here.

-Peff
