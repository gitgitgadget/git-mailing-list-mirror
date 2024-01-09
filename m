Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5443DB84
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D8YxOjcE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C8F31386F9;
	Tue,  9 Jan 2024 16:57:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qj/lkkZIFTbQd6useFW8ZANoPGHvr/yVHTP11e
	8zvcE=; b=D8YxOjcEWEKv0TeUpkiA8lsLkUJRQWKwPwmcojvnKYCEvtgQW0oK7j
	djYZ0F0rOggzpaHd4hDFzaXsJSEKdngfuqJmpgB4t67y/3yXPGbegiGgaJB3edrk
	TLA0oVY+RbKw1OM0+AHyUlDsNuQMT6bvpDPwm7G3y1+Rs0hh9/Cqs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C0A8C386F8;
	Tue,  9 Jan 2024 16:57:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6532B386F7;
	Tue,  9 Jan 2024 16:57:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/3] submodule-config.c: strengthen URL fsck check
In-Reply-To: <893071530d3b77d6b72b7f69a6dfb9947579865e.1704822817.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 09 Jan 2024 17:53:37
	+0000")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<893071530d3b77d6b72b7f69a6dfb9947579865e.1704822817.git.gitgitgadget@gmail.com>
Date: Tue, 09 Jan 2024 13:57:14 -0800
Message-ID: <xmqqplyaf9vp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D7CB136-AF3A-11EE-AA61-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Update the validation of "curl URL" submodule URLs (i.e. those that specify
> an "http[s]" or "ftp[s]" protocol) in 'check_submodule_url()' to catch more
> invalid URLs. The existing validation using 'credential_from_url_gently()'
> parses certain URLs incorrectly, leading to invalid submodule URLs passing
> 'git fsck' checks. Conversely, 'url_normalize()' - used to validate remote
> URLs in 'remote_get()' - correctly identifies the invalid URLs missed by
> 'credential_from_url_gently()'.
>
> To catch more invalid cases, replace 'credential_from_url_gently()' with
> 'url_normalize()' followed by a 'url_decode()' and a check for newlines
> (mirroring 'check_url_component()' in the 'credential_from_url_gently()'
> validation).

Thanks.  Left hand and right hand checking the same thing in
different ways and coming up with different result is never a happy
situation.  Making sure we consistently use the same definition of
what the valid URLs are is a very welcome thing to do, of course.

> -test_expect_failure 'check urls' '
> +test_expect_success 'check urls' '
>  	cat >expect <<-\EOF &&
>  	./bar/baz/foo.git
>  	https://example.com/foo.git

It is a bit unfortunate that from here we cannot tell which bogus
URLs in this test that were incorrectly accepted are now rejected.

Among the many bogus URLs in the input, we used to allow

    http://example.com:test/foo.git

(we do not accept non-numeric representation of port numbers, so
http://example.com:http/foo.git would also be rejected), but with
this change, it is now rejected.  All the other bogus ones are
rejected just as before this change.

Will queue.  Thanks.

