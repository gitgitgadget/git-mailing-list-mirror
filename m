From: Junio C Hamano <gitster@pobox.com>
Subject: [rfh] do I need to use something more complex to do this?
Date: Wed, 10 Apr 2013 07:40:18 -0700
Message-ID: <7vk3oao3e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 16:40:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPwCL-0000Kk-4z
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 16:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898Ab3DJOkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 10:40:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760638Ab3DJOkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 10:40:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 179A512AE0;
	Wed, 10 Apr 2013 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	jgFcHHZicyOgzWlmVcRaF/zRiw=; b=R0z9whFs7Pj2pDFQINf+DmnrvUmWfPj4C
	z3z3CbDS1Ynd8k+plWfl3QwXEque+r80HF+WCwD2sLRyATh2TIxmp7fqO15hFBwE
	BAWmZo4jKKN+t2/1Ms60JM+yeX2TdmH4nqitdOL6Loykf6G55Iow+0SwGWe0VYhB
	Dpt2GDukkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=SYP
	gM8u3mSNNqhJtddRO4/XVYkj0YbaEJk5Iw5BnLaTF1bZG8+wLjds9/P7VFSE8dsN
	gWPTClanRchREvMaoMkN9Qnn48oPgnHI1j7R/Y7ts/rNuSDXtMBbT1WNDQygFbwi
	1aiqlW7w7vx+2aezL+JwAltrhDaNx+Qex8Dn67i0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CB7112ADE;
	Wed, 10 Apr 2013 14:40:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E9ED12ADD; Wed, 10 Apr
 2013 14:40:20 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91DB2ECE-A1EC-11E2-AE4E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220692>

I have set of items with two attributes, <X,Y>, and would like to
keep them in some data structure in such a way that it is efficient
to (1) add a new item to the data structure, and (2) pick an item in
a specific order. There can be multiple items that share the same
value for X, or Y, or both X and Y, and it does not matter in what
order items comes out among those that share the same <X,Y>.

The type of X is totally ordered. The type of Y also usually is, but
Y can take a special value U(nspecified).

Now on to the "specific" order I want to pick an item.  I'd like to
take the item with the largest value of Y in general, and tiebreaking
on the value of X which also I prefer to take from larger to smaller.

But with a twist.

When I am picking an item <X=n,Y=m>, there should be no item
remaining in the data store with a value of Y that is smaller than m
(duplicates are allowed, so there can still be items with Y=m), and
also when I am picking <X=n,Y=m>, there should be no item with
Y=Unspecified that has a value of X that is equal or smaller than n.

E.g. if I have these 6 items (ignore the lines between the items for
now):

            <104,U>--<105,U>--<106,4>
           /
    <101,U>--<100,U>--<102,3>--<104,4>

I would want to pick them up in this order:

    <106,4> <105,U> <104,U> <104,4> <102,3> <101,U> <100,U>

I see how this can easily be done by using a two priority lists,
i.e. one for items with Y=Unspecified that is sorted by X, and the
other for all other items that is sorted by <Y,X>. Peek the top of
both, and pick the top of the former until its X is smaller than the
value of X of the top of the latter, otherwise pick the top of the
latter.  I am wondering if I can use less complex data structure,
like a single ordered sorted array, with a clever comparison
function.

For the curious, the items in the above picture represents commits,
and lines are ancestry chains between them. I am thinking how we can
extend the still_interesting() function with an optional generation
number.
