Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C12C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F5460698
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhGNRNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:13:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54980 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbhGNRNO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:13:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E37F6CFFCA;
        Wed, 14 Jul 2021 13:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bIOJStI6RkSdSuS6HCeEfD2QzxcCkmgKAazbtw
        h45+U=; b=dkpoKesu7pKN4F7PZHtcwREk2X5/A3wl8dqDoe7twY7ROxq0dJtrJC
        ie8UDV9EKOSmjzkgC+BJD8Wjyqb3tSLD49c7v4XEkRz4ls5UuT4jQO+dEr0R46rH
        qHqPMKxSjaYXNHzMTLY2CfPgVGR4sFSF+eOADV2Ed21Pd8JNYXwoM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBD18CFFC8;
        Wed, 14 Jul 2021 13:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EE4ECFFC7;
        Wed, 14 Jul 2021 13:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Patch 2/3] Documentation/config.txt: add worktree includeIf
 conditionals.
References: <20210712223139.24409-1-randall.becker@nexbridge.ca>
        <20210712223139.24409-3-randall.becker@nexbridge.ca>
        <xmqqr1g1zow4.fsf@gitster.g>
        <006b01d778b6$b74b8600$25e29200$@nexbridge.com>
Date:   Wed, 14 Jul 2021 10:10:20 -0700
In-Reply-To: <006b01d778b6$b74b8600$25e29200$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 14 Jul 2021 09:46:52 -0400")
Message-ID: <xmqqczrkyg77.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EFF5824-E4C6-11EB-8D0D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>>Assuming that I guessed correctly, is this a deliberate design
>>decision not to "automatically add ** after a pattern that ends
>>with a slash", and if so why?  I would have thought that "in the
>>worktrees that I create inside /var/tmp/, please enable these
>>configuration variables" would be a fairly natural thing to ask,
>>and I do not immediately see a reason why we want to apply
>>different syntax rules between "gitdir" and "worktree".

> The reason for this comes down to what is in
>*the_repository.

Sorry, but I still do not understand.

> Essentially, the_repository->gitdir always has a /path/to/.git
> directory with full qualification.

Yes.

> the_repository->worktree does not have /.git added
> for obvious reasons, so the /path/to is bare of the trailing
>/.

It may be the case, but /path/to/.git does not have trailing slash,
either, so I do not see the relevance.

When you say [includeIf "gitdir:/path/"], the "behave as if ** is
added after the slash at the end" rule kicks in, and the pattern
"/path/**" is used to see if it matches "/path/to/.git" and it does,
right?  When you say [includeIf "worktree:/path/"], wouldn't the
resulting "/path/**" match "/path/to"?

By the way, I think [PATCH 1/3] should turn the body of
include_by_gitdir() to a common helper function that

 - accepts a path to a directory and a pattern
 - turns it into a relpath
 - prepares the pattern with prepare_include_condition_pattern()
 - do the match include_by_gitdir() does.

and make include_by_gitdir() a very thin wrapper that passes
opts->git_dir to that common helper.  Then you do not have to copy
the entire function to create your new include_by_worktree(); it can
be another very thin wrapper that passes the_repository->worktree
instead of opts->git_dir to the common helper, as there is no other
difference in these two functions.

Thanks.
