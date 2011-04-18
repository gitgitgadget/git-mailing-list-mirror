From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: "negative" dirstat
Date: Mon, 18 Apr 2011 14:33:53 -0700
Message-ID: <7vzknn6y7y.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=it7r7UsAZGYJC1mntL6wtFipB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBw5E-0003WI-Us
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab1DRVeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:34:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1DRVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 17:34:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36E3F494C;
	Mon, 18 Apr 2011 17:36:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ofIm40TU4voOuom14ienlc431Ik=; b=Ux61td
	mhJhHy8vqkquhU6JrhGE5lOTNT7k44j/641P3lTGGeHe3ZxjENNjhcqO8rXKmJ7o
	Wics1Pp5Ewr/Es7LjFnDPdqIu3LMNRn9b0WwUEfzhIN7QjSVjPjVBGC9pSyt2gWS
	JvEG2bZ6sh/t/V3zxSG0RAyr9f0+zgyKmcCCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ugH294Y9kcjQkaqllzyP3+ILOy4uc+YX
	JinxXvgqKbOm2h7QF0fbQBHB0R0Vx/WqpuWTZLgk20NIHYbMSfXOh6tX9jM4AXLt
	W/HP080zpnNJZmFCxjFRJ8ZtLKDkegK7GQz5Dt9BMuunt6Nu/btHubYj+mCqaM+i
	NZMQNgdNHUQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05D1A494B;
	Mon, 18 Apr 2011 17:36:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D9C4D4945; Mon, 18 Apr 2011
 17:35:56 -0400 (EDT)
In-Reply-To: <BANLkTi=it7r7UsAZGYJC1mntL6wtFipB9g@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 18 Apr 2011 14:02:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DACB7878-6A03-11E0-B56C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171760>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, so this is just an RFC patch, but the concept is pretty simple..
>
> In the kernel, the ARM platform is growing boundlessly, with platform
> files being added for every random SoC out there. One of the things
> that Russell King (arm maintainer) has worried about is that when they
> try to clean stuff up, code *removal* also ends up adding to the
> damage, so if ARM ever gets its act together and is able to
> consolidate a lot of this, it's still going to look very bad in the
> statistics because there will be a lot of damage due to removed files.

Are these removal really "remove old cruft, replace with a better version
which does not have much common to removed stuff", or are they more like
"remove N duplicated similar copies of old cruft, refactoring them
properly and the result is used by N callsites"?

The second reason you gave in an earlier discussion why dirstat uses the
damage assessor code was to disregard code movements. It appears to me
that if you spanhash the contents of _all_ files in the preimage and the
postimage of ARM tree and compute literal-added vs src-copied within the
whole tree, I wonder if you can mitigate this "false damage -- because the
refactoring involved code movement across files but within the same
subsystem".

I guess what it boils down to is what you are trying to measure as the
"goodness" value of a change. Adding a lot of Documentation may be good,
adding a lot of "subarchs that do not deserve to be" may be bad, and
moving common logic from one existing subarch to a common file (which
counts towards "literal-added" in that new common file, at the same time
counting towards deletion, i.e. "size - copied", from the original) and
reusing it in a new subarch by simply calling that common infrastructure
is a very good thing. At least, if you count literal-added vs src-copied
across the files within the subarch, instead of doing it per-file, you
would be able to detect the "moving" part more accurately. Of course, you
still cannot tell between good and bad kinds of additions, and you cannot
tell that the new subarch that reuses the result of refactoring by calling
into the refactored code, without understanding the source code, and I
don't think that is within the scope of dirstat.
