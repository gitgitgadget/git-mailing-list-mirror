From: David Rientjes <rientjes@google.com>
Subject: [PATCH 16/28] daemon.c cleanup
Date: Mon, 14 Aug 2006 13:32:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141332020.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:33:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj7Y-0000UG-Tr
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWHNUdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWHNUdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:33:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:54677 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932727AbWHNUdI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:33:08 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id k7EKWm1v013681
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:32:48 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=AukG0E2UBJ8nMXDGxYxRDUg+ipRgmk3KHtCA/oZ/8Aw0GSuIPJkI1Bp0vzary+1LN
	ue+LdnsbgPPMzxrCxJTVA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps37.corp.google.com with ESMTP id k7EKWlhZ006066
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:32:47 -0700
Received: by localhost (Postfix, from userid 24081)
	id ECDB187D71; Mon, 14 Aug 2006 13:32:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id EA80687D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:32:43 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25396>

Makes execute and upload void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 daemon.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/daemon.c b/daemon.c
index 810837f..53ef514 100644
--- a/daemon.c
+++ b/daemon.c
@@ -229,7 +229,7 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+static void upload(char *dir)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
@@ -238,7 +238,7 @@ static int upload(char *dir)
 	loginfo("Request for '%s'", dir);
 
 	if (!(path = path_ok(dir)))
-		return -1;
+		return;
 
 	/*
 	 * Security on the cheap.
@@ -254,7 +254,7 @@ static int upload(char *dir)
 	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
 		logerror("'%s': repository not exported.", path);
 		errno = EACCES;
-		return -1;
+		return;
 	}
 
 	/*
@@ -267,10 +267,9 @@ static int upload(char *dir)
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
 	execl_git_cmd("upload-pack", "--strict", timeout_buf, ".", NULL);
-	return -1;
 }
 
-static int execute(struct sockaddr *addr)
+static void execute(struct sockaddr *addr)
 {
 	static char line[1000];
 	int pktlen, len;
@@ -310,11 +309,11 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
-
-	logerror("Protocol error: '%s'", line);
-	return -1;
+	if (!strncmp("git-upload-pack ", line, 16)) {
+		upload(line+16);
+	} else {
+		logerror("Protocol error: '%s'", line);
+	}
 }
 
 
@@ -463,7 +462,8 @@ static void handle(int incoming, struct 
 	dup2(incoming, 1);
 	close(incoming);
 
-	exit(execute(addr));
+	execute(addr);
+	exit(-1);
 }
 
 static void child_handler(int signo)
@@ -820,7 +820,8 @@ int main(int argc, char **argv)
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
 
-		return execute(peer);
+		execute(peer);
+		return -1;
 	}
 
 	if (detach)
-- 
1.4.2.g89bb-dirty
