From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Fri, 12 Feb 2010 23:42:13 -0800
Message-ID: <7vsk95sht6.fsf@alter.siamese.dyndns.org>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <7vljeyp1rj.fsf@alter.siamese.dyndns.org>
 <4B764B67.1020402@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Sat Feb 13 08:42:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgCeD-0002Mm-Cz
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 08:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab0BMHmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 02:42:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0BMHmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 02:42:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D340A991B1;
	Sat, 13 Feb 2010 02:42:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m6EtmWHznAv8GEGbUbNA1kvTjdM=; b=m0t/YA
	WqoTwlzgPid67rlkknPTO5ocqHDUPNmC0OiNTD4e5b32Mx+X3TRd1b3A/o+FlEun
	9mFYqU63WlzfoB72sjd70oaf4rdZLhsy+2xUH4GiIpkinpISWFq0+86YBamP1g8b
	Xrf2DlXjyeomSoqi6m3a9vF4nhwm0o4SiVvx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GN0vDg2LLzRIp+wg8EvV6rTssagqc1QY
	T363k7ZwJbwJpyQ8qQsgwm4VRgZira5I32hv96Bb6AQILwcs/UTazUyN989V/3Ol
	K67Q5UXg0UsmJ3QJ0LDYfuhGMCSoCyu2k/sEEc1LK5RtDxQ6z0+mSa0muOCVEe7x
	qgm415IRA8U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70575991AD;
	Sat, 13 Feb 2010 02:42:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32ED0991AC; Sat, 13 Feb
 2010 02:42:15 -0500 (EST)
In-Reply-To: <4B764B67.1020402@dcl.info.waseda.ac.jp> (Hitoshi Mitake's
 message of "Sat\, 13 Feb 2010 15\:49\:11 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 523A5FD4-1873-11DF-B0D1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139779>

Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> writes:

> Because strlen(challenge_64) is the upper limit of length of challenge.
> So tail part of challenge may not be filled by EVP_DecodeBlock(),
> non-zero filled buffer produces not NULL terminated string.
> I've confused once by this problem before.

If you know the length of the decoded thing, then you would just know
how much to hash.  Doesn't the EVP_DecodeBlock() give you that number?
Why do you need a NUL termination to begin with?

Because you pretend as if you do not have the actual length, you run
strlen() instead.  I am not that familiar with the API to EVP_* functions,
but I'd be surprised if it were designed in such a stupid way to force you
to write into a pre-zeroed buffer.

By the way, if you use strlen() on a pre-cleared and overallocated buffer,
doesn't your ENCODED_SIZE(n) have to be one byte longer than what you are
computing?

Looking for EVP_DecodeBlock in http://www.google.com/codesearch seems to
find usage examples of varying quality.  Your favorite isync-0.5 stores
the result in "len", but it entirely ignores it and does the same silly
calloc() and strlen().  Usage example in OpenSSL's own x509spki stores the
return value in spki_len and uses that as the length of the stuff to call
another function, which looks much more reasonable.  From this observation
and a bit of reading of the manual, my understanding is that the function
gives you the number of bytes written in the buffer.

So does EncodeBlock(), I would think.
