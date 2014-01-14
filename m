From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] blame: new option --prefer-first to better handle merged cherry-picks
Date: Tue, 14 Jan 2014 11:12:21 -0800
Message-ID: <xmqqr48a4bu2.fsf@gitster.dls.corp.google.com>
References: <20140113063008.GA3072@client.brlink.eu>
	<xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
	<20140113225229.GA3418@client.brlink.eu>
	<xmqqbnzf5vvu.fsf@gitster.dls.corp.google.com>
	<xmqq7ga35qdd.fsf@gitster.dls.corp.google.com>
	<7va9ez0xji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Tue Jan 14 20:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W39Ps-0008EH-4F
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 20:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaANTMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 14:12:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbaANTMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 14:12:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 978A662DEC;
	Tue, 14 Jan 2014 14:12:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LNxQRKZpk/LnnraCH3SOtN32Lv0=; b=XxnIP4
	v2HI+e4l1FIirsFiX4xOSf32x7EujVOaWC4U6c1NaulUPtYKo5ZfzWXyfsEaqX8H
	cagi6tcXo1KE1LysRKkMGeUB4kqHw9SX5XbDSdyiQsNYnFM5XsFl3O8rVSXzqPRp
	YqfFzXhNMJG1YO0WcLH3YnGG++Enus+ijwsDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+dSniQ5m1Qeo1walXBw1d2brZWYirfD
	XvLgDZLCT/2ZfAvl9rP3ctvoHYpKWQ+rxkP5TZPkO3b36KsZx0DZaMQFYBvEuoGI
	lkuVEJDh+DH0rJpshe/cN4QAGrDb63Urdg04QAoujeqvEKUtzBkZpRGHZBx4zUgw
	UgZomC2eRyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401A662DE5;
	Tue, 14 Jan 2014 14:12:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6DF862DD6;
	Tue, 14 Jan 2014 14:12:31 -0500 (EST)
In-Reply-To: <7va9ez0xji.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 14 Jan 2014 00:37:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D15B1B24-7D4F-11E3-A559-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240407>

Junio C Hamano <gitster@pobox.com> writes:

> The "pick the one that exactly matches if exists" can be thought of
> an easy hack to hide the problems that come from this arbitrary
> choice.  ...
> Instead, "pass the whole blame to the one that exactly matches" hack
> keeps larger blocks of text unsplit, clumping related contents
> together as long as possible while we traverse the history.
>
> It is an "easy hack", because we only need to compare the object
> name, but a logical extension to it would have been to compute the
> similarity scores between the result and each of the parents, sort
> the parents by that similarity score order, and give more similar
> ones a chance to claim responsibility before less similar ones.
> We could call it "favouring similar ones", i.e. "--prefer-similar"
> or something.

Extending along the tangent further.

Another thing that I found the argument in the proposed log message
of the patch weak was that the claim that changed code will assign
the blame to the "same" commit for both path b and c.  There are two
reasons why.  One is that we do not look at b while chasing the
ancestry of c, so if a different traverse order assigns the blame to
the same commit for them, it is a mere happenstance.  But a more
important reason is that the changed code will still assign the
blame for "different" commits if the final merge were made in the
opposite direction.  In your original topology, we skip over the
first parent and give the whole blame to the second parent without
the change, and with the change, we stop doing so and instead give
some blame to the first parent and then allow the second parent a
chance to claim the blame for the remainder.  But in a history where
the final merge went in the opposite direction, even with the
change, we compare with the "first" parent (which was the "second"
one in your original topology) with the result, find out that the
contents exactly match, and that parent grabs the whole blame.  So
in that sense, the updated code that "consistently" gives earlier
parents chance to claim the blame before later ones does not behave
consitently on the same history with different merge parent order.

That makes me think that the reason why the result you got with the
change is better (assuming it is better) is _not_ because the
updated code lets earlier parents give chance to claim the blame; it
could be an indication that the "keep larger blocks of text unsplit,
clumping related contents together as long as possible" heuristics
is what prevents us from having a better result.

If that is really the case, that would mean that letting the blame
split early would give us a better result.  I alluded to "give more
similar parents first chance to claim responsibility before less
similar ones" in the previous message, but perhaps this is
indicating that we might get a better result if we did the
opposite---instead of assigning blames to earlier parents and then
to later ones, compare the result with each parent, order the
parents by how few lines of blame they could claim if each of them
were allowed to go first, and then actually compute and assign the
blame in that order, "favouring dissimilar ones".  That may produce
the result you are after in a more consistent way, regardless of the
merge order.

I think I've done thinking about this issue, at least for now.
