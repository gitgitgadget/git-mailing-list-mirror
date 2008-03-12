From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Thu, 13 Mar 2008 00:28:08 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803130021520.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site> <7vwso74p33.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803122348210.1656@racer.site> <7vzlt335a5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZaNJ-00085u-A0
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYCLX2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYCLX2F
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:28:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:37565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbYCLX2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:28:03 -0400
Received: (qmail invoked by alias); 12 Mar 2008 23:28:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 13 Mar 2008 00:28:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18m2sgklLcmKv2oit372IJzGgCkPrhQ1zlQUnN8WU
	5uwuJDTnKnbMGD
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlt335a5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77024>

Hi,

On Wed, 12 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Yuck; approxidate() returns ulong.  Can subtracting a ulong from 
> >> another ever go negative?
> >> 
> >> Besides, because there is no guarantee of the order of evaluation 
> >> between these two approxidate() calls, you may get +1 or -1 on the 
> >> second boundary.
> >> 
> >> I think the reason why you did not catch it in your test is because 
> >> your tests are half complete; they test only what you wanted to catch 
> >> (misconfigured case) and do not test the other half (properly working 
> >> case).
> >
> > Yes, probably.  Of course, comparing a difference to 0 is absolutely 
> > moronic.
> >
> > I should have written
> >
> > 				approxidate(value) >= approxidate("now"))
> >
> > in the first place.
> 
> Eh, sorry, but why?

The thing is: I want to prevent invalid dates in gc.pruneExpire from going 
unnoticed, _especially_ since they would default to "now".  IOW if you 
said something like "one.weak.ago", it would actually have the same effect 
as "now" and offer _no_ grace period.

But like you said, comparing the difference of two unsigned longs to >= 0 
might be quite stupid.  Instead, I compare them _directly_.

Since I compare the value to "now" first, and only if it is not, compare 
the approxidate() of the value to the current time stamp, I can verify 
that no invalid date was specified.

Unfortunately, this check includes future dates.  Fortunately, they do not 
make sense at all.

To make my reasoning clear, how about this comment above that if() clause?

		/*
		 * In case of an invalid date, approxidate() returns the
		 * same as approxidate("now").  Since the millisecond
		 * boundary could have been crossed between the two calls
		 * to approxidate(), we compare not only for equality,
		 * but also if the former is greater than the latter.
		 *
		 * Note: this assumes that future dates are invalid, which
		 * makes sense, really.
		 */

Hmm?

Ciao,
Dscho
