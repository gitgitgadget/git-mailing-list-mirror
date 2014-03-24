From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/19] tree-diff: reuse base str(buf) memory on sub-tree recursion
Date: Mon, 24 Mar 2014 14:43:36 -0700
Message-ID: <xmqq61n3p913.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<301eb2377e0c5f670ffc26bda085d14dbee4f431.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:43:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCen-0000ky-9a
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbaCXVnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:43:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbaCXVnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB74755FA;
	Mon, 24 Mar 2014 17:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFIlRutserlJnKrNf9e3cSdZvGw=; b=d7NuzZ
	EiEIuoKzhA83i7VbaxPX0+XQ3zjVY1V81X/Ftk/84iRldy0Fx16FTdAHJZeCXvAz
	VHz2RPJ/XBFjHhYzgcMPx2gpjHwDg7rVZPcz9iSGr/ZqHs4ClFIiJ23v+GPmboQF
	5Xe/IIxifrXfBsCB9tDZZYRSakYwfnDdzldHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wW11PWwcgoYK0wQC631rRxe82fXTD6ds
	Qi723iKuIAub9Q0cytXFzqogkQtFUzDqr8jYfstEaVV/25dLM77lE2kr8epyZX1P
	Qh4CLLShT+wqznJ+tpZkrbTag/I/V0Pd9R94R+ZB/z6c6Dh3EA2WvifAWWvCLFWN
	UcChqQd8h24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA71755F9;
	Mon, 24 Mar 2014 17:43:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DAF3755F6;
	Mon, 24 Mar 2014 17:43:38 -0400 (EDT)
In-Reply-To: <301eb2377e0c5f670ffc26bda085d14dbee4f431.1393257006.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 24 Feb 2014 20:21:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BEB46B4-B39D-11E3-93B2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244880>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> instead of allocating it all the time for every subtree in
> __diff_tree_sha1, let's allocate it once in diff_tree_sha1, and then all
> callee just use it in stacking style, without memory allocations.
>
> This should be faster, and for me this change gives the following
> slight speedups for
>
>     git log --raw --no-abbrev --no-renames --format='%H'
>
>                 navy.git    linux.git v3.10..v3.11
>
>     before      0.618s      1.903s
>     after       0.611s      1.889s
>     speedup     1.1%        0.7%
>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
> ---
>
> Changes since v1:
>
>  - don't need to touch diff.h, as the function we are changing became static.
>
>  tree-diff.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index aea0297..c76821d 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -115,7 +115,7 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
>  	if (recurse) {
>  		strbuf_addch(base, '/');
>  		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
> -				 t2 ? t2->entry.sha1 : NULL, base->buf, opt);
> +				 t2 ? t2->entry.sha1 : NULL, base, opt);
>  	}
>  
>  	strbuf_setlen(base, old_baselen);

I was scratching my head for a while, after seeing that there does
not seem to be any *new* code added by this patch in order to
store-away the original length and restore the singleton base buffer
to the original length after using addch/addstr to extend it.

But I see that the code has already been prepared to do this
conversion.  I wonder why we didn't do this earlier ;-)

Looks good.  Thanks.

> @@ -138,12 +138,10 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
>  }
>  
>  static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
> -			    const char *base_str, struct diff_options *opt)
> +			    struct strbuf *base, struct diff_options *opt)
>  {
>  	struct tree_desc t1, t2;
>  	void *t1tree, *t2tree;
> -	struct strbuf base;
> -	int baselen = strlen(base_str);
>  
>  	t1tree = fill_tree_descriptor(&t1, old);
>  	t2tree = fill_tree_descriptor(&t2, new);
> @@ -151,17 +149,14 @@ static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
>  	/* Enable recursion indefinitely */
>  	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
>  
> -	strbuf_init(&base, PATH_MAX);
> -	strbuf_add(&base, base_str, baselen);
> -
>  	for (;;) {
>  		int cmp;
>  
>  		if (diff_can_quit_early(opt))
>  			break;
>  		if (opt->pathspec.nr) {
> -			skip_uninteresting(&t1, &base, opt);
> -			skip_uninteresting(&t2, &base, opt);
> +			skip_uninteresting(&t1, base, opt);
> +			skip_uninteresting(&t2, base, opt);
>  		}
>  		if (!t1.size && !t2.size)
>  			break;
> @@ -173,7 +168,7 @@ static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
>  			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
>  			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
>  			    (t1.entry.mode != t2.entry.mode))
> -				show_path(&base, opt, &t1, &t2);
> +				show_path(base, opt, &t1, &t2);
>  
>  			update_tree_entry(&t1);
>  			update_tree_entry(&t2);
> @@ -181,18 +176,17 @@ static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
>  
>  		/* t1 < t2 */
>  		else if (cmp < 0) {
> -			show_path(&base, opt, &t1, /*t2=*/NULL);
> +			show_path(base, opt, &t1, /*t2=*/NULL);
>  			update_tree_entry(&t1);
>  		}
>  
>  		/* t1 > t2 */
>  		else {
> -			show_path(&base, opt, /*t1=*/NULL, &t2);
> +			show_path(base, opt, /*t1=*/NULL, &t2);
>  			update_tree_entry(&t2);
>  		}
>  	}
>  
> -	strbuf_release(&base);
>  	free(t2tree);
>  	free(t1tree);
>  	return 0;
> @@ -209,7 +203,7 @@ static inline int diff_might_be_rename(void)
>  		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
>  }
>  
> -static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
> +static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, struct strbuf *base, struct diff_options *opt)
>  {
>  	struct diff_options diff_opts;
>  	struct diff_queue_struct *q = &diff_queued_diff;
> @@ -306,13 +300,19 @@ static void try_to_follow_renames(const unsigned char *old, const unsigned char
>  	q->nr = 1;
>  }
>  
> -int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
> +int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base_str, struct diff_options *opt)
>  {
> +	struct strbuf base;
>  	int retval;
>  
> -	retval = __diff_tree_sha1(old, new, base, opt);
> -	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
> -		try_to_follow_renames(old, new, base, opt);
> +	strbuf_init(&base, PATH_MAX);
> +	strbuf_addstr(&base, base_str);
> +
> +	retval = __diff_tree_sha1(old, new, &base, opt);
> +	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
> +		try_to_follow_renames(old, new, &base, opt);
> +
> +	strbuf_release(&base);
>  
>  	return retval;
>  }
