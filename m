From: Jeff King <peff@peff.net>
Subject: [PATCH] http: use curl's tcp keepalive if available
Date: Mon, 14 Oct 2013 20:06:14 -0400
Message-ID: <20131015000614.GA10905@sigill.intra.peff.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
 <20131014052739.GA16129@dcvr.yhbt.net>
 <20131014214035.GB7007@sigill.intra.peff.net>
 <20131014233839.GA26323@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 02:06:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVs9V-0003Tl-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 02:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880Ab3JOAGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 20:06:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:49401 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753884Ab3JOAGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 20:06:17 -0400
Received: (qmail 25690 invoked by uid 102); 15 Oct 2013 00:06:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 19:06:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 20:06:14 -0400
Content-Disposition: inline
In-Reply-To: <20131014233839.GA26323@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236154>

On Mon, Oct 14, 2013 at 11:38:39PM +0000, Eric Wong wrote:

> I wanted it to work as older curl first (since I noticed this
> on an old server).  But your patch on top of mine looks reasonable,
> thanks.

Makes sense. Here it is with a real commit message (on top of the
ew/keepalive topic).

-- >8 --
Subject: http: use curl's tcp keepalive if available

Commit a15d069 taught git to use curl's SOCKOPTFUNCTION hook
to turn on TCP keepalives. However, modern versions of curl
have a TCP_KEEPALIVE option, which can do this for us. As an
added bonus, the curl code knows how to turn on keepalive
for a much wider variety of platforms. The only downside to
using this option is that not everybody has a new enough curl.
Let's split our keepalive options into three conditionals:

  1. With curl 7.25.0 and newer, we rely on curl to do it
     right.

  2. With older curl that still knows SOCKOPTFUNCTION, we
     use the code from a15d069.

  3. Otherwise, we are out of luck, and the call is a no-op.

Signed-off-by: Jeff King <peff@peff.net>
---
Given the #ifdefs in curl's keepalive code, I suspect we may see build
problems for people in case 2 on some systems, with or without my patch.
I think this patch is a strict improvement, though; if they have a new
enough curl, they will not even look at the case 2 code. And if they do
not, our previous options were:

  a. Add platform-specific code for them.
  
  b. Tell them they are out of luck, and add an #ifdef to push them into
     case 3.

Now we have an extra option:

  c. Tell them to upgrade curl. :)

 http.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index a2c1819..6359526 100644
--- a/http.c
+++ b/http.c
@@ -233,7 +233,13 @@ static int has_cert_password(void)
 		return 0;
 }
 
-/* curl 7.25.0 has CURLOPT_TCP_KEEPALIVE, too, but we support older curl */
+#if LIBCURL_VERSION_NUM >= 0x071900
+static void set_curl_keepalive(CURL *c)
+{
+	curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
+}
+
+#elif LIBCURL_VERSION_NUM >= 0x071000
 static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 {
 	int ka = 1;
@@ -251,6 +257,18 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
 }
 
+static void set_curl_keepalive(CURL *c)
+{
+	curl_easy_setopt(c, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
+}
+
+#else
+static void set_curl_keepalive(CURL *c)
+{
+	/* not supported on older curl versions */
+}
+#endif
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -316,9 +334,7 @@ static CURL *get_curl_handle(void)
 	if (curl_http_proxy)
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 
-#if LIBCURL_VERSION_NUM >= 0x071000
-	curl_easy_setopt(result, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
-#endif
+	set_curl_keepalive(result);
 
 	return result;
 }
-- 
1.8.4.1.4.gf327177
