From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 09 Aug 2013 22:26:33 -0700
Message-ID: <7vbo562k1i.fsf@alter.siamese.dyndns.org>
References: <7v61vihg6k.fsf@alter.siamese.dyndns.org>
	<CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
	<7va9ksbqpl.fsf@alter.siamese.dyndns.org>
	<CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
	<7v61vgazp5.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
	<7vwqnw7z47.fsf@alter.siamese.dyndns.org>
	<CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
	<20130809110000.GD18878@sigill.intra.peff.net>
	<CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
	<20130809221615.GA7160@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 07:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V81ha-0001pe-FB
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 07:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab3HJF0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 01:26:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab3HJF0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 01:26:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B494306D2;
	Sat, 10 Aug 2013 05:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qrh4Z4mzHE29JD6JUKsDwidnC/c=; b=jWTz9l
	MQQyYfEI9DOuNkhNheGan7S5CEARpWwCSY7OdGlB3JNFtLM4egmJzoQbHRERR6e3
	DA7QI/7mdBXhBUQNyrlSLDNuHfhe8HDFYGwblyM6NeKNhDwLAzcgl7Js3D61izCD
	SReVMzBOpJtvNmR1LWAs2dyHv0oHiT/EMZksc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nx0lqcRpzAwzq703LuUtzRokjWObjvJH
	GHKhXl1mTOQ7J6w7SLuT3Ab886DOaIXyNjvy17HaVyuBF93/dFBR+bzZLqgGLF8+
	JfezzYc2rlg2pTUMrp/Wd4UT7X5pVGO+r8HfQGG5BOOMnihVpV7GFbHe4fl8SV/3
	/Pu3ZLD3/kM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F1E306D1;
	Sat, 10 Aug 2013 05:26:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C56F5306D0;
	Sat, 10 Aug 2013 05:26:34 +0000 (UTC)
In-Reply-To: <20130809221615.GA7160@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 9 Aug 2013 18:16:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C25900C-017D-11E3-BF67-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232063>

Jeff King <peff@peff.net> writes:

> ... The reason we do not store thin-packs on disk is that you
> run into problems with cycles in the delta graph (e.g., A deltas against
> B, which deltas against C, which deltas against A; at one point you had
> a full copy of one object which let you create the cycle, but you later
> deleted it as redundant with the delta, and now you cannot reconstruct
> any of the objects).

As an extension to that is that a thin-pack will make the "validity"
of a single pack dependent on its surroundings, making "verify-pack"
useless.  It may say "everything is fine", but corruption of another
pack that holds a base object a delta in it depends on will render
the pack unusable.

With the current arrangement, if you grab a single pack and re-idx
it, you know you can reconstruct all the objects in it.

The original reason was not cycles; it was primarily because we did
not want to have to map more than one packfile while reconstructing
the delta chain for a single object (this was way before the "open
small mmap windows into a large packfile" was invented).
