Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4F9C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045A721775
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gn2Aolnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgEASj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 14:39:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53590 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgEASj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 14:39:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFAEE67FE6;
        Fri,  1 May 2020 14:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9pZzoBAk8z9pIwejx4U0E5Vn4c=; b=Gn2Aol
        nl1T+buHawm/FcIfDLhNDmK09TO42Qdu/zdKqKS0tWjHAp1Sccp3L1Hagef/fubN
        IzK++dEdmnuu0pxMF+vtY3xrUeQ0vD8snBsxEReV44/u5gF+cW1jT9RB3gVuuYdU
        OwSPJs+t9twOd8SabKInwM0Bi0bnftaobzYUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TV+5WMn5atzMZsIXNkyWs8kBaXPxzHnl
        KxEp8biFn3MxWscr8ecTLUfd+DSMtZaVTc2UV8Ac2Xo9p2gvO03fb0/7oCXys/Fs
        zs4gROzS412MePv4YAbop7shslA9hotrGoOcRfraJ5Ur7roxVPLtPb3l0hJA9MkQ
        LCV7wCLd+ug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6ED667FE5;
        Fri,  1 May 2020 14:39:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30D7267FE4;
        Fri,  1 May 2020 14:39:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Andrey Mazo <ahippo@yandex.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-p4.py: fix --prepare-p4-only error with multiple commits
References: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 11:39:50 -0700
In-Reply-To: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com> (Ben
        Keene via GitGitGadget's message of "Fri, 01 May 2020 17:09:12 +0000")
Message-ID: <xmqq1ro3mrd5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 245A3C60-8BDB-11EA-8A86-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> When using git p4 submit with the --prepare-p4-only option, the program
> should prepare a single p4 changelist and notify the user that more
> commits are pending and then stop processing.
>
> A bug has been introduced by the p4-changelist hook feature that
> causes the program to continue to try and process all pending
> changelists at the same time.
>
> The function applyCommit should return True when applying the commit
> was successful and the program should continue. In the case of the
> --prepare-p4-only flag, the function should return False, alerting the
> caller that the program should not proceed with additional commits.
>
> Change the return value from True to False in the applyCommit function
> when git-p4 is executed with --prepare-p4-only flag.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---

I do not do P4, so asking those who touched the program in the past
year and half for opinions.

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-775%2Fseraphire%2Fseraphire%2Fp4-hook-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-775/seraphire/seraphire/p4-hook-v1
> Pull-Request: https://github.com/git/git/pull/775
>
>  git-p4.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index b8b2a1679e7..d9ced1bf552 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1984,7 +1984,7 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
>          return (diff + newdiff).replace('\r\n', '\n')
>  
>      def applyCommit(self, id):
> -        """Apply one commit, return True if it succeeded."""
> +        """Apply one commit, return True if it should continue processing."""
>  
>          print("Applying", read_pipe(["git", "show", "-s",
>                                       "--format=format:%h %s", id]))
> @@ -2222,7 +2222,7 @@ def applyCommit(self, id):
>                          print("  " + f)
>                  print("")
>                  sys.stdout.flush()
> -                return True
> +                return False
>  
>              if self.edit_template(fileName):
>                  if not self.no_verify:
>
> base-commit: d61d20c9b413225793f8a0b491bbbec61c184e26
