Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A04F1E5
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014766; cv=none; b=X+By1aFXTaQPfouPWq2jIiG1C0H7q06dD0jou5JnxRn+5ySHVpDBws9MLJlcf6xjTbqWvtQ1Idlz2V5QhdkOd9lOQqA6Op2QXa5JDlcVYXYZ6unWXBD3HQgJsN3LbSh6UpN+jLazZwrHQC5fkwFpi1KTRMPjbmf0q+deVJWlFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014766; c=relaxed/simple;
	bh=yzaPx5dKG9Zs2a4rkS6SmKUS69R0WoZYTh/6rUu5O3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvhjGM+0mDrR23yiWVUl47ZBKBPdfnKMMy1mHijvH2Curut9KQgnmBARLEwSW0RRaIoLiwkv/WySNDhqcCd1Ifb45vUt0dlIIeTW2tA2uOzzjUwNX8i0oqGfD/IHhilVvIvd0jpLFxBf5EZu/g6w2j3GYfIiF1Ni0/yLInjJhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=vO6QFbRV; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="vO6QFbRV"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42L9qQj5029877
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 Mar 2024 10:52:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711014747; bh=yzaPx5dKG9Zs2a4rkS6SmKUS69R0WoZYTh/6rUu5O3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=vO6QFbRVQO8O04kIlHKdU3o+to+1IeEVVlUuDzGp7mL3AKfz/gtbZiO0tx6j3GcZK
	 tGFAA6p4u9Y6okVVKNoICc+8dOiV9zveg4KVh0cW2BInrbKRgB5cvLBjdZ5OJMps6S
	 DqWvSmK0NHm1lQ967dlhJfskvt0wqeJDIa1mBHdw=
From: Dirk Gouders <dirk@gouders.net>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 4/7] sequencer: handle unborn branch with
 `--allow-empty`
In-Reply-To: <20240320233724.214369-5-brianmlyles@gmail.com> (Brian Lyles's
	message of "Wed, 20 Mar 2024 18:36:59 -0500")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240320233724.214369-5-brianmlyles@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 21 Mar 2024 10:52:21 +0100
Message-ID: <ghttkzykru.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Lyles <brianmlyles@gmail.com> writes:

> +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
> +		/*
> +		 * Check to see if this is an unborn branch
> +		 */
> +		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
> +		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))
> +			return error(_("could not resolve HEAD commit"));
> +		head_tree_oid = the_hash_algo->empty_tree;
> +	} else {
> +		head_commit = lookup_commit(r, &head_oid);
>  
> -	head_commit = lookup_commit(r, &head_oid);
> +		/*
> +		 * If head_commit is NULL, check_commit, called from
> +		 * lookup_commit, would have indicated that head_commit is not
> +		 * a commit object already.  repo_parse_commit() will return failure
> +		 * without further complaints in such a case.  Otherwise, if
> +		 * the commit is invalid, repo_parse_commit() will complain.  So
> +		 * there is nothing for us to say here.  Just return failure.
> +		 */
> +		if (repo_parse_commit(r, head_commit))
> +			return -1;

Not that I am qualified to do a review of your changes but I am in a
situation where I am trying to understand Git code in general and
(perhaps normal for this situation) wondering about varying styles of
commenting code -- could be that I am just too new to the code base and
do not yet understand the obvious things that don't need comments.

In the above example, there is a short but outstanding comment that
announces a check (and if I understood correctly by [1] it is a kind of
trick that could deserve some more information) and it does _not_
comment on the result.  Of course, I have an idea where the correct
place for a comment /* This is an unborn branch -- handle it as if... */
could be, but I'm not sure.

So, my intention is by no means to trigger another spin of this series
-- it is just a view from someone trying to understand not just this
code ;-)

Dirk

[1] https://lore.kernel.org/git/xmqqh6hcu2tg.fsf@gitster.g/
