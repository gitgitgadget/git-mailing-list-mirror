Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C59A203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbcGYR2H (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:28:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753027AbcGYR2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:28:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5573E2D172;
	Mon, 25 Jul 2016 13:28:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BnUNWFJb9gJcAYIjj8ulzMcx8Sw=; b=Exj4kB
	OBFoW0kU/YlpV8sEp6Eyc/71G2+jxZ+KD1qHOr66vU2r+3nrpl/8XxdOlwCSj2EF
	EXd9P4B7n9eQhTd60QxBTwMlq52ILqJ0MVhAUbTnB2AWBDULrOioHvzWxqSJxSNe
	WoanPsKmygHbVR4lyBfVakwH4dgDZHLU0qe9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZYJ8noox1LP5wOTmLATO8zrCJSep+rX
	4WmD7Ig88r1xfPuw7H5r8PW5/ZB9gu1Z6IaYpVlrfqToF+5aJDI1LfghcjbrwGSz
	7sk3bYw9fwtkr5rGi9/+ruiiUHUJtaykS5guXQc0BuZ5P6x7HsvJN8QpyGXXDK4B
	0ydPwQ1I0+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CC612D171;
	Mon, 25 Jul 2016 13:28:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D02B72D170;
	Mon, 25 Jul 2016 13:28:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] push: allow pushing new branches with --force-with-lease
References: <6b401124e734d4f5486003459e586cc05c7843e8.1469287889.git.john@keeping.me.uk>
Date:	Mon, 25 Jul 2016 10:28:01 -0700
In-Reply-To: <6b401124e734d4f5486003459e586cc05c7843e8.1469287889.git.john@keeping.me.uk>
	(John Keeping's message of "Sat, 23 Jul 2016 16:31:57 +0100")
Message-ID: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 248F5C28-528D-11E6-B28E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> If there is no upstream information for a branch, it is likely that it
> is newly created and can safely be pushed under the normal fast-forward
> rules.  Relax the --force-with-lease check so that we do not reject
> these branches immediately but rather attempt to push them as new
> branches, using the null SHA-1 as the expected value.
>
> In fact, it is already possible to push new branches using the explicit
> --force-with-lease=<branch>:<expect> syntax, so all we do here is make
> this behaviour the default if no explicit "expect" value is specified.

I like the loss of an extra field from "struct ref".

I suspect that the if/else cascade in the loop in apply_cas() can
also be taught that ':' followed by an empty string asks to check
that the target ref does not exist, in order to make it a bit more
useful for folks who do not rely on the "use the last observed
status of the tracking branch".

That would make the "explicit" test much less cumbersome to read.


> +test_expect_success 'new branch covered by force-with-lease (explicit)' '
> +	setup_srcdst_basic &&
> +	(
> +		cd dst &&
> +		git branch branch master &&
> +		git push --force-with-lease=branch:0000000000000000000000000000000000000000 origin branch
> +	) &&
