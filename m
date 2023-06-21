Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D68EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjFURFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFURFq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 13:05:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13460129
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 10:05:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DD923235B;
        Wed, 21 Jun 2023 13:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SCFke9ikxELyqMS1+X2W9KCnMeg2HtidHo2XIH
        Xx49A=; b=W1EwCo6yFijfnQVYloXiElfj5A0Ns2FlTvCDuFmocqxLK3RkamzfY6
        RYClsJ3s7mxTMcLK07baAFOowFZ/4Fe6/e8mbelWMCLpiWIX3wyArYWUEAmB/kq5
        rFzziIiAS92/jRvpi8ww5wM9Bn47lQ1nsi7XMRUsUz5jWjAp7Idk4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 863D33235A;
        Wed, 21 Jun 2023 13:05:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4297132359;
        Wed, 21 Jun 2023 13:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: bug in en/header-split-cache-h-part-3, was Re: What's cooking
 in git.git (Jun 2023, #05; Tue, 20)
References: <xmqqedm5k7dx.fsf@gitster.g>
        <20230621085526.GA920315@coredump.intra.peff.net>
Date:   Wed, 21 Jun 2023 10:05:40 -0700
In-Reply-To: <20230621085526.GA920315@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 21 Jun 2023 04:55:26 -0400")
Message-ID: <xmqqttv0hhjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA1FFF74-1055-11EE-A6B9-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jun 20, 2023 at 05:04:42PM -0700, Junio C Hamano wrote:
>
>> * en/header-split-cache-h-part-3 (2023-05-16) 29 commits
>>  ...
>>  Will merge to 'master' together with its fix-up in js/cmake-wo-cache-h
>>  source: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
>
> I think this series has a bug with finding the correct templates dir. If
> I check out 76ebce0b7a (Merge branch 'en/header-split-cache-h-part-3'
> into next, 2023-06-15) and run:
>
>   make prefix=/tmp/foo install && /tmp/foo/bin/git init /tmp/bar
>
> I get:
>
>   warning: templates not found in /usr/share/git-core/templates
>
> Whereas if I go to 76ebce0b7a^, that warning does not appear (and
> presumably the templates come from /tmp/foo/share, but I didn't check).

Ouch.

> Our tests can't notice because they always specify the in-repo template
> dir directly in the bin-wrappers script (and other users might not even
> get the warning if they have another git installed in /usr; it would
> just silently use the wrong template).
>
>   Side note: I'm using the merge along 'next' there because much to my
>   surprise, the tip of en/header-split-cache-h-part-3 does not build by
>   itself! It needs the evil merge result from ccd12a3d6c (Merge branch
>   'en/header-split-cache-h-part-2', 2023-05-09). I wonder if it got
>   applied on the wrong base. It does work when merged to 'next' (and
>   should with 'master' as well), but it hurts bisectability.
>
> After rebasing on 'master' to make it buildable on its own, I bisected
> my make/init command above, which shows the template problem appearing
> in 3f85c72fad (setup: adopt shared init-db & clone code, 2023-05-16).
>
> I guess the problem is the movement of the code from init-db.c to
> setup.c, and we'd want something like this:
>
> diff --git a/Makefile b/Makefile
> index e440728c24..b09c8165d0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2742,8 +2742,8 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
>  	'-DBINDIR="$(bindir_relative_SQ)"' \
>  	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
>  
> -builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
> -builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
> +setup.sp setup.s setup.o: GIT-PREFIX
> +setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
>  	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
>  
>  config.sp config.s config.o: GIT-PREFIX
>
>
> It does make me wonder if we should also just do this:
>
> diff --git a/setup.c b/setup.c
> index f8e1296766..6e7282e680 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1718,10 +1718,6 @@ int daemonize(void)
>  #endif
>  }
>  
> -#ifndef DEFAULT_GIT_TEMPLATE_DIR
> -#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
> -#endif
> -
>  #ifdef NO_TRUSTABLE_FILEMODE
>  #define TEST_FILEMODE 0
>  #else
>
> Since the Makefile always provides that value, having a baked-in
> fallback does not make much sense. And in this case it masked a real bug
> which should have been a compilation error, and instead silently used
> the wrong value.
>
> So I think we'd at least want to fix the Makefile before graduating this
> topic any further. But IMHO it would also be worth adjusting the topic's
> start point so that we don't have a big chunk of commits which fail to
> build in the final history.

Hmph, meaning (1) revert the merge of the topic to 'next', (2)
rebase the topic on top of the current 'master', instead of 4bd872e0,
which was a merge of the prerequisite series into then-current
master, (3) apply the Makefile (plus setup.c) fix, and then (4)
merge the result back to 'next'?

