Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D7C1FADF
	for <e@80x24.org>; Tue, 23 Jan 2018 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeAWSvo (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:51:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60624 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752516AbeAWSvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:51:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79F05B7C16;
        Tue, 23 Jan 2018 13:51:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KjqX19ahEwR24W9J6z1MheJHVuA=; b=Gbz7sy
        yJGEASX6OnRQBedQ0z6eVqy+8vvREc4IgsQzXyxuGcpzPfZQFq+rgBHX7UoFJVYu
        /j0FF5wRsUgZ3HZ0+dFaw0zu8xTkb8Vl2C8bsCnoWUMes5R1eICbVNUubQfp54Sf
        yCrbr7WdeTV1g+w1bZ5oDY+Jk3Ps07yi1mG6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s2gK4dgFajxsK85AASBYs2QuF/CjpYc3
        bcH57HwP7Cqq19J3NUWst0qDTirnd2/EJKoSs0wOUuJGQX5RvubDOhBkuguIQdbS
        K/oL7lVKD8IlNg3oQHxLz4DNmXelK9+D4DOUsflXqd6cQgrf+J6nh6ImyOho5Nmn
        XY7UhseZVI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71ECCB7C15;
        Tue, 23 Jan 2018 13:51:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6A8DB7C12;
        Tue, 23 Jan 2018 13:51:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
Date:   Tue, 23 Jan 2018 10:51:41 -0800
In-Reply-To: <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 16:35:34 +0100
        (STD)")
Message-ID: <xmqqvafsh0hu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74224DE6-006E-11E8-ABA4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	/*
> +	 * If HEAD is not identical to the parent of the original merge commit,
> +	 * we cannot fast-forward.
> +	 */
> +	can_fast_forward = commit && commit->parents &&
> +		!oidcmp(&commit->parents->item->object.oid,
> +			&head_commit->object.oid);
> +

I think this expression and assignment should better be done much
later.  Are you going to update commit, commit->parents, etc. that
are involved in the computation in the meantime???

>  	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
>  	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
>  	if (!merge_commit) {
> @@ -2164,6 +2172,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
>  		rollback_lock_file(&lock);
>  		return -1;
>  	}
> +
> +	if (can_fast_forward && commit->parents->next &&
> +	    !commit->parents->next->next &&
> +	    !oidcmp(&commit->parents->next->item->object.oid,
> +		    &merge_commit->object.oid)) {

... Namely, here.  Because the earlier one is computing "are we
replaying exactly the same commit on top of exactly the same
state?", which is merely one half of "can we fast-forward", and
storing it in a variable whose name is over-promising way before it
becomes necessary.  The other half of "can we fast-forward?" logic
is the remainder of the if() condition we see above.  IOW, when
fully spelled, this code can fast-forward when we are replaying a
commit on top of exactly the same first-parent and the commit being
replayed is a single parent merge.

We may even want to get rid of can_fast_forward variable.

> +		strbuf_release(&ref_name);
> +		rollback_lock_file(&lock);
> +		return fast_forward_to(&commit->object.oid,
> +				       &head_commit->object.oid, 0, opts);
> +	}
> +
>  	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
>  		      git_path_merge_head(), 0);
>  	write_message("no-ff", 5, git_path_merge_mode(), 0);
