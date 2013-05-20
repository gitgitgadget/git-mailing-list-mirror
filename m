From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 09:37:30 -0700
Message-ID: <7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 20 18:37:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeT5o-0004b1-07
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 18:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab3ETQhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 12:37:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157Ab3ETQhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 12:37:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7502020084;
	Mon, 20 May 2013 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=haa2gIdbncUfCPUH8ouUeghfvBI=; b=A9ql6x
	vCZe/nLBAc6+qew1W+8rJA04BKBlgvIj0xxeuZ7QtFLzwpJtCDuI9jEatqCLmVsQ
	S/x05KaNRcIXfG2l6e2FEfUo8neusFf/M6wLjtmqKdrYxL8TvxHYsLlA4ZOTnkSQ
	l3IwN07k4/XN+tdfNSaJct76hZTp5X2gkD3gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YzsWpYui09nHK7i0LBeoqdwaM4KJz5m9
	HrgjAVFIVuVn7OkGJsl/f1PX+pgl9hEZny3huQXZQDPjYZQPNH22JzsIIStzpXpE
	VRxTNqIo7IeNHogSCqD7BdkbV2R6AC8T61KYc0vXkQQL30Ug9tk7RXuFDtk1lHP1
	tq93a9GudDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C42B20083;
	Mon, 20 May 2013 16:37:33 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A0F22007F;
	Mon, 20 May 2013 16:37:32 +0000 (UTC)
In-Reply-To: <CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
	(Johan Herland's message of "Mon, 20 May 2013 12:28:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91C43310-C16B-11E2-B177-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224961>

Johan Herland <johan@herland.net> writes:

> For server-class installations we need ref storage that can be read
> (and updated?) atomically, and the current system of loose + packed
> files won't work since reading (and updating) more than a single file
> is not an atomic operation. Trivially, one could resolve this by
> dropping loose refs, and always using a single packed-refs file, but
> that would make it prohibitively expensive to update refs (the entire
> packed-refs file must be rewritten for every update).
>
> Now, observe that we don't have these race conditions in the object
> database, because it is an add-only immutable data store.
>
> What if we stored the refs as a tree object in the object database,
> referenced by a single (loose) ref?

What is the cost of updating a single branch with that scheme?

Doesn't it end up recording roughly the same amount of information
as updating a single packed-refs file that is flat, but with the
need to open a few tree objects (top-level, refs/, and refs/heads/),
writing out a blob that stores the object name at the tip, computing
the updated trees (refs/heads/, refs/ and top-level), and then
finally doing the compare-and-swap of that single loose ref?

You may guarantee atomicity but it is the same granularity of
atomicity as a single packed-refs file.  When you are updating a
branch while somebody else is updating a tag, of course you do not
have to look at refs/tags/ in your operation and you can write out
your final packed-refs equivalent tree to the object database
without racing with the other process, but the top-level you come up
with and the top-level the other process comes up with (which has
an up-to-date refs/tags/ part, but has a stale refs/heads/ part from
your point of view) have to race to update that single loose ref,
and one of you have to back out.

That "backing out" can be made more intelligently than just dying
with "compare and swap failed--please retry" message, e.g. you at
that point notice what you started with, what the other party did
while you were working on (i.e. updating refs/tags/), and three-way
merge the refs tree, and in cases where "all refs recorded as loose
refs" scheme wouldn't have resulted in problematic conflict, such a
three-way merge would resolve trivially (you updated refs/heads/ and
the update by the other process to refs/tags/ would not conflict
with what you did).  But the same three-way merge scheme can be
employed with the current flat single packed-refs scheme, can't it?

Even worse, what is the cost of looking up the value of a single
branch?  You would need to open a few tree objects and the leaf blob
that records the object name the ref points at, wouldn't you?

Right now, such a look-up is either opening a single small file and
reading the first 41 bytes off of it, and falling back (when the ref
in question is packed) to read a single packed-refs file and finding
the ref you want from it.

So...
