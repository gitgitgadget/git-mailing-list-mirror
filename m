From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 11:03:03 -0700
Message-ID: <xmqqionwhj54.fsf@gitster.dls.corp.google.com>
References: <1403165242-16849-1-git-send-email-jmmahler@gmail.com>
	<1403165242-16849-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:03:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxgg8-0005iP-5a
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 20:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbaFSSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 14:03:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58090 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226AbaFSSDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 14:03:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 015331F40E;
	Thu, 19 Jun 2014 14:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ANwjqzMzwjTXvIdzgFD0gUWhKKU=; b=bteKft
	U9yDyjx7LNiMmfoxh+qfqcqTnARpXdlg8eEiZdwSG0rFPlURFiwAaoBEAiAZeVud
	2MBLsXRLO/mXeyYNgYb3h36B4CFNti7XFNaPgSFwDgqEM6yUs6c107KjBfABEh7Z
	n2Jzhg5d4dftCda1pZGgwvHQvE6QbMOrYiEy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOdDO2GSHNx4OUl6+SbO33kg+fiW6yl5
	+80OQGX/INIRK2lw2ZQtf7pgYquAjnONOvoKZiP2sObMzSXkOswfpZJbUb6FWcrw
	7R1PqTMwGM0th11bBTOiwy7cA6l9X2bMQMQCzC7iq+ohg00Y0627bdEYdxyytUMy
	T/6TZ75KBIs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8E091F40D;
	Thu, 19 Jun 2014 14:03:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4EBE71F409;
	Thu, 19 Jun 2014 14:03:03 -0400 (EDT)
In-Reply-To: <1403165242-16849-2-git-send-email-jmmahler@gmail.com> (Jeremiah
	Mahler's message of "Thu, 19 Jun 2014 01:07:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F51B3FD8-F7DB-11E3-9693-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252170>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Both unpack-trees.c and read-cache.c have their own name_compare()
> function, which are identical.  And read-cache.c has a
> cache_name_compare() function which is nearly identical to
> name_compare() [1].  The cache_name_compare() function is not specific
> to a cache, other than by being part of cache.h.

'other than by designed to be used only for comparing names in the
cache entries' is probably more accurate, I would think.

> Generalize the cache_name_compare() function by renaming it to
> name_compare().  Simplify the cache_name_stage_compare() function using
> name_compare().  Then change the few instances which used
> cache_name_compare() to name_compare() [2].
>
> [1] cache_name_compare() is not identical to name_compare().  The former
>     returns +1, -1, whereas the latter returns +N, -N.  But there is no
>     place where name_compare() is used that needs the magnitude so this
>     difference does not alter its behavior.

You chose to use the one that loses the information by unifying
these two into the variant that only returns -1/0/+1.  We know that
it does not matter for the current callers, but is it expected that
no future callers will benefit by having the magnitude information?

> [2] The instances where cache_name_compare() is used have nothing to do
>     with a cache.  The new name, name_compare(), makes it clear that no
>     cache is involved.

This is redundant and should be dropped, as you already said "is not
specific to a cache" earlier.

> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  cache.h        |  2 +-
>  dir.c          |  3 +--
>  name-hash.c    |  2 +-
>  read-cache.c   | 23 +++++++++++++----------
>  tree-walk.c    | 10 ----------
>  unpack-trees.c | 11 -----------
>  6 files changed, 16 insertions(+), 35 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index c498a30..e3205fe 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1027,7 +1027,7 @@ extern int validate_headref(const char *ref);
>  
>  extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
>  extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
> -extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
> +extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
>  extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
>  
>  extern void *read_object_with_reference(const unsigned char *sha1,
> diff --git a/dir.c b/dir.c
> index 797805d..e65888d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1354,8 +1354,7 @@ static int cmp_name(const void *p1, const void *p2)
>  	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
>  	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
>  
> -	return cache_name_compare(e1->name, e1->len,
> -				  e2->name, e2->len);
> +	return name_compare(e1->name, e1->len, e2->name, e2->len);
>  }
>  
>  static struct path_simplify *create_simplify(const char **pathspec)
> diff --git a/name-hash.c b/name-hash.c
> index be7c4ae..e2bea88 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -179,7 +179,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
>  	 * Always do exact compare, even if we want a case-ignoring comparison;
>  	 * we do the quick exact one first, because it will be the common case.
>  	 */
> -	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
> +	if (len == namelen && !name_compare(name, namelen, ce->name, len))
>  		return 1;

The existing code is somewhat strange; while the update is correct
in the context of this patch, it may further want to be fixed in a
later patch to either

	!name_compare(name, namelen, ce->name, len)

or

	len == namelen && !memcmp(name, ce->name, len)

The patch text looks good.

Thanks.
