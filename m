From: Paolo Bonzini <bonzini@gnu.org>
Subject: [RFT PATCH 0/2] win32: optimize emulation of condition variables
Date: Mon,  7 Jun 2010 15:38:10 +0200
Message-ID: <1275917892-16437-1-git-send-email-bonzini@gnu.org>
Cc: j.sixt@viscovery.net
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 15:38:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLcX2-00077y-QF
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 15:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab0FGNiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 09:38:16 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:55378 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab0FGNiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 09:38:16 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.69)
	(envelope-from <bonzini@gnu.org>)
	id 1OLcWs-0004td-Kz; Mon, 07 Jun 2010 09:38:14 -0400
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148595>

I recently looked at git's condvar implementation for use in another
project, and found a couple of simple optimization opportunities.
We can drop the waiters_lock, and we can make broadcast asynchronous
if it is waking up only one thread.

I made two simple tests:

- 1 thread sending a broadcast every 10 msec, 10 threads calling
  pthread_cond_wait every 100 msec.  Timings are (average of three runs):

  before     2.094 us/wait      4.015 us/broadcast
  after      2.064 us/wait      2.883 us/broadcast

  i.e. most broadcasts and waits hit the fast path, the few that don't
  likely avoid the rendez-vous after the patch.  In this case the
  waiters_lock is always hitting its own fast path.  The speedup is
  mostly in broadcast, and comes mostly from the second patch.

- 1 thread sending a broadcast every 100 msec, 10 threads calling
  pthread_cond_wait every 10 msec.  Timings are:

  before     17.59 us/wait      192.2 us/broadcast
  after      8.959 us/wait      141.1 us/broadcast

  i.e. most broadcasts hit the slow path, and there will be also high
  contention on waiters_lock after the broadcast.  In this case the
  speedup comes from avoiding locks in the first patch.


I have tested this patch quite thoroughly outside git, but not as part
of it.  So help with that would be appreciated.

Thanks,

Paolo

Paolo Bonzini (2):
  win32: optimize condition variable implementation
  win32: optimize pthread_cond_broadcast

 compat/win32/pthread.c |   71 +++++++++++++++++++++++++----------------------
 compat/win32/pthread.h |    1 -
 2 files changed, 38 insertions(+), 34 deletions(-)
