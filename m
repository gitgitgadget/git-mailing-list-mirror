From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCHv4 2/2] daemon: allow more than one host address given via --listen
Date: Mon, 30 Aug 2010 13:30:51 +0200
Message-ID: <1283167851-18331-3-git-send-email-alexander@sulfrian.net>
References: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
Cc: Alexander Sulfrian <alexander@sulfrian.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 13:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq2a7-0001XO-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 13:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0H3LbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 07:31:12 -0400
Received: from animux.de ([78.46.93.45]:55770 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215Ab0H3LbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 07:31:00 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id DEEC380CC3AA; Mon, 30 Aug 2010 13:31:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [87.77.143.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id D2B7380CC38F;
	Mon, 30 Aug 2010 11:31:11 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Mon, 30 Aug 2010 13:30:56 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154788>

When the host has more than one interfaces, daemon can listen to all
of them by not giving any --listen option, or listen to only one.
Teach it to accept more than one --listen options.

Remove the hostname information form the die, if no socket could be
created. It would only trigger when no interface out of either all
interface or the ones specified on the command line with --listen
options, can be listened to and so the user does know which "host" was
asked.

Signed-off-by: Alexander Sulfrian <alexander@sulfrian.net>
---
 Documentation/git-daemon.txt |    1 +
 daemon.c                     |   31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 01c9f8e..4afd0a4 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -85,6 +85,7 @@ OPTIONS
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
 	is not supported, then --listen=hostname is also not supported and
 	--listen must be given an IPv4 address.
+	Can be given more than one time.
 	Incompatible with '--inetd' option.
 
 --port=n::
diff --git a/daemon.c b/daemon.c
index c666ced..d6e20c6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 #include <syslog.h>
 
@@ -866,9 +867,21 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 #endif
 
-static void socksetup(char *listen_addr, int listen_port, struct socketlist *socklist)
+static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
 {
-	setup_named_sock(listen_addr, listen_port, socklist);
+	if (!listen_addr->nr)
+		setup_named_sock(NULL, listen_port, socklist);
+	else {
+		int i, socknum;
+		for (i = 0; i < listen_addr->nr; i++) {
+			socknum = setup_named_sock(listen_addr->items[i].string,
+						   listen_port, socklist);
+
+			if (socknum == 0)
+				logerror("unable to allocate any listen sockets for host %s on port %u",
+					 listen_addr->items[i].string, listen_port);
+		}
+	}
 }
 
 static int service_loop(struct socketlist *socklist)
@@ -959,14 +972,14 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }
 
-static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
+static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
 	socksetup(listen_addr, listen_port, &socklist);
 	if (socklist.nr == 0)
-		die("unable to allocate any listen sockets on host %s port %u",
-		    listen_addr, listen_port);
+		die("unable to allocate any listen sockets on port %u",
+		    listen_port);
 
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
@@ -979,7 +992,7 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 int main(int argc, char **argv)
 {
 	int listen_port = 0;
-	char *listen_addr = NULL;
+	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
 	int inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
@@ -994,7 +1007,7 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (!prefixcmp(arg, "--listen=")) {
-			listen_addr = xstrdup_tolower(arg + 9);
+			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
 			continue;
 		}
 		if (!prefixcmp(arg, "--port=")) {
@@ -1119,7 +1132,7 @@ int main(int argc, char **argv)
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
 
-	if (inetd_mode && (listen_port || listen_addr))
+	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
@@ -1174,5 +1187,5 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
-	return serve(listen_addr, listen_port, pass, gid);
+	return serve(&listen_addr, listen_port, pass, gid);
 }
-- 
1.7.1
