Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505AEC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 17:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiHVR5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiHVR5w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 13:57:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF64331E
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:57:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA3F2133B2A;
        Mon, 22 Aug 2022 13:57:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B82hAIrw5tzq9Z5x8+SLSdW1F1moaY9x1ehst5
        s7BdM=; b=f3hWs9FEw92upEcZfgbDYhKZE2N7W8GsRAon6ZyKB+Tan3LgYGxpmW
        KkRJIUhcwgBxohDfGac1ePMj0r/T6qNmiYpJFdFrK6i6tI6lbzOth9tDvcGm/aEa
        8NQHGJT6wMBZvaDL03jzuQ5peWgNjKvlcT9wchRInk0pxlpIv7ucY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1034133B29;
        Mon, 22 Aug 2022 13:57:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E452133B28;
        Mon, 22 Aug 2022 13:57:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/7] bundle-uri: create bundle_list struct and helpers
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <c39438886586f30b020e8ac473c7facaa757f822.1661181174.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 10:57:48 -0700
In-Reply-To: <c39438886586f30b020e8ac473c7facaa757f822.1661181174.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 22 Aug 2022
        15:12:48 +0000")
Message-ID: <xmqqfshoduub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF76E2EE-2243-11ED-B5A3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/**
> + * The remote_bundle_info struct contains information for a single bundle
> + * URI. This may be initialized simply by a given URI or might have
> + * additional metadata associated with it if the bundle was advertised by
> + * a bundle list.
> + */
> +struct remote_bundle_info {
> +	struct hashmap_entry ent;
> +
> +	/**
> +	 * The 'id' is a name given to the bundle for reference
> +	 * by other bundle infos.
> +	 */
> +	char *id;
> +
> +	/**
> +	 * The 'uri' is the location of the remote bundle so
> +	 * it can be downloaded on-demand. This will be NULL
> +	 * if there was no table of contents.
> +	 */
> +	char *uri;
> +
> +	/**
> +	 * If the bundle has been downloaded, then 'file' is a
> +	 * filename storing its contents. Otherwise, 'file' is
> +	 * an empty string.
> +	 */
> +	struct strbuf file;
> +};

Presumably the sequence of events are that first a bundle list is
obtained, with their .file member set to empty, then http worker(s)
download and deposit the contents to files at which time the .file
member is set to the resulting file.  The file downloader presumably
uses the usual "create a temporary file, download to it, and then
commit it by closing and then renaming" dance, and the downloading
http worker may want to have two strbufs somewhere it can access to
come up with the name of the temporary and the name of the final
file.  But once the result becomes a committed file, its name will
not change, or will it?

At this step without the code that actually uses the data, use of
strbuf, instead of "char *" like id and uri members do, smells like
a premature optimization, and it is unclear if the optimization is
even effective.

Other than that, looks good to me.
