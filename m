Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701AC10F29
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B478C2077E
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 18:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8/kbj3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCRSrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:47:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55167 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 14:47:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5E5439925;
        Wed, 18 Mar 2020 14:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TOnW6yVMcuLTW2vVx3Ao72GiEEE=; b=Y8/kbj
        3oJBEcCLG301TPJBQCeNoMB/1ylDeuVEVX2g1pK5mhmn5Pt1GcELf3VZ1ZKoBKpo
        NBDrr/lJR2jNQBGkkzgWBQHkCHDw3Ucd2x97zrHG1M53+hpu5nBW0HBTKRkAMiB8
        7BiT8WQUWypB5rdevb/h8W4jALDs6a+R/kVQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wN+HPOy5MVFX1ydQOppOBr/K3KrgirVX
        Yry+/3js/cec4zZNARoo0+V/L/CbuQXtAsVHlu/XNjv/yejPl9AGKWvB7OgScKhc
        YlvogXnAGEXNpO8xWPDFvZ1OX3yt0mGNldVzxZEaOrUTXpZRf4KPbRRKqcDCZ8W/
        DSau7ZkZ5QY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CFF639923;
        Wed, 18 Mar 2020 14:47:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8A1839920;
        Wed, 18 Mar 2020 14:47:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        newren@gmail.com
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
References: <20200309205523.121319-1-jonathantanmy@google.com>
        <20200318173051.25875-1-jonathantanmy@google.com>
Date:   Wed, 18 Mar 2020 11:47:07 -0700
In-Reply-To: <20200318173051.25875-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 18 Mar 2020 10:30:51 -0700")
Message-ID: <xmqqpnd9fql0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE80687C-6948-11EA-855B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When rebasing against an upstream that has had many commits since the
> original branch was created:
>
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
>
> it must read the contents of every novel upstream commit, in addition to
> the tip of the upstream and the merge base, because "git rebase"
> attempts to exclude commits that are duplicates of upstream ones. This
> can be a significant performance hit, especially in a partial clone,
> wherein a read of an object may end up being a fetch.

OK.  I presume that we do this by comparing patch IDs?

Total disabling would of course is OK as a feature, especially for
the first cut, but I wonder if it would be a reasonable idea to use
some heuristic to keep the current "filter the same change" feature
as much as possible but optimize it by filtering the novel upstream
commits without hitting their trees and blobs (I am assuming that
you at least are aware of and have the commit objects on the
upstream side).

The most false-negative-prone approach is just to compare the
<author ident, author timestamp> of a candidate upstream commit with
what you have---if that author does not appear on my-dev-branch, it
is very unlikely that your change has been accepted upstream.  Of
course, two people who independently discover the same solution is
not all that rare, so it does risk false-negative to take too little
clue from the commits to compare, but at least it is not worse than
what you are proposing here ;-)  And if one of your commits on
my-dev-branch _might_ be identical to one of the novel upstream ones,
at that point, we could dig deeper to actually compute the patch ID
by fetching the upstream's tree.

That's all totally outside the scope of this patch.  It is just a
random thought to see if anybody wants to pursue to make the topic
even better, possible after it lands.

> New in V2: changed parameter name, used Taylor's commit message
> suggestions, and used Elijah's documentation suggestions.

Hmph, what was it called earlier?  My gut reaction without much
thinking finds --no-skip-* a bit confusing double-negation and
suspect "--[no-]detect-cherry-pick" (which defaults to true for
backward compatibility) may feel more natural, but I suspect (I do
not recall details of the discussion on v1) it has been already
discussed and people found --no-skip-* is OK (in which case I won't
object)?

I also wonder if --detect-cherry-pick=(yes|no|auto) may give a
better end-user experience, with "auto" meaning "do run patch-ID
based filtering, but if we know it will be expensive (e.g. the
repository is sparsely cloned), please skip it".  That way, there
may appear other reasons that makes patch-ID computation expensive
now or in the fiture, and the users are automatically covered.

