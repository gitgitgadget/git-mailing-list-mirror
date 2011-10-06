From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] mingw: avoid using strbuf in syslog
Date: Thu,  6 Oct 2011 19:52:48 +0200
Message-ID: <1317923568-9040-1-git-send-email-kusmabite@gmail.com>
Cc: drafnel@gmail.com, j.sixt@viscovery.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 19:53:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBs81-0006f2-CA
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243Ab1JFRw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:52:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62565 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965181Ab1JFRw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:52:58 -0400
Received: by bkbzt4 with SMTP id zt4so3762995bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9sGvrea4Udo2pYhbRHJnBsq0Za8cIviHMVP4dVYPK18=;
        b=flHsKUmMpFF8ncl0z3bJ2oZFbqu9/F0f2UiG4NHgDZmBFF99jP5XHQDjjm7U37l4tl
         5+Lo5hXsPrWsMnSZqzXUueyjI1uxZIXjusHIS2Wv0PrA0zdlsA4SjW/CiUnhraQ2bT9x
         ApdGevqLXQ84VsEbBPnKtf/bI8ji5L9u0BYYo=
Received: by 10.204.133.78 with SMTP id e14mr785803bkt.248.1317923577650;
        Thu, 06 Oct 2011 10:52:57 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id v16sm6400560bkd.6.2011.10.06.10.52.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 10:52:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.579.ga3d6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183001>

strbuf can call die, which again can call syslog from git-daemon.

Endless recursion is no fun; fix it by hand-rolling the logic. As
a side-effect malloc/realloc errors are changed into non-fatal
warnings; this is probably an improvement anyway.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Noticed-by: Johannes Sixt <j.sixt@viscovery.net>
---
 compat/win32/syslog.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 42b95a9..d015e43 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -1,5 +1,4 @@
 #include "../../git-compat-util.h"
-#include "../../strbuf.h"
 
 static HANDLE ms_eventlog;
 
@@ -16,13 +15,8 @@ void openlog(const char *ident, int logopt, int facility)
 
 void syslog(int priority, const char *fmt, ...)
 {
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[] = {
-		{"1", "% 1"},
-		{NULL, NULL}
-	};
 	WORD logtype;
-	char *str;
+	char *str, *pos;
 	int str_len;
 	va_list ap;
 
@@ -39,11 +33,24 @@ void syslog(int priority, const char *fmt, ...)
 	}
 
 	str = malloc(str_len + 1);
+	if (!str) {
+		warning("malloc failed: '%s'", strerror(errno));
+		return;
+	}
+
 	va_start(ap, fmt);
 	vsnprintf(str, str_len + 1, fmt, ap);
 	va_end(ap);
-	strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);
-	free(str);
+
+	while ((pos = strstr(str, "%1")) != NULL) {
+		str = realloc(str, ++str_len + 1);
+		if (!str) {
+			warning("realloc failed: '%s'", strerror(errno));
+			return;
+		}
+		memmove(pos + 2, pos + 1, strlen(pos));
+		pos[1] = ' ';
+	}
 
 	switch (priority) {
 	case LOG_EMERG:
@@ -66,7 +73,6 @@ void syslog(int priority, const char *fmt, ...)
 	}
 
 	ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
-	    (const char **)&sb.buf, NULL);
-
-	strbuf_release(&sb);
+	    (const char **)&str, NULL);
+	free(str);
 }
-- 
1.7.6.msysgit.0.579.ga3d6f
