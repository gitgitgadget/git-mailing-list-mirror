From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Mon, 26 Oct 2015 14:15:07 +0100 (CET)
Message-ID: <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqhcO-0000qJ-0g
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbbJZNPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:15:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:58958 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbbJZNPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:15:12 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LdYSM-1aGeVy372Y-00ii9Z;
 Mon, 26 Oct 2015 14:15:08 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:bz0uYNcHl0bnOPDtydfA2yaKmaF4Eo0+yTYug0D4UuPVe3ga8HM
 N7j9TpB55A5OZ3yudl1riGrdJbrr5aWwv2QwR43EY8Q919gx/9tBo2+FwT4AuO5pkXSaZPd
 qTDtQmJ53PeJaBDkBZMSavR2eIeRWSO9bWHeaGIwLx8ARmak9KgBWH39NFmUFvpqeHjg+NP
 azyYiIfeHMGY02r3EoZkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uZPBz+INFmo=:1t5iRRU3la/RBmhrGShENo
 RxW6/Ian4MTOeX8L9sOf6/SSN4UIO1Sn5THraQ+s5zfl6puXSidbTbEngMntG/J79OmGUFER8
 mli5gofE7RNj7thFxxBivmQR5PV9vm6+WsjtUBf4bvx9JZz9hHof052dMWRzcSJNjRbfEKs8I
 fzCe47QKSEHvexUiQwMmHDOu6RLxaX74G/6JZX167Rmc1CoVCEAZI1X4ug+2Sos1G4MSfM8qk
 DXZvxNWgtteZlX0kBHqFWgMlLKBeYm7hwEB8tBe+rG0n9bUfzEqoW23aArUV59Rapt2Mp76KM
 t92aAzJQh19tMjn/gtgukfVJiGgKP5rVtuGdnCZURARaoeQ4f2s9XS+mPBlSb+xfjCtfavxVy
 HsBKhTdwJQi5ka6rYUtmzSUxw9dp3NmjiB5XKJu0iRJK0+7VQMsXbH59jI25iKZ3MlDL09uuZ
 fYAVqpUpQk70YkVgPUO2MiMX3+EsAP53Vqvafhgr7u694sffb7Zu6ronmEgnKeKQvKqgutzlQ
 8WtukVEnlXepR1zAukxvAc9IGcVVxtQ3ATZtkR8jYcMk0H8i9rNtMbz2V9CpmRPDJX9G3yDUO
 JgvEfPz9O4PpkPjHK4DZVqu5hpZ/IE5vZQ/gQA/Govf6ZbZALPyTnbVaVGx01oEA+DgaB/hnL
 Sh9Yb5+Oyvuv05Jpc02smW88xiQn6Pi3Ln9598+Sujk2nCsV/gMeBgHSuQlpPL2L+IXd3Otsy
 wZXVKA7V+NYDHD9g0ELW+cXqbl439Q+/TZilcR+SuZypzYTb/RvJgIyi40aKZUAv/zzQhQiI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280191>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

With this patch we properly support SOCKS proxies, configured e.g. like
this:

	git config http.proxy socks5://192.168.67.1:32767

Without this patch, Git mistakenly tries to use SOCKS proxies as if they
were HTTP proxies, resulting in a error message like:

	fatal: unable to access 'http://.../': Proxy CONNECT aborted

This patch was required to work behind a faulty AP and scraped from
http://stackoverflow.com/questions/15227130/#15228479 and guarded with
an appropriate cURL version check by Johannes Schindelin.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/http.c b/http.c
index 7da76ed..6b89dea 100644
--- a/http.c
+++ b/http.c
@@ -465,6 +465,17 @@ static CURL *get_curl_handle(void)
 
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+#if LIBCURL_VERSION_NUM >= 0x071800
+		if (starts_with(curl_http_proxy, "socks5"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
+		else if (starts_with(curl_http_proxy, "socks4a"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
+		else if (starts_with(curl_http_proxy, "socks"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+#endif
 	}
 #if LIBCURL_VERSION_NUM >= 0x070a07
 	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-- 
2.1.4
