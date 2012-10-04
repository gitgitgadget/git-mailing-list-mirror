From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] peel_ref: do not return a null sha1
Date: Thu, 04 Oct 2012 11:32:13 -0700
Message-ID: <7vfw5uytoy.fsf@alter.siamese.dyndns.org>
References: <20121004075609.GA1355@sigill.intra.peff.net>
 <20121004080019.GB31325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtfp-00033L-7W
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab2JDScS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 14:32:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2JDScR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 14:32:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CECB8E4F;
	Thu,  4 Oct 2012 14:32:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkrnEKRCA/RpHjqEugLqOqHwYT0=; b=CBKZOP
	aYoVYV64MjnfwXOheHGVJuVO7oT87OIU7il+QC0KYATqgQbnpPMcvqGYJ7AyNvYT
	y0nxYWu36MgI1Q9UF316NlagGm9hjzzCsNXL8iQe8/XNnjRY9P9pK9P3uruus/0l
	f04HAoZwBCsJj0B+MqwvUeCC8ajNB8Ds/i9vU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgzsUIxZwqLX0jBtmX5/qYH7NDUtLCp1
	dtuHQQVO2kJPEOdYitxi3gUsoEPMHESbXMguQqiPqIUsGI2WkWaray3yBlbDfFi7
	n5zMKu/ENTR6A46IfxYNtW3yq8nRLb8TpP3c8MVb/LQipobmmpxi/Vwu2jfeQpMJ
	4/UoYa/cMl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29CA58E4E;
	Thu,  4 Oct 2012 14:32:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B13F68E4D; Thu,  4 Oct 2012
 14:32:14 -0400 (EDT)
In-Reply-To: <20121004080019.GB31325@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 04:00:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1AB47FC-0E51-11E2-8EA6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207039>

Jeff King <peff@peff.net> writes:

> The idea of the peel_ref function is to dereference tag
> objects recursively until we hit a non-tag, and return the
> sha1. Conceptually, it should return 0 if it is successful
> (and fill in the sha1), or -1 if there was nothing to peel.
>
> However, the current behavior is much more confusing. For a
> regular loose ref, the behavior is as described above. But
> there is an optimization to reuse the peeled-ref value for a
> ref that came from a packed-refs file. If we have such a
> ref, we return its peeled value, even if that peeled value
> is null (indicating that we know the ref definitely does
> _not_ peel).
>
> It might seem like such information is useful to the caller,
> who would then know not to bother loading and trying to peel
> the object. Except that they should not bother loading and
> trying to peel the object _anyway_, because that fallback is
> already handled by peel_ref. In other words, the whole point
> of calling this function is that it handles those details
> internally, and you either get a sha1, or you know that it
> is not peel-able.
>
> This patch catches the null sha1 case internally and
> converts it into a -1 return value (i.e., there is nothing
> to peel). This simplifies callers, which do not need to
> bother checking themselves.
>
> Two callers are worth noting:
>
>   - in pack-objects, a comment indicates that there is a
>     difference between non-peelable tags and unannotated
>     tags. But that is not the case (before or after this
>     patch). Whether you get a null sha1 has to do with
>     internal details of how peel_ref operated.

Yeah, this is what I was wondering while reviewing [1/4].

We traditionally said both HEAD^0 and HEAD^0^0 peel to HEAD, but
this at least at the internal API level redefines them to "these do
not peel at all and is a failure".  In other words, peel_ref(ref,
sha1) that returns 0 is a way to see if ref points at a real tag
object, and if the function returns non-zero, the caller cannot tell
if the failure is because it was a valid commit or a corrupt object.

The check !is_null_sha1(peeled) always looked fishy to me.  Good
riddance.
