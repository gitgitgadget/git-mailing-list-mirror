From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 14:08:02 -0400
Message-ID: <20120326180802.GG7942@sigill.intra.peff.net>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120326011148.GA4428@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, gitster@pobox.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEL1-0007hu-TM
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262Ab2CZSIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:08:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60054
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231Ab2CZSIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:08:04 -0400
Received: (qmail 14923 invoked by uid 107); 26 Mar 2012 18:08:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 14:08:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 14:08:02 -0400
Content-Disposition: inline
In-Reply-To: <20120326011148.GA4428@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193944>

On Sun, Mar 25, 2012 at 08:11:48PM -0500, Jonathan Nieder wrote:

> My first reaction was to suspect the series is solving the problem in
> the wrong place.  The core of the bug might be t7006 itself, which
> assumes that the shell used to interpret the GIT_PAGER setting is a
> POSIX-style shell rather than an ancient Bourne shell or cmd.exe.
> In the far long term, we should probably skip this test on some
> platforms using an appropriate test prerequisite.

I don't think that's an unreasonable assumption. Solaris /bin/sh is
really a total piece of junk, and we have already gone to lengths to let
users avoid it. We have SHELL_PATH, but we also have SANE_TOOL_PATH.
This is a case that should have been caught by SANE_TOOL_PATH, but
wasn't. So I think the problem is worth fixing, and just lets Solaris
people enjoy the same reasonable assumption about having a working shell
that other systems do.

> A second reaction was to wonder why the usual fixup from
> v1.6.4-rc0~66^2~1 (Makefile: insert SANE_TOOL_PATH to PATH before /bin
> or /usr/bin, 2009-07-08) didn't apply.  Should the git wrapper prepend
> the same magic to $PATH that git-sh-setup.sh does to make the behavior
> of scripted and unscripted commands a little more consistent?

I think that would be an OK solution, too. Though I wonder if using
SHELL_PATH isn't simply easier for the user to get right (I seem to
recall people finding SANE_TOOL_PATH confusing to set up in the past,
but I have not personally used it myself).

> A more minor comment: patch 1/2 was even more mysterious.  Combining
> the two patches would be enough to avoid confusion there.  I haven't
> checked the makefile changes and interaction with GIT-CFLAGS carefully
> yet and hope to do so in the next round.

I think they would be easier to understand squashed, too. If there were
many users of the new macro to be converted individually, I would say it
might make sense to introduce it in one commit, then convert each class
of callsites separately. But here there is really only one user, so
seeing the application can help understand the rationale for the
definition.

-Peff
