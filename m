Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFE101F9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eCIvgx1R"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCABC83
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:47:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CC9B71A95B7;
	Fri, 13 Oct 2023 16:47:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vx/RBFmuhxPPMX8oKHqJ1yC96zqic1wYvQ1HhH
	v9JNs=; b=eCIvgx1R5E55slhSGzhl9TWpxfj5K5fyAuIciSjPsjoOf/fTdccXRy
	ArDXueoBMkGc/AER1zzai3rGR2Bmy9OBkFVzt/aFk+WrgkN9udpOmoSk+NG8zzWn
	l5e+Gkzdo7rMzzQAOSxjoYrGaNTOFJKjIR6Qsnod1CFe9HOIS07lk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3A931A95B6;
	Fri, 13 Oct 2023 16:47:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 308641A95B5;
	Fri, 13 Oct 2023 16:47:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Jonathan Tan
 <jonathantanmy@google.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5 0/2] attr: add attr.tree config
In-Reply-To: <xmqqa5smz2lk.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Oct 2023 13:31:19 -0700")
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
	<pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
	<xmqqmswmz76w.fsf@gitster.g> <xmqqa5smz2lk.fsf@gitster.g>
Date: Fri, 13 Oct 2023 13:47:16 -0700
Message-ID: <xmqqzg0mxnaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2357F4E-6A09-11EE-9CF3-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Junio C Hamano <gitster@pobox.com> writes:

> So in a sense, for !!ignore_bad_attr_tree case, the code ends up
> doing the right thing.  But if !ignore_bad_attr_tree is true, i.e.,
> a blob object name is given via --attr-source or GIT_ATTR_SOURCE,
> then the bug will be uncovered.

Having said all that, I suspect that this problem is not new and
certainly not caused by this topic.  We should have unconditionally
died when GIT_ATTR_SOURCE gave a blob object name, but pretended as
if an empty tree was given.  There may even be existing users who
now assume that is working as intended and depend on this bug.

So, let's leave it as a "possible bug" that we might want to fix in
the future, outside the scope of this series.

Thanks.


>  t/t0003-attributes.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
> index ecf43ab545..0f02f22171 100755
> --- c/t/t0003-attributes.sh
> +++ w/t/t0003-attributes.sh
> @@ -394,6 +394,18 @@ test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--attr-source that points at a non-treeish' '
> +	test_when_finished rm -rf empty &&
> +	git init empty &&
> +	(
> +		cd empty &&
> +		echo "$bad_attr_source_err" >expect_err &&
> +		H=$(git hash-object -t blob --stdin -w </dev/null) &&
> +		test_must_fail git --attr-source=$H check-attr test -- f/path 2>err &&
> +		test_cmp expect_err err
> +	)
> +'
> +
>  test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, then attr.tree' '
>  	test_when_finished rm -rf empty &&
>  	git init empty &&
