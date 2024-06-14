Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258313B5AC
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360845; cv=none; b=plJ88mzmVdYfUThvOi26UWDlR2DPRRcgSiE1RYv6UGE2vzsjqoUsb9DXhE6t279uBWnkg5NpK2GE2I7lwePGSIrM8ZNNnPqWISF3w6aBtCnxww7dycIR080mFc86FxLU12CFRs9cPWn9JhNyN4TuT+oIeTRug2DllJOxEvgiENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360845; c=relaxed/simple;
	bh=B5ApuymeAWg2YTrRRY/jHotPLBdCqsfcrPTjh4+btcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EojJrUhR/QycJEmDiBA0Wk3xWnr9g4RLGPOCFhMMbc2WS/6BjTm3H2qza5fV2daFypyICU5iFXH/Ha3UgH6H+eeEVqnuTfpd3tGN9fepJ3FeNME6kV8hZXJEeZ54MnXq2aO/mhM2TGngPUg1s7rtlXYEmBmwlk9Tl0m1N0NQuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16500 invoked by uid 109); 14 Jun 2024 10:27:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:27:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27103 invoked by uid 111); 14 Jun 2024 10:27:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:27:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:27:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 03/11] remote: transfer ownership of memory in add_url(), etc
Message-ID: <20240614102722.GC222445@coredump.intra.peff.net>
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

Many of the internal functions in remote.c take const strings and store
them forever in instances of "struct remote". Since the functions are
internal and callers are aware of the convention, this seems to mostly
work and not cause leaks. But there are some issues:

  - it's impossible to clear any of the arrays, because the data
    dependencies between them are too muddled (if you free() a string,
    it might also be referenced from another array, causing a
    user-after-free; but if you don't, that might be the last reference,
    causing a leak).

    This is mostly of interest for further refactoring and features, but
    there's at least one spot that's already a problem. In alias_all_urls(),
    we replace elements of remote->url and remote->pushurl with their
    aliased forms, dropping references to the original.

  - sometimes strings from outside callers make their way in. For
    example, calling remote_get("foo") when there is no configured "foo"
    remote will create a remote struct with the single url "foo". But
    we'll do so by holding on to the string passed to remote_get()
    forever.

    In practice I think this works out because we'd usually pass in a
    string that lasts the length of the program (a string literal, or
    argv reference, or other data structure allocated in the main
    function). But it's a rather subtle requirement.

Instead, let's have remote->url and remote->pushurl own their string
memory. They'll copy the const strings that are passed in, and callers
can stop making their own copies. Likewise, when we overwrite an entry,
we can free the memory it points to, fixing the leak mentioned above.

We'll leave the struct members as "const" since they are visible to the
outside world, and shouldn't usually be touched. This requires casting
on free() for now, but we'll clean that further in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Since now we'll always allocate, I don't think it's possible for this to
introduce any memory corruption issues. It _might_ introduce a leak, but
I think I fixed all of the callers.

 remote.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/remote.c b/remote.c
index fd9d58f820..f7c846865f 100644
--- a/remote.c
+++ b/remote.c
@@ -64,13 +64,13 @@ static char *alias_url(const char *url, struct rewrites *r)
 static void add_url(struct remote *remote, const char *url)
 {
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
-	remote->url[remote->url_nr++] = url;
+	remote->url[remote->url_nr++] = xstrdup(url);
 }
 
 static void add_pushurl(struct remote *remote, const char *pushurl)
 {
 	ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushurl_alloc);
-	remote->pushurl[remote->pushurl_nr++] = pushurl;
+	remote->pushurl[remote->pushurl_nr++] = xstrdup(pushurl);
 }
 
 static void add_pushurl_alias(struct remote_state *remote_state,
@@ -79,6 +79,7 @@ static void add_pushurl_alias(struct remote_state *remote_state,
 	char *alias = alias_url(url, &remote_state->rewrites_push);
 	if (alias)
 		add_pushurl(remote, alias);
+	free(alias);
 }
 
 static void add_url_alias(struct remote_state *remote_state,
@@ -87,6 +88,7 @@ static void add_url_alias(struct remote_state *remote_state,
 	char *alias = alias_url(url, &remote_state->rewrites);
 	add_url(remote, alias ? alias : url);
 	add_pushurl_alias(remote_state, remote, url);
+	free(alias);
 }
 
 struct remotes_hash_key {
@@ -293,7 +295,7 @@ static void read_remotes_file(struct remote_state *remote_state,
 
 		if (skip_prefix(buf.buf, "URL:", &v))
 			add_url_alias(remote_state, remote,
-				      xstrdup(skip_spaces(v)));
+				      skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Pull:", &v))
@@ -336,7 +338,7 @@ static void read_branches_file(struct remote_state *remote_state,
 	else
 		frag = to_free = repo_default_branch_name(the_repository, 0);
 
-	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
+	add_url_alias(remote_state, remote, buf.buf);
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -347,6 +349,7 @@ static void read_branches_file(struct remote_state *remote_state,
 	refspec_appendf(&remote->push, "HEAD:refs/heads/%s", frag);
 	remote->fetch_tags = 1; /* always auto-follow */
 
+	strbuf_release(&buf);
 	free(to_free);
 }
 
@@ -431,15 +434,13 @@ static int handle_config(const char *key, const char *value,
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
-		char *v;
-		if (git_config_string(&v, key, value))
-			return -1;
-		add_url(remote, v);
+		if (!value)
+			return config_error_nonbool(key);
+		add_url(remote, value);
 	} else if (!strcmp(subkey, "pushurl")) {
-		char *v;
-		if (git_config_string(&v, key, value))
-			return -1;
-		add_pushurl(remote, v);
+		if (!value)
+			return config_error_nonbool(key);
+		add_pushurl(remote, value);
 	} else if (!strcmp(subkey, "push")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -495,8 +496,10 @@ static void alias_all_urls(struct remote_state *remote_state)
 		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
 			char *alias = alias_url(remote_state->remotes[i]->pushurl[j],
 						&remote_state->rewrites);
-			if (alias)
+			if (alias) {
+				free((char *)remote_state->remotes[i]->pushurl[j]);
 				remote_state->remotes[i]->pushurl[j] = alias;
+			}
 		}
 		add_pushurl_aliases = remote_state->remotes[i]->pushurl_nr == 0;
 		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
@@ -507,8 +510,10 @@ static void alias_all_urls(struct remote_state *remote_state)
 					remote_state->remotes[i]->url[j]);
 			alias = alias_url(remote_state->remotes[i]->url[j],
 					  &remote_state->rewrites);
-			if (alias)
+			if (alias) {
+				free((char *)remote_state->remotes[i]->url[j]);
 				remote_state->remotes[i]->url[j] = alias;
+			}
 		}
 	}
 }
-- 
2.45.2.937.g0bcb3c087a

