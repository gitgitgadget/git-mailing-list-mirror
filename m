From: Jeff King <peff@peff.net>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Sat, 17 May 2014 02:51:02 -0400
Message-ID: <20140517065102.GB13003@sigill.intra.peff.net>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
 <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
 <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
 <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
 <20140512202153.GB2329@sigill.intra.peff.net>
 <20140516223410.GB180798@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 08:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYSd-0002J6-PD
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbaEQGvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:51:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:53667 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755848AbaEQGvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:51:05 -0400
Received: (qmail 10237 invoked by uid 102); 17 May 2014 06:51:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 01:51:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 02:51:02 -0400
Content-Disposition: inline
In-Reply-To: <20140516223410.GB180798@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249452>

On Fri, May 16, 2014 at 10:34:10PM +0000, brian m. carlson wrote:

> > The tricky part is figuring out when to return HTTP_NOAUTH ("do not try
> > again, we failed") versus HTTP_REAUTH ("get credentials and try again")
> > in handle_curl_result. Right now the decision is based on "did we have a
> > username and password for this request?" I'm not clear on what extra
> > bits would be needed to decide to continue in the case you guys are
> > discussing.
> 
> I'm honestly not sure, either.  That's why I said, "how to do that is
> unknown".
> 
> However, if you base64-decode the two Negotiate replies in the
> successful attempt with WinHTTP and pass it through od -tc, you'll see
> that the second reply contains some form of user ID that the first one
> does not.  The curl binary sends an identical reply for the first pass,
> but then gives up and does not try a second pass.  I don't know if
> libcurl is able to provide the data required in the second pass.
> 
> All of this is way outside my knowledge, since my Kerberos/GSSAPI
> Negotiate requests look very different than the NTLM ones.

Mine too. I think a good place to start would be somebody who has a
setup to replicate the problem dumping the curl data (either from
GIT_CURL_VERBOSE, or instrumenting git with some curl_easy_getinfo
calls), and seeing what is interesting.

> > Yeah, we just set CURLAUTH_ANY now, but it would be fairly trivial to
> > add "http.authtype" and "http.proxyauthtype" to map to CURLOPT_HTTPAUTH
> > and CURLOPT_PROXYAUTH.
> 
> This might be the easiest option.

I can help with working up a patch, but I don't have any meaningful way
to test it.

The patch below might help somebody get started. I don't know if
CURLAUTH_ONLY would be useful to be able to set, too.

diff --git a/http.c b/http.c
index 94e1afd..ba56f7e 100644
--- a/http.c
+++ b/http.c
@@ -51,6 +51,9 @@ struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
 
+static long curl_http_authtype;
+static long curl_proxy_authtype;
+
 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
 #elif LIBCURL_VERSION_NUM >= 0x070903
@@ -143,6 +146,37 @@ static void process_curl_messages(void)
 }
 #endif
 
+static int parse_auth_type(const char *var, const char *value, long *type)
+{
+	static struct {
+		const char *name;
+		long value;
+	} types[] = {
+		 { "basic", CURLAUTH_BASIC },
+		 { "digest", CURLAUTH_DIGEST },
+#if CURL_VERSION >= 0x071303
+		 { "digest-ie", CURLAUTH_DIGEST_IE },
+#endif
+		 { "negotiate", CURLAUTH_GSSNEGOTIATE },
+#if CURL_VERSION >= 0x071600
+		 { "ntlm-wb", CURLAUTH_NTLM_WB },
+#endif
+		 { "ntlm", CURLAUTH_NTLM }
+	};
+	int i;
+
+	if (!value)
+		return config_error_nonbool(var);
+
+	for (i = 0; i < ARRAY_SIZE(types); i++)
+		if (!strcmp(value, types[i].name))
+			*type |= types[i].value;
+
+	if (i == ARRAY_SIZE(types))
+		return error("unknown auth type for '%s': %s", var, value);
+	return 0;
+}
+
 static int http_options(const char *var, const char *value, void *cb)
 {
 	if (!strcmp("http.sslverify", var)) {
@@ -216,6 +250,11 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.useragent", var))
 		return git_config_string(&user_agent, var, value);
 
+	if (!strcmp("http.authtype", var))
+		return parse_auth_type(var, value, &curl_http_authtype);
+	if (!strcmp("http.proxyauthtype", var))
+		return parse_auth_type(var, value, &curl_proxy_authtype);
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -296,6 +335,17 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
+static void set_curl_authtype(CURL *c, CURLoption option, long value)
+{
+	if (value)
+		curl_easy_setopt(c, option, value);
+	else {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+		curl_easy_setopt(c, option, CURLAUTH_ANY);
+#endif
+	}
+}
+
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
@@ -313,8 +363,13 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	set_curl_authtype(result, CURLOPT_HTTPAUTH, curl_http_authtype);
+#endif
+
+#if LIBCURL_VERSION_NUM >= 0x070a07
+	set_curl_authtype(result, CURLOPT_PROXYAUTH, curl_proxy_authtype);
 #endif
 
 	if (http_proactive_auth)
