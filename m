Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pC2fEuSC"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B74120
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 23:57:28 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 382D21D1E64;
	Thu, 16 Nov 2023 02:57:28 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lPm/OruJDX0/I++ysT4RsXkuYlmDhXS8PBo9vt
	vi5ZU=; b=pC2fEuSC+gk3eirW4v7ZDC7ByVqBxPs2DS1GhBDb6lLNWNDMhQ16J/
	L/Hzs3JXgOTcqnxUaSqFBUYCPYFTRHUFays41XvGnhIBCg+6rpgypyahH+Nfqc64
	NsNeLEGJ4U9z3lwKmg66HmO8v7q56mVbQWPxrxVhv9rIk0d0+dj2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FF191D1E63;
	Thu, 16 Nov 2023 02:57:28 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91DF61D1E62;
	Thu, 16 Nov 2023 02:57:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <20231116054437.2343549-1-jojwang@google.com> (Joanna Wang's
	message of "Thu, 16 Nov 2023 05:44:37 +0000")
References: <xmqqttpmtnn5.fsf@gitster.g>
	<20231116054437.2343549-1-jojwang@google.com>
Date: Thu, 16 Nov 2023 16:57:26 +0900
Message-ID: <xmqqmsveqgex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C91ACC94-8455-11EE-BE2B-25B3960A682E-77302942!pb-smtp2.pobox.com

Joanna Wang <jojwang@google.com> writes:

> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
> index a9c1e4e0ec..b08a32ea68 100755
> --- a/t/t6135-pathspec-with-attrs.sh
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -295,4 +295,29 @@ test_expect_success 'reading from .gitattributes in a subdirectory (3)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'pathspec with builtin_objectmode attr can be used' '
> +	>mode_exec_file_1 &&
> +
> +	git status -s ":(attr:builtin_objectmode=100644)mode_exec_*" >actual &&
> +	echo ?? mode_exec_file_1 >expect &&
> +	test_cmp expect actual &&
> +
> +	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&

This again would break with filesystems that are incapable of
supporting executable bit natively.  Writing one command per line,
doing something like this may help

	git add mode_exec_file_1 &&
	git update-index --chmod=+x mode_exec_file_1 &&

> +	git status -s ":(attr:builtin_objectmode=100755)mode_exec_*" >actual &&
> +	echo AM mode_exec_file_1 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'builtin_objectmode attr can be excluded' '
> +	>mode_1_regular &&
> +	>mode_1_exec  && chmod +x mode_1_exec &&

Ditto.

> +	git status -s ":(exclude,attr:builtin_objectmode=100644)" "mode_1_*" >actual &&
> +	echo ?? mode_1_exec >expect &&
> +	test_cmp expect actual &&
> +
> +	git status -s ":(exclude,attr:builtin_objectmode=100755)" "mode_1_*" >actual &&
> +	echo ?? mode_1_regular >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
