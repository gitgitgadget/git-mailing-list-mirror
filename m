From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 15:16:28 -0400
Message-ID: <20140423191628.GA20596@sigill.intra.peff.net>
References: <20140416141519.GA9684@camelia.ucw.cz>
 <20140416154653.GB4691@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
 <20140417213238.GA14792@sigill.intra.peff.net>
 <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
 <20140417215817.GA822@sigill.intra.peff.net>
 <20140423075325.GA7268@camelia.ucw.cz>
 <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stepan Kasal <kasal@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd2ep-0007UB-EL
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729AbaDWTQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:16:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:36959 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753943AbaDWTQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:16:30 -0400
Received: (qmail 24830 invoked by uid 102); 23 Apr 2014 19:16:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 14:16:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 15:16:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246868>

On Wed, Apr 23, 2014 at 12:12:14PM -0700, Junio C Hamano wrote:

> > +ulimit_stack="ulimit -s 64"
> > +test_lazy_prereq ULIMIT 'bash -c "'"$ulimit_stack"'"'
> 
> With this implementaion, ULIMIT implies bash, and we use bash that
> appears on user's PATH that may not be the one the user chose to run
> git with.  Can't we fix both of them by using $SHELL_PATH?

I don't think so. The point is that we _must_ use bash here, not any
POSIX shell. So my $SHELL_PATH is /bin/sh, which is dash, and would not
run the test.

We want to run "some bash" if we can. We may pick a bash on the user's
PATH that is not what they put into $SHELL_PATH, but that should be
relatively rare. And the consequence is that either that bash works fine
and we run the test, or it does not, and we skip the test.

> How about doing it along this line instead?
> 
> 	run_with_limited_stack () {
> 		"$SHELL_PATH" -c "ulimit -s 64 && $*"
> 	}
> 
> 	test_lazy_prereq ULIMIT "run_with_limited_stack true"

That's a much more direct test. I like it (aside from the $SHELL_PATH
thing as described above).

-Peff
