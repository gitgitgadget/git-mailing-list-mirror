From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCH/RFC] added possibility to supply more than one --listen argument to git-daemon
Date: Tue, 10 Aug 2010 20:56:02 +0200
Message-ID: <1281466562-28105-2-git-send-email-alexander@sulfrian.net>
References: <1281466562-28105-1-git-send-email-alexander@sulfrian.net>
Cc: Alexander Sulfrian <alexander@sulfrian.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:04:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiu7E-0005iZ-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980Ab0HJTD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 15:03:56 -0400
Received: from animux.de ([78.46.93.45]:44085 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932974Ab0HJTDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:03:53 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 6FA608188EE7; Tue, 10 Aug 2010 20:56:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr2 (2007-05-02) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,AWL,BAYES_20,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.1-gr2
Received: from laptop (unknown [93.214.54.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 554808188EE6;
	Tue, 10 Aug 2010 18:56:26 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Tue, 10 Aug 2010 20:56:25 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281466562-28105-1-git-send-email-alexander@sulfrian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153139>

--listen arguments are gathered in a string_list
serve and socksetup get listen_addr as string_list
socketsetup creates a listen socket for each host in that string_list

Signed-off-by: Alexander Sulfrian <alexander@sulfrian.net>
---
 daemon.c |  183 ++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 107 insertions(+), 76 deletions(-)

diff --git a/daemon.c b/daemon.c
index e22a2b7..f4492fe 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 #include <syslog.h>
 
@@ -736,7 +737,7 @@ static int set_reuse_addr(int sockfd)
 
 #ifndef NO_IPV6
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int socksetup(struct string_list *listen_addr, int listen_port, int **socklist_p)
 {
 	int socknum = 0, *socklist = NULL;
 	int maxfd = -1;
@@ -744,6 +745,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 	long flags;
+	int i;
 
 	sprintf(pbuf, "%d", listen_port);
 	memset(&hints, 0, sizeof(hints));
@@ -752,57 +754,69 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	hints.ai_protocol = IPPROTO_TCP;
 	hints.ai_flags = AI_PASSIVE;
 
-	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
-	if (gai)
-		die("getaddrinfo() failed: %s", gai_strerror(gai));
+	i = 0;
+	do {
+		if (listen_addr->nr > 0) {
+			gai = getaddrinfo(listen_addr->items[i].string, pbuf,
+					  &hints, &ai0);
+		}
+		else {
+			gai = getaddrinfo(NULL, pbuf, &hints, &ai0);
+		}
 
-	for (ai = ai0; ai; ai = ai->ai_next) {
-		int sockfd;
+		if (gai)
+			die("getaddrinfo() failed: %s", gai_strerror(gai));
 
-		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
-		if (sockfd < 0)
-			continue;
-		if (sockfd >= FD_SETSIZE) {
-			logerror("Socket descriptor too large");
-			close(sockfd);
-			continue;
-		}
+		for (ai = ai0; ai; ai = ai->ai_next) {
+			int sockfd;
+
+			sockfd = socket(ai->ai_family, ai->ai_socktype,
+					ai->ai_protocol);
+			if (sockfd < 0)
+				continue;
+			if (sockfd >= FD_SETSIZE) {
+				logerror("Socket descriptor too large");
+				close(sockfd);
+				continue;
+			}
 
 #ifdef IPV6_V6ONLY
-		if (ai->ai_family == AF_INET6) {
-			int on = 1;
-			setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
-				   &on, sizeof(on));
-			/* Note: error is not fatal */
-		}
+			if (ai->ai_family == AF_INET6) {
+				int on = 1;
+				setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
+					   &on, sizeof(on));
+				/* Note: error is not fatal */
+			}
 #endif
 
-		if (set_reuse_addr(sockfd)) {
-			close(sockfd);
-			continue;
-		}
+			if (set_reuse_addr(sockfd)) {
+				close(sockfd);
+				continue;
+			}
 
-		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
-			close(sockfd);
-			continue;	/* not fatal */
-		}
-		if (listen(sockfd, 5) < 0) {
-			close(sockfd);
-			continue;	/* not fatal */
-		}
+			if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+				close(sockfd);
+				continue;	/* not fatal */
+			}
+			if (listen(sockfd, 5) < 0) {
+				close(sockfd);
+				continue;	/* not fatal */
+			}
 
-		flags = fcntl(sockfd, F_GETFD, 0);
-		if (flags >= 0)
-			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+			flags = fcntl(sockfd, F_GETFD, 0);
+			if (flags >= 0)
+				fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
 
-		socklist = xrealloc(socklist, sizeof(int) * (socknum + 1));
-		socklist[socknum++] = sockfd;
+			socklist = xrealloc(socklist,
+					    sizeof(int) * (socknum + 1));
+			socklist[socknum++] = sockfd;
 
-		if (maxfd < sockfd)
-			maxfd = sockfd;
-	}
+			if (maxfd < sockfd)
+				maxfd = sockfd;
+		}
 
-	freeaddrinfo(ai0);
+		freeaddrinfo(ai0);
+	} while  (++i < listen_addr->nr);
 
 	*socklist_p = socklist;
 	return socknum;
@@ -810,50 +824,60 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 #else /* NO_IPV6 */
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int socksetup(struct string_list *listen_addr, int listen_port, int **socklist_p)
 {
+	int socknum = 0, *socklist = NULL;
 	struct sockaddr_in sin;
 	int sockfd;
 	long flags;
+	int i;
 
 	memset(&sin, 0, sizeof sin);
 	sin.sin_family = AF_INET;
 	sin.sin_port = htons(listen_port);
 
-	if (listen_addr) {
-		/* Well, host better be an IP address here. */
-		if (inet_pton(AF_INET, listen_addr, &sin.sin_addr.s_addr) <= 0)
+	i = 0;
+	do {
+		if (listen_addr->nr > 0) {
+			/* Well, host better be an IP address here. */
+			if (inet_pton(AF_INET, listen_addr->items[i].string,
+				      &sin.sin_addr.s_addr) <= 0)
+				return 0;
+		}
+		else {
+			sin.sin_addr.s_addr = htonl(INADDR_ANY);
+		}
+
+		sockfd = socket(AF_INET, SOCK_STREAM, 0);
+		if (sockfd < 0)
 			return 0;
-	} else {
-		sin.sin_addr.s_addr = htonl(INADDR_ANY);
-	}
 
-	sockfd = socket(AF_INET, SOCK_STREAM, 0);
-	if (sockfd < 0)
-		return 0;
+		if (set_reuse_addr(sockfd)) {
+			close(sockfd);
+			return 0;
+		}
 
-	if (set_reuse_addr(sockfd)) {
-		close(sockfd);
-		return 0;
-	}
+		if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
+			close(sockfd);
+			return 0;
+		}
 
-	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
-		close(sockfd);
-		return 0;
-	}
+		if (listen(sockfd, 5) < 0) {
+			close(sockfd);
+			return 0;
+		}
 
-	if (listen(sockfd, 5) < 0) {
-		close(sockfd);
-		return 0;
-	}
+		flags = fcntl(sockfd, F_GETFD, 0);
+		if (flags >= 0)
+			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
 
-	flags = fcntl(sockfd, F_GETFD, 0);
-	if (flags >= 0)
-		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+		socklist = xrealloc(socklist, sizeof(int) * (socknum + 1));
+		socklist[socknum++] = sockfd;
 
-	*socklist_p = xmalloc(sizeof(int));
-	**socklist_p = sockfd;
-	return 1;
+	} while (++i < listen_addr->nr);
+
+	*socklist_p = socklist;
+	return socknum;
 }
 
 #endif
@@ -946,14 +970,14 @@ static void store_pid(const char *path)
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
@@ -966,14 +990,17 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 int main(int argc, char **argv)
 {
 	int listen_port = 0;
-	char *listen_addr = NULL;
 	int inetd_mode = 0;
+	struct string_list listen_addr;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct passwd *pass = NULL;
 	struct group *group;
 	gid_t gid = 0;
 	int i;
+	int return_value;
+
+	memset(&listen_addr, 0, sizeof(struct string_list));
 
 	git_extract_argv0_path(argv[0]);
 
@@ -981,7 +1008,7 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (!prefixcmp(arg, "--listen=")) {
-			listen_addr = xstrdup_tolower(arg + 9);
+			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
 			continue;
 		}
 		if (!prefixcmp(arg, "--port=")) {
@@ -1106,7 +1133,7 @@ int main(int argc, char **argv)
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
 
-	if (inetd_mode && (listen_port || listen_addr))
+	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
@@ -1161,5 +1188,9 @@ int main(int argc, char **argv)
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
