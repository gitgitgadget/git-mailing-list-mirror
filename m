Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25943C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AB420658
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnUiJqA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfL3VoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 16:44:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56572 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3VoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 16:44:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D28D595D78;
        Mon, 30 Dec 2019 16:44:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GxRbn9K3F6hCCQSJqSiYGpUcoIk=; b=fnUiJq
        A2Jg+AdiZ+S+qIR6SxThuEt4MzfWi33uoXQ6oXQmuDSzz85SOznq4tEHTdBDrh0M
        xDbXGt/N+tKvGiCn3zfF6YlaqmB2gnrS3MdCJj95/dNQ4XCHB2CUH0W8cO+1irvq
        6AeOQUZttQuJpxpVzcbkhHoqF/33WjYtm8tQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DnM2A3L8tIDR5yWMfM3srQTRQ2f6HKuf
        9huSl0GaAXrKMC4A+Md+IhZ4atDVpb42Gmc7+bJRkMHOZw54H5tynPyUxuqkANsp
        YwHuRCOwJ7Dw+Y8wl0lLs6/lOT3mDaGfvVl47fPC5Vjv+bEaRdrN1admzzqXw/AX
        F9rDuwYABbw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CADED95D77;
        Mon, 30 Dec 2019 16:44:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE76E95D74;
        Mon, 30 Dec 2019 16:43:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: remove OBJECT_INFO_SKIP_CACHED
References: <20191230211027.37002-1-jonathantanmy@google.com>
Date:   Mon, 30 Dec 2019 13:43:56 -0800
In-Reply-To: <20191230211027.37002-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 30 Dec 2019 13:10:27 -0800")
Message-ID: <xmqqsgl1fq03.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C86DA22-2B4D-11EA-99CE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In a partial clone, if a user provides the hash of the empty tree ("git
> mktree </dev/null" - for SHA-1, this is 4b825d...) to a command which
> requires that that object be parsed, for example:
>
>   git diff-tree 4b825d <a non-empty tree>
>
> then Git will lazily fetch the empty tree.

That sounds like a bug.  Shouldn't some objects like empty tree and
empty blob whose names are hardcoded come internally without being
fetched from anywhere?

> There are 2 functions: repo_has_object_file() which does not consult
> find_cached_object() (which, among other things, knows about the empty
> tree); and repo_read_object_file() which does. This issue occurs
> because, as an optimization to avoid reading blobs into memory,
> parse_object() calls repo_has_object_file() before
> repo_read_object_file(). In the case of a regular repository (that is,
> not a partial clone), repo_has_object_file() will return false for the
> empty tree (thus bypassing the optimization) and...

OK, that bypassing already sounds wrong.  

> ... it will no longer be the case that
> repo_has_object_file() doesn't know about empty trees, but
> repo_read_object_file() does.

Yup, that sounds like the right solution to the bug, with or without
lazy cloning.
