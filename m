From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Mar 2015 10:23:05 -0700
Message-ID: <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
References: <20150316142026.GJ7847@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXYje-0006ZR-BQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 18:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbbCPRXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 13:23:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751693AbbCPRXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 13:23:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A4B840DF3;
	Mon, 16 Mar 2015 13:23:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DafxA44L2X83dxd+vPOvQl4Lmqk=; b=EqITzT
	nBvAJeJArn74zsNpuOiI3HPysCqisyoVMAaxTy2TJE27bgFaIcEe2WfKKQgXnod6
	Vua1ehfD4QmVEwWEPamop1G8Odvng9pcRcaXEyjNhxyZzUREJaMaDPO88ArE9d1X
	X/nzI/hGt4BdTk4G6hwa5VAxSDEd+Ms7ExHcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ClRdLxOhkkhwlWKSUbedy9gFV+5+Ik49
	5lSBtoERoXcHbGBgiI7nqP1n5kAs0NE9EUJWq7A2D9UOh3br3+XXrgqz2Q4X8d/H
	/g2Ajv9n6L7jXUlOtFeomQjEKxpH+fE9XrQiIM1f7SM/fk8/UR8kuZ53HyQasx4R
	TtNsf25qFx0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5265240DF1;
	Mon, 16 Mar 2015 13:23:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EE6D40DD4;
	Mon, 16 Mar 2015 13:23:06 -0400 (EDT)
In-Reply-To: <20150316142026.GJ7847@inner.h.apk.li> (Andreas Krey's message of
	"Mon, 16 Mar 2015 15:20:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C12C3D2-CC01-11E4-BB3A-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265579>

Andreas Krey <a.krey@gmx.de> writes:

> get_ref_cache used a linear list, which obviously is O(n^2).
> Use a fixed bucket hash which just takes a factor of 100000
> (~ 317^2) out of the n^2 - which is enough.
>
> Signed-off-by: Andreas Krey <a.krey@gmx.de>
> ---
>
> This brings 'git clean -ndx' times down from 17 minutes
> to 11 seconds on one of our workspaces (which accumulated
> a lot of ignored directories).

Nice.

These impressive numbers should go to the commit log message,
together with a bit more numbers to characterise the shape of the
repository that exhibits the problem with the original code.  You
say "a lot of ignored directories", but do you mean directories in
the working tree (which I suppose do not have much to do with the
submodule_ref_caches[])?  I am guessing that the repository has tons
of submodules?  How many is "tons" to make the pain noticeable?

> Actuallly using adaptive
> hashing or other structures seems overkill.

Perhaps _implementing_ these structures only for this codepath may
be overkill, but would it be an overkill to _use_ existing hashmap.c
implementation?  After all, those who wrote the original would have
thought that anything more complex than a linear list would be
overkill, and nobody disagreed until you found that your repository
disagreed with that assumption ;-)

>  refs.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index e23542b..8198d9e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -982,6 +982,8 @@ struct packed_ref_cache {
>  	struct stat_validity validity;
>  };
>  
> +#define REF_CACHE_HASH 317
> +
>  /*
>   * Future: need to be in "struct repository"
>   * when doing a full libification.
> @@ -996,7 +998,7 @@ static struct ref_cache {
>  	 * is initialized correctly.
>  	 */
>  	char name[1];
> -} ref_cache, *submodule_ref_caches;
> +} ref_cache, *submodule_ref_caches[REF_CACHE_HASH];
>  
>  /* Lock used for the main packed-refs file: */
>  static struct lock_file packlock;
> @@ -1065,18 +1067,19 @@ static struct ref_cache *create_ref_cache(const char *submodule)
>   */
>  static struct ref_cache *get_ref_cache(const char *submodule)
>  {
> -	struct ref_cache *refs;
> +	struct ref_cache *refs, **bucketp;
> +	bucketp = submodule_ref_caches + strhash(submodule) % REF_CACHE_HASH;
>  
>  	if (!submodule || !*submodule)
>  		return &ref_cache;
>  
> -	for (refs = submodule_ref_caches; refs; refs = refs->next)
> +	for (refs = *bucketp; refs; refs = refs->next)
>  		if (!strcmp(submodule, refs->name))
>  			return refs;
>  
>  	refs = create_ref_cache(submodule);
> -	refs->next = submodule_ref_caches;
> -	submodule_ref_caches = refs;
> +	refs->next = *bucketp;
> +	*bucketp = refs;
>  	return refs;
>  }
