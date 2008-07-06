From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git daemon: avoid calling syslog() from a signal
 handler
Date: Sun, 6 Jul 2008 03:42:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807060337480.3557@eeepc-johanness>
References: <200807031400.36315.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031343440.9925@racer> <200807031552.26615.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031531320.9925@racer> <alpine.DEB.1.00.0807031624020.9925@racer>
 <7vej68u6mr.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness> <7vabgwtf6m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 03:43:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFJHT-00040K-QY
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 03:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbYGFBmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 21:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbYGFBmK
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 21:42:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:51603 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753108AbYGFBmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 21:42:09 -0400
Received: (qmail invoked by alias); 06 Jul 2008 01:42:07 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp051) with SMTP; 06 Jul 2008 03:42:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nctBj2l6nxm+7W2gUINLy0MqN5Cz+x3ch9/j3nK
	IAqURPXszrSLWU
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vabgwtf6m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87483>

Hi,

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> So you will check every 1ms to see if there are new dead children, 
> >> but why is this necessary?
> >
> > This comes from me not reading the man page for poll() properly.  Of 
> > course, I want to check every second: syslog timestamps the messages 
> > with a resolution of 1 second, AFAIR, or at least some of them do.
> 
> Hmm.
> 
> The question was not about the millisecond typo, but about why time-out 
> at all.

Because I do not want to change the semantics!

ATM, in those cases where it works (as opposed to hanging!), git-daemon 
--verbose reports in the syslog when a client disconnected, possibly with 
an error.  It does so with a timestamp so that you can see how long the 
connection lasted.  That is what logs are useful for.

Now, syslog has timestamps at second-resolution (at least here it does), 
and I wanted to imitate that.

The alternative would be to deprive all users of an (mostly) accurate 
timestamp of the disconnect time.

> Another way would be to set up a pipe to ourself that is included in the 
> poll() and write a byte to the pipe from the signal handler.

It still would need to break out of the poll(), in which case the effect 
would be _exactly_ the same, but with a lot of more trouble, and 
opportunities for me to bring in new bugs, right?

Ciao,
Dscho
