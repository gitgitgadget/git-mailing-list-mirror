From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/5] Refactor struct transport_ops inlined into struct transport
Date: Wed, 19 Sep 2007 00:49:31 -0400
Message-ID: <20070919044931.GB17107@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrVf-00072u-8l
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 06:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbXISEtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 00:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbXISEtg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 00:49:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38740 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbXISEtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 00:49:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXrVC-0006x6-RX; Wed, 19 Sep 2007 00:49:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CAE3F20FBAE; Wed, 19 Sep 2007 00:49:31 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58676>

Aside from reducing the code by 20 lines this refactoring removes
a level of indirection when trying to access the operations of a
given transport "instance", making the code clearer and easier to
follow.

It also has the nice effect of giving us the benefits of C99 style
struct initialization (namely ".fetch = X") without requiring that
level of language support from our compiler.  We don't need to worry
about new operation methods being added as they will now be NULL'd
out automatically by the xcalloc() we use to create the new struct
transport we supply to the caller.

This pattern already exists in struct walker, so we already have
a precedent for it in Git.  We also don't really need to worry
about any sort of performance decreases that may occur as a result
of filling out 4-8 op pointers when we make a "struct transport".
The extra few CPU cycles this requires over filling in the "struct
transport_ops" is killed by the time it will take Git to actually
*use* one of those functions, as most transport operations are
going over the wire or will be copying object data locally between
two directories.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    3 +-
 transport.c     |   62 +++++++++++++++++++++---------------------------------
 transport.h     |   16 ++++---------
 3 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 997a8ff..2f639cc 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -392,8 +392,7 @@ static int do_fetch(struct transport *transport,
 	if (transport->remote->fetch_tags == -1)
 		no_tags = 1;
 
-	if (!transport->ops || !transport->ops->get_refs_list ||
-	    !transport->ops->fetch)
+	if (!transport->get_refs_list || !transport->fetch)
 		die("Don't know how to fetch from %s", transport->url);
 
 	/* if not appending, truncate FETCH_HEAD */
diff --git a/transport.c b/transport.c
index cc76e3f..d8458dc 100644
--- a/transport.c
+++ b/transport.c
@@ -44,8 +44,6 @@ static int disconnect_walker(struct transport *transport)
 	return 0;
 }
 
-static const struct transport_ops rsync_transport;
-
 static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
 	const char **argv;
 	int argc;
@@ -199,14 +197,6 @@ static int fetch_objs_via_curl(struct transport *transport,
 
 #endif
 
-static const struct transport_ops curl_transport = {
-	/* set_option */	NULL,
-	/* get_refs_list */	get_refs_via_curl,
-	/* fetch */		fetch_objs_via_curl,
-	/* push */		curl_transport_push,
-	/* disconnect */	disconnect_walker
-};
-
 struct bundle_transport_data {
 	int fd;
 	struct bundle_header header;
@@ -249,14 +239,6 @@ static int close_bundle(struct transport *transport)
 	return 0;
 }
 
-static const struct transport_ops bundle_transport = {
-	/* set_option */	NULL,
-	/* get_refs_list */	get_refs_from_bundle,
-	/* fetch */		fetch_refs_from_bundle,
-	/* push */		NULL,
-	/* disconnect */	close_bundle
-};
-
 struct git_transport_data {
 	unsigned thin : 1;
 	unsigned keep : 1;
@@ -401,13 +383,6 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	return !!err;
 }
 
-static const struct transport_ops git_transport = {
-	/* set_option */	set_git_option,
-	/* get_refs_list */	get_refs_via_connect,
-	/* fetch */		fetch_refs_via_pack,
-	/* push */		git_transport_push
-};
-
 static int is_local(const char *url)
 {
 	const char *colon = strchr(url, ':');
@@ -431,18 +406,31 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->url = url;
 
 	if (!prefixcmp(url, "rsync://")) {
-		ret->ops = &rsync_transport;
+		/* not supported; don't populate any ops */
+
 	} else if (!prefixcmp(url, "http://")
 	        || !prefixcmp(url, "https://")
 	        || !prefixcmp(url, "ftp://")) {
-		ret->ops = &curl_transport;
+		ret->get_refs_list = get_refs_via_curl;
+		ret->fetch = fetch_objs_via_curl;
+		ret->push = curl_transport_push;
+		ret->disconnect = disconnect_walker;
+
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
-		ret->ops = &bundle_transport;
+		ret->get_refs_list = get_refs_from_bundle;
+		ret->fetch = fetch_refs_from_bundle;
+		ret->disconnect = close_bundle;
+
 	} else {
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
+		ret->set_option = set_git_option;
+		ret->get_refs_list = get_refs_via_connect;
+		ret->fetch = fetch_refs_via_pack;
+		ret->push = git_transport_push;
+
 		data->thin = 1;
 		data->uploadpack = "git-upload-pack";
 		if (remote && remote->uploadpack)
@@ -451,7 +439,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		if (remote && remote->receivepack)
 			data->receivepack = remote->receivepack;
 		data->unpacklimit = -1;
-		ret->ops = &git_transport;
 	}
 
 	return ret;
@@ -460,24 +447,23 @@ struct transport *transport_get(struct remote *remote, const char *url)
 int transport_set_option(struct transport *transport,
 			 const char *name, const char *value)
 {
-	if (transport->ops->set_option)
-		return transport->ops->set_option(transport, name, value);
+	if (transport->set_option)
+		return transport->set_option(transport, name, value);
 	return 1;
 }
 
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags)
 {
-	if (!transport->ops->push)
+	if (!transport->push)
 		return 1;
-	return transport->ops->push(transport, refspec_nr, refspec, flags);
+	return transport->push(transport, refspec_nr, refspec, flags);
 }
 
 struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->remote_refs)
-		transport->remote_refs =
-			transport->ops->get_refs_list(transport);
+		transport->remote_refs = transport->get_refs_list(transport);
 	return transport->remote_refs;
 }
 
@@ -496,7 +482,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 		heads[nr_heads++] = rm;
 	}
 
-	rc = transport->ops->fetch(transport, nr_heads, heads);
+	rc = transport->fetch(transport, nr_heads, heads);
 	free(heads);
 	return rc;
 }
@@ -513,8 +499,8 @@ void transport_unlock_pack(struct transport *transport)
 int transport_disconnect(struct transport *transport)
 {
 	int ret = 0;
-	if (transport->ops->disconnect)
-		ret = transport->ops->disconnect(transport);
+	if (transport->disconnect)
+		ret = transport->disconnect(transport);
 	free(transport);
 	return ret;
 }
diff --git a/transport.h b/transport.h
index 6a95d66..3e332ff 100644
--- a/transport.h
+++ b/transport.h
@@ -5,22 +5,11 @@
 #include "remote.h"
 
 struct transport {
-	unsigned verbose : 1;
 	struct remote *remote;
 	const char *url;
-
 	void *data;
-
 	struct ref *remote_refs;
 
-	const struct transport_ops *ops;
-	char *pack_lockfile;
-};
-
-#define TRANSPORT_PUSH_ALL 1
-#define TRANSPORT_PUSH_FORCE 2
-
-struct transport_ops {
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
@@ -34,8 +23,13 @@ struct transport_ops {
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
 	int (*disconnect)(struct transport *connection);
+	char *pack_lockfile;
+	unsigned verbose : 1;
 };
 
+#define TRANSPORT_PUSH_ALL 1
+#define TRANSPORT_PUSH_FORCE 2
+
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
 
-- 
1.5.3.1.195.gadd6
