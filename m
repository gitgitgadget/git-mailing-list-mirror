From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 08 Aug 2013 12:37:28 -0700
Message-ID: <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
	<CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
	<7v61vihg6k.fsf@alter.siamese.dyndns.org>
	<CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
	<7va9ksbqpl.fsf@alter.siamese.dyndns.org>
	<CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
	<7v61vgazp5.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 21:37:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7W1i-0005BT-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965572Ab3HHThe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 15:37:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab3HHThd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 15:37:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87D6837F36;
	Thu,  8 Aug 2013 19:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uEw8bmRyoHMTkfczclatH2SJosU=; b=NlK/z6
	Vr88aTXeRKl6j2f6bibnVMNle04SG56W6bcuv9OjiMiHs3GUdbURLBP3IABr6WHJ
	zU8GzwtSN66bPP2ST20si1RWh4dgt/i7oy7F1p58HKzKZCLZL12To7mGf0dEfj/i
	HGYww+CCKc/oYzUq3xYoXmmGztlFvGhs/nXKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rclUX2hqhNEyfxcMA59hSapi5FDU82id
	JWXr8VwPfTt0JkmhBdtNmOQiHZpL6r6Dux7nOCYykqevSSnpg4b+uF1I7B78mf5U
	3vA9mLGjl/CMl18o6IAYgnqTBV98OWP3sihACdUYyz1iiESNGjRNnp2QJKTKK/B7
	wJPuHQ2e5Lo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7718137F35;
	Thu,  8 Aug 2013 19:37:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1735B37F2D;
	Thu,  8 Aug 2013 19:37:30 +0000 (UTC)
In-Reply-To: <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Aug 2013 23:06:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F6A4B34C-0061-11E3-8C10-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231926>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I asked you a very simple question: what happens when I do "git push"?

You asked "does push send unreachable cruft?" and I said No.  Does
that answer your question?

> 3. After a few days of working, the gc heuristics figure out that I
> have too much garbage and too many packs; a cleanup is required. The
> gc --auto which doesn't tolerate fragmentation: it tries to put
> everything into one large pack.

Today's "gc --auto" skims the history shallowly and packs loose
objects into a single _new_ pack.  If you start from a single pack
and enough loose objects and run "gc --auto", you will have two
packs, one intact from the original, one new.

> We're talking about tackling the gc aggression problem in 3.

> when I say "git push" (or when gc decides to repack), won't I need
> to explode the young pack into loose objects, do a reachability
> analysis, and repack anyway?

You do not explode anything.  "push" will read objects from
anywhere, either from loose or packed, and send a newly created pack
over the wire.

And I see from "(or when ...)" part that you do not know what you
are talking about.  "push" will not stream existing pack to the
other end without computation, and it never will.  It will reuse
existing individual pieces when it can, and having data in a pack
(even without deltifying, or as a suboptimal delta) is much better
for push performance than having the same data in a loose object if
only for this reason, as you do not have to recompress and reencode
it in a different way (loose objects and undelitifed object in pack
are encoded differently).

> ... are you willing to explain it to me?

Hope that the above clarifies.

I've treated this thread as a design discussion, not an education
session, but the above ended up having more education material than
anything that would advance the design.
