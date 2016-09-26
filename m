Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30675207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423015AbcIZQzZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:55:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65139 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1422838AbcIZQzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:55:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0279141D1C;
        Mon, 26 Sep 2016 12:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CAjXOAsfH3XPxpn6obIKjbLSbDc=; b=D9pPRN
        Cmp6dW5ePqHSZPCoM6Ojhoux6+JIgU5EPbmG1HUwIM/hGS1NLJ/pjZsalSHbAlIq
        mauNOVJw27Y5Udygxz8YUeOFovdh0zzJdHPkJazk/wd1BCLH41eI9OWH9NHjXakp
        SNTa3Cxr5n2itOFdBiyeemGQNfHHESe/0VcD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cFZKxDjablX/EJAaYHvsW1ThZLA2AyZF
        lRqrC8zykA1cE+WdsL0WzvZVkKUx3Gky70t90QXQzUo9ChfTcL8t0k3QB4YYCk45
        VbZ+t/1aEnlO/4nHlMj1J/Iv1ogY5hb4OdfuIVEJRVDFRbKngjjczKEpHGE/X1rw
        fW2trfyulEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE05341D1B;
        Mon, 26 Sep 2016 12:55:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 777AD41D1A;
        Mon, 26 Sep 2016 12:55:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 04/10] get_short_sha1: peel tags when looking for treeish
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926115947.hksmtkqp3i4tfftx@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 09:55:20 -0700
In-Reply-To: <20160926115947.hksmtkqp3i4tfftx@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 07:59:48 -0400")
Message-ID: <xmqq7f9yvbwn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0386370A-840A-11E6-9D26-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The treeish disambiguation function tries to peel tags, but
> it does so by calling:
>
>   deref_tag(lookup_object(sha1), ...);
>
> This will only work if we have previously looked at the tag
> and created a "struct tag" for it. Since parsing revision
> arguments typically happens before anything else, this is
> usually not the case, and we would fail to peel the tag (we
> are lucky that deref_tag() gracefully handles the NULL and
> does not segfault).

Makes perfect sense.

> Instead, we can use parse_object(). Note that this is the
> same fix done by 94d75d1 (get_short_sha1(): correctly
> disambiguate type-limited abbreviation, 2013-07-01), but
> that commit fixed only the committish disambiguator, and
> left the bug in the treeish one.

Can you share your secret tool you use to find this kind of thing?
Yes, the patch from that commit does look very similar to what we
see in this patch, but I'd love to see "I am fixing an incorrect
call to lookup-object by replacing it with parse-object; has there
been a similar fix?" automated ;-)

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_name.c                         | 2 +-
>  t/t1512-rev-parse-disambiguation.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 38e51d9..432a308 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -269,7 +269,7 @@ static int disambiguate_treeish_only(const unsigned char *sha1, void *cb_data_un
>  		return 0;
>  
>  	/* We need to do this the hard way... */
> -	obj = deref_tag(lookup_object(sha1), NULL, 0);
> +	obj = deref_tag(parse_object(sha1), NULL, 0);
>  	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
>  		return 1;
>  	return 0;
> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
> index 30e0b80..dfd3567 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -264,6 +264,13 @@ test_expect_success 'ambiguous commit-ish' '
>  	test_must_fail git log 000000000...
>  '
>  
> +# There are three objects with this prefix: a blob, a tree, and a tag. We know
> +# the blob will not pass as a treeish, but the tree and tag should (and thus
> +# cause an error).
> +test_expect_success 'ambiguous tags peel to treeish' '
> +	test_must_fail git rev-parse 0000000000f^{tree}
> +'
> +
>  test_expect_success 'rev-parse --disambiguate' '
>  	# The test creates 16 objects that share the prefix and two
>  	# commits created by commit-tree in earlier tests share a
