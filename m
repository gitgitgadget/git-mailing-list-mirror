From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v2 1/3]http: authenticate on NTLM proxies and others suppported
 by CuRL
Date: Thu, 01 Mar 2012 19:19:38 +0100
Message-ID: <4F4FBDBA.8040609@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, sam@vilain.net
X-From: git-owner@vger.kernel.org Thu Mar 01 18:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S39gp-0006RZ-Bq
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab2CARVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 12:21:09 -0500
Received: from luthien2.mpt.es ([82.150.0.102]:35121 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411Ab2CARVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 12:21:08 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id DF7BC24D16;
	Thu,  1 Mar 2012 18:20:59 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 09A8F2C656;
	Thu,  1 Mar 2012 18:20:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: DF7BC24D16.62297
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331227260.3863@GtXUWDB3w/C15BmmD3M5uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191949>

CURLAUTH_ANY option automatically chooses the best auth method
from among those the server supports, that means curl
will ask the proxy and use the appropiate, and it will only do that if
you are using a proxy (i.e. you've set CURLOPT_PROXY or you have http_proxy
env var), also curl will not try to authenticate if you've not provided
username or password in the proxy string, as told here[1]..

so, setting CURLOPT_PROXYAUTH = CURLAUTH_ANY will not affect the speed of
normal curl use, only if 1) you are using a proxy and 2) your proxy requires
authentication, only then curl will just make two or three roundtrips to find out
the auth methods the proxy is using, that is a tiny cost compared to having the
user find out the proxy auth type and set manually a specific config option to
enable that type.

So as CURLAUTH_ANY provide us out-of-the-box proxy support without affecting speed,
we don't want it activated manually from a config option, instead we added it
automatically when a proxy is being used.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=769254#c6

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
