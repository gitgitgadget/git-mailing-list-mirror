From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 06/11] run-command: add kill_async() and is_async_alive()
Date: Thu, 26 Nov 2009 00:39:13 +0000
Message-ID: <1259195958-2372-7-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-4-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSOn-0007rM-Qn
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935219AbZKZAjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935210AbZKZAjn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:39:43 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935197AbZKZAjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:39:42 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so295613ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3p1ehF6BKCGPPer+la/JKI3Yqi0FDdqwsiJIR7+I4x8=;
        b=o36xdWuj1q01JCfUEQ9b1xVB3RWBGmcvQxDssexlB0gj2/yTz7hyQ+sc2EUG4raVHh
         4di1luyAAvrFT5kHbjlIAn5Tl975mPH/8qPEEJQRBjUArIMydHMgWkkvgajDqZTaf1xx
         Kerdh3XxaKwJSM9HHsmrv62UUexHrGhkKW504=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yAYQ1yyg/Xn4Xrmdyp3MWzMIrdv5FWwWTndef7Y+sWijHkz3qcfOOSPCQ2H8Fic1gs
         S4wVorbHAMoB8XAqQoD13JkUbf/3wklP6HUu6eYW6Bxmt5R1VPcf6WGm2AfbqJ4Etweu
         qfeb+bq+V+A7r+xbP4OWERLSE8rU5R41jReq0=
Received: by 10.213.100.80 with SMTP id x16mr8666779ebn.18.1259195987992;
        Wed, 25 Nov 2009 16:39:47 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 7sm390115eyb.2.2009.11.25.16.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:39:47 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133724>

These functions will aid the Windows port of git-daemon.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 run-command.c |   27 +++++++++++++++++++++++++++
 run-command.h |    2 ++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index cf2d8f7..e5a0e06 100644
--- a/run-command.c
+++ b/run-command.c
@@ -373,6 +373,33 @@ int finish_async(struct async *async)
 	return ret;
 }
 
+int kill_async(struct async *async)
+{
+#ifndef WIN32
+	return kill(async->pid, SIGTERM);
+#else
+	DWORD ret = 0;
+	if (!TerminateThread(async->tid, 0))
+		ret = error("killing thread failed: %lu", GetLastError());
+	else if (!GetExitCodeThread(async->tid, &ret))
+		ret = error("cannot get thread exit code: %lu", GetLastError());
+	return ret;
+#endif
+}
+
+int is_async_alive(struct async *async)
+{
+#ifndef WIN32
+	int dummy;
+	return waitpid(async->pid, &dummy, WNOHANG);
+#else
+	int ret = WaitForSingleObject(async->tid, 0);
+	if (ret == WAIT_FAILED)
+		return error("checking thread state failed: %lu", GetLastError());
+	return ret != WAIT_OBJECT_0;
+#endif
+}
+
 int run_hook(const char *index_file, const char *name, ...)
 {
 	struct child_process hook;
diff --git a/run-command.h b/run-command.h
index fb34209..955b0bd 100644
--- a/run-command.h
+++ b/run-command.h
@@ -80,5 +80,7 @@ struct async {
 
 int start_async(struct async *async);
 int finish_async(struct async *async);
+int kill_async(struct async *async);
+int is_async_alive(struct async *async);
 
 #endif
-- 
1.6.5.rc2.7.g4f8d3
