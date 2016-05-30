From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 14:52:41 +0200
Message-ID: <vpqlh2remhy.fsf@anie.imag.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 14:52:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Mge-00012s-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 14:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbcE3Mwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 08:52:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45544 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541AbcE3Mws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 08:52:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4UCqdWW008150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 14:52:40 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UCqfUK003691;
	Mon, 30 May 2016 14:52:41 +0200
In-Reply-To: <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 30 May 2016 12:36:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 30 May 2016 14:52:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UCqdWW008150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465217561.25145@NOqHmasRmGtQtEhdJ8ThIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295891>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> multiple threads. Those limitations prevent strbuf to be used in

prevent strbuf from being used ...

> API ENHANCEMENT
> ---------------
>
> All functions of the API can still be reliably called without
> knowledge of the initialization (normal/preallocated/fixed) with the
> exception that strbuf_grow() may die() if the string try to overflow a

s/try/tries/

> @@ -20,16 +28,37 @@ char strbuf_slopbuf[1];
>  
>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
> +	sb->flags = 0;
>  	sb->alloc = sb->len = 0;
>  	sb->buf = strbuf_slopbuf;
>  	if (hint)
>  		strbuf_grow(sb, hint);
>  }

If you set flags = 0 here, existing callers will have all flags off,
including OWNS_MEMORY.

I *think* this is OK, as sb->buf is currently pointing to
strbuf_slopbuf, which the the strbuf doesn't own. But that is too subtle
to go without an explanatory comment IMHO.

Also, doesn't this make the "new_buf" case useless in strbuf_grow?

With your patch, the code looks like:

void strbuf_grow(struct strbuf *sb, size_t extra)
{
	int new_buf = !sb->alloc;
...
	if (sb->flags & STRBUF_OWNS_MEMORY) {
		if (new_buf) // <---------------------------------------- (1)
			sb->buf = NULL;
		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
	} else {
		/*
		 * The strbuf doesn't own the buffer: to avoid to realloc it,
		 * the strbuf needs to use a new buffer without freeing the old
		 */
		if (sb->len + extra + 1 > sb->alloc) {
			size_t new_alloc = MAX(sb->len + extra + 1, alloc_nr(sb->alloc));
			char *buf = xmalloc(new_alloc);
			memcpy(buf, sb->buf, sb->alloc);
			sb->buf = buf;
			sb->alloc = new_alloc;
			sb->flags |= STRBUF_OWNS_MEMORY;
		}
	}

	if (new_buf) // <---------------------------------------- (2)
		sb->buf[0] = '\0';
}

I think (1) is now dead code, since sb->alloc == 0 implies that
STRBUF_OWNS_MEMORY is set. (2) seems redundant since you've just
memcpy-ed the existing '\0' into the buffer.

> +void strbuf_wrap_preallocated(struct strbuf *sb, char *path_buf,
> +			      size_t path_buf_len, size_t alloc_len)
> +{
> +	if (!path_buf)
> +		die("you try to use a NULL buffer to initialize a strbuf");
> +
> +	strbuf_init(sb, 0);
> +	strbuf_attach(sb, path_buf, path_buf_len, alloc_len);
> +	sb->flags &= ~STRBUF_OWNS_MEMORY;
> +	sb->flags &= ~STRBUF_FIXED_MEMORY;
> +}

strbuf_wrap_preallocated seem very close to strbuf_attach. I'd rather
see a symmetric code sharing like

void strbuf_attach_internal(struct strbuf *sb, ..., unsigned int flags)

and then strbuf_attach() and strbuf_wrap_preallocated() become
straightforward wrappers around it.

This would avoid setting and then unsetting STRBUF_OWNS_MEMORY (the
performance impact is probably small, but it looks weird to set the flag
and then unset it right away).

After your patch, there are differences between
strbuf_wrap_preallocated() which I think are inconsistencies:

* strbuf_attach() does not check for NULL buffer, but it doesn't accept
  them either if I read correctly. It would make sense to add the check
  to strbuf_attach(), but it's weird to have the performance-critical
  oriented function do the expensive stuff that the
  non-performance-critical one doesn't.

* strbuf_attach() calls strbuf_release(), which allows reusing an
  existing strbuf. strbuf_wrap_preallocated() calls strbuf_init which
  would override silently any previous content. I think strbuf_attach()
  does the right thing here.

  (And I'm probably the one who misguided you to do this)

  In any case, you probably want to include calls to strbuf_attach() and
  strbuf_wrap_*() functions on existing non-empty strbufs.

> +void strbuf_wrap_fixed(struct strbuf *sb, char *path_buf,
> +		       size_t path_buf_len, size_t alloc_len)
> +{
> +	strbuf_wrap_preallocated(sb, path_buf, path_buf_len, alloc_len);
> +	sb->flags |= STRBUF_FIXED_MEMORY;
> +}

And this could become a 3rd caller of strbuf_attach_internal().

> @@ -61,9 +96,32 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>  	if (unsigned_add_overflows(extra, 1) ||
>  	    unsigned_add_overflows(sb->len, extra + 1))
>  		die("you want to use way too much memory");
> -	if (new_buf)
> -		sb->buf = NULL;
> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	if ((sb->flags & STRBUF_FIXED_MEMORY) && sb->len + extra + 1 > sb->alloc)
> +		die("you try to make a string overflow the buffer of a fixed strbuf");
> +
> +	/*
> +	 * ALLOC_GROW may do a realloc() if needed, so we must not use it on
> +	 * a buffer the strbuf doesn't own
> +	 */
> +	if (sb->flags & STRBUF_OWNS_MEMORY) {
> +		if (new_buf)
> +			sb->buf = NULL;
> +		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	} else {
> +		/*
> +		 * The strbuf doesn't own the buffer: to avoid to realloc it,
> +		 * the strbuf needs to use a new buffer without freeing the old
> +		 */
> +		if (sb->len + extra + 1 > sb->alloc) {
> +			size_t new_alloc = MAX(sb->len + extra + 1, alloc_nr(sb->alloc));
> +			char *buf = xmalloc(new_alloc);
> +			memcpy(buf, sb->buf, sb->alloc);

I think you want to memcpy only sb->len + 1 bytes. Here, you're
memcpy-ing the allocated-but-not-initialized part of the array.

xmemdupz can probably simplify the code too (either you include the '\0'
in what memcpy copies, or you let xmemdupz add it).

> +/**
> + * Allow the caller to give a pre-allocated piece of memory for the strbuf
> + * to use. It is possible then to strbuf_grow() the string past the size of the
> + * pre-allocated buffer: a new buffer will be allocated. The pre-allocated

To make it clearer: "a new buffer will then be allocated"?

> +/**
> + * Allow the caller to give a pre-allocated piece of memory for the strbuf
> + * to use and indicate that the strbuf must use exclusively this buffer,
> + * never realloc() it or allocate a new one. It means that the string can
> + * be manipulated but cannot overflow the pre-allocated buffer. The
> + * pre-allocated buffer will never be freed.
> + */

Perhaps say explicitly that although the allocated buffer has a fixed
size, the string itself can grow as long as it does not overflow the
buffer?

> @@ -91,6 +116,8 @@ extern void strbuf_release(struct strbuf *);
>   * Detach the string from the strbuf and returns it; you now own the
>   * storage the string occupies and it is your responsibility from then on
>   * to release it with `free(3)` when you are done with it.
> + * Must allocate a copy of the buffer in case of a preallocated/fixed buffer.
> + * Performance-critical operations have to be aware of this.

Better than just warn about performance, you can give the alternative.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
