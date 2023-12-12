Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UFDTpGa9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB6E8
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 09:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702402146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soZEcbjOkfOg+EooY9VRHmxCumLQ1et1GRSxISEX+/o=;
	b=UFDTpGa9G2dAt6vUQ9suUiXJrZ5svDJ+JbOkjEx1Fq3cN20/AoMHxYfO3DORl+Lf/21hIY
	EmRvchlCv5lntS0DicCTnbPiPHvCr3qeZ9Xxi4VPj2sZ63gbipNVyZ2z1RRXzlgghuQxLp
	ct+Njk3DAVwmcEBy6LEgyKGcY22pRficqQVvoiwpwCR+S1dHjnSy6Up7FIdAoqDE8VjlRt
	zH46s/9eH1rZilIkuimNaJMoWUnqQJ7gA6vfNagZuH6HlbosfWEopPvwQ5Qe+JtQB8gb4Q
	WuejZXoLJklHh6KsOQ+4vI4UFPCc9b6/3FH6eJAWZ5CWP7W7BywKQqWYeGzQ8Q==
Date: Tue, 12 Dec 2023 18:29:05 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, AtariDreams
 <83477269+AtariDreams@users.noreply.github.com>, Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
In-Reply-To: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
Message-ID: <62c31371741b07ec5e012cb268294536@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-12-12 18:17, AtariDreams via GitGitGadget wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> If it is known that an int is either 1 or 0,
> doing an exclusive or to switch instead of a
> modulus makes more sense and is more efficient.

Quite frankly, this doesn't seem like an improvement to me.  It makes 
the code much less readable, more error-prone, and may even end up 
producing code that isn't portable.

Regarding the efficiency, such optimizations may be perfectly fine as a 
trade-off in some critical paths, but these cases don't seem like that.

> Signed-off-by: Seija Kijin doremylover123@gmail.com
> ---
>     Use ^=1 to toggle between 0 and 1
> 
>     If it is known that an int is either 1 or 0, doing an exclusive or 
> to
>     switch instead of a modulus makes more sense and is more efficient.
> 
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-git-1620%2FAtariDreams%2Fbuffer-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-git-1620/AtariDreams/buffer-v1
> Pull-Request: https://github.com/git/git/pull/1620
> 
>  builtin/fast-export.c      | 4 ++--
>  diff.c                     | 2 +-
>  ident.c                    | 2 +-
>  t/helper/test-path-utils.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 70aff515acb..f9f2c9dd850 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -593,8 +593,8 @@ static void anonymize_ident_line(const char **beg,
> const char **end)
>  	struct ident_split split;
>  	const char *end_of_header;
> 
> -	out = &buffers[which_buffer++];
> -	which_buffer %= ARRAY_SIZE(buffers);
> +	out = &buffers[which_buffer];
> +	which_buffer ^= 1;
>  	strbuf_reset(out);
> 
>  	/* skip "committer", "author", "tagger", etc */
> diff --git a/diff.c b/diff.c
> index 2c602df10a3..91842b54753 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1191,7 +1191,7 @@ static void mark_color_as_moved(struct 
> diff_options *o,
>  							    &pmb_nr);
> 
>  			if (contiguous && pmb_nr && moved_symbol == l->s)
> -				flipped_block = (flipped_block + 1) % 2;
> +				flipped_block ^= 1;
>  			else
>  				flipped_block = 0;
> 
> diff --git a/ident.c b/ident.c
> index cc7afdbf819..188826eed63 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -459,7 +459,7 @@ const char *fmt_ident(const char *name, const char 
> *email,
>  	int want_name = !(flag & IDENT_NO_NAME);
> 
>  	struct strbuf *ident = &ident_pool[index];
> -	index = (index + 1) % ARRAY_SIZE(ident_pool);
> +	index ^= 1;
> 
>  	if (!email) {
>  		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> index 70396fa3845..241136148a5 100644
> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -185,7 +185,7 @@ static int check_dotfile(const char *x, const char 
> **argv,
>  	int res = 0, expect = 1;
>  	for (; *argv; argv++) {
>  		if (!strcmp("--not", *argv))
> -			expect = !expect;
> +			expect ^= 1;
>  		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
>  			res = error("'%s' is %s.git%s", *argv,
>  				    expect ? "not " : "", x);
> 
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
