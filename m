From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2] smart-http: Don't change POST to GET when following redirect
Date: Fri, 24 Sep 2010 14:20:23 +0800
Message-ID: <1285309223-4348-1-git-send-email-rctay89@gmail.com>
References: <AANLkTimwkXTs==+zT=Ue3jFNyRLL+7A1FFhoDuF-5zZ3@mail.gmail.com> <877hijvff7.fsf@catnip.gol.com> <20100918070315.GA30872@LK-Perkele-V2.elisa-laajakaista.fi> <m262y3cvpy.fsf@whitebox.home> <m21v8rcua1.fsf_-_@whitebox.home>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Miles Bader <miles@gnu.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 08:21:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz1fH-00053R-5h
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 08:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab0IXGUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 02:20:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65206 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab0IXGUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 02:20:45 -0400
Received: by pzk34 with SMTP id 34so530336pzk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=W4YVVQKbA2XisO002lkCSiIEM70WQab+OgZiiidR0vA=;
        b=Qq0UCYJ/llXJMzBTtxg0T057oLbkvSqhbgyWA2fLUoaI26AnzSKa0JjXOWqAqPiQ6s
         x+IpSsgwmnaG1CtiKL7i0kMag/yYSBFzOOYusNFI16hX7B+D9O0q/S13NniUfZj85aNo
         8cWQs82gFo5xDKy1TOrkTH2+4O8eYSo/cWls4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z5VrpKvt+5WVx9UlR/mAHa5t7H2/gMv3v1tWAFMn00fiv8F1MH6PIu0vElnoxM8cPR
         Vn7BSRAdDVbOmG1Lv6bXqyJ2cIer1g1ulNoZ+Ofe5ZHw2WTl3bAZBsqa/3dWGvlnUaAG
         uH/wEslMiFy2sK1ggSejxlucBDSfNOfXDqs34=
Received: by 10.114.46.20 with SMTP id t20mr3018189wat.181.1285309244435;
        Thu, 23 Sep 2010 23:20:44 -0700 (PDT)
Received: from localhost.localdomain (cm99.zeta153.maxonline.com.sg [116.87.153.99])
        by mx.google.com with ESMTPS id d38sm2901686wam.20.2010.09.23.23.20.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 23:20:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <AANLkTimwkXTs==+zT=Ue3jFNyRLL+7A1FFhoDuF-5zZ3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156933>

From: Andreas Schwab <schwab@linux-m68k.org>

For a long time (29508e1 "Isolate shared HTTP request functionality", Fri
Nov 18 11:02:58 2005), we've followed HTTP redirects with
CURLOPT_FOLLOWLOCATION.

However, when the remote HTTP server returns a redirect the default
libcurl action is to change a POST request into a GET request while
following the redirect, but the remote http backend does not expect
that.

Fix this by telling libcurl to always keep the request as type POST with
CURLOPT_POSTREDIR.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Added simple tests and made some changes to the patch message.

Andreas:
  shifted the setopt to right after FOLLOWLOCATION, since they're linked
  closely.

Jay: added the usual hexadecimal version checks.

 http.c                  |    3 +++
 t/lib-httpd/apache.conf |    7 +++++++
 t/t5551-http-fetch.sh   |    8 ++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 1320c50..25f8b45 100644
--- a/http.c
+++ b/http.c
@@ -275,6 +275,9 @@ static CURL *get_curl_handle(void)
 	}

 	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
+#if LIBCURL_VERSION_NUM >= 0x071301
+	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
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
