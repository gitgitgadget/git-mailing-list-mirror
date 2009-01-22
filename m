From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Wed, 21 Jan 2009 19:59:01 -0500
Message-ID: <20090122005901.GA10826@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <7vr62wb28h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 02:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPnvs-0004Ug-0s
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 02:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbZAVA7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 19:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZAVA7G
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 19:59:06 -0500
Received: from peff.net ([208.65.91.99]:48265 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbZAVA7G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 19:59:06 -0500
Received: (qmail 22931 invoked by uid 107); 22 Jan 2009 00:59:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 21 Jan 2009 19:59:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 19:59:01 -0500
Content-Disposition: inline
In-Reply-To: <7vr62wb28h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106711>

On Wed, Jan 21, 2009 at 04:42:22PM -0800, Junio C Hamano wrote:

> > Fact is: every test script will check $GIT_VALGRIND/bin/ for 
> > up-to-dateness first.  Before running any Git command.
> 
> Hmm, is that a good thing in general?  Can't makefile rules be arranged in
> such a way that one "valgrind-prep" target runs before all the potentially
> parallel executions of actual tests begin?

You have to choose either "everybody does this setup, whether they want
--valgrind or not" which is what my original patch did, or doing it
inside test-lib.sh. Because we don't know we want --valgrind until we
get into the individual scripts.

I suppose one could try parsing GIT_TEST_OPTS in the Makefile, but that
seems a bit hack-ish.

But I like putting it into test-lib.sh; yes, it is a little more CPU
time for each script, but it is negligible compared to running the
actual tests (especially since you only pay when running with
--valgrind, which makes the actual tests very expensive). But it is much
easier to be sure it is _correct_ when you run the test, especially if
you tend to run the test script directly.

> Independent from the above, I suspect that some of the existing tests
> cannot run in parallel; I haven't really looked at any of them, but a
> server-ish tests to open a local port and test interaction with client
> obviously need to either use different ports or serialize.  Perhaps we
> need a way to mark some tests that cannot be run in parallel even under
> "make -j"?

I think the only culprits are http-push and a few SVN tests. The
http-push test starts a server on a specific port, but because it is the
only script which uses that port, it is fine. It looks like a few
different SVN tests start an httpd server (9115, 9118, and 9120), which
could potentially interact badly. I've never had a problem running with
"-j4", but I don't have svn installed, so I always end up skipping those
tests.

It looks like both the http-push and svn tests are set up to take an
arbitrary port as input. Perhaps the simplest thing would be for each of
the svn tests to pick a different port so that they can be run
simultaneously.

-Peff
