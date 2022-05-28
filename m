Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8529EC433EF
	for <git@archiver.kernel.org>; Sat, 28 May 2022 00:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355321AbiE1A7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 20:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbiE1A7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 20:59:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49546542D
        for <git@vger.kernel.org>; Fri, 27 May 2022 17:59:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EAF013104C;
        Fri, 27 May 2022 20:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuosH1/bv0+h1lM81szOWVPIsFkU9wx3T4Zx4z
        ichVY=; b=ST+YiAq+q+/e6XWVaKpinL8MXuKUQBkEBWDyaqFZo0h04HTg0agyG8
        Ut/WgjDTPJKkdI+t8gCA7w4zS14gGQxgIgTx9KDumWVPuENk3bD9ZZgYOHQzxT6U
        KvZsqU9JOcvR+NcKALJU8NfcM9IY4gDzdG1qyoUZKS1czZR+yh0tI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9490313104B;
        Fri, 27 May 2022 20:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D2FC13104A;
        Fri, 27 May 2022 20:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 3/5] setup.c: create `discovery.bare`
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <d5a3e9f98450a0d602cf21790b988c1259a3466d.1653685761.git.gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 17:59:10 -0700
In-Reply-To: <d5a3e9f98450a0d602cf21790b988c1259a3466d.1653685761.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Fri, 27 May 2022 21:09:19
        +0000")
Message-ID: <xmqqy1ymzd41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6292A68A-DE21-11EC-B42D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +enum discovery_bare_config {
> +	DISCOVERY_BARE_UNKNOWN = -1,
> +	DISCOVERY_BARE_NEVER = 0,
> +	DISCOVERY_BARE_ALWAYS,
> +};
> +static enum discovery_bare_config discovery_bare_config =
> +	DISCOVERY_BARE_UNKNOWN;

Can discovery_bare come from anywhere other than config?

I am wondering if both the variable and the type should be called
"discovery_bare_allowed" instead.  That it comes from the config is
not the more important part.  That it determines if it is allowed
is.

> +static int check_bare_repo_allowed(void)
> +{
> +	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
> +		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
> +		git_protected_config(discovery_bare_cb, NULL);
> +	}

OK, so the thing is initialized to "unknown", and the first time we
want to use the value of it, we read from the file (or default to
"always").  Makes sense.

And then ...

> +	switch (discovery_bare_config) {
> +	case DISCOVERY_BARE_NEVER:
> +		return 0;
> +	case DISCOVERY_BARE_ALWAYS:
> +		return 1;
> +	case DISCOVERY_BARE_UNKNOWN:
> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);

... this is being defensive; we know discovery_bare_cb() won't give
UNKNOWN, but we want to make sure.

> +	}
> +	return 0;
> +}
> +
> +static const char *discovery_bare_config_to_string(void)
> +{

But this one feels strangely asymmetrical, as there is no inherent
reason why one must be called before the other.  I would expect it
to either

 * take a parameter of type "enum discovery_bare" and return
   "never", "always", or "unset", without calling any BUG().

or

 * have the same "we lazily figure out the discovery_bare_config
   variable on demand" logic.

As both of these functions are file-scope static, we can live with
it, though.

> +	switch (discovery_bare_config) {
> +	case DISCOVERY_BARE_NEVER:
> +		return "never";
> +	case DISCOVERY_BARE_ALWAYS:
> +		return "always";
> +	case DISCOVERY_BARE_UNKNOWN:
> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);
> +	}
> +	return NULL;
> +}

