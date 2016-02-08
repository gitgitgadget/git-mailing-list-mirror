From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 11:37:00 -0500
Message-ID: <20160208163700.GA22929@sigill.intra.peff.net>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
 <20160208135013.GA27054@sigill.intra.peff.net>
 <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 17:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSooI-0006FW-FX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 17:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbcBHQhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 11:37:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:39309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755057AbcBHQhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 11:37:03 -0500
Received: (qmail 4642 invoked by uid 102); 8 Feb 2016 16:37:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 11:37:02 -0500
Received: (qmail 6837 invoked by uid 107); 8 Feb 2016 16:37:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 11:37:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 11:37:00 -0500
Content-Disposition: inline
In-Reply-To: <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285781>

On Mon, Feb 08, 2016 at 05:27:30PM +0100, Michael J Gruber wrote:

> > I think this just re-breaks things on Windows. That first setup test
> > used "chmod +x" (which is brought back by your patch), without having
> > the POSIXPERM prerequisite.
> >
> > We probably do not want to mark the whole setup test as POSIXPERM, as
> > that would effectively break all of the other tests on Windows. The rest
> > of the tests need to be able to work whether or not the "chmod +x" was
> > run. It may be simpler to just break the executable-bit tests, including
> > setup, out to their own section of the script.
> >
> The commit message does not explain that part of the patch at all - to me
> it looks as if the direct "echo" and "chmod +x" is simply replaced
> by calling a function which does just that, or more exactly, not quite:

Ah, right. I figured that systems that don't handle `chmod +x` would
omit it from write_script(). But it looks like we don't. I guess the
logic is that on Windows "chmod +x" doesn't _complain_, it's simply a
noop for adding the file to the index (because we unset core.filemode).

So in that sense, Windows is fine with that setup either way.

I wondered why it would not later fail the same sha1 check, since "git
add" would not respect the executable bit on such a system. But the
answer is that we do not "git add" the result; we import it using svn,
and then convert that to a git tree.

> > That being said, t9100 seems to pass for me, even at bcb11f1. Can you
> > show us the breakage you are seeing?
> 
> SHELL_PATH=/bin/dash (in config.mak)
> 
> As I explained in my commit message, the problem arises when SHELL_PATH is
> not "/bin/sh" and, consequently,
> the generated "exec.sh" results in a blob with a different sha1.

Oh, of course. I forgot that my SHELL_PATH is in fact /bin/sh. Sorry for
being thick.

Assuming your patch works on Windows (and from the logic above, I think
it should be the case?), then I think it's a good solution.

-Peff
