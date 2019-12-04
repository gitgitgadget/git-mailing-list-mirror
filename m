Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5644EC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 20:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E323A2073B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 20:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YS3weXog";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="rRruFz0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLDUEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:04:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58161 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfLDUEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 15:04:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8079F3A8EE;
        Wed,  4 Dec 2019 15:04:50 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:date:message-id:mime-version:content-type;
         s=sasl; bh=kJ/6TbzYzlBmbT4MXQMDppbo6Pc=; b=YS3weXog1PK4UljMOI8d
        oY7Io6JPXzKd6cSNHhe40LOvUEP0vAZvPdzIG1jwtEQJTg8lqZTHS58u5Y0I161n
        JY3FnisKinScgyMxrCeAs8HNchV9FZ3B2yCDvoVnw4Wt0G8eJ5bqFSnnEfq0VVN1
        QEOZw44+mJ+C+NueCSo7eow=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72ADD3A8ED;
        Wed,  4 Dec 2019 15:04:50 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:date:message-id:mime-version:content-type;
 s=mesmtp; bh=zvptzVjIqn5/hcm2S2yCC2mxpmPQW/raIYa2jn8y4KA=;
 b=rRruFz0tOYfjJ8eJEyu+kHSJuwub83Y+iEsaEUcyjcISm09ZvDz7cqgRPvgBVUkHQixgPk+Z0ee9xQdPSQkiySEusfyrZczIfRASVeRzrj7P4uET1iSmmpRvg3oXT6sTex2AmOtBq5aUf9GVEPrsslpqCcgj6tVsP8w2ANC8CXs=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1EB13A8EC;
        Wed,  4 Dec 2019 15:04:49 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
In-Reply-To: <CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com>
Date:   Wed, 04 Dec 2019 15:04:48 -0500
Message-ID: <874kyf6en3.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53E0F7AA-16D1-11EA-9A1F-C28CBED8090B-24757444!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Thanks for the detailed and helpful reply.

Elijah Newren <newren@gmail.com> writes:

[...]

> As you mentioned, it won't traverse into it even when specified...
>
> $ git ls-files -o untracked_repo/
> untracked_repo/empty
>
> ...except that it does traverse into this directory if the user tab
> completes the name or otherwise manually adds a trailing slash.

Ah yes, I recall encountering what I think is the same underlying issue
when working on a previous series [0,1].  In the context of 'git add
untracked_repo/', there's been some discussion related to this trailing
slash discrepancy at

  https://lore.kernel.org/git/20180618111919.GA10085@book.hvoigt.net/T/#u

> Weird, let's try multiple pathspecs:
>
> $ git ls-files -o untracked_dir untracked_repo
> untracked_dir/empty
> untracked_repo/
>
> $ git ls-files -o untracked_dir untracked_repo/
> untracked_dir/empty
> untracked_repo/
>
> So it will traverse into the untracked_repo when specified as
> 'untracked_repo/' but not if there are more than one pathspec given?!?

Eh, indeed.

>  And it traverses into an untracked directory regardless of the
> trailing slash?  <sarcasm>What a paragon of consistency...</sarcasm>
>
>
> At least my changes in git-2.24.0 made the behavior consistent; it'll
> always traverse into a directory that matches a given pathspec.

I might be getting mixed up, but the changes in 2.24.0 did introduce
some inconsistent behavior (in the no trailing slash case) with respect
to giving a single pathspec and giving multiple pathspecs, no?  Using
your example:

    $ git --version
    git version 2.24.0
    $ git ls-files -o untracked_repo
    untracked_repo/
    $ git ls-files -o untracked_repo empty
    empty
    untracked_repo/
    untracked_repo/empty

> As for whether that's desirable or not when the pathspec is a submodule,
> I'm not certain. [...]
>
> But here are some possibilities that at least sound sane:
>
> A) ls-files -o should traverse into untracked submodules.  This case
> is easy; the code already does that.

Hmm, but as shown in the last example, ls-files -o doesn't traverse into
untracked submodules for the single pathspec case.

> B) ls-files -o should NOT traverse into untracked submodules AND
> should not even report them.
>
> C) ls-files -o should NOT traverse into untracked submodules, but
> should at least report their directory name.  If so, the fix is
> [...]

This behavior---which matches the no-slash behavior when no patchspec or
a single pathspec is given (on both v2.24.0 and previous version) as
well as when multiple pathspecs are given (before v2.24.0)---is the one
I prefer.  My biased reason for this preference is that in the DataLad
project we identify untracked nested repositories based on `ls-files -o
<untracked directory>...` reporting only the directory name for
repositories.  (Looking into one of our tests that fails with Git
v2.24.0 is how I ran into the reported change in behavior [2].)

That some external project relies on unintended ls-files output of
course doesn't mean that Git should keep reporting things that way, but
it does mean that I _hope_ that not traversing into untracked
repositories is the intended behavior and that traversing (either
because a slash is appended or as of 89a1f4aaf7 because multiple
pathspecs are given) is not intended :>


[0]: https://lore.kernel.org/git/20190409230737.26809-1-kyle@kyleam.com
[1]: https://lore.kernel.org/git/87bm1mbua4.fsf@kyleam.com/
[2]: https://github.com/datalad/datalad/issues/3890#issuecomment-561722194
