Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE5CE7B06
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1SLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1SLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 14:11:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD619F
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 11:11:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 128CD3C4BD;
        Thu, 28 Sep 2023 14:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4gYDh1zyov3qEiFoH+0QifTFnwG6tE54CTwyKp
        helHg=; b=lSFydS1vNbBcvRy3RLLe/OSHdrN2sn8ArZnv1hFBQpAaGnfg3FdqIc
        mrXiaD0UuWUOVHVljykOrd7W/wj5zToxyP+q617Zqr5VwdOUjRJzD6lZgJnWghrf
        Uv4MlvUlxt2WHBv282ZEmlb26CgAi9XFNcsAYz7oWHx6Z0y/bGu04=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B1713C4BC;
        Thu, 28 Sep 2023 14:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E8D43C4BB;
        Thu, 28 Sep 2023 14:11:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joanna Wang <jojwang@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: Supporting `git add -a <exclude submodules>`
In-Reply-To: <CAL-HyEbxGqxid3vsvDk3Z0Gd3swbNP4qcXhApadu8ZgvRkr3WA@mail.gmail.com>
        (Joanna Wang's message of "Thu, 28 Sep 2023 13:06:38 -0400")
References: <CAL-HyEbxGqxid3vsvDk3Z0Gd3swbNP4qcXhApadu8ZgvRkr3WA@mail.gmail.com>
Date:   Thu, 28 Sep 2023 11:11:01 -0700
Message-ID: <xmqqsf6yjhhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62F0EA62-5E2A-11EE-ACB1-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joanna Wang <jojwang@chromium.org> writes:

> So the work would entail:
> - adding 'native' submodule attribute support, so `git add -a
> ':(exclude,attr:submodule)' can work without having to add 'submodule'
> for every submodule path in .gitattributes

I personally do not think it is a great interface that allows you to
only say "all submodules in my tree, are equally special in the same
way, and I do not want any of them" without allowing you to say
"paths in this directory, be they files, symlinks, or submodules,
are special and I do not want any of them".  The former smells like
a very narrow hack that does not generally extend.  So compared to
"git add -a --exclude-submodules", a solution using magic pathspec
mechanism and syntax would be a great improvement.

The spelling of the attribute (if we were to use the "attr" magic,
that is) may want to allow a bit more flexibility, e.g.,
"attr:type=gitlink", or even "attr:bits=160000", that would allow
natural extension to cover symbolic links and other oddities.

> - add magic pathspec support to `git add`

Yup, I do not offhand remember why "git add" does not want to take
the magic pathspec with an "attr" component.  Whoever wants to tip
in to this effort may want to first try what breaks when it is
enabled without changing anything, write tests, and then fix the
fallouts, which can be done separately and in parallel with an
effort to design how the way to express "does this path represent a
submodule?  a regular blob?  a symbolic link?  something else?" with
the magic pathspec syntax (i.e., choose among attr:submodule,
attr:type=<what>, attr:bits=<permbits>, decide what keyword to use),
and implement that design.

> (It looks like `git commit -a` does not work with pathspec.

You should be able to do something like 

    $ git commit . ':(exclude)t/'

I think.

By the way, I am surprised that "diff.ignoreSubmodules=all" is
abused by anybody that way.  It depends on the implementation detail
that we internally use the diff machinery to find which paths are
not modified, and I would even say it is a BUG that "commit -a" pays
attention to the configuration variable that way.  I would recommend
strongly to stay away from that approach or your tools will get
broken when the bug gets fixed.

Also, I have doubts on the higher level workflow issue that makes
your people want to keep their submodules (or any subdirectories for
that matter) dirty and out of sync with the superproject, and commit
their work product from that state.  It means whatever their local
building and testing gave them cannot be trusted when evaluating the
resulting commit at the superproject level.
