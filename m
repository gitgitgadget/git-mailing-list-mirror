Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04271F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933908AbcIVSOX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:14:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935102AbcIVSNb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:13:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D41D3D032;
        Thu, 22 Sep 2016 14:13:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ifqZRKZYnzWfM+KavotG7qV1LS0=; b=yC6tPr
        3BIFai+daFEpqyoJTXl/teLmgQhQTmAXiHkntGvqsfzB2fj3+MwbuqkYsINSVFIw
        GScEuHaNi0o3u28p5P5cGjw9LK/8P87ptAaC3LHlQdUSaSwItspUl5hS4KafuNz8
        DXM/Fe2WLGwF1/M7eELpUpOw7cSDkuPxP9H5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OR3+uGZZcQAOMjDP73puARlst4i19SvX
        5l43si42blDUQKFT63skgwigBOorVRGG+tIbJ1XLqVvWGIG++HxpaainkFi+kULO
        4tAqUuA1G8lWW3O5avZ1Z+4mnkVeLgqqHW+iTVxl1tmxAGZGVuOwh6d0afZNP2Jb
        u0Dx3BfBJBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1682C3D030;
        Thu, 22 Sep 2016 14:13:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 339473D02E;
        Thu, 22 Sep 2016 14:13:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
        <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
        <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
        <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
        <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
Date:   Thu, 22 Sep 2016 11:13:13 -0700
In-Reply-To: <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Sep 2016 00:18:54 -0400")
Message-ID: <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40FDB706-80F0-11E6-980E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Should this option just be "--prefix", or maybe "--output-prefix"?
> Submodules are the obvious use case here, but I could see somebody
> adapting this for other uses (alternatively, if we _do_ want to keep it
> just as an implementation detail for submodules, we should probably
> discourage people in the documentation from using it themselves).

I agree that this is not specific to submodules; this is closely
related to what we internally call "prefix", but is different.

In any case, I would strongly recommend against exposing this (or
anything for that matter) "--prefix" to the end-user, especially
because this feature is likely to be applicable to many subcommands,
and some subcommands would want different sort of prefixing made to
different things.  Think of "git diff" that has a way to customize
the "a/" and "b/" part in "git --diff a/$path b/$path", and has
learned another way to prepend an additional prefix to every line of
output via "--line-prefix".  We want to give reasonably specific
names to things so that readers can tell what it affects from the
name of an option.

What we internally call "prefix" and "--submodule-prefix" is closely
related in that they both interact with pathspecs.  "prefix" gets
prepended to elements of an end-user supplied pathspec before a
full-path-in-the-repository (i.e. a path in the index and a path
relative from the top of the working tree) is matched against them.
This new thing on the other hand allows the leading part of pathspec
elements to be above the full-path-in-the-repository.  For example,
my primary Git working area is at ~/w/git.git and I could say

    $ cd ~
    $ git -C w/git.git/ ls-files \
        --submodule-prefix=w/git.git -- 'w/git.git/D\*' |
      xargs ls -1 -l

The command starts (eh, at least "pretends to start") in the top of
my working tree, which means that the "prefix" is NULL.  But the
shell that spawns the "git" command is still sitting in my home
directory, and viewed from there, the Documentation subdirectory is
at w/git.git/Documentation/, which is what I gave the command as the
sole element of the pathspec.  From "ls-files"'s point of view, each
path it discovers in the index (and in the working tree) is first
prefixed with --submodule-prefix before it gets matched against this
pathspec and the result is shown with this prefix, so that the
output gets relative to the calling shell and xargs would find them
at expected places.  The --submodule-prefix acts to cancel out the
fact that the caller sits a few levels above the working tree and
gave a pathspec with elements relative to that higher level in the
directory hierarchy.

Obviously, the above example is *not* using submodules at all, and
demonstrates that the mechanism does not have to be used solely to
implement recurse-into-submodules behaviour, so in that sense, the
name of the option is not quite accurate.  It however is a good
demonstration why it is *not* "output prefix".  It makes me wonder
if pathspec-prefix is a better name, but that may give an incorrect
impression that this would be used only for matching and would not
affect the output.  Do we need separate options to specify what gets
prefixed to the in-repository path before paths are matched against
a pathspec (i.e. "--pathspec-prefix") and what gets prefixed to the
resulting paths in the output (i.e. "--output-path-prefix")?

A few further random thoughts.

 * As Stefan alluded to (much) earlier, it might be a better idea
   to have these 'prefix' as the global option to "git" potty, not
   to each subcommand that happens to support them;

 * It is unclear how this should interact with commands that are run
   in a subdirectory of the working tree.  E.g. what should the
   prefix and the pathspec look like if the command in the above
   example is started in w/git.git/Documentation subdirectory, i.e.

    $ cd ~
    $ git -C w/git.git/Documentation ls-files \
        --submodule-prefix=??????? -- '???????' |
      xargs ls -1 -l

   Should we error out if we are not at the top of the working tree
   when --submodule-prefix is given?

 * It is further unclear how this should interact with commands that
   can give "relative" paths output if we allowed them to start from
   a subdirectory of the working tree.  E.g. "git grep" gives its
   output relative to where it was started from:

    $ cd ~/w/git.git/Documentation
    $ git grep -c 'ERROR.*frotz' -- '*.txt'
    git-checkout.txt:1

   How should it interact with the --submodule-prefix option and
   what value should the caller give to the option and how should
   the caller adjust the pathspec if it wants to get paths relative
   to my home directory?  I do not think the following is correct,
   but I am not sure what the correct values of them should be:

    $ cd ~
    $ git -C w/git.git/Documentation \
      --submodule-prefix=w/git.git/ \
      grep -c 'ERROR.*frotz' -- 'w/git.git/Documentation/*.txt'

   This becomes a non-issue if we forbid use of this new prefix when
   "git" is not started at the top of the working tree.

