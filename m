Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5141C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B9764E6B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhBIWYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:24:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64459 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhBIWJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1162AB0E9B;
        Tue,  9 Feb 2021 16:23:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qA1w6gVTbNJA3SzSCOU90WTXg6Y=; b=AaMZlH
        /uh4smc1NXP2NMsqGTgRa/2htbEKGX/9K06oZwMkVeGneAC1CXYXuNzqsD7RYvHO
        sDbVhqRpsOirzalncwQ1VmTj/p08N8zUqkDs8aw5lLVF80OItxZwwj++5K1ZBWZd
        xKqyYYYvXYqb1YCSz00UwcWJjeggug2a6lyDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d8QRU+Ygg4el08/eiPSuU/mJWXCUa6RA
        FmSK3BU2qOhEGNvVz2mEdMkdROXwhfSd/g70FtX+BJRwz3Amm4YzsRolXpJ2geOM
        YwLqVW4F+Uy5M4ZJlQm+jcNk7y+YDK0wHPPVhHL0c2PYcbLpleafpk+wm5nNrPl5
        SO7IQF/9AKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08553B0E9A;
        Tue,  9 Feb 2021 16:23:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 873C7B0E98;
        Tue,  9 Feb 2021 16:23:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
        <YB148VZJqKIPC8P2@coredump.intra.peff.net>
        <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
        <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
Date:   Tue, 09 Feb 2021 13:23:32 -0800
In-Reply-To: <YCLGgpfkJzg5nP7v@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 9 Feb 2021 12:29:38 -0500")
Message-ID: <xmqqv9b1ylyj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 103EE9C0-6B1D-11EB-9C29-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   If the file `.mailmap` exists at the toplevel of the repository[...]
>
> which likewise reinforces the notion that we are looking in the working
> tree.

> diff --git a/mailmap.c b/mailmap.c
> index eb77c6e77c..9bb9cf8b30 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -225,7 +225,8 @@ int read_mailmap(struct string_list *map)
>  	if (!git_mailmap_blob && is_bare_repository())
>  		git_mailmap_blob = "HEAD:.mailmap";
>  
> -	err |= read_mailmap_file(map, ".mailmap");
> +	if (!startup_info->have_repository || !is_bare_repository())
> +		err |= read_mailmap_file(map, ".mailmap");

OK.  Do we know at this point that cwd is always/already at the root
level of the working tree?

Thanks.
