Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C40C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiDFRex (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiDFRen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:34:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334101C2A16
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:41:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91EF712B542;
        Wed,  6 Apr 2022 11:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQ/8plFEV6L1JSj2S+Dc4MysiidqyCkvpbcKQK
        edKi8=; b=X0/FE38nWvGY6Vzb2MtRowulrYbEtxiZ3cK5gOOxFJyjo5Kg28uN/u
        z4zo9Bq6NcLRJpZWE0A1KK0nPERZ+jM1pJ5kPYczEGn9BUYXBuXmcl/LKKUijtQ1
        T+0ihoZ/TOtBpD62yCMR03ftZNEhOF8N1e0Nl/pukT9Ghbu7Vcgss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8952812B541;
        Wed,  6 Apr 2022 11:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E80AA12B540;
        Wed,  6 Apr 2022 11:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        congdanhqx@gmail.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH] ls-tree: `-l` should not imply recursive listing
References: <YktP0LltNKq7JZZs@google.com>
        <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
Date:   Wed, 06 Apr 2022 08:41:11 -0700
In-Reply-To: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 4 Apr 2022 15:42:24 -0700")
Message-ID: <xmqq8rsi1ap4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD00A7C4-B5BF-11EC-A212-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In 9c4d58ff2c (ls-tree: split up "fast path" callbacks, 2022-03-23), a
> refactoring of the various read_tree_at() callbacks caused us to
> unconditionally recurse into directories if `-l` (long format) was
> passed on the command line, regardless of whether or not we also pass
> the `-r` (recursive) flag.
>
> Fix this by making show_tree_long() return the value of `recurse`,
> rather than always returning 1. This value is interpreted by
> read_tree_at() to be a signal on whether or not to recurse.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> I believe this is the correct fix for the change in `git ls-tree -l`
> output. I would also like to add tests in a future fix, but I do not
> have time to add them today.

It's rather an obvious bug and it is sad that existing tests did not
find (and no, I do not think lower-level unit testing would have
helped us in any way, either).

Will queue.

Thanks for a quick fix.


>  builtin/ls-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 5dac9ee5b9..e279be8bb6 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -255,7 +255,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
>  	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
>  	       find_unique_abbrev(data.oid, abbrev), size_text);
>  	show_tree_common_default_long(base, pathname, data.base->len);
> -	return 1;
> +	return recurse;
>  }
>  
>  static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
>
> base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
