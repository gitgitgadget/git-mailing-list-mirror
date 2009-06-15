From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/2] http.c: fix compiling with libcurl 7.9.2
Date: Sun, 14 Jun 2009 22:39:00 -0400
Message-ID: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 04:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG2ER-0008Dt-6l
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 04:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZFOCrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 22:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZFOCrY
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 22:47:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:7102 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbZFOCrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 22:47:23 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2149859qwd.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Hd/V/PfjRDTQaQAc1Fkz/KbyWt01VrBWfDW1ybv12Jo=;
        b=aF/v3IfiFIjMoAYB4b+0GmAlC/83aSbP7idDHS3tqVVCi0pef14fKHQ+MdTih/qPEU
         YxZ+mfavMJinsSDGYogm73FQrgeII+ZPlI6cQpuHk/5iggrFpAkeolsuZoQB4TO5YsV6
         l92UZX5E27sSRFtidc9OUIlAD2d46s0s73a60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=U4S7coZYr9+Lo5qSYnPiaSEdBBOU7vKylDi89dMynm4OlefOJ4OvGxmU6swMtMPIS8
         eijQPO9hUaxhP+Hm+blWbCbqrrpwTpJPswRSObjm1bvIPxN1I+X4dluldpnyd2jcqKWO
         SGhF70Flq0q8rGeo6tKTyXLBhmTdfJjh2Qyto=
Received: by 10.224.67.67 with SMTP id q3mr6770600qai.5.1245033574624;
        Sun, 14 Jun 2009 19:39:34 -0700 (PDT)
Received: from localhost.localdomain ([68.33.182.150])
        by mx.google.com with ESMTPS id 2sm1001101qwi.13.2009.06.14.19.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 19:39:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121576>

Change the minimimum required libcurl version for the http.sslKey option
to 7.9.3.  Previously, preprocessor macros checked for >= 7.9.2, which
is incorrect because CURLOPT_SSLKEY was introduced in 7.9.3.  This now
allows git to compile with libcurl 7.9.2.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

This patch series is independent of my other password prompting patch
series, and is based off 'next', which includes Tay Ray Chuan's recent
http changes.

Note that git still does not compile on libcurl before 7.9.1 or below,
since CURLOPT_FTP_USE_EPSV (http.c:236) is defined in libcurl 7.9.2.

One question: In http.c, there are unnecessary #if LIBCURL_VERSION_NUM's
surrounding the global variable declarations, in http_options(), and in
http_init().  Is there a reason why these exist?  If not, I think
removing them would make the code easier to read.

Any feedback or suggestions are appreciated!
Mark


 http.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index 95b2137..b049948 100644
--- a/http.c
+++ b/http.c
@@ -20,7 +20,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static const char *ssl_cert;
-#if LIBCURL_VERSION_NUM >= 0x070902
+#if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
@@ -126,7 +126,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp("http.sslcert", var))
 		return git_config_string(&ssl_cert, var, value);
-#if LIBCURL_VERSION_NUM >= 0x070902
+#if LIBCURL_VERSION_NUM >= 0x070903
 	if (!strcmp("http.sslkey", var))
 		return git_config_string(&ssl_key, var, value);
 #endif
@@ -196,7 +196,7 @@ static CURL *get_curl_handle(void)
 
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
-#if LIBCURL_VERSION_NUM >= 0x070902
+#if LIBCURL_VERSION_NUM >= 0x070903
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
 #endif
@@ -313,7 +313,7 @@ void http_init(struct remote *remote)
 		curl_ssl_verify = 0;
 
 	set_from_env(&ssl_cert, "GIT_SSL_CERT");
-#if LIBCURL_VERSION_NUM >= 0x070902
+#if LIBCURL_VERSION_NUM >= 0x070903
 	set_from_env(&ssl_key, "GIT_SSL_KEY");
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-- 
1.6.3.2
