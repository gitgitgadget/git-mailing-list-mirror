Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6993DC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbiHRRQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiHRRP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:15:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2D61104
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:08:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7206614C855;
        Thu, 18 Aug 2022 13:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/yTVRiCbUUfJukT2yOBfvUHOrZH5SD8iP5Q/sq
        xp0JA=; b=j/4wSpb//uOu4PxOFRPv1Hp7oC3PMBu/P628ILg7bRXbdQKuXUk1Me
        +OX3BIGGW1q396G9SbVZCe1/83gx7Hj4bz2AcAOgZJMZP5/eNlrtRbKZQP/YG6JF
        PH0bjAJQPY7KegWxLbmnTER7ZK64aunOJRkzCb0UkpQqhRVAdVaNg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6936A14C854;
        Thu, 18 Aug 2022 13:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C28E614C853;
        Thu, 18 Aug 2022 13:08:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: [Question] How to know which branch(ref) is the latest updated
 branch?
References: <2022081818034939145210@oschina.cn>
Date:   Thu, 18 Aug 2022 10:08:19 -0700
In-Reply-To: <2022081818034939145210@oschina.cn> (lilinchao@oschina.cn's
        message of "Thu, 18 Aug 2022 18:04:49 +0800")
Message-ID: <xmqqa681qy2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C64DB7E-1F18-11ED-8A93-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> In a git based workflow, there are usually many active branches.
> So, is there a convenient way to quickly know which branch is the
> latest updated?

These days "git branch" has "--sort" option, inherited from "for-each-ref",
so

    git branch --sort=-committerdate

lists them from the most-recently-committed [*].

HOWEVER.

There is no way to sort on the time when each branch was last
updated.  You may do

    git branch newbranch HEAD@{2.years.ago}

to create a new branch (i.e. it is the last updated branch) that
points at a commit that existed 2 years ago (hence it would be at
least 2 years old, possibly more).  If for-each-ref learns a new
placeholder %(reflogtime) that can be used to represent the
timestamp of the latest reflog entry, you should be able to sort by
the time when branch was last updated, but not until then.


[Footnote]

I have this handy alias

    [alias]
    notyet = branch --no-merged jch --no-merged seen --sort=-committerdate '??/*'

to remind me of topics that are not yet in my integration branches
while rebuilding them.

In the end result, 'seen' is supposed to include "everything I saw
and found possibly interesting", and 'jch' is supposed to be a
subset of it, but explicitly saying "show branches that are not in
either of these two" helps while rebuilding them (and I do so a few
times a day).
