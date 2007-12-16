From: David Brown <git@davidb.org>
Subject: Re: [PATCH] threaded pack-objects: Use condition variables for
	thread communication.
Date: Sun, 16 Dec 2007 11:18:28 -0800
Message-ID: <20071216191828.GA5446@old.davidb.org>
References: <200712160018.54171.johannes.sixt@telecom.at> <20071216120558.GA4999@xp.machine.xx> <200712161941.38109.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:19:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3z0v-0007rr-Lb
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 20:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbXLPTSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 14:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbXLPTSh
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 14:18:37 -0500
Received: from mail.davidb.org ([66.93.32.219]:39165 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbXLPTSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:18:37 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J3z0O-0001U1-R6; Sun, 16 Dec 2007 11:18:28 -0800
Mail-Followup-To: Johannes Sixt <johannes.sixt@telecom.at>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <200712161941.38109.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68478>

On Sun, Dec 16, 2007 at 07:41:37PM +0100, Johannes Sixt wrote:
>On Sunday 16 December 2007 13:05, Peter Baumann wrote:
>> On Sun, Dec 16, 2007 at 12:18:53AM +0100, Johannes Sixt wrote:
>> > +
>> > +		progress_lock();
>> > +		me->working = 0;
>> > +		progress_unlock();
>> > +		pthread_cond_signal(&progress_cond);
>>
>> Shouldn't the pthread_cond_signal be inside the lock?
>> e.g. swap progress_unlock() with pthread_cond_signal(&progress_cond)
>
>No, that's not necessary. Both ways are correct, but if it's outside the lock 
>there is less contention on the mutex (because the waiting thread must 
>acquire the mutex lock before it can return from pthread_cond_wait).

The signal needs to be before the unlock if is more than one signaller.
Since normal usage has the signal inside of the lock, most implementations
should do this efficiently.

Dave
