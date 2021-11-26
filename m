Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A569EC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbhKZIBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:01:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59408 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbhKZH7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 02:59:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01D75171F8D;
        Fri, 26 Nov 2021 02:56:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=38UUR7GTYXFo9AWPsiGS+0owQgmkYakanfplO9
        Sw9OE=; b=fO5FMZOaqqJ+Z+ZWEDRzW48kEyV+BlzKOPJBB1iu+oRvuisTW9XUbT
        SjPCnN0wnSFX3nCSdmTFmQLCg551Hsnb200KkYg5pWKYktbvMcaCLa3cesIkRT3q
        vXnSEnYVDRuCqsLvkhhHandAzoJcQfsHWxnpQp3JgKMvp2Jn4Ev+M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1BDF171F8C;
        Fri, 26 Nov 2021 02:56:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDCD4171F8B;
        Fri, 26 Nov 2021 02:56:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/5] test-ref-store: don't add newline to reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <4a86d21258918ea8124caef1cd2e435b465f67c5.1637855872.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 23:56:18 -0800
In-Reply-To: <4a86d21258918ea8124caef1cd2e435b465f67c5.1637855872.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 25 Nov 2021
        15:57:49 +0000")
Message-ID: <xmqqy25b73kt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57605BAE-4E8E-11EC-9779-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The files backend produces a newline for messages automatically, so before we
> would print blank lines between entries.

It is misleading to say "The files backend produces" here.  The
promise the API makes to the callback functions is that msg will be
a single complete line, regardless of what ref backend is used, no?

Unless we plan to break the promise to the callback, forcing them to
compensate the differences of behaviour between backends, by making
the reftable backend behave differently.

    The callback for each-reflog-ent iterator functions receives a
    single complete line terminated with a newline at the end in the
    'msg' parameter; by having a newline in the printf() format
    string, we have been emitting a blank line between entries.

    Fix it.

or something, I think.

> -	printf("%s %s %s %"PRItime" %d %s\n",
> -	       oid_to_hex(old_oid), oid_to_hex(new_oid),
> -	       committer, timestamp, tz, msg);
> +	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
> +	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
>  	return 0;
>  }
>  
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index 49718b7ea7f..a600bedf2cd 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -89,13 +89,12 @@ test_expect_success 'for_each_reflog()' '
>  test_expect_success 'for_each_reflog_ent()' '
>  	$RUN for-each-reflog-ent HEAD >actual &&
>  	head -n1 actual | grep one &&
> -	tail -n2 actual | head -n1 | grep recreate-main
> +	tail -n1 actual | grep recreate-main

And I do agree this makes it much more pleasant than before (not
just this one but all the changes to the tests).

Thanks.

