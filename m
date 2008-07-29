From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 19:49:45 -0700
Message-ID: <7vy73lmmk6.fsf@gitster.siamese.dyndns.org>
References: <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
 <20080726153802.GA16868@blimp.local>
 <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
 <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org>
 <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org>
 <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org>
 <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
 <20080729014120.GA26807@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 04:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNfIe-0007Qs-US
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYG2Ct4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYG2Ct4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:49:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbYG2Ct4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:49:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B430B4151E;
	Mon, 28 Jul 2008 22:49:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 29F1A4151A; Mon, 28 Jul 2008 22:49:46 -0400 (EDT)
In-Reply-To: <20080729014120.GA26807@old.davidb.org> (David Brown's message
 of "Mon, 28 Jul 2008 18:41:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0601056C-5D19-11DD-BCFA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90555>

David Brown <git@davidb.org> writes:

> On Mon, Jul 28, 2008 at 06:31:24PM -0700, Junio C Hamano wrote:
>>Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> The kernel does caching really well, and the kernel is fast as
>>> hell, so _of_course_ when you benchmark, using kernel data
>>> structures looks good, especially if you benchmark against code
>>> that isn't well written for the particular usage case.
>>
>>Ok.  While I have your attention on st_ctime, let me ask you a stupid
>>question.  Why does "rename(old, new)" change st_ctime when you move a
>>regular file?
>
> A simple answer might be that posix requires it.

I would understand that an obvious implementation would be to link to new
and then unlink the old, and the link count of the moved entity needs to
change (although in the end, the increment and decrement would cancel out)
in each step, so it would be convenient for the implementation to update
ctime in both steps; however my reading of POSIX does not seem to require
it.

The only mention of ctime I find is about updating the parent directories
of old and new, as contents of both change so do their mtime and ctime
obviously need to change.  But it does not talk about ctime of the entity
being moved.

Additionally, the only way rename(2) is described to fail with EMLINK is
when renaming an directory and the parent of the new location cannot have
any more links; which implies that it does not have to fail if the first
step of link+unlink overflows the link count of old.

Ah, I found in the informative Application Usage section that this is
implementation dependent.

Sorry for the noise.
