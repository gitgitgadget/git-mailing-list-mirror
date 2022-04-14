Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FAC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 00:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiDNAG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 20:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiDNAG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 20:06:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E64424AB
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 17:04:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7FF3177F15;
        Wed, 13 Apr 2022 20:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wbg9lWGedL72S+4jXYyMgoL4dz8Cm8iZSP7nnY
        bu8f0=; b=OajW/84qYWwuz0Cge+SVCjSr1zfSDU2a17bi6R+g6K9u2ZVXkuWsfu
        vB2tvKtKSKd6a0LgA03fWArH48+U8xfAGqksO9xfo0GbNGyKFSbvWRwkN7SDzdDH
        AVG0fpbP+7r0WZYINEIKCYPueXS4+3uXei0ho8NTGeRHF7hGviDuk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFE31177F14;
        Wed, 13 Apr 2022 20:04:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1CF2E177F10;
        Wed, 13 Apr 2022 20:04:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Justin Steven <justin@justinsteven.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <Yk9Wcr74gvhtyOi7@camp.crustytoothpaste.net>
        <CAHZU0ySHqc7f9qB0+ZrMWHHJiWsS-_hsUzomwNrGNMTF6qwcOw@mail.gmail.com>
        <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net>
        <xmqqmtgwp1aq.fsf@gitster.g>
Date:   Wed, 13 Apr 2022 17:03:57 -0700
In-Reply-To: <xmqqmtgwp1aq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        07 Apr 2022 22:54:53 -0700")
Message-ID: <xmqqfsmg4jki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62ECF9EA-BB86-11EC-B4EE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if "walking the hierarchy up" is an effective enough
> defence offhand.  Do we consider it too much social engineering to
> make the user follow cloning instruction of the malicious project to
> prepare a repository, with core.worktree set to elsewhere, and pull
> into it?  Since walking up from any subdirectory of the directory
> the core.worktree points at will never see a directory, with ".git/"
> subdirectory that is the malicious project, "git status" run in the
> "embedded" place in such a scenario will not notice that it is a
> repository lookalike that came from outside.  But we can write it
> off as an approach needing too much  social engineering, that's OK.

In other words, an attacker could lead the victim to clone their
malicious repository at path $R with core.worktree in its
configuration file $R/config pointing at some directory $D that is
entirely unrelated to $R.  In a subdirectory of $D (i.e. the working
tree of that malicious repository) there may be a directory $G with
HEAD, refs and config in it.

When the victim visits such a directory $G, going up from there to
the root of the filesystem would not find any directory with ".git/"
subdirectory in it, so your protection may not even notice that $G
came from a checkout of $R.
