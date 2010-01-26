From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 1/2] Support addresses with ':' in git-daemon
Date: Tue, 26 Jan 2010 20:24:41 +0200
Message-ID: <1264530282-4783-2-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 19:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZq6a-0005Wt-Ae
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 19:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab0AZSYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 13:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812Ab0AZSYt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 13:24:49 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:59463 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0AZSYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 13:24:47 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 550C3C7CE9
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:45 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A01BFD52461; Tue, 26 Jan 2010 20:24:45 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 24E672BD53
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 20:24:44 +0200 (EET)
X-Mailer: git-send-email 1.6.6.1.439.gf06b6
In-Reply-To: <1264530282-4783-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138065>

If host address could have ':' in it (e.g. numeric IPv6 address), then
host and port could not be uniquely parsed. Fix this by parsing the
"["<host>"]":<port> and "["<host>"]" notations. Currently the built-in
git:// client would send <host>:<port> or <host> for such thing, but
it doesn't matter as due to bugs, resolving address fails if <host>
contains ':'.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 daemon.c |   34 ++++++++++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 360635e..6c2bd97 100644
--- a/daemon.c
+++ b/daemon.c
@@ -399,6 +399,33 @@ static char *xstrdup_tolower(const char *str)
 	return dup;
 }
 
+static void parse_host_and_port(char *hostport, char **host,
+	char **port)
+{
+	if (*hostport == '[') {
+		char *end;
+
+		end = strchr(hostport, ']');
+		if (!end)
+			die("Invalid reqeuest ('[' without ']')");
+		*end = '\0';
+		*host = hostport + 1;
+		if (!end[1])
+			*port = NULL;
+		else if (end[1] == ':')
+			*port = end + 2;
+		else
+			die("Garbage after end of host part");
+	} else {
+		*host = hostport;
+		*port = strrchr(hostport, ':');
+		if (*port) {
+			*port = '\0';
+			++*port;
+		}
+	}
+}
+
 /*
  * Read the host as supplied by the client connection.
  */
@@ -415,11 +442,10 @@ static void parse_host_arg(char *extra_args, int buflen)
 			vallen = strlen(val) + 1;
 			if (*val) {
 				/* Split <host>:<port> at colon. */
-				char *host = val;
-				char *port = strrchr(host, ':');
+				char *host;
+				char *port;
+				parse_host_and_port(val, &host, &port);
 				if (port) {
-					*port = 0;
-					port++;
 					free(tcp_port);
 					tcp_port = xstrdup(port);
 				}
-- 
1.6.6.1.439.gf06b6
