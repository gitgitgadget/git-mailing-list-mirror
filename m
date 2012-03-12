From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v4 1/5] http: try http_proxy env var when http.proxy config
 option is not set
Date: Mon, 12 Mar 2012 18:25:52 +0100
Message-ID: <4F5E31A0.1000503@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 17:27:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S786H-0006Ui-M3
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab2CLQ1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:27:53 -0400
Received: from luthien1.mpt.es ([82.150.0.102]:28552 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab2CLQ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:27:51 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id B84DFB70B3;
	Mon, 12 Mar 2012 17:27:04 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id AA4502039BB;
	Mon, 12 Mar 2012 17:27:00 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: B84DFB70B3.630F8
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332174425.22792@IiMvYRjB/FA8C3TVf9162g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192894>

cURL already reads it, but if $http_proxy has username but no password
cURL will not ask you for the password and so failed to authenticate
returning a 407 error code. So we read it ourselves to detect that and
ask for the password. Also we read it prior to connection to be able to
make a proactive authentication in case the flag http_proactive_auth is
set.

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
