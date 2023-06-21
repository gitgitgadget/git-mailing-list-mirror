Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F93EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 19:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFUTrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFUTry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 15:47:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731D41989
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 12:47:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5291197666;
        Wed, 21 Jun 2023 15:47:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Bln39inF3XBZ
        3VtfaOlIFUkNT+YlaVqAaHvopCxtxZA=; b=v7yi8w69vrjR3OhXKFcTUVo36GmC
        9Q1gtpJcgT1DXDOe7e8d0O4CIjHJBkGwcZoulo7J52ENS6ZljCmmueobSYrq1w3y
        TuwkV6GjBlWc2hN6gumRsp4j2cXbUVKJvcEzfwk0gXxtHUv+koYDKa1/MkvdEX4n
        5Vs7i236j2k6G/k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACA41197665;
        Wed, 21 Jun 2023 15:47:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10CA2197664;
        Wed, 21 Jun 2023 15:47:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Guido =?utf-8?Q?Mart=C3=ADnez?= <mtzguido@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Guido =?utf-8?Q?Mart=C3=ADnez?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ls-files: add an --exclude-links option
References: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
        <20230621081754.GA803861@coredump.intra.peff.net>
        <xmqqzg4siyru.fsf@gitster.g>
        <CA++DQUkVzz8Zn0x6BR+sAEo_LXFR67Z+JOgMhcY2JpS5UGi4rw@mail.gmail.com>
Date:   Wed, 21 Jun 2023 12:47:50 -0700
In-Reply-To: <CA++DQUkVzz8Zn0x6BR+sAEo_LXFR67Z+JOgMhcY2JpS5UGi4rw@mail.gmail.com>
        ("Guido =?utf-8?Q?Mart=C3=ADnez=22's?= message of "Wed, 21 Jun 2023
 10:54:27 -0700")
Message-ID: <xmqq352kha1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82222678-106C-11EE-A023-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guido Mart=C3=ADnez <mtzguido@gmail.com> writes:

> So would it make sense to
> 1- Add the file type filter to ls-files

I think it definitely makes sense to extend the filtering criteria
supported by ls-files beyond what we currently support (i.e.
pathspec).

I also wonder if "file type filter" could just be implemented as the
magic pathspec.  For example, we can already use the magic pathspec
'attr' (read on "pathspec" in "git help glossary") this way:

    $ git ls-files ":(attr:eol=3Dcrlf)"

to list only those files for which the 'eol' attribute is set to
'crlf' (i.e. they must be checked out for DOS no matter what your
platform actually is).  That is even more flexible than the
hardcoded "is it a regular file?  is it a symlink?  is it a
submodule" file types.  And the magic pathspec is understood not
everywhere but by git subcommands other than "ls-files".

We can either invent a new pathspec magic "filetype" and express
them this way,

    $ git ls-files ":(filetype:regular)"        # 100644 and 100755
    $ git ls-files ":(filetype:symbolic-link)"  # 120000
    $ git ls-files ":(filetype:submodule)"      # 160000

or we invent a magic attribute "filetype" that is automatically
given to every path, and express the above more like so:

    $ git ls-files ":(attr:filetype=3Dregular)"        # 100644 and 10075=
5
    $ git ls-files ":(attr:filetype=3Dsymbolic-link)"  # 120000
    $ git ls-files ":(attr:filetype=3Dsubmodule)"      # 160000

may be even better, as there are git subcommands other than ls-files
that supports magic pathspec.  For example, it might be even useful
to do something like

    $ git diff v1.0 v2.0 -- ":(attr:filetype=3Dexecutable)"

instead of saying

    $ git diff v1.0 v2.0 -- \*.sh \*.perl \*.py \*.bat

So, yeah, whether it is done via the magic pathspec or "ls-files"
specific option, teaching "ls-files" to support more filtering
criteria would make sense.

> 2- Use that to implement a proper git-do-for-paths script/binary,
> which can take pathspecs, filetype filters, -n, -P, and maybe more
> ?

The primary obstacle was you'd need a custom perl script to filter
"ls-files -z" output, but once that need is gone, I actually do not
think it buys us a lot to have such a wrapper.  Treat the improved
ls-files as what it is, i.e. a plumbing command that can be used as
a building block of your workflow, and piping its output to xargs
would just be fine.

Thanks.
