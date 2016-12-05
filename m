Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE821FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbcLES2n (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:28:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60737 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752104AbcLES2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:28:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAC855530D;
        Mon,  5 Dec 2016 13:28:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZlnQYKmbfrCdAKGdOWnI+pRwkDk=; b=kbCFcd
        v+PfNf9mt2kgIvYkN4bCe7o9OMtFgTNY1P+L6N1SrMUa29i86yQbpaUGM6Z5zsSO
        hqjgJW1bO61PnGBxrtxHAkI7L0zuEYnuGhz0qmWiH78NQKWjV2ouErGMhg2cnun3
        ujHNibTeOh8wcvZMYsWMhbY/Ng0zHud9ZQo9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tlbd0XG+UJe4hXu91OA846Ag91AnC4P4
        j47eRSEFbh3n8M1PI4hkagzNN75yXKqmvzJ5iHiOpKEGt+KM6/b/n5Z9ImS+fu0+
        a8yKaN/B81NIizKNucpY1vEicF8bomXNlaOUyA5nTB1Q7zVD8KoJYxvVZoVaT3O/
        VeEwA1cjgDQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1BDA5530C;
        Mon,  5 Dec 2016 13:28:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F07F5530A;
        Mon,  5 Dec 2016 13:28:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] clone,fetch: explain the shallow-clone option a little more clearly
References: <20161204220359.30807-1-alexhenrie24@gmail.com>
Date:   Mon, 05 Dec 2016 10:28:34 -0800
In-Reply-To: <20161204220359.30807-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sun, 4 Dec 2016 15:03:59 -0700")
Message-ID: <xmqq37i25iy5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1FD83EE-BB18-11E6-A438-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> "deepen by excluding" does not make sense because excluding a revision
> does not deepen a repository; it makes the repository more shallow.

I think that an intuitive way the feature should work may be:

 - You started with "git fetch --depth=20" and then later say "I
   have only a very short segment of the recent history, but I want
   a history that dates back to v1.0" with "--shallow-exclude=v1.0".
   In this case, you would be deepening.

 - You instead started with "git fetch --depth=20000" that dated
   back to v0.5.  "--shallow-exclude=v1.0" you say today would mean
   "I have very old cruft I no longer look at.  I just want my
   history lead back to v1.0 and no earlier".  In such a case, you
   indeed would be making the repository shallower.

I however offhand do not think the feature can be used to make the
repository shallower, and I agree your changes to the usage string
probably describe what the option does more correctly.

I however suspect that the feature is simply buggy and it would
eventually want to allow to shorten the history as well.  At that
point we may want to work on the verb 'deepen' there, too.

>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/clone.c | 2 +-
>  builtin/fetch.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 6c76a6e..e3cb808 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -99,7 +99,7 @@ static struct option builtin_clone_options[] = {
>  	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
>  		    N_("create a shallow clone since a specific time")),
>  	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
> -			N_("deepen history of shallow clone by excluding rev")),
> +			N_("deepen history of shallow clone, excluding rev")),
>  	OPT_BOOL(0, "single-branch", &option_single_branch,
>  		    N_("clone only one branch, HEAD or --branch")),
>  	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b6a5597..fc74c84 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -122,7 +122,7 @@ static struct option builtin_fetch_options[] = {
>  	OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
>  		   N_("deepen history of shallow repository based on time")),
>  	OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("revision"),
> -			N_("deepen history of shallow clone by excluding rev")),
> +			N_("deepen history of shallow clone, excluding rev")),
>  	OPT_INTEGER(0, "deepen", &deepen_relative,
>  		    N_("deepen history of shallow clone")),
>  	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
