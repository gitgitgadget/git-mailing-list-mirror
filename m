From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Make walker.fetch_ref() take a struct ref.
Date: Sat, 26 Apr 2008 15:53:09 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804261547200.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	John Wiegley <johnw@newartisans.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 21:54:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpqTC-0001GD-Ds
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 21:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762096AbYDZTxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761829AbYDZTxQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 15:53:16 -0400
Received: from iabervon.org ([66.92.72.58]:47483 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761958AbYDZTxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 15:53:12 -0400
Received: (qmail 26960 invoked by uid 1000); 26 Apr 2008 19:53:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Apr 2008 19:53:09 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80389>

This simplifies a few things, makes a few things slightly more
complicated, but, more importantly, allows that, when struct ref can
represent a symref, http_fetch_ref() can return one.

Incidentally makes the string that http_fetch_ref() gets include "refs/"
(if appropriate), because that's how the name field of struct ref works. 
As far as I can tell, the usage in walker:interpret_target() wouldn't have 
worked previously, if it ever would have been used, which it wouldn't 
(since the fetch process uses the hash instead of the name of the ref 
there).

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I'm fairly sure I got the http-push changes here right, but I don't have 
testing infrastructure for it set up, so I'd appreciate testing from 
somebody who does.

 http-push.c   |   35 +++++++++++++++++++----------------
 http-walker.c |    4 ++--
 http.c        |   13 +++++++------
 http.h        |    2 +-
 walker.c      |    7 ++++++-
 walker.h      |    2 +-
 6 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5b23038..939a764 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1759,15 +1759,16 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 static void one_remote_ref(char *refname)
 {
 	struct ref *ref;
-	unsigned char remote_sha1[20];
 	struct object *obj;
-	int len = strlen(refname) + 1;
 
-	if (http_fetch_ref(remote->url, refname + 5 /* "refs/" */,
-			   remote_sha1) != 0) {
+	ref = alloc_ref(strlen(refname) + 1);
+	strcpy(ref->name, refname);
+
+	if (http_fetch_ref(remote->url, ref) != 0) {
 		fprintf(stderr,
 			"Unable to fetch ref %s from %s\n",
 			refname, remote->url);
+		free(ref);
 		return;
 	}
 
@@ -1775,18 +1776,15 @@ static void one_remote_ref(char *refname)
 	 * Fetch a copy of the object if it doesn't exist locally - it
 	 * may be required for updating server info later.
 	 */
-	if (remote->can_update_info_refs && !has_sha1_file(remote_sha1)) {
-		obj = lookup_unknown_object(remote_sha1);
+	if (remote->can_update_info_refs && !has_sha1_file(ref->old_sha1)) {
+		obj = lookup_unknown_object(ref->old_sha1);
 		if (obj) {
 			fprintf(stderr,	"  fetch %s for %s\n",
-				sha1_to_hex(remote_sha1), refname);
+				sha1_to_hex(ref->old_sha1), refname);
 			add_fetch_request(obj);
 		}
 	}
 
-	ref = xcalloc(1, sizeof(*ref) + len);
-	hashcpy(ref->old_sha1, remote_sha1);
-	memcpy(ref->name, refname, len);
 	*remote_tail = ref;
 	remote_tail = &ref->next;
 }
@@ -1891,33 +1889,37 @@ static void mark_edges_uninteresting(struct commit_list *list)
 static void add_remote_info_ref(struct remote_ls_ctx *ls)
 {
 	struct strbuf *buf = (struct strbuf *)ls->userData;
-	unsigned char remote_sha1[20];
 	struct object *o;
 	int len;
 	char *ref_info;
+	struct ref *ref;
+
+	ref = alloc_ref(strlen(ls->dentry_name) + 1);
+	strcpy(ref->name, ls->dentry_name);
 
-	if (http_fetch_ref(remote->url, ls->dentry_name + 5 /* "refs/" */,
-			   remote_sha1) != 0) {
+	if (http_fetch_ref(remote->url, ref) != 0) {
 		fprintf(stderr,
 			"Unable to fetch ref %s from %s\n",
 			ls->dentry_name, remote->url);
 		aborted = 1;
+		free(ref);
 		return;
 	}
 
-	o = parse_object(remote_sha1);
+	o = parse_object(ref->old_sha1);
 	if (!o) {
 		fprintf(stderr,
 			"Unable to parse object %s for remote ref %s\n",
-			sha1_to_hex(remote_sha1), ls->dentry_name);
+			sha1_to_hex(ref->old_sha1), ls->dentry_name);
 		aborted = 1;
+		free(ref);
 		return;
 	}
 
 	len = strlen(ls->dentry_name) + 42;
 	ref_info = xcalloc(len + 1, 1);
 	sprintf(ref_info, "%s	%s\n",
-		sha1_to_hex(remote_sha1), ls->dentry_name);
+		sha1_to_hex(ref->old_sha1), ls->dentry_name);
 	fwrite_buffer(ref_info, 1, len, buf);
 	free(ref_info);
 
@@ -1932,6 +1934,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 			free(ref_info);
 		}
 	}
+	free(ref);
 }
 
 static void update_remote_info_refs(struct remote_lock *lock)
diff --git a/http-walker.c b/http-walker.c
index 7bda34d..99f397e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -888,10 +888,10 @@ static int fetch(struct walker *walker, unsigned char *sha1)
 		     data->alt->base);
 }
 
-static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
+static int fetch_ref(struct walker *walker, struct ref *ref)
 {
 	struct walker_data *data = walker->data;
-	return http_fetch_ref(data->alt->base, ref, sha1);
+	return http_fetch_ref(data->alt->base, ref);
 }
 
 static void cleanup(struct walker *walker)
diff --git a/http.c b/http.c
index 256a5f1..c8df13b 100644
--- a/http.c
+++ b/http.c
@@ -589,8 +589,9 @@ static char *quote_ref_url(const char *base, const char *ref)
 			len += 2; /* extra two hex plus replacement % */
 	qref = xmalloc(len);
 	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "/refs/", 6);
-	for (cp = ref, dp = qref + baselen + 6; (ch = *cp) != 0; cp++) {
+	dp = qref + baselen;
+	*(dp++) = '/';
+	for (cp = ref; (ch = *cp) != 0; cp++) {
 		if (needs_quote(ch)) {
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
@@ -604,7 +605,7 @@ static char *quote_ref_url(const char *base, const char *ref)
 	return qref;
 }
 
-int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1)
+int http_fetch_ref(const char *base, struct ref *ref)
 {
 	char *url;
 	struct strbuf buffer = STRBUF_INIT;
@@ -612,7 +613,7 @@ int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1)
 	struct slot_results results;
 	int ret;
 
-	url = quote_ref_url(base, ref);
+	url = quote_ref_url(base, ref->name);
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
@@ -624,12 +625,12 @@ int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1)
 		if (results.curl_result == CURLE_OK) {
 			strbuf_rtrim(&buffer);
 			if (buffer.len == 40)
-				ret = get_sha1_hex(buffer.buf, sha1);
+				ret = get_sha1_hex(buffer.buf, ref->old_sha1);
 			else
 				ret = 1;
 		} else {
 			ret = error("Couldn't get %s for %s\n%s",
-				    url, ref, curl_errorstr);
+				    url, ref->name, curl_errorstr);
 		}
 	} else {
 		ret = error("Unable to start request");
diff --git a/http.h b/http.h
index 04169d5..a04fc6a 100644
--- a/http.h
+++ b/http.h
@@ -105,6 +105,6 @@ static inline int missing__target(int code, int result)
 
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
-extern int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1);
+extern int http_fetch_ref(const char *base, struct ref *ref);
 
 #endif /* HTTP_H */
diff --git a/walker.c b/walker.c
index c10eca8..fa96a7c 100644
--- a/walker.c
+++ b/walker.c
@@ -190,9 +190,14 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	if (!get_sha1_hex(target, sha1))
 		return 0;
 	if (!check_ref_format(target)) {
-		if (!walker->fetch_ref(walker, target, sha1)) {
+		struct ref *ref = alloc_ref(strlen(target));
+		strcpy(ref->name, target);
+		if (!walker->fetch_ref(walker, ref)) {
+			hashcpy(sha1, ref->old_sha1);
+			free(ref);
 			return 0;
 		}
+		free(ref);
 	}
 	return -1;
 }
diff --git a/walker.h b/walker.h
index e1d40de..8a149e1 100644
--- a/walker.h
+++ b/walker.h
@@ -5,7 +5,7 @@
 
 struct walker {
 	void *data;
-	int (*fetch_ref)(struct walker *, char *ref, unsigned char *sha1);
+	int (*fetch_ref)(struct walker *, struct ref *ref);
 	void (*prefetch)(struct walker *, unsigned char *sha1);
 	int (*fetch)(struct walker *, unsigned char *sha1);
 	void (*cleanup)(struct walker *);
-- 
1.5.4.3.610.gea6cd
