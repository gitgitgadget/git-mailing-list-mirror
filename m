From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 03/16] compat: add inet_pton and inet_ntop prototypes
Date: Thu,  4 Nov 2010 02:35:11 +0100
Message-ID: <1288834524-2400-4-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDok1-00013V-4E
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428Ab0KDBfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51588 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab0KDBfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:34 -0400
Received: by ewy7 with SMTP id 7so738623ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wjYhNqw6V62iCfx894LOUo6iKjZ4nZRXCft+3LAAdbQ=;
        b=CdgLd8TAm0MbwZamzV8ExkVv2KUfxQ7FXroc5HfYXpFyag2st5rzl6+BZJCW7CSRcU
         m9QJp5vN1WEwEXk06xfm/7MV2aksV03AQR2doYAWFSo2AqHBhzUMOLfn8UuUA6tnY4qy
         R2Esh2U6M/tMmLJeHFEuxnz1Y1h9BR9p5UwQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tk3tnL1ghjoiLBAHzOolNqYLdr7SbdNijLRqcbYtO4ts82S7Yflp9XePpsdcc6mHoG
         YFmbdEhedFudGu7noCqrqFQKYOzShqirOAAoCMsktCjnHfPIJ5+vDUZZZl+gqPTxOfjZ
         epDBv6qO/QvOKES1cSS50dTUKRjvxUJsugh8g=
Received: by 10.14.11.147 with SMTP id 19mr44894eex.14.1288834532941;
        Wed, 03 Nov 2010 18:35:32 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm7193466eeh.14.2010.11.03.18.35.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160665>

From: Mike Pape <dotzenlabs@gmail.com>

Windows doesn't have inet_pton and inet_ntop, so
add prototypes in git-compat-util.h for them.

At the same time include git-compat-util.h in
the sources for these functions, so they use the
network-wrappers from there on Windows.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile           |    2 ++
 compat/inet_ntop.c |    6 +++---
 compat/inet_pton.c |    8 +++++---
 git-compat-util.h  |    8 ++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d9d9419..2aa067a 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,9 +1398,11 @@ endif
 endif
 ifdef NO_INET_NTOP
 	LIB_OBJS += compat/inet_ntop.o
+	BASIC_CFLAGS += -DNO_INET_NTOP
 endif
 ifdef NO_INET_PTON
 	LIB_OBJS += compat/inet_pton.o
+	BASIC_CFLAGS += -DNO_INET_PTON
 endif
 
 ifdef NO_ICONV
diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index f444982..e5b46a0 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -17,9 +17,9 @@
 
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+
+#include "../git-compat-util.h"
+
 #include <stdio.h>
 #include <string.h>
 
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 4078fc0..2ec995e 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -17,9 +17,9 @@
 
 #include <errno.h>
 #include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
+
+#include "../git-compat-util.h"
+
 #include <stdio.h>
 #include <string.h>
 
@@ -41,7 +41,9 @@
  */
 
 static int inet_pton4(const char *src, unsigned char *dst);
+#ifndef NO_IPV6
 static int inet_pton6(const char *src, unsigned char *dst);
+#endif
 
 /* int
  * inet_pton4(src, dst)
diff --git a/git-compat-util.h b/git-compat-util.h
index e192831..56dce85 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -387,6 +387,14 @@ static inline void *gitmempcpy(void *dest, const void *src, size_t n)
 }
 #endif
 
+#ifdef NO_INET_PTON
+int inet_pton(int af, const char *src, void *dst);
+#endif
+
+#ifdef NO_INET_NTOP
+const char *inet_ntop(int af, const void *src, char *dst, size_t size);
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 typedef void (*try_to_free_t)(size_t);
-- 
1.7.3.2.162.g09d37
