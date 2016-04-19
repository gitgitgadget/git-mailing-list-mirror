From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/4] http.h: Add debug callback and helper routine for
 implementing the GIT_TRACE_CURL environment variable in http.c
Date: Tue, 19 Apr 2016 23:11:55 +0100
Message-ID: <5716AD2B.3050701@ramsayjones.plus.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
 <20160419151044.27814-2-gitter.spiros@gmail.com>
 <5716A7C6.40507@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, gitster@pobox.com, sunshine@sunshineco.com,
	peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:30:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseAb-0006jD-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbcDSWax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:30:53 -0400
Received: from avasout07.plus.net ([84.93.230.235]:56166 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcDSWax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:30:53 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id kNWp1s0022D2Veb01NWq9A; Tue, 19 Apr 2016 23:30:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=uqDsM_BnWSDKI580JFEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <5716A7C6.40507@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291939>



On 19/04/16 22:48, Ramsay Jones wrote:
> 
[snip]

> I think the minimal fixup (including Junio's comment on patch #2, which also
> triggered for me) is given in the patch below.

BTW, if you want to have a single static instance of the 'struct trace_key',
then the following patch on top should work. (Also, I have compiled and run
the testsuite on these patches, but _not_ tested that the trace functionality
actually works!) ;-)

HTH

ATB,
Ramsay Jones
-- >8 --
Subject: [PATCH] curl-trace: reduce visibility of the trace key struct

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 http.c      | 9 +++++++--
 http.h      | 2 +-
 imap-send.c | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index ce91421..eed6dba 100644
--- a/http.c
+++ b/http.c
@@ -11,7 +11,7 @@
 #include "gettext.h"
 #include "transport.h"
 
-struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
+static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
 #else
@@ -516,6 +516,11 @@ static void curl_dump(const char *text, unsigned char *ptr, size_t size, char no
 	}
 }
 
+int curl_trace_want(void)
+{
+	return trace_want(&trace_curl);
+}
+
 int curl_trace(CURL *handle, curl_infotype type,
 	     char *data, size_t size, void *userp)
 {
@@ -652,7 +657,7 @@ static CURL *get_curl_handle(void)
 			"your curl version is too old (>= 7.19.4)");
 #endif
 
-	if (trace_want(&trace_curl)) {
+	if (curl_trace_want()) {
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
 		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
 		curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
diff --git a/http.h b/http.h
index 00e4ad7..153ff17 100644
--- a/http.h
+++ b/http.h
@@ -225,7 +225,7 @@ extern void abort_http_object_request(struct http_object_request *freq);
 extern void release_http_object_request(struct http_object_request *freq);
 
 /* Debug callback and helper routine for curl_easy_setopt CURLOPT_DEBUGFUNCTION */
-extern struct trace_key trace_curl;
+int curl_trace_want(void);
 int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp);
 
 
diff --git a/imap-send.c b/imap-send.c
index 36ff843..627ffa4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1444,7 +1444,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
 
-	if (trace_want(&trace_curl)) {
+	if (curl_trace_want()) {
 		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
 		curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
 		curl_easy_setopt(curl, CURLOPT_DEBUGDATA, NULL);
-- 
2.8.0
