From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] add --simplify-combined-diff option
Date: Tue, 29 Jul 2014 13:02:39 -0700
Message-ID: <xmqqd2co2asg.fsf@gitster.dls.corp.google.com>
References: <20140729175300.GA21536@peff.net>
	<20140729175712.GD31181@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 22:02:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCDbo-00088O-QX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 22:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbaG2UCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 16:02:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54678 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbaG2UCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 16:02:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 463E62D7E9;
	Tue, 29 Jul 2014 16:02:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QH4KtpXNVOyagsETefmpiveYkFY=; b=cUqPm+
	qpJg76sdKHNbCu23+hXxXKuGHxgzY6sZICTZ7P8+cQC1XvrRU/ViSnH0UghHNmjF
	uxYeJ+aRpJUSt6rrvskdqsOVf1z7l/lLeMZft/sV9OMfEd7UDDfLnFBxy/PtDz5X
	59XwulwTDh3EhABK7Lkb8azUcD15wTxPPGJ3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjvmJ2U9Eb3Sx4l52BrdBnvNQEtrpi9n
	QwS13ith1FykVmrowTC1sSZKEEa82LLHJ7VoROSuDbPOfFbPhi6+H2iDnFYQfIRN
	HEQnGnMCI0tNECLRh7AZT5ZdL+sGp4IuMERUGtg6PNrEHqvWoTgjSz2mhkcfpqlg
	3tR8ZUI054g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CED82D7E8;
	Tue, 29 Jul 2014 16:02:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8C3C2D7D2;
	Tue, 29 Jul 2014 16:02:40 -0400 (EDT)
In-Reply-To: <20140729175712.GD31181@peff.net> (Jeff King's message of "Tue,
	29 Jul 2014 13:57:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4BC0B612-175B-11E4-9A5E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254466>

Jeff King <peff@peff.net> writes:

> When showing a combined diff, we are comparing two (or more)
> parents to a final state, and some of these states may be
> the same.  Here's a table of the possible contents for a
> given path (for two parents, but we will generalize to more
> in a moment; we also omit isomorphic cases where the parents
> are swapped):
>
>   case | M | P1 | P2
>   -------------------
>   1    | A | A  | A
>   2    | A | A  | B
>   3    | A | B  | B
>   4    | A | B  | C
>
> In case 1, the path was not relevant to the merge at all,
> and we omit it as uninteresting. In case 2, we did resolve
> the path, but in favor of one side. We also consider this
> uninteresting and do not show the diff.
>
> In case 4, we had a real content-level merge, and the
> combined diff is interesting. We show it.
>
> That leaves case 3, in which both parents are the same, but
> the merge picks a new content. This should be rare in
> normal merges, though it could happen if you updated an
> unrelated file due to a resolution elsewhere (i.e., an evil
> merge that crosses a file boundary). But it happens
> frequently in the fake merge commits we create for stashes,
> in which one parent is the base of the stash and the other
> is the index (in which case it simply means that the index
> entry for the path was not touched).
>
> Right now, we treat it the same as case 4, and show a normal
> combined diff. However, the result is harder to read, and
> the combined nature of the diff gives no extra information;
> every marker in the combined diff will be identical for both
> parents.
>
> This patch adds a new option, "--simplify-combined-diff",
> which converts this case into a normal, non-combined diff.
> It would not be correct to simply omit it, because there
> really is an interesting change going from B..A. It's just
> that there are not two interesting changes, which the
> combined diff would show.
>
> When generalizing this to more than two parents, we have two
> options:
>
>   1. Either simply to a single parent content, or not at all.
>
>   2. Omit parents whose contents are duplicates of other
>      parents.
>
> For a case like "A B B C", option (2) would still result in
> a combined diff, but one with fewer sources. However, it
> would also be ambiguous. The parents in a combined diff are
> marked only by their position, so omitting a position means
> that a reader can no longer tell which line goes with which
> parent.
>
> Instead, we choose option (1). Either you get the full
> combined diff, or you get a normal non-combined diff.

Very nicely analyzed.  The changes to the code looked also good from
a cursory read.

Thanks.
