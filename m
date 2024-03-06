Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C105D2F7
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688207; cv=none; b=p3athky7u7evOCKN8QEwqOMEC4JKBc8SmXV7BvX57aKuw+d8QUPmFHdSyTPmHiH6u9Ln+Gp+I9H5zI4QAkBNHNdHIuqnhk95q7XkabG5vRUuO8b1Sg9oqklz+Q2DV6P6K3pjtd9B6cOwcjxkPx9Wt+Ncg6kARUMnzOgiltFGBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688207; c=relaxed/simple;
	bh=Q6otX8IetemkF39w9XPypBdlARvb+3faBjuLsBomqWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZR3Ow06Pbzc6r5ItBebS0MSszNWS8MEfhZ/UhK1KSNdGM1xVZWPbAVCS5ZmCCxohS4eKgu+J044XTCzjRgpUK3Xea3I/5qDqlShMyqjrcKHCclOqUXbXI9Sqr5zaby2cp/CdRNbro2fvr8VV2QK+JEJEDZJOprU3eQfg6ZSd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23020 invoked by uid 109); 6 Mar 2024 01:23:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 01:23:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30641 invoked by uid 111); 6 Mar 2024 01:23:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Mar 2024 20:23:26 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Mar 2024 20:23:23 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Atneya Nair <atneya@google.com>, git@vger.kernel.org,
	jeffhost@microsoft.com, me@ttaylorr.com, nasamuffin@google.com,
	Tanay Abhra <tanayabh@gmail.com>, Glen Choo <glencbz@gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
Message-ID: <20240306012323.GA3817803@coredump.intra.peff.net>
References: <20240305012112.1598053-2-atneya@google.com>
 <20240305012112.1598053-4-atneya@google.com>
 <xmqqwmqg38u2.fsf@gitster.g>
 <xmqqsf141pf5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf141pf5.fsf@gitster.g>

On Tue, Mar 05, 2024 at 10:53:02AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The use of strintern() comes originally from 3df8fd62 ...
> > ..., so they may
> > know how safe the change on the config side would be (I still do
> > not understand why you'd want to do this in the first place, though,
> > especially if you are protecting the callsites with mutex).
> 
> The risks of turning code that uses strintern() to use strdup() are
> 
>  * you will leak the allocated string unless you explicitly free the
>    string you now own.
> 
>  * you may consume too much memory if you are creating too many
>    copies of the same string (e.g. if you need filename for each
>    line in a file in an application, the memory consumption can
>    become 1000-fold).
> 
>  * the code may be taking advantage of the fact that two such
>    strings can be compared for (in)equality simply by comparing
>    their addresses, which you would need to adjust to use !strcmp()
>    and the like.

There is one more, I think: if you _do_ free the allocated string to
avoid the leak you mention, then some other code which was relying on
the lifetime of that string to be effectively infinite will now have a
user-after-free.

And I think that may be the case here. The "kvi" struct itself is local
to do_config_from(). But when we load the caching configset, we do so in
configset_add_value() which makes a shallow copy of the kvi struct. And
then that shallow copy may live on and be accessed with further calls to
git_config().

So doing just this:

diff --git a/config.c b/config.c
index 3cfeb3d8bd..2f6c83ffe7 100644
--- a/config.c
+++ b/config.c
@@ -1017,7 +1017,7 @@ static void kvi_from_source(struct config_source *cs,
 			    enum config_scope scope,
 			    struct key_value_info *out)
 {
-	out->filename = strintern(cs->name);
+	out->filename = xstrdup(cs->name);
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
@@ -1855,6 +1855,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn,
 
 	ret = git_parse_source(top, fn, &kvi, data, opts);
 
+	free((char *)kvi.filename);
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
 

will cause t4013.199 (among others) to fail when built with
SANITIZE=address, as it detects the user-after-free. I think you'd need
this on top:

diff --git a/config.c b/config.c
index 2f6c83ffe7..9854ca002d 100644
--- a/config.c
+++ b/config.c
@@ -2262,6 +2262,7 @@ static int configset_add_value(const struct key_value_info *kvi_p,
 	l_item->value_index = e->value_list.nr - 1;
 
 	*kv_info = *kvi_p;
+	kv_info->filename = xstrdup_or_null(kvi_p->filename); /* deep copy! */
 	si->util = kv_info;
 
 	return 0;

though probably an actual kvi_copy() function would be less horrible.

A few other things to note, looking at this code:

  - isn't kvi->path in the same boat? We do not duplicate it at all, so
    it seems like the shallow copy made in the configset could cause a
    user-after-free.

  - the "fix" I showed above hits your point 2: now we are making a lot
    more copies of that string. I will note that we're already making a
    lot of copies of the kvi struct in the first place, so unless you
    have really long pathnames, it probably isn't a big difference.

    But it possibly could make sense to have the configset own a single
    duplicate string, and then let the kvi structs it holds point to
    that string. But IMHO all of this should be details of the configset
    code, and the main config-iteration code should not have to worry
    about this at all. I.e., I think kvi_from_source() should not be
    duplicating anything in the first place.

-Peff
