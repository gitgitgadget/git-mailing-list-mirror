From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Wed, 23 Feb 2011 09:34:32 -0800
Message-ID: <7vd3miac47.fsf@alter.siamese.dyndns.org>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
 <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
 <20110223080854.GB2724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 18:34:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsIbv-0005yF-6r
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 18:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab1BWReo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 12:34:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab1BWRem (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 12:34:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 313A43AE3;
	Wed, 23 Feb 2011 12:35:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cSBZqANpZsnHbD4zyZCY3NipdZo=; b=pPtmZt
	vCXl98Asv3QIYxWiRqiu3GBBahVpLb3+d3kiVl4HvQVkK8MCaJXPLrwFCgZNfPYo
	ii4pMyvvsnqf2zzAy4IfTkR0X0DlBb3SaKt3U50aVDDOk/Gz2n6eEYxEUVMm4w4F
	TjnDTt31geU4CUU/rRwZIdHZB2Yh1uDA9keac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MG8NwJjkt2iE57GhnvYJ2yqhL+JpECEV
	hbvD8Nk1IvKUkJWD0QeueyH3sTkeSwH+j+zE2S8hoXABQXks2UOjqRBjPd8vmaWD
	/ud5ncrChaFyZ4Cf/1Mvlny/6oYhkTeDF5o1mJYbMzxxxrIHJyAwTfIADbNJp5fN
	qkvK4S+4Ynk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F28FD3ADF;
	Wed, 23 Feb 2011 12:35:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B10413ADD; Wed, 23 Feb 2011
 12:35:46 -0500 (EST)
In-Reply-To: <20110223080854.GB2724@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 23 Feb 2011 03\:08\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B78BFD2-3F73-11E0-A474-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167706>

Jeff King <peff@peff.net> writes:

> Yeah, I think the best path forward is:
>
>   1. Stop feeding "pre-folded" subject lines to the email formatter.
>      Give it the regular subject line with no newlines.

A bit of history.  The original design of the pp_title_line() function
since 4234a76 (Extend --pretty=oneline to cover the first paragraph,
2007-06-11) was to notice a multi-line paragraph and turn embedded
newlines into line folds (this seems to be a breakage specific to
non-ASCII titles).

As RFC 5322 (or 822/2822 for that matter) does not allow newlines in field
bodies (2.2: A field body MUST NOT include CR and LF except when used in
"folding" and "unfolding"...), it was the only way to allow the recipient
to tell where the original line breaks were to fold at the line breaks in
the original commit message.  Then the recipient _can_ be git aware and
turn the folding CRLF-SP into a LF, not just a SP, relying on the hope
that the transport between the sender and the recipient would not clobber
line folding, to recover the original.

The rebase pipeline (i.e. "format-patch | am") would have satisfied such a
flaky assumption and that was the only reason I wrote the line folding on
the output side that way.  These days, however, "am" invoked in the rebase
pipeline knows to slurp the message not from the patch text but from the
original message, so we can safely depart form the original design rationale.

>   2. rfc2047 encoding should encode a literal newline. Which should
>      generally never happen, but is probably the most sane thing to do
>      if it does.

I was re-reading RFC 2047 and its 5. (3) [Page 8] seems to imply that this
might be allowed: "Only printable and white space character data should be
encoded using this scheme."; I think LF is counted as a white space
character in this context, but it is a bit unclear.

If this "encode newline via 2047" _were_ allowed, I would say that my
preference is not to go with your 1. above.  Instead I would prefer to see
us feed the entire first paragraph, whether it is a single-liner or
multi-line paragraph, to the step 2 ...

>   3. rfc2047 should fold all lines at some sane length...

... and the have step3 fold its result to limit the physical length of the
output line(s).  Note that a multi-line first paragraph always will be
encoded using 2047 because we cannot have a newline in the field body per
RFC5322.  But going the above route would allow us to recover the original
first paragraph intact.

We might need to tweak the receiving end a bit, though.  IIRC, mailinfo
output assumed we will always be dealing with a single-liner subject.
