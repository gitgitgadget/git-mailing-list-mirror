From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git daemon: avoid calling syslog() from a signal
 handler
Date: Sun, 06 Jul 2008 18:50:02 -0700
Message-ID: <7vmykua2et.fsf@gitster.siamese.dyndns.org>
References: <200807031400.36315.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031343440.9925@racer>
 <200807031552.26615.brian.foster@innova-card.com>
 <alpine.DEB.1.00.0807031531320.9925@racer>
 <alpine.DEB.1.00.0807031624020.9925@racer>
 <7vej68u6mr.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness>
 <7vabgwtf6m.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807060337480.3557@eeepc-johanness>
 <7vmykvo87w.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0807061414320.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 03:51:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFfsk-0007nF-Qo
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 03:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYGGBuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 21:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbYGGBuM
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 21:50:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbYGGBuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 21:50:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 80F8023EFB;
	Sun,  6 Jul 2008 21:50:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D2C1223EF8; Sun,  6 Jul 2008 21:50:04 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807061414320.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Sun, 6 Jul 2008 14:23:20 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07F6AD80-4BC7-11DD-9197-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87572>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Note that we still have to check for dead children in 
> 	check_max_connections(), and since child_handler() knows nothing 
> 	about that, it still will write to the pipe, waking up the loop 
> 	unnecessarily.
>
> 	But that will be rare.
>
> 	This is no longer as trivial as I wanted it to be, so I'd 
> 	appreciate a few eyeballs on this patch.

Yeah, I think the fix-up I sent on top of your patch to make 1-sec timeout
conditional would be more appropriate for 'maint' than this one, even
though it is a band-aid to the issue.

Another thing we might want to consider to make this logic much more
simpler would be to move everything out of child_handler(), except the
write() whose sole purpose is to allow us break out of the poll().

Then you do not have to use "negative is error and positive is success"
convention (which you may regret later when you would need to pass more
than one bit of information from the callsite of waitpid() to the callsite
of syslog()), nor separate "reap here, report there" code structure.
