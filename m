Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898E1EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGUEcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGUEcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:32:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38443272E
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:32:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB5212A17A;
        Fri, 21 Jul 2023 00:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=decxHgdCn5JLFFqhUbUW08wq0ImgJV1qBG0Wbq
        HGjbA=; b=ON4yxm7oYeadM2UbGyOJhvcF5/lXnSJHPzZz9BcRVlNIzTFI6Spncv
        Y3JZxV6EI7GiV3RPgc5sN0MqNeoruiEK2HS9dMqXhzqodOG1PJNqj2FjHUFdtx2j
        wxcr4pfCEG5+qGgsoPicHjXI3+Fs6qEtV7qX5N5eHy1x0j6S4PBsg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A31062A179;
        Fri, 21 Jul 2023 00:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A32C2A178;
        Fri, 21 Jul 2023 00:32:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/2] config: return positive from git_config_parse_key()
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
        <99244816307b822bd8ffcbff8690ef449c797a23.1689891436.git.gitgitgadget@gmail.com>
Date:   Thu, 20 Jul 2023 21:32:09 -0700
In-Reply-To: <99244816307b822bd8ffcbff8690ef449c797a23.1689891436.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Thu, 20 Jul 2023 22:17:15
        +0000")
Message-ID: <xmqq4jlx28c6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E9A5C3E-277F-11EE-A498-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> git_config_parse_key() returns #define-d error codes, but negated. This
> negation is merely a convenience to other parts of config.c that don't
> bother inspecting the return value before passing it along. But:
>
> a) There's no good reason why those callers couldn't negate the value
>    themselves.

That is not a good reason to break from a widely adopted convention
in UNIXy library functions to signal success with 0 and failure with
negative values.  The callers if they want to have a positive values
can flip the polarity themselves, by the way.

>
> b) In other callers, this value eventually gets fed to exit(3), and
>    those callers need to sanitize the negative value (and they sometimes
>    do so lossily, by overriding the return value with
>    CONFIG_INVALID_KEY).

There is no reason to think that each and every minute difference
the direct callers of a library function may want to notice by
different error return values needs to be propagated to the calling
process via its exit value.  It is perfectly fine and expected for
the status values of the entire process is more coarse grained than
individual library calls, the latter may convey not just "I failed"
but "I failed why" to their callers, while the former may not want
to say "I made a call to some library functions and got this error
code", let alone "I called library function X and got error code Y".

In other words, if your program does

	err = library_call_about_some_filesystem_operation();
	if (err)
		exit(err); /* or exit(-err) */
	err = library_call_about_some_database_operation();
	if (err)
		exit(err); /* or exit(-err) */
	err = library_call_about_some_parsing();
	if (err)
		exit(err); /* or exit(-err) */

there is something wrong.  The error codes from these different
library functions share the same "integer" namespace without being
segregated, and expecting the calling process to be able to tell
what error we discovered by relaying the literal translation of low
level library error code would not work.  The exit() codes would
need to be wider (i.e. not limited only to the possible errors from
a single library function) and would be coarser (i.e. a filesystem
operation may say "open failed due to permission error" or "open
failed because there was no such file"; at the end-user level, it
may be more appropriate to say "configuration file could not be
read", regardless of the reason why the filesystem operation
failed).

	err = library_call_about_some_filesystem_operation();
	if (err) {
		error("cannot open the filesystem entity");
		exit(ERR_FILESYSTEM);
	err = library_call_about_some_database_operation();
	if (err)
		exit(ERR_DATABASE);
	err = library_call_about_some_parsing();
	if (err)
		exit(ERR_PARSING);

So, this is not a good reason, either.

> c) We want to move that into a separate library, and returning only
>    negative values no longer makes as much sense.

Quite the contrary, if it were a purely internal convention, we may
not care too much, as we have only ourselves to confuse by picking
an unusual convention, but if we are making more parts of our code
available in a library-ish interface, I would expect they follow
some convention, and that convention would be "0 for success,
negative for failure".

Thanks.
