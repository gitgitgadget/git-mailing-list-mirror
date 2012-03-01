From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v2 2/3] http: try http_proxy env var when http.proxy config
 option is not set
Date: Thu, 01 Mar 2012 19:21:03 +0100
Message-ID: <4F4FBE0F.6020004@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 18:22:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39i9-0007PN-VP
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab2CARWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 12:22:32 -0500
Received: from luthien2.map.es ([82.150.0.102]:42289 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab2CARWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 12:22:32 -0500
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id ED3D024E7F;
	Thu,  1 Mar 2012 18:22:24 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 3F86AD4D4D;
	Thu,  1 Mar 2012 18:22:20 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: ED3D024E7F.8B3D9
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331227345.04974@M7K46YlFIu5+FPqGGSXCJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191950>

CuRL already reads it, but if $http_proxy has username but no password
curl will not ask you for the password.. so we read it ourselves to
detect that and ask for the password.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 8ac8eb6..8932da5 100644
--- a/http.c
+++ b/http.c
@@ -295,6 +295,13 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);

+	if (!curl_http_proxy) {
+		const char *env_proxy;
+		env_proxy = getenv("http_proxy");
+		if (env_proxy) {
+			curl_http_proxy = xstrdup(env_proxy);
+		}
+	}
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-- 
1.7.7.6
