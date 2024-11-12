Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5520DD75
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400780; cv=none; b=kW3SibzgvmUswChfqz7etFmv+nfqoNWYMD0plA/oI/d19TaTmY7/jw6dlPtNB9lQotpL16aZNeShUdJU7JMHlwQdak4FZDe4ia8scA884a/pJ51UOXurgiJaxwaUkzu9G0K7bAjy6G/yMVP4v/krm9h/48pZkqIlzkbepoK53c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400780; c=relaxed/simple;
	bh=vgV7HyAYrSn5zoOe0sTTL5WCuoRwMpBDU4//8vYJwfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7Ei8KietEYRDGqSjsLWiora2jBsa/GIKGDQO5LqGDpiVkrDzXCip3D03Dxm3F+asJPa9PatArHYu896fkFVqzRCn09ZvHy7yeGPoimOcc36rj7mrtVMks4zd3LDvlgJqtCf5ir1SceEBv8sXhtAvCZ4n1BDBvtKvSudE1iRx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XCERSCo2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XCERSCo2"
Received: (qmail 30348 invoked by uid 109); 12 Nov 2024 08:39:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vgV7HyAYrSn5zoOe0sTTL5WCuoRwMpBDU4//8vYJwfo=; b=XCERSCo2eZqynJuu56d2zbEDzIFHHo+H4QNluHmDnr2IhHAc8w8gtWBQpagWBEv5oEF4MuoOw7c1Gxzhnnd/2kpLjaS0guTnb8UjEhIzP5NcC2w0sBfYxIxJpsMrRYSm2e6h5wanPMKlGBGi1weJTqXYl/SPAL+E/oDQFUy9EW5IWQLMVhN72pnog1I7XEkbJh1W5SNOtWmwQKflYFN1q4JBVAsXaLwG8WyjtAVGi/nEviluU8AIQcYDkyVWZdW9A8KNcEgnC+c3lZKY6oSTKX77eU/yjQRXWFIu5Z3T6+RTURjK/0nxTanPETjaTd2oeizQQw0ItK/qbmPWdKbkWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 08:39:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27586 invoked by uid 111); 12 Nov 2024 08:39:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 03:39:42 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 03:39:37 -0500
From: Jeff King <peff@peff.net>
To: Eric Mills <ermills@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 3/3] refspec: store raw refspecs inside refspec_item
Message-ID: <20241112083937.GC3529122@coredump.intra.peff.net>
References: <20241112083204.GA2636868@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112083204.GA2636868@coredump.intra.peff.net>

The refspec struct keeps two matched arrays: one for the refspec_item
structs and one for the original raw refspec strings. The main reason
for this is that there are other users of refspec_item that do not care
about the raw strings. But it does make managing the refspec struct
awkward, as we must keep the two arrays in sync. This has led to bugs in
the past (both leaks and double-frees).

Let's just store a copy of the raw refspec string directly in each
refspec_item struct. This simplifies the handling at a small cost:

  1. Direct callers of refspec_item_init() will now get an extra copy of
     the refspec string, even if they don't need it. This should be
     negligible, as the struct is already allocating two strings for the
     parsed src/dst values (and we tend to only do it sparingly anyway
     for things like the TAG_REFSPEC literal).

  2. Users of refspec_appendf() will now generate a temporary string,
     copy it, and then free the result (versus handing off ownership of
     the temporary string). We could get around this by having a "nodup"
     variant of refspec_item_init(), but it doesn't seem worth the extra
     complexity for something that is not remotely a hot code path.

Code which accesses refspec->raw now needs to look at refspec->item.raw.
Other callers which just use refspec_item directly can remain the same.
We'll free the allocated string in refspec_item_clear(), which they
should be calling anyway to free src/dst.

One subtle note: refspec_item_init() can return an error, in which case
we'll still have set its "raw" field. But that is also true of the "src"
and "dst" fields, so any caller which does not _clear() the failed item
is already potentially leaking. In practice most code just calls die()
on an error anyway, but you can see the exception in valid_fetch_refspec(),
which does correctly call _clear() even on error.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c  |  8 ++------
 builtin/remote.c |  8 ++++----
 refspec.c        | 25 +++++++++----------------
 refspec.h        |  5 ++---
 submodule.c      |  4 ++--
 5 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d9027e4dc9..0874da55d1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -454,14 +454,10 @@ static void filter_prefetch_refspec(struct refspec *rs)
 				 ref_namespace[NAMESPACE_TAGS].ref))) {
 			int j;
 
-			free(rs->items[i].src);
-			free(rs->items[i].dst);
-			free(rs->raw[i]);
+			refspec_item_clear(&rs->items[i]);
 
-			for (j = i + 1; j < rs->nr; j++) {
+			for (j = i + 1; j < rs->nr; j++)
 				rs->items[j - 1] = rs->items[j];
-				rs->raw[j - 1] = rs->raw[j];
-			}
 			rs->nr--;
 			i--;
 			continue;
diff --git a/builtin/remote.c b/builtin/remote.c
index 875d6c3bad..9093600965 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -377,7 +377,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	for (i = 0; i < states->remote->fetch.nr; i++)
 		if (get_fetch_map(remote_refs, &states->remote->fetch.items[i], &tail, 1))
 			die(_("Could not get fetch map for refspec %s"),
-				states->remote->fetch.raw[i]);
+				states->remote->fetch.items[i].raw);
 
 	for (ref = fetch_map; ref; ref = ref->next) {
 		if (omit_name_by_refspec(ref->name, &states->remote->fetch))
@@ -634,11 +634,11 @@ static int migrate_file(struct remote *remote)
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push.nr; i++)
-		git_config_set_multivar(buf.buf, remote->push.raw[i], "^$", 0);
+		git_config_set_multivar(buf.buf, remote->push.items[i].raw, "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch.nr; i++)
-		git_config_set_multivar(buf.buf, remote->fetch.raw[i], "^$", 0);
+		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
@@ -768,7 +768,7 @@ static int mv(int argc, const char **argv, const char *prefix)
 			char *ptr;
 
 			strbuf_reset(&buf2);
-			strbuf_addstr(&buf2, oldremote->fetch.raw[i]);
+			strbuf_addstr(&buf2, oldremote->fetch.items[i].raw);
 			ptr = strstr(buf2.buf, old_remote_context.buf);
 			if (ptr) {
 				refspec_updated = 1;
diff --git a/refspec.c b/refspec.c
index 8e8ee8542d..994901f55b 100644
--- a/refspec.c
+++ b/refspec.c
@@ -153,6 +153,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
 {
 	memset(item, 0, sizeof(*item));
+	item->raw = xstrdup(refspec);
 	return parse_refspec(item, refspec, fetch);
 }
 
@@ -167,6 +168,7 @@ void refspec_item_clear(struct refspec_item *item)
 {
 	FREE_AND_NULL(item->src);
 	FREE_AND_NULL(item->dst);
+	FREE_AND_NULL(item->raw);
 	item->force = 0;
 	item->pattern = 0;
 	item->matching = 0;
@@ -179,7 +181,7 @@ void refspec_init(struct refspec *rs, int fetch)
 	rs->fetch = fetch;
 }
 
-static void refspec_append_nodup(struct refspec *rs, char *refspec)
+void refspec_append(struct refspec *rs, const char *refspec)
 {
 	struct refspec_item item;
 
@@ -188,24 +190,20 @@ static void refspec_append_nodup(struct refspec *rs, char *refspec)
 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
 	rs->items[rs->nr] = item;
 
-	ALLOC_GROW(rs->raw, rs->nr + 1, rs->raw_alloc);
-	rs->raw[rs->nr] = refspec;
-
 	rs->nr++;
 }
 
-void refspec_append(struct refspec *rs, const char *refspec)
-{
-	refspec_append_nodup(rs, xstrdup(refspec));
-}
-
 void refspec_appendf(struct refspec *rs, const char *fmt, ...)
 {
 	va_list ap;
+	char *buf;
 
 	va_start(ap, fmt);
-	refspec_append_nodup(rs, xstrvfmt(fmt, ap));
+	buf = xstrvfmt(fmt, ap);
 	va_end(ap);
+
+	refspec_append(rs, buf);
+	free(buf);
 }
 
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr)
@@ -219,18 +217,13 @@ void refspec_clear(struct refspec *rs)
 {
 	int i;
 
-	for (i = 0; i < rs->nr; i++) {
+	for (i = 0; i < rs->nr; i++)
 		refspec_item_clear(&rs->items[i]);
-		free(rs->raw[i]);
-	}
 
 	FREE_AND_NULL(rs->items);
 	rs->alloc = 0;
 	rs->nr = 0;
 
-	FREE_AND_NULL(rs->raw);
-	rs->raw_alloc = 0;
-
 	rs->fetch = 0;
 }
 
diff --git a/refspec.h b/refspec.h
index 0461c9def6..69d693c87d 100644
--- a/refspec.h
+++ b/refspec.h
@@ -26,6 +26,8 @@ struct refspec_item {
 
 	char *src;
 	char *dst;
+
+	char *raw;
 };
 
 #define REFSPEC_FETCH 1
@@ -43,9 +45,6 @@ struct refspec {
 	int alloc;
 	int nr;
 
-	char **raw;
-	int raw_alloc;
-
 	int fetch;
 };
 
diff --git a/submodule.c b/submodule.c
index 307f73fb5b..7ec564854d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1175,7 +1175,7 @@ static int push_submodule(const char *path,
 			int i;
 			strvec_push(&cp.args, remote->name);
 			for (i = 0; i < rs->nr; i++)
-				strvec_push(&cp.args, rs->raw[i]);
+				strvec_push(&cp.args, rs->items[i].raw);
 		}
 
 		prepare_submodule_repo_env(&cp.env);
@@ -1210,7 +1210,7 @@ static void submodule_push_check(const char *path, const char *head,
 	strvec_push(&cp.args, remote->name);
 
 	for (i = 0; i < rs->nr; i++)
-		strvec_push(&cp.args, rs->raw[i]);
+		strvec_push(&cp.args, rs->items[i].raw);
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-- 
2.47.0.508.g57228aee23
