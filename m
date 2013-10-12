From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] http: enable keepalive on TCP sockets
Date: Sat, 12 Oct 2013 22:29:40 +0000
Message-ID: <20131012222939.GA24255@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 00:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV7gu-0002lV-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 00:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab3JLW3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 18:29:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37360 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab3JLW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 18:29:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9AB44C004;
	Sat, 12 Oct 2013 22:29:40 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236059>

This is a follow up to commit e47a8583a20256851e7fc882233e3bd5bf33dc6e
(enable SO_KEEPALIVE for connected TCP sockets).

Sockets may never receive notification of some link errors,
causing "git fetch" or similar processes to hang forever.
Enabling keepalive messages allows hung processes to error out
after a few minutes/hours depending on the keepalive settings of
the system.

I noticed this problem with some non-interactive cronjobs getting
hung when talking to HTTP servers.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 http.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/http.c b/http.c
index f3e1439..5834c9b 100644
--- a/http.c
+++ b/http.c
@@ -260,6 +260,24 @@ static int has_cert_password(void)
 	return 1;
 }
 
+/* curl 7.25.0 has CURLOPT_TCP_KEEPALIVE, too, but we support older curl */
+static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
+{
+	int ka = 1;
+	int rc;
+	socklen_t len = (socklen_t)sizeof(ka);
+
+	if (type != CURLSOCKTYPE_IPCXN)
+		return 0;
+
+	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
+	if (rc < 0)
+		warning("unable to set SO_KEEPALIVE on socket %s",
+			strerror(errno));
+
+	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
+}
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -332,6 +350,10 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 	}
 
+#if LIBCURL_VERSION_NUM >= 0x071000
+	curl_easy_setopt(result, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
+#endif
+
 	return result;
 }
 
-- 
Eric Wong
