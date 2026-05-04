Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C46388E6D
	for <git@vger.kernel.org>; Mon,  4 May 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888486; cv=none; b=QGrKby1AlJ9FeZi9bx47wF6e2qWKIMIqg/kjevkaFGvaxJ3PMbG180Ci6QyICsq7zxfhzLVaVJjCQCxMSXB9Dg5ERHojfAkMwmYAZPSjy9XJKv7kK6Ap878NmrrvszrEq2C2BCBmxNGkv08spBnHtp8J8vdrF7YWqS0c2Wu020c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888486; c=relaxed/simple;
	bh=6Pyv2F3O/rxw3IZNM1m4OnhDZKSZaITozHLVfRkh+fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqrhOidLP19/q0zQmt2ZFA1Uyowl8GWH5eDgPJIqBco5OCskfYRn3uBJMI1mjjvbWzhLI40KSHR+Sv3l1jU4IazHfWEBsG+71N6t1p448wkGcGVET9roHO8PmrZr0JYsFhxmAbfQ5iA8HLtoducPmeVMgO3A9gq1K8Smal0H1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JvPczUW1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JvPczUW1"
Received: (qmail 28068 invoked by uid 106); 4 May 2026 09:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6Pyv2F3O/rxw3IZNM1m4OnhDZKSZaITozHLVfRkh+fo=; b=JvPczUW15MbP1XJ0o7g/GHJqetdECFHs//jpkN48SYLVHsWUSJPzpOQ/2USw1oDI3iH7rKQ19U7iiWZokZWNKUSWy5+luJn/0CThFMd8Env7dafFCHXBFlqRDLDAWxpHlkgOkCwn51obplF/9XaGwufTHSiRO8oVy9ZqCfFYrZZaS10gme1ym4cZktS2yYg/4gWoMECxt+cH1FzPZyVF3FdL2rjR+gAFVZNSAwIJwJ/Ko8XKzI5rONSsEQMjZXDs7M1dZVvdubII/rRuFrd5UDDjuIStZOh6Cb4hXGe3U5QjhrFnFBnu4E6KUuFocDm8UzSjxQXZ9Yl+oV+jh5r10g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 May 2026 09:54:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 54945 invoked by uid 111); 4 May 2026 09:54:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2026 05:54:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 May 2026 05:54:42 -0400
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: git@vger.kernel.org, emkan@prevas.dk
Subject: Re: git clone with --dissociate sometimes fails to check out target
 commit
Message-ID: <20260504095442.GA603346@coredump.intra.peff.net>
References: <87h5onsi0f.fsf@prevas.dk>
 <20260504095110.GA599780@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504095110.GA599780@coredump.intra.peff.net>

On Mon, May 04, 2026 at 05:51:10AM -0400, Jeff King wrote:

> No, you're using it correctly. The dissociate step should copy all of
> the shared objects into the new repo, so it shouldn't matter whether we
> do it before or after checkout. The objects are there either way.
> 
> But there's an interesting bug here with commit graphs. What happens is
> this:

Oh, and ironically dissociating later _would_ fix this bug, like so:

diff --git a/builtin/clone.c b/builtin/clone.c
index fba3c9c508..7b7c83c717 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1616,11 +1616,6 @@ int cmd_clone(int argc,
 	transport_unlock_pack(transport, 0);
 	transport_disconnect(transport);
 
-	if (option_dissociate) {
-		odb_close(the_repository->objects);
-		dissociate_from_references();
-	}
-
 	if (option_sparse_checkout && git_sparse_checkout_init(dir))
 		return 1;
 
@@ -1630,6 +1625,11 @@ int cmd_clone(int argc,
 		       filter_submodules,
 		       ref_storage_format);
 
+	if (option_dissociate) {
+		odb_close(the_repository->objects);
+		dissociate_from_references();
+	}
+
 	list_objects_filter_release(&filter_options);
 
 	string_list_clear(&option_not, 0);


But only because we are working around it: if we dissociate at the very
end, then there is no in-process code that will look at the objects
after that odb_close() call, and thus the bug cannot be triggered. It
would still potentially be lurking for other odb_close() callers,
though.

-Peff
