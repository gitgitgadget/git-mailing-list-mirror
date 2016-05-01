From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/6] connect: remove get_port()
Date: Sun,  1 May 2016 15:02:48 +0900
Message-ID: <1462082573-17992-2-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTE-0007ub-0E
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbcEAGDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:01 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33618 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbcEAGC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:02:59 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkSz-0004h0-SS; Sun, 01 May 2016 15:02:53 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293137>

get_port() is only used as a fallback when get_host_and_port() does not
return a port. But get_port() does the same search as
get_host_and_port(), except get_host_and_port() starts from the end of
the host, respecting square brackets for ipv6 addresses, and get_port(),
operating after get_host_and_port(), works on a modified host string
that has square brackes removed if there were any.

I cannot think of any legal host:port string that would not have a port
returned by get_host_and_port() *and* have one returned by get_port().
So just remove get_port().

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/connect.c b/connect.c
index c53f3f1..45308ef 100644
--- a/connect.c
+++ b/connect.c
@@ -571,22 +571,6 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	return proxy;
 }
 
-static char *get_port(char *host)
-{
-	char *end;
-	char *p = strchr(host, ':');
-
-	if (p) {
-		long port = strtol(p + 1, &end, 10);
-		if (end != p + 1 && *end == '\0' && 0 <= port && port < 65536) {
-			*p = '\0';
-			return p+1;
-		}
-	}
-
-	return NULL;
-}
-
 /*
  * Extract protocol and relevant parts from the specified connection URL.
  * The caller must free() the returned strings.
@@ -742,9 +726,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
-			if (!port)
-				port = get_port(ssh_host);
-
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
-- 
2.8.1.16.g58dac65.dirty
