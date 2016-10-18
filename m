Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03E820988
	for <e@80x24.org>; Tue, 18 Oct 2016 15:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935301AbcJRPYZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 11:24:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55460 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935077AbcJRPYX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 11:24:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8F65470E8;
        Tue, 18 Oct 2016 11:24:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gZ4Q7w7pV8QFYgPdGCc8+mvA2XA=; b=jkjRtj
        bb98xOV+HHiw8KwK52W9jjV4mVsSvA0yAIUkQUaCOrY3vRHDBakxQ3uIa0xI7IPo
        /zL1L233ueLnhFgJRFABee4pacdOHUG28hCJPsFKoFjPOOsMprxNa8dbUZyL0H1U
        7vyGwoDEn6nIVu92jXv0vlTKcxUiTIyS03HVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YN9sxAf0huxG7gBYAfnyA4mJOYEHH2Or
        LkHu12l1BIRkfeF2pdi08Pw/qq3rO+YzCiqE/7wH+b3vGpOOmTv8egYG433iJSwL
        C/tS81ZgktYhEG78Q6HGFJzaCHzut2sOO+8cYnQz4njXfQb5heRp7KnkoJaWT03E
        0VgMOCzHndw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ED86470E7;
        Tue, 18 Oct 2016 11:24:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2033B470E5;
        Tue, 18 Oct 2016 11:24:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        venv21@gmail.com, dennis@kaarsemaker.net, jrnieder@gmail.com
Subject: Re: [PATCH] submodule--helper: normalize funny urls
References: <20161017221623.7299-1-sbeller@google.com>
Date:   Tue, 18 Oct 2016 08:24:20 -0700
In-Reply-To: <20161017221623.7299-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 17 Oct 2016 15:16:23 -0700")
Message-ID: <xmqqy41lr87v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F206C79E-9546-11E6-9483-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently a URL for the superproject ending in
>
> (A)    .../path/to/dir
> (B)    .../path/to/dir/
> (C)    .../path/to/dir/.
> (D)    .../path/to/dir/./.
> (E)    .../path/to/dir/.///.//.
>
> is treated the same in (A) and (B), but (C, D, E) are different.

You may know what you meant to say with "treated", but the readers
do not know "treated" in what situation you are talking about.  We
need to tell the readers that the bug being fixed is about resolving
a relative URL "../<something>" off of the URL of the superproject
to compute the remote URL for a submodule repository.

> We never produce the URLs in (C,D,E) ourselves, they come to use, because
> the user used it as the URL for cloning a superproject.
> Normalize these paths.

As you know the externally-visible impact of this change (which I
asked you, but didn't see an on-list answer to, by the way), please
describe what this means to the end user in the log message.  It is
normally done in an earlier part of the log message to describe the
problem being solved and its background.

If I understand the issue correctly, it may go like this:

	The remote URL for the submodule can be specified relative
	to the URL of the superproject in .gitmodules.  A top-level
	git://site.xz/toplevel.git can specify in its .gitmodules

		[submodule "sub"]
			url = ../submodule.git
			path = sub

	to say that git://site.xz/submodule.git is where the
	submodule bound at its "sub/" is found.

	However, when the toplevel is cloned like this:

		git clone git://site.xz/toplevel.git/. top

	i.e. the toplevel specifies its URL with trailing "/.", the
	code set the URL to git://site.xz/toplevel.git/submodule.git
	for the submodule, which is nonsense.  This was because the
	logic failed to treat trailing "/." any differently from
	trailing "/<anything-without-slash>" when resolving a
	relative URL "../<something>" off of it.  Stripping "/." at
	the end does *not* take you one level up, even though
	stripping "/<anything-without-slash>" does!
	
And then describe the solution/bugfix, listing A-C (or A-E) and
telling that these will be treated the same way.

