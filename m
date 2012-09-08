From: Jan Engelhardt <jengelh@inai.de>
Subject: [PATCH] daemon: restore getpeername(0,...) use
Date: Sat,  8 Sep 2012 19:09:33 +0200
Message-ID: <1347124173-14460-2-git-send-email-jengelh@inai.de>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 19:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAOXV-0004Vv-RO
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 19:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2IHRJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 13:09:38 -0400
Received: from seven.inai.de ([5.9.24.206]:40174 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab2IHRJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 13:09:36 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 06BC696A1084; Sat,  8 Sep 2012 19:09:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1347124173-14460-1-git-send-email-jengelh@inai.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205021>

This reverts f9c87be6b42dd0f8b31a4bb8c6a44326879fdd1a, in a sense,
because that commit broke logging of "Connection from ..." when
git-daemon is run under xinetd.

This patch here computes the text representation of the peer and then
copies that to environment variables such that the code in execute()
and subfunctions can stay as-is.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 daemon.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4602b46..eaf08c2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,4 @@
+#include <stdbool.h>
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
@@ -1164,6 +1165,54 @@ static int serve(struct string_list *listen_addr, int listen_port,
 	return service_loop(&socklist);
 }
 
+static void inetd_mode_prepare(void)
+{
+	struct sockaddr_storage ss;
+	struct sockaddr *addr = (void *)&ss;
+	socklen_t slen = sizeof(ss);
+	char addrbuf[256], portbuf[6] = "";
+
+	if (!freopen("/dev/null", "w", stderr))
+		die_errno("failed to redirect stderr to /dev/null");
+
+	/*
+	 * Windows is said to not be able to handle this, so we will simply
+	 * ignore failure here. (It only affects a log message anyway.)
+	 */
+	if (getpeername(0, addr, &slen) < 0)
+		return;
+
+	if (addr->sa_family == AF_INET) {
+		const struct sockaddr_in *sin_addr = (void *)addr;
+
+		if (inet_ntop(addr->sa_family, &sin_addr->sin_addr,
+			      addrbuf, sizeof(addrbuf)) == NULL)
+			return;
+		snprintf(portbuf, sizeof(portbuf), "%hu",
+			 ntohs(sin_addr->sin_port));
+#ifndef NO_IPV6
+	} else if (addr->sa_family == AF_INET6) {
+		const struct sockaddr_in6 *sin6_addr = (void *)addr;
+
+		addrbuf[0] = '[';
+		addrbuf[1] = '\0';
+		if (inet_ntop(AF_INET6, &sin6_addr->sin6_addr, addrbuf + 1,
+			      sizeof(addrbuf) - 2) == NULL)
+			return;
+		strcat(addrbuf, "]");
+
+		snprintf(portbuf, sizeof(portbuf), "%hu",
+			 ntohs(sin6_addr->sin6_port));
+#endif
+	} else {
+		snprintf(addrbuf, sizeof(addrbuf), "<AF %d>",
+			 addr->sa_family);
+	}
+	if (setenv("REMOTE_ADDR", addrbuf, true) < 0)
+		return;
+	setenv("REMOTE_PORT", portbuf, true);
+}
+
 int main(int argc, char **argv)
 {
 	int listen_port = 0;
@@ -1341,10 +1390,8 @@ int main(int argc, char **argv)
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
-	if (inetd_mode) {
-		if (!freopen("/dev/null", "w", stderr))
-			die_errno("failed to redirect stderr to /dev/null");
-	}
+	if (inetd_mode)
+		inetd_mode_prepare();
 
 	if (inetd_mode || serve_mode)
 		return execute();
-- 
1.7.10.4
