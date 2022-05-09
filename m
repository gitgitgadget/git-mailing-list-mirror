Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733F7C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 22:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiEIW6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiEIW6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 18:58:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CB1C344E
        for <git@vger.kernel.org>; Mon,  9 May 2022 15:54:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20D5019B081;
        Mon,  9 May 2022 18:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nuavjNPQRq9HLx+AUJajSy4LZ8lTWL9vvbWdWD
        S3T/Q=; b=JcfhO4Rgdfyl85PAV1UY2Mb2JeGKM1/bAk42fEdUxeTNBrHZmipPGA
        YnpXa+X9Zwe/rZgjBLvtl+aBQoUEvM+3esYx/UCpp7h9+jYsGiqi59nqJ5Ych1rj
        W/GdK14ICSNXWp8sHl6KHCUPUz+QQjAW4SlZSv/dkpajzy8/hNkg4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 193F819B080;
        Mon,  9 May 2022 18:54:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD36C19B07F;
        Mon,  9 May 2022 18:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] [RFC] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <YnmKwLoQCorBnMe2@nand.local>
Date:   Mon, 09 May 2022 15:54:08 -0700
In-Reply-To: <YnmKwLoQCorBnMe2@nand.local> (Taylor Blau's message of "Mon, 9
        May 2022 17:42:24 -0400")
Message-ID: <xmqq8rrab9m7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFFCEFE8-CFEA-11EC-96AD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thanks for working on this! I'm excited to see some patches here, though
> I'm not totally convinced of this direction. More below.
>
> To summarize, this proposal attempts to work around the problem of
> embedding bare repositories in non-bare checkouts by providing a way to
> opt-out of bare repository discovery (which is to only discover things
> that are listed in the safe.bareRepository configuration).
>
> I agree that this would prevent the problem you're trying to solve, but
> I have significant concerns that this patch is going too far (at the
> risk of future damage to unrelated workflows) in order to accomplish
> that goal.
>
> My concern is that if we ever flipped the default (i.e. that
> "safe.bareRepository" might someday be ""), that many legitimate cases
> of using bare repositories would be broken. I think there are many such
> legitimate use cases that _do_ rely on discovering bare repositories
> (i.e., Git invocations that do not have a `--git-dir` in their
> command-line).

I think 99% of such use is to chdir into the directory with HEAD,
refs/ and objects/ in it and let git recognise the cwd is a git
directory.  Am I mistaken, or are there tools that chdir into
objects/08/ and rely on setup_git_directory_gently_1() to find the
parent directory of that 'objects' directory to be a git directory?

I am wondering if another knob to help that particular use case
easier may be sufficient.  If you are a forge operator, you'd just
set a boolean configuration variable to say "it is sufficient to
chdir into a directory to use it a bare repository without exporting
the environment variable GIT_DIR=."

It is likely that end-user human users would not want to enable such
a variable, of course, but I wonder if a simple single knob would be
sufficient to help other use cases you are worried about?

While I wish "extensions and nothing else", i.e. we use "degraded
access", not "refuse to give access at all", were workable, I am
pessimistic that it would work well in practice.

Saying "nothing else" is easy, but we do "if X exists, use it" for
hook, and to implement "nothing else", you'd need to find such a
code and say "even if X exists, because we are in this strange
embedded bare thing, ignore this part of the logic" for every X.
We've been casually saying "potentially risky config" and then
started mixing "hooks" in the discussion, but who knows what other
things are used from the repository by third-party tools that we
need to yet add to the mix?

> I'm still not convinced that just reading repository extensions while
> ignoring the rest of config and hooks is too confusing, so I'd be more
> in favor of something like:

I do not think it would be confusing.  I am worried about it being
error prone.

>     $ git.compile rev-parse --absolute-git-dir
>     warning: ignoring repository config and hooks
>     advice: to permit bare repository discovery (which
>     advice: will read config and hooks), consider running:
>     advice:
>     advice:   $ git config --global --add safe.bareRepository /home/ttaylorr/repo.git
>     /home/ttaylorr/repo.git

Is the last line meant to be an output from "rev-parse --absolute-git-dir"?
IOW, the warning says you are ignoring, but we are still recognising
it as a repository?

By the way, do we need safe.bareRepository?  Shouldn't
safe.directory cover the same purpose?  

If a directory is on the latter, you are saying that (1) the
directory is OK to use as a repository, and (2) it is so even if the
directory is owned by somebody else, not you.

Theoretically you can argue that there can be cases where you only
want (1) and not (2), but as long as you control such a directory
(like an embedded repository in your project's checkout) yourself,
you do not have to worry about the "ok even if it is owned by
somebody else" part.




