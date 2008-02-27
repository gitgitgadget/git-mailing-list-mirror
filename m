From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Set proxy override with http_init()
Date: Wed, 27 Feb 2008 21:35:50 +0100
Message-ID: <1204144550-14175-1-git-send-email-mh@glandium.org>
References: <20080227200551.GA6954@glandium.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 27 21:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSy7-0006xc-1j
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 21:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbYB0Ucu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 15:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757624AbYB0Uct
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 15:32:49 -0500
Received: from vuizook.err.no ([85.19.215.103]:39766 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068AbYB0Uct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 15:32:49 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JUSxF-0004DS-Af; Wed, 27 Feb 2008 21:32:47 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JUT0I-0003h3-9c; Wed, 27 Feb 2008 21:35:50 +0100
X-Mailer: git-send-email 1.5.4.3.195.g48d21.dirty
In-Reply-To: <20080227200551.GA6954@glandium.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75301>

In transport.c, proxy setting (the one from the remote conf) was set through
curl_easy_setopt() call, while http.c already does the same with the
http.proxy setting. We now just use this infrastructure instead, and make
http_init() now take the struct remote as argument so that it can take the
http_proxy setting from there, and any other property that would be added
later.

At the same time, we make get_http_walker() take a struct remote argument
too, and pass it to http_init(), which makes remote defined proxy be used
for more than get_refs_via_curl().

We leave out http-fetch and http-push, which don't use remotes for the
moment, purposefully.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 > > It's a good idea, but maybe http_init() (and the call chain leading up to
 > > it) should take the struct remote, so that it can get anything else you
 > > might also have there in the future? For that matter, is it intentional
 > > that http-push ignore the proxy setting, which is equally available in
 > > http-push, but not used? If so, it should probably get a comment.
 > 
 > It is intentional, for the moment. I'll rework the patch to take the
 > struct remote, and add a comment.

 And here you are. Changing const char * to struct remote * had the nice side
 effect to make me detect a missing change in builtin-http-fetch.c.

 builtin-http-fetch.c |    2 +-
 http-push.c          |    2 +-
 http-walker.c        |    4 ++--
 http.c               |   10 +++++++++-
 http.h               |    3 ++-
 transport.c          |    9 ++++-----
 walker.h             |    4 +++-
 7 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index 7f450c6..48128c6 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -59,7 +59,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 		url = rewritten_url;
 	}
 
-	walker = get_http_walker(url);
+	walker = get_http_walker(url, NULL);
 	walker->get_tree = get_tree;
 	walker->get_history = get_history;
 	walker->get_all = get_all;
diff --git a/http-push.c b/http-push.c
index 0beb740..04e056d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2240,7 +2240,7 @@ int main(int argc, char **argv)
 
 	memset(remote_dir_exists, -1, 256);
 
-	http_init();
+	http_init(NULL);
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
diff --git a/http-walker.c b/http-walker.c
index 2c37868..7bda34d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -902,13 +902,13 @@ static void cleanup(struct walker *walker)
 	curl_slist_free_all(data->no_pragma_header);
 }
 
-struct walker *get_http_walker(const char *url)
+struct walker *get_http_walker(const char *url, struct remote *remote)
 {
 	char *s;
 	struct walker_data *data = xmalloc(sizeof(struct walker_data));
 	struct walker *walker = xmalloc(sizeof(struct walker));
 
-	http_init();
+	http_init(remote);
 
 	data->no_pragma_header = curl_slist_append(NULL, "Pragma:");
 
diff --git a/http.c b/http.c
index 519621a..64c53cd 100644
--- a/http.c
+++ b/http.c
@@ -219,13 +219,16 @@ static CURL* get_curl_handle(void)
 	return result;
 }
 
-void http_init(void)
+void http_init(struct remote *remote)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
 
 	curl_global_init(CURL_GLOBAL_ALL);
 
+	if (remote && remote->http_proxy)
+		curl_http_proxy = xstrdup(remote->http_proxy);
+
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 
 #ifdef USE_CURL_MULTI
@@ -315,6 +318,11 @@ void http_cleanup(void)
 
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
+
+	if (curl_http_proxy) {
+		free(curl_http_proxy);
+		curl_http_proxy = NULL;
+	}
 }
 
 struct active_request_slot *get_active_slot(void)
diff --git a/http.h b/http.h
index 9bab2c8..04169d5 100644
--- a/http.h
+++ b/http.h
@@ -7,6 +7,7 @@
 #include <curl/easy.h>
 
 #include "strbuf.h"
+#include "remote.h"
 
 /*
  * We detect based on the cURL version if multi-transfer is
@@ -83,7 +84,7 @@ extern void add_fill_function(void *data, int (*fill)(void *));
 extern void step_active_slots(void);
 #endif
 
-extern void http_init(void);
+extern void http_init(struct remote *remote);
 extern void http_cleanup(void);
 
 extern int data_received;
diff --git a/transport.c b/transport.c
index 397983d..86e0374 100644
--- a/transport.c
+++ b/transport.c
@@ -442,7 +442,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	struct ref *last_ref = NULL;
 
 	if (!transport->data)
-		transport->data = get_http_walker(transport->url);
+		transport->data = get_http_walker(transport->url,
+						transport->remote);
 
 	refs_url = xmalloc(strlen(transport->url) + 11);
 	sprintf(refs_url, "%s/info/refs", transport->url);
@@ -453,9 +454,6 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, refs_url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
-	if (transport->remote->http_proxy)
-		curl_easy_setopt(slot->curl, CURLOPT_PROXY,
-				 transport->remote->http_proxy);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -509,7 +507,8 @@ static int fetch_objs_via_curl(struct transport *transport,
 				 int nr_objs, struct ref **to_fetch)
 {
 	if (!transport->data)
-		transport->data = get_http_walker(transport->url);
+		transport->data = get_http_walker(transport->url,
+						transport->remote);
 	return fetch_objs_via_walker(transport, nr_objs, to_fetch);
 }
 
diff --git a/walker.h b/walker.h
index ea2c363..e1d40de 100644
--- a/walker.h
+++ b/walker.h
@@ -1,6 +1,8 @@
 #ifndef WALKER_H
 #define WALKER_H
 
+#include "remote.h"
+
 struct walker {
 	void *data;
 	int (*fetch_ref)(struct walker *, char *ref, unsigned char *sha1);
@@ -32,6 +34,6 @@ int walker_fetch(struct walker *impl, int targets, char **target,
 
 void walker_free(struct walker *walker);
 
-struct walker *get_http_walker(const char *url);
+struct walker *get_http_walker(const char *url, struct remote *remote);
 
 #endif /* WALKER_H */
-- 
1.5.4.3.195.g48d21.dirty
