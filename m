Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252B361181
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhIHWVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:21:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52210 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhIHWVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:21:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 317B1138165;
        Wed,  8 Sep 2021 18:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N/m6wlOWmIe610s/uTD4p2BRcuhR+u58NuYttQ
        bZgTU=; b=rkvqWZmm4h7fxTBhl6eRH8YkqnM+/GdL3uk2nLRK6NUh+2eyWnrfNM
        QlbJ9XPGdJkF6OPoyWd4COp3UiOZNHU61ge1WyggrWaLEKqhNCi5mBWYAXoqWO1W
        3JvzVZlMRK1e1LTAmnuZNQDHOvL5razJnXFKlhNrgUNGIyXZeHjyU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29AD4138163;
        Wed,  8 Sep 2021 18:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 718E7138162;
        Wed,  8 Sep 2021 18:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 1/3] t6437: run absorbgitdirs on repos
References: <cover.1631123754.git.jonathantanmy@google.com>
        <942d3ce2d3cf96192c7e9d5860a18c333dd08acf.1631123754.git.jonathantanmy@google.com>
Date:   Wed, 08 Sep 2021 15:20:18 -0700
In-Reply-To: <942d3ce2d3cf96192c7e9d5860a18c333dd08acf.1631123754.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 8 Sep 2021 11:18:13 -0700")
Message-ID: <xmqqwnnq1zh9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4150BCC-10F2-11EC-8B12-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The submodule merge code is being transitioned away from
> add_submodule_odb() to repo_submodule_init(), and the latter does not
> support submodules that have their .git directories in the worktree
> (instead of in .git/modules). Migrate the test code by calling
> absorbgitdirs wherever necessary to place the .git directories of
> submodules in .git/modules of the superproject.

It is wonderful that we can work with the "absorbed" form of the
submodule repositories, and having all the submodules in "absorbed"
form may be ideal in the longer term, but I fail to convince myself
that this particular change to test script is a good idea.

After all, if you are not cloning from somebody else but creating
a new submodule in a superproject you have (whether that was locally
created or cloned from elsewhere), wouldn't it more natural to have
a submodule that is not "absorbed" there?  Is it easy to create an
"absorbed" submodule locally?  

The change to tests in this patch may make things work with the
repo_submodule_init() that is incapable of work with submodules with
in-worktree .git repository.  In theory, the users can do the same,
i.e. have an extra "git submodule absorbgitdirs" call, when adding a
new submodule, to make things work with repo_submodule_init(), too.

But that sounds like a workaround, not a feature.

Quite honestly, if repo_submodule_init() can only work with the
"absorbed" form, isn't it simply a bug?

Two independent (i.e. we can do either or both) things may improve
the situation:

 - allow repo_submodule_init() to work on both forms (in place---no
   cheating by calling "absorb" behind user's back).

 - teach "git submodule add" to transition an old-style submodule
   into the "absorbed" form (either with an option, or do so by
   default with an escape hatch to disable).

The latter indirectly attacks the "repo_submodule_init() can only
work with absorbed form" issue by making it harder to create a
non-absorbed submodule to begin with.

Hmm?
