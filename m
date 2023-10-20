Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE01802E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wh3QePou"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4AD52
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 12:52:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62E7D1A36C9;
	Fri, 20 Oct 2023 15:52:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DRuyOT3qVGzJE/3jTJ2pWWmxx6JAS1F6uDnJ7b
	nqE2c=; b=wh3QePouwE4NXxvA8V/oifRGwv9+jVqy87rJYeExs6XDJFjBHrePh6
	K6C5zLNSQ+Ah8fS3SYEVdk+yhLvGGg9iOfFhGYfWqhdQmXS/d928F9+r1lXdIrOL
	lVLXsP1GixW9sD4AnYTt2EuJ1rISMK6m/v9kGOzcRlPK7qeLAbiFg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59AD41A36C8;
	Fri, 20 Oct 2023 15:52:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF5F11A36C7;
	Fri, 20 Oct 2023 15:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 05/11] t: convert tests to not access symrefs via the
 filesystem
In-Reply-To: <1ac120368c6cd995841c28bde7542e882ec7b04f.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:24 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<1ac120368c6cd995841c28bde7542e882ec7b04f.1697607222.git.ps@pks.im>
Date: Fri, 20 Oct 2023 12:52:36 -0700
Message-ID: <xmqq4jilqdff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 386AAE86-6F82-11EE-995C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> @@ -164,9 +164,9 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
>  test_expect_success 'for-each-ref emits warnings for broken names' '
>  	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
>  	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
> -	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
> +	test-tool ref-store main create-symref refs/heads/badname refs/heads/broken...ref &&

I am of two minds here.  While it certainly smells nicer because we
can test ref backends other than the files backend with this change,
we are forcing all ref backends to support creating a symbolic ref
with invalid name, because otherwise "test-tool" would not be able
to do this.  Newer more database-oriented ref backends should be
allowed to implement their file format in which it is imposssible to
store such a bad name, but this makes it impossible.

I guess it is OK, because we would introduce some new prerequisite
(i.e. REF_BACKEND_ALLOWS_BROKEN_REFS) to skip this test on certain
ref backend where making invalid refs is impossible.

Other kind of changes in this patch, e.g., ...

> @@ -315,7 +325,9 @@ test_expect_success 'defaulted HEAD uses remote branch if available' '
>  	git -c init.defaultBranch=branchwithstuff -c protocol.version=2 \
>  		clone "file://$(pwd)/file_unborn_parent" \
>  		file_unborn_child 2>stderr &&
> -	grep "refs/heads/branchwithstuff" file_unborn_child/.git/HEAD &&
> +	echo "refs/heads/branchwithstuff" >expect &&
> +	git -C file_unborn_child symbolic-ref HEAD >actual &&
> +	test_cmp expect actual &&
>  	test_path_is_file file_unborn_child/stuff.t &&
>  	! grep "warning:" stderr
>  '
> diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
> index d8d536269cf..8ca24670acb 100755
> --- a/t/t9133-git-svn-nested-git-repo.sh
> +++ b/t/t9133-git-svn-nested-git-repo.sh
> @@ -11,7 +11,7 @@ test_expect_success 'setup repo with a git repo inside it' '
>  	(
>  		cd s &&
>  		git init &&
> -		test -f .git/HEAD &&
> +		git symbolic-ref HEAD &&
>  		> .git/a &&
>  		echo a > a &&
>  		svn_cmd add .git a &&

... all looked sensible, though.

Thanks.
