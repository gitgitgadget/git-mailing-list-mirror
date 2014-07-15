From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] alloc: write out allocator definitions
Date: Tue, 15 Jul 2014 13:11:41 -0700
Message-ID: <xmqqzjgatm9u.fsf@gitster.dls.corp.google.com>
References: <20140713064116.GA4768@sigill.intra.peff.net>
	<20140713064150.GB4852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X794r-0007cS-B2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 22:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367AbaGOULu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 16:11:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61862 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757029AbaGOULs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 16:11:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 059E9296E6;
	Tue, 15 Jul 2014 16:11:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z0z3inmyPLUZa1jRnh4aIwPXAS0=; b=KVCYfk
	Et3OH5ZPT2ZiPlkRZmhfaU9Zz680Z1xnpfu6ArDmRnN3ZEAkIRxy8tqUvWIux/wZ
	9iQMuwSc0QBgW7J7B0sPc7KlyILqvRHgJGYufu4Ug8pBLZgstjdYx24vb5aYhdvM
	4gXXy/3dUiGOtzRBaX/W4hJlltufgZTUIUA1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZkUqvClGTfqK2x/p8L2KFmaVDWWAs+q9
	V7WJ+I9iaY/dgqfaKOoa/5YClBtViLnJ77NxoeHvfYbzir8UkXLFjfCKxVAYWMS4
	oWv+Skc4YdxwbrLWJ5Ow1Pl9Nj4DdjhqKI76ZcBy00VEtoDcTndpayZClOIxDR9g
	NkbVznpcHHs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0E9B296E4;
	Tue, 15 Jul 2014 16:11:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E5A4A296DC;
	Tue, 15 Jul 2014 16:11:24 -0400 (EDT)
In-Reply-To: <20140713064150.GB4852@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 13 Jul 2014 02:41:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 325DF310-0C5C-11E4-B666-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253598>

Jeff King <peff@peff.net> writes:

> Because the allocator functions for tree, blobs, etc are all
> very similar, we originally used a macro to avoid repeating
> ourselves. Since the prior commit, though, the heavy lifting
> is done by an inline helper function.  The macro does still
> save us a few lines, but at some readability cost.  It
> obfuscates the function definitions (and makes them hard to
> find via grep).
>
> Much worse, though, is the fact that it isn't used
> consistently for all allocators. Somebody coming later may
> be tempted to modify DEFINE_ALLOCATOR, but they would miss
> alloc_commit_node, which is treated specially.
>
> Let's just drop the macro and write everything out
> explicitly.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  alloc.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> ...
> +static struct alloc_state blob_state;
> +void *alloc_blob_node(void)
> +{
> +	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
> +	return b;
> +}

I think the change makes the code nicer overall, but it looks
strange to see a (void *) that was returned by alloc_node()
implicitly casted to (struct blob *) by assignment to b and then
again implicitly casted to (void *) by it being the return type of
the function.

Is there a reason why it is not like so?

	void *alloc_blob_node(void)
        {
                return alloc_node(&blob_state, sizeof(struct blob));
	}

I may have missed previous discussion on it, in which case I'd
apologize in advance.
