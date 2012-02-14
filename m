From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Tue, 14 Feb 2012 14:05:15 -0500
Message-ID: <20120214190515.GB12072@sigill.intra.peff.net>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org>
 <20120213203709.GA31671@ecki>
 <7vhayuctwm.fsf@alter.siamese.dyndns.org>
 <20120214092048.GC1762@ecki>
 <7vaa4l8diz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxNgr-0005JD-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759080Ab2BNTFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 14:05:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35780
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757047Ab2BNTFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 14:05:19 -0500
Received: (qmail 9194 invoked by uid 107); 14 Feb 2012 19:12:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 14:12:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 14:05:15 -0500
Content-Disposition: inline
In-Reply-To: <7vaa4l8diz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190734>

On Tue, Feb 14, 2012 at 10:40:04AM -0800, Junio C Hamano wrote:

> I do not think tilde in $PATH is expanded by exec*p family to begin with,
> so it is not "dash" but POSIX, I would think.  It is bash that is harming
> other programs, by trying to be more helpful, encouraging this user
> mistake to add ~ literally on the PATH.

Hmm. There is an interesting ramification for run-command's "use_shell"
optimization. Typically, git runs all of the user-provided commands
given to it via the shell. But if the command contains no
meta-characters, we skip the shell invocation as an optimization, since
the shell should simply be word-splitting and calling exec, and the
behavior will be identical.

But if your shell handles PATH entries differently, then there is a
difference. I.e., doing this:

  mkdir junk
  ln -s /usr/bin/vi junk/my-editor
  export PATH=~/junk:$PATH
  export GIT_EDITOR=my-editor
  git commit

might work without the optimization, but not with.

We could check PATH and disable the optimization in that case, but I
suspect it is not worth it, as:

  1. People who put a literal "~" in their PATH get what they deserve
     anyway. :)

  2. We explicitly run "sh" in such situations, not SHELL_PATH. Even if
     "sh" is bash, I believe it should look at its own argv[0] and put
     itself into a more POSIX-y mode (but I didn't test).

-Peff
