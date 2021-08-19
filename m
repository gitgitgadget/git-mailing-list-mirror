Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5269C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9651610A6
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 16:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhHSQ42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:56:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhHSQ42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 12:56:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73DE0DEA62;
        Thu, 19 Aug 2021 12:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=twPREencjLmz
        JVgCaxYxXqNYKqnSAaDNsm2XikMRp98=; b=NuVqT2EwvdJ1zDx+jThxvpaEcs7P
        UW8v4gqGhVAV1L5YlHcU8KJp5QXEtmczpDzDG44Q6Y5vncwv7bq1mFeZoUHwdt+W
        TzPWnTyy8DS7PtIY4qeITXXH5IajJPMAi6vemKwh2UJUY4Nk+nGoIZySYVBLuY1x
        wlDgbN/FBmbofno=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B27ADEA61;
        Thu, 19 Aug 2021 12:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0A54DEA60;
        Thu, 19 Aug 2021 12:55:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Thomas De Zeeuw <thomas@slight.dev>
Subject: Re: [PATCH] diff-lib: ignore all outsider if --relative asked
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
        <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
Date:   Thu, 19 Aug 2021 09:55:49 -0700
In-Reply-To: <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 19 Aug
 2021 15:29:09 +0700")
Message-ID: <xmqqwnoh2x2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E79138C-010E-11EC-AC6B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> For diff family commands, we can tell them to exclude changes outside
> of some directories if --relative is requested.
>
> In diff_unmerge(), NULL will be returned if the requested path is
> outside of the interesting directories, thus we'll run into NULL
> pointer dereference in run_diff_files when trying to dereference
> its return value.
>
> We can simply check for NULL there before dereferencing said
> return value.  However, we can do better by not running diff
> on those unintesting entries.  Let's do that instead.
>
> Reported-by: Thomas De Zeeuw <thomas@slight.dev>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---

Nicely done.

If we look at cd676a51 (diff --relative: output paths as relative to
the current subdirectory, 2008-02-12) where the "--relative" feature
was introduced a bit more carefully, we notice that it wanted to
implement "anything outside the .prefix gets discarded" at
diff_addremove(), diff_change(), and diff_unmerge() level, instead
of the side that enumerates the paths and calls these helpers, and
that way, the "--relative" feature would consistently work across
diff-files, diff-tree, and diff-index, as they all share these three
helpers.

But filtering upfront before the codepath even has to decide if it
needs to call diff_addremove() or diff_change(), like this patch
does, makes sense, especially in the context of diff-files where the
enumeration of paths is just to walk a single flat array that is the
in-core index.

The proposed log message needs a bit more work, though.  It would be
an 80% OK explanation if the "check diff_unmerge()'s return value"
approach was sufficient to correct bugs and we took the approach,
but that is not the case.  As you found out, it is not sufficient,
and it is not the approach you took.  The only part in the proposed
log that explains the approach that was actually taken was "we can
do better by ...".

Until/unless we do similar "filter with diffopt.prefix upfront" in
diff-index and diff-tree codepaths, we unfortunately cannot lose the
filter added to diff_addremove() and diff_change(), but I think this
is a good first step towards such a longer-term clean-up.

Thanks.
