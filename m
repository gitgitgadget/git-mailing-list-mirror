Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79345C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 23:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483052087F
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 23:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rFu2VAu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgA1XQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:16:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57746 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA1XQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 18:16:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAA923A6E7;
        Tue, 28 Jan 2020 18:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JaNVAqPO4hQdouHMpdsubQLc5cQ=; b=rFu2VA
        u8wJ2uuXovxycBMnD1YPcWAjhwvemd3H3+2Aj/wV0nKTpkPJGcOEdLQQy0Yj/c83
        mYEoCGT22uHJgT8bPdSJ31ZEwwLh7e6i8WXcllZAEVIgrZU3ajIm0OLDn5lKoWGN
        bD7IvibmWIvSy5MFGFhmUBHFmHm5gpb02gEHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QDOI21fgThSv5ENFFfxpL0n7e9uykgI8
        GFVJhK+5cV8AAN/d4eUYSNudzWF9Z+LYW1ELOdO+LnLnG+kNjJrjdzDPIhdbWl7q
        qdRmwjR00ZQK48M3+ETLmJLtN9gorRdvVhQqdj7L9/nfv0OSfK9n7/X11HtDUqIx
        B3oTAYkGmjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D23B23A6E6;
        Tue, 28 Jan 2020 18:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3075A3A6E5;
        Tue, 28 Jan 2020 18:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Make git rm submodule succeed if .gitmodules index stat info is zero
References: <20200127185856.2619317-1-dturner@twosigma.com>
Date:   Tue, 28 Jan 2020 15:16:02 -0800
In-Reply-To: <20200127185856.2619317-1-dturner@twosigma.com> (David Turner's
        message of "Mon, 27 Jan 2020 13:58:56 -0500")
Message-ID: <xmqqftfz6ukt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27CBDBD4-4224-11EA-A582-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> The bug was that ie_match_stat was used to compare if the stat info
> for the file was compatible with the stat info in the index, rather
> using ie_modified to check if the file was in fact different from the
> version in the index.

Makes sense.  ie_match_stat() often ends up comparing the file
contents in our tests due to sequence Git commands firing too
rapidly, leading to a racy-index status, but read-tree is a reliable
way to clear the cached stat information to force it say "I dunno---
suspect it got modified".  Will queue.

> +test_expect_success 'rm will not error out on .gitmodules file with zero stat data' '
> +	git reset --hard &&
> +	git submodule update &&
> +	git read-tree HEAD &&
> +	git rm submod &&
> +	test_path_is_missing submod
> +'
>  
>  test_expect_success 'rm issues a warning when section is not found in .gitmodules' '
>  	git reset --hard &&
