From: Jeff King <peff@peff.net>
Subject: Re: bash-completion now loads completions dynamically, so __git_ps1
 is not defined when you open a shell
Date: Thu, 29 Mar 2012 01:57:02 -0400
Message-ID: <20120329055702.GC27604@sigill.intra.peff.net>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
 <7v1uoctlp2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kerrick Staley <mail@kerrickstaley.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 07:57:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD8MC-0001BV-MK
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 07:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab2C2F5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 01:57:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36796
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab2C2F5G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 01:57:06 -0400
Received: (qmail 27747 invoked by uid 107); 29 Mar 2012 05:57:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 01:57:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 01:57:02 -0400
Content-Disposition: inline
In-Reply-To: <7v1uoctlp2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194231>

On Wed, Mar 28, 2012 at 03:17:13PM -0700, Junio C Hamano wrote:

> Kerrick Staley <mail@kerrickstaley.com> writes:
> 
> > The __git_ps1 function is defined in same script that defines Git's
> > tab completions (contrib/completion/git-completion.bash). Since
> > bash-completion loads completions on-the-fly in newer versions, the
> > __git_ps1 function isn't immediately available in a new shell. How
> > should this be handled? Should users just source git-completion.bash
> > before they redefine $PS1?
> 
> Sorry, I don't quite get it.  "newer verions" of what?
> 
> To me, completion scripts have always been to be dot-sourced early, making
> sure inclusion happen before PS1 is used.  Did we change anything recently
> to break it????

No, it is not us. The bash-completion project used to look in something
like /etc/bash_completions.d and load everything at shell startup.
Packagers could then drop our git-completion file there, and everything
just worked.

But it made starting the shell very slow, as you loaded completions for
commands that you were unlikely to ever run. Newer versions of
bash-completions load as little as possible on startup. When you first
try to tab-complete "git <tab>", _then_ it looks for a "git" file and
loads it on the fly.

So people who put ". /path/to/git-completion.bash" have nothing to worry
about. Everything will work as normal. People who depend on dropping
the file somewhere that bash-completion can find it (or who use a
package which does so) will find that they do not have __git_ps1 at
shell startup with newer versions of bash-completion. Those people will
need to start sourcing the file themselves (or possibly bash-completion
could do it, but it really feels like it is not their responsibility, as
the prompt functions have nothing to do with completion).

We can help them out by breaking the file apart into "must be loaded at
startup" and "can be loaded dynamically" bits, so they don't end up
loading more than they need to.

-Peff
