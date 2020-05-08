Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B22BC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E8D21655
	for <git@archiver.kernel.org>; Fri,  8 May 2020 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Exv7sAqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgEHPHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 11:07:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55375 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 11:07:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B827FD737F;
        Fri,  8 May 2020 11:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DwcaRqXhnjyp8xMtrOwU9dx9XbU=; b=Exv7sA
        qfyHYLyKUfKhRPfWI3/yFsKXBvqNUUhmK75Sv3k0KFCzWbqkeiF15HRDl7azRbw9
        u0j+RKkFg2QqmzXIVJA0HgzxX7MjUXjs5cSXKkQDkPMUh0MHdNsMlTCT/ZAFErmK
        sOi3C51yPOVQPssmREt3WeskHnGfuAGOsJUQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mnL5XZFxG6ZkcccC8IqwYUkGHAiRXOd5
        M2k6FhUZzcTQaOMS/+oS9kXlxdeJwEWZlQTwKeMzJsG/FVvw+boL3kSX1/TRTq14
        pAg6ZRovJQNvlEM5TQHlhCJJauqmVrgDsRM4cj+gXn0otibt2KATpwvXoEdVZ6EW
        ZFYGd4RYY7A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFF16D737E;
        Fri,  8 May 2020 11:07:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CEBFED737C;
        Fri,  8 May 2020 11:07:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christopher Warrington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christopher Warrington <chwarr@microsoft.com>
Subject: Re: [PATCH] bisect: fix replay of CRLF logs
References: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
        <20200507222510.GA42822@coredump.intra.peff.net>
        <xmqq5zd72vjp.fsf@gitster.c.googlers.com>
        <20200508130831.GB631018@coredump.intra.peff.net>
Date:   Fri, 08 May 2020 08:07:05 -0700
In-Reply-To: <20200508130831.GB631018@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 8 May 2020 09:08:31 -0400")
Message-ID: <xmqqh7wq1n52.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9517EC9C-913D-11EA-89E5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 07, 2020 at 04:07:54PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > The simplest fix is probably to clean up "$file" into another tempfile,
>> > and then read from that.
>> 
>> Or just tell the users do not break the log file (or they can keep
>> both halves)?
>
> I am OK with that, too. :)

Well, that was tongue-in-cheek.

The log is designed to be edited and then run via the shell or fed
to the "bisect replay" subcommand, so if a (wide) class of editors
tend to "corrupt" the edited result in a known and recoverable way,
we should deal with it.

Replaying is just setting the refs the logged session should have
known about (without checking out the revisions at each step) and
doing the final checkout, so it should be a fast operation, and
penalizing majority of users by paying the cost to dos2unix copy the
file "just in case" feels somewhat ugly.  I wish we were dumb and
checked out each and every intermediate steps---then the cost for
such a "just in case" clean-up would have been dwarfed in the noise.

I wonder if we can add a CR to IFS so that the parsing logic of each
line would not even see it?

 bisect_replay () {
         file="$1"
         test "$#" -eq 1 || die "$(gettext "No logfile given")"
         test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
         git bisect--helper --bisect-reset || exit
+        IFS="$IFS$(printf "\015")"
         while read git bisect command rev
         do
                 test "$git $bisect" = "git bisect" ||
                 test "$git" = "git-bisect" || continue

