From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Thu, 26 Apr 2012 18:29:47 +0200
Message-ID: <4F9977FB.8010601@seap.minhap.es>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com><4F966F0C.6090504@seap.minhap.es><xmqqipgpgdpl.fsf@junio.mtv.corp.google.com><4F994AC3.2070708@seap.minhap.es><20120426130854.GC27785@sigill.intra.peff.net> <xmqqehraa5ct.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:33:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNQhF-00008H-9k
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 17:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2DZPdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 11:33:25 -0400
Received: from luthien2.mpt.es ([82.150.0.102]:40072 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756047Ab2DZPdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 11:33:24 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id AC0E2B70A0;
	Thu, 26 Apr 2012 17:32:33 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 89BEDD4CD4;
	Thu, 26 Apr 2012 17:32:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <xmqqehraa5ct.fsf@junio.mtv.corp.google.com>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: AC0E2B70A0.51327
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336059155.10363@KU6FVsnMC1tl/ybh06v9Jg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196374>

On 04/26/2012 05:18 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Don't we explicitly not want to do this when the protocol is http? Curl
>> doesn't respect HTTP_PROXY.
> 
> Yes.  Here is what I'll queue.

Fine. You beat me on time, anyway I send you my version just for the sake
of having done it.

>From 66c5e59f486088d12b48a2e624a98242e7ebce46 Mon Sep 17 00:00:00 2001
From: Nelson Benitez Leon <nbenitezl@gmail.com>
Date: Thu, 26 Apr 2012 14:44:03 +0200
Subject: [PATCH] http: try an uppercase version of $prot_proxy env var

If the lowercase version of $prot_proxy is not found
then try the uppercase one, excluding HTTP_PROXY case
as it is ignored by cURL.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 6a98195..0ca5bba 100644
--- a/http.c
+++ b/http.c
@@ -329,6 +329,13 @@ static CURL *get_curl_handle(const char *url)
 		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
 		env_proxy_var = strbuf_detach(&buf, NULL);
 		env_proxy = getenv(env_proxy_var);
+		if (!env_proxy && strcmp("http", cre_url.protocol)) { /* skip HTTP_PROXY as cURL ignores it */
+			char *p;
+			for (p = env_proxy_var; *p; p++) {
+				*p = toupper(*p);
+			}
+			env_proxy = getenv(env_proxy_var);
+		}
 		if (env_proxy) {
 			read_http_proxy = 1;
 			no_proxy = getenv("no_proxy");
-- 
1.7.7.6
