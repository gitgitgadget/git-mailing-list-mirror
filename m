From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] daemon: cleanup: factor out xstrdup_tolower()
Date: Fri, 26 Dec 2008 11:12:15 +0100
Message-ID: <1230286335.6728.51.camel@ubuntu.ubuntu-domain>
References: <1230284785.6728.26.camel@ubuntu.ubuntu-domain>
	 <1230285717.6728.40.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 11:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG9hQ-0004RK-Ct
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 11:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbYLZKMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 05:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbYLZKMX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 05:12:23 -0500
Received: from india601.server4you.de ([85.25.151.105]:45789 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYLZKMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 05:12:22 -0500
Received: from [10.0.1.101] (p57B7E108.dip.t-dialin.net [87.183.225.8])
	by india601.server4you.de (Postfix) with ESMTPSA id AE6182F8003;
	Fri, 26 Dec 2008 11:12:15 +0100 (CET)
In-Reply-To: <1230285717.6728.40.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103929>

Add xstrdup_tolower(), a helper to get a lower case copy of a
string, and use it in two cases.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 daemon.c |   34 +++++++++++++---------------------
 1 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4468fb9..60bf6c7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -397,6 +397,14 @@ static void make_service_overridable(const char *name, int ena)
 	die("No such service %s", name);
 }
 
+static char *xstrdup_tolower(const char *str)
+{
+	char *p, *dup = xstrdup(str);
+	for (p = dup; *p; p++)
+		*p = tolower(*p);
+	return dup;
+}
+
 /*
  * Separate the "extra args" information as supplied by the client connection.
  */
@@ -405,7 +413,6 @@ static void parse_extra_args(char *extra_args, int buflen)
 	char *val;
 	int vallen;
 	char *end = extra_args + buflen;
-	char *hp;
 
 	while (extra_args < end && *extra_args) {
 		saw_extended_args = 1;
@@ -423,7 +430,7 @@ static void parse_extra_args(char *extra_args, int buflen)
 					tcp_port = xstrdup(port);
 				}
 				free(hostname);
-				hostname = xstrdup(host);
+				hostname = xstrdup_tolower(host);
 			}
 
 			/* On to the next one */
@@ -432,19 +439,10 @@ static void parse_extra_args(char *extra_args, int buflen)
 	}
 
 	/*
-	 * Replace literal host with lowercase-ized hostname.
-	 */
-	hp = hostname;
-	if (!hp)
-		return;
-	for ( ; *hp; hp++)
-		*hp = tolower(*hp);
-
-	/*
 	 * Locate canonical hostname and its IP address.
 	 */
+	if (hostname) {
 #ifndef NO_IPV6
-	{
 		struct addrinfo hints;
 		struct addrinfo *ai, *ai0;
 		int gai;
@@ -468,9 +466,7 @@ static void parse_extra_args(char *extra_args, int buflen)
 			}
 			freeaddrinfo(ai0);
 		}
-	}
 #else
-	{
 		struct hostent *hent;
 		struct sockaddr_in sa;
 		char **ap;
@@ -491,8 +487,8 @@ static void parse_extra_args(char *extra_args, int buflen)
 		canon_hostname = xstrdup(hent->h_name);
 		free(ip_address);
 		ip_address = xstrdup(addrbuf);
-	}
 #endif
+	}
 }
 
 
@@ -945,12 +941,8 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (!prefixcmp(arg, "--listen=")) {
-		    char *p = arg + 9;
-		    char *ph = listen_addr = xmalloc(strlen(arg + 9) + 1);
-		    while (*p)
-			*ph++ = tolower(*p++);
-		    *ph = 0;
-		    continue;
+			listen_addr = xstrdup_tolower(arg + 9);
+			continue;
 		}
 		if (!prefixcmp(arg, "--port=")) {
 			char *end;
-- 
1.6.1
