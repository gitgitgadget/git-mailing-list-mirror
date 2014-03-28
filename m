From: Jeff King <peff@peff.net>
Subject: Re: [BUG] MSVC: error box when interrupting `gitlog` by quitting less
Date: Fri, 28 Mar 2014 06:19:41 -0400
Message-ID: <20140328101940.GA27601@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <loom.20140328T093203-852@post.gmane.org>
 <loom.20140328T101113-154@post.gmane.org>
 <20140328094443.GA16370@sigill.intra.peff.net>
 <loom.20140328T105136-494@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 11:19:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTTt5-0007Lv-62
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 11:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbaC1KTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 06:19:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:49205 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751055AbaC1KTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 06:19:42 -0400
Received: (qmail 7661 invoked by uid 102); 28 Mar 2014 10:19:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 05:19:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 06:19:41 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140328T105136-494@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245377>

On Fri, Mar 28, 2014 at 10:07:22AM +0000, Marat Radchenko wrote:

> > What
> > happens if git is still writing data to the pager and the pager exits?
> > Does it receive a signal of some sort?
> 
> I'm not sure what you mean, sorry. check_pipe properly detects pager exit.
> The problem is with the way it tries to die.

Right, but check_pipe shouldn't trigger in most cases on Unix because
the process will be killed by SIGPIPE automatically. It's only there to
catch the case where we have disabled SIGPIPE.

On Windows, what happens to "yes" if you run:

  yes | (exit 0)

On Unix, "yes" receives SIGPIPE and dies. Does it run forever on
Windows? If it dies, what does the death look like (does it have a
signal death, or exit with a specific code?).

> > The point of the code in check_pipe is to simulate that death. So
> > whatever happens to git in that case is what we would want to happen
> > when we call raise(SIGPIPE).
> 
> That's what I'm talking about. On Windows, you can't raise(SIGPIPE).
> You can only raise(Windows_supported_signal) where signal is one of:
> SIGABRT, SIGFPE, SIGILL, SIGINT, SIGSEGV, SIGTERM as MSDN tells us.

Right, I understand that you don't have SIGPIPE. But we want to emulate
whatever happens in the case I described above.

> > A possibly simpler option would be to just have the MSVC build skip the
> > raise() call, and do the exit(141) that comes just after. That is
> > probably close enough simulation of SIGPIPE death.
> 
> Isn't raise(SIGTERM/SIGINT) good enough?

Perhaps. It is a slight lie. We _didn't_ get a SIGTERM, and anybody
looking at our exit code to find out why we died would be misled. But
the most important thing is that we die and that the exit status is
non-zero.

-Peff
