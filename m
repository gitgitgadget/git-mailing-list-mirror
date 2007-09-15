From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/5] Remove unnecessary 'fetch' argument from transport_get API
Date: Sat, 15 Sep 2007 03:23:14 -0400
Message-ID: <20070915072314.GE20346@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWS06-0003fr-6R
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXIOHXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXIOHXT
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:23:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35954 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbXIOHXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:23:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWRzn-0006i9-1g; Sat, 15 Sep 2007 03:23:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0200B20FBAE; Sat, 15 Sep 2007 03:23:15 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58225>

We don't actually need to know at the time of transport_get if the
caller wants to fetch, push, or do both on the returned object.
It is easier to just delay the initialization of the HTTP walker
until we know we will need it by providing a CURL specific fetch
function in the curl_transport that makes sure the walker instance
is initialized before use.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    2 +-
 builtin-push.c  |    2 +-
 transport.c     |   23 +++++++++++++++++------
 transport.h     |    4 +---
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 8b0fdbe..300d563 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -496,7 +496,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	else
 		remote = remote_get(argv[i++]);
 
-	transport = transport_get(remote, remote->uri[0], 1);
+	transport = transport_get(remote, remote->uri[0]);
 	if (verbose >= 2)
 		transport->verbose = 1;
 	if (quiet)
diff --git a/builtin-push.c b/builtin-push.c
index f496b46..7d7e826 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -59,7 +59,7 @@ static int do_push(const char *repo, int flags)
 	errs = 0;
 	for (i = 0; i < remote->uri_nr; i++) {
 		struct transport *transport =
-			transport_get(remote, remote->uri[i], 0);
+			transport_get(remote, remote->uri[i]);
 		int err;
 		if (receivepack)
 			transport_set_option(transport,
diff --git a/transport.c b/transport.c
index 5eabe8d..7f94d30 100644
--- a/transport.c
+++ b/transport.c
@@ -174,6 +174,14 @@ static struct ref *get_refs_via_curl(const struct transport *transport)
 	return refs;
 }
 
+static int fetch_objs_via_curl(struct transport *transport,
+				 int nr_objs, struct ref **to_fetch)
+{
+	if (!transport->data)
+		transport->data = get_http_walker(transport->url);
+	return fetch_objs_via_walker(transport, nr_objs, to_fetch);
+}
+
 #else
 
 static struct ref *get_refs_via_curl(const struct transport *transport)
@@ -182,12 +190,19 @@ static struct ref *get_refs_via_curl(const struct transport *transport)
 	return NULL;
 }
 
+static int fetch_objs_via_curl(struct transport *transport,
+				 int nr_objs, struct ref **to_fetch)
+{
+	die("Cannot fetch from '%s' without curl ...", transport->url);
+	return -1;
+}
+
 #endif
 
 static const struct transport_ops curl_transport = {
 	/* set_option */	NULL,
 	/* get_refs_list */	get_refs_via_curl,
-	/* fetch */		fetch_objs_via_walker,
+	/* fetch */		fetch_objs_via_curl,
 	/* push */		curl_transport_push,
 	/* disconnect */	disconnect_walker
 };
@@ -408,14 +423,12 @@ static int is_file(const char *url)
 	return S_ISREG(buf.st_mode);
 }
 
-struct transport *transport_get(struct remote *remote, const char *url,
-				int fetch)
+struct transport *transport_get(struct remote *remote, const char *url)
 {
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->remote = remote;
 	ret->url = url;
-	ret->fetch = !!fetch;
 
 	if (!prefixcmp(url, "rsync://")) {
 		ret->ops = &rsync_transport;
@@ -423,8 +436,6 @@ struct transport *transport_get(struct remote *remote, const char *url,
 	        || !prefixcmp(url, "https://")
 	        || !prefixcmp(url, "ftp://")) {
 		ret->ops = &curl_transport;
-		if (fetch)
-			ret->data = get_http_walker(url);
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
diff --git a/transport.h b/transport.h
index f2bbdf7..6a95d66 100644
--- a/transport.h
+++ b/transport.h
@@ -6,7 +6,6 @@
 
 struct transport {
 	unsigned verbose : 1;
-	unsigned fetch : 1;
 	struct remote *remote;
 	const char *url;
 
@@ -38,8 +37,7 @@ struct transport_ops {
 };
 
 /* Returns a transport suitable for the url */
-struct transport *transport_get(struct remote *remote, const char *url,
-				int fetch);
+struct transport *transport_get(struct remote *, const char *);
 
 /* Transport options which apply to git:// and scp-style URLs */
 
-- 
1.5.3.1.84.gaf82-dirty
