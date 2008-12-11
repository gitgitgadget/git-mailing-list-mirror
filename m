From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fsck segmentation fault
Date: Wed, 10 Dec 2008 18:33:20 -0800
Message-ID: <7vljunwidr.fsf@gitster.siamese.dyndns.org>
References: <200811271814.06941.simon@lst.de>
 <200811272021.56108.simon@lst.de>
 <alpine.LFD.2.00.0811271449500.14328@xanadu.home>
 <200811280919.10685.simon@lst.de>
 <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
 <20081210075338.GA7776@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Thu Dec 11 03:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAbO6-0002qL-Ko
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 03:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYLKCdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 21:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbYLKCdd
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 21:33:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbYLKCdc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 21:33:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DE6B11896E;
	Wed, 10 Dec 2008 21:33:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4E5F18965; Wed,
 10 Dec 2008 21:33:24 -0500 (EST)
In-Reply-To: <20081210075338.GA7776@auto.tuwien.ac.at> (Martin Koegler's
 message of "Wed, 10 Dec 2008 08:53:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 195CDD70-C72C-11DD-81D1-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102768>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> Maybe something like this could help:

>>From 32be177cbb0825fc019200b172f3d79117b28140 Mon Sep 17 00:00:00 2001
> From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date: Wed, 10 Dec 2008 08:42:08 +0100
> Subject: [PATCH] fsck: use fewer stack
>
> This patch moves the state while traversing the tree
> from the stack to the heap.

Hmm, after the change:

	* mark_object() marks the object as reachable, and pushes the
	  objects to the objectstack;

	* mark_object_reachable() marks the object using mark_object(),
          and repeatedly calls mark_child_object() until the objectstack
          is fully drained;

	* mark_child_object() inspects the object taken from the
          objectstack, calls fsck_walk() on it, with mark_object as the
          callback;

	  * fsck_walk() calls the callback function (i.e. mark_object) on
            the object given, and the objects immediately reachable from
            it;

            * mark_object() does not recurse, so these immediately
              reachable objects are left in the objectstack, without a
              deep recursion.
        
That seems to be what is going on, and this should be a good fix.

A similar change would be needed for other callers of fsck_walk(), no?
There seem to be one in builtin-unpack-objects.c (check_object calls
fsck_walk as itself as the callback). 

Another caller is in index-pack.c (sha1_object() calls fsck_walk with
mark_link as the callback), but I do not think it would  recurse for the
depth of the history, so we are safe there.

I initially expected that the fix would be to introduce this "userspace
work queue" (i.e. your objectstack) to be maintained on the
fsck.c:fsck_walk() side (perhaps as an extra parameter to an actual queue
for reentrancy), not by making the callee not to recurse, though.
