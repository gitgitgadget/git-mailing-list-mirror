Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D52C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 23:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B152A61350
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 23:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhJGXlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 19:41:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64158 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhJGXlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 19:41:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2C41F420B;
        Thu,  7 Oct 2021 19:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cOYApa7YZJi3A+eLapXWiwIxzO8nfQB9nXmZ6C
        3WDrA=; b=VQIXIk4vl5LS8XFZAn1MQPpG0kM8MFCMgLNpBlLnmiTN/69f7VpJYI
        2jxva06lGosCmhyEePOBEtpu1AlZEMahq7SSbkb6arESUpiAc+00aWahqhsKItVB
        JIzzfzhTGyRq88tDkVvUCUjJyOuavL8In6I/5+1CIAvQO2BsyFAL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C92A1F420A;
        Thu,  7 Oct 2021 19:39:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01E06F4209;
        Thu,  7 Oct 2021 19:39:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] remote: add remote_state to struct repository
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <5316ac086d89065cd9bda38bd475f6699adc928e.1633633635.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 16:39:21 -0700
In-Reply-To: <5316ac086d89065cd9bda38bd475f6699adc928e.1633633635.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Thu, 07 Oct 2021 19:07:15
        +0000")
Message-ID: <xmqq4k9so15i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC3ED7CC-27C7-11EC-BCF5-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static void add_pushurl_alias(struct remote *remote, const char *url)
> +static void add_pushurl_alias(struct remote_state *remote_state,
> +			      struct remote *remote, const char *url)
>  {

I am not sure if this is a good interface.  It allows a caller to
obtain "struct remote *" instance from somewhere, and feed it with
an instance of "struct remote_state *" that has nothing to do with
the "struct remote *", no?

> -static struct remote *make_remote(const char *name, int len)
> +static struct remote *make_remote(struct remote_state *remote_state,
> +				  const char *name, int len)
>  {
>  	struct remote *ret;
>  	struct remotes_hash_key lookup;
> @@ -147,7 +119,7 @@ static struct remote *make_remote(const char *name, int len)
>  	if (!len)
>  		len = strlen(name);
>  
> -	init_remotes_hash();
> +	init_remotes_hash(remote_state);
>  	lookup.str = name;
>  	lookup.len = len;
>  	hashmap_entry_init(&lookup_entry, memhash(name, len));
> @@ -173,6 +145,28 @@ static struct remote *make_remote(const char *name, int len)
>  	return ret;

Instead, shouldn't "struct remote *" _know_ which remote-state it
came from?

I didn't look, but I suspect that there may be similar problems with
other structures like "branch" in this change.

Thanks.
