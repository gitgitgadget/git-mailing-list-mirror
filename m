From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 03 Mar 2010 13:28:01 -0800
Message-ID: <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
 <20100303204257.GA5501@coredump.intra.peff.net>
 <7v3a0hktga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 22:28:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmw7B-0002Da-3o
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 22:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290Ab0CCV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 16:28:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab0CCV2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 16:28:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A2909E67C;
	Wed,  3 Mar 2010 16:28:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ED7/ipU04oD2RunY1bc/YjlpdGQ=; b=dySw5n
	WesKBZta/r0386M0PkUfTKTR2VATVx6/SwjFi2cgh0S8TFqF1amywb5NVtzNj28p
	t+JkmzwR3jI0LQvKk9bOtQ2lS88X9IlL2opVgk2TUeOLDlw1uFfTbFng4d+QVIpr
	+mJx3wamR133qEsi97o6AwmoXn0ylSomSHA34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tjw5dAr4pquthEII+BdqJWlRXpuYoBJd
	hhmvRF27lOnTzBLE0siPHXddltMDToiPYYj3UZgDVhx8YfiFcTKrSp1ZtGum51Om
	KwBhfvF+DkwsARWTG2LYF7nZ9SZM9ZnaqbV6o1GeodRH1AJufq96lMMhZsxqjOVc
	AtRdMs8KyeQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 196E09E677;
	Wed,  3 Mar 2010 16:28:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E64D9E676; Wed,  3 Mar
 2010 16:28:03 -0500 (EST)
In-Reply-To: <7v3a0hktga.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Mar 2010 13\:04\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9C464CE-270B-11DF-8469-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141482>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>>  - "git submodule summary path...", defaults to HEAD which is _not_ unborn
>>>    (we shouldn't shift).
>>
>> I don't think this is a problem. We do:
>>
>>   git rev-parse -q --verify --default HEAD path
>>
>> and it correctly reports failure, so we never do the problematic shift.
>
> Stepping back a bit, why do we even special case an unborn branch case in
> the first place?  
>
>     rm -fr one && git init one && cd one && git diff HEAD
>
> would diagnose it as an error (we may want to sugarcoat "ambiguous
> argument" error message, but that is a tangent).
>
> I may be able to buy "status/diff internally calls submodule summary, and
> that codepath needs to special case a submodule on an unborn branch _for
> such and such reasons_" if the reasoning is sound, but even if that is the
> case, shouldn't that special case be triggered explicitly by the caller of
> "submodule summary" with an option?

Continuing to mutter to myself...  I am suspecting that the right solution
to the issue $gmane/140066 raised may be your "dwim-ref fix in 003c6ab
(dwim_ref: fix dangling symref warning, 2010-02-16) and a patch along the
line of the attached (with 3deea89 reverted of course).

We _might_ also want to revert 003c6ab, though it is more or less an
independent issue.

 wt-status.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 5807fc3..1cca3aa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -476,6 +476,9 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 		NULL
 	};
 
+	if (s->is_initial && !uncommitted)
+		return;
+
 	sprintf(summary_limit, "%d", s->submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
 
