Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2EE320756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdATWS3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:18:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751121AbdATWS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:18:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11F35630A0;
        Fri, 20 Jan 2017 17:18:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eBSwDb++qQ47c1XYE/qTG9Qco7Y=; b=kyb4KE
        x4DjpKyA+1BTKTA/WN14UvpZ6X3qtHRoDjcVrGAdznj6mv/5VHrDvVmV2BVriQbt
        T6FII6lNeSgH2jNsgbaqArx0S18B8feq2R8cC7FxXWSoQqjMn4BCHNWREO4YU2U+
        PP/4wPlLNSx1hWvTCD8OyDKOE9BdPNuqmMFYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ildjrnO0/PWHMsEFWFGUgt7XKei1qG8T
        EFJfpm2+8LuoOs7A3NVDlpK/weTpcCpDtC3QP1q3oNdvRNQ35LFm7WqdQGwYI1P2
        raeg+05y/3nSEJPO4dSOZNQABVUodeROgXVuRNZZkLn9pTRxDJD5eUbXMOhD9fjV
        UamfnXGrTew=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 085996309F;
        Fri, 20 Jan 2017 17:18:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C6E66309E;
        Fri, 20 Jan 2017 17:18:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
References: <20170120171126.16269-1-stefanha@redhat.com>
        <20170120171126.16269-3-stefanha@redhat.com>
Date:   Fri, 20 Jan 2017 14:18:20 -0800
In-Reply-To: <20170120171126.16269-3-stefanha@redhat.com> (Stefan Hajnoczi's
        message of "Fri, 20 Jan 2017 17:11:26 +0000")
Message-ID: <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A32DC98-DF5E-11E6-87EC-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> If the tree contains a sub-directory then git-grep(1) output contains a
> colon character instead of a path separator:
>
>   $ git grep malloc v2.9.3:t
>   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
>   $ git show v2.9.3:t:test-lib.sh
>   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'
>
> This patch attempts to use the correct delimiter:
>
>   $ git grep malloc v2.9.3:t
>   v2.9.3:t/test-lib.sh:	setup_malloc_check () {
>   $ git show v2.9.3:t/test-lib.sh
>   (success)
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  builtin/grep.c  | 4 +++-
>  t/t7810-grep.sh | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 90a4f3d..7a7aab9 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -494,7 +494,9 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
>  
>  			/* Add a delimiter if there isn't one already */
>  			if (name[len - 1] != '/' && name[len - 1] != ':') {
> -				strbuf_addch(&base, ':');
> +				/* rev: or rev:path/ */
> +				char delim = obj->type == OBJ_COMMIT ? ':' : '/';

Why check the equality with commit, rather than un-equality with
tree?  Wouldn't you want to treat $commit:path and $tag:path the
same way?

I also think the two patches should be squashed together, as it is
only after this patch that the code does the "right thing" by
changing the delimiter depending on obj->type.

> +				strbuf_addch(&base, delim);
>  			}
>  		}
>  		init_tree_desc(&tree, data, size);
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index e804a3f..8a58d5e 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -1445,6 +1445,11 @@ test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t/' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'grep outputs valid <rev>:<path> for HEAD:t' '
> +	git grep vvv HEAD:t >actual &&
> +	test_cmp expected actual
> +'
> +

Perhaps you want an annotated tag object refs/tags/v1.0 that points
at the commit at the HEAD, and then run the same grep on v1.0:t, in
addition to the above test.

>  cat >expected <<EOF
>  HEAD:t/a/v:vvv
>  HEAD:t/v:vvv
