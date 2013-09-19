From: Jeff King <peff@peff.net>
Subject: Re: git clone silently aborts if stdout gets a broken pipe
Date: Thu, 19 Sep 2013 04:35:30 -0400
Message-ID: <20130919083530.GA12597@sigill.intra.peff.net>
References: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
 <20130918184551.GC18821@sigill.intra.peff.net>
 <A612847CFE53224C91B23E3A5B48BAC798CD91DBA7@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 10:35:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMZiF-0002xV-72
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 10:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab3ISIfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 04:35:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:33561 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab3ISIfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 04:35:39 -0400
Received: (qmail 29096 invoked by uid 102); 19 Sep 2013 08:35:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 03:35:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 04:35:30 -0400
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC798CD91DBA7@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235007>

On Thu, Sep 19, 2013 at 09:54:38AM +0200, Peter Kjellerstedt wrote:

> > I think your perl script is somewhat questionable, as it is making
> > assumptions about the output of git-clone, and you would do better to
> > accept arbitrary-sized output 
> 
> Well, the whole idea of using Git::command_oneline() is that we 
> are only interested in the first line of output, similar to using 
> "| head -1". If we had wanted all of the output we would have used 
> Git::command() instead. Since the Git Perl module is released as a 
> part of Git, I would expect it to work as documented regardless of 
> which Git command is used with Git::command_oneline().

I think command_oneline is exactly like "| head -1" in this case. Doing
"git clone | head -1" would also fail, and should not be used. In
general, you do not want to put a limiting pipe on a command with side
effects beyond output. The design of unix pipes and SIGPIPE is such that
you can do "generate_output | head", and "generate_output" will get
SIGPIPE and die after realizing that its writer no longer cares about
the output. But if your command is doing something besides output, that
assumption doesn't hold.

Arguably, "git clone" should be taking the initiative to ignore SIGPIPE
itself.  Its primary function is not output, but doing the clone. If
output fails, we would want to continue the clone, not die.

By the way, did you actually want to capture the stdout of git-clone, or
were you just trying to suppress it? Because the eventual patch I posted
sends it to stderr, under the assumption that what used to go to stdout
should not be captured and parsed (because it is localized and subject
to change).

> However, what surprised me most was that git clone failed silently 
> when it got a broken pipe.

It's not "git clone" that is doing this, I think, but rather the design
of command_oneline. If I do:

  (sleep 1; git clone ...; echo >&2 exit=$?) | false

then I see:

  exit=141

That is, clone dies from SIGPIPE trying to write "Cloning into...". But
command_oneline is specifically designed to ignore SIGPIPE death,
because you would want something like:

  command_oneline("git", "rev-list", "$A..$B");

to give you the first line, and then you do not care if the rest of the
rev-list dies due to SIGPIPE (it is a good thing, because by closing the
pipe you are telling it that its output is not needed). It may be that
the documentation for command_oneline can be improved to mention this
subtlety.

-Peff
