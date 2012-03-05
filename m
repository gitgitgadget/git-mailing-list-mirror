From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v3 1/4] http: support proxies that needs authentication
Date: Mon, 05 Mar 2012 16:16:11 +0100
Message-ID: <4F54D8BB.4080305@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 15:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4YjV-0002wI-In
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab2CEORp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:17:45 -0500
Received: from luthien1.map.es ([82.150.0.102]:43825 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932492Ab2CEORo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:17:44 -0500
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id 8855B24B45;
	Mon,  5 Mar 2012 15:17:35 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id AE53418003D;
	Mon,  5 Mar 2012 15:17:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 8855B24B45.7F265
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331561855.63649@DVVU4ilTzyz5rtF3oliqgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192242>

When the proxy server specified by the http.proxy configuration or
the http_proxy environment variable requires authentication, git
failed to connect to the proxy, because we did not configure the
cURL handle with CURLOPT_PROXYAUTH.

When a proxy is in use, and you tell git that the proxy requires
authentication by having username in the http.proxy configuration,
an extra request needs to be made to the proxy to find out what
authentication method it supports, as this patch uses CURLAUTH_ANY
to let the library pick the most secure method supported by the
proxy server.

The extra round-trip adds extra latency, but relieves the user
from the burden to configure a specific authentication method.  If
it becomes problem, a later patch could add a configuration option
to specify what method to use, but let's start simple for the time
being.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 0ffd79c..8ac8eb6 100644
--- a/http.c
+++ b/http.c
@@ -295,8 +295,10 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-	if (curl_http_proxy)
+	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+	}
 
 	return result;
 }
-- 
1.7.7.6
