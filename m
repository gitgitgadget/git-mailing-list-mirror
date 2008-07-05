From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git daemon: avoid calling syslog() from a signal handler
Date: Sat, 05 Jul 2008 10:26:57 -0700
Message-ID: <7vabgwtf6m.fsf@gitster.siamese.dyndns.org>
References: <200807031400.36315.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031343440.9925@racer>
 <200807031552.26615.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031531320.9925@racer>
 <alpine.DEB.1.00.0807031624020.9925@racer>
 <7vej68u6mr.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 05 19:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFBYK-0000vX-Hd
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 19:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYGER1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYGER1G
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 13:27:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYGER1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 13:27:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2534221AF6;
	Sat,  5 Jul 2008 13:27:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6E75621AF5; Sat,  5 Jul 2008 13:26:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness> (Johannes
 Schindelin's message of "Sat, 5 Jul 2008 12:05:26 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 951168C4-4AB7-11DD-8297-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87453>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> So you will check every 1ms to see if there are new dead children, but why
>> is this necessary?
>
> This comes from me not reading the man page for poll() properly.  Of 
> course, I want to check every second: syslog timestamps the messages with 
> a resolution of 1 second, AFAIR, or at least some of them do.

Hmm.

The question was not about the millisecond typo, but about why time-out at
all.

We would need to somehow break out of poll() after handling the SIGCHLD
signal and I guess timing the syscall out would be the most obvious way,
but somehow it felt awkward.

Another way would be to set up a pipe to ourself that is included in the
poll() and write a byte to the pipe from the signal handler.
