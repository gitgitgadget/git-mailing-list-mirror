Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2492CC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BB7611CB
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJTWK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:10:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58353 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTWKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 18:10:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F74BF5BD1;
        Wed, 20 Oct 2021 18:08:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hZcUcS/DMWeffDGwv+rCOq+I2qFEDCQAoRom/w
        MJZsg=; b=JVmtZuUJG2BcBFAek4CwCelp2fBdGHo2Nd/tCG+P2J9ZV7VU8BPpRM
        5BiT0ARvEj14vDFr+gXRgAv7H6FJ/SaKuYgxWjUigU3VkTfgtBj68GNxV87iW9SB
        erhUYFO205Z29zF+qRlPYZDxQQc5An3El59anCosCra0OwrX6ixhw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16FDBF5BD0;
        Wed, 20 Oct 2021 18:08:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E22EF5BCF;
        Wed, 20 Oct 2021 18:08:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <20211013193127.76537-1-chooglen@google.com>
        <20211019224339.61881-1-chooglen@google.com>
        <20211019224339.61881-3-chooglen@google.com>
        <xmqqzgr3o4yw.fsf@gitster.g> <xmqqtuhbo2tn.fsf@gitster.g>
Date:   Wed, 20 Oct 2021 15:08:08 -0700
In-Reply-To: <xmqqtuhbo2tn.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Oct 2021 13:31:48 -0700")
Message-ID: <xmqqk0i7nyd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35B754FC-31F2-11EC-89DF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In any case, any public facing entry point, like pushremote_get()
> that is directly called from cmd_push() with just a name, should
> auto vivify an instance of struct remote_state and populate its
> members as needed, I think, and in this particular case, I suspect
> that it forgets to initialize the current_branch and other members
> by calling read_config(), just like other entry points like
> repo_remote_get() do.

I give up (for the day at least).  I am not quite sure where things
are going wrong.

There are a few bare repositories (that hold preformatted
documentation trees) next to my primary working tree, and I do

	for topic in htmldocs manpages
	do
		printf "%s: " "$topic"
		( cd ../git-$topic.git && git push "$@") || exit
	done

where "$@" is often nothing, and the backtrace I showed was from
such a push that uses "no remote specified?  push to the origin".
The configuration in these bare repositories do not have anything
particularly interesting.  It has three URLs, and pushes the same to
all three.

[core]
	repositoryformatversion = 0
	filemode = true
	bare = true

[remote "origin"]
        url = gitolite.kernel.org:/pub/scm/git/git-htmldocs.git
        url = github.com:gitster/git-htmldocs.git
	url = repo.or.cz:/srv/git/git-htmldocs.git
        push = refs/heads/master:refs/heads/master
