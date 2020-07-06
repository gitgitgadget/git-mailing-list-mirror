Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B56C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 21:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4237B206B6
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 21:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGPYq64e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGFVoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:44:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59392 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 17:44:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C1C7CA314;
        Mon,  6 Jul 2020 17:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U9BTK3O2GKevI2kfjJSXXDcY/so=; b=GGPYq6
        4eRC9dc3jdgkCUEJzZL9xkOnIg9ZVRx+Z938uoiS/P0SrpYzoTstr4ExY3ajz9i6
        CWkNgy3tO8ZDFqdumUXsPvvJwfe0U28V5OftK5PrzE3d64e1B7sXpEJPujzVrn9P
        rnWo1T4AffLoweg3ljUQ43lExVhDXnqk/Xy3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XSwdI6n+csqZADmZbWJ0bG/hRT9IoEzT
        sffR25VdL1snp7GKZ1DqwLbXBr5uaFucDJmOZ9uxuyyzFgQ6t2BfNxx0kCrOVSaG
        CYHRs4RAG6YDLHFy0sGNwhOJ4/0WI/Z12BrwALi4N1mWVvmWU0T774ucDZdlvvZo
        XxQySMxiutk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32E1ACA313;
        Mon,  6 Jul 2020 17:44:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 826D6CA312;
        Mon,  6 Jul 2020 17:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/2] ref-filter: add support for %(contents:size)
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
        <20200702140845.24945-3-chriscool@tuxfamily.org>
Date:   Mon, 06 Jul 2020 14:44:17 -0700
In-Reply-To: <20200702140845.24945-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 2 Jul 2020 16:08:45 +0200")
Message-ID: <xmqq5zb09v4e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8DA59A2-BFD1-11EA-8EAE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It's useful and efficient to be able to get the size of the
> contents directly without having to pipe through `wc -c`.
>
> Also the result of the following:
>
> `git for-each-ref --format='%(contents)' | wc -c`
>
> is off by one as `git for-each-ref` appends a newline character
> after the contents, which can be seen by comparing its ouput
> with the output from `git cat-file`.

So that's off by number of refs that are shown?

> +contents:size::
> +	The size in bytes of the complete message.
> +

Complete as opposed to what?  

What happens when the object referred to by the ref is not a commit
or a tag?

I am fine if it just is silently ignored (which is consistent with
already existing behaviour of other requests that do not make sense
for the given type) if the thing is a blob or a tree, but we'd need
to cover the case with a test or two.  It seems you only expect this
with a tag object and do not have any test that checks for other
types of objects?

Thanks.

> +# We cannot use test_atom to check contents:size of signed tags due to sanitize_pgp
> +test_tag_contents_size_pgp () {
> +	ref="$1"
> +	test_expect_success $PREREQ "basic atom: $ref contents:size" "
> +		git cat-file tag $ref | tail -n +6 | wc -c >expected &&
> +		git for-each-ref --format='%(contents:size)' $ref >actual &&
> +		test_cmp expected actual
> +	"
> +}
> +
>  PREREQ=GPG
>  test_atom refs/tags/signed-empty subject ''
>  test_atom refs/tags/signed-empty contents:subject ''
> @@ -629,6 +643,7 @@ test_atom refs/tags/signed-empty body "$sig"
>  test_atom refs/tags/signed-empty contents:body ''
>  test_atom refs/tags/signed-empty contents:signature "$sig"
>  test_atom refs/tags/signed-empty contents "$sig"
> +test_tag_contents_size_pgp refs/tags/signed-empty
>  
>  test_atom refs/tags/signed-short subject 'subject line'
>  test_atom refs/tags/signed-short contents:subject 'subject line'
> @@ -637,6 +652,7 @@ test_atom refs/tags/signed-short contents:body ''
>  test_atom refs/tags/signed-short contents:signature "$sig"
>  test_atom refs/tags/signed-short contents "subject line
>  $sig"
> +test_tag_contents_size_pgp refs/tags/signed-short
>  
>  test_atom refs/tags/signed-long subject 'subject line'
>  test_atom refs/tags/signed-long contents:subject 'subject line'
> @@ -649,6 +665,7 @@ test_atom refs/tags/signed-long contents "subject line
>  
>  body contents
>  $sig"
> +test_tag_contents_size_pgp refs/tags/signed-long
>  
>  test_expect_success 'set up multiple-sort tags' '
>  	for when in 100000 200000
