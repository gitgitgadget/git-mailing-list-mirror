Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578546B3
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PMyvv/BE"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990563C15
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:48:48 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2573836849;
	Fri, 10 Nov 2023 23:48:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3Pg3Z4xM/FHiU8Uo6b+dfh0LKdghmINlhKSGHH
	7bshs=; b=PMyvv/BEJIX+YxqND5k/vd9kHrDSl+QOjsFSZk13ibSRziLzxMul68
	pWxUzQBqx7WwDhDzCw8+JGc9Ec18jlFzJcXO9cvqibf2vPzBp8cPl9MJxbgM4CFJ
	VX7XiOJmZCwFzGq7Iuv3ULYiWGaDAsfMnFkIZgtwZpH2PydA1zOk0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BB6436847;
	Fri, 10 Nov 2023 23:48:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB9DC36842;
	Fri, 10 Nov 2023 23:48:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: add native file mode values support
In-Reply-To: <20231111040309.2848560-1-jojwang@google.com> (Joanna Wang's
	message of "Sat, 11 Nov 2023 04:03:08 +0000")
References: <20231111040309.2848560-1-jojwang@google.com>
Date: Sat, 11 Nov 2023 13:48:43 +0900
Message-ID: <xmqqpm0grj2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 98114292-804D-11EE-A13F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Joanna Wang <jojwang@google.com> writes:

> +/*
> + * This implements native file mode attr support.
> + * We always return the current mode of the path, not the mode stored
> + * in the index, unless the path is a directory where we check the index
> + * to see if it is a GITLINK. It is ok to rely on the index for GITLINK
> + * modes because a path cannot become a GITLINK (which is a git concept only)
> + * without having it indexed with a GITLINK mode in git.
> + */
> +static unsigned int native_mode_attr(struct index_state *istate, const char *path)
> +{
> +	struct stat st;
> +	unsigned int mode;

Please have a blank line here between decls and the first statement.

> +	if (lstat(path, &st))
> +		die_errno(_("unable to stat '%s'"), path);

For checking in, this is probably OK, but don't we need to switch
between lstat() on the filesystem entity and inspecting ce_mode()
for the in-index cache_entry, depending on the git_attr_direction?

> +	mode = canon_mode(st.st_mode);
> +	if (S_ISDIR(mode)) {
> +		int pos = index_name_pos(istate, path, strlen(path));
> +		if (pos >= 0)
> +			if (S_ISGITLINK(istate->cache[pos]->ce_mode))
> +				return istate->cache[pos]->ce_mode;

Even if we assume that this code is currently meant to work only
with GIT_ATTR_CHECKIN, I do not think this is what you want.  When
asked to perform "git add . ':(exclude,mode=160000)'", you not only
want to exclude the submodules that are already known to this
superproject, but also a repository that _can_ become a submodule of
this superproject when added, no?  You are missing "if (pos < 0)"
case where you'd probably want to see if the directory at the path
looks like the top of a working tree with ".git" subdirectory that
is a valid repository, or something like that to detect such a case.

On the other hand, the GIT_ATTR_CHECKOUT direction is hopefully much
simpler.  You'd see what the path in the index is, among a gitlink,
a regular non-executable file, an executable file, or a symlink.

> +	}
> +	return mode;
> +}
> +
> +
>  void git_check_attr(struct index_state *istate,
>  		    const char *path,
>  		    struct attr_check *check)
>  {
>  	int i;
>  	const struct object_id *tree_oid = default_attr_source();
> +	struct strbuf sb = STRBUF_INIT;
>  
>  	collect_some_attrs(istate, tree_oid, path, check);
>  
>  	for (i = 0; i < check->nr; i++) {
>  		unsigned int n = check->items[i].attr->attr_nr;
>  		const char *value = check->all_attrs[n].value;
> -		if (value == ATTR__UNKNOWN)
> -			value = ATTR__UNSET;
> +		if (value == ATTR__UNKNOWN){

Style.  Missing SP between "){".

> +			if (strcmp(check->all_attrs[n].attr->name, "mode") == 0) {

Style.  We avoid comparison with 0; so say

			if (!strcmp(check->all_attrs[n].attr->name, "mode") == 0) {

instead.

It is disturbing that we always need to perform a string comparison
in this loop (and the function is called repeatedly while traversing
the tree looking for paths that match pathspec).  The attribute objects
are designed to be interned, so at least you should be able to do

	mode_attr = git_attr("mode");

before the loop and then compare check->all_attrs[n].attr and
mode_attr as two addresses.

> +				/*
> +				 * If value is ATTR_UNKNOWN then it has not been set
> +				 * anywhere with -mode (ATTR_FALSE), !mode (ATTR_UNSET),
> +				 * mode (ATTR_TRUE), or an explicit value. We fill
> +				 * value with the native mode value.
> +				 */
> +				strbuf_addf(&sb, "%06o", native_mode_attr(istate, path));
> +				value = sb.buf;

Or even better yet, as this is not a place to write too many lines
for a single oddball attribute, it might make even more sense to
introduce a helper function and make a call to it like so:

		if (value == ATTR__UNKNOWN)
-			value = ATTR__UNSET;
+			value = compute_attr_from_path(istate, path, check_items[i].attr);

with the new helper function do all the heavy lifting, e.g.,

	static const char *compute_attr_from_path(struct index_state *istate,
						  const char *path,
						  const struct git_attr *attr) {
		static struct git_attr mode_attr;

		if (!mode_attr)
			mode_attr = git_attr("mode");

		if (attr == mode_attr) {
			call native_mode_attr(), stringify, and
			return it;
		}
		return ATTR__UNSET;
	}

which will allow us to easily add in the future special attribute
similar to "mode" whose fallback value is computed.

Otherwise, looking pretty good.  Thanks for working on this.
