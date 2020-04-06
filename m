Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBD0C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1273206C0
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAmXB0Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDFXRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:17:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56066 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDFXRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 19:17:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C902C66BBF;
        Mon,  6 Apr 2020 19:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/smlZtmG1E3KRFKHX50hPaPW2Cc=; b=dAmXB0
        Ync1SqzWKP86YpC/7aaPnrVwNM9jVFKDR/l0RVUCVVHpSJ7U3mLVq6WnCrujP1jv
        Q8H8MB6WZQUSR49il8Jk1jAOIszegzYM2/1nZxL++8LSXG6OIGgtyr/k+c0LSQFv
        ZywjcKr8dw1FjKTLv6tqfrDzNzchPwmNwq4vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nW5ppHJkE0VO3a73fsEZ2eR2YwOxRwvL
        fQjwR9aUxRM0/lcqpKheho08ESPcjJ1VbcluOP7T820XtA0mna0wzGCpD63aCLkt
        Za4sMDL93ddAeUI384EzBe2bu+xqa3+kmiqnTqywF5/kfnYrzCMnk6cEV4FaP5xi
        2wG3zpHMOnI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0E9566BBE;
        Mon,  6 Apr 2020 19:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CAE766BBD;
        Mon,  6 Apr 2020 19:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v12 3/5] bugreport: gather git version and build info
References: <20200406224526.256074-1-emilyshaffer@google.com>
        <20200406224526.256074-4-emilyshaffer@google.com>
Date:   Mon, 06 Apr 2020 16:17:51 -0700
In-Reply-To: <20200406224526.256074-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 6 Apr 2020 15:45:24 -0700")
Message-ID: <xmqqeet0urts.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D624E5FE-785C-11EA-AC5F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It's not ideal to directly call 'git version --build-options' because
> that output goes to stdout. Instead, wrap the version string in a helper
> within help.[ch] library, and call that helper from within the bugreport
> library.

This means that "git-bugreport" that can be a different binary from
say "git-remote-curl" (or "git-version" for that matter) would still
report whatever version string that was compiled into "bugreport".

Reporting the version of "bugreport" is *not* useless, and what this
step adds to the report is good.  

But the version number of "bugreport" may not have much to do with
the binary the end user is having trouble with, so we'd also want
the version of the main part of "git", and other standalone "git"
subprograms like "git-remote-curl", reported separately, probably
together with $PATH, $GIT_EXEC_PATH and what appears in the
directories listed on these environment variables.

If "git version --build-options" writes to its standard output
stream, that is a good thing, as it makes it easy to spawn and read
what it says via the run_command() API, and there is one less thing
to worry about (it would be a bit more cumbersome if the output goes
to the standard error stream).

As "git-remote-curl" would also be a separate binary, we'd have to
use the same technique to report version number (and perhaps curl's
library version and its configuration?), perhaps by teaching the
subcommand a new option to dump such details to its standard output.

Using the same technique to report the version about the "git"
itself would be consistent thing to do, as a preparation for future
steps that reports the details about "git-remote-curl".

Thanks.
