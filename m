Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FFFC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6578264F86
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhBBQ6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:58:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50889 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhBBQ4G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:56:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A962100232;
        Tue,  2 Feb 2021 11:55:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RkIDHwDreDuFEt6cQhbsZgKULMU=; b=i8mPO6
        hh3VBC/cPuYPPq+AlGyy8hKXeRj1q9gQGwWuL4WxHl6d1UJnWqmdKhlwBzMolYg6
        y0d7n+OHUSVWJNb3xmxP8sgsjGoHQjQsRj8g/ykI48iwGUPu8cuHphmT6NLMfc2j
        Gqj6SQLCv109Qyv5x9DycuXnqyXDHSfqQVK3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c5y2/KgFxgHjCv5bASG03mnZ35lbYzV9
        oDxP/ozkJXcEZVul/TTlbX7QperU1JDYmUxAo50pr7qVdxCWCjU4uZk7ea+U3zcQ
        I3te3f5ZjWmrujevYMFrPTZ0kiavF3BhnaZBirPL3pD7zDfQTgtq6oDoAZyoPVQv
        saIuR11xKZc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44160100231;
        Tue,  2 Feb 2021 11:55:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E351100230;
        Tue,  2 Feb 2021 11:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v6 1/3] ls-refs: report unborn targets of symrefs
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1612231707.git.jonathantanmy@google.com>
        <411bbafe25f60c2ef9d9ab773e5eb046b8549b2d.1612231707.git.jonathantanmy@google.com>
Date:   Tue, 02 Feb 2021 08:55:14 -0800
In-Reply-To: <411bbafe25f60c2ef9d9ab773e5eb046b8549b2d.1612231707.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 1 Feb 2021 18:14:59 -0800")
Message-ID: <xmqq4kiuif4d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C9D5216-6577-11EB-B4F5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning, we choose the default branch based on the remote HEAD.
> But if there is no remote HEAD reported (which could happen if the
> target of the remote HEAD is unborn), we'll fall back to using our local
> init.defaultBranch. Traditionally this hasn't been a big deal, because
> most repos used "master" as the default. But these days it is likely to
> cause confusion if the server and client implementations choose
> different values (e.g., if the remote started with "main", we may choose
> "master" locally, create commits there, and then the user is surprised
> when they push to "master" and not "main").
> ...
> The client side will be updated to use this in a subsequent commit.

Nicely explained.

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 85daeb5d9e..4707511c10 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
>  	When specified, only references having a prefix matching one of
>  	the provided prefixes are displayed.
>  
> +If the 'unborn' feature is advertised the following argument can be
> +included in the client's request.
> +
> +    unborn
> +	The server may send symrefs pointing to unborn branches in the form
> +	"unborn <refname> symref-target:<target>".
> +

I somehow had an impression that this is done only for HEAD and no
other symrefs.

If this describes the ideal endgame state and the implementation at
the moment only covers what is practically the most useful (i.e.
HEAD), that is fine.

If we do not plan to support symrefs other than HEAD that are
dangling, that is fine as well, but then the description needs
updating, no?
