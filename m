From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] imap-send: use cURL automatically when NO_OPENSSL defined
Date: Sat,  7 Mar 2015 21:13:55 -0800
Message-ID: <66ffbcf60233c62b6f0e443bd7d922c@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Sun Mar 08 06:14:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUTXV-00065m-J2
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 06:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbbCHFOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 00:14:05 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39242 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbCHFOC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 00:14:02 -0500
Received: by pabrd3 with SMTP id rd3so29828660pab.6
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 21:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HSmGaHYuzRti8eWDBfVx+Ap++wDQXLmPNto1IEbm2Yg=;
        b=jvALMNzj37KAnwrg2OgvKlmgtBhNztgha7PKkU/mA5UJPIzOMZo50iqRozUj+LD5U5
         34sx/K/opjMnCRTvzx5szoe0NwtNLAg2uQNuAmnuUY+vSfViGk0C+0vWRe6kwuqLu4mF
         Qyp3GTKfwZeN0eH9dgh6FdIKHV11WI2HUA/S74b0Sp9bGZ/K7FbAScNowd5XYTjJKll2
         WeFQ03KTkRsRqss0DpZfpXwkWo+7UKAebKM2AJ9bVW0cVmOeuGVb5u6swYihz9VAhL+N
         QycXp+HFxIgaPMRTGtJmgXUyvu8EHjlQ46P1qS2AefmTdxsfbmkwx2DgdyBmu+hq0bCJ
         EBBg==
X-Received: by 10.68.135.136 with SMTP id ps8mr40243869pbb.130.1425791641263;
        Sat, 07 Mar 2015 21:14:01 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id bl2sm13885316pad.15.2015.03.07.21.14.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 21:14:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265030>

If both USE_CURL_FOR_IMAP_SEND and NO_OPENSSL are defined do
not force the user to add --curl to get a working git imap-send
command.

Instead automatically select --curl and warn and ignore the
--no-curl option.  And while we're in there, correct the
warning message when --curl is requested but not supported.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 Documentation/git-imap-send.txt |  3 ++-
 imap-send.c                     | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 77aacf13..5d1e4c80 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -44,7 +44,8 @@ OPTIONS
 
 --no-curl::
 	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.
+	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
+	set.
 
 
 CONFIGURATION
diff --git a/imap-send.c b/imap-send.c
index d69887da..37ac4aa8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -34,8 +34,16 @@ typedef void *SSL;
 #include "http.h"
 #endif
 
+#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
+/* only available option */
+#define USE_CURL_DEFAULT 1
+#else
+/* strictly opt in */
+#define USE_CURL_DEFAULT 0
+#endif
+
 static int verbosity;
-static int use_curl; /* strictly opt in */
+static int use_curl = USE_CURL_DEFAULT;
 
 static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
 
@@ -1504,9 +1512,14 @@ int main(int argc, char **argv)
 
 #ifndef USE_CURL_FOR_IMAP_SEND
 	if (use_curl) {
-		warning("--use-curl not supported in this build");
+		warning("--curl not supported in this build");
 		use_curl = 0;
 	}
+#elif defined(NO_OPENSSL)
+	if (!use_curl) {
+		warning("--no-curl not supported in this build");
+		use_curl = 1;
+	}
 #endif
 
 	if (!server.port)
---
