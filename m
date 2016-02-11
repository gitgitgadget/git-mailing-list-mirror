From: Christoph Egger <christoph@christoph-egger.org>
Subject: [PATCH] Implement https public key pinning
Date: Thu, 11 Feb 2016 23:54:37 +0100
Message-ID: <20160211225437.GA33955@mitoraj.siccegge.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 00:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU0JN-0003tW-G0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 00:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbcBKXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 18:05:49 -0500
Received: from chadwick.siccegge.de ([185.44.107.74]:10007 "EHLO
	chadwick.siccegge.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcBKXFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 18:05:49 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2016 18:05:48 EST
Received: by chadwick.siccegge.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86 (FreeBSD))
	(envelope-from <christoph@christoph-egger.org>)
	id 1aU089-000Gq9-Ic; Thu, 11 Feb 2016 22:54:34 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 131.188.6.21
X-SA-Exim-Mail-From: christoph@christoph-egger.org
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on chadwick.siccegge.de
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS
	autolearn=unavailable autolearn_force=no version=3.4.1
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on chadwick.siccegge.de)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286017>

Add the http.pinnedpubkey configuration option for public key
pinning. It allows any string supported by libcurl --
base64(sha256(pubkey)) or filename of the full public key.

Signed-off-by: Christoph Egger <christoph@christoph-egger.org>
---

 For some more sensitive repositories I'd like to properly pin the
 public key of the https service. libcURL properly supports this since
 7.44.0, some parts earlier, the option just needs to be exposed by
 git.

 There seem to be no test regressions.

 Documentation/config.txt |  6 ++++++
 http.c                   | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27f02be..35b4495 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1727,6 +1727,12 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the 'GIT_SSL_CAPATH' environment variable.
 
+http.pinnedpubkey::
+	Public key of the https service. It may either be the filename of
+	a PEM or DER encoded public key file or a string starting with
+	'sha256//' followed by the base64 encoded sha256 hash of the
+	public key. See also libcurl 'CURLOPT_PINNEDPUBLICKEY'.
+
 http.sslTry::
 	Attempt to use AUTH SSL/TLS and encrypted data transfers
 	when connecting via regular FTP protocol. This might be needed
diff --git a/http.c b/http.c
index dfc53c1..60776cc 100644
--- a/http.c
+++ b/http.c
@@ -57,6 +57,9 @@ static const char *ssl_key;
 #if LIBCURL_VERSION_NUM >= 0x070908
 static const char *ssl_capath;
 #endif
+#if LIBCURL_VERSION_NUM >= 0x072c00
+static const char *ssl_pinnedkey;
+#endif
 static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
@@ -239,6 +242,10 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x072c00
+	if (!strcmp("http.pinnedpubkey", var))
+		return git_config_pathname(&ssl_pinnedkey, var, value);
+#endif
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
@@ -499,6 +506,10 @@ static CURL *get_curl_handle(void)
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x074400
+	if (ssl_pinnedkey != NULL)
+		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
+#endif
 	if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 
-- 
2.7.0


-- 
