From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git daemon: avoid calling syslog() from a signal handler
Date: Sat, 05 Jul 2008 23:08:35 -0700
Message-ID: <7vmykvo87w.fsf@gitster.siamese.dyndns.org>
References: <200807031400.36315.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031343440.9925@racer>
 <200807031552.26615.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031531320.9925@racer>
 <alpine.DEB.1.00.0807031624020.9925@racer>
 <7vej68u6mr.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness>
 <7vabgwtf6m.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807060337480.3557@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 08:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFNRM-0002rX-SL
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 08:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYGFGIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 02:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYGFGIn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 02:08:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYGFGIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 02:08:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 209681B2E4;
	Sun,  6 Jul 2008 02:08:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 242821B2E3; Sun,  6 Jul 2008 02:08:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807060337480.3557@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 6 Jul 2008 03:42:09 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB2FD400-4B21-11DD-8E5D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87500>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The question was not about the millisecond typo, but about why time-out 
>> at all.
>
> Because I do not want to change the semantics!
>
> ATM, in those cases where it works (as opposed to hanging!), git-daemon 
> --verbose reports in the syslog when a client disconnected, possibly with 
> an error.  It does so with a timestamp so that you can see how long the 
> connection lasted.  That is what logs are useful for.
>
> Now, syslog has timestamps at second-resolution (at least here it does), 
> and I wanted to imitate that.

Yes, we do not want to change the semantics, but that is not a reason for
an unused daemon to wake up every second, isn't it?

> The alternative would be to deprive all users of an (mostly) accurate 
> timestamp of the disconnect time.
>
>> Another way would be to set up a pipe to ourself that is included in the 
>> poll() and write a byte to the pipe from the signal handler.
>
> It still would need to break out of the poll(), in which case the effect 
> would be _exactly_ the same,...

I do not think so.

In the solution I suggested, you would set up a pipe to yourself, and give
the read end of the pipe and the accepting socket to poll() with infinite
timeout.  And when you do reap in the signal handler, you write a byte to
the write end of the pipe (and that would be the only codepath that would
write to that pipe).  That would make the pipe you are polling redable,
and allow you to break out of poll().  When poll() returns thusly, you
notice you are in that condition and read out that byte to keep the pipe
clean, and do the check_dead_children() thing.

That way, you would wake up only when you actually have something useful
to do.  Otherwise you will stay dormant, waiting for something to happen,
either by socket becoming ready to accept, or child dying and raising
SIGCHLD.

I agree that it is a bit too elaborate change that we do not want to have
in 'maint'.

Even then, for 'maint', we probably would at least want something like
this on top of your patch, so that when we know we have absolutely nothing
to do, we do not have to spin.

 daemon.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 6dc96aa..ce3a6f5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -944,6 +944,7 @@ static int service_loop(int socknum, int *socklist)
 
 	for (;;) {
 		int i;
+		int timeout;
 
 		/*
 		 * This 1-sec timeout could lead to idly looping but it is
@@ -952,7 +953,8 @@ static int service_loop(int socknum, int *socklist)
 		 * to ourselves that we poll, and write to the fd from child_handler()
 		 * to wake us up (and consume it when the poll() returns...
 		 */
-		i = poll(pfd, socknum, 1000);
+		timeout = (children_spawned != children_deleted) ? 1000 : -1;
+		i = poll(pfd, socknum, timeout);
 		if (i < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
