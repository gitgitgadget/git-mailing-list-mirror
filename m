Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C28B1F4C1
	for <e@80x24.org>; Mon, 21 Oct 2019 02:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfJUCJ1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 22:09:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52695 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUCJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 22:09:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 813AA2331B;
        Sun, 20 Oct 2019 22:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xcGy6lyr79yDcT5Xzsd2QIwAgig=; b=W8mMlw
        XdnI0vaoMZ1RmJJjvHXXA5Qyd4PWrUDx7Efs0UkpxXIbYwml6gc+5HD/qrDGjHNr
        oJ1M9AgecbsHHDlonj3XSSeqCFdSqz6vI6kNkmjwEZk2MZvQN+YLddWnqsNanu5n
        O0ADPuCNpxYZC1c7wbmrcjp/dihbWudvfPJW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VjTkNKqEwyRS0VcKrbfAkWPP2NoyWqNP
        ANQkVrO3esL1AAXOua5Q0H4NPTXIqxmVbWGV8i7ijbaqG9kO0M33SfKrQ9eiF1TT
        3LMIMHQ2d6uvJpln7mLyoJBgMwldwVXZ8XdetvrQBN3xHq+cXD75zKA+eyRnVmXy
        eptn5Y/UlqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64BE32331A;
        Sun, 20 Oct 2019 22:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B272023319;
        Sun, 20 Oct 2019 22:09:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Jones <pjones@redhat.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 3/4] Make die_if_checked_out() prune missing checkouts of unlocked worktrees.
References: <20191018194317.wvqphshpkfskvkyh@redhat.com>
        <20191018194542.1316981-1-pjones@redhat.com>
        <20191018194542.1316981-3-pjones@redhat.com>
Date:   Mon, 21 Oct 2019 11:09:24 +0900
In-Reply-To: <20191018194542.1316981-3-pjones@redhat.com> (Peter Jones's
        message of "Fri, 18 Oct 2019 15:45:41 -0400")
Message-ID: <xmqqimoin92j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE48C61E-F3A7-11E9-A62F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Jones <pjones@redhat.com> writes:

[jc: won't repeat comments on the title]

> @@ -360,6 +360,12 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
>  	wt = find_shared_symref("HEAD", branch);
>  	if (!wt || (ignore_current_worktree && wt->is_current))
>  		return;

die-if-checked-out is called from callers that expect to be stopped
before they do any harm, so it feels dirty to make a side effect
like this.

If the user tries to check out a branch that used to be checked out
in an already removed worktree, doesn't that indicate that an
earlier worktree removal was done incorrectly, which is something
worth reporting to the user and give the user a chance to think and
choose what corrective action(s) need to be taken?

For that, instead of automatically losing information like this
patch does, it may make more sense to fail the checkout and stop at
giving diagnosis (e.g. "our record shows that the branch is checked
out in that worktree, but you seem to have lost it.  if you forgot
to prune it, then here is the command you can give to do so.")
without actually touching the filesystem.

Thanks.


> +
> +	if (prune_worktree_if_missing(wt) >= 0) {
> +		delete_worktrees_dir_if_empty();
> +		return;
> +	}
> +
>  	skip_prefix(branch, "refs/heads/", &branch);
>  	die(_("'%s' is already checked out at '%s'"),
>  	    branch, wt->path);
