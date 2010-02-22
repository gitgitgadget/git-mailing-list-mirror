From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Sun, 21 Feb 2010 21:30:41 -0800
Message-ID: <7v635p4z26.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 07:05:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjQsx-0008As-Bx
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 06:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab0BVFa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 00:30:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0BVFa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 00:30:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EAC39B17E;
	Mon, 22 Feb 2010 00:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SMrGFkNUMuMMHlxgHb3BvFuMta8=; b=MR7JFz
	aTFJCoWcGzYsMarWcVLE9Lc3SUiEOcNdJgRAfSVdq54EAOD4uZXqPYDyV9N0dA5L
	NO5tNGTq09U9XHEyT+ev2NaxxvphbPSFZ7r1LV+2B08VZLlc6XkJIB39VWoYGHq4
	rX228wsyk7ArNw/blYiBHugzvnUyqNj4gatag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gaWjfNgfMMgZBDl9UW4n9beHQoM2i6ia
	oKECMV5bpghAd+WGS2QoYKiMAvBZFAy4pGf+6KZVH0OWt99ROOfoVhW/vYH8Oaxf
	X9y3U4erpkX7xKWTwQe32bot+5U5JL5frLdyyKJSU8K9egE3Yzp2Fjm5jJIVYheo
	QkVRy+hAg8U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B2B19B17D;
	Mon, 22 Feb 2010 00:30:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE13E9B17A; Mon, 22 Feb
 2010 00:30:48 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002211950250.1946@xanadu.home> (Nicolas
 Pitre's message of "Sun\, 21 Feb 2010 20\:35\:48 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71702A26-1F73-11DF-A9D4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140613>

Nicolas Pitre <nico@fluxnic.net> writes:

> The whole point is to detect data incoherencyes.

Yes.  We want to make sure that the SHA-1 we compute is over what we fed
deflate().

> So current sequence of events is as follows:
>
> T0	write_sha1_file_prepare() is called
> T1	start initial SHA1 computation on data buffer
> T2	in the middle of initial SHA1 computation
> T3	end of initial SHA1 computation -> object name is determined
> T4	write_loose_object() is called
> ...	enter the write loop
> T5+n	deflate() called on buffer n
> T6+n	git_SHA1_Update(() called on the same buffer n
> T7+n	deflated data written out
> ...
> Tend	abort if result of T6+n doesn't match object name from T3
>
> So... what can happen:
>
> 1) Data is externally modified before T5+n: deflated data and its CRC32 
>    will be coherent with the SHA1 computed in T6+n, but incoherent with 
>    the SHA1 used for the object name. Wrong data is written to the 
>    object even if it will inflate OK. We really want to prevent that 
>    from happening. The test in Tend will fail.
>
> 2) Data is externally modified between T5+n and T6+n: the deflated data 
>    and CRC32 will be coherent with the object name but incoherent with 
>    the parano_sha1.  Although written data will be OK, this is way too 
>    close from being wrong, and the test in Tend will fail.  If there is 
>    more than one round into the loop and the external modifications are 
>    large enough then this becomes the same as case 1 above.
>
> 3) Data is externally modified in T2: again the test in Tend will fail.
>
> So in all possible cases I can think of, the write will abort.

There is one pathological case.

Immediately before T5+n (or between T5+n and T6+n), the external process
changes the data deflate() is working on, but before T6+n, the external
process changes the data back.  Two SHA-1's computed may match, but it is
not a hash over what was deflated(); you won't be able to abort.
