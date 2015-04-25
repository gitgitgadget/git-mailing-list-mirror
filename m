From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] ref_transaction_commit(): only keep one lockfile open at a time
Date: Sat, 25 Apr 2015 12:21:07 -0700
Message-ID: <xmqqoamcypy4.fsf@gitster.dls.corp.google.com>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
	<1429875349-29736-6-git-send-email-mhagger@alum.mit.edu>
	<553B2F5C.3010007@alum.mit.edu>
	<xmqqiock1yq3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 25 21:21:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym5de-00041s-0Y
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 21:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbbDYTVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 15:21:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750731AbbDYTVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 15:21:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 256CD4A74B;
	Sat, 25 Apr 2015 15:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8F95eXcYeUhotuRhQ2SGSTXmOaY=; b=udxmNE
	X1HE4Z8svvvV3yZnRMzoPwmElZ7Dn4tMmOmdlv9joxwM5CJG9s3lPrrejvmYt7kx
	5Nc5KIDyeWwwYdiWxTjPqVpUZVlP2Gy9bAeDybcoja1e+7hgvsulWbzcj950PIKg
	tgJmJGMmQrZBrZ8nUiEVJ9GHKt3GH7pQmlQBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VnMO3OTc6gPEsbAKIH78eqgBQLxcWgmP
	QXSf0vyS9qq3XavkRCpMIA9PGv+XpRk7o/ABkxL74kJYgQzB4FhcSFlkHNgsiYj/
	XCYmO2PLagsPKEsUO59tq0afglOi1onJJOiONQ6c5GlkjBnI8QQt3HEmUWKV9gNM
	U+KIMwz1GJY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C1884A74A;
	Sat, 25 Apr 2015 15:21:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 916F64A749;
	Sat, 25 Apr 2015 15:21:08 -0400 (EDT)
In-Reply-To: <xmqqiock1yq3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 24 Apr 2015 23:57:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39CDEE76-EB80-11E4-9C60-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267798>

Junio C Hamano <gitster@pobox.com> writes:

> I am not too worried about "push --atomic", as we can just add a few
> words to Release Notes and documentation saying "this is still an
> experimental broken code that is unusable; don't use the feature in
> production".
>
> I however am more worried about the other one "update-ref --stdin";
> the change will be pure regression for those who want to do many
> updates and do not care if the update is atomic, no?

I should have refrained from touching the keyboard so late at night
X-<.  This regression was done long time ago (even in v2.1.0 I see
that ref_transaction_commit() tries to grab all locks at once).

So it is only "push --atomic".

The choice is between (1) shipping "push --atomic" that is known to
be broken, (2) applying your five-patch series which may (a) fix
both "push --atomic" and "update-ref --stdin", or (b) break other
transaction users including "update-ref -stdin" in unexpected ways.

I dunno.  I am still tempted to go route (2) hoping that it would
result in (2-a) not (2-b).
