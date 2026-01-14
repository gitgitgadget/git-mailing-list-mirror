Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F13B5307
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430102; cv=none; b=bm9AkTCdlbq1YBYO8JIQZ0Gv6pc/4o9/OHBv9Z2f4mIgFwPmHZ9RYlHPAOxaWLHaeQ1NfVzf/pl7iCWLCB1urEln5TAUdv3mj/1HkRpjzmaMnX5ozpLWI9BqtnVd9H0sqDJDxITfdzJi566icp8j5fKh7RnDOUWdRSRava3CzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430102; c=relaxed/simple;
	bh=1F8r0KnVPDc4BXQlyiVUiyM8PG+LG9QBR4ihbqjadDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2YqlDkmyx12yKaSA6oSf4qNpXIA2QHVYg4RVTdH745Gie42A2EZPvr7/h4q96mhphC0dhu9t0qkwcQ6kPaqcP9i3X0Kk2dNf1VgkXTueQu73rap/SEw2YE3TVPSZ2h35sc6Km+BOJM63QBSU6f4YU9ZVzt5skaeCLcGbFabDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gKQTVjdy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gKQTVjdy"
Received: (qmail 42098 invoked by uid 109); 14 Jan 2026 22:34:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1F8r0KnVPDc4BXQlyiVUiyM8PG+LG9QBR4ihbqjadDs=; b=gKQTVjdyc0OV399vN5u6rQiN4uN8J3e1CLwYZF9V5EqYUp7mVGm86gFg5H7ghPkIxzVnYsoyA3NYTcDDvaF0q+/ZjudNpSR/CGdtfqtzDXw6hWS5Wql+nKs3O5I73qFCxFfkqM6LgnB/sjJ00YlYmiIvYFyo6GqZLPt7wqnfReTBhSId6U5KvqYlPWS2y1CsNkVD+wp3pQxqPamlgMl5+XmTOWiiw/61JbLb98lWb6rNcKrdDNPBRaaG1VI5sz/9zbENU+Jf6DedeyOHAAqAeCxsGTCMzzDruTiwGPRW7TcG+wY28VJ/w+NM51U29ijkjoa2asap56Bg4CIa84PW4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 22:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71158 invoked by uid 111); 14 Jan 2026 22:34:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 17:34:54 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 17:34:51 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] fsck: snapshot default refs before object walk
Message-ID: <20260114223451.GB1014423@coredump.intra.peff.net>
References: <pull.2026.v2.git.1767749366719.gitgitgadget@gmail.com>
 <pull.2026.v3.git.1767980953134.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2026.v3.git.1767980953134.gitgitgadget@gmail.com>

On Fri, Jan 09, 2026 at 05:49:13PM +0000, Elijah Newren via GitGitGadget wrote:

> -static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
> +struct ref_snapshot {
> +	char *refname;
> +	struct object_id oid;
> +	/* TODO: Maybe supplement with latest reflog entry info too? */
> +};

I think this is an OK place to stop for now, but just a few thoughts for
a possible future (that I hope neither of us ever needs to follow up on ;) ).

I wonder if we need to record individual reflog entries at all, or if it
would be sufficient to just keep an oidset of reachable tips. In fact, I
wondered if we even needed these ref_snapshot structs at all, and
couldn't just get away with an oidset. But I guess if we do find that
something reachable is missing, we want some better way of pointing to
the culprit.

It _might_ be possible to keep a more compact representation like an
oidset for the happy path, and then only if we find that something is
unreachable, go back and find the culprit. But maybe that gets too
complicated and/or racy.

I also wondered if we could just instantiate a "struct object" for each
ref tip, and marking it with a reachable flag. That's even _more_
expensive than the object_id you're storing here, but eventually becomes
cheaper, since we're going to instantiate all of those objects as we
traverse. IIRC fsck traditionally relied on the existence of an object
struct as a signal that we saw the object somewhere, but I don't recall
if that is still true (a long time ago, I think I tried to convert that
into an explicit flag to prevent subtle confusion, but I don't remember
how completely I succeeded).

Anyway, all of that is for another time.

> +static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
> +{
> +	struct object *obj;
> +
> +	obj = parse_object(the_repository, ref->oid);
>  	obj->flags |= USED;
>  	fsck_put_object_name(&fsck_walk_options,
>  			     ref->oid, "%s", ref->name);

I wonder if this parse_object() can ever fail (say, in a corrupted repo)
and we'd segfault here? I wouldn't be surprised if that is already a
possibility before your patch, either. ;)

> [...]

I gave a fairly quick read to the rest of it but didn't see anything
questionable.

-Peff
