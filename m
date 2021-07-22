Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF96C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7A160C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGVSZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 14:25:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59908 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhGVSZi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 14:25:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E115C1303BA;
        Thu, 22 Jul 2021 15:06:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wFVHyvS/UU1z
        dGM3lu6Gae8SQ18R/aRXsAUD4Z6bUnA=; b=n7SuXmCs2ykh56JSuQ98tbRyjtZH
        m6I1bc4RrL1mF70NcVh4rM5ZgrnbicBuBLuMI9JTycUsLZN1CtGO5F0yGB93/4xu
        MOXc+frK++fbLJiVDD/AtCKMQcEJmmvaTjJZtVPeA8bgiZ+nLt6Sp7paN/eqiiHQ
        KySEvf+2n1CNDEM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA0561303B9;
        Thu, 22 Jul 2021 15:06:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C4C81303B7;
        Thu, 22 Jul 2021 15:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Tom Cook <tom.k.cook@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] setup: only die on invalid .git under RUN_SETUP
References: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
        <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
Date:   Thu, 22 Jul 2021 12:06:08 -0700
In-Reply-To: <patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 16:07:39 +0200")
Message-ID: <xmqq5yx29nj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0252532-EB1F-11EB-877B-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change RUN_SETUP_GENTLY to stop dying if e.g. the .git is "not a
> repo". This means that we now recover in cases like:
>
>     $ echo "gitdir: /foo/bar" > .git
>     $ git ls-remote https://github.com/torvalds/linux
>     [... ls-remote output ...]
>
> But not (as intended):
>
>     $ git rev-parse HEAD
>     fatal: not a git repository: /foo/bar

I am of two minds.  ls-remote is benign in that it behaves more or
less identically when given certain types of args, and the above may
be a strict improvement (but it does fail if you did not use URL but
use a remote nickname you thought you configured in the repository
in such a situation).  There however are a few niche commands that
work inside and outside a repository and they work differently.  For
example, if you do

  $ git diff file1 file2

in such a corrupt repository, I'd prefer to see the command _fail_
to nudge the user to look into the situation, instead of taking the
output (which degenerates to "git diff --no-index file1 file2"
outside a repository) blindly as a patch that shows the changes
relative to the index for these two paths.

