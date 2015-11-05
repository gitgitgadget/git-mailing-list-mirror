From: atousa.p@gmail.com
Subject: [PATCH v4 1/3] Provide another level of abstraction for the SHA1 utilities.
Date: Wed,  4 Nov 2015 22:38:41 -0800
Message-ID: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
References: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 08:09:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuEfv-0005wo-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033038AbbKEHGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 02:06:39 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35626 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032974AbbKEGlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:41:20 -0500
Received: by pasz6 with SMTP id z6so80853241pas.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 22:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=90kI1rhnqV79kP3pibtsZxGmbHY9emMKqyXk7kKxFgw=;
        b=PClwe2lVo8/ZdsLZH1dBxWLYjC5ZOTsqI2ZjWONb01Mr+EaaChEfvy4m4Dgx2Z0QU3
         XS7DsINVMF3HIN2RISjJIM9/F8TJO88BlPW7vSOTFqTIgMGF9vhR0Od4nVq4mq1OLIgv
         0azTotgqEvroVDG2/9spiK5H64kCdZ8X0qKlf4Rs2s/sVoFS4XaJkSRJ7vKhbxaNdcBP
         5BRvUbzdDKa3xak16380Dlsp+T2Nk9dreK+9D9Bmd/zkXg15Gxnu/w/kW2jXfoofQdt+
         3VMNgYJ7pmKOoTNeTTvSRvcz+9/8B0DR/qeAIod6jdLWFsfuM9GCNeapN7pK5+TML5eY
         fx/A==
X-Received: by 10.68.96.226 with SMTP id dv2mr7241900pbb.127.1446705680257;
        Wed, 04 Nov 2015 22:41:20 -0800 (PST)
Received: from Atousas-Air.jduprat.net ([50.240.193.13])
        by smtp.gmail.com with ESMTPSA id nu5sm5710601pbb.65.2015.11.04.22.41.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 22:41:19 -0800 (PST)
X-Google-Original-From: apahlevan@ieee.org
X-Mailer: git-send-email 2.4.9 (Apple Git-60)
In-Reply-To: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280911>

From: Atousa Pahlevan Duprat <apahlevan@ieee.org>

The git source uses git_SHA1_Update() and friends to call
into the code that computes the hashes.  This is can then be
mapped directly to an implementation that computes the hash,
such as platform_SHA1_Update(); or as we will do in a subsequent
patch, it can be mapped to something more complex that will in turn call
into the platform's SHA implementation.

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
---
 cache.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index a9aaa03..a934a2e 100644
--- a/cache.h
+++ b/cache.h
@@ -12,10 +12,21 @@
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
-#define git_SHA_CTX	SHA_CTX
-#define git_SHA1_Init	SHA1_Init
-#define git_SHA1_Update	SHA1_Update
-#define git_SHA1_Final	SHA1_Final
+
+/* platform's underlying implementation of SHA1, could be OpenSSL,
+   blk_SHA, Apple CommonCrypto, etc...  */
+#define platform_SHA_CTX	SHA_CTX
+#define platform_SHA1_Init	SHA1_Init
+#define platform_SHA1_Update	SHA1_Update
+#define platform_SHA1_Final    	SHA1_Final
+
+/* git may call platform's underlying implementation of SHA1 directly,
+   or may call it through a wrapper */
+#define git_SHA_CTX		platform_SHA_CTX
+#define git_SHA1_Init		platform_SHA1_Init
+#define git_SHA1_Update		platform_SHA1_Update
+#define git_SHA1_Final		platform_SHA1_Final
+
 #endif
 
 #include <zlib.h>
-- 
2.4.9 (Apple Git-60)
