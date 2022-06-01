Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA04CCA473
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 15:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355931AbiFAP67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355927AbiFAP65 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 11:58:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A3D57B24
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:58:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C454D13A41A;
        Wed,  1 Jun 2022 11:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K98ezRxUBOJdJmhU+7J/IkcL874nmxHyqFbhPK
        NTyiA=; b=jdNEXaZ3pKTUbTM3zapo2ri+q/sFzaF1yS7Gzt/Lz4AAW1iUStpr+R
        b6NivSl9db7JDGeAW9oZAJF1Lrmax6A0FKN9tPzGu6IYd8m8rDIjyrkbtNkYj2EV
        g4YIsVxEb6yogrsB1/Db7zTSsGNS9cPE30W90BEsaHeOtmbzcEkR8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B958713A419;
        Wed,  1 Jun 2022 11:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B14B13A418;
        Wed,  1 Jun 2022 11:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 2/5] config: read protected config with
 `git_protected_config()`
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <7499a2809615d42eaf3649e1c33f38d099d27c1a.1653685761.git.gitgitgadget@gmail.com>
        <xmqqbkvi1owx.fsf@gitster.g>
        <kl6lv8tlegy4.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 01 Jun 2022 08:58:53 -0700
In-Reply-To: <kl6lv8tlegy4.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 31 May 2022 10:43:15 -0700")
Message-ID: <xmqqwne0tlxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCACE838-E1C3-11EC-A3D1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> A goal in this version was to introduce as little jargon as possible, so
> - "protected config" refers to the set of config sources, and
> - "protected config only" refers to config variables/settings that are
>   only read from protected config.

OK.  Let's have such a clear pair of definitions somewhere in the
doc or at least in a proposed log message.

>
>>> - Protected config is stored in `the_repository` so that we don't need
>>>   to statically allocate it. But this might be confusing since protected
>>>   config ignores repository config by definition.
>>
>> Yes, it indeed is.  Is it because we were over-eager when we
>> introduced the "struct repository *repo" parameter to many functions
>> and the configuration system wants you to have some repository, even
>> when you know you are not reading from any repository?  
>
> Ah no, I was just trying to avoid yet-another global variable (since
> IIRC we want to move towards a more lib-like Git), and the_repository
> was a convenient global variable to (ab)use.

If this does not have to be known only inside config.c, until we
introduce a more global bag of things, which may have the current
the_repository as one of its components, I do not think it hurts to
have a file-scope static there.  Then, perhaps git_configset_get*()
helper functions can recognize cs==NULL as a sign that the caller
wants to grab from the "protected config", or something?  If we do
not want to expose the underying global variable to the public, that
is.

> As an aside, I wonder how we could get rid of all of the globals in
> environment.c in the long term. Maybe we would have yet-another all
> encompassing global, the_environment, and then figure out which
> variables belong to the repository and which belong to the environment.

I think we are on the same page, we'd probably need something called
the_world ;-)

> Instead, we can use "protected config" to refer to the config and
> "protected config only" to refer to variables. Since "protected config"
> is defined as (global + system + CLI) config, then yes, we would say
> that it is "protected config". But since we do not enforce that
> "user.name" _must_ come from only protected config, it is not "protected
> config only".

Very clear.  Thanks.
