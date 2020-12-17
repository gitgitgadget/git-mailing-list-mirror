Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B53C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66A7239ED
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgLQTuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:50:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59144 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgLQTuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:50:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2E95108043;
        Thu, 17 Dec 2020 14:49:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/LLZmZbQha0+KowAWoJPRXhShFw=; b=Gtd47o
        eegkiEY2jSxRHArWSO9b4w0edIT2OSrQmsRiFOyZTwd95dZHHrZ+Mnz3oqImtULP
        xAGVena5gu44oLGaTtBPuE3qpq8eQWAw4Rzn/MnaGQc8wfeN9VvK7NH6dV6II4J4
        /28mSc6ujLdyjIaIAD4C7veLOLdo+YPVbcrkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y9/D1LC/h5Qsq2XF6yXWWVDIxIg28K9r
        eAlTSQmx6GdXJjwUBjybR66X1eHRLK+KOUxSml+8vSg0VBJ8I/d822VUK9aPZQY9
        QEDRchnLenT5FfvKK0kCfHq9S3KI0B2oC7WTAF1zcQ76dCg/2hUOqmkZlzUelzwo
        105/F3uEvUk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB9D8108042;
        Thu, 17 Dec 2020 14:49:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE13D108041;
        Thu, 17 Dec 2020 14:49:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: teach `repair` to fix multi-directional breakage
References: <20201208173705.5770-1-sunshine@sunshineco.com>
        <xmqqwnxs55rn.fsf@gitster.c.googlers.com>
        <CAPig+cQT2Cj4i=2kq_svMyKiFmNLxvpa5kG=XNeaT+8UD5238Q@mail.gmail.com>
Date:   Thu, 17 Dec 2020 11:49:21 -0800
In-Reply-To: <CAPig+cQT2Cj4i=2kq_svMyKiFmNLxvpa5kG=XNeaT+8UD5238Q@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 17 Dec 2020 05:22:54 -0500")
Message-ID: <xmqqwnxgxlfi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5E46BBE-40A0-11EB-B324-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> We only have the paths making the two-way link between the repository
> and the secondary worktrees. Specifically, the outgoing
> <repo>/worktrees/<id>/gitdir points at /path/to/worktree/.git, and the
> incoming /path/to/worktree/.git points at <repo>/worktrees/<id>.

Yes.

> The inference is intentionally simple-minded. There is no path-based
> inference or other heuristic at play; the entire inference is based
> upon <id>. The worktree's path is specified as an argument. `git
> worktree repair` manually reads the ".git" gitfile at that location
> and, if it is well-formed, extracts the <id>. It then searches for a
> corresponding <id> in <repo>/worktrees/ and,...

That is exactly the point I got confused.  The worktree's path comes
as an argument from the user, so we'd trust it.  And it has ".git"
that is a gitfile that used to point at <repo> but because we are
trying to deal with a situation where both worktree and repo moved,
it cannot be used to learn where <repo> is.  Then, even after
learning what <id> to use, how would we know where to use that <id>
to find <repo>/worktrees/<id>, when the location of <repo> is unknown?

I think the answer is "where the user starts the 'git worktree'
command has to be under control of some repository (perhaps found by
a call to setup_git_directory()), and we'd use that one as <repo>".

Since I did not see that (in hindsight an obvious) piece, I failed
to see how it could possibly work.  But now it is clear.

Thanks.
