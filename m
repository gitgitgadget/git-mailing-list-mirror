From: Christoph Egger <christoph@christoph-egger.org>
Subject: [PATCH +warn2] Implement https public key pinning
Date: Tue, 16 Feb 2016 12:19:21 +0100
Message-ID: <20160216111921.GA67844@mitoraj.siccegge.de>
References: <20160216032818.GB19954@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 12:19:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVdfQ-0004SW-45
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 12:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbcBPLT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 06:19:28 -0500
Received: from chadwick.siccegge.de ([185.44.107.74]:48694 "EHLO
	chadwick.siccegge.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcBPLT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 06:19:27 -0500
Received: by chadwick.siccegge.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86 (FreeBSD))
	(envelope-from <christoph@christoph-egger.org>)
	id 1aVdf5-000C7E-Br
	for git@vger.kernel.org; Tue, 16 Feb 2016 11:19:20 +0000
Content-Disposition: inline
In-Reply-To: <20160216032818.GB19954@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286339>

Add the http.pinnedpubkey configuration option for public key
pinning. It allows any string supported by libcurl --
base64(sha256(pubkey)) or filename of the full public key.

If cURL does not support pinning (is too old) output a warning to the
user.

Signed-off-by: Christoph Egger <christoph@christoph-egger.org>
---

 Now tested again both with and without a "new enough" cURL version.
 Passes tests in both configurations and is obviously more correct.

 Documentation/config.txt |  8 ++++++++
 http.c                   | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27f02be..0f2643b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1727,6 +1727,14 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the 'GIT_SSL_CAPATH' environment variable.
 
+http.pinnedpubkey::
+	Public key of the https service. It may either be the filename of
+	a PEM or DER encoded public key file or a string starting with
+	'sha256//' followed by the base64 encoded sha256 hash of the
+	public key. See also libcurl 'CURLOPT_PINNEDPUBLICKEY'. git will
+	exit with an error if this option is set but not supported by
+	cURL.
+
 http.sslTry::
 	Attempt to use AUTH SSL/TLS and encrypted data transfers
 	when connecting via regular FTP protocol. This might be needed
diff --git a/http.c b/http.c
index dfc53c1..f640a8b 100644
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
@@ -239,6 +242,14 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 #endif
+	if (!strcmp("http.pinnedpubkey", var)) {
+#if LIBCURL_VERSION_NUM >= 0x072c00
+		return git_config_pathname(&ssl_pinnedkey, var, value);
+#else
+		warning(_("Public key pinning not supported with cURL < 7.44.0"));
+		return 0;
+#endif
+	}
 	if (!strcmp("http.sslcainfo", var))
 		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
@@ -499,6 +510,10 @@ static CURL *get_curl_handle(void)
 	if (ssl_capath != NULL)
 		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x072c00
+	if (ssl_pinnedkey != NULL)
+		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
+#endif
 	if (ssl_cainfo != NULL)
 		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
 
-- 
2.7.0


-- 
