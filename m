From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 06/11] run-command: add kill_async() and is_async_alive()
Date: Thu, 26 Nov 2009 00:44:15 +0000
Message-ID: <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTd-0001AV-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbZKZAok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbZKZAoj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:39 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46652 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965070AbZKZAoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:38 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so298499ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3p1ehF6BKCGPPer+la/JKI3Yqi0FDdqwsiJIR7+I4x8=;
        b=L2mUy2sz0JgWPQbKZSJ6y+I2HV6Gla8J3qBqcQUuBRHpkuAdFYtvaBKjntVs5UJUxW
         daqZCJul4H2trCVQgvxPlWMnY/VEEDHwe1rsxgf59f6fNAPcLntZ1CUO/FWzpC9MqFR8
         OhXX5YC1W7cjl10ot0iw3FeAP+XG+RaUJFLDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bm/t1L4FB/nV1viDrvnS5m7dm3JEkvJc/xsNVzw0Jju4PG1QNTlC9l7KeA4Kx7xrtc
         8+r5XG3vdPCpOg3Xk9NOhBcCEkRlKW7RWRiCLYau2NzglYFHU/Ct6EwrCuHvQRQjedCK
         E/TEjLM68ywzlw/SF4jeRpRlDusq1I39YlanI=
Received: by 10.213.8.26 with SMTP id f26mr1815097ebf.47.1259196284483;
        Wed, 25 Nov 2009 16:44:44 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 10sm389849eyz.15.2009.11.25.16.44.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:43 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133737>

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
