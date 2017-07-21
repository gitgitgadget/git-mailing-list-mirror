Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9410D1F600
	for <e@80x24.org>; Fri, 21 Jul 2017 06:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbdGUGBt (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 02:01:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51403 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752269AbdGUGBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 02:01:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B65B93692;
        Fri, 21 Jul 2017 02:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SNDoJGBJSwAn1ANWYTraH5fLD3A=; b=Dq+n+E
        VB2qvh/EQD31UiLZgRmRqmhEHHezzyVTyQMDGZ9YY2T2v1NpbbU3MzHkQoEntCJf
        /LI85gUKPwwB+WVUufVNrWWEwtvaBfglQw9cBb2oi1MINpFi0QuO4GOrtDS0NNOF
        6Rc0Et1HEYjaTCoCgSGV9j+rUDuC3vDF02wJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ju3dDjSQbuXYyItgNNy8sBk5+GhOjZVA
        uupGAXuqyLNvcJ/rdMF1JSpj4YZ+Z3jcsh8I1jMw4y6wgGAIwszWlsjxZ5WgnCQP
        bTRHYWRRBKxiZhFfkhUrWSAuMWwalMMEUB8Gbh+HQIfu6achDa6f/aXWr7GddNby
        ayHh3WJvPFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 441E893691;
        Fri, 21 Jul 2017 02:01:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 991CA9368F;
        Fri, 21 Jul 2017 02:01:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate from the lockfile
References: <cover.1497534157.git.mhagger@alum.mit.edu>
        <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
        <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com>
        <20170720233051.GB159617@aiede.mtv.corp.google.com>
Date:   Thu, 20 Jul 2017 23:01:45 -0700
In-Reply-To: <20170720233051.GB159617@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 20 Jul 2017 16:30:51 -0700")
Message-ID: <xmqqpocuib06.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 142F9C8A-6DDA-11E7-B608-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Do we care about the ancient layout that used symlinks to emulate
>> the more modern worktree one?
>
> I think we do care.  In the context of people's changing workflows,
> "git worktree" is a relatively new tool.  Breaking the older
> git-new-workdir (and tools that emulate it) would affect a large
> number of users that don't necessarily know how to clean up the
> result.

Fair enough.  Even though the git-new-workdir is on its way out, and
we really do want to do certain updates under lock, we cannot just
allow the topic to graduate to 'master' in its current form without
some transition plan or mitigation strategy.

The general strategy we take for these atomic update of a file
entity at $path is to:

 (1) try to create $path.lock exclusively; if we cannot, somebody
     else holds the lock so fail (or backoff and retry, which
     amounts to the same thing in the larger picture).

 (2) update $path.lock and close the fd.

 (3) rename $path.lock to $path atomically to unlock.

Would it be sufficent to tweak the above procedure with a new,
zeroth step?

 (0) see $path is a symlink; if so, readlink it and assign the
     result to $path.  Then go on to step (1) above.

I do not think such an enhancement would break atomicity guarantee
we want from the locking.  When updating .git/packed-refs in an
ancient new-workdir'ed directory, we would end up locking the
corresponding file in the real repository, which is exactly what we
want anyway.  As the basic assumption of having a symbolic link in
the new-workdir'ed directory is that a symlink can stay the same
forever while the linked target will be updated, I think this would
be a reasonable short-term "fix".

It would be ideal if we can do this at somewhat a low level, i.e. in
the lockfile subsystem.

Thoughts?  An even easier way out may be to just make pack-refs a
no-op when .git/refs/ is a symbolic link, but as a solution that is
far from satisfactory, while "locking the right file" smells right,
at least to me.

