Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A50C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C1E64F69
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 23:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhCDXeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:34:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54374 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCDXeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 18:34:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1AC59872F;
        Thu,  4 Mar 2021 18:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V4srOnfph/9MK+OtEYk5OpJvpRo=; b=o8CS1X
        Mtyd2F5ZuKVBXYLHEEimVwoC/ZXH8so7S47F8ZwLKKa7p1yGR4q1I0LjmP29WbJZ
        VhVKCvu+N5SX+zqWrSBwpAb7oTSprjBX2pY2eZ+8xKA4Ph+MmGV/R55++G61lPc+
        hQe57GnT9ZOahR8/mEO0bX3/vpT31WY70QF5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tt8loPhNTgkFAKTD8IqZi0kRZEHql2I2
        ZPNtvKCK2YnIWjA8D5yGiLmPbMEqNpDiTgp+9moAuSJJ0XuVIuiNDSi8ryME9yVL
        pILBojDDBqdDX45NtYvIYFnOCxvj2ua3x7a5Ssot92nFm2UlNvsRrcyxGJYTHkcj
        IAE5sZGTRDc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B80029872E;
        Thu,  4 Mar 2021 18:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0151298728;
        Thu,  4 Mar 2021 18:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
        <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
        <YED1DmLWd+ciySNa@coredump.intra.peff.net>
        <xmqqa6riejyp.fsf@gitster.c.googlers.com>
Date:   Thu, 04 Mar 2021 15:34:07 -0800
In-Reply-To: <xmqqa6riejyp.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 04 Mar 2021 12:34:54 -0800")
Message-ID: <xmqqtupqbij4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D733362-7D42-11EB-BCD7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So I dunno. I'd be OK to just rip the feature out in favor of doing
>> those chdir()s. But that seems like a non-zero amount of work versus
>> leaving, and the existing code has the benefit that if another caller
>> shows up, it could benefit from the feature.
>
> I am OK to keep the series as-is, and leave it to a possible future
> work to remove the need for chdir even for long paths and not having
> to return an error with ENAMETOOLONG; when such an update happens,
> the "fail if need to chdir" feature this patch is adding will become
> a no-op.

For example, as this is UNIX-only codepath, I wonder if something
like this would be a good way to avoid chdir() that would cause
trouble.

    - obtain a fd from socket(2)
    - check if path is too long to fit in sa->sun_path
      - if it does, bind(2) the fd to the address
      - if it does not, fork(2) a child and
        - in the child, chdir(2) there and use the shortened path
	  to bind(2), and exit(3)
        - the parents just wait(2)s for the child to return. By the
          time it dies, the fd would be successfully bound to the
	  path.
    - now we have a file descriptor that is bound at that path.

