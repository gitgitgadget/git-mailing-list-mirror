From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] mingw: avoid using strbuf in syslog
Date: Thu,  6 Oct 2011 18:57:24 +0200
Message-ID: <1317920244-6320-1-git-send-email-kusmabite@gmail.com>
Cc: drafnel@gmail.com, j.sixt@viscovery.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 18:57:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrGO-0002K8-U5
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130Ab1JFQ5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:57:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51956 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965123Ab1JFQ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:57:36 -0400
Received: by bkbzt4 with SMTP id zt4so3698141bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gBuhhezS0nz0Fv31XkTjbwXFAVtdJ4x5Nn2NDRu9bY8=;
        b=kEDtux3gsk593gKuPalyrLQNW22JEYyR3cCFxuyU7C/hwrBmRnB1b7fb9e7/e0Frm+
         JKVvrsK22vGuu8lZbR+/jfpj6Oez7BiieFm4XLkrXuR4FzkViGNFz5SKYb2vd7jSPAQ4
         7IsReuOjm9ebHn5w7tfxbz4Z6Ci4UVC9C0El4=
Received: by 10.204.150.202 with SMTP id z10mr695950bkv.279.1317920254225;
        Thu, 06 Oct 2011 09:57:34 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id e14sm6275547bka.0.2011.10.06.09.57.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 09:57:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.579.ga3d6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182982>

strbuf can call die, which again can call syslog from git-daemon.

Endless recursion is no fun; fix it by hand-rolling the logic.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
Fixes the problem Brandon pointed out...

 compat/win32/syslog.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 42b95a9..3b8e2b7 100644
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
 
@@ -39,11 +33,20 @@ void syslog(int priority, const char *fmt, ...)
 	}
 
 	str = malloc(str_len + 1);
+	if (!str)
+		return; /* no chance to report error */
+
 	va_start(ap, fmt);
 	vsnprintf(str, str_len + 1, fmt, ap);
 	va_end(ap);
-	strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);
-	free(str);
+
+	while ((pos = strstr(str, "%1")) != NULL) {
+		str = realloc(str, ++str_len + 1);
+		if (!str)
+			return;
+		memmove(pos + 2, pos + 1, strlen(pos));
+		pos[1] = ' ';
+	}
 
 	switch (priority) {
 	case LOG_EMERG:
@@ -66,7 +69,6 @@ void syslog(int priority, const char *fmt, ...)
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
