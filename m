From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] remote-curl: store url as a strbuf
Date: Sat, 28 Sep 2013 04:35:25 -0400
Message-ID: <20130928083525.GC2782@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpzx-0005Fm-9K
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab3I1If3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:35:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:35177 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754942Ab3I1If1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:35:27 -0400
Received: (qmail 8909 invoked by uid 102); 28 Sep 2013 08:35:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:35:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:35:25 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235497>

We use a strbuf to generate the string containing the remote
URL, but then detach it to a bare pointer. This makes it
harder to later manipulate the URL, as we have forgotten the
length (and the allocation semantics are not as clear).

Let's instead keep the strbuf around. As a bonus, this
eliminates a confusing double-use of the "buf" strbuf in
main(). Prior to this, it was used both for constructing the
url, and for reading commands from stdin.

The downside is that we have to update each call site to
refer to "url.buf" rather than just "url" when they want the
C string.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 7fb092f..5add2cb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -12,7 +12,8 @@ static struct remote *remote;
 #include "credential.h"
 
 static struct remote *remote;
-static const char *url; /* always ends with a trailing slash */
+/* always ends with a trailing slash */
+static struct strbuf url = STRBUF_INIT;
 
 struct options {
 	int verbosity;
@@ -131,7 +132,8 @@ static struct ref *parse_info_refs(struct discovery *heads)
 			mid = &data[i];
 		if (data[i] == '\n') {
 			if (mid - start != 40)
-				die("%sinfo/refs not valid: is this a git repository?", url);
+				die("%sinfo/refs not valid: is this a git repository?",
+				    url.buf);
 			data[i] = 0;
 			ref_name = mid + 1;
 			ref = xmalloc(sizeof(struct ref) +
@@ -150,7 +152,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 	}
 
 	ref = alloc_ref("HEAD");
-	if (!http_fetch_ref(url, ref) &&
+	if (!http_fetch_ref(url.buf, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
 		ref->next = refs;
 		refs = ref;
@@ -213,11 +215,11 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		return last;
 	free_discovery(last);
 
-	strbuf_addf(&refs_url, "%sinfo/refs", url);
-	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
+	strbuf_addf(&refs_url, "%sinfo/refs", url.buf);
+	if ((!prefixcmp(url.buf, "http://") || !prefixcmp(url.buf, "https://")) &&
 	     git_env_bool("GIT_SMART_HTTP", 1)) {
 		maybe_smart = 1;
-		if (!strchr(url, '?'))
+		if (!strchr(url.buf, '?'))
 			strbuf_addch(&refs_url, '?');
 		else
 			strbuf_addch(&refs_url, '&');
@@ -235,13 +237,13 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		break;
 	case HTTP_MISSING_TARGET:
 		show_http_message(&type, &buffer);
-		die("repository '%s' not found", url);
+		die("repository '%s' not found", url.buf);
 	case HTTP_NOAUTH:
 		show_http_message(&type, &buffer);
-		die("Authentication failed for '%s'", url);
+		die("Authentication failed for '%s'", url.buf);
 	default:
 		show_http_message(&type, &buffer);
-		die("unable to access '%s': %s", url, curl_errorstr);
+		die("unable to access '%s': %s", url.buf, curl_errorstr);
 	}
 
 	last= xcalloc(1, sizeof(*last_discovery));
@@ -607,7 +609,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->out = client.out;
 	strbuf_init(&rpc->result, 0);
 
-	strbuf_addf(&buf, "%s%s", url, svc);
+	strbuf_addf(&buf, "%s%s", url.buf, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
@@ -659,7 +661,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	for (i = 0; i < nr_heads; i++)
 		targets[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
 
-	walker = get_http_walker(url);
+	walker = get_http_walker(url.buf);
 	walker->get_all = 1;
 	walker->get_tree = 1;
 	walker->get_history = 1;
@@ -706,7 +708,7 @@ static int fetch_git(struct discovery *heads,
 		depth_arg = strbuf_detach(&buf, NULL);
 		argv[argc++] = depth_arg;
 	}
-	argv[argc++] = url;
+	argv[argc++] = url.buf;
 	argv[argc++] = NULL;
 
 	for (i = 0; i < nr_heads; i++) {
@@ -804,7 +806,7 @@ static int push_dav(int nr_spec, char **specs)
 		argv[argc++] = "--dry-run";
 	if (options.verbosity > 1)
 		argv[argc++] = "--verbose";
-	argv[argc++] = url;
+	argv[argc++] = url.buf;
 	for (i = 0; i < nr_spec; i++)
 		argv[argc++] = specs[i];
 	argv[argc++] = NULL;
@@ -837,7 +839,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	argv_array_push(&args, options.progress ? "--progress" : "--no-progress");
 	for_each_string_list_item(cas_option, &cas_options)
 		argv_array_push(&args, cas_option->string);
-	argv_array_push(&args, url);
+	argv_array_push(&args, url.buf);
 	for (i = 0; i < nr_spec; i++)
 		argv_array_push(&args, specs[i]);
 
@@ -918,14 +920,12 @@ int main(int argc, const char **argv)
 	remote = remote_get(argv[1]);
 
 	if (argc > 2) {
-		end_url_with_slash(&buf, argv[2]);
+		end_url_with_slash(&url, argv[2]);
 	} else {
-		end_url_with_slash(&buf, remote->url[0]);
+		end_url_with_slash(&url, remote->url[0]);
 	}
 
-	url = strbuf_detach(&buf, NULL);
-
-	http_init(remote, url, 0);
+	http_init(remote, url.buf, 0);
 
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
-- 
1.8.4.rc3.19.g9da5bf6
