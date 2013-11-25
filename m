From: Jeff King <peff@peff.net>
Subject: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
Date: Mon, 25 Nov 2013 09:43:21 -0500
Message-ID: <20131125144321.GA23779@sigill.intra.peff.net>
References: <20131125143213.GA22642@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Nov 25 15:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkxNo-0001Hr-US
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 15:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab3KYOnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 09:43:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:45326 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754066Ab3KYOnX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 09:43:23 -0500
Received: (qmail 11399 invoked by uid 102); 25 Nov 2013 14:43:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Nov 2013 08:43:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Nov 2013 09:43:21 -0500
Content-Disposition: inline
In-Reply-To: <20131125143213.GA22642@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238309>

This is an extension to the fix in 7d80ed64e43515. We may
call Curl_disconnect() while cleaning up the multi handle,
which could lead to openssl sending packets, which could get
a SIGPIPE.

Signed-off-by: Jeff King <peff@peff.net>
---
I really am just cargo-culting here. I have no idea what
multi->closure_handle does, except that it gets used as conn->data for
the connection we pass to Curl_disconnect, so it seems like a reasonable
place to check for the magic no_signal variable.

 lib/multi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/multi.c b/lib/multi.c
index 923e2ce..2ecb1a4 100644
--- a/lib/multi.c
+++ b/lib/multi.c
@@ -41,6 +41,7 @@
 #include "bundles.h"
 #include "multihandle.h"
 #include "pipeline.h"
+#include "sigpipe.h"
 
 #define _MPRINTF_REPLACE /* use our functions only */
 #include <curl/mprintf.h>
@@ -1786,12 +1787,18 @@ CURLMcode curl_multi_cleanup(CURLM *multi_handle)
   struct SessionHandle *nextdata;
 
   if(GOOD_MULTI_HANDLE(multi)) {
+    SIGPIPE_VARIABLE(pipe);
+    bool restore_pipe = FALSE;
+
     multi->type = 0; /* not good anymore */
 
     /* Close all the connections in the connection cache */
     close_all_connections(multi);
 
     if(multi->closure_handle) {
+      sigpipe_ignore(multi->closure_handle, &pipe);
+      restore_pipe = TRUE;
+
       multi->closure_handle->dns.hostcache = multi->hostcache;
       Curl_hostcache_clean(multi->closure_handle,
                            multi->closure_handle->dns.hostcache);
@@ -1836,6 +1843,8 @@ CURLMcode curl_multi_cleanup(CURLM *multi_handle)
     Curl_pipeline_set_server_blacklist(NULL, &multi->pipelining_server_bl);
 
     free(multi);
+    if (restore_pipe)
+      sigpipe_restore(&pipe);
 
     return CURLM_OK;
   }
-- 
1.8.5.rc3.491.ge1614cf
