Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CF1C43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3FC206B7
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uC4cnYro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIQUVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:21:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65413 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIQUVo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 16:21:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15AFB882C9;
        Thu, 17 Sep 2020 16:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ehe/NkA6qrP2lgmFsflZ4jcrmpw=; b=uC4cnY
        romS8dWKbomuPzywIAYxSSPhYTWW44nUD65wYEphDqmYEDGDqVAgxIO3vhM5YGRA
        M2zU0lG4XQdB60YEowriuycY4lm1sROqCJ8CdCQdaFLH0Zhph/bLx9bChrov+3nS
        XuyXLqu8ka4wRAvEQzfzY7/C7OLRCBvWKzBwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NyV/zUhrdHVb7CSKlxUJt9Ewz+Ry966D
        C7Jb+IRZSLIUT8YcHOyoeHyG0pz/RzqoQI/ViEZXtMDxK6AWscVPHMIzVnHXv0gw
        kkSBbLpJT+9oX1jCxYquKnrRYrJ01U+iIc1lJZeAg4Kj4LefwHHIv4+eHBDskYI/
        6wxkfhdAh8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D7EC882C7;
        Thu, 17 Sep 2020 16:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B0D7882C6;
        Thu, 17 Sep 2020 16:21:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
        <20200821215247.758978-2-jacob.e.keller@intel.com>
Date:   Thu, 17 Sep 2020 13:21:40 -0700
In-Reply-To: <20200821215247.758978-2-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 21 Aug 2020 14:52:47 -0700")
Message-ID: <xmqqh7rwqhm3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65D4F6D4-F923-11EA-A977-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Both fetch and push support pattern refspecs which allow fetching or
> pushing references that match a specific pattern. Because these patterns
> are globs, they have somewhat limited ability to express more complex
> situations.
>
> For example, suppose you wish to fetch all branches from a remote except
> for a specific one. To allow this, you must setup a set of refspecs
> which match only the branches you want. Because refspecs are either
> explicit name matches, or simple globs, many patterns cannot be
> expressed.
>
> Add support for a new type of refspec, referred to as "negative"
> refspecs. These are prefixed with a '^' and mean "exclude any ref
> matching this refspec". They can only have one "side" which always
> refers to the source. During a fetch, this refers to the name of the ref
> on the remote. During a push, this refers to the name of the ref on the
> local side.
>
> With negative refspecs, users can express more complex patterns. For
> example:
>
>  git fetch origin refs/heads/*:refs/remotes/origin/* ^refs/heads/dontwant
>
> will fetch all branches on origin into remotes/origin, but will exclude
> fetching the branch named dontwant.
>
> Refspecs today are commutative, meaning that order doesn't expressly
> matter. Rather than forcing an implied order, negative refspecs will
> always be applied last. That is, in order to match, a ref must match at
> least one positive refspec, and match none of the negative refspecs.
> This is similar to how negative pathspecs work.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>
> I realize this probably needs to be broken down into multiple patches, but I
> haven't quite figured out the best way to do that. I'd like to avoid the
> case where a commit has support for parsing negative refspecs but code paths
> which use refspecs aren't handling them correctly. Thoughts?
>
> Splitting would also allow additional space for explanations of some of the
> trickier logic.
>
> I am also definitely looking for more test ideas, to help make sure we
> cover a good variety of the flows.

Anybody wants to help this move forward?

I plan to send a review with the patch in the current form, without
waiting for any splitting, later towards the weekend, though.
