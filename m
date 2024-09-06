Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424CA41
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594361; cv=none; b=hXmiN21SqbQlDKpeokf+zYxPzhhqEjPNuPr1jsQG1fh7IkE+FpMeUAtMYxJN85ZwnSRKkS/r7Y0x1XV1W1Z6xCYiA8Cq+YpN186Wq5G3zDxtNwwF9wBhMYj/iF4Y6RJr+GsDX2k/v+ffMGkT8iwlS497VldZcGEWO5Tq7Ef+yBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594361; c=relaxed/simple;
	bh=l8nyj+5NdYZMLQ7Tqap/SHfQpOMvLLCZW3v3h23ou1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvZdzBx5dJZbHLE3FW9StHlOIGyQjNWd1oTM6Q9dwROS6ZWy8DI5b/c/ZdLKcKji8970TNlTMRUsSTktO2xy+e957KGhM7uOFHtc2IkiZ/Iel+gkWxYkDoQVvLqhn1h19hGT10vQpAPGKi076Rq2Fvl5VF94ofiMxAhKUf4dV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15206 invoked by uid 109); 6 Sep 2024 03:45:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 03:45:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16334 invoked by uid 111); 6 Sep 2024 03:45:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 23:45:57 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 23:45:57 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] sparse-checkout file handle leak fix
Message-ID: <20240906034557.GA3693911@coredump.intra.peff.net>
References: <20240905082749.GA88220@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905082749.GA88220@coredump.intra.peff.net>

Here's a re-roll that fixes the use-after-free of the lock filename that
Patrick noticed. I pulled the error-checking fix into its own patch
(patch 2 here), and did Junio's suggested "goto out" as preparation in
patch 1. Patch 3 is the leak fix.

Range diff is below, but it's much harder to read than just looking at
the updated patch 3.

Thanks both for review on round 1.

  [1/3]: sparse-checkout: consolidate cleanup when writing patterns
  [2/3]: sparse-checkout: check commit_lock_file when writing patterns
  [3/3]: sparse-checkout: use fdopen_lock_file() instead of xfdopen()

 builtin/sparse-checkout.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-:  ---------- > 1:  03a80d3748 sparse-checkout: consolidate cleanup when writing patterns
-:  ---------- > 2:  20628aa350 sparse-checkout: check commit_lock_file when writing patterns
1:  b4700ba1a9 ! 3:  fe41f9f02b sparse-checkout: use fdopen_lock_file() instead of xfdopen()
    @@ Commit message
           - we no longer need to call fflush(); committing the lock-file
             auto-closes it, which will now do the flush for us. As a bonus, this
             will actually check that the flush was successful before renaming
    -        the file into place. Let's likewise report when committing the lock
    -        fails (rather than quietly returning success from the command).
    +        the file into place.
     
           - we can get rid of the local "fd" variable, since we never look at it
             ourselves now
    @@ builtin/sparse-checkout.c: static int write_patterns_and_update(struct pattern_l
     -	fd = hold_lock_file_for_update(&lk, sparse_filename,
     -				      LOCK_DIE_ON_ERROR);
     +	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
    - 	free(sparse_filename);
      
      	result = update_working_directory(pl);
    + 	if (result) {
     @@ builtin/sparse-checkout.c: static int write_patterns_and_update(struct pattern_list *pl)
    - 		return result;
    + 		goto out;
      	}
      
     -	fp = xfdopen(fd, "w");
    @@ builtin/sparse-checkout.c: static int write_patterns_and_update(struct pattern_l
      		write_patterns_to_file(fp, pl);
      
     -	fflush(fp);
    --	commit_lock_file(&lk);
    -+	if (commit_lock_file(&lk))
    -+		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
    - 
    - 	clear_pattern_list(pl);
    + 	if (commit_lock_file(&lk))
    + 		die_errno(_("unable to write %s"), sparse_filename);
      

