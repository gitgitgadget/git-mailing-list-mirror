Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94626C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44095206BE
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LRAtlfz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgGGTps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:45:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55486 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGTpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:45:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A19D56F8B8;
        Tue,  7 Jul 2020 15:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5xs//7Q2gqSpO56ldgrN9udRJ10=; b=LRAtlf
        z6OdpshR2GzMZVeZkaC2vc1EEh3EyDI51dFLzGxdPIo/N0DFtu+mKiAdM8u4FkbG
        NgtXqaUtSLkoadCLDWSHYZPBsy8px2g20yz7Ynq1C7ZPdyy/1c8HkzC13HmseB4T
        /RuRTyOHLxkTlsFBF9SlhwcYoaWHEjNuuNSlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sy5LlzR99WpSX6CdW8THgt6CvBhm7DMw
        bs89W+MX+hQ+HVlxoegy87nAQeYXhvDNdAcbR30/Y4duqaALb/toYh+YPyOq0fu0
        Nv/cjDKGasboUBtlYlAW8dvWEhItdxZTID/IfA/GT/m9ikASzXiVKhPJsc9NV8di
        IwZG95qiI7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99C526F8B7;
        Tue,  7 Jul 2020 15:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0B826F8B6;
        Tue,  7 Jul 2020 15:45:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-5-chriscool@tuxfamily.org>
Date:   Tue, 07 Jul 2020 12:45:39 -0700
In-Reply-To: <20200707174049.21714-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 7 Jul 2020 19:40:49 +0200")
Message-ID: <xmqqk0zf3y8s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F9B9E9C-C08A-11EA-A82E-C28CBED8090B-77302942!pb-smtp1.pobox.com
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
> `git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`
>
> is off by one as `git for-each-ref` appends a newline character
> after the contents, which can be seen by comparing its output
> with the output from `git cat-file`.
>
> As with %(contents), %(contents:size) is silently ignored, if a
> ref points to something other than a commit or a tag:
>
> ```
> $ git update-ref refs/mytrees/first HEAD^{tree}
> $ git for-each-ref --format='%(contents)' refs/mytrees/first
>
> $ git for-each-ref --format='%(contents:size)' refs/mytrees/first
>
> ```
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-for-each-ref.txt |  3 +++
>  ref-filter.c                       |  7 ++++++-
>  t/t6300-for-each-ref.sh            | 19 +++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)

Nice.  The only questionable thing here is if we later regret for
assuming that all sizes are always measured in bytes.  If we later
find an application that wants an efficient access to "| wc -l"
(instead of "| wc -c" that motivated this patch), we'd want to be
able to say "%(contents:lines)" and at that point we may want to go
back in time and call this "%(contents:bytes)" or something.

>  test_atom head contents 'Initial
>  '
> +test_atom head contents:size '8'

These two are tied together (any change to the test script that
causes us to update the former also forces us to update the latter),
but I do not think of a way to unify the test without writing too
much boilerplate code, so let's say this is good enough at least for
now (but I may change my opinion as I read along).

>  test_atom tag contents 'Tagging at 1151968727
>  '
> +test_atom tag contents:size '22'

Likewise.

> @@ -580,6 +582,7 @@ test_atom refs/tags/subject-body contents 'the subject line
>  first body line
>  second body line
>  '
> +test_atom refs/tags/subject-body contents:size '51'

Likewise.

Of course, we _could_ update the test_atom to do something magic
only when the 'contents' atom is being asked.  We notice that $2 is
'contents', do the usual test_expect_success for 'contents', and
then measure the byte length of $3 ourselves and test
'contents:size'.  That way, all the above test updates would become
unnecessary (and the last two hunks of this patch can also go).

That approach may even allow you to hide the details of sanitize-pgp
in the updated test_atom so that the actual tests may not have to get
updated even for signed tags.

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
>  test_expect_success 'set up refs pointing to tree and blob' '
>  	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
> @@ -664,6 +681,7 @@ test_atom refs/mytrees/first body ""
>  test_atom refs/mytrees/first contents:body ""
>  test_atom refs/mytrees/first contents:signature ""
>  test_atom refs/mytrees/first contents ""
> +test_atom refs/mytrees/first contents:size ""
>  
>  test_atom refs/myblobs/first subject ""
>  test_atom refs/myblobs/first contents:subject ""
> @@ -671,6 +689,7 @@ test_atom refs/myblobs/first body ""
>  test_atom refs/myblobs/first contents:body ""
>  test_atom refs/myblobs/first contents:signature ""
>  test_atom refs/myblobs/first contents ""
> +test_atom refs/myblobs/first contents:size ""
>  
>  test_expect_success 'set up multiple-sort tags' '
>  	for when in 100000 200000
