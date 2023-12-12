Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A779B7
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 12:09:22 -0800 (PST)
Received: (qmail 16569 invoked by uid 109); 12 Dec 2023 20:09:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 20:09:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18739 invoked by uid 111); 12 Dec 2023 20:09:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 15:09:20 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 15:09:20 -0500
From: Jeff King <peff@peff.net>
To: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	AtariDreams <83477269+AtariDreams@users.noreply.github.com>,
	Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Message-ID: <20231212200920.GC1127366@coredump.intra.peff.net>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>

On Tue, Dec 12, 2023 at 05:17:47PM +0000, AtariDreams via GitGitGadget wrote:

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 70aff515acb..f9f2c9dd850 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -593,8 +593,8 @@ static void anonymize_ident_line(const char **beg, const char **end)
>  	struct ident_split split;
>  	const char *end_of_header;
>  
> -	out = &buffers[which_buffer++];
> -	which_buffer %= ARRAY_SIZE(buffers);
> +	out = &buffers[which_buffer];
> +	which_buffer ^= 1;

In the current code, if the size of "buffers" is increased then
everything would just work. But your proposed code (rather subtly) makes
the assumption that ARRAY_SIZE(buffers) is 2.

So even leaving aside questions of readability, I think the existing
code is much more maintainable.

> diff --git a/diff.c b/diff.c
> index 2c602df10a3..91842b54753 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1191,7 +1191,7 @@ static void mark_color_as_moved(struct diff_options *o,
>  							    &pmb_nr);
>  
>  			if (contiguous && pmb_nr && moved_symbol == l->s)
> -				flipped_block = (flipped_block + 1) % 2;
> +				flipped_block ^= 1;
>  			else
>  				flipped_block = 0;

This one I do not see any problem with changing, though I think it is a
matter of opinion on which is more readable (I actually tend to think of
"x = 0 - x" as idiomatic for flipping).

> diff --git a/ident.c b/ident.c
> index cc7afdbf819..188826eed63 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -459,7 +459,7 @@ const char *fmt_ident(const char *name, const char *email,
>  	int want_name = !(flag & IDENT_NO_NAME);
>  
>  	struct strbuf *ident = &ident_pool[index];
> -	index = (index + 1) % ARRAY_SIZE(ident_pool);
> +	index ^= 1;
>  
>  	if (!email) {
>  		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)

This has the same problem as the first case.

> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> index 70396fa3845..241136148a5 100644
> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -185,7 +185,7 @@ static int check_dotfile(const char *x, const char **argv,
>  	int res = 0, expect = 1;
>  	for (; *argv; argv++) {
>  		if (!strcmp("--not", *argv))
> -			expect = !expect;
> +			expect ^= 1;

This one is not wrong, but IMHO it is more clear to express negation of
a boolean using "!" (i.e., what the code is already doing).


So of the four hunks, only the second one seems like a possible
improvement, and even there I am not sure the readability is better.

-Peff
