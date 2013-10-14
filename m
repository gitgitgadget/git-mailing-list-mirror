From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: enable keepalive on TCP sockets
Date: Mon, 14 Oct 2013 17:40:35 -0400
Message-ID: <20131014214035.GB7007@sigill.intra.peff.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
 <20131014052739.GA16129@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 14 23:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVpsY-0007Aa-V2
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 23:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab3JNVkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 17:40:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:49298 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757151Ab3JNVki (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 17:40:38 -0400
Received: (qmail 18221 invoked by uid 102); 14 Oct 2013 21:40:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 16:40:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 17:40:35 -0400
Content-Disposition: inline
In-Reply-To: <20131014052739.GA16129@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236121>

On Mon, Oct 14, 2013 at 05:27:39AM +0000, Eric Wong wrote:

> Daniel Stenberg <daniel@haxx.se> wrote:
> > On Sat, 12 Oct 2013, Eric Wong wrote:
> > 
> > >This is a follow up to commit
> > >e47a8583a20256851e7fc882233e3bd5bf33dc6e (enable SO_KEEPALIVE for
> > >connected TCP sockets).
> > 
> > Just keep in mind that TCP keep-alive is enabled in awkwardly many
> > different ways on different systems and this patch only supports one
> > of them. Feel free to take inspiration from libcurl's source code
> > for doing this. See:
> > 
> >   https://github.com/bagder/curl/blob/master/lib/connect.c#L108
> 
> Thanks.  I think the Linux-specific TCP_KEEP* knobs are overkill for git.
> (since this is mainly for non-interactive users, I went at least a day
>  before realizing the process was stuck on my machine).
> I cannot comment on the knobs for other OSes.

I don't think we should get into having a big compatibility layer that
just reproduces what is in curl.

But is there any reason not to use CURLOPT_TCP_KEEPALIVE when it is
available, falling back to CURLOPT_SOCKOPTFUNCTION, and then finally to
nothing? That lets people on modern curl benefit from curl's more
portable code, without punishing people on older versions.

I.e., something like:

---
diff --git a/http.c b/http.c
index 5834c9b..e221efb 100644
--- a/http.c
+++ b/http.c
@@ -254,36 +254,54 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
 	if (!cert_auth.password) {
 		cert_auth.protocol = xstrdup("cert");
 		cert_auth.username = xstrdup("");
 		cert_auth.path = xstrdup(ssl_cert);
 		credential_fill(&cert_auth);
 	}
 	return 1;
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
 	int rc;
 	socklen_t len = (socklen_t)sizeof(ka);
 
 	if (type != CURLSOCKTYPE_IPCXN)
 		return 0;
 
 	rc = setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
 	if (rc < 0)
 		warning("unable to set SO_KEEPALIVE on socket %s",
 			strerror(errno));
 
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
 
 	if (!curl_ssl_verify) {
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
 	} else {
 		/* Verify authenticity of the peer's certificate */
@@ -344,21 +362,19 @@ static CURL *get_curl_handle(void)
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
 #endif
 
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x071000
-	curl_easy_setopt(result, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
-#endif
+	set_curl_keepalive(result);
 
 	return result;
 }
 
 static void set_from_env(const char **var, const char *envname)
 {
 	const char *val = getenv(envname);
 	if (val)
 		*var = val;
