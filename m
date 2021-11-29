Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42154C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhK2XSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:18:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51352 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhK2XSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:18:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97ADF16F271;
        Mon, 29 Nov 2021 18:15:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TGCEWIcd6qJakK3IV+TfDA6qfx4KJc0qtn/02l
        r5fF8=; b=heDOtqye+9E5kmz33ZuLSQZDOVn83Dff9qHXfMyjCgKyw38JAZJ6W/
        rYtRe1rYtDgi/VsRDgiUetvrIzWNoq8UzXWBOfVAsy1qdM90OnRCyjO2te8DkuNj
        CVXC1OgXigbGBtZ2co7B3Ea50z1wszG6xihDR1ZimY7UlHFIe6r2o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 910E616F270;
        Mon, 29 Nov 2021 18:15:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6688416F26F;
        Mon, 29 Nov 2021 18:15:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 1/6] test-ref-store: plug memory leak in cmd_delete_refs
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <7fa5c247c8b1cdeb4fcd166cfb6e98425d21e5ae.1638211786.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:15:16 -0800
In-Reply-To: <7fa5c247c8b1cdeb4fcd166cfb6e98425d21e5ae.1638211786.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 29 Nov 2021
        18:49:41 +0000")
Message-ID: <xmqqsfve4kqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3718401C-516A-11EC-B308-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/helper/test-ref-store.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index b314b81a45b..ccc2bb01bf3 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -86,11 +86,13 @@ static int cmd_delete_refs(struct ref_store *refs, const char **argv)
>  	unsigned int flags = arg_flags(*argv++, "flags");
>  	const char *msg = *argv++;
>  	struct string_list refnames = STRING_LIST_INIT_NODUP;
> -
> +	int result;

Thanks, but let's not lose the blank line between the declarations
and the first statement, which serves for readability.

>  	while (*argv)
>  		string_list_append(&refnames, *argv++);
>  
> -	return refs_delete_refs(refs, msg, &refnames, flags);
> +	result = refs_delete_refs(refs, msg, &refnames, flags);
> +	string_list_clear(&refnames, 0);
> +	return result;
>  }
>  
>  static int cmd_rename_ref(struct ref_store *refs, const char **argv)
