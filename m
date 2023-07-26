Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED4C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGZRPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGZRPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 13:15:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2C2706
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:15:04 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D63A192590;
        Wed, 26 Jul 2023 13:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ZInk2/0DjOHGHnJMnqzIWusF6YxGV54v/kkwh
        sd9MY=; b=ht2hO+VYvpVrRk7w8mbP6/PXDODMREeLpTtjxkUqRCsuNtkbVPAi/f
        nxE3YayFiRpp3n7CGmm2FCvO41ErdFjrYkVL9PRI71+KAWW/EKtN8AFqMpI81yGQ
        k7k1bVgp2pwocfDZKyTr+ZkF+Pz8oLos/b/8SbneZCx6/8QuF/Va0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C3B819258E;
        Wed, 26 Jul 2023 13:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21E9019258B;
        Wed, 26 Jul 2023 13:15:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential/libsecret: erase matching creds only
References: <pull.1527.git.git.1687591293705.gitgitgadget@gmail.com>
        <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 10:15:01 -0700
In-Reply-To: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Wed, 26 Jul 2023 16:06:25
        +0000")
Message-ID: <xmqqzg3id27e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F57C9870-2BD7-11EE-A6FD-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> The credential erase request typically includes protocol, host, username
> and password.
>
> credential-libsecret erases a stored credential if it matches protocol,
> host and username, regardless of password.
>
> This is confusing in the case the stored password differs from that
> in the request. This case can occur when multiple credential helpers are
> configured.
>
> Only erase credential if stored password matches request (or request
> omits password).

This is much better.

> This fixes test "helper ... does not erase a password distinct from
> input" introduced in aeb21ce22e (credential: avoid erasing distinct
> password, 2023-06-13)

This was still confusing for a patch that does not touch anything in
t/, but after re-reading aeb21ce22e and the above a few times, I
think I get it.  Adding the following

	, when t0303 is run with GIT_TEST_CREDENTIAL_HELPER set to
	"libsecret".

at the end may help, but perhaps it is too obvious for folks who are
ready to actually review this change---presumably they are familiar
with how t0303 is to be used and read that without being told from
the context?

Thanks.

