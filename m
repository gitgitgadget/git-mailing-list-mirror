From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH] daemon: consider only address in kill_some_child()
Date: Sat,  9 Jan 2010 15:13:28 +0100
Message-ID: <1263046408-2368-1-git-send-email-kusmabite@gmail.com>
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 15:14:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTc4t-0004WC-73
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 15:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0AIOOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 09:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143Ab0AIOOA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 09:14:00 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:54943 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0AION7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 09:13:59 -0500
Received: by ewy6 with SMTP id 6so19944596ewy.29
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/D7u4t03YDobXgjoHg+pIFZjBKYuUO8hnYzPfcNDwC0=;
        b=SJGW5hX7f3xBlMPRceUqWpDU9Xc3UzbMWRlajUj6sdZm3SJjrya/JUPeuaho/zIwd6
         Yscg+Ts2RZE6NrFFxGSHCb2b/J3Zn57IAHrdXyu0eQOGbpvk/JNXvprOSpkH4Q+emOG1
         3BV/eJSDMTgEhbhkbiU2gaY972e9tCxOlzjAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uMsh5EFcxR90W1iPOF34KUpPNym+ZBM9NPnUjTrYecX091ygw42gfoRRcFybTW4zyq
         /HJYrO8JNtcTTJIcY+tjLQTlgd8nh8V5zxBR3Y1v5X0Jvn/O+hUuwXNPu4l944HHuI6s
         nZKSnfPJLrkODdQKROuNKjRXsYHQG+ukNheho=
Received: by 10.213.110.11 with SMTP id l11mr729591ebp.84.1263046438286;
        Sat, 09 Jan 2010 06:13:58 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 14sm1125971ewy.7.2010.01.09.06.13.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 06:13:57 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136533>

kill_some_child() compares the entire sockaddr_storage
structure (with the pad-bits zeroed out) when trying to
find out if connections originate from the same host.
However, sockaddr_storage contains the port-number for
the connection (which varies between connections), so
the comparison always fails.

Change the code so we only consider the host-address,
by introducing the addrcmp()-function that inspects
the address family and compare as appropriate.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/daemon.c b/daemon.c
index 5783e24..918e560 100644
--- a/daemon.c
+++ b/daemon.c
@@ -562,6 +562,24 @@ static int execute(struct sockaddr *addr)
 	return -1;
 }
 
+static int addrcmp(const struct sockaddr_storage *s1,
+    const struct sockaddr_storage *s2)
+{
+	if (s1->ss_family != s2->ss_family)
+		return s1->ss_family - s2->ss_family;
+	if (s1->ss_family == AF_INET)
+		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
+		    &((struct sockaddr_in *)s2)->sin_addr,
+		    sizeof(struct in_addr));
+#ifndef NO_IPV6
+	if (s1->ss_family == AF_INET6)
+		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
+		    &((struct sockaddr_in6 *)s2)->sin6_addr,
+		    sizeof(struct in6_addr));
+#endif
+	return 0;
+}
+
 static int max_connections = 32;
 
 static unsigned int live_children;
@@ -576,17 +594,12 @@ static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
 {
 	struct child *newborn, **cradle;
 
-	/*
-	 * This must be xcalloc() -- we'll compare the whole sockaddr_storage
-	 * but individual address may be shorter.
-	 */
 	newborn = xcalloc(1, sizeof(*newborn));
 	live_children++;
 	newborn->pid = pid;
 	memcpy(&newborn->address, addr, addrlen);
 	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-		if (!memcmp(&(*cradle)->address, &newborn->address,
-			    sizeof(newborn->address)))
+		if (!addrcmp(&(*cradle)->address, &newborn->address))
 			break;
 	newborn->next = *cradle;
 	*cradle = newborn;
@@ -619,8 +632,7 @@ static void kill_some_child(void)
 		return;
 
 	for (; (next = blanket->next); blanket = next)
-		if (!memcmp(&blanket->address, &next->address,
-			    sizeof(next->address))) {
+		if (!addrcmp(&blanket->address, &next->address)) {
 			kill(blanket->pid, SIGTERM);
 			break;
 		}
-- 
1.6.6.95.gae285
