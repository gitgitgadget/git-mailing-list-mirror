From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] tree-walk: learn get_tree_enty_follow_symlinks
Date: Fri, 08 May 2015 12:26:49 -0700
Message-ID: <xmqqd22alvk6.fsf@gitster.dls.corp.google.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri May 08 21:26:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnvF-0007VH-SI
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbbEHT0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 15:26:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753038AbbEHT0w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:26:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65E604EE35;
	Fri,  8 May 2015 15:26:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBGQqFj4YFhLkdFKgUKgUb5+HLM=; b=Bu9gau
	wr4JOiISckg/7YSKeeP0mYO7GEgNuNK0dVZDLIS3R3hma3fIp01fvrMfFpAhdSiS
	EfBbUX2AXpjLk1JAQdlqFrGFuYi3KOZv6KHR1CVqyTHjBXMzqJWSLJJuotjYQzn5
	P7UNwm+R+sHIDP33a/dN0E6EWJlqbP+pHf3gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKz/dV9+uEBL0yny9ASx9i/mM+X0MD7I
	Na9MenQaQx6wldiiboyRmyWyYW7Uuo8gRUd0eIKjulyZ7x2DDMg0BJwpL+pV7i4B
	mATKebri+Pw4niLiRUTbUR5UYzn//QEMZ/tX9wsWgBefNSpU/uvhJrvy8iqbqG60
	f2sGlhfu+hk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E52C4EE34;
	Fri,  8 May 2015 15:26:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB15B4EE32;
	Fri,  8 May 2015 15:26:50 -0400 (EDT)
In-Reply-To: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Fri, 8 May 2015 14:13:37
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D29E566-F5B8-11E4-AEFB-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268648>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> Add a new function, get_tree_entry_follow_symlinks, to tree-walk.[ch].
> The function is not yet used.  It will be used to implement git
> cat-file --batch --follow-symlinks.
>
> The function locates an object by path, following symlinks in the
> repository.  If the symlinks lead outside the repository, the function
> reports this to the caller.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  tree-walk.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tree-walk.h |   2 +
>  2 files changed, 224 insertions(+)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 5dd9a71..6fb4b7d 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -415,6 +415,228 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  	return error;
>  }
>  
> +static int find_tree_entry_nonrecursive(struct tree_desc *t, char *name, unsigned char *result, unsigned *mode) {
> +	int namelen = strlen(name);
> +
> +	while (t->size) {

Why do you need an almost duplicate of existing find_tree_entry()
here?  The argument "name" above is not const, so isn't that just
the matter of the caller to temporarily replace '/' in name[] before
calling find_tree_entry() if all you wanted to avoid was to prevent
it from falling into get_tree_entry() codepath?  Or are there more
to this function?

> +#define GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS 40

Is 40 just a randomly chosen number?

I do not think 40 is particularly unreasonable, but so is 5 (which I
think is also reasonable and is already used as MAXDEPTH in refs.c
to follow symrefs), and am curious where that number came from.

> +/**
> + * Find a tree entry by following symlinks in tree_sha (which is
> + * assumed to be the root of the repository).  In the event that a
> + * symlink points outside the repository (e.g. a link to /foo or a
> + * root-level link to ../foo), the portion of the link which is
> + * outside the repository will be copied into result_path (which is
> + * assumed to hold at least PATH_MAX bytes), and *mode will be set to
> + * 0.

As the API to this new function is not constrained by existing
callers, you might want to consider using strbuf for result_path,
which would make it easier for both the callers and this function.

> +int get_tree_enty_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, unsigned char *result_path, unsigned *mode)
> +{
> +	int retval = -1;
> +	void *tree;
> +	struct dir_state *parents = NULL;
> +	size_t parents_cap = 0;
> +	ssize_t parents_len = 0;

It is customary to name variables to control an ALLOC_GROW()-managed
array 'foo' as foo_nr and foo_alloc.  Deviating from the convention
makes the patch harder to read by people who are familiar with it
without any benefit, and those who are familiar with the existing
code are the people you want your patch reviewed by.

I am context-switching now; will review the remainder some other
time.

Thanks.
