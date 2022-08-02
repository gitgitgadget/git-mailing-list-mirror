Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B41C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiHBVca (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiHBVc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:32:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C45B55
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:32:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 968CB12E1D3;
        Tue,  2 Aug 2022 17:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EMnaE4SuyAG8XyLkIZj7hR1iUFjrZFV2kqjaZf
        +61fE=; b=A1FZmJC36D370yNn3UG6fuY+A8oFd2sNvZPlAGWMOCG2hnOHH/N8DI
        /MpjOdB8Dvi5J7U1PLozVrUovathg1loLOIuKiIMf9S5wlKiJe0Ja1t0t4+mGs1L
        I7wgxbjdp5FzpK6dAdY3HuZvcKAUKwzUo/t8oHOBzVVDNCgMAeW8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AC1D12E1D2;
        Tue,  2 Aug 2022 17:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECA5D12E1D0;
        Tue,  2 Aug 2022 17:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/5] bundle-uri: add support for http(s):// and file://
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <e4f2dcc7a45388663aeac786e5abdcf2164cfe62.1659443384.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 14:32:24 -0700
In-Reply-To: <e4f2dcc7a45388663aeac786e5abdcf2164cfe62.1659443384.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 02 Aug 2022
        12:29:43 +0000")
Message-ID: <xmqq8ro6fi1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A3EF530-12AA-11ED-B950-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int copy_uri_to_file(const char *filename, const char *uri)
> +{
> +	const char *out;
> +
> +	if (istarts_with(uri, "https:") ||
> +	    istarts_with(uri, "http:"))

Let's be a bit more strict to avoid mistakes and make the code
immediately obvious, e.g.

	if (istarts_with(uri, "https://") ||
	    istarts_with(uri, "http://"))

> +		return download_https_uri_to_file(filename, uri);
> +
> +	if (!skip_prefix(uri, "file://", &out))
> +		out = uri;

If we are using istarts_with because URI scheme name is case
insensitive, shouldn't we do the same for "file://" URL, not
just for "http(s)://" URL?  IOW

	if (!skip_iprefix(uri, "file://", &out))

> +static int download_https_uri_to_file(const char *file, const char *uri)
>  {
> +	int result = 0;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	FILE *child_in = NULL, *child_out = NULL;
> +	struct strbuf line = STRBUF_INIT;
> +	int found_get = 0;
> +
> +	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);

Does "git-remote-https" talk to a "http://" URL just fine when uri
parameter starts with "http://"?  Would it be the same if the uri
parameter begins with say "Http://"?

Other than that, looks sensible.

