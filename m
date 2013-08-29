From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 4/7] refs: factor delete_ref loose ref step into a helper
Date: Thu, 29 Aug 2013 10:28:11 -0700
Message-ID: <xmqqppsw5rv8.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<f5a6f3552b16519b6568a7c745ab61c26bc4a072.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF617-0001wr-1a
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab3H2R2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:28:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755073Ab3H2R2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:28:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1613DA3C;
	Thu, 29 Aug 2013 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PJHGT882X0doQ0/LqkER3WnIlCc=; b=t1O1nh
	3s24sCkKsdTWVD+jPfTkxcHEylLf5/Ko5B3eICWWWdMlh6mFoj17rY7+HoxqxZBj
	hMeRVQ3mhMDwi18jyi0X1HeBvX82Tz9YUilupLAcNG/7UK37CHhVX2rLVdPpSKvh
	dNw+3jzE5NV6MxZBCUVHdaCyuyttwVnAGcTaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wt4dKvanySxP3zXMsRo8SdnpzfE3RVR8
	qMf7B7qbB+htw6kcFA7N1Y9yVLlAnTJFxLtF3yJqmkNO9cPj9NuGcm9vF8RBX4Gc
	8mQYJbITwovExLchAOsM7MyXuVqpJ2mZbkYuyB8PcjQ31xHTVGdFmSuyMLLaMByp
	niAYmXLor+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A103DA3B;
	Thu, 29 Aug 2013 17:28:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5120C3DA39;
	Thu, 29 Aug 2013 17:28:14 +0000 (UTC)
In-Reply-To: <f5a6f3552b16519b6568a7c745ab61c26bc4a072.1377784597.git.brad.king@kitware.com>
	(Brad King's message of "Thu, 29 Aug 2013 10:11:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6285B52E-10D0-11E3-829C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233290>

Brad King <brad.king@kitware.com> writes:

> Factor loose ref deletion into helper function delete_ref_loose to allow
> later use elsewhere.  While at it, rename local names 'flag => type' and
> 'delopt => flags' for consistency with callers and called functions.
>
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  refs.c |   24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 2e755b4..5908648 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2450,15 +2450,10 @@ static int repack_without_ref(const char *refname)
>  	return commit_packed_refs();
>  }
>  
> -int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
> +static int delete_ref_loose(struct ref_lock *lock, int type)
>  {
> -	struct ref_lock *lock;
> -	int err, i = 0, ret = 0, flag = 0;
> -
> -	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
> -	if (!lock)
> -		return 1;
> -	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
> +	int err, i, ret = 0;
> +	if (!(type & REF_ISPACKED) || type & REF_ISSYMREF) {

Hits from "git grep REF_IS" tell me that all users of REF_IS* symbol
that check if a bit is on in a word does so against "flag" (either a
variable called "flag", "flags", or a structure member ".flag").

This change is making things less consistent, not more, I am afraid.

>  		/* loose */
>  		i = strlen(lock->lk->filename) - 5; /* .lock */
>  		lock->lk->filename[i] = 0;
> @@ -2468,6 +2463,19 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  
>  		lock->lk->filename[i] = '.';
>  	}
> +	return ret;
> +}
> +
> +int delete_ref(const char *refname, const unsigned char *sha1, int flags)
> +{
> +	struct ref_lock *lock;
> +	int ret = 0, type = 0;
> +
> +	lock = lock_ref_sha1_basic(refname, sha1, flags, &type);
> +	if (!lock)
> +		return 1;
> +	ret |= delete_ref_loose(lock, type);
> +
>  	/* removing the loose one could have resurrected an earlier
>  	 * packed one.  Also, if it was not loose we need to repack
>  	 * without it.
