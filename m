Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48799207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933921AbcJLShS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 14:37:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755886AbcJLShQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 14:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A03449DA;
        Wed, 12 Oct 2016 14:37:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TdGo9kXb6AoFbanUdJveNSapf2w=; b=iwQCUz
        SuOWQBQo7VqRW5nEvUwTfU812RQFZaV2jK8oA5q88LF0OA7W5NF9c3htV6VZzcEk
        Ns/3MHAmgNbSWDy1SS/AA4mWHzhqJEcn/U/KqC7PI8YRDTIE1gkQ8D3itK+yEGiO
        +hlvff2xzEnr82V1+vYlOj2U87gqwRlLBPwvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PrjGXxVDKH32IrAQHCZsxQK5Jh+1yCnK
        URF+453g2qhcYHBB2/arv7voBbN9FfxMWauAdLMgDSwb6tXJNEnvEd+1pkziA/5g
        Cd0D9ms4d2q0JVnsmbkkip86w8aMxYmB2DIuLblDkfQo5UGdmYYpJIipa7sjrj9H
        XrVs6teadbk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB252449D9;
        Wed, 12 Oct 2016 14:37:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DB5A449D8;
        Wed, 12 Oct 2016 14:37:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com, mtutty@gforgegroup.com,
        rappazzo@gmail.com
Subject: Re: [PATCH] worktree: allow the main brach of a bare repository to be checked out
References: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
        <20161012164104.zcxpcwqrp5h65qmc@hurricane>
Date:   Wed, 12 Oct 2016 11:37:12 -0700
In-Reply-To: <20161012164104.zcxpcwqrp5h65qmc@hurricane> (Dennis Kaarsemaker's
        message of "Wed, 12 Oct 2016 18:41:07 +0200")
Message-ID: <xmqqfuo14dnr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5070E28-90AA-11E6-A6B6-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> OK, so here it is as a proper patch.
>
> D.
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 4bcc335..2996c38 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
>  	)
>  '
>  
> ++test_expect_success '"add" default branch of a bare repo' '

Huh?

> +	(
> +		git clone --bare . bare2 &&
> +		cd bare2 &&
> +		git worktree add ../there3 master
> +	)
> +'
> +
>  test_expect_success 'checkout with grafts' '
>  	test_when_finished rm .git/info/grafts &&
>  	test_commit abc &&
> diff --git a/worktree.c b/worktree.c
> index 5acfe4c..35e95b7 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
>  
>  	for (i = 0; worktrees[i]; i++) {
>  		struct worktree *wt = worktrees[i];
> +		if(wt->is_bare)
> +			continue;
>  
>  		if (wt->is_detached && !strcmp(symref, "HEAD")) {
>  			if (is_worktree_being_rebased(wt, target)) {
> -- 
> 2.10.1-356-g947a599
