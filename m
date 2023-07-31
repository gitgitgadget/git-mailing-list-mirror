Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D81C00528
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 15:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGaPo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGaPoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 11:44:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41172170C
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 08:44:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BB23197D9;
        Mon, 31 Jul 2023 11:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/nfOtq3ab1Wdj915K0yBePVRt69Br1sSZBeVF1
        Ag5Bg=; b=ZmuI8UQ+uSOF2r+ZR+Oh6oimjRYoK1WJwqHj+ZM9tl2uWSmOvVh7Xk
        a1+rlmAybCVj+HyP21qNNLjeCl/c1ZyayoZClXV7kktAT3x1LP4L8LDHEtXWVnig
        mh0j0YuBDJItOVEQywVnFgx0Paces8/Mmj2VAqZlhhXB34SgDtv74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 847EA197D8;
        Mon, 31 Jul 2023 11:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C994B197D7;
        Mon, 31 Jul 2023 11:44:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hank Leininger <hlein@korelogic.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Git 2.39.0+ Git.pm ignores Directory=> argument for bare
 repos
References: <20230730140659.0cc15491-00d2-4e58-af57-aaf5e74b5827@korelogic.com>
Date:   Mon, 31 Jul 2023 08:44:15 -0700
In-Reply-To: <20230730140659.0cc15491-00d2-4e58-af57-aaf5e74b5827@korelogic.com>
        (Hank Leininger's message of "Sun, 30 Jul 2023 14:42:44 -0600")
Message-ID: <xmqqa5vc13xs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B4AD30C-2FB9-11EE-A161-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hank Leininger <hlein@korelogic.com> writes:

> Recent git versions (2.39.0 through 2.41.0) Git.pm seems to forget its
> Directory argument for bare repos. Initial creation of a
> Git->repository object will succeed, but subsequent $repo->command()
> fails unless the repo is in pwd or is set in the GIT_DIR environment
> argument.

$ git log --oneline v2.38.0..v2.39.0 -- perl/Git.pm
20da61f25f Git.pm: trust rev-parse to find bare repositories
77a1310e6b Git.pm: add semicolon after catch statement

My guess is 20da61f25f is likely the source of the differences, but
it is unclear if that should be called a "bug", as it was done as a
fix for misbehaviour.

commit 20da61f25f8f61a2b581b60f8820ad6116f88e6f
Author: Jeff King <peff@peff.net>
Date:   Sat Oct 22 18:08:59 2022 -0400

    Git.pm: trust rev-parse to find bare repositories
    
    When initializing a repository object, we run "git rev-parse --git-dir"
    to let the C version of Git find the correct directory. But curiously,
    if this fails we don't automatically say "not a git repository".
    Instead, we do our own pure-perl check to see if we're in a bare
    repository.
    
    This makes little sense, as rev-parse will report both bare and non-bare
    directories. This logic comes from d5c7721d58 (Git.pm: Add support for
    subdirectories inside of working copies, 2006-06-24), but I don't see
    any reason given why we can't just rely on rev-parse. Worse, because we
    treat any non-error response from rev-parse as a non-bare repository,
    we'll erroneously set the object's WorkingCopy, even in a bare
    repository.
    
    But it gets worse. Since 8959555cee (setup_git_directory(): add an owner
    check for the top-level directory, 2022-03-02), it's actively wrong (and
    dangerous). The perl code doesn't implement the same ownership checks.
    And worse, after "finding" the bare repository, it sets GIT_DIR in the
    environment, which tells any subsequent Git commands that we've
    confirmed the directory is OK, and to trust us. I.e., it re-opens the
    vulnerability plugged by 8959555cee when using Git.pm's repository
    discovery code.
    
    We can fix this by just relying on rev-parse to tell us when we're not
    in a repository, which fixes the vulnerability. Furthermore, we'll ask
    its --is-bare-repository function to tell us if we're bare or not, and
    rely on that.
