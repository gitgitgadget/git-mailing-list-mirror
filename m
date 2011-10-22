From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] credential-cache--daemon.c: Don't leave stale socket
 on --exit
Date: Sat, 22 Oct 2011 18:24:51 +0100
Message-ID: <4EA2FC63.9060602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 19:30:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHfOf-0002Kp-83
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 19:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab1JVRaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 13:30:08 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:33142 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754133Ab1JVRaG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2011 13:30:06 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RHfOW-0002kn-c3; Sat, 22 Oct 2011 17:30:05 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184104>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 credential-cache--daemon.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 128c5ce..ee2c15a 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -137,22 +137,22 @@ static int read_credential_request(FILE *fh, struct credential *c,
 	return 0;
 }
 
-static void serve_one_client(FILE *in, FILE *out)
+static int serve_one_client(FILE *in, FILE *out)
 {
 	struct credential c = { NULL };
 	int timeout = -1;
 	char *action = NULL;
 
 	if (read_credential_request(in, &c, &action, &timeout) < 0)
-		return;
+		return 1;
 
 	if (!action) {
 		warning("cache client didn't specify an action");
-		return;
+		return 1;
 	}
 
 	if (!strcmp(action, "exit"))
-		exit(0);
+		return 0;
 
 	if (!strcmp(action, "get")) {
 		struct credential_cache_entry *e = lookup_credential(&c);
@@ -160,27 +160,27 @@ static void serve_one_client(FILE *in, FILE *out)
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
 		}
-		return;
+		return 1;
 	}
 
 	if (!strcmp(action, "erase")) {
 		remove_credential(&c);
-		return;
+		return 1;
 	}
 
 	if (!strcmp(action, "store")) {
 		if (timeout < 0) {
 			warning("cache client didn't specify a timeout");
-			return;
+			return 1;
 		}
 
 		remove_credential(&c);
 		cache_credential(&c, timeout);
-		return;
+		return 1;
 	}
 
 	warning("cache client sent unknown action: %s", action);
-	return;
+	return 1;
 }
 
 static int serve_cache_loop(int fd)
@@ -201,7 +201,7 @@ static int serve_cache_loop(int fd)
 	}
 
 	if (pfd.revents & POLLIN) {
-		int client, client2;
+		int client, client2, ret;
 		FILE *in, *out;
 
 		client = accept(fd, NULL, NULL);
@@ -218,9 +218,10 @@ static int serve_cache_loop(int fd)
 
 		in = xfdopen(client, "r");
 		out = xfdopen(client2, "w");
-		serve_one_client(in, out);
+		ret = serve_one_client(in, out);
 		fclose(in);
 		fclose(out);
+		return ret;
 	}
 	return 1;
 }
-- 
1.7.7
