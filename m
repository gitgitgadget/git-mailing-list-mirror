Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D96C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGASgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiGASgE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:36:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7233EB3
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:36:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2752D1AFB6D;
        Fri,  1 Jul 2022 14:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pTR6vwqKtRj4yh6hBvSaXbyVwVcjMdXIG2dLD6
        b3I5Y=; b=tFtTfdaRLiJF+ekuTc1OOxubYygjsRYRR87kjDFhSsJT3eBTrO73Bn
        5KdBhqXpZu/ht+8xH2wISfI2UDyXAXjT16r7ZbgiLsDW21d3xUZfpUE6MM2C1MRi
        5Sqmyc9h6H5KIE1J+qKa5NslML/CiP8jlItphgtMQioQmYLfop1F0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FACC1AFB6C;
        Fri,  1 Jul 2022 14:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD6061AFB6B;
        Fri,  1 Jul 2022 14:35:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
        <bee9eb82-6c6a-6467-37d1-d3797c583929@gmail.com>
Date:   Fri, 01 Jul 2022 11:35:56 -0700
In-Reply-To: <bee9eb82-6c6a-6467-37d1-d3797c583929@gmail.com> (Phillip Wood's
        message of "Fri, 1 Jul 2022 10:31:05 +0100")
Message-ID: <xmqqr1348yur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5EE157A-F96C-11EC-9A50-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +static int write_update_refs_state(struct string_list *refs_to_oids)
>> +{
>> +	int result = 0;
>> +	FILE *fp = NULL;
>> +	struct string_list_item *item;
>> +	char *path = xstrdup(rebase_path_update_refs());
>
> This is leaked

Good eyes.

>> +	if (safe_create_leading_directories(path)) {
>> +		result = error(_("unable to create leading directories of %s"),
>> +			       path);
>> +		goto cleanup;
>> +	}
>> +
>> +	fp = fopen(path, "w");
>> +	if (!fp) {
>> +		result = error_errno(_("could not open '%s' for writing"), path);
>> +		goto cleanup;
>> +	}
>
> Can we use fopen_or_warn() here? It ignores ENOENT and ENOTDIR but I
> don't think that should matter here.

fopen("no-such-directory/file", "w") would fail with ENOENT, and
fopen("README.md/file", "w") would fail with ENOTDIR, I would think,
so "should not matter because we are writing" is not the reason, but
because we know the path is in a subdirectory of ".git/" that we
know should exist, the most likely reason for the fopen to fail is
because (1) the repository is broken (we will get ENOENT, ENOTDIR,
which we want to warn about but fopen_or_warn() ignores, as well as
other errors such as EISDIR), (2) the repository is unwritable (we
will get EACCES), or (3) we are running low on diskspace (ENOSPC).

I think that the fopen_or_warn() helper was primarily invented to
read an optional file (so we deliberately ignore a failure to open
one due to ENOENT and ENOTDIR), and we should be careful of its use
for any other purpose, i.e. write access for any purpose and read
access for files that we know we should be able to.

>> +compare_two_refs () {
>> +	git rev-parse $1 >expect &&
>> +	git rev-parse $2 >actual &&
>> +	test_cmp expect actual
>> +}
>
> This is just test_cmp_rev

I love to see reviewers who know the existing API and helpers very
well (including the fopen-or-warn above).

Very much appreciated.

> Thanks for working on this, it will be a really useful addition to rebase.

Ditto.

Thanks.
