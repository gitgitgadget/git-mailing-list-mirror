From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Thu, 28 Feb 2008 09:52:57 -0800
Message-ID: <7vy795j7d2.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
 <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
 <200802261438.17014.lenb@kernel.org>
 <7vir0byoc2.fsf@gitster.siamese.dyndns.org>
 <7voda2yksf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271411280.19665@iabervon.org>
 <7vskzeruit.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802271605540.19665@iabervon.org>
 <7voda1nbzc.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802281026030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Len Brown <lenb@kernel.org>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUmxB-00034u-0L
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbYB1RxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 12:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbYB1RxU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:53:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYB1RxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 12:53:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 414C1195C;
	Thu, 28 Feb 2008 12:53:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5AC6C1958; Thu, 28 Feb 2008 12:53:08 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802281026030.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 28 Feb 2008 10:53:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75428>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Actually, I just realized something which should have been obvious: when 
> we reconnect, we get a list of the remote's refs, which we currently 
> discard immediately. We should actually pass this list to fetch_pack() if 
> we just reconnected, so that the client side always does the interaction 
> with the right idea of the server's refs, and discard it afterwards. The 
> fact that the user of transport_*() doesn't find out that the server 
> side's refs change in the middle of the life cycle and can't find out in 
> any way doesn't matter too much, so long as each actual connection is 
> internally consistant. (And the situation is no different from how it used 
> to be with git-fetch.sh: if you get a different mirror later, you may 
> discover that the server now doesn't have refs that it seemed to 
> advertize, but nothing weird happens.)

I think that would also be a valid way to solve this "stale idea
of what the other side has" and can replace my weatherbaloon
patch.

Another potential problem area is if find_common() does the
right thing when it is called for the second time.  I did not
check if you clear COMMON, SEEN, COMPLETE etc. bits from the
object database before initiating the second round, but if you
didn't, I am afraid these bits left over from the primary
transfer might interfere the common ancestor discovery during
the second round.

