From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 02/13] Use an external program to implement fetching with
 curl
Date: Wed, 5 Aug 2009 01:01:56 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050053580.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYe3-0007Gg-PI
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZHEFB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZHEFB7
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:01:59 -0400
Received: from iabervon.org ([66.92.72.58]:36994 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754019AbZHEFB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:01:57 -0400
Received: (qmail 18259 invoked by uid 1000); 5 Aug 2009 05:01:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:01:56 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the transport native helper mechanism to fetch by http (and ftp, etc).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile      |    5 ++
 remote-curl.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport.c   |  136 +-------------------------------------------------------
 3 files changed, 145 insertions(+), 135 deletions(-)
 create mode 100644 remote-curl.c

diff --git a/Makefile b/Makefile
index 504646a..35117fc 100644
--- a/Makefile
+++ b/Makefile
@@ -981,6 +981,7 @@ else
 		CURL_LIBCURL = -lcurl
 	endif
 	BUILTIN_OBJS += builtin-http-fetch.o
+	PROGRAMS += git-remote-http$X git-remote-https$X git-remote-ftp$X git-http-fetch$X
 	EXTLIBS += $(CURL_LIBCURL)
 	LIB_OBJS += http.o http-walker.o
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
@@ -1491,6 +1492,10 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http-walker.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
diff --git a/remote-curl.c b/remote-curl.c
new file mode 100644
index 0000000..ad6a163
--- /dev/null
+++ b/remote-curl.c
@@ -0,0 +1,139 @@
+#include "cache.h"
+#include "remote.h"
+#include "strbuf.h"
+#include "walker.h"
+#include "http.h"
+
+static struct ref *get_refs(struct walker *walker, const char *url)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	char *data, *start, *mid;
+	char *ref_name;
+	char *refs_url;
+	int i = 0;
+	int http_ret;
+
+	struct ref *refs = NULL;
+	struct ref *ref = NULL;
+	struct ref *last_ref = NULL;
+
+	refs_url = xmalloc(strlen(url) + 11);
+	sprintf(refs_url, "%s/info/refs", url);
+
+	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	switch (http_ret) {
+	case HTTP_OK:
+		break;
+	case HTTP_MISSING_TARGET:
+		die("%s not found: did you run git update-server-info on the"
+		    " server?", refs_url);
+	default:
+		http_error(refs_url, http_ret);
+		die("HTTP request failed");
+	}
+
+	data = buffer.buf;
+	start = NULL;
+	mid = data;
+	while (i < buffer.len) {
+		if (!start) {
+			start = &data[i];
+		}
+		if (data[i] == '\t')
+			mid = &data[i];
+		if (data[i] == '\n') {
+			data[i] = 0;
+			ref_name = mid + 1;
+			ref = xmalloc(sizeof(struct ref) +
+				      strlen(ref_name) + 1);
+			memset(ref, 0, sizeof(struct ref));
+			strcpy(ref->name, ref_name);
+			get_sha1_hex(start, ref->old_sha1);
+			if (!refs)
+				refs = ref;
+			if (last_ref)
+				last_ref->next = ref;
+			last_ref = ref;
+			start = NULL;
+		}
+		i++;
+	}
+
+	strbuf_release(&buffer);
+
+	ref = alloc_ref("HEAD");
+	if (!walker->fetch_ref(walker, ref) &&
+	    !resolve_remote_symref(ref, refs)) {
+		ref->next = refs;
+		refs = ref;
+	} else {
+		free(ref);
+	}
+
+	strbuf_release(&buffer);
+	free(refs_url);
+	return refs;
+}
+
+int main(int argc, const char **argv)
+{
+	struct remote *remote;
+	struct strbuf buf = STRBUF_INIT;
+	const char *url;
+	struct walker *walker = NULL;
+
+	setup_git_directory();
+	if (argc < 2) {
+		fprintf(stderr, "Remote needed\n");
+		return 1;
+	}
+
+	remote = remote_get(argv[1]);
+
+	if (argc > 2) {
+		url = argv[2];
+	} else {
+		url = remote->url[0];
+	}
+
+	do {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF)
+			break;
+		if (!prefixcmp(buf.buf, "fetch ")) {
+			char *obj = buf.buf + strlen("fetch ");
+			if (!walker)
+				walker = get_http_walker(url, remote);
+			walker->get_all = 1;
+			walker->get_tree = 1;
+			walker->get_history = 1;
+			walker->get_verbosely = 0;
+			walker->get_recover = 0;
+			if (walker_fetch(walker, 1, &obj, NULL, NULL))
+				die("Fetch failed.");
+			printf("\n");
+			fflush(stdout);
+		} else if (!strcmp(buf.buf, "list")) {
+			struct ref *refs;
+			struct ref *posn;
+			if (!walker)
+				walker = get_http_walker(url, remote);
+			refs = get_refs(walker, url);
+			for (posn = refs; posn; posn = posn->next) {
+				if (posn->symref)
+					printf("@%s %s\n", posn->symref, posn->name);
+				else
+					printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
+			}
+			printf("\n");
+			fflush(stdout);
+		} else if (!strcmp(buf.buf, "capabilities")) {
+			printf("fetch\n");
+			printf("\n");
+			fflush(stdout);
+		} else {
+			return 1;
+		}
+		strbuf_reset(&buf);
+	} while (1);
+	return 0;
+}
diff --git a/transport.c b/transport.c
index de0d587..9935c85 100644
--- a/transport.c
+++ b/transport.c
@@ -1,9 +1,6 @@
 #include "cache.h"
 #include "transport.h"
 #include "run-command.h"
-#ifndef NO_CURL
-#include "http.h"
-#endif
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "send-pack.h"
@@ -352,45 +349,6 @@ static int rsync_transport_push(struct transport *transport,
 	return result;
 }
 
-/* Generic functions for using commit walkers */
-
-#ifndef NO_CURL /* http fetch is the only user */
-static int fetch_objs_via_walker(struct transport *transport,
-				 int nr_objs, const struct ref **to_fetch)
-{
-	char *dest = xstrdup(transport->url);
-	struct walker *walker = transport->data;
-	char **objs = xmalloc(nr_objs * sizeof(*objs));
-	int i;
-
-	walker->get_all = 1;
-	walker->get_tree = 1;
-	walker->get_history = 1;
-	walker->get_verbosely = transport->verbose >= 0;
-	walker->get_recover = 0;
-
-	for (i = 0; i < nr_objs; i++)
-		objs[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
-
-	if (walker_fetch(walker, nr_objs, objs, NULL, NULL))
-		die("Fetch failed.");
-
-	for (i = 0; i < nr_objs; i++)
-		free(objs[i]);
-	free(objs);
-	free(dest);
-	return 0;
-}
-#endif /* NO_CURL */
-
-static int disconnect_walker(struct transport *transport)
-{
-	struct walker *walker = transport->data;
-	if (walker)
-		walker_free(walker);
-	return 0;
-}
-
 #ifndef NO_CURL
 static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
 {
@@ -432,96 +390,6 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	return !!err;
 }
 
-static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
-{
-	struct strbuf buffer = STRBUF_INIT;
-	char *data, *start, *mid;
-	char *ref_name;
-	char *refs_url;
-	int i = 0;
-	int http_ret;
-
-	struct ref *refs = NULL;
-	struct ref *ref = NULL;
-	struct ref *last_ref = NULL;
-
-	struct walker *walker;
-
-	if (for_push)
-		return NULL;
-
-	if (!transport->data)
-		transport->data = get_http_walker(transport->url,
-						transport->remote);
-
-	walker = transport->data;
-
-	refs_url = xmalloc(strlen(transport->url) + 11);
-	sprintf(refs_url, "%s/info/refs", transport->url);
-
-	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
-	switch (http_ret) {
-	case HTTP_OK:
-		break;
-	case HTTP_MISSING_TARGET:
-		die("%s not found: did you run git update-server-info on the"
-		    " server?", refs_url);
-	default:
-		http_error(refs_url, http_ret);
-		die("HTTP request failed");
-	}
-
-	data = buffer.buf;
-	start = NULL;
-	mid = data;
-	while (i < buffer.len) {
-		if (!start)
-			start = &data[i];
-		if (data[i] == '\t')
-			mid = &data[i];
-		if (data[i] == '\n') {
-			data[i] = 0;
-			ref_name = mid + 1;
-			ref = xmalloc(sizeof(struct ref) +
-				      strlen(ref_name) + 1);
-			memset(ref, 0, sizeof(struct ref));
-			strcpy(ref->name, ref_name);
-			get_sha1_hex(start, ref->old_sha1);
-			if (!refs)
-				refs = ref;
-			if (last_ref)
-				last_ref->next = ref;
-			last_ref = ref;
-			start = NULL;
-		}
-		i++;
-	}
-
-	strbuf_release(&buffer);
-
-	ref = alloc_ref("HEAD");
-	if (!walker->fetch_ref(walker, ref) &&
-	    !resolve_remote_symref(ref, refs)) {
-		ref->next = refs;
-		refs = ref;
-	} else {
-		free(ref);
-	}
-
-	strbuf_release(&buffer);
-	free(refs_url);
-	return refs;
-}
-
-static int fetch_objs_via_curl(struct transport *transport,
-				 int nr_objs, const struct ref **to_fetch)
-{
-	if (!transport->data)
-		transport->data = get_http_walker(transport->url,
-						transport->remote);
-	return fetch_objs_via_walker(transport, nr_objs, to_fetch);
-}
-
 #endif
 
 struct bundle_transport_data {
@@ -950,14 +818,12 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	} else if (!prefixcmp(url, "http://")
 	        || !prefixcmp(url, "https://")
 	        || !prefixcmp(url, "ftp://")) {
+		transport_helper_init(ret);
 #ifdef NO_CURL
 		error("git was compiled without libcurl support.");
 #else
-		ret->get_refs_list = get_refs_via_curl;
-		ret->fetch = fetch_objs_via_curl;
 		ret->push = curl_transport_push;
 #endif
-		ret->disconnect = disconnect_walker;
 
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
-- 
1.6.4.rc3.27.g95032.dirty
