Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F2D20756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdAQU5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:57:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54154 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751023AbdAQU5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:57:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 271A061A06;
        Tue, 17 Jan 2017 15:52:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iolid1TwW63T+FCrIx1suseVMl4=; b=MLFxlg
        yZyDURl23wCuXByA7vD6uIL9wb9BQhXsKVb9649heO39hhKr1LQ0Kvh4xJqo2JQ5
        r1VcXXT0B0AM2abQPwraovfzNRKJ23E39i0LepXS96ZiYiHOVtlQWKRjDgdC6+eT
        xh6Nqjuo5MajbABHr8LxPSZ2NbKcUEIHfxSjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KUgklUl+kK1kTOy0QqMVTbeGQiUEbL8n
        VTKHRC0Nks10UtbWsD6rG7hECIKJetxTbqAR6BxcSblhwPWAhje0uQJkpIZgll4S
        xxWGygiKszsgk9JqP+YOoCdD0oDcb87fSdoeLwiWgcLbEmyPcS3WL+v7E5d4Xctj
        JRzidqVbeeU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F86A61A05;
        Tue, 17 Jan 2017 15:52:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7849B61A03;
        Tue, 17 Jan 2017 15:52:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/6] t1450: clean up sub-objects in duplicate-entry test
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
        <20170116212403.l7ca7crmt47id3mu@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 12:52:43 -0800
In-Reply-To: <20170116212403.l7ca7crmt47id3mu@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 16:24:03 -0500")
Message-ID: <xmqqlgu9e7dw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5B23648-DCF6-11E6-9121-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This test creates a multi-level set of trees, but its
> cleanup routine only removes the top-level tree. After the
> test finishes, the inner tree and the blob it points to
> remain, making the inner tree dangling.
>
> A later test ("cleaned up") verifies that we've removed any
> cruft and "git fsck" output is clean. This passes only
> because of a bug in git-fsck which fails to notice dangling
> trees.
>
> In preparation for fixing the bug, let's teach this earlier
> test to clean up after itself correctly. We have to remove
> the inner tree (and therefore the blob, too, which becomes
> dangling after removing that tree).
>
> Since the setup code happens inside a subshell, we can't
> just set a variable for each object. However, we can stuff
> all of the sha1s into the $T output variable, which is not
> used for anything except cleanup.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1450-fsck.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks.  

It is tempting to move this loop to remove_object, but that is not
necessary while the user is only this one.

>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index ee7d4736d..6eef8b28e 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -189,14 +189,16 @@ test_expect_success 'commit with NUL in header' '
>  '
>  
>  test_expect_success 'tree object with duplicate entries' '
> -	test_when_finished "remove_object \$T" &&
> +	test_when_finished "for i in \$T; do remove_object \$i; done" &&
>  	T=$(
>  		GIT_INDEX_FILE=test-index &&
>  		export GIT_INDEX_FILE &&
>  		rm -f test-index &&
>  		>x &&
>  		git add x &&
> +		git rev-parse :x &&
>  		T=$(git write-tree) &&
> +		echo $T &&
>  		(
>  			git cat-file tree $T &&
>  			git cat-file tree $T
