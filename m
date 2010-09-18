From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] convert: fix normalization of foreign idents
Date: Sat, 18 Sep 2010 14:31:47 -0700
Message-ID: <7v8w2yzqkc.fsf@alter.siamese.dyndns.org>
References: <cover.1284820251.git.marcus@mc.pp.se>
 <b56d7f50198f63a810b304ae77043f58a240f743.1284820251.git.marcus@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Sat Sep 18 23:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox51N-000591-B9
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 23:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab0IRVcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 17:32:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab0IRVcN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 17:32:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C0CBD7E05;
	Sat, 18 Sep 2010 17:32:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPrnlXMhwQl8Py2r0xq+1mMXItk=; b=uSO+Ts
	RRaoa0Hf1b/cCxWgdlCQP40K5AmfENEgpzRYj76tSzetN1RlbgbTrwaY4qUBkZOK
	enWgHmuPwt5zM/BPtU95z+lP3hmfgw78OBvMPb9sT8K0n7iux8+ITbIlu3IVdr8F
	fph/cEbo9aWf0VjiPtkDRdbvcRPuzLBsJzumk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iZRKlWJ9IGNW1vwaqsZYrsn548uGt0Wy
	EacQzOPrTq1M/Hmuj3HkxPf1P4sKDBfFPspw84BcVcjjB1JFCoP3FtYr7seAul7L
	QDGXPpUN7YmYFBOTcs+h5sYvkaDrb7J9mMus41tE9hN2wk9oDCfBqZ83020uaADu
	P+OXq8M+6qM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5973AD7DFD;
	Sat, 18 Sep 2010 17:32:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD63DD7DE5; Sat, 18 Sep
 2010 17:31:48 -0400 (EDT)
In-Reply-To: <b56d7f50198f63a810b304ae77043f58a240f743.1284820251.git.marcus@mc.pp.se>
 (Marcus Comstedt's message of "Mon\, 23 Aug 2010 09\:05\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 312DD3D0-C36C-11DF-BF2A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156475>

Marcus Comstedt <marcus@mc.pp.se> writes:

> Since ident_to_worktree() does not touch $Id$ tags which contain
> foreign expansions in the repository, make sure that ident_to_git()
> does not either.

Thanks.

> There is however one case where we want ident_to_git() to normalize
> the tag to $Id$ despite the asymmetry...

I'd actually think that is a bad idea.  The user _can_ choose to do so by
removing the stale part from '$Id: obsolate garbage$", of course.  Or we
can always normalize, which _might_ turn out to be a better solution.  In
either case, it would be better to be consistent.

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 638e7be..fe8d638 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1932,7 +1932,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
>  	case S_IFREG:
>  		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
>  			return error("unable to open or read %s", path);
> -		convert_to_git(path, buf->buf, buf->len, buf, CHECKS_DISALLOWED);
> +	        convert_to_git(path, buf->buf, buf->len, buf, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);

In order to apply a patch to a file in the working tree, we first need to
read it, and this codepath is the place to do so.  The file in the working
tree may be "smudged" (in the sense of smudge/clean filter) and we "clean"
it so that we can compare and update with what we read from the patch (the
patch text is expected to be always "clean").

We don't check "safe-crlf", as it can "die" if it is allowed to when
check_safe_clrf() finds things it does not like.

We expect to write the result out to the working tree, and at that point
we will run convert_to_working_tree().  The result can also be added to
the index after we are done.  The resulting index may be used to create
the next commit.  Why "for compare" and not "for commit"?

If you get a patch to a file that contains a line with an ident, either as
a context or old line.  Both your working tree file and your index would
have "$Id: stale garbage$".

A patch may have

 - "$Id: stale garbage$" (made against the identical foreign source),
 - "$Id: updated garbage$" (made against an updated foreign source), or
 - "$Id$": (made against a conversion to git done elsewhere).

By telling git not to normalize "$Id: stale garbage$" you have, aren't you
making the patch made not to apply 2 out of 3 above cases, especially if
it came from your git friends (the last one)?

This patch doesn't touch "apply --cached" at all, which introduces yet
more unnecessary inconsistency.  If you made changes to the index through
that codepath, shouldn't the resulting object lose the $Id: stale garbage$
somewhere before it is made into the next commit?

My gut feeling is that this kind of complications aren't worth it.  If we
were to address the $Id$ issue, I wonder if we can fix it the other way
around, by making both directions always convert (i.e. ident_to_worktree()
and ident_to_git()); the end result of such a change feels much simpler to
explain to the users.

Anyway, let's continue reading your patch.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 850e165..8d8cbf3 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2095,7 +2095,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		if (strbuf_read(&buf, 0, 0) < 0)
>  			die_errno("failed to read from stdin");
>  	}
> -	convert_to_git(path, buf.buf, buf.len, &buf, CHECKS_DISALLOWED);
> +	convert_to_git(path, buf.buf, buf.len, &buf, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);

Not questionable.  We are "read-only".

> diff --git a/cache.h b/cache.h
> index 250abc1..3010e20 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -586,6 +586,11 @@ enum allow_checks {
>  	CHECKS_ALLOWED = 1,
>  };
>  
> +enum normalize_mode {
> +        NORMALIZE_FOR_COMPARE = 0,
> +	NORMALIZE_FOR_COMMIT = 1,
> +};

Funny use of whitespaces.

> diff --git a/combine-diff.c b/combine-diff.c
> index c7f132d..e36bf61 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -758,7 +758,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  			if (is_file) {
>  				struct strbuf buf = STRBUF_INIT;
>  
> -				if (convert_to_git(elem->path, result, len, &buf, CHECKS_ALLOWED)) {
> +				if (convert_to_git(elem->path, result, len, &buf, CHECKS_ALLOWED, NORMALIZE_FOR_COMPARE)) {

Not questionable.  We are "read-only".

> @@ -797,5 +810,5 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
>  		src = dst->buf;
>  		len = dst->len;
>  	}
> -	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED);
> +	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);

This is called from merge operation to read from the object store, and
apply double-conversion (first from git to working tree and then back to
git).  But the result is written out as an object and hopefully be
recorded as a merge commit.  Why "for compare"?  We would want a normalized
result, no?

> diff --git a/diff.c b/diff.c
> index ed74f6b..eebe3dd 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2375,7 +2375,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
>  		/*
>  		 * Convert from working tree format to canonical git format
>  		 */
> -		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED)) {
> +		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED, NORMALIZE_FOR_COMPARE)) {

This feels wrong.  This is a "read-only" access just like combine-diff and
blame one.  I think CHECKS_ALLOWED is probably a bug in the original.
There is no reason to complain against what you haven't added.

> diff --git a/sha1_file.c b/sha1_file.c
> index 13624a6..cbebb75 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2434,7 +2434,8 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
>  	if ((type == OBJ_BLOB) && path) {
>  		struct strbuf nbuf = STRBUF_INIT;
>  		if (convert_to_git(path, buf, size, &nbuf,
> -		                   write_object ? CHECKS_ALLOWED : CHECKS_DISALLOWED)) {
> +		                   write_object ? CHECKS_ALLOWED : CHECKS_DISALLOWED,
> +				   write_object ? NORMALIZE_FOR_COMMIT : NORMALIZE_FOR_COMPARE)) {

Although I can sort-of see why Steffen wanted to allow the former less
strict in these two commands:

    git hash-object <foo
    git hash-object -w <foo

the code now says that they will produce different results, which feels
utterly wrong.

I was hoping that from this patch a simple pattern, a correlation between
the two conversion tweak flags you now have, would emerge[*1*].  And
indeed it looks like it does.

If we fix the potential bug in diff_populate_filespec(), we see that
checkcrlf==0 goes hand in hand with "for compare".  The meaning of both
option is "Are we in read-only codepath?"[*2*] and both conversion filters
change their behaviour based on that single bit.

But the "for compare"/"for commit" we looked at during this review may
probably have to change, and in the end it may not be a simple matter of
"if we are writing we convert this way, but if we are reading we convert
that other way".  My gut feeling is still that if we want consistency, we
should just always convert, not the other way around, though.


[footnote]

*1* By the way, as I already said, I do not like adding more and more
conversion tweak flags (it makes it even more distasteful that this patch
does so especially to support a check-box "feature" like ident).

*2* That is the kind of option that specifies what it _means_, not what or
how it does, I suggested you to think about in the first round of review.
"Do we allow checks?" wasn't the kind of a meaningful option I was hoping
to see; we would want the code to clarify _why_ we allow or forego checks
at individual callsites.
