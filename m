Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9A71FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756622AbcKVTK3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:10:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58905 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755534AbcKVTK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:10:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9FF850793;
        Tue, 22 Nov 2016 14:10:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+oYqlChe7dFBQOKRPKstuil0178=; b=NjjNuD
        rabbM624F1gO9pBkPzLQE/Rh739dSK16unjoO1V8QiAoSNIqIZmoMt1lDdas72uU
        7UwP8UbIS1UO71e2aJ6kCheNxT5+tot5D9WmivCVqs7VMOvzkuMEyPGzXQt1NITS
        MDm0ijgQL4u6m6/llxFHJ+HQ90FR9E9PkZPgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JAHDeRRLynJHhCHtoti0kDQz44/rK3H0
        TPZdhOsj0LHnpdkKC+wUYRA5/y/M/Z+wQR62rG28IEv79yTynYj17e6LzYfCJk9k
        JN4jcV8dsJSWkBEAG0l3mG7fb1YDcDplU6BT3ZRw8npKuk3UCAZFdHD26jmYg0Kw
        jX5aeP04nxU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1A7750791;
        Tue, 22 Nov 2016 14:10:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C6815078E;
        Tue, 22 Nov 2016 14:10:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
        <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
        <alpine.DEB.2.20.1611221712480.3746@virtualbox>
        <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 22 Nov 2016 11:10:25 -0800
In-Reply-To: <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 22 Nov 2016 09:10:08 -0800")
Message-ID: <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5349903E-B0E7-11E6-9094-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think we want to audit the ones without RUN_SETUP* in the command
> table in order to hunt for regression aka "a fix revealed a bug that
> was covered by .git/config accidentally getting read when run from
> the top-level of the working tree", though. We may find unreported
> breakages that we may have to fix.

So I took a brief look at the "PROGRAM_OBJS += ..." in the Makefile
for non-builtin commands, and commands[] array in git.c for builtin
commands to see how bad it looks.


Archive & Upload-archive:

"cd Documentation && git archive --remote=origin" immediately hits
"BUG: setup_git_env called without repository" if your Git is built
with b1ef400eec ("setup_git_env: avoid blind fall-back to ".git"",
2016-10-20), which will not be part of the upcoming release.  And
'origin' will probably not be understood from the local config.

I think we can do the "gently" thing there, as we may be retrieving
a remote archive outside a local repository.  We'd need to tweak
"output" with prefix to compensate for the case in which the command
is run from a subdirectory, and probably we need to futz with the
setup_prefix parameter to write_archive(), as a local caller now
will know if we are in nongit situation.

On the upload-archive side that serves "--remote" request, there is
enter_repo() so we should be covered OK.


Mailinfo:

We may want a "gently" thing there to pick up local configuration.
i18n.commitencoding and mailinfo.scissors in local repository would
be ignored otherwise.


Splitspace:

Dscho fixed this one.


Verify-pack:

This calls git_config() but these days farms out its operation to
"index-pack", so we should be OK.  We may even want to lose the call
to git_config() which does not affect anything.

