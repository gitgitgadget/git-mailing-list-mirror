Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FC12B7C
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jJ3c5NBd"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685B10D3
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 16:13:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CAEC311A3;
	Sat, 21 Oct 2023 19:13:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ThMslNTUztN8oXlOLTVzyRC1srtDCK5CofAoJk
	R47D4=; b=jJ3c5NBdZl+BQ0rRv6Ju8DdInbY5UY27Jgs+mSBjZ2gvYmJRHkrFF8
	nRYfQV2CmeOK0wFG6I88p9yptHX0cxZA6lpWappfFmsvuwZSKNMOVaVwuXfOHIRN
	lTebxXBXRBOpeIhrr3wQxIsKjm3QBTVa12Oi0OgktQRxoA4aIvAWQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 15173311A2;
	Sat, 21 Oct 2023 19:13:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3DD23119F;
	Sat, 21 Oct 2023 19:13:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 06/11] t: convert tests to not access reflog via the
 filesystem
In-Reply-To: <eaac658bbfd8259ed9a3cce6ca3c8486d6682e8f.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:29 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<eaac658bbfd8259ed9a3cce6ca3c8486d6682e8f.1697607222.git.ps@pks.im>
Date: Sat, 21 Oct 2023 16:13:01 -0700
Message-ID: <xmqqy1fvsh6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 62380138-7067-11EE-AEDE-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 5f505e2f353..b1d2c014132 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -90,7 +90,8 @@ test_expect_success "deleting current branch adds message to HEAD's log" '
>  	git symbolic-ref HEAD $m &&
>  	git update-ref -m delete-$m -d $m &&
>  	test_must_fail git show-ref --verify -q $m &&
> -	grep "delete-$m$" .git/logs/HEAD
> +	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
> +	grep "delete-$m$" actual
>  '
>  
>  test_expect_success "deleting by HEAD adds message to HEAD's log" '
> @@ -99,7 +100,8 @@ test_expect_success "deleting by HEAD adds message to HEAD's log" '
>  	git symbolic-ref HEAD $m &&
>  	git update-ref -m delete-by-head -d HEAD &&
>  	test_must_fail git show-ref --verify -q $m &&
> -	grep "delete-by-head$" .git/logs/HEAD
> +	test-tool ref-store main for-each-reflog-ent HEAD >actual &&
> +	grep "delete-by-head$" actual
>  '

These are quite straight-forward.

>  test_expect_success "verifying $m's log (logged by config)" '
> -	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test_when_finished "git update-ref -d $m && git reflog expire --expire=all --all && rm -rf actual expect" &&
>  	test-tool ref-store main for-each-reflog-ent $m >actual &&
>  	test_cmp actual expect
>  '

The approach forces us to assume that "git reflog expire" performs
correctly in order to test reflog, but it probably is OK---we'll
notice breakages in "reflog expire" in other tests, hopefully.
