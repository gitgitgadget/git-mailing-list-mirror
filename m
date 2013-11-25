From: Jeff King <peff@peff.net>
Subject: [curl PATCH 1/2] factor out sigpipe_reset from easy.c
Date: Mon, 25 Nov 2013 09:35:37 -0500
Message-ID: <20131125143536.GA22701@sigill.intra.peff.net>
References: <20131125143213.GA22642@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Nov 25 15:35:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkxGK-0005xa-CR
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 15:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab3KYOfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 09:35:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:45321 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751897Ab3KYOfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 09:35:38 -0500
Received: (qmail 11035 invoked by uid 102); 25 Nov 2013 14:35:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Nov 2013 08:35:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Nov 2013 09:35:37 -0500
Content-Disposition: inline
In-Reply-To: <20131125143213.GA22642@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238308>

Commit 7d80ed64e43515 introduced some helpers to handle
sigpipe in easy.c. However, that fix was incomplete, and we
need to add more callers in other files. The first step is
making the helpers globally accessible.

Since the functions are small and should generally end up
inlined anyway, we simply define them in the header as
static functions.

Signed-off-by: Jeff King <peff@peff.net>
---
We can also do it as a separate '.c' file if you prefer.

Note that this will #include the system signal.h at a different point in
easy.c now (in particular, after we have included more local headers). I
don't know if that has any portability implications.

I almost wonder if the SIGPIPE_IGNORE definition (and inclusion of
signal.h) should go into curl-setup.h.  I have very little knowledge of
the curl code base and conventions, so please feel free to hack it up or
point me in the right direction.

 lib/Makefile.inc |  2 +-
 lib/easy.c       | 56 +-----------------------------------------------------
 lib/sigpipe.h    | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 56 deletions(-)
 create mode 100644 lib/sigpipe.h

diff --git a/lib/Makefile.inc b/lib/Makefile.inc
index ec71770..62bc0b3 100644
--- a/lib/Makefile.inc
+++ b/lib/Makefile.inc
@@ -46,4 +46,4 @@ HHEADERS = arpa_telnet.h netrc.h file.h timeval.h qssl.h hostip.h	\
   curl_ntlm_msgs.h curl_sasl.h curl_schannel.h curl_multibyte.h		\
   curl_darwinssl.h hostcheck.h bundles.h conncache.h curl_setup_once.h	\
   multihandle.h setup-vms.h pipeline.h dotdot.h x509asn1.h gskit.h	\
-  http2.h
+  http2.h sigpipe.h
diff --git a/lib/easy.c b/lib/easy.c
index 1e718ab..1dbdcb7 100644
--- a/lib/easy.c
+++ b/lib/easy.c
@@ -50,11 +50,6 @@
 #include <sys/param.h>
 #endif
 
-#if defined(HAVE_SIGNAL_H) && defined(HAVE_SIGACTION) && defined(USE_OPENSSL)
-#define SIGPIPE_IGNORE 1
-#include <signal.h>
-#endif
-
 #include "strequal.h"
 #include "urldata.h"
 #include <curl/curl.h>
@@ -78,6 +73,7 @@
 #include "warnless.h"
 #include "conncache.h"
 #include "multiif.h"
+#include "sigpipe.h"
 
 #define _MPRINTF_REPLACE /* use our functions only */
 #include <curl/mprintf.h>
@@ -85,56 +81,6 @@
 /* The last #include file should be: */
 #include "memdebug.h"
 
-#ifdef SIGPIPE_IGNORE
-struct sigpipe_ignore {
-  struct sigaction old_pipe_act;
-  bool no_signal;
-};
-
-#define SIGPIPE_VARIABLE(x) struct sigpipe_ignore x
-
-/*
- * sigpipe_ignore() makes sure we ignore SIGPIPE while running libcurl
- * internals, and then sigpipe_restore() will restore the situation when we
- * return from libcurl again.
- */
-static void sigpipe_ignore(struct SessionHandle *data,
-                           struct sigpipe_ignore *ig)
-{
-  /* get a local copy of no_signal because the SessionHandle might not be
-     around when we restore */
-  ig->no_signal = data->set.no_signal;
-  if(!data->set.no_signal) {
-    struct sigaction action;
-    /* first, extract the existing situation */
-    memset(&ig->old_pipe_act, 0, sizeof(struct sigaction));
-    sigaction(SIGPIPE, NULL, &ig->old_pipe_act);
-    action = ig->old_pipe_act;
-    /* ignore this signal */
-    action.sa_handler = SIG_IGN;
-    sigaction(SIGPIPE, &action, NULL);
-  }
-}
-
-/*
- * sigpipe_restore() puts back the outside world's opinion of signal handler
- * and SIGPIPE handling. It MUST only be called after a corresponding
- * sigpipe_ignore() was used.
- */
-static void sigpipe_restore(struct sigpipe_ignore *ig)
-{
-  if(!ig->no_signal)
-    /* restore the outside state */
-    sigaction(SIGPIPE, &ig->old_pipe_act, NULL);
-}
-
-#else
-/* for systems without sigaction */
-#define sigpipe_ignore(x,y) Curl_nop_stmt
-#define sigpipe_restore(x)  Curl_nop_stmt
-#define SIGPIPE_VARIABLE(x)
-#endif
-
 /* win32_cleanup() is for win32 socket cleanup functionality, the opposite
    of win32_init() */
 static void win32_cleanup(void)
diff --git a/lib/sigpipe.h b/lib/sigpipe.h
new file mode 100644
index 0000000..73fb853
--- /dev/null
+++ b/lib/sigpipe.h
@@ -0,0 +1,58 @@
+#ifndef HEADER_CURL_SIGPIPE_H
+#define HEADER_CURL_SIGPIPE_H
+
+#include "curl_setup.h"
+
+#if defined(HAVE_SIGNAL_H) && defined(HAVE_SIGACTION) && defined(USE_OPENSSL)
+#include <signal.h>
+
+struct sigpipe_ignore {
+  struct sigaction old_pipe_act;
+  bool no_signal;
+};
+
+#define SIGPIPE_VARIABLE(x) struct sigpipe_ignore x
+
+/*
+ * sigpipe_ignore() makes sure we ignore SIGPIPE while running libcurl
+ * internals, and then sigpipe_restore() will restore the situation when we
+ * return from libcurl again.
+ */
+static void sigpipe_ignore(struct SessionHandle *data,
+                           struct sigpipe_ignore *ig)
+{
+  /* get a local copy of no_signal because the SessionHandle might not be
+     around when we restore */
+  ig->no_signal = data->set.no_signal;
+  if(!data->set.no_signal) {
+    struct sigaction action;
+    /* first, extract the existing situation */
+    memset(&ig->old_pipe_act, 0, sizeof(struct sigaction));
+    sigaction(SIGPIPE, NULL, &ig->old_pipe_act);
+    action = ig->old_pipe_act;
+    /* ignore this signal */
+    action.sa_handler = SIG_IGN;
+    sigaction(SIGPIPE, &action, NULL);
+  }
+}
+
+/*
+ * sigpipe_restore() puts back the outside world's opinion of signal handler
+ * and SIGPIPE handling. It MUST only be called after a corresponding
+ * sigpipe_ignore() was used.
+ */
+static void sigpipe_restore(struct sigpipe_ignore *ig)
+{
+  if(!ig->no_signal)
+    /* restore the outside state */
+    sigaction(SIGPIPE, &ig->old_pipe_act, NULL);
+}
+
+#else
+/* for systems without sigaction */
+#define sigpipe_ignore(x,y) Curl_nop_stmt
+#define sigpipe_restore(x)  Curl_nop_stmt
+#define SIGPIPE_VARIABLE(x)
+#endif
+
+#endif /* HEADER_CURL_SIGPIPE_H */
-- 
1.8.5.rc3.491.ge1614cf
