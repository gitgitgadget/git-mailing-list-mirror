Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E0C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C8B22C9F
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 05:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbhAFF4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:56:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57538 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFF4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 00:56:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF9BA1101B0;
        Wed,  6 Jan 2021 00:55:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=UuQc51UshLExDI48NsFuA7uK+zw=; b=bV1ebflKyDVH+6SHocM6
        LY6SQlTEzRRzPBFNgEZdzRvYU7x9vVv9bprHVj8lcwepnSho8COnS1W3KN66DZFq
        zf/x/L5QDhl3I9D6+M5vVcfzFCuTzM2psPBmN5vT/V5pBMY8LeZlnh5DnA5A344b
        K/Y1SBbw839Ujb3wn0rJuqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ARLF6tnvbPIdmU6cw9K+3hPaQUSRxbUrF5mks8IZ6kLKJ5
        RORWbfcs74aULdDNImtMj+1an/Mv+WcNCf9hC+u92Db1TI0TtD6WMhJK+KZGk/y5
        ltw4FVTzSUzzzKHxfazXbgADD5i9am9xDgjE3mKmBjuo2lcuL48pc7vgrKLno=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C88591101AF;
        Wed,  6 Jan 2021 00:55:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1A6D1101AE;
        Wed,  6 Jan 2021 00:55:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 5/5] mergetool: add automerge_enabled tool-specific
 override function
References: <20201228045427.1166911-1-seth@eseth.com>
        <20201228192919.1195211-1-seth@eseth.com>
        <20201228192919.1195211-6-seth@eseth.com>
Date:   Tue, 05 Jan 2021 21:55:26 -0800
Message-ID: <xmqqpn2ivcc1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6E69740-4FE3-11EB-8BC2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 929192d0f8..a44afd3822 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -336,7 +336,7 @@ merge_file () {
>  
>  	initialize_merge_tool "$merge_tool"
>  
> -	if test "$(
> +	if automerge_enabled && test "$(
>  		git config --get --bool "mergetool.$merge_tool.automerge" ||
>  		git config --get --bool "mergetool.automerge" ||
>  		echo true)" = true

This allows the tool author to say "nobody ever is allowed to use my
tool with the automerge feature".  I know I may have suggested
something like that, but I am not sure if we want to be all that
draconian.

If the user explicitly says "I want the new behaviour enabled for
this particular merge tool", we are better off letting the user use
it and take responsibility for the possible breakage.

My preference would probably be

 - if "mergetool.$merge_tool.automerge" is set to 'true' or 'false',
   that's final.

 - Your automerge_enabled helper that is by default 'true' (but
   allows individual merge_tool to return 'false') is asked, and if
   it says 'false', that's final.  But 'true' from automerge_enabled
   is not final at this step.

 - if "mergetool.automerge" is set to 'true' or 'false', that's
   final.

 - otherwise, your automerge_enabled helper's answer (either 'true'
   or 'false') gives the final answer.

That way, those who use a broad "mergetool.automerge = true/false"
would still honor what automerge_enabled yields (which is "enabled
by default but individual merge_tool can set its default to be
disabled"), while individual mergetool.$merge_tool.automerge
configuration would always win.

Hmm?
