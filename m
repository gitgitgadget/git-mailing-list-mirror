From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] sort-in-topological-order: use commit-queue
Date: Mon, 10 Jun 2013 00:27:31 -0700
Message-ID: <7vsj0ql924.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-4-git-send-email-gitster@pobox.com>
	<7vehcan9e0.fsf@alter.siamese.dyndns.org>
	<20130610053059.GE3621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwVx-0001Wk-9h
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab3FJH1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 03:27:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab3FJH1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 03:27:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B3E724758;
	Mon, 10 Jun 2013 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ah+oTBfpU+D+
	4Z/6PLyB9N0xkIo=; b=swjdt+/QF+gBDpfpEm3L451FxdSyXxq23olRsSA1uqvn
	lTOErByMxk/r498X2x3rcWa9OXTx7ZSw4m3mmGfVqh83me0ZLc+w4iOzGEqY9Y2+
	El/tEnDS34LS4mbkGqQGPaLO89X6hfqPQBY4cA2uI95TtFTcXgyWzpsVaPU7DdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kGe45D
	RlHtl5+WIZLmiliCuYdLgAu3QnE4U/omsovCgugyTdvujXemJ6W5UMjNCypD6Www
	CeeVcKzWaNveCiIrwbCWAU0DALDhWruTZLXFr72P0EwvpO4DMSoEzZkMU13GvJGW
	Y9fgJ6R5JQqQVZnhLrLaEOis5UCPjDJKMVbB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF6324757;
	Mon, 10 Jun 2013 07:27:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D4D224756;
	Mon, 10 Jun 2013 07:27:32 +0000 (UTC)
In-Reply-To: <20130610053059.GE3621@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 01:31:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36EA4486-D19F-11E2-B161-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227247>

Jeff King <peff@peff.net> writes:

> The performance enhancement of the priority queue came from replacing
> "commit_list_insert_by_date" calls with insertion into a queue. That
> drops O(n^2) behavior on the linked-list down to O(n log n), as we ha=
ve
> "n" insertions, each causing an O(log n) heapify operation.

Yes.

> Around the same time, though, Ren=C3=A9 wrote the linked-list merge s=
ort that
> powers commit_list_sort_by_date. And topo-sort learned to do O(1)
> insertions into the unsorted list, and then one O(n log n) sort.

Yes, but that only affects the "sort the work queue in date order"
before entering the main loop, and maintenance of work queue as we
dig along still is "find the place to put this in the date-order
sorted linked list", no?

> So your results are exactly what I would expect: the time should be
> about the same (due to the same complexity), but the memory is used m=
ore
> compactly (array of pointers instead of linked list of pointers).

I've been disturbed every time I saw the commit_list insertion
function that does a small allocation which will be freed fairly
often and have been wondering if we can rewrite it with custom slab
allocator, but not using linked list where we do not have to feels
like a better solution to that issue, and use of pqueue may be a
right direction to go in.
