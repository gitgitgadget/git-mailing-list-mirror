Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570362070C
	for <e@80x24.org>; Wed,  6 Jul 2016 17:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbcGFRnn (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 13:43:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754068AbcGFRnm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 13:43:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3965280FE;
	Wed,  6 Jul 2016 13:43:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CHddupZu04q2
	lljmld3U0s0CDSw=; b=Z8AI2sZM6N8ynfe7KvCDv0gNNmXNhNDhG5BgpauXuQJ5
	eXJBE8GhBzOIKgQqjn0zzsOT1LJcOX5q7pnUMMAX33L2X81Gt/j3xHxX4s6MNvD5
	9+krhxdBooGJSP4JBBhDGnmBMwYcdfyMJvU59hll/YM+h1mvntQZaUC/SJphxYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qsJuYD
	CRh4XxA9PCZIWZyqqnjxO9Naw5/02SGbeHC7nUxgfIigLV4ff/kyxYhH3xzcROwJ
	c/NHMCKNCCl+uDW5yA5HbUqpRTUmh8PnenSwzJ+h1Zvb68nVAMTg2p0NLFp/JtaX
	dicdutSUByyLw4kImMkfNdQxYSPZ6/JMzhTms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCC70280FA;
	Wed,  6 Jul 2016 13:43:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55E1D280F1;
	Wed,  6 Jul 2016 13:43:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH] cache-tree.c: fix i-t-a check skipping directory updates sometimes
References: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
	<20160704174807.6578-1-pclouds@gmail.com>
Date:	Wed, 06 Jul 2016 10:43:21 -0700
In-Reply-To: <20160704174807.6578-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Mon, 4 Jul 2016 19:48:07 +0200")
Message-ID: <xmqqd1mqu0g6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22C69E4C-43A1-11E6-A588-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Commit 3cf773e (cache-tree: fix writing cache-tree when CE_REMOVE is
> present - 2012-12-16) skips i-t-a entries when building trees objects
> from the index. Unfortunately it may skip too much.
>
> The code in question checks if an entry is an i-t-a one, then no tree
> entry will be written. But it does not take into account that
> directories can also be written with the same code. Suppose we have
> this in the index.
>
>     a-file
>     subdir/file1
>     subdir/file2
>     subdir/file3
>     the-last-file
>
> We write an entry for a-file as normal and move on to subdir/file1,
> where we realize the entry name for this level is simply just
> "subdir", write down an entry for "subdir" then jump three items ahead
> to the-last-file.
>
> That is what happens normally when the first file in subdir is not an
> i-t-a entry. If subdir/file1 is an i-t-a, because of the broken
> condition in this code, we still think "subdir" is an i-t-a file and
> not writing "subdir" down and jump to the-last-file. The result tree
> now only has two items: a-file and the-last-file. subdir should be
> there too (even though it only records two sub-entries, file2 and
> file3).
>
> If the i-t-a entry is subdir/file2 or subdir/file3, this is not a
> problem because we jump over them anyway. Which may explain why the
> bug is hidden for nearly four years.
>
> Fix it by making sure we only skip i-t-a entries when the entry in
> question is actual an index entry, not a directory.

Aha.  Good catch.

However, this makes me wonder if subdir has only files all of which
are i-t-a.  The resulting top-level tree object should not record
subdir/ as an empty (sub)directory in that case.  I do not see where
you are ensuring it in the patch below, though.

>
> Reported-by: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  cache-tree.c          |  4 ++--
>  t/t2203-add-intent.sh | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index ddf0cc9..c2676e8 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -319,7 +319,7 @@ static int update_one(struct cache_tree *it,
>  	i = 0;
>  	while (i < entries) {
>  		const struct cache_entry *ce = cache[i];
> -		struct cache_tree_sub *sub;
> +		struct cache_tree_sub *sub = NULL;
>  		const char *path, *slash;
>  		int pathlen, entlen;
>  		const unsigned char *sha1;
> @@ -375,7 +375,7 @@ static int update_one(struct cache_tree *it,
>  		 * they are not part of generated trees. Invalidate up
>  		 * to root to force cache-tree users to read elsewhere.
>  		 */
> -		if (ce_intent_to_add(ce)) {
> +		if (!sub && ce_intent_to_add(ce)) {
>  			to_invalidate = 1;
>  			continue;
>  		}
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 2a4a749..12d701c 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -82,5 +82,18 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
> +	git init ita-in-dir &&
> +	(
> +		cd ita-in-dir &&
> +		mkdir 2 &&
> +		touch 1 2/1 2/2 3 &&
> +		git add 1 2/2 3 &&
> +		git add -N 2/1 &&
> +		git commit -m comitted &&
> +		git ls-tree -r HEAD | grep 2/2
> +	)
> +'
> +
>  test_done
