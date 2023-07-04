Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B2EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGDVwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDVwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 17:52:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D944B127
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 14:52:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 730B12AF8D;
        Tue,  4 Jul 2023 17:52:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NxkVE/WuTMqo2moAWx7NTYJvk5+UVHK2iVzCkW
        D3Wec=; b=qY+l+Lita/JdpmqJjN8HDe0JN6g+x5QKqsdE6qOX0oTY6snGM25/kj
        3UskBLrCOxdQuBtN6Wfz2yvMhjJb7KJ/lPrC7GSZyTPidWgrTSZyZ+u2VtK1GZqj
        yRmRD32TxjabPKQ+T17qmQJu/9ufMWaRSKYJYsKy+9GcCwURYkVDw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69C6A2AF8C;
        Tue,  4 Jul 2023 17:52:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E61142AF8B;
        Tue,  4 Jul 2023 17:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
        <20230704194756.166111-1-alexhenrie24@gmail.com>
        <20230704194756.166111-2-alexhenrie24@gmail.com>
Date:   Tue, 04 Jul 2023 14:51:55 -0700
In-Reply-To: <20230704194756.166111-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 4 Jul 2023 13:47:46 -0600")
Message-ID: <xmqqr0pn4a6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEFE9F30-1AB4-11EE-846E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Also, don't imply that `git pull` is only for merging.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  remote.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index a81f2e2f17..009034ecde 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2323,7 +2323,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  			base, ours, theirs);
>  		if (advice_enabled(ADVICE_STATUS_HINTS))
>  			strbuf_addstr(sb,
> -				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
> +				_("  (use \"git pull\" to reconcile your local branch with the remote branch,\n"
> +				  "  or \"git push --force-with-lease\" to overwrite the remote branch with\n"
> +				  "  your local branch)\n"));
>  	}
>  	free(base);
>  	return 1;

Use of --force-with-lease without which commit you assume to be at
the tip of their branch is just as risky as blind use of --force.

As I said in a separate message, I do not think "reconcile" and
"force" cannot both be sensible choices at the same time.  If the
user wants not to lose the work by themselves and by others,
reconciling would be the only sensible choice and forcing cannot be
a sane substitute for that (if the user knows what is at the tip of
central repository is wrong and wants to get rid of it, forcing
would be a very sensible choice, but then reconciling would not be a
subsitute for that in such a case---"merge --ours" does not count as
"reconciling").

So, I'd suggest to make it a bit more clear that they are not
alternatives in the message, and discourage forcing in the first
place by using not "overwrite" but a bit stronger word, like discard
or destroy.  e.g.

    To reconcile your local changes with the work at the remote, you
    can use 'git pull' and then 'git push'.  To discard the work at
    the remote and replace it with what you did (alone), you can use
    'git push --force'.

or something, perhaps.

Thanks.
