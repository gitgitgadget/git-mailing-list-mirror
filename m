Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D9B1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 20:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756322AbdLVUiY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 15:38:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55194 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755941AbdLVUiX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 15:38:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 820C8BE9C4;
        Fri, 22 Dec 2017 15:38:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCmNy+WzPKPYVmIYeVzuhV4Zfog=; b=lbY2x3
        /Vl1jXwq7iVgIWxVJUUHEC4Jn5V81xyVTpTclXYTq7BE9KwYEPn32Hs6ixX0vFrk
        GimwA8YsZNjcU2sAZU6Pzc43YMQo0YOPn38Sunp8hI1/NGHigSJ+eW/uiiRLn8L2
        kCXokgYa2QfdbIJCUoa8yfpjjDoMEJ9ceHlXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SnHCijibLi+eGIS3MyWWtLF6g+rxgbxR
        fn/iL8zgvhNTUBmFjSHIovxVDzpLGYXe6nHZAjqeeEjBFO1x4oMPrvpJrZA3Q2Fp
        jBu7CAlyJ4x2jvERQLzlX55+Lnj2uHVnDmJ9pK/RgocsNX8IDDC7yiaTyJZnjnFw
        n/5UyX3wmoc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79A31BE9C3;
        Fri, 22 Dec 2017 15:38:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E33D3BE9C2;
        Fri, 22 Dec 2017 15:38:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, a.krey@gmx.de
Subject: Re: [PATCH 3/3] merge-recursive: Avoid incorporating uncommitted changes in a merge
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
        <20171221191907.4251-1-newren@gmail.com>
        <20171221191907.4251-3-newren@gmail.com>
Date:   Fri, 22 Dec 2017 12:38:20 -0800
In-Reply-To: <20171221191907.4251-3-newren@gmail.com> (Elijah Newren's message
        of "Thu, 21 Dec 2017 11:19:07 -0800")
Message-ID: <xmqqh8siqz0j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D02559A-E758-11E7-B066-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> builtin/merge.c contains this important requirement for merge strategies:
> 	/*
> 	 * At this point, we need a real merge.  No matter what strategy
> 	 * we use, it would operate on the index, possibly affecting the
> 	 * working tree, and when resolved cleanly, have the desired
> 	 * tree in the index -- this means that the index must be in
> 	 * sync with the head commit.  The strategies are responsible
> 	 * to ensure this.
> 	 */
>
> merge-recursive does not do this check directly, instead it relies on
> unpack_trees() to do it.  However, merge_trees() has a special check for
> the merge branch exactly matching the merge base; when it detects that
> situation, it returns early without calling unpack_trees(), because it
> knows that the HEAD commit already has the correct result.  Unfortunately,
> it didn't check that the index matched HEAD, so after it returned, the
> outer logic ended up creating a merge commit that included something
> other than HEAD.

Good.

I actually was imagining that you would shoot for creating an empty
commit and leaving a working tree and the index that are both dirty,
but I do not think it is worth the effort.  Besides, "you have to
start from a clean index" is a much simpler rule to explain than
with "unless the resulting tree is the same as HEAD", especially
when that "unless" is highly unlikely to happen anyway.

Thanks.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c                        | 7 +++++++
>  t/t6044-merge-unrelated-index-changes.sh | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 2ecf495cc2..780f81a8bd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1952,6 +1952,13 @@ int merge_trees(struct merge_options *o,
>  	}
>  
>  	if (oid_eq(&common->object.oid, &merge->object.oid)) {
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		if (index_has_changes(&sb)) {
> +			err(o, _("Dirty index: cannot merge (dirty: %s)"),
> +			    sb.buf);
> +			return 0;
> +		}
>  		output(o, 0, _("Already up to date!"));
>  		*result = head;
>  		return 1;
> diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
> index 5e472be92b..23b86fb977 100755
> --- a/t/t6044-merge-unrelated-index-changes.sh
> +++ b/t/t6044-merge-unrelated-index-changes.sh
> @@ -112,7 +112,7 @@ test_expect_success 'recursive' '
>  	test_must_fail git merge -s recursive C^0
>  '
>  
> -test_expect_failure 'recursive, when merge branch matches merge base' '
> +test_expect_success 'recursive, when merge branch matches merge base' '
>  	git reset --hard &&
>  	git checkout B^0 &&
