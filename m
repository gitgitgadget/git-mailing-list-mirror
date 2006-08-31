From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 1/3] daemon.c: introduce daemon's service [take #2]
Date: Thu, 31 Aug 2006 17:15:59 +0200
Message-ID: <44F6FD2F.5080707@innova-card.com>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com> <1157027723594-git-send-email-vagabon.xyz@gmail.com> <44F6DEF4.6000609@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 17:16:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIoH1-0000v0-FT
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 17:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHaPQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 11:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWHaPQE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 11:16:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:51527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932348AbWHaPQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 11:16:01 -0400
Received: by nf-out-0910.google.com with SMTP id x30so430579nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 08:16:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=VXM9R8u7AiwUr6EurbInasY5bT6vKdnyJWg6Q8n/Ks8+WGPOfByaNh1qS/0UWWRmIowcvSqf4py5a9lQ5IfVj2pVe2M+RdmtgR5rQBkYpLGnpcV+X5s8MxCcOkV4/CtkC8IOeNMOz/B1sv2O74YJdhXg1mPNT1eLweM0LgyejUM=
Received: by 10.49.41.12 with SMTP id t12mr1475116nfj;
        Thu, 31 Aug 2006 08:15:59 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id i1sm1779234nfe.2006.08.31.08.15.59;
        Thu, 31 Aug 2006 08:15:59 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <44F6DEF4.6000609@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26264>


Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 daemon.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/daemon.c b/daemon.c
index 66ec830..f5f6927 100644
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
 
-	if (!(path = path_ok(dir)))
-		return -1;
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
+
+	loginfo("Request '%s' for '%s'", serv->name, cmdline);
 
 	/*
 	 * Security on the cheap.
@@ -253,11 +294,16 @@ static int upload(char *dir)
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
 
 	/*
@@ -266,17 +312,14 @@ static int upload(char *dir)
 	 */
 	signal(SIGTERM, SIG_IGN);
 
-	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
-
-	/* git-upload-pack only ever reads stuff, so this is safe */
-	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
-	return -1;
+	return serv->fn(path, cmdline);
 }
 
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
 	int pktlen, len;
+	int rv;
 
 	if (addr) {
 		char addrbuf[256] = "";
@@ -313,11 +356,11 @@ #endif
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
