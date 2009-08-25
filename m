From: Jeff King <peff@peff.net>
Subject: Re: hitting home directory's parent
Date: Tue, 25 Aug 2009 00:42:36 -0400
Message-ID: <20090825044236.GA13738@coredump.intra.peff.net>
References: <20090821200503.GA19660@panix.com>
 <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com>
 <20090822150542.GA29507@panix.com>
 <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
 <20090822181607.GA25823@coredump.intra.peff.net>
 <fcaeb9bf0908222107i6d999335r998a304aaa3cd405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Convissor <danielc@analysisandsolutions.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 06:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfnsO-0003a2-73
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 06:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZHYEmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 00:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbZHYEmh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 00:42:37 -0400
Received: from peff.net ([208.65.91.99]:47675 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbZHYEmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 00:42:36 -0400
Received: (qmail 13769 invoked by uid 107); 25 Aug 2009 04:42:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 00:42:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 00:42:36 -0400
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0908222107i6d999335r998a304aaa3cd405@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126996>

On Sun, Aug 23, 2009 at 11:07:39AM +0700, Nguyen Thai Ngoc Duy wrote:

> It is (and should be worked around with GIT_CEILING_DIRECTORIES).
> Unfortunately in my test, it could not chdir() back when it failed to
> find gitdir. chdir() was called with an absolute directory, and one
> directory in that path was inaccesible, leading another die("Cannot
> come back to cwd"). This one is fatal and should not be ignored. I
> don't know whether having an inaccesible parent directory is a real
> scenario, as lots of tools would break.

Hmm, good point. Some of those die()s really can't be removed, because
we have munged state in a way that can't be recovered (or is hard to
recover).

Also, thinking about it a bit more, I'm not sure it is correct to turn
such a die() into a "return -1" without passing more information along
to the caller. Because there are really three possible outcomes:

  1. we are in a git repo
  2. we are not in a git repo
  3. some error occurred and we could not determine which
     of (1) and (2) is the case

And the "gently" bit really just refers to (1) versus (2). It is
tempting to fold (3) into (2), but I'm not sure that is the right thing
to do; some callers (including script callers not under our control) may
care about the distinction (though I think we already blur it; for
example, a non-existent '.git' regular file is treated the same as one
which we couldn't stat for permission problems).

So perhaps the right thing is to either pass back a tri-state status, or
to have an extra_gently mode, either of which could be used by "git
help".  The problem with either is that the current setup process is not
amenable to exiting in the middle -- it really may leave us in a weird
and buggy state due to the chdir.

So short of major surgery on the setup procedure, I think we may have to
leave this bug be for now (especially because I'm not convinced the
setup of a non-executable parent directory isn't a little bit crazy).

-Peff
