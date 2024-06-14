Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78ED13BAC8
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361726; cv=none; b=C6zqY3JQmqs8QnhYhXGFMaCMJAuoZWIU099fyOgoh3SoanJS3s9QwDE0jMIvcsa4jBi7lV6uxRFCh+ZymR2B/FLQqaUDHJjVraDrDiGO3g1Y/PBSTKLsEvk21L/5t3A8XFBlHdByP0mpBg2cbkaK0OADvsJx0P9UFgtlOyd1t7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361726; c=relaxed/simple;
	bh=dkSZC39SCnAjEk5DVcrbXGSFMQodQvnILwNYFOAKvIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffVIIY1xUNVmbyUeXbvczjpNHocx4s/D5a9onw5S2TjEUhPsnLZdg8/J6okFCoABhrlcPuq34vZrGxB9uQI/lppw45LP/WAN5daKFJXBw6pxTPkeuWzyNmRPAvgeJ/8MY1c0rw8ytZYrUGoCiUhQ+YUPUF1f9Pc5q4yl3A4OMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16646 invoked by uid 109); 14 Jun 2024 10:42:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:42:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27425 invoked by uid 111); 14 Jun 2024 10:42:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:42:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:42:03 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 11/11] remote: drop checks for zero-url case
Message-ID: <20240614104203.GK222445@coredump.intra.peff.net>
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

Now that the previous commit removed the possibility that a "struct
remote" will ever have zero url fields, we can drop a number of
redundant checks and untriggerable code paths.

Signed-off-by: Jeff King <peff@peff.net>
---
Note for reviewers: the hunk in builtin/push.c is funny. The original
code was:

  if (url->nr) {
	for (i = 0; i < url->nr; i++) {
		do this
	}
  } else {
    do that
  }

And I removed the "do that" part along with the if/else to become:

  for (i = 0; i < url->nr; i++) {
	do this
  }


But because "this" and "that" were so similar, and because the
indentation of "this" in the loop was now the same of the old "that",
the diff makes it look like I dropped the first half of the conditional.

 builtin/archive.c          |  2 --
 builtin/ls-remote.c        |  2 --
 builtin/push.c             | 13 ++-----------
 builtin/remote.c           | 13 +++----------
 t/helper/test-bundle-uri.c |  2 --
 transport.c                | 17 +++++++----------
 6 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 0d9aff7e6f..7234607aaa 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -31,8 +31,6 @@ static int run_remote_archiver(int argc, const char **argv,
 	struct packet_reader reader;
 
 	_remote = remote_get(remote);
-	if (!_remote->url.nr)
-		die(_("git archive: Remote with no URL"));
 	transport = transport_get(_remote, _remote->url.v[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 4c04dbbf19..8f3a64d838 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -109,8 +109,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			die("bad repository '%s'", dest);
 		die("No remote configured to list refs from.");
 	}
-	if (!remote->url.nr)
-		die("remote %s has no configured URL", dest);
 
 	if (get_url) {
 		printf("%s\n", remote->url.v[0]);
diff --git a/builtin/push.c b/builtin/push.c
index 00d99af1a8..8260c6e46a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -438,18 +438,9 @@ static int do_push(int flags,
 	}
 	errs = 0;
 	url = push_url_of_remote(remote);
-	if (url->nr) {
-		for (i = 0; i < url->nr; i++) {
-			struct transport *transport =
-				transport_get(remote, url->v[i]);
-			if (flags & TRANSPORT_PUSH_OPTIONS)
-				transport->push_options = push_options;
-			if (push_with_options(transport, push_refspec, flags))
-				errs++;
-		}
-	} else {
+	for (i = 0; i < url->nr; i++) {
 		struct transport *transport =
-			transport_get(remote, NULL);
+			transport_get(remote, url->v[i]);
 		if (flags & TRANSPORT_PUSH_OPTIONS)
 			transport->push_options = push_options;
 		if (push_with_options(transport, push_refspec, flags))
diff --git a/builtin/remote.c b/builtin/remote.c
index 06c09ed060..c5c94d4dbd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1002,8 +1002,7 @@ static int get_remote_ref_states(const char *name,
 		struct transport *transport;
 		const struct ref *remote_refs;
 
-		transport = transport_get(states->remote, states->remote->url.nr > 0 ?
-			states->remote->url.v[0] : NULL);
+		transport = transport_get(states->remote, states->remote->url.v[0]);
 		remote_refs = transport_get_remote_refs(transport, NULL);
 
 		states->queried = 1;
@@ -1294,8 +1293,7 @@ static int show(int argc, const char **argv, const char *prefix)
 		get_remote_ref_states(*argv, &info.states, query_flag);
 
 		printf_ln(_("* remote %s"), *argv);
-		printf_ln(_("  Fetch URL: %s"), info.states.remote->url.nr > 0 ?
-		       info.states.remote->url.v[0] : _("(no URL)"));
+		printf_ln(_("  Fetch URL: %s"), info.states.remote->url.v[0]);
 		url = push_url_of_remote(info.states.remote);
 		for (i = 0; i < url->nr; i++)
 			/*
@@ -1440,10 +1438,7 @@ static int prune_remote(const char *remote, int dry_run)
 	}
 
 	printf_ln(_("Pruning %s"), remote);
-	printf_ln(_("URL: %s"),
-		  states.remote->url.nr
-		  ? states.remote->url.v[0]
-		  : _("(no URL)"));
+	printf_ln(_("URL: %s"), states.remote->url.v[0]);
 
 	for_each_string_list_item(item, &states.stale)
 		string_list_append(&refs_to_prune, item->util);
@@ -1632,8 +1627,6 @@ static int get_url(int argc, const char **argv, const char *prefix)
 	}
 
 	url = push_mode ? push_url_of_remote(remote) : &remote->url;
-	if (!url->nr)
-		die(_("no URLs configured for remote '%s'"), remotename);
 
 	if (all_mode) {
 		for (i = 0; i < url->nr; i++)
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 3285dd962e..0c5fa723d8 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -88,8 +88,6 @@ static int cmd_ls_remote(int argc, const char **argv)
 			die(_("bad repository '%s'"), dest);
 		die(_("no remote configured to get bundle URIs from"));
 	}
-	if (!remote->url.nr)
-		die(_("remote '%s' has no configured URL"), dest);
 
 	transport = transport_get(remote, NULL);
 	if (transport_get_remote_bundle_uri(transport) < 0) {
diff --git a/transport.c b/transport.c
index eba92eb7e0..a324045240 100644
--- a/transport.c
+++ b/transport.c
@@ -1112,6 +1112,7 @@ static struct transport_vtable builtin_smart_vtable = {
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
+	const char *p;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->progress = isatty(2);
@@ -1127,19 +1128,15 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->remote = remote;
 	helper = remote->foreign_vcs;
 
-	if (!url && remote->url.nr)
+	if (!url)
 		url = remote->url.v[0];
 	ret->url = url;
 
-	/* maybe it is a foreign URL? */
-	if (url) {
-		const char *p = url;
-
-		while (is_urlschemechar(p == url, *p))
-			p++;
-		if (starts_with(p, "::"))
-			helper = xstrndup(url, p - url);
-	}
+	p = url;
+	while (is_urlschemechar(p == url, *p))
+		p++;
+	if (starts_with(p, "::"))
+		helper = xstrndup(url, p - url);
 
 	if (helper) {
 		transport_helper_init(ret, helper);
-- 
2.45.2.937.g0bcb3c087a
