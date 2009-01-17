From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/5] Fix parsing of @{-1}@{1}
Date: Sat, 17 Jan 2009 22:22:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901172214120.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de> <1232208597-29249-1-git-send-email-trast@student.ethz.ch> <1232208597-29249-2-git-send-email-trast@student.ethz.ch> <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-4-git-send-email-trast@student.ethz.ch> <1232208597-29249-5-git-send-email-trast@student.ethz.ch> <1232208597-29249-6-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901171907530.3586@pacific.mpi-cbg.de>
 <7vsknh66qu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 22:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOIda-0004pQ-KN
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 22:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702AbZAQVWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 16:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757993AbZAQVWB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 16:22:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:39123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753815AbZAQVWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 16:22:00 -0500
Received: (qmail invoked by alias); 17 Jan 2009 21:21:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 17 Jan 2009 22:21:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6bzxxzYS6mwwotn9dIheJU5I+/ItqRyZtNkRfjZ
	rHGT0soOoVm8Vs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vsknh66qu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106107>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > To do that, Git no longer looks forward for the '@{' corresponding to the
> > closing '}' but backward, and dwim_ref() as well as dwim_log() learnt
> > about the @{-<N>} notation.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	The modifications of dwim_ref() and dwim_log() are probably
> > 	more important than the issue I tried to fix...
> 
> Good, so we can say things like:
> 
> 	git log -g @{-1}
>         git show-branch -g @{-1}
> 
> with this?

I _hope_ :-)

> By the way, I noticed that without these patch series we show something 
> when "git rev-parse --verify @{-1}" is asked for.  What is it trying to 
> show?

Apparently the same as @{1.Jan}: in get_sha1_basic(), we have this code:

                /* Is it asking for N-th entry, or approxidate? */
                for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
                        char ch = str[at+2+i];
                        if ('0' <= ch && ch <= '9')
                                nth = nth * 10 + ch - '0';
                        else
                                nth = -1;
                }
                if (100000000 <= nth) {
                        at_time = nth;
                        nth = -1;
                } else if (0 <= nth)
                        at_time = 0;
                else {
                        char *tmp = xstrndup(str + at + 2, reflog_len);
                        at_time = approxidate(tmp);
                        free(tmp);
                }

So in the loop, nth is set to -1 because of a non-digit, and later, 
approxidate is called for nth == -1, which does this:

	$ ./test-date now
	now -> bad -> Thu Jan  1 01:00:00 1970
	now -> Sat Jan 17 22:21:20 2009

Ciao,
Dscho
