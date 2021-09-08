Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6AEC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C150561139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbhIHQby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:31:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57109 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhIHQby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:31:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E2A2E675B;
        Wed,  8 Sep 2021 12:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o+7I0JobbbMAXvN5Z4u/yVCMkXBlZh7+MKb+9b
        XKfiU=; b=FSalNVi+nRVz3VBQ+9Sa+7AcpEHcnSpaBuNYsCs1U4kxYBJNWqikDh
        t1ERAwqeHO1v1vlBTFGTZEQRTRZfBYUDhS4ugTsrTIln+GAaBbo2wTxUdRCTsbVL
        ZhCn2A1dzfxX69MIwTiLAEh86BgxLYXvlzvuO5xWu66067NVE2+Nc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 849DEE6759;
        Wed,  8 Sep 2021 12:30:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3AFFE6758;
        Wed,  8 Sep 2021 12:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] stash: restore untracked files AFTER restoring
 tracked files
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
        <ac8ca07481d2ed4156036c2441d10712a1b92b0e.1631065427.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:30:44 -0700
In-Reply-To: <ac8ca07481d2ed4156036c2441d10712a1b92b0e.1631065427.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 08 Sep 2021
        01:43:46 +0000")
Message-ID: <xmqq5yvb58sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DBB6DD0-10C2-11EC-9BA8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> If a user deletes a file and places a directory of untracked files
> there, then stashes all these changes, the untracked directory of files
> cannot be restored until after the corresponding file in the way is
> removed.  So, restore changes to tracked files before restoring
> untracked files.
>
> There is no similar problem to worry about in the opposite directory,

direction, I think.

If a user deletes a directory with tracked files in it and places an
untracked file at the path the directory used to be, and then stash
all these changes, that would be the opposite direction, I would
presume?  The untracked file would be restorable only after applying
the removal of the tracked files that occupied the directory.

Which would be fine if we apply the changes to the tracked ones first.

OK.

After creating a stash, we clear the working tree.  How do we do
that exactly, and would we have a similar problem there?  We need to
first remove the untracked file that currently occupies where the
directory used to be in HEAD, and then create the directory and
resurrect the tracked files in the directory from HEAD, in my
modified example above.  In the file-becomes-directory scenario, is
the story the same?

Thanks.
