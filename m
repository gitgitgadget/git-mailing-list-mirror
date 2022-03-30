Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD10C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351758AbiC3XHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiC3XHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 19:07:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0C2D1D8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 16:05:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B23317BC0A;
        Wed, 30 Mar 2022 19:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W8860l4kuJ3kQByUqahqy6ntojNqi9IzeRrHAW
        jfJWI=; b=fCAXZTV41VHuJivBWUDogRmD2YGTEHBROvHxvrPIwH9k8qKq5vKnQL
        jSObpJORNlvm8lrOSQ8JCnBfU5iQK1q4O6ZGPpVGQ+ESu83QTbP0hcT/9OYu057/
        zp4AcL08KNSjhU72gb0LyZQvWZ2ixc3Puj5iKgnHkRQvgpLNA4zA8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82A1817BC08;
        Wed, 30 Mar 2022 19:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1B3917BC07;
        Wed, 30 Mar 2022 19:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes
 to a ref
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-1-sandals@crustytoothpaste.net>
        <20220329214941.2018609-4-sandals@crustytoothpaste.net>
Date:   Wed, 30 Mar 2022 16:05:28 -0700
In-Reply-To: <20220329214941.2018609-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 29 Mar 2022 21:49:40 +0000")
Message-ID: <xmqqtubf59dz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4DCB080-B07D-11EC-A3CD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +static int do_export_stash(const char *ref, size_t argc, const char **argv)
> +{
> +	struct object_id base;
> +	struct object_context unused;
> +	struct commit *prev;
> +	struct object_id *items = NULL;
> +	int nitems = 0, nalloc = 0;
> +	int res = 0;
> +	struct strbuf revision;
> +	const char *author, *committer;
> +
> +	/*
> +	 * This is an arbitrary, fixed date, specifically the one used by git
> +	 * format-patch.  The goal is merely to produce reproducible output.
> +	 */
> +	prepare_fallback_ident("git stash", "git@stash");
> +	author = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT, "2001-09-17T00:00:00Z", 0);
> +	committer = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT, "2001-09-17T00:00:00Z", 0);
> +
> +	/* First, we create a single empty commit. */
> +	if (commit_tree_extended(NULL, 0, the_hash_algo->empty_tree, NULL, &base, author, committer, NULL, NULL))
> +		return error(_("unable to write base commit"));
> +
> +	prev = lookup_commit_reference(the_repository, &base);
> +
> +	if (argc) {
> +		/*
> +		 * Find each specified stash, and load data into the array.
> +		 */
> +		for (int i = 0; i < argc; i++) {
> +			ALLOC_GROW_BY(items, nitems, 1, nalloc);

Documentation/CodingGuidelines still says this

 - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
   is still not allowed in this codebase.

We have been experimenting since we merged 44ba10d6 (revision: use
C99 declaration of variable in for() loop, 2021-11-14) at 5a4069a1
(Merge branch 'jc/c99-var-decl-in-for-loop', 2021-12-21), which is
shipped as a part of v2.35.0 just a few months ago.

Let's not add more until we are sure that we do not have to revert
44ba10d6 (revision: use C99 declaration of variable in for() loop,
2021-11-14) to limit the potential damage, especially when it is so
easy to do so.

Just declare "int i" at the beginning of the funcion and keep
reusing it would be fine here.
