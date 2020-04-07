Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDCFC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAE32074B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="slpLhSz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDGUFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:05:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63613 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGUFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:05:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0923456C65;
        Tue,  7 Apr 2020 16:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ikKqUEQaWUZStYrwG5oUg73Q2eA=; b=slpLhS
        z0OZmRBLY1Oqw+xBWYDopidVWIIiB+qGXNuCM1bcW0QaMFnaiFxFp6rv7VW8qUJO
        lYoyDexN82dI/RfGz2P7ryhnfULZ4KNsd2HIZUi7KjaEsmcjLuHxNZy5qvNyighy
        AQ40A2S344N4DyHQlYDionx2N1CVZUUnM2GRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jh88sTB5N/Nma6kvnp65rNjwMa+pO4Wq
        XcRGBVKYWYQ+tIH2z7S7posglV4okkWC4idlIW26WOaK+OP7vrPK/su/0M92wVg0
        KyDTQ7SvejbyGt5zkjo3NT8qe0qRVkmLGuQpJVrCZCPgx1Jpt5iKrF9PebqR4EJp
        3+tHD+bwf5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEA7156C63;
        Tue,  7 Apr 2020 16:05:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C8E756C62;
        Tue,  7 Apr 2020 16:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v12 3/5] bugreport: gather git version and build info
References: <20200406224526.256074-1-emilyshaffer@google.com>
        <20200406224526.256074-4-emilyshaffer@google.com>
        <xmqqeet0urts.fsf@gitster.c.googlers.com>
        <20200407184240.GB137962@google.com>
Date:   Tue, 07 Apr 2020 13:05:02 -0700
In-Reply-To: <20200407184240.GB137962@google.com> (Emily Shaffer's message of
        "Tue, 7 Apr 2020 11:42:40 -0700")
Message-ID: <xmqq4ktvt635.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11928D18-790B-11EA-8EE5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> To be clear, do you want me to include the output of get_compiler_info()
> in "git version --build-options" when I do that change, too?

In the endgame, there are two kinds of information we'd want to
gather and report, I would think.

Ones that can be different per-binary are things like:

 - what version of the source code the binary was compiled from
 - with what compiler options
 - using which compiler and
 - linking with what libraries,
 - where in the filesystem is the binary located

The others are various properties of the system the user is using,
and having trouble using, Git on:

 - how many CPUs do we have,
 - how much free memory,
 - is the repository's filesystem case sensitive,
 - what version of 'wish' is being used.

We'd want the former to be reported for each binary that matters, so
"git version --build-options" would want to say it, "git remote-curl
--build-options" would want to say it, and being different binaries,
they may say different things.

There is not much point in duplicating the latter that are not
binary specific, so it probably makes sense to gather them inside,
and report them from, "git bugreport" itself.

Thanks.
