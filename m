From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Fri,  8 Feb 2008 21:08:55 +0100
Message-ID: <1202501335-28205-1-git-send-email-mh@glandium.org>
References: <20080208073456.GA17791@glandium.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 08 21:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZX9-00028h-2A
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760720AbYBHUIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760408AbYBHUIg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:08:36 -0500
Received: from vuizook.err.no ([85.19.215.103]:50723 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYBHUIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:08:35 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNZXL-0002Qi-Ql; Fri, 08 Feb 2008 21:09:34 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNZWp-0007LK-TC; Fri, 08 Feb 2008 21:08:55 +0100
X-Mailer: git-send-email 1.5.4.7.gd8534-dirty
In-Reply-To: <20080208073456.GA17791@glandium.org>
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73128>

Either recent curl or gnutls doesn't like initializing again after cleaning
up, and this is happening in some cases such as git fetch.

We work around this by removing the http_cleanup call from get_refs_via_curl,
and allowing http_init to be called several times without initializing http.c
global variables again and leaking old values.

The remaining calls to http_cleanup are either last (http-push.c), or almost
never called (walker.c; the function it lies in is only called from
transport-disconnect, which is called last, and only in builtin-push.c).
These leaks shall be addressed in the http code refactoring.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 > So, it looks like either gnutls has a problem reinitializing its ASN1
 > parser or curl is doing something wrong with gnutls when initializing a
 > new request.

 In the end, it was a bit of git's fault, but either curl or gnutls is the
 actual culprit. I've not looked into either code to find out who's
 responsible, but a very simplified testcase is as follows:

	#include <curl/curl.h>
	#include <curl/easy.h>

	int main(void) {
	        CURL *easy = curl_easy_init();
	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
	        curl_easy_perform(easy);
	        curl_global_cleanup();
	        easy = curl_easy_init();
	        curl_easy_setopt(easy, CURLOPT_VERBOSE, 1);
	        curl_easy_setopt(easy, CURLOPT_URL, "https://www.verisign.com/");
	        curl_easy_perform(easy);
	}

	(build with gcc -o test test.c -lcurl)
	(note curl_easy_init does curl_global_init behind the curtains, even the
	second time. You can convince yourself by adding
	curl_global_init(CURL_GLOBAL_ALL);)

 http.c      |    5 +++++
 transport.c |    2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index babaa21..1eb6d78 100644
--- a/transport.c
+++ b/transport.c
@@ -473,8 +473,6 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 		return NULL;
 	}
 
-	http_cleanup();
-
 	data = buffer.buf;
 	start = NULL;
 	mid = data;
-- 
1.5.4.7.gd8534-dirty
