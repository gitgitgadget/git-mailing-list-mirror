From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 1/3] daemon.c: introduce daemon's service
Date: Thu, 31 Aug 2006 14:35:21 +0200
Message-ID: <1157027723594-git-send-email-vagabon.xyz@gmail.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 31 14:35:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIlla-0003S9-1E
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWHaMf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWHaMf0
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:35:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51562 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751603AbWHaMf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 08:35:26 -0400
Received: by nf-out-0910.google.com with SMTP id x30so387462nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 05:35:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h/AgcnbZB0tmjAkt0wDZA9XMfMCldk2SFTAiTiA1q9TYWvWrabjStM/U4czsV3MF0QQB4vBauB5CtowGqMwU/omWs0vhhrr7hSbOtZLU5azmzsxe+Ynu5i5BCfGrxmV6SzHUkpQwzR/dGhZ0Z0qIubMpCyR7GSCfejaFcsjxPDQ=
Received: by 10.48.220.15 with SMTP id s15mr1273810nfg;
        Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id y24sm1557575nfb.2006.08.31.05.35.23;
        Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 9FAE123F759; Thu, 31 Aug 2006 14:35:23 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26257>

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 daemon.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/daemon.c b/daemon.c
index 66ec830..ed3a13d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -232,16 +232,57 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+/*
+ * Services we're able to deal with.
+ */
+static int service_upload_pack(const char *dir, const char *args)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
+
+	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
+
+	/* git-upload-pack only ever reads stuff, so this is safe */
+	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
+	return -1;
+}
+
+/* service options */
+#define NEED_REPO	(1<<0)
+
+struct service_info {
+	const char *name;
+	int (*fn)(const char *dir, const char *args);
+	int options;
+};
+
+static struct service_info services[] = {
+	{ "git-upload-pack", service_upload_pack, NEED_REPO },
+};
+
+static int run_service(char *cmdline)
+{
+	struct service_info *serv;
 	const char *path;
+	size_t len;
+	int i;
 
-	loginfo("Request for '%s'", dir);
+	for (i = 0; i < ARRAY_SIZE(services); i++) {
+		serv = &services[i];
+		
+		len = strlen(serv->name);
+		if (strncmp(cmdline, serv->name, len))
+			continue;
+		if (cmdline[len] != ' ')
+			continue;
+		goto found;
+	}
+	return -1;
+found:
+	cmdline += len + 1;
+	path = NULL;
 
-	if (!(path = path_ok(dir)))
-		return -1;
+	loginfo("Request '%s' for '%s'", serv->name, cmdline);
 
 	/*
 	 * Security on the cheap.
@@ -253,30 +294,33 @@ static int upload(char *dir)
 	 * path_ok() uses enter_repo() and does whitelist checking.
 	 * We only need to make sure the repository is exported.
 	 */
+	if (serv->options & NEED_REPO) {
+		if (!(path = path_ok(cmdline)))
+			return -1;
 
-	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
-		logerror("'%s': repository not exported.", path);
-		errno = EACCES;
-		return -1;
+		if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
+			logerror("'%s': repository not exported.", path);
+			errno = EACCES;
+			return -1;
+		}
+		cmdline += strlen(path) + 1;
 	}
-
+	
 	/*
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
 	 */
 	signal(SIGTERM, SIG_IGN);
 
-	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
+	return serv->fn(path, cmdline);
 
-	/* git-upload-pack only ever reads stuff, so this is safe */
-	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
-	return -1;
 }
 
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
 	int pktlen, len;
+	int rv;
 
 	if (addr) {
 		char addrbuf[256] = "";
@@ -313,11 +357,11 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
+	rv = run_service(line);
+	if (rv < 0)
+		logerror("Protocol error: '%s'", line);
 
-	logerror("Protocol error: '%s'", line);
-	return -1;
+	return rv;
 }
 
 
-- 
1.4.2
