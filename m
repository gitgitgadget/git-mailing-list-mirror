Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066E7C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 16:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjEPQMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEPQMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 12:12:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068793D4
        for <git@vger.kernel.org>; Tue, 16 May 2023 09:11:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADB6E18DC59;
        Tue, 16 May 2023 12:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FaksOVUOZ6/kXCMX3Xu0QxzmKLhY5d+IVSF1vU
        NMtkY=; b=r6H6SQn71p+Vna3eN5nxUM4lR9Fao9mbZVEQiss3VzKIEVVVj8aW4X
        964diyftXOBLKMH9GP82UJm+psba6yL1fGcdV0WfLRXAHbAs9I12yuI8zaExp46q
        R4KYrjPAaJcr7eiL6mtjQ/u2tYXIgX1Pek0ZYHye0V0gNPGwiZTVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CEE18DC58;
        Tue, 16 May 2023 12:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0133218DC57;
        Tue, 16 May 2023 12:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] credential/libsecret: support password_expiry_utc
References: <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com>
        <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
        <CAGJzqskMwOJkriH6serqdwAVYi+fftEL8ohJd-suP6v+OxB_bg@mail.gmail.com>
        <xmqq353xa2cg.fsf@gitster.g>
        <CAGJzqsn_Jmr3x0tj3U7QRD3eGMzWwr3RR1-O3_YzFCMCU7u+eQ@mail.gmail.com>
Date:   Tue, 16 May 2023 09:10:33 -0700
In-Reply-To: <CAGJzqsn_Jmr3x0tj3U7QRD3eGMzWwr3RR1-O3_YzFCMCU7u+eQ@mail.gmail.com>
        (M. Hickford's message of "Tue, 16 May 2023 09:03:51 +0100")
Message-ID: <xmqq4jocw93a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3091A696-F404-11ED-94B4-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

> Yes, I think that would work nicely. A format such as that below would
> be backwards compatible (passwords already can't contain newlines) and
> self explanatory to any curious user browsing their secret store. I
> already have a draft that works much like this. I'll prepare a patch
> v4.
>
>     7d7b554
>     password_expiry_utc=1684179877
>     oauth_refresh_token=be8a9aa3
>
> Is the secret store ever shared with other applications such as a web
> browser? If so, sharing is already broken, because popular Git hosts
> such as GitHub and GitLab expect different passwords for web login and
> Git authentication (OAuth token or personal access token).

It probably is a good argument.  We do not have to worry about
interoperating with browsers and their authentication with Git
hosting sites.  And the "newline can be used to add extra pieces of
information" is a good trick ;-)

> A solution
> could be to introduce our own libsecret schema (as in the current
> patch) instead of continuing to use SECRET_SCHEMA_COMPAT_NETWORK
> potentially shared with other apps. I'm not sure whether that's
> worthwhile in this patch. I defer to you.

It may depend on what other Git GUI frontends may want to do.  If
there is no precedent and you are the pioneer, then using our own
would be perfectly fine and we can let others also read from us if
they want to; I presume that it would not prevent us from doing so
even if did not use COMPAT_NETWORK (which gnome dev document even
discourages of its use in new applications anyway).

Thanks.


