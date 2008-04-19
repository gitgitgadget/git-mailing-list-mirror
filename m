From: Tordek <kedrot@gmail.com>
Subject: [PATCH (try 2)] http.c: 'use_git_config_string' on configuration
 options.
Date: Sat, 19 Apr 2008 19:23:52 -0300
Message-ID: <480A70F8.8080400@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 00:24:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLUP-0007yl-6k
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbYDSWYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYDSWYK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:24:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:60962 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYDSWYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 18:24:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so710493ywb.1
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=i0Qiob8qHBLgOxB48stgP6dGAVRBsSK+oT+MoRljass=;
        b=q8lZA270csxkCIjdESlyDz7fM1LCsxGFm8N7Q9jcrJ5MNBvTbDpjkw5wqv2aM58j5UA+t1kAKV06NCTnlciZjsd0wtwcLppAU4zu8aeRUE5PknpHG62w/EHluNcxT29TAiRwqIgcJVuiZSM48Gh9CFY5QvWu4eNYFuTRC6Kp4UE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=N/9+ePsMDVlJA4ztrGBd/BXC2GAs1LnXWdx+2TUX6k/uEv75OcgLAWoHKllv7KBOQcMu2t4kGQTOIQLclKEFCNFbhFnkPbQ9VcWv7ABBsMHkPjpYGo+o67iPk6NsNxiTbVFLS+hNo0+k10Rc/4yurvY4BFiCSOIYkWk/w7AUYlA=
Received: by 10.150.12.10 with SMTP id 10mr5414191ybl.205.1208643838816;
        Sat, 19 Apr 2008 15:23:58 -0700 (PDT)
Received: from ?192.168.0.101? ( [190.137.195.23])
        by mx.google.com with ESMTPS id 7sm3782542ywo.1.2008.04.19.15.23.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Apr 2008 15:23:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79926>

Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
---
Second attempt at offering a Janitorial patch.

  http.c |   34 ++++++++++++----------------------
  1 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index 256a5f1..22c75f5 100644
--- a/http.c
+++ b/http.c
@@ -13,14 +13,14 @@ static CURL *curl_default;
  char curl_errorstr[CURL_ERROR_SIZE];

  static int curl_ssl_verify = -1;
-static char *ssl_cert = NULL;
+static const char *ssl_cert = NULL;
  #if LIBCURL_VERSION_NUM >= 0x070902
-static char *ssl_key = NULL;
+static const char *ssl_key = NULL;
  #endif
  #if LIBCURL_VERSION_NUM >= 0x070908
-static char *ssl_capath = NULL;
+static const char *ssl_capath = NULL;
  #endif
-static char *ssl_cainfo = NULL;
+static const char *ssl_cainfo = NULL;
  static long curl_low_speed_limit = -1;
  static long curl_low_speed_time = -1;
  static int curl_ftp_no_epsv = 0;
@@ -100,39 +100,29 @@ static int http_options(const char *var, const 
char *value)
  	}

  	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cert = xstrdup(value);
-		}
+		if (ssl_cert == NULL)
+			return git_config_string(&ssl_cert, var, value);
  		return 0;
  	}
  #if LIBCURL_VERSION_NUM >= 0x070902
  	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_key = xstrdup(value);
+		if (ssl_key == NULL)
+			return git_config_string(&ssl_key, var, value);
  		}
  		return 0;
  	}
  #endif
  #if LIBCURL_VERSION_NUM >= 0x070908
  	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_capath = xstrdup(value);
+		if (ssl_capath == NULL)
+			return git_config_string(&ssl_capath, var, value);
  		}
  		return 0;
  	}
  #endif
  	if (!strcmp("http.sslcainfo", var)) {
-		if (ssl_cainfo == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cainfo = xstrdup(value);
-		}
+		if (ssl_cainfo == NULL)
+			return git_config_string(&ssl_cainfo,val,var);
  		return 0;
  	}

-- 
1.5.2.2
