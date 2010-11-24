From: Junio C Hamano <gitster@pobox.com>
Subject: Re: First/oldest entry in reflog dropped
Date: Tue, 23 Nov 2010 16:35:52 -0800
Message-ID: <7vzksztv6f.fsf@alter.siamese.dyndns.org>
References: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
 <20101121053545.GA10520@sigill.intra.peff.net>
 <alpine.DEB.1.00.1011211233570.2948@bonsai2>
 <20101122044252.GA7362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 24 01:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL3LJ-0003SC-O2
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 01:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab0KXAgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 19:36:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab0KXAgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 19:36:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C4B62BBD;
	Tue, 23 Nov 2010 19:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lga3HMSx2kXkdaoEY6s0PHIyjZk=; b=Mq6qpD
	NZjpcd4yxGGDmaeOZ9qQU11nvYY46SOgeBAsDkiEZ0OTlwnbItXjaBd9KJFRuLRd
	qZxOtwOKiJjmt0NcbEE0aMvIY98ZjIlIQ2k6gF2WtqcOXKmva0hm8hk2z74RdTNO
	w6/qU5nzZbWYWHcYbAKG2F5fhOLKSjd5qlDck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DuVItq6WVU+uRKls9QVxLkFEg/GY9ggh
	6FrKJKs7K8tc5lhbFDvK/GuYaeZRUQylxHb+M8aBCTkEYkz0R83LsHxeCzr2p5V7
	qBf2I06Xll38JbTawhsG587u+D4uHhXq3CTTdWCJ31aJGRk4CO3FbGYj00CKaAwE
	rDXhXlNkKuU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A0022BB9;
	Tue, 23 Nov 2010 19:36:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CACA52BB6; Tue, 23 Nov 2010
 19:36:07 -0500 (EST)
In-Reply-To: <20101122044252.GA7362@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 21 Nov 2010 23\:42\:53 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D718D28E-F762-11DF-84DA-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162037>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 21, 2010 at 12:36:21PM +0100, Johannes Schindelin wrote:
>
>> On Sun, 21 Nov 2010, Jeff King wrote:
>> 
>> > This patch clears up your bug, and doesn't break any tests. But I'd 
>> > really like to get a second opinion on the significance of those other 
>> > flags, or why the flag clearing was at the bottom of the function in the 
>> > first place.
>> 
>> The flag clearing was at the bottom because I had the impression that 
>> something function one might want to call in that function in the future 
>> could set the flags again. Maybe a goto would be appropriate here instead 
>> of the early returns?
>
> That makes sense. I did a quick skim of the called code and I'm not sure
> any flags could be set, but even if I am right, I think it is better to
> be defensive.
>
> So let's do this, which is the equivalent behavior to your gotos, but
> this structure makes more sense to me as a reader (and it doesn't
> involve goto :) ).

I have a feeling that we probably should have structured the code a bit
more modularly, placing some info in "rev" that tells us how to "pop" a
commit from the rev->list (typically "not the ones that we have shown"),
what other commits to push back into the queue (typically, "all the
parents that are not interesting"), and what side effects we should cause
when we do so (typically, "mark uninteresting parents"), etc., instead of
the current "if we are walking reflog, here is the special codepath we
take", so that the walking is more generalized when we did the reflog
walking (in fact, if we did this properly we probably wouldn't be calling
it "bolted on").  But for now let's refrain from doing such a rewrite.

Thanks, both.
