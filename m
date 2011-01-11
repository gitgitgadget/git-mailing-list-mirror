From: Jeff King <peff@peff.net>
Subject: Re: git-config does not check validity of variable names
Date: Tue, 11 Jan 2011 00:59:22 -0500
Message-ID: <20110111055922.GD10094@sigill.intra.peff.net>
References: <20110108144644.GA11019@localhost.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jan 11 06:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcXGV-0004hY-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 06:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab1AKF70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 00:59:26 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab1AKF7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 00:59:25 -0500
Received: (qmail 11408 invoked by uid 111); 11 Jan 2011 05:59:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 11 Jan 2011 05:59:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jan 2011 00:59:22 -0500
Content-Disposition: inline
In-Reply-To: <20110108144644.GA11019@localhost.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164911>

On Sat, Jan 08, 2011 at 03:46:44PM +0100, Libor Pechacek wrote:

> I've noticed that git-config accepts variable names in the form "a=b" for its
> "get" operation.  That means "git config a=b" does not write anything to its
> output and exists with status 1.
> 
> According to the man page only alphanumeric characters and - are allowed in
> variable names.  Would it make sense to spit out an error message when the user
> supplies an invalid variable name like the above?

Probably. The current behavior isn't all that terrible, in that it
simply tries to look up the key, which of course doesn't exist (because
it cannot syntactically), and does signal an error (with the exit code).
So it is in some ways no worse than a typo like "git config
color.dif.branch". And we probably don't want to start writing to stderr
in such a case, as scripts assume they can call git config to find out
whether the variable is defined without having to redirect stderr.

That being said, I can see how the lack of a message could be confusing
for a user who mistakenly thinks "git config color.diff.branch=red"
should work. So I think a patch to make that better would get a
favorable response.

Note, though, that what you wrote above is not strictly true. The
manpage says variable names and section names must be alphanumeric. But
subsection names can contain any character except newline. So it is
valid syntactically to do:

  git config color.diff=red.branch

where the subsection contains the "=". Obviously this example is
nonsense, and in practice most such "a=b" forms will end up not being
syntactically valid (because the = will be part of the variable name,
not the subsection). But if you are going to write a patch, you need to
make sure not to accidentally disallow:

  git config 'diff.my custom diff driver.command'

-Peff
