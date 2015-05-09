From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] tree-walk: learn get_tree_entry_follow_symlinks
Date: Fri, 08 May 2015 22:00:17 -0700
Message-ID: <xmqqzj5egxb2.fsf@gitster.dls.corp.google.com>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat May 09 07:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqwss-0003oF-KL
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 07:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbbEIFAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 01:00:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbbEIFAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2015 01:00:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D075449542;
	Sat,  9 May 2015 01:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q9KRNt5NDD0y1RXepzfx0R3mqI4=; b=MH9Lc7
	NExeywIcxmYj0Hde3MYN3brpzUQfrmCk1ycAU+xEaZs/5zjqYj1z5oCGOhxOhH5Q
	FYu1DFdy8o+JnT/7+25xqJyWPri6obm6pN2IisgZG0TcunIXaI32nlKhoqnXG/ej
	61SgIEZYSuyUQJxwduyTo5tlMbl7aQRMZUz+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JibE0NmfRrpdAfnJ7H6e++tJ/sYNfhhO
	9wRSSOGHQg6smxyMfsMWOhHDEo5hzLOnL1RfH0SyxrWEHK7li85ygTCvNe4yUS23
	QYXcC1V1AGbXbLmHwr8i4bREzNpREr/88vCGS0JBV/NheW0J5vncNwmZQ+2JafI3
	8yFrkqqwyi0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C917249541;
	Sat,  9 May 2015 01:00:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1803B4953F;
	Sat,  9 May 2015 01:00:19 -0400 (EDT)
In-Reply-To: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Fri, 8 May 2015 18:38:44
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A17763E-F608-11E4-A062-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268698>

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
>  tree-walk.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tree-walk.h |   2 +
>  2 files changed, 195 insertions(+)

Overall this looks fairly straight-forward and much cleaner than I
feared it would end up to be.

	Side Note: Earlier I stupidly thought that it may have to
	involve ugly code to avoid penalizing common cases by first
	attempting to resolve the whole thing (e.g. a/b/c) and fall
	back to "is there any symbolic link?" codepath only after
	seeing it fail (i.e. if we can find "a/b/c" in the tree, by
	definition "a/" and "a/b/" cannot be a symbolic link).  But
	of course that is a silly thought. As this implementation
	makes it clear, for us to resolve "a/b/c" in the common case
	without symbolic link, we need to incrementally find "a" in
	the root, then find "b" in that "a", and then find "c" in
	"a/b" _anyway_.



I'll leave others (or maybe tomorrow's myself ;-) to nitpick on
styles, code layout and possibly logic errors (if any), but from
a cursory read, I like the general structure of this patch a lot.

Good job.

Thanks.

> diff --git a/tree-walk.c b/tree-walk.c
> index 5dd9a71..2df31a2 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -415,6 +415,12 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  	return error;
>  }
>  
> +struct dir_state {
> +	void *tree;
> +	unsigned long size;
> +	unsigned char sha1[20];
> +};
> +
>  static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
>  {
>  	int namelen = strlen(name);
> @@ -478,6 +484,193 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
>  	return retval;
>  }
>  
> +/* This is Linux's built-in max for the number of symlinks to follow.
> + * That limit, of course, does not affect git, but it's a reasonable
> + * choice.
> + */
> +#define GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS 40
> +
> +/**
> + * Find a tree entry by following symlinks in tree_sha (which is
> + * assumed to be the root of the repository).  In the event that a
> + * symlink points outside the repository (e.g. a link to /foo or a
> + * root-level link to ../foo), the portion of the link which is
> + * outside the repository will be copied into result_path, and *mode
> + * will be set to 0.  Otherwise, result will be filled in with the
> + * sha1 of the found object, and *mode will hold the mode of the
> + * object.
> + */
> +int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, unsigned char *result_path, unsigned *mode)
> +{
> +	int retval = -1;
> +	void *tree;
> +	struct dir_state *parents = NULL;
> +	size_t parents_alloc = 0;
> +	ssize_t parents_nr = 0;
> +	unsigned long size;
> +	unsigned char root[20];
> +	unsigned char current_tree_sha1[20];
> +	struct strbuf namebuf = STRBUF_INIT;
> +	enum object_type type;
> +	int already_have_tree = 0;
> +	struct tree_desc t = {0};
> +	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
> +	int i;
> +
> +	strbuf_addstr(&namebuf, name);
> +	hashcpy(current_tree_sha1, tree_sha1);
> +
> +	while (1) {
> +		char *first_slash;
> +		char *remainder = NULL;
> +		int find_result;
> +
> +		if (!t.buffer) {
> +			tree = read_object_with_reference(current_tree_sha1,
> +							  tree_type, &size,
> +							  root);
> +			if (!tree)
> +				goto done;
> +
> +			ALLOC_GROW(parents, parents_nr + 1, parents_alloc);
> +			parents[parents_nr].tree = tree;
> +			parents[parents_nr].size = size;
> +			hashcpy(parents[parents_nr].sha1, root);
> +
> +			parents_nr++;
> +
> +			if (namebuf.buf[0] == '\0') {
> +				hashcpy(result, root);
> +				retval = 0;
> +				goto done;
> +			}
> +
> +			if (!size)
> +				goto done;
> +
> +			/* descend */
> +			init_tree_desc(&t, tree, size);
> +		}
> +
> +		/* Handle symlinks to e.g. a//b by removing leading slashes */
> +		while (namebuf.buf[0] == '/') {
> +			strbuf_remove(&namebuf, 0, 1);
> +		}
> +
> +		/* Split namebuf into a first component and a
> +		 * remainder */
> +		if ((first_slash = strchr(namebuf.buf, '/'))) {
> +			*first_slash = 0;
> +			remainder = first_slash + 1;
> +		}
> +
> +		if (!strcmp(namebuf.buf, "..")) {
> +			struct dir_state *parent;
> +			/* We could end up with .. in the namebuf if
> +			 * it appears in a symlink. */
> +
> +			if (parents_nr == 1) {
> +				if (remainder)
> +					*first_slash = '/';
> +				if (strlcpy(result_path, namebuf.buf,
> +					    PATH_MAX) < PATH_MAX) {
> +					*mode = 0;
> +					retval = 0;
> +				}
> +				goto done;
> +			}
> +			parent = &parents[parents_nr - 1];
> +			free(parent->tree);
> +			parents_nr--;
> +			parent = &parents[parents_nr - 1];
> +			init_tree_desc(&t, parent->tree, parent->size);
> +			strbuf_remove(&namebuf, 0, remainder ? 3 : 2);
> +			continue;
> +		}
> +
> +		/* We could end up here via a symlink to dir/.. */
> +		if (namebuf.buf[0] == '\0') {
> +			hashcpy(result, parents[parents_nr - 1].sha1);
> +			retval = 0;
> +			goto done;
> +		}
> +
> +		/* Look up the first (or only) path component
> +		 * in the tree. */
> +		find_result = find_tree_entry(&t, namebuf.buf,
> +					      current_tree_sha1, mode);
> +		if (find_result) {
> +			retval = find_result;
> +			goto done;
> +		}
> +
> +		if (S_ISDIR(*mode)) {
> +			if (!remainder) {
> +				hashcpy(result, current_tree_sha1);
> +				retval = 0;
> +				goto done;
> +			}
> +			/* Descend the tree */
> +			t.buffer = NULL;
> +			strbuf_remove(&namebuf, 0,
> +				      1 + first_slash - namebuf.buf);
> +		} else if (S_ISREG(*mode)) {
> +			if (!remainder) {
> +				hashcpy(result, current_tree_sha1);
> +				retval = 0;
> +			}
> +			goto done;
> +		} else if (S_ISLNK(*mode)) {
> +			/* Follow a symlink */
> +			size_t link_len, len;
> +			char *contents, *contents_start;
> +			struct dir_state *parent;
> +
> +			if (follows_remaining-- == 0)
> +				/* Too many symlinks followed */
> +				goto done;
> +
> +			contents = read_sha1_file(current_tree_sha1, &type,
> +						  &link_len);
> +
> +			if (!contents)
> +				goto done;
> +
> +			if (contents[0] == '/') {
> +				if (strlcpy(result_path,
> +					    contents, PATH_MAX) < PATH_MAX) {
> +					*mode = 0;
> +					retval = 0;
> +				}
> +				goto done;
> +			}
> +
> +			if (remainder)
> +				len = first_slash - namebuf.buf;
> +			else
> +				len = namebuf.len;
> +
> +			contents_start = contents;
> +
> +			parent = &parents[parents_nr - 1];
> +			init_tree_desc(&t, parent->tree, parent->size);
> +			strbuf_splice(&namebuf, 0, len,
> +				      contents_start, link_len);
> +			if (remainder)
> +				namebuf.buf[link_len] = '/';
> +			free(contents);
> +		}
> +	}
> +done:
> +	for (i = 0; i < parents_nr; ++i) {
> +		free(parents[i].tree);
> +	}
> +	free(parents);
> +
> +	strbuf_release(&namebuf);
> +	return retval;
> +}
> +
>  static int match_entry(const struct pathspec_item *item,
>  		       const struct name_entry *entry, int pathlen,
>  		       const char *match, int matchlen,
> diff --git a/tree-walk.h b/tree-walk.h
> index ae7fb3a..d9ad768 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -40,6 +40,8 @@ struct traverse_info;
>  typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
>  int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
>  
> +int get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, unsigned char *result_path, unsigned *mode);
> +
>  struct traverse_info {
>  	struct traverse_info *prev;
>  	struct name_entry name;
