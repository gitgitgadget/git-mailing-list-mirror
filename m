Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC3FC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4515A20720
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMjNreHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIJEZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:25:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57927 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJEZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 00:25:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59CCF706A7;
        Thu, 10 Sep 2020 00:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OrP5Ckt7hgF6+0XZDBIeO56lw/s=; b=GMjNre
        HTgHFyuaOkhKQ1gk2yTTNh9zyBZ/1t2LfddsqdZi52yLtImtzpACwS+1nGySKtjQ
        qI2LuQYhGlYTC9xBH6MRpEmE7GTkQXHPlJS8Q1cT3qI1eR6/8TLTPmz0CVek1PF1
        XvDs2N1kEh97HyCvSl2bLWFIrnmJUD5H4kfaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qi7/bV+lsDcPkobo7+Tzix909ZtEYfub
        yQWB3BJkX8eK/3xrbgxNTsQHRvSa5xVFJmWP6JukTpffgXLZ85l1UYj5AmcKOKHr
        03WRYTu5187EenvmDou61zEApquu5IKlhCDrSYLzcHqwoNCKyCtIarkkufixqGV4
        yJbUuG3NM+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5100A706A6;
        Thu, 10 Sep 2020 00:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9A15706A4;
        Thu, 10 Sep 2020 00:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 21:25:30 -0700
In-Reply-To: <pull.732.git.1599707259907.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Thu, 10 Sep 2020 03:07:39 +0000")
Message-ID: <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9E89F4E-F31D-11EA-8733-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> `git ls-files` learned to recurse into submodules when given
> '--recurse-submodules' back in e77aa336f1 (ls-files: optionally recurse
> into submodules, 2016-10-07) but it does not respect the
> 'submodule.recurse' config option which was later introduced in
> 046b48239e (Introduce 'submodule.recurse' option for worktree
> manipulators, 2017-05-31).
>
> Add a 'git_ls_files_config' function to read this configuration
> variable, and adjust the documentation and tests accordingly.

I am afraid that this will break existing scripts big time, and I
would not be surprised if 046b48239e refrained to do the equivalent
of this patch very much on purpose to avoid such a regression.

Anybody who writes a script using ls-files _without_ passing the
--recurse-submodules option expects that the ls-files command will
stop at submodule boundary without recursing, that the script can
notice and pick up mode 160000 entries in the output from ls-files,
and that the script can decide if it wants to descend into
submodules it discovered that way.

It is easy to imagine that such a script will break badly when run
by a user who has the configuration variable set, I would think.

It also is easy to imagine a script derived from "git-submodule.sh"
back from the time before we started rewriting pieces of it in C.
The main "discover and list the immediate submodules we have" code
was ls-files piped to a loop that picks up entries with mode 160000,
and it was used to drive all the "git submodule" subcommands.  As
the scripted version was not the world's greatest code, it is quite
plausible that somebody forked and improved it, without feeding the
changes back to us.  Such a script is also a candidate to be broken
with this patch.

So, no.  I am not enthused to see this change.
