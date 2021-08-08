Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA2C4320A
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CC460F0F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhHHRug (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 13:50:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64287 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhHHRuf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 13:50:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDB02C5594;
        Sun,  8 Aug 2021 13:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X3BupXrm+OYj75SlGLeT3vrYAh4S0/0+7odULa
        MkOZo=; b=J6MMopZB6O7ZxPprU5BZsYRtjx0HtHhrbYjZpv4islWdH7y0W91wS1
        ZOKqws7fu6oji6reRHxkdnTE3eOrnGs+HHwNzNQODhLBbbMRAgRw0nfcee3oIZvj
        KYEynir3PWXHfC4ogOX/VVUlwe9Xk5/JWWdcx8Ln3x8rQiNKVnvRc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5DA0C5593;
        Sun,  8 Aug 2021 13:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56EC7C5591;
        Sun,  8 Aug 2021 13:50:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Noah Pendleton <noah.pendleton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
References: <20210807202752.1278672-1-noah.pendleton@gmail.com>
        <xmqqr1f5hszw.fsf@gitster.g>
        <CADm0i3-ToKo1gNTXXLHH6i2d4qpz771VeRjDsfJjgbgMfhx6rA@mail.gmail.com>
        <xmqqtuk0h4ph.fsf@gitster.g>
Date:   Sun, 08 Aug 2021 10:50:14 -0700
In-Reply-To: <xmqqtuk0h4ph.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        07 Aug 2021 22:43:06 -0700")
Message-ID: <xmqqim0fhlm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16474330-F871-11EB-AB01-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think an easier way out is to introduce a new configuration
> variable blame.ignoreRevsFileIsOptional which takes a boolean value,
> and when it is set to true, silently ignore when the named file does
> not exist without any warning.  When the variable is set to false
> (or the variable does not exist), we can keep the current behaviour
> of noticing a misconfigured blame.ignoreRevsFile and error out.
>
> That way, the current users who rely on the typo detection feature
> can keep relying on it, and those who want to make it optional can
> do so without getting annoyed by a warning.

A bit more ambitious might want to consider another more generally
applicable avenue, which would help the userbase a lot more, before
continuing.

We start from the realization that this is not the only
configuration variable that specifies a filename that could be
missing.  There may be other variables that name files to be used
("git config --help" would hopefully be the most comprehensive, but
"git grep -e git_config_pathname \*.c" would give us quicker
starting point to gauge how big an impact to the system we would be
talking about).

What do the codepaths that use these variables do when they find
that the named files are missing?  Do some of them die, some
others just warn, and yet some others silently ignore?  Would such
an inconsistency hurt our users?

Among the ones that die, are there ones that could reasonably
continue as if the configuration variable weren't there and no file
was specified (i.e. similar to what you want blame.ignoreRevsFile to
do)?  Among the ones that are silently ignored, are there ones that
may benefit by having a typo-detection?  Do all of them benefit if
the behaviour upon missing files can be configurable by the end-user?

Depending on the answers to the above questions, it might be that it
is not a desirable approach to add "blame.ignoreRevsFileIsOptional"
configuration variable, as all the existing configuration variables
that name files would want to add their own.  We might be better off
inventing a syntax for the value of blame.ignoreRevsFile (and other
variables that name files) to mark if the file is optional (i.e.
silently ignore if the named file does not exist) or required (i.e.
diagnose as a configuration error).  For example, we may borrow from
the "magic" syntax for pathspecs that begin with ":(", with comma
separated "magic" keywords and ends with ")" and specify optional
pathname configuration like so:

    [blame] ignoreRevsFile = :(optional).gitignorerevs

and teach the config parser to pretend as if it saw nothing when it
notices that the named file is missing.  That approach would cover
not just this single variable, but other variables that are parsed
using git_config_pathname() may benefit the same way (of course, the
callsites for git_config_pathmame() must be inspected and adjusted
for this to happen).

Thanks.

