From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/25] reachable: use traverse_commit_list instead of custom walk
Date: Thu, 16 Oct 2014 10:53:52 -0700
Message-ID: <xmqqmw8vuci7.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<20141015223728.GF25630@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 19:54:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XepFP-0005Md-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 19:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbaJPRxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 13:53:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751309AbaJPRxz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 13:53:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46518162C7;
	Thu, 16 Oct 2014 13:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fez1fU0TYeK6S6/D4jsyA3j8l8c=; b=JJb08h
	OfgH5DajS5mNLnwW5cXp5rKkv65ytknpmiu2DnY8MKvvMphI2+xDpnexdMoyi0VX
	uJXTuD2+05zwgi1BwCVSCMqZGnHtqtONVg334temmLJES7rJhB5R8gzXOlmD3ft+
	iXGS7J9n50TOxNSCYdRoryKWNoxw5pnS4y2Mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rijIhvycjCTRDv+ynAvsNBkRDsjYjqn3
	MHxwKGL89RyWsJ+ADBvAyVNSfHUniXBdLIlAJK19HuJWya8JrApUbEaR9EUQlN/+
	ZpUpxxp4HJrqhbizzxjtqzO+hCkjdYHVU+TG0eivXpDBAKfEXPRskkO3piIbCv8x
	bewXijfB9QM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D8B8162C4;
	Thu, 16 Oct 2014 13:53:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B593C162C3;
	Thu, 16 Oct 2014 13:53:53 -0400 (EDT)
In-Reply-To: <20141015223728.GF25630@peff.net> (Jeff King's message of "Wed,
	15 Oct 2014 18:37:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64B00FFC-555D-11E4-851A-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To find the set of reachable objects, we add a bunch of
> possible sources to our rev_info, call prepare_revision_walk,
> and then launch into a custom walker that handles each
> object top. This is a subset of what traverse_commit_list
> does, so we can just reuse that code (it can also handle
> more complex cases like UNINTERESTING commits and pathspecs,
> but we don't use those features).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I was concerned this would be slower because traverse_commit_list is
> more featureful. To my surprise, it was consistently about 3-4% faster!
> The major difference is that traverse_commit_list will hit all of the
> commits first, and then the trees. For reachability that doesn't matter
> either way, but I suspect the new way has slightly better cache
> locality, leading to the minor speedup.

I am not very surprised, as "custom walk" hasn't changed much ever
since it was done in ba84a797 (builtin "git prune", 2006-07-06),
while the generic traversal code has been worked heavily while it
was still in builtin-rev-list.c and then later moved to
list-objects.c.

>  reachable.c | 130 ++++++++----------------------------------------------------
>  1 file changed, 17 insertions(+), 113 deletions(-)

;-) ;-) ;-) ;-) ;-)
