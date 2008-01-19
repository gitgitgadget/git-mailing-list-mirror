From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push: more explicit error message with bad URL or password
Date: Sat, 19 Jan 2008 16:22:49 +0100
Message-ID: <1200756171-11696-3-git-send-email-gb@gbarbier.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
 <1200756171-11696-2-git-send-email-gb@gbarbier.org>
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 16:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFYF-0007ga-3i
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760020AbYASPXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760062AbYASPXE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:23:04 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48546 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759338AbYASPWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:22:55 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9FE761AB30C;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 795721AB315;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc3.54.g4b665-dirty
In-Reply-To: <1200756171-11696-2-git-send-email-gb@gbarbier.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71117>

Previously, when URL or password where not set correctly (or when some network
errors occur), the error message was "no DAV locking support".
---
 http-push.c |    6 ++++++
 http.c      |   25 +++++++++++++++++++++++++
 http.h      |    1 +
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index e1984d3..c984d84 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2228,6 +2228,12 @@ int main(int argc, char **argv)
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
+	if (!http_test_connection(remote->url)) {
+		fprintf(stderr, "Error: cannot access to remote URL (maybe malformed URL, network error or bad credentials)\n");
+		rc = 1;
+		goto cleanup;
+	}
+
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
 		fprintf(stderr, "Error: no DAV locking support on remote repo %s\n", remote->url);
diff --git a/http.c b/http.c
index d2c11ae..8b04ae9 100644
--- a/http.c
+++ b/http.c
@@ -634,3 +634,28 @@ int http_fetch_ref(const char *base, const char *ref, unsigned char *sha1)
 	free(url);
 	return ret;
 }
+
+int http_test_connection(const char *url)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct active_request_slot *slot;
+	struct slot_results results;
+	int ret = 0;
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result == CURLE_OK)
+			ret = -1;
+		else
+			error("Cannot access to URL %s, return code %d", url, results.curl_result);
+	} else
+		error("Unable to start request");
+	strbuf_release(&buffer);
+	return ret;
+}
diff --git a/http.h b/http.h
index aeba930..b353007 100644
--- a/http.h
+++ b/http.h
@@ -77,6 +77,7 @@ extern void step_active_slots(void);
 
 extern void http_init(void);
 extern void http_cleanup(void);
+extern int http_test_connection(const char *url);
 
 extern int data_received;
 extern int active_requests;
-- 
1.5.4.rc3.52.g9a5bd-dirty
