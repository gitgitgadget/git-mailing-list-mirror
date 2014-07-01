From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] paint_down_to_common: use prio_queue
Date: Tue, 01 Jul 2014 09:23:21 -0700
Message-ID: <xmqqionhxd3a.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625233952.GC23146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:23:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X20qF-0000H7-7m
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 18:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758304AbaGAQXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 12:23:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61773 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758297AbaGAQXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 12:23:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 537EF24C36;
	Tue,  1 Jul 2014 12:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=08rxAYHXCuGyBVtemXIJve3d++4=; b=qMuy9G
	3mzDnhjEvFn6SciKgm+2+c3XQaJ1ml22KIfa0Mio18j2fccxnw/ZReX3Fs0QGvFz
	bNhxxIPx51oxLnI8o/a0Xj4JGsWAVdkLGZQQ5SsCm4Mh9QiYzDdEJUVUE/n0YyNC
	uRmtSNrQHtSOlKR766Xu+iom00VUn6Hly2UMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b21Vy9lEqKpN9KANmKu00aq2IEZuVw9S
	K7VFk3W761OtSRbwNKUX/HE4lMLGL3JqCpOm/86rFm6sqzdfRoG1kqmxOXR3KMD1
	tH8Z4WH2wPQ6GG3uQIzXMuzY4Nv+OeIZ4CM0/o+BGBUaZ6u4/HRCcldF3SKgQIII
	vY3iy+D8aGk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A90024C35;
	Tue,  1 Jul 2014 12:23:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DB6E24C29;
	Tue,  1 Jul 2014 12:23:12 -0400 (EDT)
In-Reply-To: <20140625233952.GC23146@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Jun 2014 19:39:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF4D8C54-013B-11E4-B457-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252722>

Jeff King <peff@peff.net> writes:

> The downside is that our priority queue is not stable, which
> means that commits with the same timestamp may not come out
> in the order we put them in. You can see this in the test
> update in t6024. That test does a recursive merge across a
> set of commits that all have the same timestamp. For the
> virtual ancestor, the test currently ends up with blob like
> this:
>
>     <<<<<<< Temporary merge branch 1
>     <<<<<<< Temporary merge branch 1
>     C
>     =======
>     B
>     >>>>>>> Temporary merge branch 2
>     =======
>     A
>     >>>>>>> Temporary merge branch 2
>
> but with this patch, the positions of B and A are swapped.
> This is probably fine, as the order is an internal
> implementation detail anyway (it would _not_ be fine if we
> were using a priority queue for "git log" traversal, which
> should show commits in parent order).

Interesting that the queue is not "stable", but the test can still
rely on a fixed output.  While I tend to agree that for the purpose
of this code path, the order is an internal implementation detail,
but I wonder if it would benefit us a lot if we taught prio-queue to
be optionally more "stable", which would allow us to use it in other
code paths that care.  If we really wanted to, I would imagine that
we could keep the "insertion counter" in the elements of the queue
to make the result stable (i.e. the "void **array" would become
something like "struct { int insertion_ctr; void *thing; } *array").

> I'm slightly hesitant because of the stability thing mentioned above. I
> _think_ it's probably fine. But we could also implement a
> stable_prio_queue on top of the existing prio_queue if we're concerned
> (and that may be something we want to do anyway, because "git log" would
> want that if it switched to a priority queue).

Heh, I should have read the below-three-dashs commentary before
commenting (I often start working from the commit messages in "git
log" and then go back to the original thread).
