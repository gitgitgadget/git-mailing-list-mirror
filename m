From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/33] refs: extract a function ref_resolves_to_object()
Date: Tue, 16 Apr 2013 11:08:20 -0700
Message-ID: <7vd2tumjqj.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-11-git-send-email-mhagger@alum.mit.edu>
 <7v7gk3zqhc.fsf@alter.siamese.dyndns.org> <516D1988.5060501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:08:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAIt-0004lj-NC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab3DPSIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:08:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab3DPSIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:08:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F42D1707D;
	Tue, 16 Apr 2013 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8VP8oFerlXzqIoXZXC2FbxTx9Tk=; b=NkVnao
	FajHO0d0zDOpa8TFmKcIg9zYMoXaaVCB0HbP7jkqqagz0qoukI1Vay+3XtTSecub
	ITFNqiyeDsa3ZXTOZJ5lPFVGVS0NsEQj95UU64ieZf1io8AfJVqFilcGRCFxhPw0
	aH0chBvJvJz7Tz76zHxRu5x1LLuqEkDpFbcUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iqRnaMtSQsUgVQs0PQafaRAdXt0btM2K
	FzGTHcaP173lOgOCf6ppw9ve0lfk7QKQX2bNoITck9ZioEOT79w4ldpSlsvyamd3
	qTArljfmncpqKWtIQji6knAmecXJloTZUuj8l/oWam+k8Rni4tAcbV1zkb0OWWuY
	HfATEMwuB2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 430CA1707C;
	Tue, 16 Apr 2013 18:08:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A27DE1707B; Tue, 16 Apr
 2013 18:08:21 +0000 (UTC)
In-Reply-To: <516D1988.5060501@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 16 Apr 2013 11:27:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FA3C98E-A6C0-11E2-9036-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221440>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> In projects where I can choose the coding standard, I like to use extra
> whitespace to help the eye pick out the range of parentheses, like
>
>         if (!(
>                 (flags & DO_FOR_EACH_INCLUDE_BROKEN) ||
>                 ref_resolves_to_object(entry)
>                 ))
>                 return 0;
>
> but I've never seen this style in the Git project so I haven't used it here.

I _think_ at least to me, it is not the textual grouping style but
the "unless X we skip the rest" logic itself that confused me.  It
took the same number of minutes to grok the above as the original.

We skip the rest of this function unless the condition inside !()
holds, and the condition is.... we are told to include broken ones,
in which case we know we will do the remainder without checking
anything else, or we do the checking and find that it is not broken.

I suspect the root cause of the confusion to force the double
negation is INCLUDE_BROKEN; we have to express "when we are told to
ignore broken one and this thing is broken, ignore it" without
negation, i.e.

	if ( !(flags & INCLUDE_BROKEN) && is_broken(thing) )
		return;

which would have been much more pleasant to read if it were

	if ( (flags & IGNORE_BROKEN) && is_broken(thing) )
		return;

Unfortunately, we cannot change it to IGNORE_BROKEN and flip the
meaning of the bit, because almost all callers do want to ignore
broken ones.

Either way is fine by me, even though I find that !(A || B) needs a
bit more mental exercise to grok than (!A && !B).  Perhaps it is
just me who is not so strong at math ;-)
