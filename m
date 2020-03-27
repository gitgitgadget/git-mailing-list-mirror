Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF45C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495942071B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hzHDedll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0Wyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:54:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52935 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0Wyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 18:54:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB4D7BD87C;
        Fri, 27 Mar 2020 18:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oGHRqfOflt0HzVSnPOCXs96p+B4=; b=hzHDed
        lllhwCDKnaEYzbQP46lbmzuAHKEn9Ydt7VqWL8yayodbG+qty7RadkoZ3YxgnHB5
        8bSlkBrmCH6aT57lcaVyKRKgnynJQIOeWfXnk6YlZx27og46nFJTc+2g2W1E8xxb
        Eac4WKs9sl06SjVxO5SWbWEMJHPgJ9a3F03fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ldrpc9VeqH5gI7ghHaT5+l83oh/1OpT/
        PBEcNTdeeIyqt6hstb+PGgtopTOi6aBApZ0MlaZ9oURCDlYBc9wr/s6VEJ1/8m/G
        +LSn8wYACb3qWSpHQ0JadwOS5ZY2GuB1LCmMEL6pdvLQ4fMk48vvuG+XjMGbOT9/
        QMDg62svhEQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B428DBD87B;
        Fri, 27 Mar 2020 18:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B2E2BD87A;
        Fri, 27 Mar 2020 18:54:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] pull: avoid running both merge and rebase
References: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 15:54:48 -0700
In-Reply-To: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 27 Mar 2020 21:51:40
        +0000")
Message-ID: <xmqqy2rlcssn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6B721E2-707D-11EA-9F28-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> When opt_rebase is true, we still first check if we can fast-forward.
> If the branch is fast-forwardable, then we can avoid the rebase and just
> use merge to do the fast-forward logic.  However, when commit a6d7eb2c7a
> ("pull: optionally rebase submodules (remote submodule changes only)",
> 2017-06-23) added the ability to rebase submodules it accidentally
> caused us to run BOTH a merge and a rebase.  Add a flag to avoid doing
> both.

This is a fun one.  Thanks for digging to the bottom of the issue.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e624d1e008..19899b45c1d 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -976,6 +976,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	if (opt_rebase) {
>  		int ret = 0;
> +		int ran_ff = 0;
>  		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
>  		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
>  		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
> @@ -992,10 +993,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  			if (is_descendant_of(merge_head, list)) {
>  				/* we can fast-forward this without invoking rebase */
>  				opt_ff = "--ff-only";
> +				ran_ff = 1;
>  				ret = run_merge();
>  			}
>  		}
> -		ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> +		if (!ran_ff)
> +			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
>  
>  		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
>  			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
>
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
