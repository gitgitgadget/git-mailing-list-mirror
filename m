From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 09 Aug 2013 10:35:11 -0700
Message-ID: <7vr4e26a40.fsf@alter.siamese.dyndns.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
	<CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
	<7v61vihg6k.fsf@alter.siamese.dyndns.org>
	<CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
	<7va9ksbqpl.fsf@alter.siamese.dyndns.org>
	<CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
	<7v61vgazp5.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
	<7vwqnw7z47.fsf@alter.siamese.dyndns.org>
	<CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
	<20130809110000.GD18878@sigill.intra.peff.net>
	<CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:35:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qax-0006Mb-N8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343Ab3HIRfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:35:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab3HIRfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:35:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 480513711B;
	Fri,  9 Aug 2013 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQq0tN9byAU/HWaQHJoetleXG9s=; b=EUGMNq
	fTdyJoGPRChymLNVkVrSLZ2RhbQNxxQmtuGUkvkyetY6sTnzAYCD39xpNPjhGW7P
	0tlmAmRbgESWSe8lk/XcIt5abNjOXLzHeDBG6k0qOGmOgpEPfEaSdxisbIPfa+2g
	VdHA4zcIiWyAwntRql/mQvamv8viRAbL0qr6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u/NZDJgt/i1lwh76A1CNXG7tcjIvsJUl
	zo6e2/2y1ZygAca6puNvwVA38Qyg0JjjB4qBj8pyqIO691CkNZFlUPgSYF0lxEwj
	EwxM2J4L9qbhaeyI8qeBDNMNjm8ASem02JF3B93UGX6n1mRbIiRtrcLbqbUzintl
	9WEkaMcEiSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1D937115;
	Fri,  9 Aug 2013 17:35:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F13A037109;
	Fri,  9 Aug 2013 17:35:12 +0000 (UTC)
In-Reply-To: <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 9 Aug 2013 19:04:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BDB2D00-011A-11E3-B460-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232001>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'll raise some (hopefully interesting) points. Let's take the example
> of a simple push: I start send-pack, which in turn starts receive_pack
> on the server and connects its stdin/stdout to it (using git_connect).
> Now, it reads the (sha1, ref) pairs it receives on stdin and spawns
> pack-objects --stdout with the right arguments as the response, right?
> Overall, nothing special: just pack-objects invoked with specific
> arguments.
>
> How does pack-objects work?  ...

You've been here long enough to know that you can and should learn
things yourself instead of repeating "tell me tell me" ;-)

> threads to find_deltas(). This is where this get fuzzy for me: it
> calls try_delta() in a nested loop, trying to find the smallest delta,
> right?

Yes.

> I'm not sure whether the interfaces it uses to read objects
> differentiates between packed deltas versus packed undeltified objects
> versus loose objects at all.

Yes, but that happens way before that.  Start reading from
pack-heuristics document to get the general overall feel of what
goes on, and then go back to the source.

> Now, the main problem I see is that a pack has to be self-contained: I
> can't have an object "bar" which is a delta against an object that is
> not present in the pack, right? Therefore no matter what the server
> already has, I have to prepare deltas only against the data that I'm
> sending across.

There is a --thin option to allow deltas against base objects that
are known to exist on the other end to be used in the pack without
including the base objects.  The receiving end then re-adds the base
objects to the received data to complete the pack.
