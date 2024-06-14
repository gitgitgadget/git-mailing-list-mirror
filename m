Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF91922DF
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360885; cv=none; b=DZSFrYMmUXlXGTjiLZ6r2i83xh6FXGTEa/zAIcanobnEIMJYURyWY/a90XfpCQfxkYJSug797PWb1wuNAk7cNMb5OyA/NDA3pv5eaNIjNhQLAEXTLAcKdXh86EfgqHSiPWXcUHXyr6wWW5GCI6Bork4pAkxBWTSyRLVwOujpyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360885; c=relaxed/simple;
	bh=Ur/39kT1TUKer8VHmcRQ/UfzdpU4FZxvtPscDFFGCDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS3zDV9PY4qMNbzrSbIDeccMqkyp1Lu1vLpkG4VEf6zmPc9Dlx0Po4+uqCHclhQRVBaQpMaHmolSLqcFGJl2H1H/LkJOkV7mT4Qniq93ss5+hs5kLCfegMDRkfbnPcf2qdh6HaovK51BRi1QpmnRETSbD9ar6rBUh0ClyY8plvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16513 invoked by uid 109); 14 Jun 2024 10:28:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:28:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27108 invoked by uid 111); 14 Jun 2024 10:27:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:27:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:28:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 04/11] remote: use strvecs to store remote url/pushurl
Message-ID: <20240614102801.GD222445@coredump.intra.peff.net>
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

Now that the url/pushurl fields of "struct remote" own their strings, we
can switch from bare arrays to strvecs. This has a few advantages:

  - push/clear are now one-liners

  - likewise the free+assigns in alias_all_urls() can use
    strvec_replace()

  - we now use size_t for storage, avoiding possible overflow

  - this will enable some further cleanups in future patches

There's quite a bit of fallout in the code that reads these fields, as
it tends to access these arrays directly. But it's mostly a mechanical
replacement of "url_nr" with "url.nr", and "url[i]" with "url.v[i]",
with a few variations (e.g. "*url" could become "*url.v", but I used
"url.v[0]" for consistency).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/archive.c          |  4 +--
 builtin/clone.c            |  4 +--
 builtin/ls-remote.c        |  6 ++--
 builtin/push.c             | 10 +++----
 builtin/remote.c           | 56 +++++++++++++++++++-------------------
 remote-curl.c              |  2 +-
 remote.c                   | 52 ++++++++++++++---------------------
 remote.h                   | 12 ++------
 t/helper/test-bundle-uri.c |  2 +-
 transport.c                |  4 +--
 10 files changed, 68 insertions(+), 84 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index f35560042e..0d9aff7e6f 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -31,9 +31,9 @@ static int run_remote_archiver(int argc, const char **argv,
 	struct packet_reader reader;
 
 	_remote = remote_get(remote);
-	if (!_remote->url_nr)
+	if (!_remote->url.nr)
 		die(_("git archive: Remote with no URL"));
-	transport = transport_get(_remote, _remote->url[0]);
+	transport = transport_get(_remote, _remote->url.v[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
 
 	/*
diff --git a/builtin/clone.c b/builtin/clone.c
index 730b3efae6..d3b70b49b0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1290,7 +1290,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
 			branch_top.buf);
 
-	path = get_repo_path(remote->url[0], &is_bundle);
+	path = get_repo_path(remote->url.v[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
 	if (is_local) {
 		if (option_depth)
@@ -1312,7 +1312,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
-	transport = transport_get(remote, path ? path : remote->url[0]);
+	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;
 	transport->cloning = 1;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index e8d65ebbdc..4c04dbbf19 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -109,11 +109,11 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			die("bad repository '%s'", dest);
 		die("No remote configured to list refs from.");
 	}
-	if (!remote->url_nr)
+	if (!remote->url.nr)
 		die("remote %s has no configured URL", dest);
 
 	if (get_url) {
-		printf("%s\n", *remote->url);
+		printf("%s\n", remote->url.v[0]);
 		return 0;
 	}
 
@@ -130,7 +130,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!dest && !quiet)
-		fprintf(stderr, "From %s\n", *remote->url);
+		fprintf(stderr, "From %s\n", remote->url.v[0]);
 	for ( ; ref; ref = ref->next) {
 		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
diff --git a/builtin/push.c b/builtin/push.c
index 2fbb31c3ad..61b5d3afdd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -143,12 +143,12 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 
 static int push_url_of_remote(struct remote *remote, const char ***url_p)
 {
-	if (remote->pushurl_nr) {
-		*url_p = remote->pushurl;
-		return remote->pushurl_nr;
+	if (remote->pushurl.nr) {
+		*url_p = remote->pushurl.v;
+		return remote->pushurl.nr;
 	}
-	*url_p = remote->url;
-	return remote->url_nr;
+	*url_p = remote->url.v;
+	return remote->url.nr;
 }
 
 static NORETURN void die_push_simple(struct branch *branch,
diff --git a/builtin/remote.c b/builtin/remote.c
index 447ef1d3c9..ee6a33ff11 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -619,8 +619,8 @@ static int migrate_file(struct remote *remote)
 	int i;
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
-	for (i = 0; i < remote->url_nr; i++)
-		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
+	for (i = 0; i < remote->url.nr; i++)
+		git_config_set_multivar(buf.buf, remote->url.v[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push.raw_nr; i++)
@@ -1002,8 +1002,8 @@ static int get_remote_ref_states(const char *name,
 		struct transport *transport;
 		const struct ref *remote_refs;
 
-		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
-			states->remote->url[0] : NULL);
+		transport = transport_get(states->remote, states->remote->url.nr > 0 ?
+			states->remote->url.v[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport, NULL);
 
 		states->queried = 1;
@@ -1216,12 +1216,12 @@ static int get_one_entry(struct remote *remote, void *priv)
 	const char **url;
 	int i, url_nr;
 
-	if (remote->url_nr > 0) {
+	if (remote->url.nr > 0) {
 		struct strbuf promisor_config = STRBUF_INIT;
 		const char *partial_clone_filter = NULL;
 
 		strbuf_addf(&promisor_config, "remote.%s.partialclonefilter", remote->name);
-		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url[0]);
+		strbuf_addf(&remote_info_buf, "%s (fetch)", remote->url.v[0]);
 		if (!git_config_get_string_tmp(promisor_config.buf, &partial_clone_filter))
 			strbuf_addf(&remote_info_buf, " [%s]", partial_clone_filter);
 
@@ -1230,12 +1230,12 @@ static int get_one_entry(struct remote *remote, void *priv)
 				strbuf_detach(&remote_info_buf, NULL);
 	} else
 		string_list_append(list, remote->name)->util = NULL;
-	if (remote->pushurl_nr) {
-		url = remote->pushurl;
-		url_nr = remote->pushurl_nr;
+	if (remote->pushurl.nr) {
+		url = remote->pushurl.v;
+		url_nr = remote->pushurl.nr;
 	} else {
-		url = remote->url;
-		url_nr = remote->url_nr;
+		url = remote->url.v;
+		url_nr = remote->url.nr;
 	}
 	for (i = 0; i < url_nr; i++)
 	{
@@ -1301,14 +1301,14 @@ static int show(int argc, const char **argv, const char *prefix)
 		get_remote_ref_states(*argv, &info.states, query_flag);
 
 		printf_ln(_("* remote %s"), *argv);
-		printf_ln(_("  Fetch URL: %s"), info.states.remote->url_nr > 0 ?
-		       info.states.remote->url[0] : _("(no URL)"));
-		if (info.states.remote->pushurl_nr) {
-			url = info.states.remote->pushurl;
-			url_nr = info.states.remote->pushurl_nr;
+		printf_ln(_("  Fetch URL: %s"), info.states.remote->url.nr > 0 ?
+		       info.states.remote->url.v[0] : _("(no URL)"));
+		if (info.states.remote->pushurl.nr) {
+			url = info.states.remote->pushurl.v;
+			url_nr = info.states.remote->pushurl.nr;
 		} else {
-			url = info.states.remote->url;
-			url_nr = info.states.remote->url_nr;
+			url = info.states.remote->url.v;
+			url_nr = info.states.remote->url.nr;
 		}
 		for (i = 0; i < url_nr; i++)
 			/*
@@ -1454,8 +1454,8 @@ static int prune_remote(const char *remote, int dry_run)
 
 	printf_ln(_("Pruning %s"), remote);
 	printf_ln(_("URL: %s"),
-		  states.remote->url_nr
-		  ? states.remote->url[0]
+		  states.remote->url.nr
+		  ? states.remote->url.v[0]
 		  : _("(no URL)"));
 
 	for_each_string_list_item(item, &states.stale)
@@ -1647,15 +1647,15 @@ static int get_url(int argc, const char **argv, const char *prefix)
 
 	url_nr = 0;
 	if (push_mode) {
-		url = remote->pushurl;
-		url_nr = remote->pushurl_nr;
+		url = remote->pushurl.v;
+		url_nr = remote->pushurl.nr;
 	}
 	/* else fetch mode */
 
 	/* Use the fetch URL when no push URLs were found or requested. */
 	if (!url_nr) {
-		url = remote->url;
-		url_nr = remote->url_nr;
+		url = remote->url.v;
+		url_nr = remote->url.nr;
 	}
 
 	if (!url_nr)
@@ -1718,12 +1718,12 @@ static int set_url(int argc, const char **argv, const char *prefix)
 
 	if (push_mode) {
 		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
-		urlset = remote->pushurl;
-		urlset_nr = remote->pushurl_nr;
+		urlset = remote->pushurl.v;
+		urlset_nr = remote->pushurl.nr;
 	} else {
 		strbuf_addf(&name_buf, "remote.%s.url", remotename);
-		urlset = remote->url;
-		urlset_nr = remote->url_nr;
+		urlset = remote->url.v;
+		urlset_nr = remote->url.nr;
 	}
 
 	/* Special cases that add new entry. */
diff --git a/remote-curl.c b/remote-curl.c
index 6008d7e87c..22957c16db 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1574,7 +1574,7 @@ int cmd_main(int argc, const char **argv)
 	if (argc > 2) {
 		end_url_with_slash(&url, argv[2]);
 	} else {
-		end_url_with_slash(&url, remote->url[0]);
+		end_url_with_slash(&url, remote->url.v[0]);
 	}
 
 	http_init(remote, url.buf, 0);
diff --git a/remote.c b/remote.c
index f7c846865f..76a3e41c73 100644
--- a/remote.c
+++ b/remote.c
@@ -32,7 +32,7 @@ struct counted_string {
 
 static int valid_remote(const struct remote *remote)
 {
-	return (!!remote->url) || (!!remote->foreign_vcs);
+	return (!!remote->url.nr) || (!!remote->foreign_vcs);
 }
 
 static char *alias_url(const char *url, struct rewrites *r)
@@ -63,14 +63,12 @@ static char *alias_url(const char *url, struct rewrites *r)
 
 static void add_url(struct remote *remote, const char *url)
 {
-	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
-	remote->url[remote->url_nr++] = xstrdup(url);
+	strvec_push(&remote->url, url);
 }
 
 static void add_pushurl(struct remote *remote, const char *pushurl)
 {
-	ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushurl_alloc);
-	remote->pushurl[remote->pushurl_nr++] = xstrdup(pushurl);
+	strvec_push(&remote->pushurl, pushurl);
 }
 
 static void add_pushurl_alias(struct remote_state *remote_state,
@@ -150,18 +148,12 @@ static struct remote *make_remote(struct remote_state *remote_state,
 
 static void remote_clear(struct remote *remote)
 {
-	int i;
-
 	free((char *)remote->name);
 	free((char *)remote->foreign_vcs);
 
-	for (i = 0; i < remote->url_nr; i++)
-		free((char *)remote->url[i]);
-	FREE_AND_NULL(remote->url);
+	strvec_clear(&remote->url);
+	strvec_clear(&remote->pushurl);
 
-	for (i = 0; i < remote->pushurl_nr; i++)
-		free((char *)remote->pushurl[i]);
-	FREE_AND_NULL(remote->pushurl);
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);
@@ -493,27 +485,25 @@ static void alias_all_urls(struct remote_state *remote_state)
 		int add_pushurl_aliases;
 		if (!remote_state->remotes[i])
 			continue;
-		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
-			char *alias = alias_url(remote_state->remotes[i]->pushurl[j],
+		for (j = 0; j < remote_state->remotes[i]->pushurl.nr; j++) {
+			char *alias = alias_url(remote_state->remotes[i]->pushurl.v[j],
 						&remote_state->rewrites);
-			if (alias) {
-				free((char *)remote_state->remotes[i]->pushurl[j]);
-				remote_state->remotes[i]->pushurl[j] = alias;
-			}
+			if (alias)
+				strvec_replace(&remote_state->remotes[i]->pushurl,
+					       j, alias);
 		}
-		add_pushurl_aliases = remote_state->remotes[i]->pushurl_nr == 0;
-		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
+		add_pushurl_aliases = remote_state->remotes[i]->pushurl.nr == 0;
+		for (j = 0; j < remote_state->remotes[i]->url.nr; j++) {
 			char *alias;
 			if (add_pushurl_aliases)
 				add_pushurl_alias(
 					remote_state, remote_state->remotes[i],
-					remote_state->remotes[i]->url[j]);
-			alias = alias_url(remote_state->remotes[i]->url[j],
+					remote_state->remotes[i]->url.v[j]);
+			alias = alias_url(remote_state->remotes[i]->url.v[j],
 					  &remote_state->rewrites);
-			if (alias) {
-				free((char *)remote_state->remotes[i]->url[j]);
-				remote_state->remotes[i]->url[j] = alias;
-			}
+			if (alias)
+				strvec_replace(&remote_state->remotes[i]->url,
+					       j, alias);
 		}
 	}
 }
@@ -653,10 +643,10 @@ static void validate_remote_url(struct remote *remote)
 	else
 		die(_("unrecognized value transfer.credentialsInUrl: '%s'"), value);
 
-	for (i = 0; i < remote->url_nr; i++) {
+	for (i = 0; i < remote->url.nr; i++) {
 		struct url_info url_info = { 0 };
 
-		if (!url_normalize(remote->url[i], &url_info) ||
+		if (!url_normalize(remote->url.v[i], &url_info) ||
 		    !url_info.passwd_off)
 			goto loop_cleanup;
 
@@ -830,8 +820,8 @@ struct ref *ref_remove_duplicates(struct ref *ref_map)
 int remote_has_url(struct remote *remote, const char *url)
 {
 	int i;
-	for (i = 0; i < remote->url_nr; i++) {
-		if (!strcmp(remote->url[i], url))
+	for (i = 0; i < remote->url.nr; i++) {
+		if (!strcmp(remote->url.v[i], url))
 			return 1;
 	}
 	return 0;
diff --git a/remote.h b/remote.h
index e8c6655e42..84dc91cca0 100644
--- a/remote.h
+++ b/remote.h
@@ -4,6 +4,7 @@
 #include "hash-ll.h"
 #include "hashmap.h"
 #include "refspec.h"
+#include "strvec.h"
 
 struct option;
 struct transport_ls_refs_options;
@@ -68,16 +69,9 @@ struct remote {
 	char *foreign_vcs;
 
 	/* An array of all of the url_nr URLs configured for the remote */
-	const char **url;
-
-	int url_nr;
-	int url_alloc;
-
+	struct strvec url;
 	/* An array of all of the pushurl_nr push URLs configured for the remote */
-	const char **pushurl;
-
-	int pushurl_nr;
-	int pushurl_alloc;
+	struct strvec pushurl;
 
 	struct refspec push;
 
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 09dc78733c..3285dd962e 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -88,7 +88,7 @@ static int cmd_ls_remote(int argc, const char **argv)
 			die(_("bad repository '%s'"), dest);
 		die(_("no remote configured to get bundle URIs from"));
 	}
-	if (!remote->url_nr)
+	if (!remote->url.nr)
 		die(_("remote '%s' has no configured URL"), dest);
 
 	transport = transport_get(remote, NULL);
diff --git a/transport.c b/transport.c
index 83ddea8fbc..eba92eb7e0 100644
--- a/transport.c
+++ b/transport.c
@@ -1127,8 +1127,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	helper = remote->foreign_vcs;
 
-	if (!url && remote->url)
-		url = remote->url[0];
+	if (!url && remote->url.nr)
+		url = remote->url.v[0];
 	ret->url = url;
 
 	/* maybe it is a foreign URL? */
-- 
2.45.2.937.g0bcb3c087a

