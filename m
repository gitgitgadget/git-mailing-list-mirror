Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11783C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E166112F
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhETAum (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:50:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETAum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:50:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CCA5B8DCF;
        Wed, 19 May 2021 20:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vL71SgRSpKpPphZsEsfWDDie3kcUQgyWrunIrD
        tkOMw=; b=EAXPaz/T+1eTnusblxSQVlztm3cNf4nJ1EX8CMkM9CEJBXbym9DP71
        VRqU3nuRQMsv7q0GKhWUy0xip3cGtsImHnAQQ2yIQ8Tw5xzy7WmWRjC3BEUDF48l
        TOGr+czZg7tsGDc91wjXaBi24ZgBlJVtWREtSeU0sZtZCDto0tapI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EB14B8DCE;
        Wed, 19 May 2021 20:49:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5AC7B8DCC;
        Wed, 19 May 2021 20:49:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
References: <YKWggLGDhTOY+lcy@google.com>
Date:   Thu, 20 May 2021 09:49:20 +0900
In-Reply-To: <YKWggLGDhTOY+lcy@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 16:34:24 -0700")
Message-ID: <xmqqeee2w7ov.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36B7FFDE-B905-11EB-A318-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> One kind of signal we haven't been able to make good use of is error
> rates.  The problem is that a die() call can be an indication of
>
>  a. the user asked to do something that isn't sensible, and we kindly
>     rebuked the user
> ...
>  e. we encountered an internal error in handling the user's
>     legitimate request
>
> and these different cases do not all motivate the same response.
> ...
> In order to do this, I would like to annotate "exit" events with a
> classification of the error.

We already have BUG() for e. and die() for everything else, and
"everything else" may be overly broad for your purpose.

I am sympathetic to the cause and I agree that introducing a
finer-grained classification might be a solution.  I however am not
sure how we can enforce developers to apply such a manually assigned
"error code" cosistently.

Just to throw in a totally different alternative to see if it works
better, I wonder if you can teach die() to report to the trace2
stream where in the code it was called from and which vintage of Git
it is running.

The stat collection side that cares about certain class of failures
can have function that maps "die() at <filename>:<lineno>@<version>"
to "what kind of die() it is".  

E.g.  blame.c:50@v2.32.0-rc0-184-gbbde7e6616" may be BUG(), while
blame.c:2740@v2.32.0-rc0-184-gbbde7e6616 may be an user-error.

That way, our developers do not have to do anything special and
cannot do anything to screw up the classification.
