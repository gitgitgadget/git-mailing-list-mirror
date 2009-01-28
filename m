From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Windows: Fix intermittent failures of t7701
Date: Tue, 27 Jan 2009 23:28:14 -0500
Message-ID: <20090128042814.GA18216@coredump.intra.peff.net>
References: <497F076F.8060509@viscovery.net> <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS23b-0003ay-DD
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbZA1E2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZA1E2S
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:28:18 -0500
Received: from peff.net ([208.65.91.99]:59245 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbZA1E2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:28:17 -0500
Received: (qmail 18617 invoked by uid 107); 28 Jan 2009 04:28:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Jan 2009 23:28:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2009 23:28:14 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107472>

On Tue, Jan 27, 2009 at 05:42:03PM +0100, Johannes Schindelin wrote:

> > We want to catch failures of test-chmtime; but since it appears in a 
> > pipe, we cannot access its exit code. Therefore, we at least make sure 
> > that it prints time stamps of all files that are passed on its command 
> > line.
> 
> I use this trick in my valgrind series:
> 
> 	($PROGRAM; echo $? > exit.code) | $OTHER_PROGRAM &&
> 	test 0 = "$(cat exit.code)"

Oh, that's far too readable. How about:

  exec 3>&1
  status=$( ( ($PROGRAM ; echo $? >&4) | $OTHER_PROGRAM >&3) 4>&1 )
  exec 3>&-

But seriously, I think if we are talking about tests, then

  $PROGRAM >output &&
  $OTHER_PROGRAM <output

is very clear to read, and as a bonus makes "output" accessible for
viewing when the test breaks. The downside is that it isn't very
efficient for a large output, but most of our test output is small (and
we don't care that much about efficiency).

Just my shell bikeshedding 2 cents. Feel free to ignore.

-Peff
