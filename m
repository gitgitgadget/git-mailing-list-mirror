From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Mon, 21 Mar 2011 08:17:28 -0700
Message-ID: <7v4o6wtsdz.fsf@alter.siamese.dyndns.org>
References: <4D8525C9.2060203@gmail.com>
 <20110319222852.GB7116@sigill.intra.peff.net>
 <20110319224726.GC7116@sigill.intra.peff.net>
 <7vy64avdba.fsf@alter.siamese.dyndns.org>
 <20110320090111.GA15641@sigill.intra.peff.net>
 <7vd3llwrah.fsf@alter.siamese.dyndns.org>
 <20110321103549.GA16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:17:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1grb-0004uq-Jp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 16:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab1CUPRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 11:17:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1CUPRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 11:17:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC86A4BA6;
	Mon, 21 Mar 2011 11:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZZ3FxDXyoXgehr+1rPZh5o8O7eg=; b=UlEkeJ
	XaGZT7Q87qCIcqDvqE44bweDysB7MpBaWyMiIy9QiIJMB0g+wQDv3FpiPkeWOAKt
	M4crgyWCA5G0eujURDQthz1ixQfrj2USvj32ifp8WCvQ4IZ232a/8kau39DZvN1U
	CbyTVjFXI4rO9V4kmV2CEi4ZAknUqnYXaexIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ameeFQIyA12+Wh0tyEPoyBtXSXPuv4Z4
	PK/EAYZCggQC80gCADeXWsJz3Vx5dF/nMsXzT2HKLP/M947HiROLrNrfB+D/6UeO
	spRzmfE+jICc2Ddsfm0jg5CLfBVTooV196e0R7UpHkmYo2EvGbo+CzPx0nzH/DyC
	iWYfgFIwt84=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8987F4BA5;
	Mon, 21 Mar 2011 11:19:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 402294BA4; Mon, 21 Mar 2011
 11:19:07 -0400 (EDT)
In-Reply-To: <20110321103549.GA16334@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 21 Mar 2011 06:35:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 938A9DD6-53CE-11E0-BFA6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169600>

Jeff King <peff@peff.net> writes:

>   1. B does not use any of the same marks as A. Otherwise, it will end
>      up clearing part of A's result during cleanup (not to mention that
>      it may get a bogus result because of what was left from A).
>
>   2. B works on a totally disjoint set of history from A and C.
>
> I don't think (1) is that realistic in the general case. Sure, you might
> only want to use TMP_MARK. But the revision walker behind the scenes is
> using SEEN and UNINTERESTING, which is going to bring you into conflict.

I suspect I didn't write it clearly enough, but I think we are saying the
same thing.

Of course SEEN/UNINTERESTING needs to be reset for any traversal.  That is
a given for anybody who uses get_revision() to traverse the history.  "B
knows more about the bit it uses than other people, so it should be able
to do a better job of cleaning after it than others" is exactly about (1).

> For (2), there are cases where it works. In this recent bug, for
> example, it would sometimes produce the correct results depending on the
> exact traversal done in the orphan-warning (e.g., if you were exploring
> way back in history near a tag, the traversal wouldn't come near the
> commits needed to get the tracking info for the new branch).

And then "B knows more about where in the history it travesed, so it
should be able to do a better job" is about (2).

> But you can only know that it's a reasonable thing to do if you manually
> analyze A, B, and C as a set, and even then only if you can know pretty
> specifically what the inputs are.

Oh, that is a given that whoever is inserting B between A and C needs to
know about their relationship, and whoever wishes to design B to be
reusable in other different contexts needs to know what masks other people
may care about not to stomp on them.  I had this idea of allocating masks
on-demand instead of the current static assignment in the back of my head
for a few years, but my gut feeling keeps me telling that the added
complexity (and lax use of object bits by coders leading to memory
footprint bloat) may not be worth it.

> I can change it to UNINTERESTING. As far as I can tell, that is the only
> one set by prepare_revision_walk. It just felt like a leaky abstraction
> for this code to have to know which flags might get set by the
> underlying code. But obviously callers do need to know and care which
> flags might be set and when.

Yes, the code has to know about the bits, and explicitly declaring it
knows what it is doing and using is about being assuring, not being leaky.
