From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git daemon: avoid calling syslog() from a signal handler
Date: Sat, 05 Jul 2008 00:34:04 -0700
Message-ID: <7vej68u6mr.fsf@gitster.siamese.dyndns.org>
References: <200807031400.36315.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031343440.9925@racer>
 <200807031552.26615.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031531320.9925@racer>
 <alpine.DEB.1.00.0807031624020.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 05 09:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF2Ig-0004sb-Nh
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 09:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYGEHeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYGEHeT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 03:34:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbYGEHeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 03:34:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BE701C58A;
	Sat,  5 Jul 2008 03:34:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C89441C589; Sat,  5 Jul 2008 03:34:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807031624020.9925@racer> (Johannes
 Schindelin's message of "Thu, 3 Jul 2008 16:27:24 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C64A9A94-4A64-11DD-A675-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87436>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signal handlers should never call syslog(), as that can raise signals
> of its own.
>
> Instead, call the syslog() from the master process.

Earlier parts seem to make sense but I am puzzled by these changes.

> @@ -929,7 +945,8 @@ static int service_loop(int socknum, int *socklist)
>  	for (;;) {
>  		int i;
>  
> -		if (poll(pfd, socknum, -1) < 0) {
> +		i = poll(pfd, socknum, 1);
> +		if (i < 0) {
>  			if (errno != EINTR) {
>  				error("poll failed, resuming: %s",
>  				      strerror(errno));
> @@ -937,6 +954,10 @@ static int service_loop(int socknum, int *socklist)
>  			}
>  			continue;
>  		}
> +		if (i == 0) {
> +			check_dead_children();
> +			continue;
> +		}

So you will check every 1ms to see if there are new dead children, but why
is this necessary?
