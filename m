From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v2] Work around curl-gnutls not liking to be reinitialized
Date: Fri,  8 Feb 2008 23:22:39 +0100
Message-ID: <1202509359-23840-1-git-send-email-mh@glandium.org>
References: <20080208220941.GA22199@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 08 23:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbcQ-0000n4-H3
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYBHWWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYBHWWP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:22:15 -0500
Received: from vuizook.err.no ([85.19.215.103]:35756 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbYBHWWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:22:15 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNbch-0007be-SR; Fri, 08 Feb 2008 23:23:14 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNbcF-0006Cy-1t; Fri, 08 Feb 2008 23:22:39 +0100
X-Mailer: git-send-email 1.5.4.8.g95ac
In-Reply-To: <20080208220941.GA22199@glandium.org>
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73162>

curl versions 7.16.3 to 7.18.0 included had a regression in which https
requests following curl_global_cleanup/init sequence would fail with ASN1
parser errors with curl-gnutls. Such sequences happen in some cases such
as git fetch.

We work around this by removing the http_cleanup call from get_refs_via_curl
for broken versions of curl, and allowing http_init to be called several
times without initializing http.c global variables again and leaking old
values, which is a safe thing to have unconditionally.

The remaining calls to http_cleanup are either last (http-push.c), or almost
never called (walker.c; the function it lies in is only called from
transport-disconnect, which is called last, and only in builtin-push.c)
These leaks shall be addressed in the http code refactoring.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c      |    5 +++++
 transport.c |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index d2c11ae..a3aa9e9 100644
--- a/http.c
+++ b/http.c
@@ -215,9 +215,14 @@ static CURL* get_curl_handle(void)
 
 void http_init(void)
 {
+	static int init = 0;
 	char *low_speed_limit;
 	char *low_speed_time;
 
+	if (init)
+		return;
+	init = 1;
+
 	curl_global_init(CURL_GLOBAL_ALL);
 
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
diff --git a/transport.c b/transport.c
index babaa21..32ab521 100644
--- a/transport.c
+++ b/transport.c
@@ -473,7 +473,9 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		return NULL;
 	}
 
+#if (LIBCURL_VERSION_NUM < 0x071003) || (LIBCURL_VERSION_NUM > 0x071200)
 	http_cleanup();
+#endif
 
 	data = buffer.buf;
 	start = NULL;
-- 
1.5.4.7.gd8534-dirty
