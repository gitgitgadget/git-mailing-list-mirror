Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC9C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbiGNXIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 19:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNXIX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 19:08:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCECF6EEB1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 16:08:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11C7C1456B0;
        Thu, 14 Jul 2022 19:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0wdycjWWsb2IlbbLyWmBZzOzjsWuj8i+g+7sDi
        dZZOI=; b=ZqTwtdb4iJnHZrNZKB5Uo25Gsh3Dr+9T0jPtqyQ6Pw9yWvI+uFd2v4
        2hpi7OcTJxolaDwz8xCLx1inNutCehWLNlOegt5G7mW3tWES2TxRvzRHdthb547q
        8gt8XW8gk38fR9FHd/t2yy1wOAFxlS2ZpWGabVagLx9NJPnOwtQl4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A1851456AF;
        Thu, 14 Jul 2022 19:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69AB81456AE;
        Thu, 14 Jul 2022 19:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Julian Prein <druckdev@protonmail.com>
Subject: Re: [PATCH] hooks--pre-commit: detect non-ASCII when renaming
References: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com>
        <xmqqedyn2t6e.fsf@gitster.g>
Date:   Thu, 14 Jul 2022 16:08:20 -0700
In-Reply-To: <xmqqedyn2t6e.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        14 Jul 2022 16:03:37 -0700")
Message-ID: <xmqqa69b2syj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAEB5CDA-03C9-11ED-BD56-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julian Prein <druckdev@protonmail.com>
>>
>> Currently the diff-filter that is used to check for non-ASCII characters
>> in filenames only checks new additions.
>>
>> Extend the diff-filter in the pre-commit sample to include `CR` as well.
>> This way non-ASCII character in filenames are detected on a rename/copy
>> as well.
>
> It would probably be a better implementation to disable the rename
> detection, instead of adding Copies and Renames.

That is ...

>> -	test $(git diff --cached --name-only --diff-filter=A -z $against |

... instead of using the "git diff" Porcelain, we can probably use
the "git diff-index" plumbing command here, which will not be
affected by end-user configuration or by the fact that recent "git
diff" turns on the rename detection by default.
