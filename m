From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Teach repack to optionally retain otherwise lost objects
Date: Wed, 28 Nov 2007 22:15:05 -0800
Message-ID: <7vaboxy3va.fsf@gitster.siamese.dyndns.org>
References: <200711181225.52288.johannes.sixt@telecom.at>
	<7v3av3wg7h.fsf@gitster.siamese.dyndns.org>
	<200711182101.53936.johannes.sixt@telecom.at>
	<7v7ikfuxfk.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711290340470.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 07:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxcgP-0007h5-8S
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 07:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXK2GPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 01:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbXK2GPN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 01:15:13 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42151 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbXK2GPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 01:15:11 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7F6012EF;
	Thu, 29 Nov 2007 01:15:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EB09F98F42;
	Thu, 29 Nov 2007 01:15:28 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711290340470.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 29 Nov 2007 03:41:42 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66505>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Besides, a completely different idea just struck me: before
> 	repacking, .git/objects/pack/* could be _hard linked_ to the
> 	forkee's object stores.  Then nothing in git-repack's code
> 	needs to be changed.
>
> 	Oh, well.  I just wasted 1.5 hours.

Your 1.5 hours was spent wisely to come up with that idea ;-).

To make sure I understand your idea correctly, the procedure to repack a
repository in a fork-friendly way is:

 (1) find the project directly forked from you;

 (2) hardlink all packs under your object store to their object store;

 (3) repack -a -l and prune.

I think that would work as long as you do the above as a unit and handle
one repository at a time.  Otherwise I think you risk losing necessary
objects when hierarchical forks are involved.  E.g.  if you have a
project X that has a fork Y which in turn has fork Z.

	* Step 1 is run for X, Y and Z.
        * Step 2 is run for Y and Z.
        * Step 3 is run for Z.

At this point, Z is still borrowing objects from Y and X through Y, and
it will not keep objects it is borrowing from X through Y.  Then if the
procedure is intermixed like this, a bad thing happens.

	* Step 2 is run for X.
	* Step 3 is run for Y.
	* Step 3 is run for X.

Step 3 for Y would lose objects Y was borrowing from X that were not
used by Y itself.  At this point, Z is still usable as the objects it is
borrowing from X though Y have not been pruned from X.  But Step 3 for X
will lose them, rendering Z unusable.
