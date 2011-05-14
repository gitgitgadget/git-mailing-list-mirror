From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] receive-pack: Add receive.denyObjectLimit to refuse
 push with too many objects
Date: Sat, 14 May 2011 03:49:59 +0200
Message-ID: <201105140349.59289.johan@herland.net>
References: <201105131854.31540.johan@herland.net> <4DCD766D.2080801@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 14 03:50:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QL3ze-0007AL-TE
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 03:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab1ENBuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 21:50:03 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49324 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab1ENBuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 21:50:01 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL500A2DX3C2V40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 03:50:00 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 542901EA5D42_DCDDFC8B	for <git@vger.kernel.org>; Sat,
 14 May 2011 01:50:00 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3B95D1EA2A6D_DCDDFC8F	for <git@vger.kernel.org>; Sat,
 14 May 2011 01:50:00 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LL500AUJX3CWR00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 14 May 2011 03:50:00 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <4DCD766D.2080801@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173570>

On Friday 13 May 2011, Johannes Sixt wrote:
> Am 13.05.2011 18:54, schrieb Johan Herland:
> > So the pack-objects on the local side dies of a broken pipe (as
> > expected), but the error message from the remote side:
> > 
> >   error: unpack failed: received pack exceeds configured
> >   receive.denyObjectLimit
> > 
> > is never printed, so the user gets no clue as to why the push failed.
> 
> The error message is printed by receive_status(), called around line 350
> in builtin/send-pack.c. But when pack-object fails, then the
> pack_objects() call around line 340 signals an error and an early-exit
> branch is taken, and receive_status() is never called.
> 
> In the test case, only a small amount of data is produced by
> pack-objects, so that it can exit successfully and quickly enough
> because the data fits into the pipe buffer. If the pack-objects process
> were scheduled differently, there is a chance that it dies from SIGPIPE
> as well. So, you are just being lucky that the test case succeeds.

Thanks for the helpful explanation!

Indeed (as Junio already suggested) it seems I must swallow and discard all 
the data sent by the client, and there's no way to easily abort the transfer 
_and_ get the error message printed on the client side. Still, I can at 
least prevent the pack from being stored server-side.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
