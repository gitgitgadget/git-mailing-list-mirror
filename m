From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCHv3 2/2] daemon: allow more than one host address given via --listen
Date: Sun, 29 Aug 2010 17:13:16 +0200
Message-ID: <1283094796-27984-3-git-send-email-alexander@sulfrian.net>
References: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
Cc: Alexander Sulfrian <alexander@sulfrian.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 17:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpjZp-0002Ct-Ef
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab0H2PNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:13:33 -0400
Received: from animux.de ([78.46.93.45]:41393 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606Ab0H2PNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:13:32 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 0F67380DFFAD; Sun, 29 Aug 2010 17:13:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [93.214.39.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 3677380D7590;
	Sun, 29 Aug 2010 15:13:42 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Sun, 29 Aug 2010 17:13:28 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154692>

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
 daemon.c                     |   33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

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
index deda4cf..bd7574e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 #include <syslog.h>
 
@@ -861,11 +862,20 @@ static int setup_named_sock(char *listen_addr, int listen_port, int **socklist_p
 
 #endif
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int socksetup(struct string_list *listen_addr, int listen_port, int **socklist_p)
 {
 	int socknum = 0, *socklist = NULL;
 
-	socknum = setup_named_sock(listen_addr, listen_port, &socklist, socknum);
+	if (!listen_addr->nr)
+		socknum = setup_named_sock(NULL, listen_port, &socklist,
+					   socknum);
+	else {
+		int i;
+		for (i = 0; i < listen_addr->nr; i++)
+			socknum = setup_named_sock(listen_addr->items[i].string,
+						   listen_port, &socklist,
+						   socknum);
+	}
 
 	*socklist_p = socklist;
 	return socknum;
@@ -959,14 +969,14 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }
 
-static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
+static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
 {
 	int socknum, *socklist;
 
 	socknum = socksetup(listen_addr, listen_port, &socklist);
 	if (socknum == 0)
-		die("unable to allocate any listen sockets on host %s port %u",
-		    listen_addr, listen_port);
+		die("unable to allocate any listen sockets on port %u",
+		    listen_port);
 
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
@@ -979,7 +989,7 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 int main(int argc, char **argv)
 {
 	int listen_port = 0;
-	char *listen_addr = NULL;
+	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
 	int inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
@@ -987,6 +997,7 @@ int main(int argc, char **argv)
 	struct group *group;
 	gid_t gid = 0;
 	int i;
+	int return_value;
 
 	git_extract_argv0_path(argv[0]);
 
@@ -994,7 +1005,7 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (!prefixcmp(arg, "--listen=")) {
-			listen_addr = xstrdup_tolower(arg + 9);
+			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
 			continue;
 		}
 		if (!prefixcmp(arg, "--port=")) {
@@ -1119,7 +1130,7 @@ int main(int argc, char **argv)
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
 
-	if (inetd_mode && (listen_port || listen_addr))
+	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
@@ -1174,5 +1185,9 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
-	return serve(listen_addr, listen_port, pass, gid);
+	return_value = serve(&listen_addr, listen_port, pass, gid);
+
+	string_list_clear(&listen_addr, 0);
+
+	return return_value;
 }
-- 
1.7.1
