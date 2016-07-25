Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8C6203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbcGYWXV (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:23:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755117AbcGYWWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:22:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73CE8304E5;
	Mon, 25 Jul 2016 18:22:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4AQ/3Cy6ejGNTyHhTZ1WyhhjKsI=; b=k6mKr5
	Q3PKgrn0z+l+PRqebrKHEGmgHH8hLV1wk6hqPQ2WaPuDE7K90ZxbvEF4Zixxt0vt
	+DVhXbA2PKi0gjw0Dq78E+ABAyazrpDJ8zBScSFIrpNVcq0jJPnB/EcB4IK7UjQ9
	kvUPfZxq2iB53Y6gcT3GMkKKMjgnOFw8aNydg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mk7QJkr5yrJsB0sm2eUcn0iHp6Yrf4ln
	5FppyT96DaNkNkcIZZnURvphtnnNGRPVA45asyi2XebhvY0aAAVe7zF7P89WuF3R
	uuoANvASm3WuWpvedsph00oGV30TJ3/9ptPLEyBbFn30fiPzh2+82n1+xZ5UvWsA
	LlnSE+WaS+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A3CA304E4;
	Mon, 25 Jul 2016 18:22:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D94AA304E2;
	Mon, 25 Jul 2016 18:22:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	John Keeping <john@keeping.me.uk>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch creation
References: <cover.1469483499.git.john@keeping.me.uk>
	<4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
Date:	Mon, 25 Jul 2016 15:22:48 -0700
In-Reply-To: <4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
	(John Keeping's message of "Mon, 25 Jul 2016 22:59:56 +0100")
Message-ID: <xmqqpoq12w93.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52DB4CA8-52B6-11E6-976E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

John Keeping <john@keeping.me.uk> writes:

> Allow the empty string to stand in for the null SHA-1 when pushing a new
> branch, like we do when deleting branches.
>
> This means that the following command ensures that `new-branch` is
> created on the remote (that is, is must not already exist):
>
> 	git push --force-with-lease=new-branch: origin new-branch
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> New in v2.
>
>  Documentation/git-push.txt |  3 ++-
>  remote.c                   |  2 ++
>  t/t5533-push-cas.sh        | 12 ++++++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index bf7c9a2..927a034 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -201,7 +201,8 @@ if it is going to be updated, by requiring its current value to be
>  the same as the specified value `<expect>` (which is allowed to be
>  different from the remote-tracking branch we have for the refname,
>  or we do not even have to have such a remote-tracking branch when
> -this form is used).
> +this form is used).  If `<expect>` is the empty string, then the named ref
> +must not already exist.
>  +
>  Note that all forms other than `--force-with-lease=<refname>:<expect>`
>  that specifies the expected current value of the ref explicitly are
> diff --git a/remote.c b/remote.c
> index a326e4e..af94892 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2294,6 +2294,8 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
>  	entry = add_cas_entry(cas, arg, colon - arg);
>  	if (!*colon)
>  		entry->use_tracking = 1;
> +	else if (!colon[1])
> +		memset(entry->expect, 0, sizeof(entry->expect));

hashclr()?

>  	else if (get_sha1(colon + 1, entry->expect))
>  		return error("cannot parse expected object name '%s'", colon + 1);
>  	return 0;
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index c732012..5e7f6e9 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -191,4 +191,16 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'new branch covered by force-with-lease (explicit)' '
> +	setup_srcdst_basic &&
> +	(
> +		cd dst &&
> +		git branch branch master &&
> +		git push --force-with-lease=branch: origin branch
> +	) &&
> +	git ls-remote dst refs/heads/branch >expect &&
> +	git ls-remote src refs/heads/branch >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
