From: Jeff King <peff@peff.net>
Subject: [PATCH 09/14] remote-curl: auto-detect bundles when fetching refs
Date: Thu, 10 Nov 2011 02:50:52 -0500
Message-ID: <20111110075052.GI27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPPZ-0003gi-8t
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602Ab1KJHu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:50:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38925
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab1KJHuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:50:55 -0500
Received: (qmail 22494 invoked by uid 107); 10 Nov 2011 07:50:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:50:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:50:52 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185207>

You can't currently fetch from a network bundle, like:

  git fetch http://example.com/foo.bundle

This patch takes the first (and biggest) step towards that
working: it auto-detects when fetching refs results in a
bundle, and automatically spools the bundle to disk and
fetches from it.

There are a few important design decisions to note:

  1. We auto-detect the bundle based on content, not based
     on a special token in the URL (like ending in
     ".bundle"). This lets the server side be flexible with
     its URLs (e.g., "http://example.com/bundle?repo=foo").

  2. When fetching refs, we don't actually fetch $URL, but
     start with $URL/info/refs, looking for smart or dumb
     http. Some servers, when file "foo.bundle" exists, will
     serve it to the client when "foo.bundle/info/refs" is
     requested. Therefore we may be "surprised" to receive a
     bundle when we thought we were just getting the list of
     refs, and need to handle it appropriately.

  3. We spool the bundle to disk, and then run "index-pack
     --fix-thin" to create a packfile. That means we will
     momentarily use twice the size of the bundle in local
     disk space. Avoiding this would mean piping directly to
     "index-pack --fix-thin".  However, if we want to be
     able to resume the transfer of the bundle after an
     interruption, then we need to save the bundle's pack.

     In theory a smart index-pack that was interrupted could
     write out its partial results along with a count of how
     many bytes it actually consumed (i.e., where to resume
     next time), and then pick up where it left off when fed
     the rest of the data. But index-pack isn't that smart
     yet, so let's start off with spooling.

No tests yet, as apache is not one of the "surprising"
servers from (2), and our test harness is based around that
(though just with this patch, you can fetch from surprising
servers like lighttpd).

Signed-off-by: Jeff King <peff@peff.net>
---
This is really the big, interesting one.

 remote-curl.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 014d413..84586e0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -7,6 +7,7 @@
 #include "run-command.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "bundle.h"
 
 static struct remote *remote;
 static const char *url; /* always ends with a trailing slash */
@@ -77,6 +78,10 @@ struct discovery {
 	char *buf;
 	size_t len;
 	unsigned proto_git : 1;
+
+	char *bundle_filename;
+	int bundle_fd;
+	struct bundle_header bundle_header;
 };
 static struct discovery *last_discovery;
 
@@ -86,26 +91,93 @@ static void free_discovery(struct discovery *d)
 		if (d == last_discovery)
 			last_discovery = NULL;
 		free(d->buf_alloc);
+		if (d->bundle_fd >= 0)
+			close(d->bundle_fd);
+		if (d->bundle_filename) {
+			unlink(d->bundle_filename);
+			free(d->bundle_filename);
+		}
 		free(d);
 	}
 }
 
 struct get_refs_cb_data {
 	struct strbuf *out;
+
+	int is_bundle;
+	const char *tmpname;
+	FILE *fh;
 };
 
 static size_t get_refs_callback(char *buf, size_t sz, size_t n, void *vdata)
 {
 	struct get_refs_cb_data *data = vdata;
-	strbuf_add(data->out, buf, sz * n);
+	struct strbuf *out = data->out;
+
+	if (data->is_bundle > 0)
+		return fwrite(buf, sz, n, data->fh);
+
+	strbuf_add(out, buf, sz * n);
+
+	if (data->is_bundle == 0)
+		return sz * n;
+
+	data->is_bundle = is_bundle_buf(out->buf, out->len);
+	if (data->is_bundle > 0) {
+		data->fh = fopen(data->tmpname, "wb");
+		if (!data->fh)
+			die_errno("unable to open %s", data->tmpname);
+		if (fwrite(out->buf, 1, out->len, data->fh) < out->len)
+			die_errno("unable to write to %s", data->tmpname);
+	}
 	return sz * n;
 }
 
-static int get_refs_from_url(const char *url, struct strbuf *out, int options)
+static int get_refs_from_url(const char *url, struct strbuf *out, int options,
+			     const char *tmpname, int *is_bundle)
 {
 	struct get_refs_cb_data data;
+	int ret;
+
 	data.out = out;
-	return http_get_callback(url, get_refs_callback, &data, 0, options);
+	data.is_bundle = -1;
+	data.tmpname = tmpname;
+	data.fh = NULL;
+
+	ret = http_get_callback(url, get_refs_callback, &data, 0, options);
+
+	if (data.fh) {
+		if (fclose(data.fh))
+			die_errno("unable to write to %s", data.tmpname);
+	}
+
+	*is_bundle = data.is_bundle > 0;
+	return ret;
+}
+
+static const char *url_to_bundle_tmpfile(const char *url)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int last_was_quoted = 1;
+	const char *ret;
+
+	strbuf_addstr(&buf, "tmp_bundle_");
+	for (; *url; url++) {
+		if (isalpha(*url) || isdigit(*url)) {
+			strbuf_addch(&buf, *url);
+			last_was_quoted = 0;
+		}
+		else if (!last_was_quoted) {
+			strbuf_addch(&buf, '_');
+			last_was_quoted = 1;
+		}
+	}
+	if (last_was_quoted)
+		strbuf_setlen(&buf, buf.len - 1);
+
+	ret = git_path("objects/%s", buf.buf);
+	strbuf_release(&buf);
+	return ret;
 }
 
 static struct discovery* discover_refs(const char *service)
@@ -114,11 +186,15 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options)
 	struct discovery *last = last_discovery;
 	char *refs_url;
 	int http_ret, is_http = 0, proto_git_candidate = 1;
+	const char *filename;
+	int is_bundle;
 
 	if (last && !strcmp(service, last->service))
 		return last;
 	free_discovery(last);
 
+	filename = url_to_bundle_tmpfile(url);
+
 	strbuf_addf(&buffer, "%sinfo/refs", url);
 	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
 		is_http = 1;
@@ -130,7 +206,8 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);
 
-	http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE);
+	http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE,
+				     filename, &is_bundle);
 
 	/* try again with "plain" url (no ? or & appended) */
 	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
@@ -141,7 +218,8 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options)
 		strbuf_addf(&buffer, "%sinfo/refs", url);
 		refs_url = strbuf_detach(&buffer, NULL);
 
-		http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE);
+		http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE,
+					     filename, &is_bundle);
 	}
 
 	switch (http_ret) {
@@ -161,6 +239,7 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options)
 	last->service = service;
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
+	last->bundle_fd = -1;
 
 	if (is_http && proto_git_candidate
 		&& 5 <= last->len && last->buf[4] == '#') {
@@ -190,6 +269,10 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options)
 		last->proto_git = 1;
 	}
 
+	else if (is_bundle) {
+		last->bundle_filename = xstrdup(filename);
+	}
+
 	free(refs_url);
 	strbuf_release(&buffer);
 	last_discovery = last;
@@ -276,6 +359,22 @@ static int write_discovery(int in, int out, void *data)
 	return refs;
 }
 
+static void ensure_bundle_open(struct discovery *heads)
+{
+	if (heads->bundle_fd >= 0)
+		return;
+	heads->bundle_fd = read_bundle_header(heads->bundle_filename,
+					      &heads->bundle_header);
+	if (heads->bundle_fd < 0)
+		die("could not read bundle from %s", url);
+}
+
+static struct ref *parse_bundle_refs(struct discovery *heads)
+{
+	ensure_bundle_open(heads);
+	return bundle_header_to_refs(&heads->bundle_header);
+}
+
 static struct ref *get_refs(int for_push)
 {
 	struct discovery *heads;
@@ -287,6 +386,11 @@ static int write_discovery(int in, int out, void *data)
 
 	if (heads->proto_git)
 		return parse_git_refs(heads);
+	if (heads->bundle_filename) {
+		if (for_push)
+			die("cannot push into a remote bundle");
+		return parse_bundle_refs(heads);
+	}
 	return parse_info_refs(heads);
 }
 
@@ -690,11 +794,21 @@ static int fetch_git(struct discovery *heads,
 	return err;
 }
 
+static int fetch_bundle(struct discovery *d,
+			int nr_heads, struct ref **to_fetch)
+{
+	ensure_bundle_open(d);
+	return unbundle(&d->bundle_header, d->bundle_fd,
+			options.progress ? BUNDLE_VERBOSE : 0);
+}
+
 static int fetch(int nr_heads, struct ref **to_fetch)
 {
 	struct discovery *d = discover_refs("git-upload-pack");
 	if (d->proto_git)
 		return fetch_git(d, nr_heads, to_fetch);
+	else if (d->bundle_filename)
+		return fetch_bundle(d, nr_heads, to_fetch);
 	else
 		return fetch_dumb(nr_heads, to_fetch);
 }
-- 
1.7.7.2.7.g9f96f
