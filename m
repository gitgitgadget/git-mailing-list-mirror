Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00013C43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C954C61264
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhEKNiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:38:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52875 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhEKNiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:38:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 923DA13A354;
        Tue, 11 May 2021 09:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zot5wVgxp8MJA3a5C0fBpB/Jy6NVi1SVSnQKow
        76RT8=; b=jZ5Y1/6lypS/n9086FpiOQIUE32ulHeKRXphIDdevDTm+R1w6Q+98n
        fTAfjUq9u4rFw+JSOYLwhamFSLIv6LXTPo8UDZsTycr7nIHA1wMfsswFPJrI/zL0
        LNq9NLPs4YVsmFr15DJRR2Tdg41riOzYpTOrcIG3O2dghCIFsTeD8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A24F13A353;
        Tue, 11 May 2021 09:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C033113A352;
        Tue, 11 May 2021 09:36:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
References: <20210511103730.GA15003@dcvr>
Date:   Tue, 11 May 2021 22:36:51 +0900
In-Reply-To: <20210511103730.GA15003@dcvr> (Eric Wong's message of "Tue, 11
        May 2021 10:37:30 +0000")
Message-ID: <xmqqy2cll7d8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F213EAF8-B25D-11EB-B0A7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> The remote-https process needs to update it's own instance of
> `the_repository' when it sees an HTTP(S) remote is using sha256.
> Without this, parse_oid_hex() fails to handle sha256 OIDs when
> it's eventually called by parse_fetch().
>
> Tested with:
>
> 	git clone https://yhbt.net/sha256test.git
> 	GIT_SMART_HTTP=0 git clone https://yhbt.net/sha256test.git
> 	(plain http:// also works)
>
> Cloning the URL via git:// required no changes

OK, so smart-http is disabled because it is just a slight variation
of the native Git protocol in disguise running over the http
transport, while the non-smart-http uses totally different codepath
to initialize the repository, and this bug does not appear when the
native Git protocol is in use?

I guess we use "git clone" over HTTP in many place in our tests, so
there is no need to add a new one to safeguard this fix from future
breakage (instead we can just run the whole test suite with SHA256)?

Will wait for brian to comment.

Thanks.

> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  remote-curl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 0290b04891..9d432c299a 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -555,6 +555,8 @@ static void output_refs(struct ref *refs)
>  	struct ref *posn;
>  	if (options.object_format && options.hash_algo) {
>  		printf(":object-format %s\n", options.hash_algo->name);
> +		repo_set_hash_algo(the_repository,
> +				hash_algo_by_ptr(options.hash_algo));
>  	}
>  	for (posn = refs; posn; posn = posn->next) {
>  		if (posn->symref)
