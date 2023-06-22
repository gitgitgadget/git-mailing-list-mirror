Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F4DEB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFVVJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFVVIy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:08:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1343270D
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:07:01 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 454391A74A0;
        Thu, 22 Jun 2023 17:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5IU31bLsB/gQyF1uAicRnImKuT0Vb1SFo440S/
        SsN0M=; b=H0MiCrsBb7mrFvVPCJ3hXnbjhVaX4W9gKQ1syD7RCyWJw58/RAwL81
        nUNqNirflV2UI5gSa7Z2KZ7Gg9MngY3a5xit2mYutuxnybCG831nL7BeVuSTPIga
        340T6SC0OL+HDj0TruqdzDsqFzW2NsnJJtv++xD7G12QnHHyXvtrM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DAAD1A749F;
        Thu, 22 Jun 2023 17:05:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6C9A1A749E;
        Thu, 22 Jun 2023 17:05:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 1/3] var: add support for listing the shell
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230622195059.320593-2-sandals@crustytoothpaste.net>
        <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
Date:   Thu, 22 Jun 2023 14:05:39 -0700
In-Reply-To: <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 22 Jun 2023 16:42:31 -0400")
Message-ID: <xmqqjzvvdx7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B418FF8-1140-11EE-BE61-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This can be implemented more simply without a temporary file:
>
>     shpath=$(git var GIT_SHELL_PATH) &&
>     test -x "$shpath"
>
> This is safe since the exit code of the Git command is preserved
> across the `shpath=...` assignment.

Correct.  I also suspect that we want to add test_path_is_executable
helper next to test_path_is_{file,dir,missing} helpers and list it
in t/README.  One downside of your approach is that the output from
the command is only in $shpath and cannot be observed easily in the
$TRASH_DIRECTORY after the test fails, but with such a helper we can
report the problematic path when the expectation fails.

Thanks.
