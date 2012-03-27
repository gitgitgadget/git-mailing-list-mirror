From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Mon, 26 Mar 2012 23:34:20 -0400
Message-ID: <20120327033420.GC17338@sigill.intra.peff.net>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120327032917.GB17338@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jrnieder@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Mar 27 05:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCNB0-0002th-7X
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 05:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609Ab2C0DeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 23:34:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60375
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756875Ab2C0DeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 23:34:25 -0400
Received: (qmail 28258 invoked by uid 107); 27 Mar 2012 03:34:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 23:34:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 23:34:20 -0400
Content-Disposition: inline
In-Reply-To: <20120327032917.GB17338@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194000>

On Mon, Mar 26, 2012 at 11:29:17PM -0400, Jeff King wrote:

> > +#ifndef SHELL_PATH
> > +# define SHELL_PATH "sh"
> > +#endif
> 
> Does this default ever kick in? The Makefile defaults SHELL_PATH to
> /bin/sh, so we will always end up with at least that.
> 
> Doing so at least makes us consistent across builds, but I wonder if we
> should leave it as "sh" on systems that do not set SHELL_PATH manually.
> Executing "sh" via the PATH is the normal system() thing to do. I doubt
> many people have an "sh" in their PATH ahead of /bin/sh, but if they do,
> we are changing the behavior for them for no good reason.
> 
> The whole SHELL_PATH and SANE_TOOL_PATH mess is about helping people on
> less-abled systems, and I do not mind bending the usual conventions to
> make things more convenient on those systems (e.g., by not doing the
> PATH lookup of the shell name). But it would be nice if that bending did
> not affect people on more mainstream systems.

I think you could do that pretty easily with this in the Makefile:

diff --git a/Makefile b/Makefile
index be1957a..fcd6896 100644
--- a/Makefile
+++ b/Makefile
@@ -528,6 +528,9 @@ BINDIR_PROGRAMS_NO_X += git-cvsserver
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
+	SHELL_NAME = sh
+else
+	SHELL_NAME = $(SHELL_PATH)
 endif
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl

and then just pass and use $SHELL_NAME in run-command.c (I guess you'd
have to make a $SHELL_NAME_SQ, too).

One other option not discussed: what if you always just used the
basename of $SHELL_PATH? That would fix your problem (it would do "bash
-c" instead of "sh -c"), while keeping the same PATH-lookup semantics
that exist now. The only setup it wouldn't help is somebody who uses
/some/other/sh, then still has /bin in their PATH before /some/other.

-Peff
