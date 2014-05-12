From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: Preserve diff heading when splitting hunks
Date: Mon, 12 May 2014 14:07:15 -0700
Message-ID: <xmqqvbtapuyk.fsf@gitster.dls.corp.google.com>
References: <1399824596-4670-1-git-send-email-avarab@gmail.com>
	<20140512183955.GB31164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 12 23:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjxRl-0004VA-3P
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 23:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758296AbaELVHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 17:07:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50633 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbaELVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 17:07:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44B4F15448;
	Mon, 12 May 2014 17:07:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FRa0JSKV8uBQ3YH1ZKkRST8hahw=; b=ThgmTb
	GiUrb1R6OVeMIaHkQg21virbuY6tgGOJIN8sl1gao8wjmjbsoUfCKQhQkGCWJgqd
	39yclxwXwpHqwQ5WqqpNmtVfJ4it31qd7mUNcYO/w9edjYHDinc8Zr8rQe71NpnF
	gcB98pFAtli1sopZhHSBLOUVvB++CexvGbSSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GxPTenPhLunY2Q7ujsDYHhpLnmW2AFYn
	mytatkHSRaNn4BhF59HF103geBo/vL3cGy6nZuTtRlIEjnfeIZAgXGHL4dO9TO9B
	cNWJ+Fv32z0LTNVRCG3QL9avBwWBmnx47B0tfMSVDVfNoMpHIFoyCMLPqFMbqkP9
	S7Z5/GTT/XE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 391DD15447;
	Mon, 12 May 2014 17:07:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C5F82153EB;
	Mon, 12 May 2014 17:07:16 -0400 (EDT)
In-Reply-To: <20140512183955.GB31164@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 12 May 2014 14:39:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65CD1F16-DA19-11E3-9160-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248734>

Jeff King <peff@peff.net> writes:

> One, there is a slightly funny artifact in that the hunk header comes
> from the top of the context line, and that top is a different position
> for each of the split hunks. So in a file like:
>
>   header_A
>       content
>   header_B
>       one
>       two
>       three
>       four
>
> you might have a diff like:
>
>   @@ ... @@ header_A
>    header_B
>        one
>        two
>   +    new line 1
>        three
>   +    new line 2
>        four
>
> The hunk header for "new line 1" is "A", because "B" itself is part of
> the context. But the hunk header for "new line 2", if it were an
> independent hunk, would be "B". We print "A" because we copy it from the
> original hunk.
>
> It probably won't matter much in practice (and I can even see an
> argument that "A" is the "right" answer).

I tend to agree with both points.

> And figuring out "B" here
> would be prohibitively difficult, I would think, as it would require
> applying the funcname rules internal to git-diff to a hunk that git-diff
> itself never actually sees.

You can actually apply a split hunk being proposed to a temporary
file and then ask "git diff" about it, so I do not think difficult
is too much of an issue, but I doubt we would want to see header_B,
exactly because when the user says "Split this hunk", s/he is very
well aware that the second one is artificial and was split from the
original hunk whose header said header_A.

> Since the output from your patch is strictly better than what we saw
> before, I think there is no reason we cannot leave such an improvement
> to later (or never).

Yes.
