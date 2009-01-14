From: Jan Engelhardt <jengelh@medozas.de>
Subject: [PATCH 1/3] git-daemon: single-line logs
Date: Wed, 14 Jan 2009 11:48:10 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 11:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN3Jb-0001qy-C2
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbZANKsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 05:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZANKsO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:48:14 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:59905 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbZANKsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:48:13 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id EA9E71812F9E3; Wed, 14 Jan 2009 11:48:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id E96301CBDECE0
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 11:48:10 +0100 (CET)
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105613>



parent v1.6.1

git-daemon: single-line logs

Having just a single line per connection attempt, much like Apache
httpd2 access logs, makes log parsing much easier, especially when
just glancing over it non-automated.

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>

---
 daemon.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: git-1.6.1/daemon.c
===================================================================
--- git-1.6.1.orig/daemon.c
+++ git-1.6.1/daemon.c
@@ -295,12 +295,13 @@ static int git_daemon_config(const char
 	return 0;
 }
 
-static int run_service(char *dir, struct daemon_service *service)
+static int run_service(char *dir, struct daemon_service *service,
+    const char *origin, const char *vhost)
 {
 	const char *path;
 	int enabled = service->enabled;
 
-	loginfo("Request %s for '%s'", service->name, dir);
+	loginfo("%s->%s %s \"%s\"\n", origin, vhost, service->name, dir);
 
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
@@ -507,10 +508,10 @@ static void parse_extra_args(char *extra
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
+	char addrbuf[256] = "";
 	int pktlen, len, i;
 
 	if (addr) {
-		char addrbuf[256] = "";
 		int port = -1;
 
 		if (addr->sa_family == AF_INET) {
@@ -529,7 +530,6 @@ static int execute(struct sockaddr *addr
 			port = ntohs(sin6_addr->sin6_port);
 #endif
 		}
-		loginfo("Connection from %s:%d", addrbuf, port);
 		setenv("REMOTE_ADDR", addrbuf, 1);
 	}
 	else {
@@ -541,10 +541,6 @@ static int execute(struct sockaddr *addr
 	alarm(0);
 
 	len = strlen(line);
-	if (pktlen != len)
-		loginfo("Extended attributes (%d bytes) exist <%.*s>",
-			(int) pktlen - len,
-			(int) pktlen - len, line + len + 1);
 	if (len && line[len-1] == '\n') {
 		line[--len] = 0;
 		pktlen--;
@@ -569,7 +565,8 @@ static int execute(struct sockaddr *addr
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			return run_service(line + namelen + 5, s,
+			       addrbuf, hostname);
 		}
 	}
 
