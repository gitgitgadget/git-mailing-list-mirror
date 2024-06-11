Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21A2230F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096519; cv=none; b=GWkjV05x8qEPEEmHepba9FTN8JlFK25JdYyZJJqjjyu7Xn13JcImLmn07Cp4PeF8XkNJapXqupz0EYU8zsDE6BqwFvTDd/yQD00yi0CMWzGM8XvBPYQqNISrJ5q1wilPjcZ9bRgwTqXav+eXMQTsRip4ztfp9CgudGd+h3GmHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096519; c=relaxed/simple;
	bh=NfSKUwiaRTfLnGOLNWvJ9vqZptIqxD8Yn4o1YsC0LCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8vfZl0R6obDcrW5vCmjgYxKs6aT3fXPdblmBooWtqHiTBY1aet4luLgZRRM1nld2FugAAcUbouZC+Ug4JyRSkg+ciyZai/vmcW7gQ+MCag2mqK8+UPht0LfJ/XyFv36TYXt0KSraIuaXhAtiAJyEx4R6tQpy7nU7Lsvc2glI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18715 invoked by uid 109); 11 Jun 2024 09:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 09:01:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24980 invoked by uid 111); 11 Jun 2024 09:01:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 05:01:54 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 05:01:56 -0400
From: Jeff King <peff@peff.net>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] refs: keep track of unresolved reference value in
 iterators
Message-ID: <20240611090156.GK3248245@coredump.intra.peff.net>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <7202ada0542b6f014647785945094a13c9d885c7.1717694802.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7202ada0542b6f014647785945094a13c9d885c7.1717694802.git.gitgitgadget@gmail.com>

On Thu, Jun 06, 2024 at 05:26:38PM +0000, John Cai via GitGitGadget wrote:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bf2ffe062ea..a963d796a29 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -243,8 +243,9 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
>  {
>  	struct object_id oid;
>  	int flag;
> +	const char* referent = NULL;
>  
> -	if (!refs_resolve_ref_unsafe(&refs->base, refname, NULL, RESOLVE_REF_READING,
> +	if (!refs_resolve_ref_unsafe(&refs->base, refname, referent, RESOLVE_REF_READING,
>  				     &oid, &flag)) {
>  		oidclr(&oid);
>  		flag |= REF_ISBROKEN;

Here we pass in NULL, so the code in refs_resolve_ref_unsafe() won't do
anything. And our copy of "referent" here will remain NULL, so the rest
of this patch also does nothing. Again, I think that the function should
take a "char **", and you'd pass in &referent here?

Though if we are OK with surfacing just the final value in a
multi-element chain, then you could just use the existing return value,
like:

  referent = refs_resolve_ref_unsafe(&refs->base, refname,
				     RESOLVE_REF_REAEDING, &oid, &flags);
  if (!referent) {
          oidclr(&oid);
          flag |= REF_ISBROKEN;
  }

and then later pass "referent" to create_ref_entry() if flags contains
REF_ISSYMREF (or since we pass it the flags, it could do that check
itself).

-Peff
