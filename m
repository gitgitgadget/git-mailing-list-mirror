From: Jeff King <peff@peff.net>
Subject: Re: [BUG] MSVC: error box when interrupting `gitlog` by quitting less
Date: Fri, 28 Mar 2014 05:44:43 -0400
Message-ID: <20140328094443.GA16370@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <loom.20140328T093203-852@post.gmane.org>
 <loom.20140328T101113-154@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 10:44:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTTLJ-0003cK-6y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 10:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbaC1Jot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 05:44:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:49183 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751208AbaC1Jos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 05:44:48 -0400
Received: (qmail 5464 invoked by uid 102); 28 Mar 2014 09:44:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 04:44:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 05:44:43 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140328T101113-154@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245373>

On Fri, Mar 28, 2014 at 09:14:07AM +0000, Marat Radchenko wrote:

> > Jeff King <peff <at> peff.net> writes:
> > 
> > > 
> > > The write_or_die function will always die on an error,
> > > including EPIPE. However, it currently treats EPIPE
> > > specially by suppressing any error message, and by exiting
> > > with exit code 0.
> > 
> > This causes error box on Windows in MSVC=1 build:
> 
> After deeper investigation it turned out that Windows supports
> much less signals [1] than POSIX and "If the argument is not a valid signal 
> as specified above, the invalid parameter handler is invoked".
> 
> The question is - what is the proper way to fix this?
> Patch mingw_raise in compat/mingw.c to map unsupported signals into
> supported ones like SIGPIPE -> SIGTERM?
> 
> [1]: http://msdn.microsoft.com/en-us/library/dwwzkt4c.aspx

I'm not sure what an actual SIGPIPE death looks like on Windows. What
happens if git is still writing data to the pager and the pager exits?
Does it receive a signal of some sort?

The point of the code in check_pipe is to simulate that death. So
whatever happens to git in that case is what we would want to happen
when we call raise(SIGPIPE).

A possibly simpler option would be to just have the MSVC build skip the
raise() call, and do the exit(141) that comes just after. That is
probably close enough simulation of SIGPIPE death.

-Peff
