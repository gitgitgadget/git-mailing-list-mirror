From: Jeff King <peff@peff.net>
Subject: Re: http.postBuffer set at the server side?
Date: Thu, 29 Aug 2013 02:31:02 -0400
Message-ID: <20130829063102.GA28827@sigill.intra.peff.net>
References: <871B6C10EBEFE342A772D1159D132085416127CF@umechphj.easf.csd.disa.mil>
 <20130829035209.GC22788@sigill.intra.peff.net>
 <D7C6383E8CCC40338EABF61A1CDADFC8@porsche>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Thu Aug 29 08:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEvlA-0000gb-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 08:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab3H2GbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 02:31:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:34276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab3H2GbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 02:31:07 -0400
Received: (qmail 1850 invoked by uid 102); 29 Aug 2013 06:31:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Aug 2013 01:31:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Aug 2013 02:31:02 -0400
Content-Disposition: inline
In-Reply-To: <D7C6383E8CCC40338EABF61A1CDADFC8@porsche>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233236>

On Thu, Aug 29, 2013 at 12:40:16AM -0400, Jason Pyeron wrote:

> > What would it mean to set it on the server?  It is the size 
> > at which the client decides to use a "chunked" 
> 
> To tell the client...

But the server in this case cannot tell it a useful size. Only "whatever
you do, do not chunk".

> Agreed. By then I hope to get our infrastructure team to address the proxies.
> Liking the spool idea below. The other idea would be restrict the size of any
> one transfer. (would that work if a given commit is large than the threshold???)

I don't think you can do that elegantly. The packfile needs to come up
as a whole, because the server is stateless. The best you could do is to
split the packfile up into small updates of history, and then have the
server receive each (and update the refs) incrementally. But even that
isn't foolproof; it could be that a single large blob object is larger
than the limit.

> > If the server really insists on a content-length header, then 
> > we can't ever fix (2). But we could fix (1) by spooling the 
> > packfile to disk and then sending from there (under the 
> > assumption that you have way more temporary disk space than RAM).
> 
> Hmmm. So if the server says, hey I have a borked infrastructure, please send me
> a content length git could spool then.

I'm not sure how the server would say that. It can return a 411, which
it is currently doing, but the git client will have already discarded
the data by that point. So it would have to come during one of the
earlier responses (I guess an extra http header? I surely would not want
to pollute the git protocol with such hackery).

So let's imagine that we figure that part out, and now we can ship a 1G
packfile up in a single POST by spooling it to disk. Do the proxies
actually allow that? Or do they also have a max-size-per-post setting?

If there is a maximum size, we can't get around that. And if it's small
enough, there's no point in spooling, as we can just get by with
tweaking http.postBuffer instead.

-Peff
