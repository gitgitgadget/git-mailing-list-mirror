Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29860C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D68B60F9E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhHaR5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:57:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57938 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhHaR5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:57:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3143F156284;
        Tue, 31 Aug 2021 13:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y+GanrG3p6//chX894KiJZLVeBz+Wtzs0yLBeZ
        m+HDg=; b=FeSWHqBbxtnsOgS4SiSIXMwj/k25gjtIN+uQ344fVs+OZiv8pOcRt8
        f5GBD//pKs8HDL+uspkeEfmEtK7SJmgZsPYL2HSLLEEhrk4cw0y/y0zDOGGDNumP
        7N5gJfjfAPR7GeDgtSzi4Ove+2rCoEnauykmfcwsAItoAheY93k/8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29E68156283;
        Tue, 31 Aug 2021 13:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E115156282;
        Tue, 31 Aug 2021 13:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Thorp <andrew.thorp.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: `git commit` adding unstaged chunks of files to commits on
 2.33.0
References: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
Date:   Tue, 31 Aug 2021 10:56:42 -0700
In-Reply-To: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
        (Andrew Thorp's message of "Tue, 31 Aug 2021 13:15:18 -0400")
Message-ID: <xmqq4kb5v6p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE695FB4-0A84-11EC-975C-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Thorp <andrew.thorp.dev@gmail.com> writes:

>> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Edit a checked-in file, adding multiple chunks of lines to the file.
> Using `git add -p <file>`, stage one of the chunks, leave some chunks unstaged.
> After running `git status` the file should both in the section
> `Changes to be committed:` and `Changes not staged for commit`.
> Commit the changes.

How was the last "commit the changes" done exactly?  

If either "git commit -a" or "git commit <file>" was done, that
would explain the symptom of having the entire up-to-date contents
of <file> in the working tree recorded in the resulting commit.  The
former tells "take all changes in the working tree", the latter
tells "take the version of <file> in the working tree as a whole",
to Git to create a commit out of.

"git commit" without pathspec would have made a partial commit that
records only the changes that were added with "git add -p" to the
index, though.
