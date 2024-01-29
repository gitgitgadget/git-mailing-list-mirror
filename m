Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FE6F077
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552843; cv=none; b=fErfZWJ3WgyiP4aFp8LLhFoAiVI7eVo1dGPME6VtAJDEUHpBFt7/d2PyR6qSTCdqQX1SM/X3ebdgeQp8CAkwv5Le7VheNKSqAFYevKIBr4ic+iSzSEsN/lF9CSPm2HdzGZD38KehA3wLCzt42S9Yt/sBAmovFXK2djVRAB3M6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552843; c=relaxed/simple;
	bh=5y9Tufg5RU6HOH2/F/yOYc0kQPlihBBhz29D/WTwJvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJ7UX75wnybiGHOfAV6IijVIC+mVG9x6H4sh64X1H79S1fQN4J0/BayG/TSBlp2FEhlr1XLsj4FiZqFi3plM3HQkoNmKZV4/aVQJlNFyycCxKO7aHdCuWXT4Q4ETmfHa6I4fqSjQEjiloatuDDVggJJI+gW7fgzuY3LbhwLicRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=e7npcHD6; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="e7npcHD6"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 132D42068B;
	Mon, 29 Jan 2024 13:27:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5y9Tufg5RU6HOH2/F/yOYc0kQPlihBBhz29D/W
	TwJvs=; b=e7npcHD6hDxsoeDPm3YOfzosn+gckt6+gEusVT6kSDA/ekqB4obWTN
	BT19hj4CbH10L11asUZfGocUCZmTdDxI1jLOGET/FbN0k7K+b1ggZfW2jJXb/hZ1
	MAznWE6JYB3T0x9blEfIXwSit5xnzN8aE3CBEcMzHJWr2wXY9kr6w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BED02068A;
	Mon, 29 Jan 2024 13:27:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 947E220687;
	Mon, 29 Jan 2024 13:27:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] add-patch: compare object id instead of literal
 string
In-Reply-To: <20240128181202.986753-3-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sun, 28 Jan 2024 23:41:22 +0530")
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
	<20240128181202.986753-3-shyamthakkar001@gmail.com>
Date: Mon, 29 Jan 2024 10:27:10 -0800
Message-ID: <xmqqmssohu69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 04B2EA76-BED4-11EE-A958-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Add a new function reveq(), which takes repository struct and two revision
> strings as arguments and returns 0 if the revisions point to the same
> object. Passing a rev which does not point to an object is considered
> undefined behavior as the underlying function memcmp() will be called
> with NULL hash strings.

I didn't dug into the patch or the codepath it touches, but
I wonder if it has something (possibly historical) to do with the
fact that these two behave quite differently:

    $ git checkout HEAD
    $ git checkout HEAD^0

With the former, you will stay on your current branch, while with
the latter you detach at the commit at the tip of your current
branch.  Granted that "git checkout -p" is not about moving HEAD but
checking out some files to the worktree from a given tree-ish, anytime
I see code that does strcmp() with a fixed "HEAD" string, that is
one consideration I'd look for.

> Should the return values of repo_get_oid() be checked in reveq()? As
> reveq() is not a global function and is only used in run_add_p(), the
> validity of revisions is already checked beforehand by builtin/checkout.c
> and builtin/reset.c before the call to run_add_p().

If this were to become a public function (even if it somehow turns
out that it is a bad idea to move away from an explicit comparison
with "HEAD", introducing such a function might be useful---I dunno),
it probably makes sense not to burden its potential callers with too
many assumption.  But doesn't the fact that the immediate callers
you are introducing already checked the validity of the revisions
tell us something?  Would it result in us not needing this new
helper function at all, if we rearranged the code that already
checks the validity so that the actual object names are collected?
Then it would become the matter of running oideq() directly on these
object names, instead of calling a new helper function that
(re)converts from strings to object names and compares them.

> +// Check if two revisions point to the same object. Passing a rev which does not
> +// point to an object is undefined behavior.

Style:

    /*
     * Our multi-line comments look
     * like this.
     */

> +static inline int reveq(struct repository *r, const char *rev1,
> +			const char *rev2)
> +{
> +	struct object_id oid_rev1, oid_rev2;
> +	repo_get_oid(r, rev1, &oid_rev1);
> +	repo_get_oid(r, rev2, &oid_rev2);
> +
> +	return !oideq(&oid_rev1, &oid_rev2);

Horribly confusing.  If oideq() says "yes, they are the same" by
returning 0, then any helper function derived from it to ansewr "are
X and Y the same?" should return 0 when it wants to say "yes, they
are the same" to help developers keep their sanity.

> +}
> +
>  static int parse_range(const char **p,
>  		       unsigned long *offset, unsigned long *count)
>  {
> @@ -1730,28 +1743,25 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  		s.mode = &patch_mode_stash;
>  	else if (mode == ADD_P_RESET) {
>  		/*
> -		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
> -		 * compare the commit objects instead so that other ways of
> -		 * saying the same thing (such as "@") are also handled
> -		 * appropriately.
> -		 *
> -		 * This applies to the cases below too.
> +		 * The literal string comparison to HEAD below is kept
> +		 * to handle unborn HEAD.
>  		 */

So, does this change solve the NEEDSWORK comment?  On an unborn
HEAD, this would still not allow you to say "@".  Only "HEAD" is
supported.

Not that I necessarily agree with the original "NEEDSWORK" comment
(I think it is perfectly fine for this or any other codepaths not to
take "@" as "HEAD"), but if that desire still stands here, should
the resulting comment still mention it with a NEEDSWORK label?

Besides ...

> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> index 747eb5563e..431f34fa9c 100755
> --- a/t/t2016-checkout-patch.sh
> +++ b/t/t2016-checkout-patch.sh
> @@ -12,6 +12,7 @@ test_expect_success 'setup' '
>  	git commit -m initial &&
>  	test_tick &&
>  	test_commit second dir/foo head &&
> +	git branch newbranch &&
>  	set_and_save_state bar bar_work bar_index &&
>  	save_head
>  '
> +# Note: 'newbranch' points to the same commit as HEAD. And it is technically
> +# allowed to name a branch '@' as of now, however in below test '@'
> +# represents the shortcut for HEAD.
> +for opt in "HEAD" "@" "newbranch"
> +do
> +	test_expect_success "git checkout -p $opt with NO staged changes: abort" '
> +		set_and_save_state dir/foo work head &&
> +		test_write_lines n y n | git checkout -p $opt >output &&
> +		verify_saved_state bar &&
> +		verify_saved_state dir/foo &&
> +		test_grep "Discard" output
> +	'

I think this change in behaviour, especially for "newbranch" that
used to use the "_nothead" variants of directions and messages, is
way too confusing.  Users may consider "HEAD" and "@" the same and
may want them to behave the same way, but the user, when explicitly
naming "newbranch", means they want to "check contents out of that
OTHER thing named 'newbranch', not the current branch"; it may or
may not happen to be pointing at the same commit as HEAD, but if
the user meant to say "check contents out of the current commit,
(partially) reverting the local changes I have", the user would have
said HEAD.  After all, the user may not even be immediately aware
that "newbranch" happens to point at the same commit as HEAD.

So, after thinking about it a bit more, I do not think I agree with
the NEEDSWORK comment.  I can buy "@", but not an arbitrary revision
name that happens to point at the same commit as HEAD.  In other
words, I may be persuaded to thinking into it is a good idea to add:

    static inline int user_means_HEAD(const char *a)
    {
	return !strcmp(a, "HEAD") || !strcmp(a, "@");
    }

and replace "!strcmp(rev, "HEAD")" with "user_means_HEAD(rev)", but
I would not go any further than that.

Thanks.



