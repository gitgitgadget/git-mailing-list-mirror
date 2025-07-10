Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF38748F
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118971; cv=none; b=kmgFPGMRHXgS0eULwAUlJwe0b1bi1Mq+4gcgf/f89C3tea+PIyyXSDIcJ1YrQZCcbKsNRbzxu5JVUPdoBkbFuLfeWXtuTQkFvHPYo6vHlLQX/vTS0sU/Wk+I4cH8NzfsT2FJVuikLDFKPLFet0oZEvwNNZI0xE8uIMOliJ9Id1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118971; c=relaxed/simple;
	bh=auEBURgylRCrPlkIowWhFs5rkoXn0L1GhsrrMi3cuws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kN26ERpc3kL5TJ0Z/1F9E3rvVZJCJqC4W2h1QyreE1SSgbOJEFggCpXv+IQeQQxNgwbixuVzTnZsfYxqfwHFrPz6gl7Tpd/oHukmJrxrnLmOdVjCHQ+FggW1NdqM6u57GcuTxLhHY3Vzo97rWVXL+zf1QTbJrNf2U1FdknLjU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KKiuzZbm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KKiuzZbm"
Received: (qmail 750 invoked by uid 109); 10 Jul 2025 03:42:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=auEBURgylRCrPlkIowWhFs5rkoXn0L1GhsrrMi3cuws=; b=KKiuzZbmxuaEatsyuEwy7h9zW3EasWLq1JgWYY243V+Hd9jXknRbetMT2GRpmetEEArRglwQhBexTFBJGebG15VhrXo9y3mEz7bqryH6dIHv7DzxDXy56QErhyjDB3YNUSS0iK7r6El6iHVlzYGOPFnMDyiykx3P4mvHTbmowDa3K7iHYXYgX51b3D+vsZvyT/bP0BlhXkhJ/jw19XjO7wlZN4ieFfvBcBjy+/gNzQ+EFlpHZdJuEHctGtoBWujsWsS2PPelxbBthk5iNP+Vaq9VkiYGu/vL2RcqkWS85WtfgF7YPg6qmsc66v58N7GldVMnnvrydxe7VZbSn8YEmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jul 2025 03:42:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21144 invoked by uid 111); 10 Jul 2025 03:42:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Jul 2025 23:42:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Jul 2025 23:42:41 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] reflog: close leak of reflog expire entry
Message-ID: <20250710034241.GA2057509@coredump.intra.peff.net>
References: <20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com>
 <D34FE2DE-EE5B-43F3-A706-1AC133AA72F1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D34FE2DE-EE5B-43F3-A706-1AC133AA72F1@gmail.com>

On Thu, Jul 10, 2025 at 11:00:38AM +0800, Lidong Yan wrote:

> In builtin/reflog.c, we have code like
> 
> ---
> 	for (i = 0; i < argc; i++) {
> 		char *ref;
> 		struct expire_reflog_policy_cb cb = { .opts = opts };
> 
> 		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
> 			status |= error(_("reflog could not be found: '%s'"), argv[i]);
> 			continue;
> 		}
> 		reflog_expire_options_set_refname(&cb.opts, ref);
> 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
> 					     ref, flags,
> 					     reflog_expiry_prepare,
> 					     should_prune_fn,
> 					     reflog_expiry_cleanup,
> 					     &cb);
> 		free(ref);
> 	}
> +      reflog_clear_expire_config(&opts);
> ---
> 
> I think allowing reblog_expiry_cleanup() to free all opt->entries might
> cause reblog_expire_options_set_refname() to behave incorrectly.

Hmm, yeah. We are calling this in a loop, so we'd want the config to
persist until the loop ends. I didn't test, but I'd guess that:

  git -c 'gc.refs/heads/*.reflogExpire=now' \
    reflog expire refs/heads/foo refs/heads/bar

would apply the config for "foo" but not for "bar". So I think
reflog_expiry_cleanup() has to just clean up per-traversal data, not the
config.

So the call at the end here looks reasonable, but the call in
reflog_expiry_cleanup() is wrong. I guess it was trying to cover the
call in reflog_expire_condition(). That probably just needs a manual:

diff --git a/builtin/gc.c b/builtin/gc.c
index 845876ff02..37f5437365 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -346,6 +346,7 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
 				 count_reflog_entries, &data);
 
 	reflog_expiry_cleanup(&data.policy);
+	reflog_clear_expire_config(&data.policy);
 	return data.count >= data.limit;
 }
 

-Peff
