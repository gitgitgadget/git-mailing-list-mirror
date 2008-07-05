From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git daemon: avoid calling syslog() from a signal
 handler
Date: Sat, 5 Jul 2008 12:05:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness>
References: <200807031400.36315.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031343440.9925@racer> <200807031552.26615.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031531320.9925@racer> <alpine.DEB.1.00.0807031624020.9925@racer>
 <7vej68u6mr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 12:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF4f3-0000GC-HS
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 12:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbYGEKF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 06:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbYGEKF2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 06:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:44987 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbYGEKF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 06:05:27 -0400
Received: (qmail invoked by alias); 05 Jul 2008 10:05:24 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp068) with SMTP; 05 Jul 2008 12:05:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/z6a4nkxHzcVe9AyKCGA8Zx0oWVUTpSttBeLeKpa
	/JsD2HEj0SASSM
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vej68u6mr.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87439>

Hi,

On Sat, 5 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signal handlers should never call syslog(), as that can raise signals 
> > of its own.
> >
> > Instead, call the syslog() from the master process.
> 
> Earlier parts seem to make sense but I am puzzled by these changes.
> 
> > @@ -929,7 +945,8 @@ static int service_loop(int socknum, int *socklist)
> >  	for (;;) {
> >  		int i;
> >  
> > -		if (poll(pfd, socknum, -1) < 0) {
> > +		i = poll(pfd, socknum, 1);
> > +		if (i < 0) {
> >  			if (errno != EINTR) {
> >  				error("poll failed, resuming: %s",
> >  				      strerror(errno));
> > @@ -937,6 +954,10 @@ static int service_loop(int socknum, int *socklist)
> >  			}
> >  			continue;
> >  		}
> > +		if (i == 0) {
> > +			check_dead_children();
> > +			continue;
> > +		}
> 
> So you will check every 1ms to see if there are new dead children, but why
> is this necessary?

This comes from me not reading the man page for poll() properly.  Of 
course, I want to check every second: syslog timestamps the messages with 
a resolution of 1 second, AFAIR, or at least some of them do.

So if you could just squash in this patch, that would be smashing:

-- snipsnap --
@@ -945,8 +945,8 @@ static int service_loop(int socknum, int *socklist)
 	for (;;) {
 		int i;
 
-		i = poll(pfd, socknum, 1);
+		i = poll(pfd, socknum, 1000);
 		if (i < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
 				      strerror(errno));
