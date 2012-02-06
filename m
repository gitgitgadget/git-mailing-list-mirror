From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] perl/Makefile: use 'installsitelib' even with
 NO_PERL_MAKEMAKER
Date: Mon, 6 Feb 2012 15:26:10 -0500
Message-ID: <20120206202610.GC30776@sigill.intra.peff.net>
References: <24482D02-B773-4FE3-8FC7-92B8B4D8C0FA@spotify.com>
 <7328033C-8A11-452D-A927-E81E2DC4ABD6@spotify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicholas Harteau <nrh@ikami.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuV8j-0006ox-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab2BFU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:26:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58938
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab2BFU0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 15:26:12 -0500
Received: (qmail 30745 invoked by uid 107); 6 Feb 2012 20:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 15:33:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 15:26:10 -0500
Content-Disposition: inline
In-Reply-To: <7328033C-8A11-452D-A927-E81E2DC4ABD6@spotify.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190097>

On Mon, Feb 06, 2012 at 02:38:20PM -0500, Nicholas Harteau wrote:

> > perl/Makefile installs Git.pm into $prefix/lib when ExtUtils::MakeMaker
> > is not present.  perl can't "use Git;" in that scenario, as $prefix/lib
> > isn't in perl's include path.
> > 
> > This patch installs Git.pm into perl's 'installsitelib', generally
> > $prefix/lib/perl5/site_perl, so that even when ExtUtils::MakeMaker isn't
> > present, Git.pm gets installed in a location where 'use Git;' just
> > works.
> [...]
> > ifdef NO_PERL_MAKEMAKER
> > -instdir_SQ = $(subst ','\'',$(prefix)/lib)
> > +instdir_SQ = $(subst ','\'',$(subst installsitelib=,'',$(shell $(PERL_PATH_SQ) -V:installsitelib)))

Isn't this a regression if I am a non-root user installing into
$HOME/local or similar? With MakeMaker, I end up with this in my
perl.mak:

  PREFIX = /home/peff/local
  ...
  SITEPREFIX = $(PREFIX)
  ...
  INSTALLSITELIB = $(SITEPREFIX)/share/perl/5.14.2

which works great.  Before your patch, without MakeMaker, git would
install into /home/peff/local/lib, which is also OK. But with your
patch, it will try:

  $ perl -V:installsitelib
  installsitelib='/usr/local/share/perl/5.14.2';

which is not writable by me, and the install will fail.

I know it's more convenient for some uses, because we know that
installsitelib will be in perl's @INC. But git has always installed out
of the box for non-root users, and I don't think we want to change that.

-Peff
