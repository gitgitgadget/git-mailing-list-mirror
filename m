From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] threaded pack-objects: Use condition variables for thread communication.
Date: Sun, 16 Dec 2007 19:41:37 +0100
Message-ID: <200712161941.38109.johannes.sixt@telecom.at>
References: <200712160018.54171.johannes.sixt@telecom.at> <20071216120558.GA4999@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:42:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3yRF-0003F1-By
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 19:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbXLPSlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbXLPSlq
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 13:41:46 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:46612 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbXLPSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 13:41:46 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 9187B98159;
	Sun, 16 Dec 2007 19:41:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B99EE59A65;
	Sun, 16 Dec 2007 19:41:38 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <20071216120558.GA4999@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68476>

On Sunday 16 December 2007 13:05, Peter Baumann wrote:
> On Sun, Dec 16, 2007 at 12:18:53AM +0100, Johannes Sixt wrote:
> > +
> > +		progress_lock();
> > +		me->working = 0;
> > +		progress_unlock();
> > +		pthread_cond_signal(&progress_cond);
>
> Shouldn't the pthread_cond_signal be inside the lock?
> e.g. swap progress_unlock() with pthread_cond_signal(&progress_cond)

No, that's not necessary. Both ways are correct, but if it's outside the lock 
there is less contention on the mutex (because the waiting thread must 
acquire the mutex lock before it can return from pthread_cond_wait).

-- Hannes
