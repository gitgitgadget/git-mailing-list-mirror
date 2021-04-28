Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB2C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 05:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7F561413
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 05:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhD1FIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 01:08:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51199 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhD1FIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 01:08:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48362AEF72;
        Wed, 28 Apr 2021 01:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+uGctuWeKfNzC03Ed/PbQUG4x0GFhHGoTsDL+L
        Y+nZY=; b=xi8kxC9TiBfSfc7d7dMBySWa1Qi8Z6ZYK4TMDdKW8ubOAm1VHv+slf
        XgFMCmn13WUZ2MMUp2MQ16XY6gP57vUN4e6hZfsvvqX8bOClCGo2GWeRCrqXe5aC
        Mb/uAIxNwjqE4u7XRlGbPMB6RUtTGmbzQ1sa9GS0950UMPPVR/NJ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D86CAEF71;
        Wed, 28 Apr 2021 01:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4771EAEF6E;
        Wed, 28 Apr 2021 01:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH V2] git-apply: add --allow-empty flag
References: <20210427011246.28054-1-jerry@skydio.com>
        <20210427194049.14399-1-jerry@skydio.com>
Date:   Wed, 28 Apr 2021 14:08:06 +0900
In-Reply-To: <20210427194049.14399-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 27 Apr 2021 12:40:49 -0700")
Message-ID: <xmqqmttjate1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B81B0148-A7DF-11EB-AB15-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Some users or scripts will pipe "git diff"
> output to "git apply" when replaying diffs
> or commits. In these cases, they will rely
> on the return value of "git apply" to know
> whether the diff was applied successfully.
>
> However, for empty commits, "git apply" will
> fail. This complicates scripts since they
> have to either buffer the diff and check
> its length, or run diff again with "exit-code",
> essentially doing the diff twice.
>
> Add the "--allow-empty" flag to "git apply"
> which allows it to handle both empty diffs
> and empty commits created by "git format-patch
> --always" by doing nothing and returning 0.
>
> Add tests for both with and without --allow-empty.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> This patch applies on top of "git-apply: add --quiet flag".
> The conflict is in Documentation -> Synopsis and is
> trivial to solve.

> V1 -> V2:
> - Moved behavior under a flag
> - Added tests for both cases

When people add a flag (a boolean option), it becomes tempting to
add a corresponding configuration variable.

I wonder it this step should start calling

	git apply --no-allow-empty

when "git am" drives it, so that a futre end-user configuration
variable would not break it?


