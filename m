Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B483644BD
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752137; cv=none; b=uzW0FClrxfSuKIizpltW9bgOwg0oIhyjpCudUZAN07qhn4SGsgGI03Oly9fMyRZ1VAJXEmC+ZERCGumMoQ+ozj7/OT56wQoOviptSik2YjVmK/Pxv0u6rNotPdxgot9PyxjL28gj6dlONFmSYcd5lYzIfD2TSOw89O9ZxfjbJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752137; c=relaxed/simple;
	bh=LQdRp0fmwDdoi8lyW9DJv1X//qnbw5bNE+72H/ObXNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozV3y4mdG2UrISY5rHTlyh2OJIPQ/V17Lh8cbfq2aGLMEQLixuLzidkKRimoIxYl3q4E9hfXVpCs7D8LWUfbyx5F84Qb3QQr97SWuYICTcvTxfA8eY7Qq4PomrIoB15oLuYgxoPsvnSyfA9jiZqVpye2zE6Tt4vt1n2B8LHZ6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=T6zqxBBE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="T6zqxBBE"
Received: (qmail 2671 invoked by uid 106); 5 Mar 2026 23:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LQdRp0fmwDdoi8lyW9DJv1X//qnbw5bNE+72H/ObXNA=; b=T6zqxBBEQ/HM4wtV4C9+eNm27D6cbgJJFhtUBpt4g6sUJXrDTw+Q2LfIAFz1UsR1TSJL31UMSRgjUIf0BhRWw6dLa0pups3oAzPyanEE4WetrGObpeuJ0tWDi6qbiSnaz07Zos6DdJFa6H0yDUJLv4Imv+5h90HkseoU/eY8wc/AMUADv3DuRZk/MXoTeWij6MTHraOgR4ierqzdn/nAhmtecB3EnUFQbw0DOr1EQWiHZClMDj7IsNqtWtP8AMAyiwV18vBldLNvfE80unkEt59rgMJ7G7xRBxSXyqP1+N1FJqMxqzv94G+HUDIHuWQt0GrRm7oR8hSlgfQTmvEKjQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 23:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393470 invoked by uid 111); 5 Mar 2026 23:08:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 18:08:57 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 18:08:54 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: [PATCH 1/4] check_connected(): delay opening new_pack
Message-ID: <20260305230854.GA2901305@coredump.intra.peff.net>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305230315.GA2354983@coredump.intra.peff.net>

In check_connected(), if the transport tells us we got a single packfile
that has already been verified as self-contained and connected, then we
can skip checking connectivity for any tips that are mentioned in that
pack. This goes back to c6807a40dc (clone: open a shortcut for
connectivity check, 2013-05-26).

We don't need to open that pack until we are about to start sending oids
to our child rev-list process, since that's when we check whether they
are in the self-contained pack. Let's push the opening of that pack
further down in the function. That saves us from having to clean it up
when we leave the function early (and by the time have opened the
rev-list process, we never leave the function early, since we have to
clean up the child process).

Signed-off-by: Jeff King <peff@peff.net>
---
One thing I noticed here is that for a clone with a single
self-contained pack, we could probably skip running rev-list entirely. I
don't know if it matters much, though, as a noop rev-list process is not
that expensive compared to the cost of a clone. And in the worst case,
it would involve calling find_pack_entry() on each proposed ref tip an
extra time only to find that at least one does need to be sent. Though
that is also not very expensive.

I left it out of this series, though it would involve moving the
new_pack opening up above the start_command() invocation again.

I also wondered if this whole thing out to be written to avoid a one-off 
packed_git in the first place, like:

  - call reprepare_packed_git() to re-scan objects/pack

  - find the pack by name in the packed_git list

  - don't clean it up; it's owned by the repository struct now

But that's a somewhat bigger change, and I'm not sure it really buys us
that much.

 connected.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/connected.c b/connected.c
index 79403108dd..530357de54 100644
--- a/connected.c
+++ b/connected.c
@@ -45,20 +45,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		return err;
 	}
 
-	if (transport && transport->smart_options &&
-	    transport->smart_options->self_contained_and_connected &&
-	    transport->pack_lockfiles.nr == 1 &&
-	    strip_suffix(transport->pack_lockfiles.items[0].string,
-			 ".keep", &base_len)) {
-		struct strbuf idx_file = STRBUF_INIT;
-		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
-			   base_len);
-		strbuf_addstr(&idx_file, ".idx");
-		new_pack = add_packed_git(the_repository, idx_file.buf,
-					  idx_file.len, 1);
-		strbuf_release(&idx_file);
-	}
-
 	if (repo_has_promisor_remote(the_repository)) {
 		/*
 		 * For partial clones, we don't want to have to do a regular
@@ -90,7 +76,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 promisor_pack_found:
 			;
 		} while ((oid = fn(cb_data)) != NULL);
-		free(new_pack);
 		return 0;
 	}
 
@@ -127,15 +112,27 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	else
 		rev_list.no_stderr = opt->quiet;
 
-	if (start_command(&rev_list)) {
-		free(new_pack);
+	if (start_command(&rev_list))
 		return error(_("Could not run 'git rev-list'"));
-	}
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
 	rev_list_in = xfdopen(rev_list.in, "w");
 
+	if (transport && transport->smart_options &&
+	    transport->smart_options->self_contained_and_connected &&
+	    transport->pack_lockfiles.nr == 1 &&
+	    strip_suffix(transport->pack_lockfiles.items[0].string,
+			 ".keep", &base_len)) {
+		struct strbuf idx_file = STRBUF_INIT;
+		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
+			   base_len);
+		strbuf_addstr(&idx_file, ".idx");
+		new_pack = add_packed_git(the_repository, idx_file.buf,
+					  idx_file.len, 1);
+		strbuf_release(&idx_file);
+	}
+
 	do {
 		/*
 		 * If index-pack already checked that:
-- 
2.53.0.786.g466665faa3

