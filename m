From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3] smart-http: Don't change POST to GET when following redirect
Date: Sat, 25 Sep 2010 12:20:35 +0800
Message-ID: <1285388435-5336-1-git-send-email-rctay89@gmail.com>
References: <m21v8jaudw.fsf@igel.home> <1285309223-4348-1-git-send-email-rctay89@gmail.com> <AANLkTimwkXTs==+zT=Ue3jFNyRLL+7A1FFhoDuF-5zZ3@mail.gmail.com> <877hijvff7.fsf@catnip.gol.com> <20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi> <m262y3cvpy.fsf@whitebox.home> <m21v8rcua1.fsf_-_@whitebox.home>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Miles Bader <miles@gnu.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 06:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzMGL-0000KP-Ad
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 06:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218Ab0IYEUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 00:20:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41756 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab0IYEUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 00:20:52 -0400
Received: by pzk34 with SMTP id 34so795273pzk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Tw/hgPLn+BQpMAC47c6Na3mFdsq+XDZbCT/Y3qDoiXI=;
        b=KdLoAkVqD5F6Yf0CpaG9vKoQ1oKoMcyzQ/jNS+pp4kPm8W6VmY3HukJsJjzsxsvBUK
         VchT9r29u6O8mz/0mhUeapaeyRbeAdpGIpQHnbNeuRgSzpwRgk1kN3HCQYGqIeqWj8/U
         guwwThLznWebUXT+h8RX8VRPepaPUN4BTUgkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wVP+Vvvh6giDiGV3wn70fGQKW9EVLsFi8Z2DHz/5v3unsmDyjrx4mWZ4BX/i5IQO2C
         yXnprBFH+tKIDqJDnvAtSRHVqpVI28fckRbxbDxr3XsyOwdvWOPc6SllZ6vr9xAoDEpt
         6w21YnnlMQY1q6vtUGgrIBHX8BBszS6akl0kY=
Received: by 10.142.78.12 with SMTP id a12mr3623695wfb.43.1285388451946;
        Fri, 24 Sep 2010 21:20:51 -0700 (PDT)
Received: from localhost.localdomain (cm99.zeta153.maxonline.com.sg [116.87.153.99])
        by mx.google.com with ESMTPS id e12sm3248293wfh.1.2010.09.24.21.20.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 21:20:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <m21v8jaudw.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157115>

For a long time (29508e1 "Isolate shared HTTP request functionality", Fri
Nov 18 11:02:58 2005), we've followed HTTP redirects with
CURLOPT_FOLLOWLOCATION.

However, when the remote HTTP server returns a redirect the default
libcurl action is to change a POST request into a GET request while
following the redirect, but the remote http backend does not expect
that.

Fix this by telling libcurl to always keep the request as type POST with
CURLOPT_POSTREDIR.

For users of libcurl older than 7.19.1, use CURLOPT_POST301 instead,
which only follows 301s instead of both 301s and 302s.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Andreas: added CURLOPT_POST301 alternative. There doesn't seem to be a pretty
         constant, the docs just say a non-zero value [1] or 1 [2].

[1] http://github.com/bagder/curl/blob/curl-7_17_1/docs/libcurl/curl_easy_setopt.3#L646
[2] http://github.com/bagder/curl/blob/curl-7_19_0/docs/libcurl/curl_easy_setopt.3#L699

 http.c                  |    5 +++++
 t/lib-httpd/apache.conf |    7 +++++++
 t/t5551-http-fetch.sh   |    8 ++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 1320c50..d10e2f0 100644
--- a/http.c
+++ b/http.c
@@ -275,6 +275,11 @@ static CURL *get_curl_handle(void)
 	}

 	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
+#if LIBCURL_VERSION_NUM >= 0x071301
+	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+#elif LIBCURL_VERSION_NUM >= 0x071101
+	curl_easy_setopt(result, CURLOPT_POST301, 1);
+#endif

 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 4961505..f41c7c6 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -17,6 +17,9 @@ ErrorLog error.log
 <IfModule !mod_env.c>
 	LoadModule env_module modules/mod_env.so
 </IfModule>
+<IfModule !mod_rewrite.c>
+	LoadModule rewrite_module modules/mod_rewrite.so
+</IFModule>

 Alias /dumb/ www/

@@ -36,6 +39,10 @@ ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
 	Options ExecCGI
 </Files>

+RewriteEngine on
+RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
+RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
+
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index fd19121..26d3557 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -101,5 +101,13 @@ test_expect_success 'used upload-pack service' '
 	test_cmp exp act
 '

+test_expect_success 'follow redirects (301)' '
+	git clone $HTTPD_URL/smart-redir-perm/repo.git --quiet repo-p
+'
+
+test_expect_success 'follow redirects (302)' '
+	git clone $HTTPD_URL/smart-redir-temp/repo.git --quiet repo-t
+'
+
 stop_httpd
 test_done
--
1.7.3.67.g2a10b
