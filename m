From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Replace ",<,>,& with their respective XML entities in DAV requests
Date: Fri, 10 Apr 2009 00:23:24 +0200
Message-ID: <1239315804-22629-1-git-send-email-mh@glandium.org>
References: <20090409111944.GA22297@kos.to>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 10 00:24:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls2fI-00011D-Tu
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 00:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757882AbZDIWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZDIWWe
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 18:22:34 -0400
Received: from vuizook.err.no ([85.19.221.46]:50149 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755099AbZDIWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 18:22:33 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Ls2dc-00076f-BV; Fri, 10 Apr 2009 00:22:27 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Ls2ea-0005tW-MR; Fri, 10 Apr 2009 00:23:24 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <20090409111944.GA22297@kos.to>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116213>

If the repo url or the user email contain XML special characters, the
remote DAV server is likely to reject the LOCK requests because the XML
is then malformed.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

Note I haven't tested more than with a quick run of t5540-http-push.sh.
Also note that this doesn't solve possible problems with non UTF-8
characters in both strings we escape here. (a DAV server may rightfully
reject XML containing non UTF-8 characters, since this XML is supposed
to be UTF-8 according to its prolog, and would thus be malformed)

diff --git a/http-push.c b/http-push.c
index feeb340..29e6b6b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -186,6 +186,32 @@ enum dav_header_flag {
 	DAV_HEADER_TIMEOUT = (1u << 2)
 };
 
+static char *xml_entities(char *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+	while (*s) {
+		size_t len = strcspn(s, "\"<>&");
+		strbuf_add(&buf, s, len);
+		s += len;
+		switch (*s) {
+		case '"':
+			strbuf_addstr(&buf, "&quot;");
+			break;
+		case '<':
+			strbuf_addstr(&buf, "&lt;");
+			break;
+		case '>':
+			strbuf_addstr(&buf, "&gt;");
+			break;
+		case '&':
+			strbuf_addstr(&buf, "&amp;");
+			break;
+		}
+		s++;
+	}
+	return buf.buf;
+}
+
 static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1225,6 +1251,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	struct remote_lock *lock = NULL;
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
+	char *escaped;
 
 	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
 	sprintf(url, "%s%s", repo->url, path);
@@ -1259,7 +1286,9 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		ep = strchr(ep + 1, '/');
 	}
 
-	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, git_default_email);
+	escaped = xml_entities(git_default_email);
+	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, escaped);
+	free(escaped);
 
 	sprintf(timeout_header, "Timeout: Second-%ld", timeout);
 	dav_headers = curl_slist_append(dav_headers, timeout_header);
@@ -1584,8 +1613,11 @@ static int locking_available(void)
 	struct curl_slist *dav_headers = NULL;
 	struct xml_ctx ctx;
 	int lock_flags = 0;
+	char *escaped;
 
-	strbuf_addf(&out_buffer.buf, PROPFIND_SUPPORTEDLOCK_REQUEST, repo->url);
+	escaped = xml_entities(repo->url);
+	strbuf_addf(&out_buffer.buf, PROPFIND_SUPPORTEDLOCK_REQUEST, escaped);
+	free(escaped);
 
 	dav_headers = curl_slist_append(dav_headers, "Depth: 0");
 	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
-- 
1.6.2.1
