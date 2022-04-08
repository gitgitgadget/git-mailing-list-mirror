Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC1C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 05:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiDHF5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 01:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHF5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 01:57:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8844215F1A
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 22:54:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC241182925;
        Fri,  8 Apr 2022 01:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YudJcQtPfTtdosj/POrQDKcPi3G5kI5W0uwWPb
        8ZMsk=; b=jCW3AHJqFSrTvq3X0gFllzGml8VRblN8CDqihY0Nwcv45bzrps1Oul
        oF8CUM8yYPlRigBLs0I3SXJP4yNKNfr6fnw2KbTHutHZbDwgMRWKfCsfsUBBHJx0
        YJUyokrZFWmseik1XXiXFnMyd1AF1Ts+GfrB1TykEAJAdK6eCfcmI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4B16182924;
        Fri,  8 Apr 2022 01:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F473182923;
        Fri,  8 Apr 2022 01:54:54 -0400 (EDT)
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
Date:   Thu, 07 Apr 2022 22:54:53 -0700
In-Reply-To: <Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 7 Apr 2022 22:10:00 +0000")
Message-ID: <xmqqmtgwp1aq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69BB3EC4-B700-11EC-8C92-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Then we'd probably be better off just walking up the entire hierarchy
> and excluding worktrees from embedded bare repositories, or otherwise
> restricting the config we read.  That will probably mean we'll need to
> walk the entire directory hierarchy to see if it's embedded (or at least
> to the root of the device) in such a case, but that should be relatively
> uncommon.

I find this direction to notice iffy "user data" and disable it
quite reasonable.  A configuration file can define alias, and it
would be yet another attack vector to overload common ones users
likely use ("git co", "git st", ...).  There may also be a hooks/
directory.

I wonder if it is an acceptable defence to deliberately "corrupt"
such user data when we notice that they smell fishy, perhaps by
renaming "config" and "hooks", when they are found next to "HEAD"
and "objects" and "refs", to "config.disabled" and "hooks.disabled"?
I am just thinking aloud without assessing if it is sensible or
feasible at ths point.

I am not sure if "walking the hierarchy up" is an effective enough
defence offhand.  Do we consider it too much social engineering to
make the user follow cloning instruction of the malicious project to
prepare a repository, with core.worktree set to elsewhere, and pull
into it?  Since walking up from any subdirectory of the directory
the core.worktree points at will never see a directory, with ".git/"
subdirectory that is the malicious project, "git status" run in the
"embedded" place in such a scenario will not notice that it is a
repository lookalike that came from outside.  But we can write it
off as an approach needing too much  social engineering, that's OK.
