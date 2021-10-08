Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0F360F6B
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhJHRVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:21:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51946 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHRV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:21:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F465142F73;
        Fri,  8 Oct 2021 13:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YplN32W+HL+Pj2v7zP4npkrahqkVYIWg0jslHe
        ybmH4=; b=Nb2C4Ux/AnmuNxorXvDqkHrVO0oBeNzOIry8iYI85Gcz9xyNdn0nof
        p4sst1aYTapuVFKcDSrT9u1QhlVDxV1wUDIgnbCVIMadVaVTGKqqDkR/1HxQ15pG
        iPKXpcyGHiGO7FjOjoWhdkkknEdlvxBKRoKX3jPklTt8+KmTgrF7s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0375A142F72;
        Fri,  8 Oct 2021 13:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50B2A142F71;
        Fri,  8 Oct 2021 13:19:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
        <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
        <xmqq35pcm6m9.fsf@gitster.g>
        <72f4df1e-54ef-6bdb-ef71-1f115e92c9a5@github.com>
Date:   Fri, 08 Oct 2021 10:19:30 -0700
In-Reply-To: <72f4df1e-54ef-6bdb-ef71-1f115e92c9a5@github.com> (Victoria Dye's
        message of "Fri, 8 Oct 2021 11:47:45 -0400")
Message-ID: <xmqqily7l9i5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E65A7B22-285B-11EC-8345-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I tried coming up with a user-facing name that wasn't too focused on the
> internal implementation, but it ends up being misleading. The intention was
> to have this be a variation of `git update-index` that uses the default
> setting for `command_requires_full_index` but then proceeds to read and
> write the index as `update-index` normally would. Something like
> `--use-default-index-sparsity` might have been more accurate?

The option name in the reviewed patch does imply "we force expanding
to full" and not "use the default", so it probably needs renaming,
if we want the "use the default" semantics.  But is that useful in
the context of the test you are using it in place of "reset" or "mv"?
Even if the default is somehow flipped to use sparse always, wouldn't
the particular test want the index expanded?  I dunno.

> In the test's use-case, `active_cache_changed` ends up set to
> `CACHE_TREE_CHANGED`, which forces writing the index. It is still
> effectively a no-op, but it serves the needs of the test.

Ah, cache-tree is updated, then it's OK.

As to test-tool vs end-user-accessible-command, I do not have a
strong opinion, but use your imagination and ask Derrick or somebody
else for their imagination to see if such a "force expand" feature
may be something the end-users might need an access to in order to
dig themselves out of a hole (in which case, it may be better to
make it end-user-accessible) or not (in which case, test-tool is
more appropriate).

Thanks.


