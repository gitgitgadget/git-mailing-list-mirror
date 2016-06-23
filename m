Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7DA1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcFWT4N (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:56:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751380AbcFWT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:56:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C719125F8E;
	Thu, 23 Jun 2016 15:56:10 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Mg20SNfWQv+j/NAo6l+MHY+Na4=; b=qqizwZ
	RaSSJ07l+JWOKmwHSVqwKedAFBkQM/l4WpSBnL5L6D5nCi8odtXyFXDsHb/CloK6
	Vo5aL6j6IPQQYylBk2aZCWkfePjNRCGE1P2JT6o4W+ZQSWs+t4qsBZGsyrM4azG9
	7gr2EsSVGdUi/VuoyngALIYgVF58jMJTbY8DI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fa8dqXEqbvjlRWhxpGNLJNjDjYc4FD6c
	kq1QYmtfuw6E5XaaTWfoiC/ZGKN9UgELD6as1NEvzLDDTDuv+0n4QSP1ZIcWmxPB
	6begLqRXc1aFOscOyrK19LS3RMK4NeK5nc9wwJkmbr4bRY+5LetMQpBZdX0qro6e
	6+huuLdTF7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BFB4025F8D;
	Thu, 23 Jun 2016 15:56:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A0CE25F8C;
	Thu, 23 Jun 2016 15:56:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
References: <20160623173048.GA19923@sigill.intra.peff.net>
	<20160623174015.GG15774@sigill.intra.peff.net>
	<xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
	<20160623183907.GA32368@sigill.intra.peff.net>
Date:	Thu, 23 Jun 2016 12:56:08 -0700
In-Reply-To: <20160623183907.GA32368@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 14:39:08 -0400")
Message-ID: <xmqq7fdfisrr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88149F12-397C-11E6-9760-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... but with --color-words, it actually helps quite a
> bit (try it on the documentation patch from this series, for example).

This gets me back to another tangent, but this time a one that is
quite a lot more relevant to Git.

There is this change in "git show --word-diff" for the "italic"
patch:

    The accepted attributes are `bold`, `dim`, `ul`, `blink`,
    {+`reverse`,+} and [-`reverse`.-]{+`italic`.+}

If we imagine that the pre- and post- image expressed in "one token
per line" format, the text before and after the patch would have
read like this:

    preimage		postimage
    -----------         ------------
    ...			...
    blink		blink
    ,			,
    and			reverse
    reverse		,
    .			and
    			reverse
                        .

And the current output is showing an equivalent of this diff:

	...
        blink
        ,
       +reverse
       +,
        and
       -reverse
       -.
       +italic
       +.

But if we were doing line-level diff for the above two, I would
think this is much easier to read:

	...
        blink
        ,
       -and
        reverse
       +,
       +and
       +italic
       +.

That would give us a word-diff more like this, I would imagine,

    The accepted attributes are `bold`, `dim`, `ul`, `blink`,
    [-and-] reverse[-,-] {+and `italic`}.

and that would be much easier to read than the current --word-diff
output.
