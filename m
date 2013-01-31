From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Verify Content-Type from smart HTTP servers
Date: Thu, 31 Jan 2013 14:09:40 -0800
Message-ID: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 23:10:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12Kc-00056S-Au
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab3AaWJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:09:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183Ab3AaWJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:09:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D347DC938;
	Thu, 31 Jan 2013 17:09:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	/EMOOkCC284mUQSrBBlF24PL4c=; b=wUNmy7sJDa/jRToMN13iOLaZ/7ITGawxC
	fVoduvi7Kal4lyTCGKQjdq8YUKx3s9Fbvgb4kjtgDyhe5oiWnDTV2zI+gdaIaRH7
	uxv6fQAAa7IX35LJIQAkodgHdW5hIH6cojpFBIBrZzJT7VFLENaruTj0MOC3IoCr
	g3/QiYJGBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=LPi92eZpiG76WLCp9Qjq2ZmKw8YXHGOkGpiBzCRYrBd8md7dMt9iARzb
	WXei50lgCx1dQNct5LjvEuvo5ecTZiIeG/+5ZnQr1UhFnhbEllX9LX0m0ANCdKTM
	L40Yg/l1xo2LXWaiGMAxb4np6TQPr9B+ie9J30mLzttHpxXMIGA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C51C9C936;
	Thu, 31 Jan 2013 17:09:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB090C933; Thu, 31 Jan 2013
 17:09:41 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E995C262-6BF2-11E2-9D58-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215174>

Before parsing a suspected smart-HTTP response verify the returned
Content-Type matches the standard. This protects a client from
attempting to process a payload that smells like a smart-HTTP
server response.

JGit has been doing this check on all responses since the dawn of
time. I mistakenly failed to include it in git-core when smart HTTP
was introduced. At the time I didn't know how to get the Content-Type
from libcurl. I punted, meant to circle back and fix this, and just
plain forgot about it.

Signed-off-by: Shawn Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The original was picked up by majordomo taboo rules; resending
   after minor style fix.

   Was there a report of an attempted attack by malicious server or
   something that triggered this, or is this just a "common sense
   thing to do" in general?

 http-push.c                      |  4 ++--
 http.c                           | 31 ++++++++++++++++++++++---------
 http.h                           |  2 +-
 remote-curl.c                    | 15 +++++++++++----
 t/lib-httpd.sh                   |  1 +
 t/lib-httpd/apache.conf          |  4 ++++
 t/lib-httpd/broken-smart-http.sh | 11 +++++++++++
 t/t5551-http-fetch.sh            |  6 ++++++
 8 files changed, 58 insertions(+), 16 deletions(-)
 create mode 100755 t/lib-httpd/broken-smart-http.sh

diff --git a/http-push.c b/http-push.c
index 8701c12..ba45b7b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1560,7 +1560,7 @@ static int remote_exists(const char *path)
 
 	sprintf(url, "%s%s", repo->url, path);
 
-	switch (http_get_strbuf(url, NULL, 0)) {
+	switch (http_get_strbuf(url, NULL, NULL, 0)) {
 	case HTTP_OK:
 		ret = 1;
 		break;
@@ -1584,7 +1584,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", repo->url, path);
 
-	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK)
+	if (http_get_strbuf(url, NULL, &buffer, 0) != HTTP_OK)
 		die("Couldn't get %s for remote symref\n%s", url,
 		    curl_errorstr);
 	free(url);
diff --git a/http.c b/http.c
index 44f3525..d868d8b 100644
--- a/http.c
+++ b/http.c
@@ -788,7 +788,8 @@ int handle_curl_result(struct slot_results *results)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
-static int http_request(const char *url, void *result, int target, int options)
+static int http_request(const char *url, struct strbuf *type,
+			void *result, int target, int options)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -838,24 +839,36 @@ static int http_request(const char *url, void *result, int target, int options)
 		ret = HTTP_START_FAILED;
 	}
 
+	if (type) {
+		char *t;
+		curl_easy_getinfo(slot->curl, CURLINFO_CONTENT_TYPE, &t);
+		if (t)
+			strbuf_addstr(type, t);
+	}
+
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 
 	return ret;
 }
 
-static int http_request_reauth(const char *url, void *result, int target,
+static int http_request_reauth(const char *url,
+			       struct strbuf *type,
+			       void *result, int target,
 			       int options)
 {
-	int ret = http_request(url, result, target, options);
+	int ret = http_request(url, type, result, target, options);
 	if (ret != HTTP_REAUTH)
 		return ret;
-	return http_request(url, result, target, options);
+	return http_request(url, type, result, target, options);
 }
 
-int http_get_strbuf(const char *url, struct strbuf *result, int options)
+int http_get_strbuf(const char *url,
+		    struct strbuf *type,
+		    struct strbuf *result, int options)
 {
-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
+	return http_request_reauth(url, type, result,
+				   HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -878,7 +891,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 		goto cleanup;
 	}
 
-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_reauth(url, NULL, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
@@ -904,7 +917,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	int ret = -1;
 
 	url = quote_ref_url(base, ref->name);
-	if (http_get_strbuf(url, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
+	if (http_get_strbuf(url, NULL, &buffer, HTTP_NO_CACHE) == HTTP_OK) {
 		strbuf_rtrim(&buffer);
 		if (buffer.len == 40)
 			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
@@ -997,7 +1010,7 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 	strbuf_addstr(&buf, "objects/info/packs");
 	url = strbuf_detach(&buf, NULL);
 
-	ret = http_get_strbuf(url, &buf, HTTP_NO_CACHE);
+	ret = http_get_strbuf(url, NULL, &buf, HTTP_NO_CACHE);
 	if (ret != HTTP_OK)
 		goto cleanup;
 
diff --git a/http.h b/http.h
index 0a80d30..25d1931 100644
--- a/http.h
+++ b/http.h
@@ -132,7 +132,7 @@ extern char *get_remote_object_url(const char *url, const char *hex,
  *
  * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
  */
-int http_get_strbuf(const char *url, struct strbuf *result, int options);
+int http_get_strbuf(const char *url, struct strbuf *content_type, struct strbuf *result, int options);
 
 /*
  * Prints an error message using error() containing url and curl_errorstr,
diff --git a/remote-curl.c b/remote-curl.c
index 9a8b123..e6f3b63 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -92,6 +92,8 @@ static void free_discovery(struct discovery *d)
 
 static struct discovery* discover_refs(const char *service)
 {
+	struct strbuf exp = STRBUF_INIT;
+	struct strbuf type = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
 	struct discovery *last = last_discovery;
 	char *refs_url;
@@ -113,7 +115,7 @@ static struct discovery* discover_refs(const char *service)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);
 
-	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	http_ret = http_get_strbuf(refs_url, &type, &buffer, HTTP_NO_CACHE);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
@@ -133,16 +135,19 @@ static struct discovery* discover_refs(const char *service)
 	last->buf = last->buf_alloc;
 
 	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
-		/* smart HTTP response; validate that the service
+		/*
+		 * smart HTTP response; validate that the service
 		 * pkt-line matches our request.
 		 */
-		struct strbuf exp = STRBUF_INIT;
-
+		strbuf_addf(&exp, "application/x-%s-advertisement", service);
+		if (strbuf_cmp(&exp, &type))
+			die("invalid content-type %s", type.buf);
 		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
 			die("%s has invalid packet header", refs_url);
 		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
 			strbuf_setlen(&buffer, buffer.len - 1);
 
+		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
 		if (strbuf_cmp(&exp, &buffer))
 			die("invalid server response; got '%s'", buffer.buf);
@@ -160,6 +165,8 @@ static struct discovery* discover_refs(const char *service)
 	}
 
 	free(refs_url);
+	strbuf_release(&exp);
+	strbuf_release(&type);
 	strbuf_release(&buffer);
 	last_discovery = last;
 	return last;
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 02f442b..895b925 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -80,6 +80,7 @@ fi
 prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
+	cp "$TEST_PATH"/broken-smart-http.sh "$HTTPD_ROOT_PATH"
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index fe76e84..938b4cf 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -62,9 +62,13 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_COMMITTER_EMAIL custom@example.com
 </LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
+ScriptAlias /broken_smart/ broken-smart-http.sh/
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
+<Files broken-smart-http.sh>
+	Options ExecCGI
+</Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/broken-smart-http.sh b/t/lib-httpd/broken-smart-http.sh
new file mode 100755
index 0000000..f7ebfff
--- /dev/null
+++ b/t/lib-httpd/broken-smart-http.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+printf "Content-Type: text/%s\n" "html"
+echo
+printf "%s\n" "001e# service=git-upload-pack"
+printf "%s"   "0000"
+printf "%s%c%s%s\n" \
+	"00a58681d9f286a48b08f37b3a095330da16689e3693 HEAD" \
+	0 \
+	" include-tag multi_ack_detailed multi_ack ofs-delta" \
+	" side-band side-band-64k thin-pack no-progress shallow no-done "
+printf "%s"   "0000"
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index c5cd2e3..cb95b95 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -157,6 +157,12 @@ test_expect_success 'GIT_SMART_HTTP can disable smart http' '
 	 test_must_fail git fetch)
 '
 
+test_expect_success 'invalid Content-Type rejected' '
+	echo "fatal: invalid content-type text/html" >expect
+	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.8.1.2.605.gb99210a
