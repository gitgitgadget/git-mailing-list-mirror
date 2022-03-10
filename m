Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F10C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbiCJSaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiCJSaD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:30:03 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0618CC12
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:29:02 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C6AB18A234;
        Thu, 10 Mar 2022 13:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4dbeBszat6bVnPmkoYFMEuPxC8HYfplXp8jgn2
        udLjA=; b=eEHmT69MjIYv8LOdbhP3tIdmrLseRLMgzFAncmgvymjVduBg3znlyX
        68+Ouadk3vuFiAjQmbtKPqCa0hMl8VVaR5izWxcplMIzzaN5NIC3qtQJBg7BjP0Y
        JVj/u+s/9h0JFG+wShFjOKc43OJFvjZvH/nR+VCS59Y9N8/XG7KT8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3364718A233;
        Thu, 10 Mar 2022 13:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AF1618A231;
        Thu, 10 Mar 2022 13:28:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 8/8] core.fsync: new option to harden packed references
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <3b81d8f5aeffb73a32b0bff0da947f023a3df517.1646905589.git.ps@pks.im>
Date:   Thu, 10 Mar 2022 10:28:57 -0800
In-Reply-To: <3b81d8f5aeffb73a32b0bff0da947f023a3df517.1646905589.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 10 Mar 2022 10:53:25 +0100")
Message-ID: <xmqqzglxek5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3587510-A09F-11EC-AF5A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 27dd8c3922..32d6635969 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1262,7 +1262,8 @@ static int write_with_updates(struct packed_ref_store *refs,
>  		goto error;
>  	}
>  
> -	if (close_tempfile_gently(refs->tempfile)) {
> +	if (fsync_component(FSYNC_COMPONENT_PACKED_REFS, get_tempfile_fd(refs->tempfile)) ||
> +	    close_tempfile_gently(refs->tempfile)) {
>  		strbuf_addf(err, "error closing file %s: %s",
>  			    get_tempfile_path(refs->tempfile),
>  			    strerror(errno));

I do not necessarily agree with the organization to have it as a
component that is separate from other ref backends, but it is
very pleasing to see that there is only one fsync necessary for the
packed backend.

Nice.
