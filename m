From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge unpack-objects to index-pack?
Date: Fri, 11 May 2012 10:51:33 -0700
Message-ID: <7vsjf6li6y.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BjA-L=jOZ7G9TbDY6D0rqhuzCCRwAjazEfBx_=HcqcqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 19:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSu0R-0006MY-VO
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 19:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946070Ab2EKRvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 13:51:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945946Ab2EKRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 13:51:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB2C18321;
	Fri, 11 May 2012 13:51:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5LpsY9jmxSzZEfJA7kNRTZnK1+M=; b=VK5bQ1
	r+hbLuVzxEBAPy0oAgyOyb5LTsY/RO6ELYbwrwSHfflEWmprsCWF13lR+JIf+Ds4
	2gp/qumhg1t9MyovshctS/YCzLliDyt/Oqs2xZ24WK7Bc7/XThO3jtKv6FslPVXM
	RAnLS20jxtRTN+Ywb/C9bzaMU1ESPdhPR5etk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPy6IvR8vij57e9Byr9zjvfoE+Cbf2Zc
	MwTY7XVDaV+J+Z5mV2SrxPSDAKkpxKjbEfJE9zUdrMiMScymvGzIbRbybPLINKIT
	VyVLMOpQKNZ3TD41MajjoNpauWhMoSWWOLW7ny7ztnZuAavueDEw02H2fUitEnit
	XwWVIkXFMWo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2DA88320;
	Fri, 11 May 2012 13:51:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0891A831F; Fri, 11 May 2012
 13:51:34 -0400 (EDT)
In-Reply-To: <CACsJy8BjA-L=jOZ7G9TbDY6D0rqhuzCCRwAjazEfBx_=HcqcqA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 11 May 2012 19:02:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F330E5CC-9B91-11E1-A887-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197684>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I'm looking at adding large file support to unpack-objects. A simple
> way is just to stream large blobs into loose large blobs. But I'd
> rather keep those blobs in pack because pack-objects is happier that
> way. I'm looking at unpack-objects and thinking maybe it's best to
> just merge it back to index-pack.
>
> In normal mode (all small objects), index-pack receives the pack
> stream. Objects will be unpacked in phase two, resolving objects in
> index-pack. The only downside I can see is the new unpack-objects now
> write temporary pack on disk, which does not sound too bad to me.
> unpack-packs is called on small packs so extra space is small. For
> single-huge-blob packs, it's good to keep them on disk anyway. When
> the pack has large blobs, we could either just keep full pack.
>
> After this, the only pack receiver at client side is index-pack.
> fetch-pack does not have to choose between unpack-objects and
> index-pack, just pass --unpack-limit <n> to index-pack.
>
> What do you think?

I think it is beneficial to step back a bit.  What is the _real_ reason
why we call unpack-objects instead of index-pack when we receive only a
handful of objects?

I think we did this to avoid littering the receiving repository with too
many packs from individual transfers.  As long as that goal is met, a
solution that replaces the current "if we are going to get less than N
objects, explode them to loose objects" does not actually have to explode
them to loose objects.  It could explode normal objects into loose ones,
while appending large ones into an existing pack (and it has to fix up the
pack .idx after doing so), for example.  Or it could even choose to
_always_ append into an existing pack designated for appending new
objects.  Or it could punt the "appending" part, declaring that large
object problem is a rare event, and create/leave a new pack in the
repository that stores a large object (this however would not satisfy "do
not litter the receiving repository with too many packs" goal if "large
object problem" is not rare enough).

And the first step to make that happen would be to let a single receiver
program, instead of receive-pack/fetch-pack, make the decision.  That
receiver program _might_ benefit from knowing how many objects it is going
to receive when making the decision before seeing a single byte from the
packstream, but there are other more meaningful data you can learn only
after looking at what is in the pack.

So I like the general direction you are heading.

Probably the first step in the right structure of such a series would
introduce a new helper program that builtin/receive-pack.c::unpack() and
builtin/fetch-pack.c::get_pack() call, remove the header-peeking these
calling processes currently do, and make that new helper responsible for
switching between unpack/index-pack (the new helper may peek the header
instead).  The first implementation of the new helper may decide exactly
like how these two functions choose between the two.

Once that is done, it will be an implementation detail of how objects in
the incoming packstream is stored locally from the point of view of
fetch-pack and receive-pack, and nobody should notice when the new helper
is updated to call only the updated index-pack that knows to stream large
(or all) objects into a pack.
