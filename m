Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC018EBF
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198565; cv=none; b=lE/6VdbnniFMjHLl1EV+h5l2tynsIPhn78VYOiuxS4/j3Nwpuw2jDJJUFotNuBt1V4q/LBbKwWFolCnmUAsU4MDmujm5Eo8WGGd1VJKA5CJ75YebXpiyup0PrbiRii+pdHBWYHNkvK43aq7jZnFkLVt4dYLpyyg+Ct5SzDRxCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198565; c=relaxed/simple;
	bh=Vhka2cZhJ3jl1xGToSe7O19FsvRKCPw9zzT1rT6WA5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNBpxbSlA7lRDj6dZTihr+malDzcFwFAuYm6QqJ5Q8ruMBEFNdu/gPy8C8J2+BjzGseVF8gyplod4YbpGfD9yyQytk19z6IdAC6Gqa0lp6GrIaZ9U3xzQY7LUvb2dVVwLvWMF0T0usvpXJce8OrEcG7IJ2DLBUFMEB4DVD6jQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23868 invoked by uid 109); 17 Jul 2024 06:42:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 06:42:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19028 invoked by uid 111); 17 Jul 2024 06:42:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 02:42:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 02:42:41 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.46.0-rc0 test failures on cygwin
Message-ID: <20240717064241.GF547635@coredump.intra.peff.net>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>

On Tue, Jul 16, 2024 at 08:45:48PM +0100, Ramsay Jones wrote:

>   error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.git/reftable': Permission denied
>   migrated refs can be found at '.git/ref_migration.sr9pEF'
> [...]
> Now try to finish the migration by hand:
> 
>   $ mv .git/ref_migration.sr9pEF/reftable .git/reftable
> 
> Hmm, note no error; of course, the mv command may well do much more than
> the rename() library function, so they are not necessarily equivalent.

This is a shot in the dark, but: could the problem be an open file that
cannot be moved? If I run a "ref migrate" on my Linux system in the
debugger and stop at move_files(), checking /proc/<pid>/fd shows an open
descriptor for .git/ref_migration.WnJ8TS/reftable/tables.list.

Does the patch below fix things for you? I'm not too familiar with the
code, so this is what I cobbled together.  The best response will be
from Patrick, but I think he's offline for another week or so. In the
meantime, this at least doesn't crash for me. ;) And I confirmed that
the tables.list file is closed during the move_files() call.

-Peff

---
diff --git a/refs.c b/refs.c
index bb90a18875..06a0fc5099 100644
--- a/refs.c
+++ b/refs.c
@@ -2843,6 +2843,12 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 		goto done;
 	}
 
+	/*
+	 * Close the new ref store to avoid holding on to any open files
+	 * which could interfere with moving things behind the scenes.
+	 */
+	ref_store_release(new_refs);
+
 	/*
 	 * Until now we were in the non-destructive phase, where we only
 	 * populated the new ref store. From hereon though we are about
@@ -2874,8 +2880,13 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 */
 	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, 1);
 
-	free(new_refs->gitdir);
-	new_refs->gitdir = xstrdup(old_refs->gitdir);
+	/*
+	 * Re-open the now-migrated ref store. I'm not sure if this is strictly
+	 * needed or not. Perhaps it would also be a good time to check that
+	 * we correctly opened it, it's in the expected format, etc?
+	 */
+	new_refs = ref_store_init(repo, format, old_refs->gitdir,
+				  REF_STORE_ALL_CAPS);
 	repo->refs_private = new_refs;
 	ref_store_release(old_refs);
 
