From: Jeff King <peff@peff.net>
Subject: Re: another packed-refs race
Date: Fri, 3 May 2013 14:26:49 -0400
Message-ID: <20130503182649.GA25379@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com>
 <20130503172853.GB21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 03 20:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYKh6-0002ZF-Os
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 20:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762990Ab3ECS0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 14:26:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:40638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837Ab3ECS0w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 14:26:52 -0400
Received: (qmail 8772 invoked by uid 102); 3 May 2013 18:27:10 -0000
Received: from c-98-244-78-62.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.78.62)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 May 2013 13:27:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2013 14:26:49 -0400
Content-Disposition: inline
In-Reply-To: <20130503172853.GB21715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223318>

On Fri, May 03, 2013 at 01:28:53PM -0400, Jeff King wrote:

> > The following solution might work in both the resolve-a-single-ref and
> > enumerating-refs case:
> > 
> > 0. Look for ref already cached in memory. If found, OK.
> > 
> > 1. Look for loose ref. If found, OK.
> > 
> > 2. If not found, load all loose refs and packed-refs from disk (in
> > that order), and store in memory for remainder of this process. Never
> > reload packed-refs from disk (unless you also reload all loose refs
> > first).
> 
> I think that would be correct (modulo that step 1 cannot happen for
> enumeration). But we would like to avoid loading all loose refs if we
> can. Especially on a cold cache, it can be quite slow, and you may not
> even care about those refs for the current operation (I do not recall
> the exact original motivation for the lazy loading, but it was something
> along those lines).

Actually, forgetting about enumeration for a minute, that would make
single-ref lookup quite painful. Running "git rev-parse foo" shouldn't
have to even look at most loose refs in the first place. It should be a
couple of open() calls looking for the right spot, and then fall back to
loading packed-refs.

-Peff
