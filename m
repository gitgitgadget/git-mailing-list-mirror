Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1819414D
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360953; cv=none; b=DxeapnlyR6B9j+LLZloFPmhCKOvwrthgu0uow2kwnn59Tl7E1Kqy23vCyPXKBE0E5wR+ULPWcottHWOZwBhTZNshNiA4fkJXoF0wY0mx3nj94apOZZ9DM5eQPGVzJHuM1KAGQW5u9AvqRe7yZSQeYqOkleeSSEZWgPfdIFLtHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360953; c=relaxed/simple;
	bh=z41xdbzz69RRqt219UK4TBopdnj0ry7B/Fd2ZGO9sM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0/w7hNOyvdvzpA6Ejt3H1BuUcKi2FY4mUedV5/RmSK+6ZfJWAQuOZW9+SszjHpcaQ3J3fZHiCPx4J1olQkpgnYx2rs/ZmU/p9l1e/9L9JYlkJV0xDvYqMnaltvQkf942YPCgf4+mxL22IN+6/6GZwm2M+QyPMxNnjxz8uTidV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16538 invoked by uid 109); 14 Jun 2024 10:29:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:29:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27114 invoked by uid 111); 14 Jun 2024 10:29:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:29:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:29:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 05/11] remote: simplify url/pushurl selection
Message-ID: <20240614102909.GE222445@coredump.intra.peff.net>
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

When we want to know the push urls for a remote, there is some simple
logic:

  - if the user configured any remote.*.pushurl keys, then those make
    the complete set of push urls

  - otherwise we push to all urls in remote.*.url

Many spots implement this with a level of indirection, assigning to a
local url/url_nr pair. But since both arrays are now strvecs, we can
just use a pointer to select the appropriate strvec, shortening the code
a bit.

Even though this is now a one-liner, since it is application logic that
is present in so many places, it's worth abstracting a helper function.
In fact, we already have such a function, but it's local to
builtin/push.c. So we'll just make it available everywhere via remote.h.

There are two spots to pay special attention to here:

  1. in builtin/remote.c's get_url(), we are selecting first based on
     push_mode and then falling back to "url" when we're in push_mode
     but no pushurl is defined. The updated code makes that much more
     clear, compared to the original which had an "else" fall-through.

  2. likewise in that file's set_url(), we _only_ respect push_mode,
     sine the point is that we are adding to pushurl in that case
     (whether it is empty or not). And thus it does not use our helper
     function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/push.c   | 21 ++++-----------
 builtin/remote.c | 69 ++++++++++++++----------------------------------
 remote.c         |  5 ++++
 remote.h         |  1 +
 4 files changed, 31 insertions(+), 65 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 61b5d3afdd..00d99af1a8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -141,16 +141,6 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 	free_refs(local_refs);
 }
 
-static int push_url_of_remote(struct remote *remote, const char ***url_p)
-{
-	if (remote->pushurl.nr) {
-		*url_p = remote->pushurl.v;
-		return remote->pushurl.nr;
-	}
-	*url_p = remote->url.v;
-	return remote->url.nr;
-}
-
 static NORETURN void die_push_simple(struct branch *branch,
 				     struct remote *remote)
 {
@@ -434,8 +424,7 @@ static int do_push(int flags,
 		   struct remote *remote)
 {
 	int i, errs;
-	const char **url;
-	int url_nr;
+	struct strvec *url;
 	struct refspec *push_refspec = &rs;
 
 	if (push_options->nr)
@@ -448,11 +437,11 @@ static int do_push(int flags,
 			setup_default_push_refspecs(&flags, remote);
 	}
 	errs = 0;
-	url_nr = push_url_of_remote(remote, &url);
-	if (url_nr) {
-		for (i = 0; i < url_nr; i++) {
+	url = push_url_of_remote(remote);
+	if (url->nr) {
+		for (i = 0; i < url->nr; i++) {
 			struct transport *transport =
-				transport_get(remote, url[i]);
+				transport_get(remote, url->v[i]);
 			if (flags & TRANSPORT_PUSH_OPTIONS)
 				transport->push_options = push_options;
 			if (push_with_options(transport, push_refspec, flags))
diff --git a/builtin/remote.c b/builtin/remote.c
index ee6a33ff11..06c09ed060 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1213,8 +1213,8 @@ static int get_one_entry(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 	struct strbuf remote_info_buf = STRBUF_INIT;
-	const char **url;
-	int i, url_nr;
+	struct strvec *url;
+	int i;
 
 	if (remote->url.nr > 0) {
 		struct strbuf promisor_config = STRBUF_INIT;
@@ -1230,16 +1230,10 @@ static int get_one_entry(struct remote *remote, void *priv)
 				strbuf_detach(&remote_info_buf, NULL);
 	} else
 		string_list_append(list, remote->name)->util = NULL;
-	if (remote->pushurl.nr) {
-		url = remote->pushurl.v;
-		url_nr = remote->pushurl.nr;
-	} else {
-		url = remote->url.v;
-		url_nr = remote->url.nr;
-	}
-	for (i = 0; i < url_nr; i++)
+	url = push_url_of_remote(remote);
+	for (i = 0; i < url->nr; i++)
 	{
-		strbuf_addf(&remote_info_buf, "%s (push)", url[i]);
+		strbuf_addf(&remote_info_buf, "%s (push)", url->v[i]);
 		string_list_append(list, remote->name)->util =
 				strbuf_detach(&remote_info_buf, NULL);
 	}
@@ -1295,28 +1289,21 @@ static int show(int argc, const char **argv, const char *prefix)
 
 	for (; argc; argc--, argv++) {
 		int i;
-		const char **url;
-		int url_nr;
+		struct strvec *url;
 
 		get_remote_ref_states(*argv, &info.states, query_flag);
 
 		printf_ln(_("* remote %s"), *argv);
 		printf_ln(_("  Fetch URL: %s"), info.states.remote->url.nr > 0 ?
 		       info.states.remote->url.v[0] : _("(no URL)"));
-		if (info.states.remote->pushurl.nr) {
-			url = info.states.remote->pushurl.v;
-			url_nr = info.states.remote->pushurl.nr;
-		} else {
-			url = info.states.remote->url.v;
-			url_nr = info.states.remote->url.nr;
-		}
-		for (i = 0; i < url_nr; i++)
+		url = push_url_of_remote(info.states.remote);
+		for (i = 0; i < url->nr; i++)
 			/*
 			 * TRANSLATORS: the colon ':' should align
 			 * with the one in " Fetch URL: %s"
 			 * translation.
 			 */
-			printf_ln(_("  Push  URL: %s"), url[i]);
+			printf_ln(_("  Push  URL: %s"), url->v[i]);
 		if (!i)
 			printf_ln(_("  Push  URL: %s"), _("(no URL)"));
 		if (no_query)
@@ -1622,8 +1609,7 @@ static int get_url(int argc, const char **argv, const char *prefix)
 	int i, push_mode = 0, all_mode = 0;
 	const char *remotename = NULL;
 	struct remote *remote;
-	const char **url;
-	int url_nr;
+	struct strvec *url;
 	struct option options[] = {
 		OPT_BOOL('\0', "push", &push_mode,
 			 N_("query push URLs rather than fetch URLs")),
@@ -1645,27 +1631,15 @@ static int get_url(int argc, const char **argv, const char *prefix)
 		exit(2);
 	}
 
-	url_nr = 0;
-	if (push_mode) {
-		url = remote->pushurl.v;
-		url_nr = remote->pushurl.nr;
-	}
-	/* else fetch mode */
-
-	/* Use the fetch URL when no push URLs were found or requested. */
-	if (!url_nr) {
-		url = remote->url.v;
-		url_nr = remote->url.nr;
-	}
-
-	if (!url_nr)
+	url = push_mode ? push_url_of_remote(remote) : &remote->url;
+	if (!url->nr)
 		die(_("no URLs configured for remote '%s'"), remotename);
 
 	if (all_mode) {
-		for (i = 0; i < url_nr; i++)
-			printf_ln("%s", url[i]);
+		for (i = 0; i < url->nr; i++)
+			printf_ln("%s", url->v[i]);
 	} else {
-		printf_ln("%s", *url);
+		printf_ln("%s", url->v[0]);
 	}
 
 	return 0;
@@ -1680,8 +1654,7 @@ static int set_url(int argc, const char **argv, const char *prefix)
 	const char *oldurl = NULL;
 	struct remote *remote;
 	regex_t old_regex;
-	const char **urlset;
-	int urlset_nr;
+	struct strvec *urlset;
 	struct strbuf name_buf = STRBUF_INIT;
 	struct option options[] = {
 		OPT_BOOL('\0', "push", &push_mode,
@@ -1718,12 +1691,10 @@ static int set_url(int argc, const char **argv, const char *prefix)
 
 	if (push_mode) {
 		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
-		urlset = remote->pushurl.v;
-		urlset_nr = remote->pushurl.nr;
+		urlset = &remote->pushurl;
 	} else {
 		strbuf_addf(&name_buf, "remote.%s.url", remotename);
-		urlset = remote->url.v;
-		urlset_nr = remote->url.nr;
+		urlset = &remote->url;
 	}
 
 	/* Special cases that add new entry. */
@@ -1740,8 +1711,8 @@ static int set_url(int argc, const char **argv, const char *prefix)
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
 		die(_("Invalid old URL pattern: %s"), oldurl);
 
-	for (i = 0; i < urlset_nr; i++)
-		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
+	for (i = 0; i < urlset->nr; i++)
+		if (!regexec(&old_regex, urlset->v[i], 0, NULL, 0))
 			matches++;
 		else
 			negative_matches++;
diff --git a/remote.c b/remote.c
index 76a3e41c73..9417d83e51 100644
--- a/remote.c
+++ b/remote.c
@@ -827,6 +827,11 @@ int remote_has_url(struct remote *remote, const char *url)
 	return 0;
 }
 
+struct strvec *push_url_of_remote(struct remote *remote)
+{
+	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
+}
+
 static int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result)
 {
diff --git a/remote.h b/remote.h
index 84dc91cca0..034f9d6660 100644
--- a/remote.h
+++ b/remote.h
@@ -123,6 +123,7 @@ typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
+struct strvec *push_url_of_remote(struct remote *remote);
 
 struct ref_push_report {
 	const char *ref_name;
-- 
2.45.2.937.g0bcb3c087a

