Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB5C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiGKVW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 17:22:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC12A71A
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 14:22:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 792F01A6CFC;
        Mon, 11 Jul 2022 17:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c7e40sFABKcILYNTTGvX2ot/bIE+kd/b1SmKjZ
        Sy/r8=; b=mDTuv7jTcow0WIm6tVdtZVsdmYwyuHgyTSa4bCFm/ZDG0P/WFruMo1
        hF+moLnqcZAIyYgl9ZVc4NfvfrKbcH+qIrmdn8lcnOI7zaRD1+8wbUnCGtFcJYU/
        4PKT8leluYbnTrnDqf+D0EsOAa5hrHhc/y6V+v/5xK+9Epg65oMGw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7163D1A6CFB;
        Mon, 11 Jul 2022 17:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE5091A6CF9;
        Mon, 11 Jul 2022 17:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 4/7] pack-bitmap.c: don't ignore ENOENT silently
References: <cover.1657540174.git.dyroneteng@gmail.com>
        <009cc49a18f2846c24256102e07437894ac16908.1657540174.git.dyroneteng@gmail.com>
Date:   Mon, 11 Jul 2022 14:22:15 -0700
In-Reply-To: <009cc49a18f2846c24256102e07437894ac16908.1657540174.git.dyroneteng@gmail.com>
        (Teng Long's message of "Mon, 11 Jul 2022 20:44:00 +0800")
Message-ID: <xmqqpmibmjjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A2AB046-015F-11ED-99DF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> When finished call git_open(), instead of ignoring ENOENT silently
> and return error_errno(_("cannot stat...")), it's better to check
> the ENOENT before then output the warning.

Both the title and the body describes a complete opposite of what
the patch does, doesn't it?

	pack-bitmap.c: do not ignore error when opening a bitmap file

	Calls to git_open() to open the pack bitmap file and
	multi-pack bitmap file do not report any error when they
	fail.  These files are optional and it is not an error if
	open failed due to ENOENT, but we shouldn't be ignoring
	other kinds of errors.

or something?

> +	if (fd < 0) {
> +		if (errno != ENOENT)
> +			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
> +		free(bitmap_name);

Showing the errno is good, but I do not think it should be enclosed
in single quotes.

One thing you should consider when writing a "this is an optional
file and not finding it is perfectly fine" logic like this one is
that you may or may not want to ignore ENOTDIR.  ENOTDIR is what you
get when you say open("a/b") and "a" exists as something other than
a directory.  If you have a path with a slash in bitmap_name, and if
in a sane and healthy repository the leading path should always
exist (i.e. the file "a/b" may be missing, but the directory "a/"
should be there), then getting ENOTDIR is a noteworthy event.  There
may be cases where ENOTDIR can justifiably and should be ignored.

