From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Mon, 30 May 2016 23:10:08 -0700
Message-ID: <xmqqr3ci7o73.fsf@gitster.mtv.corp.google.com>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
	<89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 31 08:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7csc-0002gG-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbcEaGKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:10:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752345AbcEaGKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:10:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A9E621D8B;
	Tue, 31 May 2016 02:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yoCJ5KhuBQXfqSzvyzU4q8Yuc8w=; b=F/9mbB
	cyn2qVOsyZPxJkFWZ+VkL0ZHHk0G4PAUUEhP7UTYeods92npiR00gbG1VS5MZk/N
	mhN+GveIj575LoEmCq/CwfmjwUjyaLjOG/kdEbDrAv3pCZ0/cKak4wnto9hrgGNr
	MkUEbaz8O4rMqkEtvuV1v1CL/QM229lIlUe5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pOup6GMCFZHbpWliuhr9O17EJ1idmP2b
	Wxg412E6NfExwKb73qBJ/kPuymH0cQ5OKkN+U7iC820UyfamY0CftQybU+l0TTjQ
	2kbAYamR0JR7wYQuHrx8jSn1eQpI9Bj0y6Z+wMNjJb+8W36YojUOYVtbAjOJ9CG5
	U03KlXoTtC4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6252221D8A;
	Tue, 31 May 2016 02:10:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90A2021D89;
	Tue, 31 May 2016 02:10:10 -0400 (EDT)
In-Reply-To: <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 30 May 2016 09:55:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 54B01180-26F6-11E6-B0B4-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295954>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This commit introduces a new iteration primitive for references: a
> ref_iterator. A ref_iterator is a polymorphic object that a reference
> storage backend can be asked to instantiate. There are three functions
> that can be applied to a ref_iterator:
>
> * ref_iterator_advance(): move to the next reference in the iteration
> * ref_iterator_abort(): end the iteration before it is exhausted
> * ref_iterator_peel(): peel the reference currently being looked at

This part looked somewhat strange in that it makes "peel" sound
something very special.  Even though I understand why, it made me
feel uneasy.  I do not think of another operation like peel that may
want to have such a specialized helper, so I'll let it pass, but the
primary uneasiness I felt comes from the fact that "iterator-peel"
is not an essential service of the API that needs for correctness,
but is a pure optimization (i.e. you could grab a ref from the
normal iterator call, and then ask "please peel this ref" to the
usual ref API that does not know anything about iteration).

> Iterating using a ref_iterator leaves the flow of control in the hands
> of the caller, which means that ref_iterators from multiple
> sources (e.g., loose and packed refs) can be composed and presented to
> the world as a single compound ref_iterator.

Yes, this is a very good move.  I am happy to see us going in this
direction.
