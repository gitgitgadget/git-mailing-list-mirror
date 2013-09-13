From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] name-hash: refactor polymorphic index_name_exists()
Date: Fri, 13 Sep 2013 11:40:16 -0700
Message-ID: <xmqq38p8k1kf.fsf@gitster.dls.corp.google.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
	<1379070943-36595-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 20:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKYI7-00057L-TO
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 20:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab3IMSkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 14:40:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab3IMSkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 14:40:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7CC5416D9;
	Fri, 13 Sep 2013 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RK7O2Dho4mdKuiHO/QU+esUDg0U=; b=ghylf0
	PA19vGJInU8iAwuEpr0XlTLVfqNGRgFhR/SUfxAxQBFa8pFc4xl0498DBgnN9brT
	KewtlV2x2b3/qn49NwEc4lRl2Cfb2dAZu0/ReHGVr2209caeDWwD7ozacH1R+/Va
	aPFkexKvXpLeH6GqLezQX4X9R1FmXqkP30YVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nORuTnrTBFcuKAZxTCfq2tG9i/6sZ87H
	W8QHycqGpR8NGKRiteHUibnjTSgXt0Ej9I1IaewQ5owyfZbapYFSNNeTm53sBzE3
	HTDXkSLSUgHhZoqgxM9bm3CzbdLmh1EtuGCZDsvIyMjSEUrJoiSJqFvgJTeoLkwr
	c5MKOG4DgQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBDC2416D6;
	Fri, 13 Sep 2013 18:40:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3508A416D4;
	Fri, 13 Sep 2013 18:40:21 +0000 (UTC)
In-Reply-To: <1379070943-36595-2-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 13 Sep 2013 07:15:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1BE4312-1CA3-11E3-A6BC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234761>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Depending upon the absence or presence of a trailing '/' on the incoming
> pathname, index_name_exists() checks either if a file is present in the
> index or if a directory is represented within the index.  Each caller
> explicitly chooses the mode of operation by adding or removing a
> trailing '/' before invoking index_name_exists().
>
> Since these two modes of operations are disjoint and have no code in
> common (one searches index_state.name_hash; the other dir_hash), they
> can be represented more naturally as distinct functions: one to search
> for a file, and one for a directory.
>
> Splitting index searching into two functions relieves callers of the
> artificial burden of having to add or remove a slash to select the mode
> of operation; instead they just call the desired function. A subsequent
> patch will take advantage of this benefit in order to eliminate the
> requirement that the incoming pathname for a directory search must have
> a trailing slash.

Good thinking.  Thanks for working on this; I agree with the general
direction this series is going.

I however wonder if it would be a good idea to rename the other one
to {cache|index}_file_exists(), and even keep the *_name_exists()
variant that switches between the two based on the trailing slash,
to avoid breaking other topics in flight that may have added new
callsites to *_name_exists().  Otherwise the new callsites will feed
a path with a trailing slash to *_name_exists() and get a false
result, no?


> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  cache.h      |  2 ++
>  dir.c        |  7 ++++---
>  name-hash.c  | 47 ++++++++++++++++++++++++-----------------------
>  read-cache.c |  2 +-
>  4 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 9ef778a..03ec24c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -314,6 +314,7 @@ extern void free_name_hash(struct index_state *istate);
>  #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
>  #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
>  #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
> +#define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
>  #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
>  #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
>  #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
> @@ -463,6 +464,7 @@ extern int write_index(struct index_state *, int newfd);
>  extern int discard_index(struct index_state *);
>  extern int unmerged_index(const struct index_state *);
>  extern int verify_path(const char *path);
> +extern struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen);
>  extern struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int igncase);
>  extern int index_name_pos(const struct index_state *, const char *name, int namelen);
>  #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
> diff --git a/dir.c b/dir.c
> index b439ff0..0080673 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -860,7 +860,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
>  
>  static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
>  {
> -	if (cache_name_exists(pathname, len, ignore_case))
> +	if ((len == 0 || pathname[len - 1] != '/') &&
> +	    cache_name_exists(pathname, len, ignore_case))
>  		return NULL;
>  
>  	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
> @@ -885,11 +886,11 @@ enum exist_status {
>  /*
>   * Do not use the alphabetically sorted index to look up
>   * the directory name; instead, use the case insensitive
> - * name hash.
> + * directory hash.
>   */
>  static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
>  {
> -	const struct cache_entry *ce = cache_name_exists(dirname, len + 1, ignore_case);
> +	const struct cache_entry *ce = cache_dir_exists(dirname, len + 1);
>  	unsigned char endchar;
>  
>  	if (!ce)
> diff --git a/name-hash.c b/name-hash.c
> index 617c86c..5b01554 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -222,11 +222,35 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
>  	return slow_same_name(name, namelen, ce->name, len);
>  }
>  
> +struct cache_entry *index_dir_exists(struct index_state *istate, const char *name, int namelen)
> +{
> +	struct cache_entry *ce;
> +	struct dir_entry *dir;
> +
> +	lazy_init_name_hash(istate);
> +	dir = find_dir_entry(istate, name, namelen);
> +	if (dir && dir->nr)
> +		return dir->ce;
> +
> +	/*
> +	 * It might be a submodule. Unlike plain directories, which are stored
> +	 * in the dir-hash, submodules are stored in the name-hash, so check
> +	 * there, as well.
> +	 */
> +	ce = index_name_exists(istate, name, namelen - 1, 1);
> +	if (ce && S_ISGITLINK(ce->ce_mode))
> +		return ce;
> +
> +	return NULL;
> +}
> +
>  struct cache_entry *index_name_exists(struct index_state *istate, const char *name, int namelen, int icase)
>  {
>  	unsigned int hash = hash_name(name, namelen);
>  	struct cache_entry *ce;
>  
> +	assert(namelen == 0 || name[namelen - 1] != '/');
> +
>  	lazy_init_name_hash(istate);
>  	ce = lookup_hash(hash, &istate->name_hash);
>  
> @@ -237,29 +261,6 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
>  		}
>  		ce = ce->next;
>  	}
> -
> -	/*
> -	 * When looking for a directory (trailing '/'), it might be a
> -	 * submodule or a directory. Despite submodules being directories,
> -	 * they are stored in the name hash without a closing slash.
> -	 * When ignore_case is 1, directories are stored in a separate hash
> -	 * table *with* their closing slash.
> -	 *
> -	 * The side effect of this storage technique is we have need to
> -	 * lookup the directory in a separate hash table, and if not found
> -	 * remove the slash from name and perform the lookup again without
> -	 * the slash.  If a match is made, S_ISGITLINK(ce->mode) will be
> -	 * true.
> -	 */
> -	if (icase && name[namelen - 1] == '/') {
> -		struct dir_entry *dir = find_dir_entry(istate, name, namelen);
> -		if (dir && dir->nr)
> -			return dir->ce;
> -
> -		ce = index_name_exists(istate, name, namelen - 1, icase);
> -		if (ce && S_ISGITLINK(ce->ce_mode))
> -			return ce;
> -	}
>  	return NULL;
>  }
>  
> diff --git a/read-cache.c b/read-cache.c
> index 885943a..a59644a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -643,7 +643,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  			if (*ptr == '/') {
>  				struct cache_entry *foundce;
>  				++ptr;
> -				foundce = index_name_exists(istate, ce->name, ptr - ce->name, ignore_case);
> +				foundce = index_dir_exists(istate, ce->name, ptr - ce->name);
>  				if (foundce) {
>  					memcpy((void *)startPtr, foundce->name + (startPtr - ce->name), ptr - startPtr);
>  					startPtr = ptr;
