From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: use shorten_unambiguous_ref
Date: Tue, 14 Apr 2009 09:55:08 -0700
Message-ID: <7vprff41lf.fsf@gitster.siamese.dyndns.org>
References: <1239291182-12860-1-git-send-email-git@drmicha.warpmail.net>
 <20090410171458.GA26478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltlx9-000850-L0
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 18:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbZDNQzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 12:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757043AbZDNQzU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 12:55:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982AbZDNQzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 12:55:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D5E37EC32;
	Tue, 14 Apr 2009 12:55:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D7848EC31; Tue,
 14 Apr 2009 12:55:10 -0400 (EDT)
In-Reply-To: <20090410171458.GA26478@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Apr 2009 13:14:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07BE6C32-2915-11DE-8A89-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116547>

Jeff King <peff@peff.net> writes:

> Hmm. I was thinking we might be able to just do away with prettify_ref,
> but I didn't consider the fact that we need to prettify remote things. I
> think you could still unambiguously prettify the local half of those
> callsites, though.
>
> Given that the two functions are closely related, should we perhaps
> rename them to
>
>   const char *shorten_ref(const char *);
>   const char *shorten_ref_unambiguous(const char *);
>
> ? The implementations are quite different, with prettify_ref not really
> respecting the ref lookup rules, but rather just considering a few
> pre-determined bits of the hierarchy as uninteresting. It shouldn't be
> that hard to have them both use the same implementation, like:
>
>   const char *shorten_ref(const char *, int unambiguous);

I was hoping that a single "shorten" function that does not even take
"unambiguous" parameter would be used by almost everybody.  As far as I
can see, Bert's "rev-parse --abbrev-ref" RFC is the only caller that might
need to use a value different from warn_ambiguous_refs, and all the other
existing callers (including fill_tracking_info() for "upstream" report by
git-branch) do not have to pass "0" but can use the default.  IOW, we can
have:

	const char *shorten_ref_unambiguous(const char *ref, int strict);
	const char *shorten_ref(const char *ref)
        {
        	return shorten_ref_unambiguous(ref, warn_ambiguous_refs);
	}

and only specialized callers that really care use shorten_ref_unambiguous
(without Bert's [PATCH-RFC 3/2] we do not have any such specialized
caller, I think).

But I am not sure how well prettify_ref() fits into this picture.  It is
called only from transport and is meant to deal with refs that exist on
the remote side, so ambiguity check against our local namespace would not
make much sense.  We could:

	const char *shorten_ref_internal(const char *ref, int mode);
	const char *shorten_ref(const char *ref)
        {
		unsigned mode = warn_ambiguous_refs ? SHORTEN_STRICT : 0;
        	return shorten_ref_internal(ref, mode);
	}
	const char *prettify_ref(const char *ref)
        {
        	return shorten_ref_internal(ref, SHORTEN_PREFIX_ONLY);
        }

and have the SHORTEN_PREFIX_ONLY logic inherit from what the current
prettify_ref() does, but at that point it I do not think it makes sense
anymore.
