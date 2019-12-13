Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D9EC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34225206B7
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l+VWkL+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMVve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:51:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58107 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:51:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 202B9A87F0;
        Fri, 13 Dec 2019 16:51:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XEenMgKSfhQ6wZSrIbLVUo0c3Sc=; b=l+VWkL
        +jHtsQXdWmh6jK1nvQxyhhcmYJuGOscpw1A5uN62wD4uwIWzxh5dHPNodK9J4BNf
        +Hw+rDCBMeEnfA3KFLt9xgtF6BfUDfOCqrMBQwv8+cxMF64irfj1fPCD2cSAu0g5
        RuzBT6JVeOJxVjBSa5dUZBY0CAqPpX1IWdjuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kV5KQWzUKokwIIfdAPT/Gc7a/MfTLgHL
        4ROuAQZOzY//dCLJ81vgCniWefqqQ84xDWX0N7bA4iGfLd2esRPcXVbB9PjY/yiJ
        ybyl4YKLHBNR4qZjCFEN0o5DnRTY6ocjEqCJMe2aYPEm9qk4YM8vSqsFfK/Oi/hF
        1z7eQfhLvKw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17E26A87EF;
        Fri, 13 Dec 2019 16:51:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 393E0A87EE;
        Fri, 13 Dec 2019 16:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 12/15] bugreport: count loose objects
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-13-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:51:27 -0800
In-Reply-To: <20191213004312.169753-13-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:09 -0800")
Message-ID: <xmqqv9qjhp28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B879DCCC-1DF2-11EA-BAA2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> The number of unpacked objects in a user's repository may help us
> understand the root of the problem they're seeing, especially if a
> command is running unusually slowly.
>
> Rather than directly invoking 'git-count-objects', which may sometimes
> fail unexpectedly on Git for Windows, manually count the contents of
> .git/objects.

Is for_each_loose_object() or for_each_loose_file_in_objdir() not
sufficient?  We really do *not* want a redundant implementation of
something we already use elsewhere in the system, especially for the
purpose of this program, because you would end up reporting what you
computed in a way that may be quite different from what the rest of
the system that is actually used by the end users computes.

