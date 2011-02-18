From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revlist.c: introduce --cherry for unsymmetric
 picking
Date: Fri, 18 Feb 2011 11:42:42 -0800
Message-ID: <7vzkptnn7x.fsf@alter.siamese.dyndns.org>
References: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 20:43:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqWEE-0001qE-Gu
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 20:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758340Ab1BRTmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 14:42:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab1BRTmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 14:42:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98F0B352C;
	Fri, 18 Feb 2011 14:43:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VjudQX3A/VgvdEzDoWJlevUwpWM=; b=Vr55yx
	cNbWC8uYLPY57JrFgFxHJHWBhAhGKwaK43nzMsyM/Wvs/m52yMB+Z9IHtU9DkYp/
	F10QQN50oXglghW1gdE4g3JqGPriOZpUu3pejOYUZC3PkIZfNdgV9tx648z1azEi
	HmQbSYG/xoBdXyhiwXOEIii5LkkCqXcWV9MIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fb2fOHgjG5zW9eBHG9SaQkotAInx9up3
	LL9ApQ/ThzCPjxvCySfd0XYY+uIumV72ZoUdYXRHfW2OynQavuPv8UOfW+8VoanI
	/1eomfetTgV7w0dINkixc80mGDat2eHRbU4vGOO/YgLNk4SPphEbMyaszanCo/Pw
	0vSwM5l8bUs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 727BA352B;
	Fri, 18 Feb 2011 14:43:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 59398352A; Fri, 18 Feb 2011
 14:43:54 -0500 (EST)
In-Reply-To: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 18 Feb 2011 13\:34\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6CE6BB78-3B97-11E0-9EA3-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167226>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The existing "--cherry-pick" does not work with unsymmetric ranges
> (A..B) for obvious reasons.
>
> Introduce "--cherry" which works more like "git-cherry", i.e.: Ignore
> commits in B which are patch-equivalent to patches in A, i.e. list only
> those which "git cherry B A" would list with a "-". This is especially
> useful for things like
>
> git log --cherry @{u}..
>
> which is a much more descriptive than
>
> git cherry @{u}
>
> and potentially more useful than
>
> git log --cherry-pick @{u}...
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

A few comments.

As a Porcelain tool, "log --cherry @{u}.." may very well be useful; what
do I have that I still need to send.  It is the moral equivalent of what
format-patch does internally.

However I don't find it "works more like 'git-cherry'" at all.  The point
of the command is to show _both_ what are still left to be sent, and what
are already accepted.  So it is very much inherently a symmetric-range
operation.  At the plumbing level (which 'git-cherry' was designed to be),
we should be able to ask for either (or both).  Adding a "we are only
interested in the right hand side" as a rev-list option is somewhat
distasteful and short-sighted.

I wonder if you can instead extend the revision walking machinery by just
adding a filter that says "show me only the left/right hand side" [*1*]?
I.e.

    git rev-list --right-only --oneline --cherry-pick @{u}...

If that is done, we could ask for "--left-only" when we wanted to.

As there are by definition more contributors than integrators, naturally
we can expect that "--right-only" would be a lot more often used mode of
operation than "--left-only", and I don't mind to have "--cherry" as a
synonym to trigger "--cherry-pick --right-only" (and perhaps internally
turn a two-dot automatically into three-dot), so that you can say

    git log --cherry @{u}..

from the command line to get the same effect.

By the way, when this feature is properly implemented internally at the
revision traversal level, we should be able to lose quite a lot of code
from builtin/log.c, as format-patch in it was the original implementation
of the whole thing, and it was done outside the revision walking machinery
to implement patch equivalence filtering of the traversal result.  We
would essentially feed the symmetric upstream...HEAD range with the
cherry-pick flag, ask it to give only the right hand side (i.e. what are
left after the patch equivalence filter), and emit the result.

The get_patch_ids() function itself can go, and its caller and the
codepaths that use has_commit_patch_id() would be vastly simplified, no?


[Footnote]

*1* It might be even interesting to add a mode that allows you to ask for
only the matching ones, but that would take somewhat a different logic in
cherry_pick_list() in revision.c.  Instead of filtering out the equivalent
ones, you would need to keep them, painted in yet another color.
