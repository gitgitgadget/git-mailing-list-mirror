From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict for connectivity check
Date: Thu, 02 May 2013 23:55:57 -0700
Message-ID: <7vbo8szh4y.fsf@alter.siamese.dyndns.org>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367405974-22190-5-git-send-email-pclouds@gmail.com>
	<7vvc722s0h.fsf@alter.siamese.dyndns.org>
	<CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
	<7vvc711h4m.fsf@alter.siamese.dyndns.org>
	<CACsJy8AXe-5o7EyEp_aFB=+Ny8GoqrObxzwbAhGD4w9h7Jhmog@mail.gmail.com>
	<7vk3ngzi6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 08:56:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9uY-0004Tl-6c
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414Ab3ECG4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:56:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab3ECG4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:56:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D7B16222;
	Fri,  3 May 2013 06:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gHd/qEMuwFwWsNzlMEEc06kU2LQ=; b=QG5ccE
	tCPkcYTL2suqjZFvRN4Mdz1VmTcNCME+qoslPmC5SusJ/wWqGm9HF5SEBBwNMNhB
	U4WlKONCn6EAgIVCQpo/ZF1ncCW+S/WMq6etuNUoWsoab0qj9WEQOZ3mASOsD6y0
	9kInQBJgsLW12M3iNqUjjG5tfcDqTz2IeO/wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HascIcBwQ4acdihCWguwDIdnIPq3ze3Y
	/tdK5ICDcb661StDsRI4ha0XNmm7LevGZgyCk3yMNr1hLdCuaKg6hXAb3TTqYUlB
	LfqtW4y1u97Zo++Vead4NR62ACeh1n3A7vakBs9Cj2Kp7CBkdNjwRlu+NJBn4pDq
	lx0Lgykkw2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C9C51621E;
	Fri,  3 May 2013 06:55:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC67D1621C;
	Fri,  3 May 2013 06:55:58 +0000 (UTC)
In-Reply-To: <7vk3ngzi6o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 02 May 2013 23:33:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82620588-B3BE-11E2-9B9B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223291>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> What do you mean by "partial history"? Do we have dangling pointers
>> after doing that commit walker?
>
> "^C" will leave the objects and it is safe because it will not
> update refs.
>
> But your code that does not verify the full connectivity from such
> an object (that is outside the transferred pack) to the rest of the
> history will then make the resulting repository broken, if you
> update your ref to point at such an object, no?  Ading a single
> has_sha1_file() only verifies that single object, not the history
> behind it.

Let's illustrate.  Imagine your project as a whole has this history:

---A---B---C---D---E

When you cloned, it only had up to A, so that is what you have.
Then you try http walker, which slurps E, wants to go to D and dig
down, but after fetching E, some trees and blobs in E, and fetching
D, but before completing D' trees and blobs, your ISP cuts you off.

You have these in your object store:

---A           D---E

but your ref is pointing at A, because we promise that we make sure
full connectivity before we update the ref, and even if you have
commits D and E, the associated trees, blobs, and commits behind
this subpart of the history are missing.

Now you try to fetch from another mirror over the pack transport.
You advertise that you have A (but you do not advertise E, because
your refs do not point at it), and you expect all objects that are
listed in "rev-list --objects A..E" to be gien to you.

Unfortunately, the mirror is broken, in that it only packs the
objects that appear in "rev-list --objects A..B", but still tells
you that it is sending objects to complete history leading to E.

Your object store would have objects like this after this transfer:

---A---B       D---E

You may still have commits D and E unpruned, but are missing C, and
trees and blobs that are needed in D or E.

You have to walk the history from E and list the necessary objects
yourself, running has_sha1_file() on all of them, to prove that you
have everything needed, and the only things you can trust are your
refs (in this case, A).

If you verify that all the objects in the transferred pack are
complete, and also verify that the object the transfer proposes to
update your ref to is _in_ that pack, then you can detect a mirror
that is broken and only sends objects for A..B, but that does not
actually solve the issue.  Imagine another broken mirror that
instead sends objects for E.  E, its trees and all its blobs may be
in the pack and the only outgoing link from that pack may be a
pointer out of E pointing at D.  You happen to _have_ it in your
object store, but that does not mean you can update your ref to E
(remember, you do not have trees and blobs to complete D, or the
history behind it).

The current check is implemented in the way we currently do it,
_not_ because we were stupid and did not realize the optimization
possibility (in other words, what your patch proposes is not new),
but because we rejected this approach because it was not safe.
