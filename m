Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C12C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 05:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7846F207FB
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 05:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGfXO9wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgIJFJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:09:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51381 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 01:09:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4F2AFAC8D;
        Thu, 10 Sep 2020 01:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k0FOvPsUAFRE3LcU7AW50tUgs6g=; b=lGfXO9
        wk9b9us7NjKmgohWIzRmBmPA6Xz+2Txj15OHOBRtuQidrr1o1efaTXFKiPAjmfd6
        Wy0/n+A6eZu5PxQ0749Eh0YTji8jaMe71L8HY33UCQ+fWfYg1NK8Dqjyug5Z3Jm6
        RdjBtmKlqisV2aMiW6NKMYqx1ZArS5GBPSr6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VCcKb0KnVJwZ6Wl6VKdL3j7rVYYyJPqj
        dtoYwe2rtSFtUiqcrJQcuWm/SVUEmxq7k3DkWG04svtP3iQ4+Q+6GAjuHZ2U1FXv
        3I0AaSfd/CfmkgH41GD91PnsOMvdw9uMXQpD7zRTm8t30y6JyQTuKQi2G+lrkxIP
        D/6IRN37XAo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2735FAC8C;
        Thu, 10 Sep 2020 01:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88BFBFAC8B;
        Thu, 10 Sep 2020 01:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-2-emilyshaffer@google.com>
        <20200910003157.GB667601@google.com>
Date:   Wed, 09 Sep 2020 22:09:05 -0700
In-Reply-To: <20200910003157.GB667601@google.com> (Jonathan Nieder's message
        of "Wed, 9 Sep 2020 17:31:57 -0700")
Message-ID: <xmqqeenarzf2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C101AD3C-F323-11EA-9980-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> A few consequences:
>
> - it's a little briefer, which is nice

Also this makes start always pair with stop, which is cleaner,
especially if there is no extra work.

The current "if you do not want the overhead when not collecting
stats for and showing progress, just avoid calling start---stop
without calling start will be a no-op and safe anyway" arrangement
we have feels a bit kludgy.

> - progress is always non-NULL, so we can't express
>
> 	if (progress) {
> 		for ( ... ) {
> 			... do one chunk of work ...
> 			display_progress(...);
> 		}
> 	} else {
> 		... do work slightly more efficiently, all in one chunk ...
> 	}

Yes, this is the other side of the coin.  When there is significant
difference in the work between with and without progress codepath,
it is convenient to be able to switch on the "progress" pointer
itself.  The progress_is_enabled() helper you bring up later may be
a way to solve it.

> - even if we don't want progress, we always spend the overhead of
>   allocating a progress struct (not a big deal)

True.

> - if 'n' is a more complex expression (e.g. a function call), it gets
>   computed even if we don't want progress.  For example, in "git fsck",
>   as Junio noticed, this means accumulating the object counts from all
>   idx files just to throw them away.

Yes, I think the conceptual muddiness caused by this is what
disturbed me the most.  The cost of counting would likely to be
negligible; developers' time to understand why things are counted
in the first place however is the true waste.

> - the motivation: it means the progress API can be aware of whether
>   the caller wants to write progress to the terminal and has control
>   over what to do with that information.
>
>   In particular this makes the function name display_progress even
>   more of a misnomer --- before this patch, display_progress on a
>   non-NULL progress struct would display some progress information and
>   possibly also write something to traces, but after this patch it
>   sometimes only writes something to traces.

Yeah, this might show us a way to an acceptable solution to the
problem of conceptual uncleanliness, as naming may have a lot to
contribute to it.

> That said, what would an API look like that avoids that?
>
> One possibility would be to make separate initialization and
> start-of-progress calls:
>
> 	struct progress *progress = progress_new(show_progress, the_repository);
>
> 	if (progress_is_enabled(progress)) {
> 		for (...) {
> 			...
> 			total += ...
> 		}
>
> 		start_progress(progress, _("Checking objects"), total);
> 	}

OK.
