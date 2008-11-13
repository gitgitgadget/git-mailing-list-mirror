From: Jan Engelhardt <jengelh@medozas.de>
Subject: git-daemon: single-line logging
Date: Thu, 13 Nov 2008 17:51:04 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811131749420.16134@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jengelh@medozas.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 17:52:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0fQg-0001pF-3E
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 17:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYKMQvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 11:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYKMQvI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 11:51:08 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:41323 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKMQvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 11:51:06 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 9B6971839E1E0; Thu, 13 Nov 2008 17:51:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 93C391D3C061F;
	Thu, 13 Nov 2008 17:51:04 +0100 (CET)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100885>

Hi,


I wrote this patch for my git-daemon to make it much easier to parse 
/var/log/git-daemon.log -- namely reducing the output from three lines 
per connected client to just one.

commit 4dc99ff38c7e09aabf253bd9f65e8b4958654f7e
against v1.6.0.4
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Sun Aug 24 12:12:29 2008 -0400

    git-daemon: single-line logs
    
    Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 daemon.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/daemon.c b/daemon.c
index 8dcde73..8ecfe7b 100644
--- a/daemon.c
+++ b/daemon.c
@@ -319,14 +319,15 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int run_service(struct interp *itable, struct daemon_service *service)
+static int run_service(struct interp *itable, struct daemon_service *service,
+    const char *origin)
 {
 	const char *path;
 	int enabled = service->enabled;
 
-	loginfo("Request %s for '%s'",
-		service->name,
-		itable[INTERP_SLOT_DIR].value);
+	loginfo("%s->%s %s \"%s\"\n",
+		origin, itable[INTERP_SLOT_HOST].value,
+		service->name, itable[INTERP_SLOT_DIR].value);
 
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
@@ -534,10 +535,10 @@ static void fill_in_extra_table_entries(struct interp *itable)
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
+	char addrbuf[256] = "";
 	int pktlen, len, i;
 
 	if (addr) {
-		char addrbuf[256] = "";
 		int port = -1;
 
 		if (addr->sa_family == AF_INET) {
@@ -556,7 +557,6 @@ static int execute(struct sockaddr *addr)
 			port = ntohs(sin6_addr->sin6_port);
 #endif
 		}
-		loginfo("Connection from %s:%d", addrbuf, port);
 	}
 
 	alarm(init_timeout ? init_timeout : timeout);
@@ -564,10 +564,6 @@ static int execute(struct sockaddr *addr)
 	alarm(0);
 
 	len = strlen(line);
-	if (pktlen != len)
-		loginfo("Extended attributes (%d bytes) exist <%.*s>",
-			(int) pktlen - len,
-			(int) pktlen - len, line + len + 1);
 	if (len && line[len-1] == '\n') {
 		line[--len] = 0;
 		pktlen--;
@@ -596,7 +592,7 @@ static int execute(struct sockaddr *addr)
 			 */
 			interp_set_entry(interp_table,
 					 INTERP_SLOT_DIR, line + namelen + 5);
-			return run_service(interp_table, s);
+			return run_service(interp_table, s, addrbuf);
 		}
 	}
 
