Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C24195969
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360780; cv=none; b=d3cunU+RFxjSobnXJSvopdhjCNf2V0OHA/FRpH7BNZKutAIFrVkJiCVgQhTvQ16OyIowt+VR0+B553esZvBNJPyRvr3ifW6hKL3EHAKw2efGGLYDHdmeWZkFckg2ubhyb5n4i3y0ULafXXkZYNsBKELnsiGrKCayIfgVGnJLnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360780; c=relaxed/simple;
	bh=u8n72KsHQdIMm4ikNwrcpbM97zk6qjYPyo6lBYCF5qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmhB75D9xq5OrQQrUxtdNBVNSe5pVNEXVx5a0vQ7wFBBdmLQ0DfvN+PfrXN+vGDBK14uT0FFnN2c9BCnhEioAM+QofufYXfVYZoDZ/GeRomcQP4OuF+VUOMZIDN8Q2nCx1fge/Q+RLQ7al4dn2XNZK9Y5mzufnEPlMyGEMzQOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16478 invoked by uid 109); 14 Jun 2024 10:26:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:26:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27094 invoked by uid 111); 14 Jun 2024 10:26:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:26:15 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:26:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 02/11] remote: refactor alias_url() memory ownership
Message-ID: <20240614102616.GB222445@coredump.intra.peff.net>
References: <20240614102439.GA222287@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614102439.GA222287@coredump.intra.peff.net>

The alias_url() function may return either a newly allocated string
(which the caller must take ownership of), or the original const "url"
parameter that was passed in.

This often works OK because callers are generally passing in a "url"
that they expect to retain ownership of anyway. So whether we got back
the original or a new string, we're always interested in storing it
forever. But I suspect there are some possible leaks here (e.g.,
add_url_alias() may end up discarding the original "url").

Whether there are active leaks or not, this is a confusing setup that
makes further refactoring of memory ownership harder. So instead of
returning the original string, return NULL, forcing callers to decide
what to do with it explicitly. We can then build further cleanups on top
of that.

Signed-off-by: Jeff King <peff@peff.net>
---
Just to be clear, I think there's probably still a leak in
add_url_alias() even after this patch. It's just a step on the way to
fixing.

 remote.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index dcb5492c85..fd9d58f820 100644
--- a/remote.c
+++ b/remote.c
@@ -35,7 +35,7 @@ static int valid_remote(const struct remote *remote)
 	return (!!remote->url) || (!!remote->foreign_vcs);
 }
 
-static const char *alias_url(const char *url, struct rewrites *r)
+static char *alias_url(const char *url, struct rewrites *r)
 {
 	int i, j;
 	struct counted_string *longest;
@@ -56,7 +56,7 @@ static const char *alias_url(const char *url, struct rewrites *r)
 		}
 	}
 	if (!longest)
-		return url;
+		return NULL;
 
 	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
 }
@@ -76,15 +76,16 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 static void add_pushurl_alias(struct remote_state *remote_state,
 			      struct remote *remote, const char *url)
 {
-	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
-	if (pushurl != url)
-		add_pushurl(remote, pushurl);
+	char *alias = alias_url(url, &remote_state->rewrites_push);
+	if (alias)
+		add_pushurl(remote, alias);
 }
 
 static void add_url_alias(struct remote_state *remote_state,
 			  struct remote *remote, const char *url)
 {
-	add_url(remote, alias_url(url, &remote_state->rewrites));
+	char *alias = alias_url(url, &remote_state->rewrites);
+	add_url(remote, alias ? alias : url);
 	add_pushurl_alias(remote_state, remote, url);
 }
 
@@ -492,19 +493,22 @@ static void alias_all_urls(struct remote_state *remote_state)
 		if (!remote_state->remotes[i])
 			continue;
 		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
-			remote_state->remotes[i]->pushurl[j] =
-				alias_url(remote_state->remotes[i]->pushurl[j],
-					  &remote_state->rewrites);
+			char *alias = alias_url(remote_state->remotes[i]->pushurl[j],
+						&remote_state->rewrites);
+			if (alias)
+				remote_state->remotes[i]->pushurl[j] = alias;
 		}
 		add_pushurl_aliases = remote_state->remotes[i]->pushurl_nr == 0;
 		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
+			char *alias;
 			if (add_pushurl_aliases)
 				add_pushurl_alias(
 					remote_state, remote_state->remotes[i],
 					remote_state->remotes[i]->url[j]);
-			remote_state->remotes[i]->url[j] =
-				alias_url(remote_state->remotes[i]->url[j],
+			alias = alias_url(remote_state->remotes[i]->url[j],
 					  &remote_state->rewrites);
+			if (alias)
+				remote_state->remotes[i]->url[j] = alias;
 		}
 	}
 }
-- 
2.45.2.937.g0bcb3c087a

