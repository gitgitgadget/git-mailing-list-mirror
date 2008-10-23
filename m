From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/5] add valgrind support in test scripts
Date: Thu, 23 Oct 2008 11:29:23 -0400
Message-ID: <20081023152922.GB10804@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net> <20081022202915.GA4547@coredump.intra.peff.net> <alpine.DEB.1.00.0810230008430.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7v7i80tber.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 17:31:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt291-0004j4-1n
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 17:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYJWP3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 11:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbYJWP3Z
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 11:29:25 -0400
Received: from peff.net ([208.65.91.99]:3328 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbYJWP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 11:29:25 -0400
Received: (qmail 10276 invoked by uid 111); 23 Oct 2008 15:29:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 11:29:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 11:29:23 -0400
Content-Disposition: inline
In-Reply-To: <7v7i80tber.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98972>

On Wed, Oct 22, 2008 at 05:14:52PM -0700, Junio C Hamano wrote:

> > I wonder if it would not be better to scrap the t/valgrind/ directory and 
> > regenerate it everytime you run a test manually; I'd use "ln" instead of 
> > "cp", and also parse command-list.txt to catch really all of them (even if 
> > a dashed form is used for a builtin by mistake).
> 
> Going one step further, I wonder if this approach can also be used to
> catch such a mistake.  Install a dashed form that records the fact that it
> was called when it shouldn't, and by whom.

I think that makes sense, though it is somewhat orthogonal to valgrind.
Do we want to always set up such a fake path? It could actually be even
simpler than a wrapper; just stop adding the build directory to the
PATH, and instead have a pseudo-installation directory with the bin and
exec-path directories set up appropriately. This would more closely
model the actual installation.

I think there are actually several classes of dashed commands we need to
differentiate:

 1. dashed commands which get installed in bin; these should be allowed

 2. dashed commands which don't get installed in bin; these should be
    flagged as an error

 3. dashed commands in exec-path which are stand-alone C programs. These
    should be run under valgrind.

 4. dashed commands in exec-path which are scripts. These do get run,
    but should not be run under valgrind.

 5. dashed commands in exec-path which are builtins. These should never
    get run by our test scripts, since they are "legacy" links for people
    who want to put the exec-path in their PATH

Right now we always point PATH at the build directory, which has
everything. So we can't easily differentiate between '1' and '2'. I used
the $(PROGRAMS) variable in the Makefile to find '3' (as opposed to '4'
and '5').

-Peff
