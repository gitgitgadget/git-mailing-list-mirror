From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 16:53:18 -0500
Message-ID: <20090121215318.GA9107@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPl26-0004ph-QB
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbZAUVxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbZAUVxV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:53:21 -0500
Received: from peff.net ([208.65.91.99]:59983 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452AbZAUVxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:53:21 -0500
Received: (qmail 21886 invoked by uid 107); 21 Jan 2009 21:53:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 21 Jan 2009 16:53:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 16:53:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106685>

On Wed, Jan 21, 2009 at 09:49:14PM +0100, Johannes Schindelin wrote:

> >   A: execvp("git-foo")
> >   B: oops, "git-foo" is out of date
> >   B: rm $GIT_VALGRIND/git-foo
> >   A: look for $GIT_VALGRIND/git-foo; not there
> >   A: look for $PATH[1]/git-foo; ok, there it is
> >   B: ln -s ../../git-valgrind $GIT_VALGRIND/git-foo
> 
> Except that A had to check the link first, and it was out-of-date already 
> -- except if you changed a script into a builtin _and_ run make while a 
> valgrinded test is called _and_ you're unlucky.

Hrm, true. I consider running "make" in the middle of tests and
expecting them to work properly to be a bit crazy, so I guess this is
not a problem in practice.

I'll stop bugging you about race conditions for now, then. :)

> > readlink is not portable; it's part of GNU coreutils. Right now valgrind
> > basically only runs on Linux, which I think generally means that
> > readlink will be available (though I have no idea if there are
> > distributions that vary in this). However, there is an experimental
> > valgrind port to FreeBSD and NetBSD, which are unlikely to have
> > readlink.
> 
> As I mentioned earlier: let's bridge this bridge when we face it 
> (probably it involves making a test-readlink).

Actually, I am wrong. There is a stripped-down readlink that has
shipped with FreeBSD (since 4.10) and NetBSD (since 1.6). So while
readlink isn't portable, I think it should generally work on platforms
supported by valgrind.

> Or are you insisting that the patch should be reworked _now_ so that 
> GIT_EXEC_PATH _always_ points somewhere else?

No, I'm not insisting. It was merely a suggestion that the patch be
split into two parts so non-valgrind invocations can benefit from this
type of bug checking (and by this type I mean general PATH issues -- I
think we had some problems in the past with invoking dashed forms of
commands which were supposed to be available only via exec-path).

> I hope not, because then you break Windows.

Only if you use the same symlink technique.

-Peff
