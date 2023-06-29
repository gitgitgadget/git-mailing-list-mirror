Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0059C001DB
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 19:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF2TUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjF2TTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 15:19:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9510F7
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:17:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EB2019B5B5;
        Thu, 29 Jun 2023 15:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qHCpwr45H3IGb8DqDDWgp1ptyyC9/VudwMjbel
        CixE4=; b=npt4wYtYIT5U2kJ5C8+pAN6aJoo823bWRaMMyTHpWv4H+oSqf0+Oqz
        hQQKaEUU0gGA1mRH7nxYhsqQgvA30iInDBzb1nnNLNy3enTc8O+j7+0yt5ijDXlG
        zrXwR+7HijpnRv+E5tg6xYtfe7xgY4Mj5cV5ygtx2CzhlJnVv5Hs4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 758CB19B5B4;
        Thu, 29 Jun 2023 15:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD00619B5B3;
        Thu, 29 Jun 2023 15:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] commit -a -m: allow the top-level tree to become
 empty again
References: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
        <08c50b64e2a93300eed196505936e58ce8bb639b.1688044991.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 12:17:22 -0700
In-Reply-To: <08c50b64e2a93300eed196505936e58ce8bb639b.1688044991.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 29 Jun 2023
        13:23:10 +0000")
Message-ID: <xmqq5y769iyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93BA9442-16B1-11EE-8303-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> That logic was introduced to add a shortcut when committing without
> editing the commit message interactively. A part of that logic was to
> ensure that the index was read into memory:
>
> 	if (!active_nr && read_cache() < 0)
> 		die(...)
>
> Translation to English: If the index has not yet been read, read it, and
> if that fails, error out.

Well described.  It does make sense to turn !active_nr used here
into a check on the .initialized member.

> And it was natural to do it this way because at the time that condition
> was introduced, the `index_state` structure had no explicit flag to
> indicate that it was initialized: This flag was only introduced in
> 913e0e99b6a (unpack_trees(): protect the handcrafted in-core index from
> read_cache(), 2008-08-23), but that commit did not adjust the code path
> where no index file was found and a new, pristine index was initialized.

My mistake, but after 15 years it probably is beyond statute of
limitations ;-)

> Using the `initialized` flag instead, we avoid that mistake, and as a
> bonus we can fix a bug at the same time that was introduced by the
> memory leak fix: When deleting all tracked files and then asking `git
> commit -a -m ...` to commit the result, Git would internally update the
> index, then discard and re-read the index undoing the update, and fail
> to commit anything.

That does sound like the primary bug fixed with this change, not a
bonus, but anyway, the change is very sensible and clearly described
with a good test.  Will queue.

Thanks.
