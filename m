From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Mon, 6 Feb 2012 05:06:22 -0500
Message-ID: <20120206100622.GC4300@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <4F2FA330.7020803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 06 11:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuLTG-00005H-FS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 11:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab2BFKGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 05:06:25 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58737
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215Ab2BFKGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 05:06:25 -0500
Received: (qmail 26409 invoked by uid 107); 6 Feb 2012 10:13:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 05:13:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 05:06:22 -0500
Content-Disposition: inline
In-Reply-To: <4F2FA330.7020803@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190060>

On Mon, Feb 06, 2012 at 10:53:52AM +0100, Michael Haggerty wrote:

> ISTM that the main goal was to prevent infinite recursion, not avoid a
> little bit of redundant reading.

It was both, actually. There was a sense that we should not end up with
duplicate entries by reading the same file twice. However, entries which
actually create lists (and could therefore create duplicates) are by far
the minority compared to entries which overwrite. And it is the
overwrite-style entries which are harmed by suppressing duplicates.

> If that is the goal, all you have to record is the "include stack"
> context that caused the currently-being-included file to be read and
> make sure that the currently-being-included file didn't appear earlier
> on the stack.  The fact that the same file was included earlier (but
> not as part of the same include chain) needn't be considered an error.

I considered this, but decided the complexity wasn't worth it,
especially because getting it accurate means cooperation from
git_config_from_file, which otherwise doesn't know or care about this
mechanism. Instead I keep a simple depth counter and barf at a
reasonable maximum, printing the "from" and "to" files. Yes, it's not
nearly as elegant as keeping the whole stack, but I really don't expect
people to have complex super-deep includes, nor for it to be difficult
to hunt down the cause of a cycle.

Maybe that is short-sighted or lazy of me, but I'd just really be
surprised if people ever went more than 1 or 2 layers deep, or if they
actually ended up with a cycle at all.

There is a stack kept already by git_config_from_file, but it doesn't
respect the call-chain (so if I start a new git_config() call from
inside a callback, it is still part of the same stack).

We could possibly put a marker in the stack for that situation, and then
it would be usable for include cycle-detection.

> However, one could even imagine a command like
> 
>     $ git config --where-defined user.email
>     user.email defined by /home/me/myfile2 line 75
>         which was included from /home/me/myfile1 line 13
>         which was included from /home/me/.gitconfig line 22
>     user.email redefined by /home/me/project/.git/companyconfig line 8
>         which was included from /home/me/project/.git/config line 20

You can already implement this with the existing stack by providing a
suitable callback (since its your callback, you'd know that there was no
recursion of git_config, and therefore the stack refers only to a single
set of includes).

-Peff
