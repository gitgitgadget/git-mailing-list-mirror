From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 06 Sep 2009 12:39:27 -0700
Message-ID: <7v3a6z3lsg.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
 <7vab191dz1.fsf@alter.siamese.dyndns.org>
 <7vzl98vrmt.fsf@alter.siamese.dyndns.org>
 <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 21:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkNc7-0000xV-8F
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 21:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbZIFTjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 15:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758203AbZIFTjg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 15:39:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758200AbZIFTjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 15:39:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3304946192;
	Sun,  6 Sep 2009 15:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QAIL9jZjZilFradLnaAKOGkLgb0=; b=Gwb2o0
	V2F+bcnNdYNddwkq3mWrUcZ0rDRWfe9Zd2YQl2PaXrF9pjFC8kf+Lye5YcAiH2cz
	51C0n0q6DgzX+9tmAsT6HG2kOq4UELPnehsqDSFTtttfY2dwZnfo4ROy0DodUqsT
	Wiw7YKI3o0FrHXcwqd2zZRYMk20jt36MR12tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XB/dimzYfS5op6jY9NiR+FmbQP0hESE8
	3UEAXLiGv9QXo5BJoQ5JM4VsVBBXZ4FwyzbN5ClkjSSIKgUQ72FtiQVtOo78SxEW
	8jVqjgqIy1EGQuWfIJMVfe3XcC8DpVy6l4v69CoBNQBk72C7FvMWS3xnhDmIjgM/
	1qyeLBIn3mY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17B4746191;
	Sun,  6 Sep 2009 15:39:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CBA7346190; Sun,  6 Sep 2009
 15:39:29 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 6 Sep 2009 11\:18\:59 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00FB24C4-9B1D-11DE-B534-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127865>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And then fix the fallout from that: callers never get mixed-up tree and 
> blob entries, and have to do their DF checking themselves.

There are two levels of internal APIs involved, and I am getting confused
as to which level of callers you are referrring to in the above.

My understanding of the current situation is:

 * unpack_trees() takes a callback from the caller in o->fn().  It
   promises (but fails to keep the promise) that the callback is called
   with entries with matching names, so that it gets to see D/F
   conflicting entries in one go.

 * traverse_trees() takes a callback from the caller in info->fn().  It
   feeds the callback the entries with the same name most of the time, but
   that is not a guarantee, and the bug we are seeing is coming from a
   caller, unpack_trees_callback(), assuming it.

Do you mean we would still keep the promise unpack_trees() makes to its
callbacks, e.g. threeway_merge(), or do you mean these callbacks are to be
prepared to get DF-split input themselves and expected to coalesce them
as necessary?

There are only two callers of traverse_trees() interface.  unpack_trees()
codepath is the primary one (the other being the merge-tree.c, which is in
disuse).

If you mean unpack_trees() by "callers, ... have to do their DF checking",
it may be a much isolated fix than what I had in mind in the last message
from me---the one that makes traverse_trees() pay attention to the caller
supplied "candiate 'earliest' name" and tries to push the "give entries
from all the trees with the same name to the callback in one go" promise
down to traverse_trees() layer.

If traverse_trees() did not do this name coalescing, on the other hand, I
wonder if it is doing only half of the job to be useful.  I do not think
of a plausible scenario where a caller, who wants to walk multiple trees
in parallel, does not want to be fed the entries with the same name from
all the input trees in one invocation of the callback it gives.

If all the callers need to do the name coalescing in order to notice the
situation that led to this bug, I wonder if it would be nicer to do so in
traverse_trees()?

unpack_trees() would of course be helped if traverse_trees() gave that
promise, and I suspect merge-tree.c::threeway_callback() would expect that
behaviour, too.
