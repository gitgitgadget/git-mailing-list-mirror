From: Jeff King <peff@peff.net>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Wed, 14 May 2014 15:33:53 -0400
Message-ID: <20140514193353.GB2715@sigill.intra.peff.net>
References: <536A8FF8.7080909@fabiodalfonso.com>
 <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
 <20140508041423.GC26630@sigill.intra.peff.net>
 <536B1DF4.5080109@fabiodalfonso.com>
 <20140509155945.GG18197@sigill.intra.peff.net>
 <xmqqy4yavewk.fsf@gitster.dls.corp.google.com>
 <20140510140259.GA6836@sigill.intra.peff.net>
 <20140514101440.GA10173@sigill.intra.peff.net>
 <xmqqiop8l1zk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:34:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkewJ-0001Rn-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 21:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaENTd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 15:33:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:51605 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbaENTd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 15:33:56 -0400
Received: (qmail 10011 invoked by uid 102); 14 May 2014 19:33:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 May 2014 14:33:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2014 15:33:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiop8l1zk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248939>

On Wed, May 14, 2014 at 10:11:11AM -0700, Junio C Hamano wrote:

> A bit more disturbing is that I did not get the impression that we
> know the exact reason why these http tests, especially the getwpuid
> call, fail for Fabio when run as root.  And if my impression is
> correct, then "do not run tests as root" applied as a "solution" to
> the failure report, would merely be sweeping the problem under the
> rug, even though it is a very good advice in general.
> 
> Is it a bug in the server itself that it fails to do getpwuid, or is
> it because the system Fabio's on is somehow screwed up?

I think it's a config problem possibly coupled with an Apache bug. We
don't define the "User" directive (and I think it would be kind of crazy
to do so[1]). The default for "User" is "-1", and we see in his log that
apache was trying to getpwuid to 4294967295. However, if you don't set
User at all, and you are running as root, I would expect Apache to
continue running as root. The most I could come up with on this front
was that it's a bug in apache 1.3.22:

  http://www.gossamer-threads.com/lists/apache/users/179688#179688

but that seems like an awfully old version to have on a Natty desktop (I
checked, and it seems only to have shipped apache2). So either the bug
resurfaced, or something else is going on.

> Until the latter can be ruled out, we might be better off not doing
> anything, which may give interested parties an easier way to dig
> deeper into the real cause of getpwuid failing, no?  Such a digging
> may even result in a better solution (e.g. finding a specific
> pattern of misconfigured systems and stop tests only on them).

Sure, I have no problem with anybody digging deeper. I was mainly
worried that it would become a pain for people on such systems, as it
causes a false positive in the test suite. But we don't even know how
common such systems are, so I'm OK with waiting to see if we have more
reports.

-Peff
