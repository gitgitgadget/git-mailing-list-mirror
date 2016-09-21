Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490A61F935
	for <e@80x24.org>; Wed, 21 Sep 2016 19:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934392AbcIUTSH (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 15:18:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55988 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932771AbcIUTSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 15:18:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3777C3FB68;
        Wed, 21 Sep 2016 15:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QG5UPQWvVVPIitfksSPIpqI9QTg=; b=Si0bcM6Q6U0K2YTVHauV
        m6JEu9gMVmC2oJUgIM9YsCYmW+CPh/w/qMUFdPyhhi+wjU3FxXox9BLdlBNubDPy
        gLGe4W2eEUsk321QLvEumxKMlTO2xP0xQQQq7tEMV6kJrMo7yi+KxzeUnKyNtMv1
        DtEGE0Mz4mOY7Am5U6uTRCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=o5TH7chjQCo1fnQkS7W32TKy6Hax9AvaP9XbXvOkFnAoMD
        gMtam9ytLw1a2vXVsMUIocrVw244lt6ZQadxD/x19nrlH1KIc8Tk6gqqdmuH4WB+
        fmYp5D3XfyDdkeebFokaBO8+OdOFGhUCealb/mKI5mBvKf+0yD3jxNI3tesGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F0F63FB67;
        Wed, 21 Sep 2016 15:18:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42D973FB66;
        Wed, 21 Sep 2016 15:18:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 3/3] regex: use regexec_buf()
References: <cover.1473321437.git.johannes.schindelin@gmx.de>
        <cover.1474482164.git.johannes.schindelin@gmx.de>
        <53f3609d99c865d59d7bfd8219a5334339e9e6bc.1474482164.git.johannes.schindelin@gmx.de>
Date:   Wed, 21 Sep 2016 12:18:01 -0700
Message-ID: <xmqqmvj16p06.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E1EAD5A-8030-11E6-9650-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The new regexec_buf() function operates on buffers with an explicitly
> specified length, rather than NUL-terminated strings.
>
> We need to use this function whenever the buffer we want to pass to
> regexec() may have been mmap()ed (and is hence not NUL-terminated).
>
> Note: the original motivation for this patch was to fix a bug where
> `git diff -G <regex>` would crash. This patch converts more callers,
> though, some of which explicitly allocated and constructed
> NUL-terminated strings (or worse: modified read-only buffers to insert
> NULs).
>
> Some of the buffers actually may be NUL-terminated. As regexec_buf()
> uses REG_STARTEND where available, but has to fall back to allocating
> and constructing NUL-terminated strings where REG_STARTEND is not
> available, this makes the code less efficient in the latter case.
>
> However, given the widespread support for REG_STARTEND, combined with
> the improved ease of code maintenance, we strike the balance in favor
> of REG_STARTEND.

The last paragraph can go (2/3 was already justified separately),
and the paragraph before that needs rewording, as you no longer do
the "duplicate, run regexec, and free" dance.

Will comment on the patch text itself later.

Thanks for following it through.  This topic actually fell under my
radar until now.
