From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] read-cache.c: Refactor --ignore-missing implementation
Date: Mon, 27 Jan 2014 09:39:46 -0800
Message-ID: <xmqqy521nx25.fsf@gitster.dls.corp.google.com>
References: <cover.1390592626.git.brad.king@kitware.com>
	<cover.1390833624.git.brad.king@kitware.com>
	<e8a33f2e20e9f2041bf5f0fa952536755dbdf34c.1390833624.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, newren@gmail.com, jrnieder@gmail.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 18:40:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7qAD-0000yP-0z
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 18:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbaA0Rjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 12:39:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861AbaA0Rjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 12:39:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6196067352;
	Mon, 27 Jan 2014 12:39:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zJVKDmpyRh8AkDtdH6m9yB7DpOw=; b=RfMiqV
	Cm92uY2j5AqbdezS4irsFPMjrcLzm85ijAj5Z40YbxJFtI8ARj3TC8vK7gJvDu67
	nTY8dmIpp0mnN+u8jpTyG/RrSfq5+GO8Kt6hwqLU78rnJm2v+1NGNTcHyIJbFfh1
	QvkLmJik0iTK2QhiXNoTh/TSUy2LSfwhj1yeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mVxNDTmeMvjk5wzztipyLy216mfsdj+j
	YZeDJm0C4hIr9DvOhtKB6UTfYtjcI7SWaxcFg44hxChyZ3J8XnPj73jaaCTxSiPR
	9JrlYFbjladvFD/vAFdl+496mh/AVTs9CbD9W0hMSkTramhBFzmEDK+MtnErDRQ+
	D0ZoV06D7vI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5352367351;
	Mon, 27 Jan 2014 12:39:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 605906734E;
	Mon, 27 Jan 2014 12:39:49 -0500 (EST)
In-Reply-To: <e8a33f2e20e9f2041bf5f0fa952536755dbdf34c.1390833624.git.brad.king@kitware.com>
	(Brad King's message of "Mon, 27 Jan 2014 09:45:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 052FFFBC-877A-11E3-A226-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241150>

Brad King <brad.king@kitware.com> writes:

> Move lstat ENOENT handling from refresh_index to refresh_cache_ent and
> activate it with a new CE_MATCH_IGNORE_MISSING option.  This will allow
> other call paths into refresh_cache_ent to use the feature.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---

Good!

I forgot that we had "update-index --ignore-missing --refresh", and
that is conceptually the thing you want to use in your "perform
merge-recursive in an empty tree while pretending that the working
tree is fully populated and up-to-date" scenario.

>  cache.h      | 2 ++
>  read-cache.c | 8 +++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index c9efe88..c96ada7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -498,6 +498,8 @@ extern void *read_blob_data_from_index(struct index_state *, const char *, unsig
>  #define CE_MATCH_RACY_IS_DIRTY		02
>  /* do stat comparison even if CE_SKIP_WORKTREE is true */
>  #define CE_MATCH_IGNORE_SKIP_WORKTREE	04
> +/* ignore non-existent files during stat update  */
> +#define CE_MATCH_IGNORE_MISSING		0x08
>  extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>  extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>  
> diff --git a/read-cache.c b/read-cache.c
> index 33dd676..d61846c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1031,6 +1031,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>  	int changed, size;
>  	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
>  	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
> +	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
>  
>  	if (ce_uptodate(ce))
>  		return ce;
> @@ -1050,6 +1051,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>  	}
>  
>  	if (lstat(ce->name, &st) < 0) {
> +		if (ignore_missing && errno == ENOENT)
> +			return ce;
>  		if (err)
>  			*err = errno;
>  		return NULL;
> @@ -1127,7 +1130,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
>  	int first = 1;
>  	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
> -	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
> +	unsigned int options = ((really ? CE_MATCH_IGNORE_VALID : 0) |
> +				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
>  	const char *modified_fmt;
>  	const char *deleted_fmt;
>  	const char *typechange_fmt;
> @@ -1176,8 +1180,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  		if (!new) {
>  			const char *fmt;
>  
> -			if (not_new && cache_errno == ENOENT)
> -				continue;
>  			if (really && cache_errno == EINVAL) {
>  				/* If we are doing --really-refresh that
>  				 * means the index is not valid anymore.
