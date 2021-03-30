Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACAC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B223D61985
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhC3TJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:09:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhC3TJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:09:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C59CC0039;
        Tue, 30 Mar 2021 15:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A1EMEEVRUYI+PZ8x2btD0U+bqLI=; b=CCSAUD
        2BF3VQ2sD2txzK1WkyMAZL4RoKUM9X98szWUTSh947BZArMQNVMjm+wKSk3ybUI6
        IgukVwSz99jFpCY6az5zWoAB/UhRyCmYZvsBPZrvnmrXCY8VGhCJG7RFHGtvel0P
        Jk7qqUJNGbp1o0En/gQhKLtJ9/ttuCs/P7e4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FEfq5E6qpQr8DS0Q78P4rym7MDg+HVIv
        Zk95t3CGvZjy0LjuNrvAAL7c7esVygV9nBIQ82q+X8ZdtWmDUNZNcar7rAwt+BCu
        7WNa1zqxYdnD1fMXzuRPi/4VVT9orUNQOg9niQ7iK/PlHmWPesanyz6WTtEmdkmf
        gdtsl62S9XI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74539C0038;
        Tue, 30 Mar 2021 15:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F04D4C0036;
        Tue, 30 Mar 2021 15:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dominyk Tiller via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Dominyk Tiller <dominyktiller@gmail.com>
Subject: Re: [PATCH] persistent-https: add go.mod to fix compile
References: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 12:09:34 -0700
In-Reply-To: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com> (Dominyk
        Tiller via GitGitGadget's message of "Tue, 30 Mar 2021 13:07:48
        +0000")
Message-ID: <xmqqy2e4cvbl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7720B3BE-918B-11EB-B554-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dominyk Tiller via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dominyk Tiller <dominyktiller@gmail.com>
>
> GOPATH-based builds and non module-aware builds are being deprecated
> by golang upstream, which currently causes this to fail. This adds a
> barebones mod file to fix the build.
>
> The `persistent-https` code hasn't been touched for a long time but
> I assume this is preferable to simply removing it from the codebase.
>
> Before this change:
> ```
> case $(go version) in \
> 	"go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
> 	go build -o git-remote-persistent-https \
> 		-ldflags "-X main._BUILD_EMBED_LABEL${EQ}"
> go: cannot find main module, but found .git/config in ../git
> 	to create a module there, run:
> 	cd ../.. && go mod init
> make: *** [git-remote-persistent-https] Error 1
> ```

With which version of go?  Any recent version would fail the same
way, or only 1.16 and later?

> Ref: https://blog.golang.org/go116-module-changes.

> diff --git a/contrib/persistent-https/go.mod b/contrib/persistent-https/go.mod
> new file mode 100644
> index 000000000000..6028b1fe5e62
> --- /dev/null
> +++ b/contrib/persistent-https/go.mod
> @@ -0,0 +1,3 @@
> +module github.com/git/git/contrib/persistent-https
> +
> +go 1.16

Can I ask what is affected by this 1.16 version number?  Do the
users have to use 1.16 and nothing older or newer?

As a non Go user, I am trying to see if this change is "make it work
for all users of reasonably new versions of Go" (if that is the
case, what is the "reasonably new") or "make it work for those with
1.16, and everybody else should either install 1.16 or figure out 
their own solutions".

Thanks.
