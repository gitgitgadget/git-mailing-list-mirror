Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57EA47366
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lXeAXVkq"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF8114
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:34:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C6F0D36088;
	Wed, 18 Oct 2023 14:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bWir1A939zwTuiJNesjoy2MHrYyrvOV46NwpU+
	ulWZ4=; b=lXeAXVkqrnAF25cQ230hQJ9sibsHCJUkmBe1Q2lG0iAu/RB11gXTFv
	XeQ1uTfEmmb0j34xSaxp7F/9QAlcyr5UI+8i/2ZeGB32MuhGqCoPsBG/yaF2e1qz
	3zkxrdftVD47f2sfvB8HNsX2VwceGF0RUalx4H/Txs1ByakeQaPkU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BDEEB36087;
	Wed, 18 Oct 2023 14:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4002736086;
	Wed, 18 Oct 2023 14:34:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 04/11] t: convert tests to not write references via the
 filesystem
In-Reply-To: <c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Oct 2023 07:35:20 +0200")
References: <cover.1697607222.git.ps@pks.im>
	<c79431c0bf117d756e1d584f4c9415888d9ff9eb.1697607222.git.ps@pks.im>
Date: Wed, 18 Oct 2023 11:34:23 -0700
Message-ID: <xmqq1qdru6ds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6A0F1CA-6DE4-11EE-8FFA-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patrick Steinhardt <ps@pks.im> writes:

> -test_expect_success "fail to create $n" '
> -	test_when_finished "rm -f .git/$n_dir" &&
> -	touch .git/$n_dir &&
> -	test_must_fail git update-ref $n $A
> +test_expect_success "fail to create $n due to file/directory conflict" '
> +	test_when_finished "git update-ref -d refs/heads/gu" &&
> +	git update-ref refs/heads/gu $A &&
> +	test_must_fail git update-ref refs/heads/gu/fixes $A
>  '

OK, the original checks "if a random garbage file, which may not
necessarily be a ref, exists at $n_dir, we cannot create a ref at
$n_dir/fixes, due to D/F conflict" more directly, but as long as our
intention is to enforce the D/F restriction across different ref
backends [*], creating a ref at $n_dir and making sure $n_dir/fixes
cannot be created is an equivalent check that is better (because it
can be applied for other backends).

    Side note: there is no fundamental need to, though, and there
         are cases where being able to have the 'seen' branch and
         'seen/ps/ref-test-tools' branches at the same time is
         beneficial---packed-refs and ref-table backends would not
         have such an inherent limitation, but they can of course be
         castrated to match what files-backend can(not) do.

> @@ -222,7 +220,7 @@ test_expect_success 'delete symref without dereference when the referred ref is
>  
>  test_expect_success 'update-ref -d is not confused by self-reference' '
>  	git symbolic-ref refs/heads/self refs/heads/self &&
> -	test_when_finished "rm -f .git/refs/heads/self" &&
> +	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF refs/heads/self" &&
>  	test_path_is_file .git/refs/heads/self &&

I trust that this will be corrected to use some wrapper around "git
symbolic-ref" (or an equivalent for it as a test-tool subcommand) in
some future patch, if not in this series?

>  	test_must_fail git update-ref -d refs/heads/self &&
>  	test_path_is_file .git/refs/heads/self

Likewise.

> @@ -230,7 +228,7 @@ test_expect_success 'update-ref -d is not confused by self-reference' '
>  
>  test_expect_success 'update-ref --no-deref -d can delete self-reference' '
>  	git symbolic-ref refs/heads/self refs/heads/self &&
> -	test_when_finished "rm -f .git/refs/heads/self" &&
> +	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF refs/heads/self" &&
>  	test_path_is_file .git/refs/heads/self &&
>  	git update-ref --no-deref -d refs/heads/self &&
>  	test_must_fail git show-ref --verify -q refs/heads/self

We already have the "ref is missing" test here.

I'll stop at this point for now; will hopefully continue in a
separate message later.  Thanks.
