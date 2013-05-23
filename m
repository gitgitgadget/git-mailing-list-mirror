From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] gc_boundary(): move the check "alloc <= nr" to caller
Date: Thu, 23 May 2013 11:02:50 -0700
Message-ID: <7vd2shfub9.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-10-git-send-email-mhagger@alum.mit.edu>
	<7vobc4nrz8.fsf@alter.siamese.dyndns.org>
	<519DC0B7.7080401@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 20:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZqs-0003je-5O
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 20:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847Ab3EWSCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 14:02:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758722Ab3EWSCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 14:02:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72649212CA;
	Thu, 23 May 2013 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9W2KbHVoKl1n7sIuKT+6pKgfOo=; b=dkuP0x
	kNIboLkvXt4FLLfGK6MI3ky5NTdwY+4fZTdN4P2ifu5Pk113K7O4bxV+vLg6Ihu+
	4mJBJk1swKwlpszxO5cDhbIOAhOEnyssX4FQ9SViKSXz/W4AwrdU9fwTj0UF0KGe
	QnZYc/Et/WViB2XHUTChMmopv/Fg0xShca4ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOu//Bk2dF2cAjxlQNCFhScNAc2qcb/t
	lGKilYq0BauQrhzZsNPl/vcpm7GdkwkY5ZjRIIKMvjOhfRSICq7Rn+sxSg/asJ7o
	o3pSMjb3XkRTO/ToRkQzMiLun5XiNIqrV+DPap3Fjuve0o1QTEvz0X7DusCPts3D
	snOZNynqXAw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69442212C9;
	Thu, 23 May 2013 18:02:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B66C6212C7;
	Thu, 23 May 2013 18:02:51 +0000 (UTC)
In-Reply-To: <519DC0B7.7080401@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 23 May 2013 09:09:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC472486-C3D2-11E2-9438-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225276>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. The function name gc_boundary() suggests that it will do a garbage
> collection unconditionally.  In fact, it might or might not depending on
> this test.  At the caller, this made it look like a gc was happening
> each time through the loop, which made me nervous about the performance.
>  The new version makes it clear at the caller that the gc is only
> happening occasionally.

Perhaps.

> 2. Even assuming that gc_boundary() were renamed to maybe_gc_boundary(),
> the function has hopelessly little information on which to base its
> decision whether or not to gc, and the choice of policy can only be
> justified based on some implicit knowledge about how the array is grown
> and shrunk.  But the growing/shrinking is done at the layer of the
> caller, and therefore the choice of gc policy also belongs at the layer
> of the caller.
>
> 3. As you point out, if the gc policy is ever to be made more
> intelligent, then gc_boundary() is unlikely to have enough information
> to implement the new policy (e.g., it would have no place to record
> low/high water marks).  Separating concerns at the correct level would
> make a change like that easier.

These two depend on how you look at the API hierarchy.  You seem to
think that the ideal end result is

	get_revision_internal()
          have an open coded "when to gc" logic in this function
          call object_array_filter()

My suggestion was based on a different view, which is:

	get_revision_internal()
          call gc_boundary()

        gc_boundary()
          make decision on when and how to gc
          if decided to do so
            call object_array_fitler()

You can obviously rename gc_boundary() to auto_gc_boundary() if that
makes it easier to understand, but these two belong to the same
codepath that deals with the object array used specifically for
keeping track of boundary commits. I view "who has what information"
as secondary---if the decision to gc is not the primary thing
get_revision_internal() should be worrying about (and I do not think
it is), it would be a better code structure to have a helper specific
for doing so, i.e. gc_boundary(), and delegate that part of job to it.

Obviously, the caller needs to supply sufficient information to that
helper if the helper needs more than what it currently gets by
adding parameters to it, but that goes without saying.

> At the moment I am not interested in improving the gc policy of this
> code.

I am not either; the only effect we get from removing gc_boudnary()
and calling directly to object_array_filter() is to lose the above
abstraction and make it easy to let get_revision_internal() become
more cluttered when somebody else later decides to improve the gc
policy, it seems.
