From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 01 Feb 2010 09:21:51 -0800
Message-ID: <7v3a1k50sw.fsf@alter.siamese.dyndns.org>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond>
 <20100201113213.GA22663@coredump.intra.peff.net>
 <20100201121933.GA9995@coredump.intra.peff.net>
 <4B66CD81.3010005@viscovery.net>
 <20100201133903.GA923@coredump.intra.peff.net>
 <20100201134454.GA796@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?Q?Elli=C3=A9?= Computing Open Source Program 
	<opensource@elliecomputing.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbzyW-0007wa-U6
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0BARWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:22:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024Ab0BARWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:22:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C36EA96CD3;
	Mon,  1 Feb 2010 12:22:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=aPOZxt2vgp5BlacXNny3RcFpkDs=; b=MbjTiCVVzxZ0kIJrnx9ayvQ
	x5/AyI3m7jCBThzr2fkg3Q9hkjpHw6tuilIUR7OKwE9/jCyroKfY2d8q3D3yBUZw
	pOcYOZvKNfYyaF3dx0bnYSK0Suo6/f/YgQ1AImjux6aaVaHfq5HfgofTbiSQCaRY
	XA8oOFTtXU7RCYnawr/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=cwpXuO5m9MPw4SLGHTmFvMtnZsu+wvu3lmdho3XXKx3ulu+28
	0B6PpMcoHFpgZUnQo0B1YDs71fF0kuYXnfqHT5VNbqfEsmP3+jcIb+2SzRT6zhgi
	/6dG2JrTYKr4vfB03hCq+FpXWoCBgv3Ad/vQNLaSqEyGhQvzdp+HsX0uz8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71EE396CD2;
	Mon,  1 Feb 2010 12:21:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 651FA96CD1; Mon,  1 Feb
 2010 12:21:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D62ED4E-0F56-11DF-86F4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138628>

Jeff King <peff@peff.net> writes:

> And here is what the "quote embedded NULs" patch would look like on top.
> It's actually pretty straightforward, but the more I think of it, the
> more I think it is probably not worthwhile. Not only are we quoting
> paths, which should not have embedded NULs, but it requires that the
> caller always pass the length explicitly, and clearly we are not doing
> that all or even most of the time. So while this would fix the low-level
> "this function quotes an arbitrary string" case, for it to be of any use
> all of the code paths leading to it would need to be audited to handle
> NUL-embedded strings.

Thanks; I think your analysis is very sound.

The current callers do not care (for a good reason).  They are dealing
with a pathname, and either they are feeding a string on which there is a
pathname followed by something else and they know where that something
else begins (they give maxlen because they don't want to or cannot NUL
terminate the string in place while calling this function), or they know
they want to quote to the end of the string but they haven't counted how
long it is (they say "I don't care---just quote to the end").  In either
way, they don't expect giving too long a maxlen will go beyond the end of
the string past the terminating NUL.

Unless we document "this function is to C-quote a (portion of a) string,
either to the end or up to the given length", however, future callers may
incorrectly assume that with length the function can be fed anything and
would C-quote that piece of memory.  The argument name "const char *name"
already suggests that is not an arbitrary binary rubbish, changing that to
"str" would probably make that a bit stronger documentation, or we could
explicitly say "this is a (early part of a) NUL-terminated string" in a
comment.

But your one-liner patch would actually be a smaller change than any of
them and makes the whole problem disappear; wouldn't it be a far better
solution?
