Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3DBC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbiGTQSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiGTQSI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:18:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F252FDC
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:18:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81BFF12EACB;
        Wed, 20 Jul 2022 12:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nqDJHjfzKwWUOh8kz+2Ya8q5M5C0baPtwIAlbE
        oiOEI=; b=w8R5XocIKRU9rB84qSKsIcJoWHohOstMZZqRYjlnQbrOq0oieN3cb+
        W0zeuovmtvnkGbwCKZyCoJjRFyEq28pscRX/LhTmxukcX+FGUgQGG5mGncRySEWD
        YcNu6z7iBnj9HRm7QycGBhJsZKeg+LSClRFzQKszKxOTMvRrZtjnA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5301812EACA;
        Wed, 20 Jul 2022 12:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7777612EAC6;
        Wed, 20 Jul 2022 12:18:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>
Subject: Re: [PATCH 2/2] git-p4: fix error handling in
 P4Unshelve.renameBranch()
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <69c9fd5fbec859c2cced95930ac4d427a09aee90.1658298900.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 09:18:03 -0700
In-Reply-To: <69c9fd5fbec859c2cced95930ac4d427a09aee90.1658298900.git.gitgitgadget@gmail.com>
        (Moritz Baumann via GitGitGadget's message of "Wed, 20 Jul 2022
        06:34:59 +0000")
Message-ID: <xmqqa6934v2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 888E50C8-0847-11ED-9FF5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Moritz Baumann <moritz.baumann@sap.com>
>
> The error handling code referenced a variable that does not exist.
> Also, the condition could never evaluate to True.



>
> Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
> ---
>  git-p4.py | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 1de3d6f1cd4..8f20d15f272 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -4369,19 +4369,16 @@ class P4Unshelve(Command):
>      def renameBranch(self, branch_name):
>          """Rename the existing branch to branch_name.N ."""
>  
> -        found = True

This has to be initialized to False, because ...

>          for i in range(0, 1000):
>              backup_branch_name = "{0}.{1}".format(branch_name, i)
>              if not gitBranchExists(backup_branch_name):
>                  # Copy ref to backup
>                  gitUpdateRef(backup_branch_name, branch_name)
>                  gitDeleteRef(branch_name)
> -                found = True
>                  print("renamed old unshelve branch to {0}".format(backup_branch_name))

... we flip it to True when we find an available unused name and
break out ...

>                  break
> -
> -        if not found:
> -            sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))

... so that we can complain when we didn't find anything usable.

So a minimum fix would be to initialize found correctly, and
rewriting the logic to use "for ... else" is an unrelated style
change.  The version using "for ... else" may be more idiomatic
Python, and I do not think people would mind it, but it should
be mentioned in the proposed log mesage, perhaps like:

    The code tries to see if there is an available name by setting
    the variable 'found' to true when it finds one and breaks out of
    the loop, but because the variable is incorrectly initialized to
    true (it should be initialized to false), the code after the
    loop cannot tell if it found an available name or not.

    It would be the minimal fix to initialize the variable to false,
    but in modern Python it is more idiomatic to add else: clause
    after a loop to write what happens when the loop did not break
    out, so let's do that instead.

    Also, fix the error message that refers to a wrong variable
    name.

or something.

Thanks.  Will queue.

> +        else:
> +            sys.exit("gave up trying to rename existing branch {0}".format(branch_name))
>  
>      def findLastP4Revision(self, starting_point):
>          """Look back from starting_point for the first commit created by git-p4
