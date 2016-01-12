From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
Date: Tue, 12 Jan 2016 11:41:17 -0800
Message-ID: <xmqqlh7utwki.fsf@gitster.mtv.corp.google.com>
References: <20160112095638.GA4773@sigill.intra.peff.net>
	<20160112095804.GB16501@sigill.intra.peff.net>
	<20160112132628.GA31854@sigill.intra.peff.net>
	<20160112135522.GA23255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:41:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ4oo-0007cs-L4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 20:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcALTlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 14:41:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751219AbcALTlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 14:41:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DCFD83BB5E;
	Tue, 12 Jan 2016 14:41:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h+0x7Ltnga6BSToB072n6sE0ohg=; b=XVv/Il
	nrX7Rl2U0gUrD8fC/O+gM3hYBtmnoBzHVzcmOuvTHhN2Q6/bNcFGFHEjldzKUG+2
	Xhbq85MvO3qHQT/FDF0Ft2dcpl4Ga3cyVfbW0fBwrhOf6xiX0/ziMBku43qXV/p8
	TSxFYseIocco54YJrUOeop/iJMez/4gb7PXPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2TRcGdRkFFTi8s791WYZorkuJ1KPrxY
	h+nTy4Y+ENJVb2m6NexphHxWAZCm7Lcg2hu1klWfSF8LZmvUbvBpiG2tKpOHkbkP
	4fHp8ih9cA3mNVjduBLPztnake9btEit6PARszcZtJbLXZulpeeB/osD5W4mCtgu
	hzZX1tm5fXY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D381D3BB5C;
	Tue, 12 Jan 2016 14:41:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C1C63BB50;
	Tue, 12 Jan 2016 14:41:19 -0500 (EST)
In-Reply-To: <20160112135522.GA23255@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 12 Jan 2016 08:55:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73A306CE-B964-11E5-81E7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283838>

Jeff King <peff@peff.net> writes:

> I also notice that if we are deleting, we _do_ set
> RESOLVE_REF_NO_RECURSE from the very beginning, which means we would
> generally not get a valid lock->old_oid.hash for a symref. But I'm not
> sure what it would mean to delete a symref while asking for its current
> value (it cannot have one!). So I don't think it is a bug.

I started scratching my head after noticing that the NO_RECURSE bit
set in the DELETING codepath before reading the above, and I am
still doing so.

A transaction that attempts to delete an existing symref presumably
wants to make sure that the "old" value it read hasn't changed, but
ensuring the object name (obtained by reading the ref that is
pointed by the symref by dereferencing) are the same is not the
right way to ensure nobody raced with us in the meantime anyway (we
should rather be making sure that the symref is still pointing at
the same ref), so in that sense, in the context of acquiring the
lock, old oid value is meaningless for symrefs.

This patch is a strict improvement as the behaviour for REF_DELETING
case is unchanged by it (an idempotent resolve-ref-unsafe may be
called one more time in some cases), and other cases are better, I
think.
