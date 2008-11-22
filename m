From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/4] daemon: use strbuf_expand() instead of interpolate()
Date: Sun, 23 Nov 2008 00:15:01 +0100
Message-ID: <49289275.7090003@lsrfire.ath.cx>
References: <4928912A.5050307@lsrfire.ath.cx> <492891FC.6000908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Loeliger <jdl@freescale.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 00:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41iD-0002PM-BO
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 00:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYKVXPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 18:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbYKVXPI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 18:15:08 -0500
Received: from india601.server4you.de ([85.25.151.105]:49199 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbYKVXPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 18:15:07 -0500
Received: from [10.0.1.101] (p57B7B890.dip.t-dialin.net [87.183.184.144])
	by india601.server4you.de (Postfix) with ESMTPSA id 2C3572F8057;
	Sun, 23 Nov 2008 00:15:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <492891FC.6000908@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101562>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 daemon.c |  109 ++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/daemon.c b/daemon.c
index b9ba44c..64f60c4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
-#include "interpolate.h"
 
 #include <syslog.h>
 
@@ -54,26 +53,11 @@ static const char *user_path;
 static unsigned int timeout;
 static unsigned int init_timeout;
 
-/*
- * Static table for now.  Ugh.
- * Feel free to make dynamic as needed.
- */
-#define INTERP_SLOT_HOST	(0)
-#define INTERP_SLOT_CANON_HOST	(1)
-#define INTERP_SLOT_IP		(2)
-#define INTERP_SLOT_PORT	(3)
-#define INTERP_SLOT_DIR		(4)
-#define INTERP_SLOT_PERCENT	(5)
-
-static struct interp interp_table[] = {
-	{ "%H", 0},
-	{ "%CH", 0},
-	{ "%IP", 0},
-	{ "%P", 0},
-	{ "%D", 0},
-	{ "%%", 0},
-};
-
+static char *hostname;
+static char *canon_hostname;
+static char *ip_address;
+static char *tcp_port;
+static char *directory;
 
 static void logreport(int priority, const char *err, va_list params)
 {
@@ -163,7 +147,7 @@ static int avoid_alias(char *p)
 	}
 }
 
-static char *path_ok(struct interp *itable)
+static char *path_ok(void)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
@@ -171,7 +155,7 @@ static char *path_ok(struct interp *itable)
 	char *path;
 	char *dir;
 
-	dir = itable[INTERP_SLOT_DIR].value;
+	dir = directory;
 
 	if (avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
@@ -201,14 +185,27 @@ static char *path_ok(struct interp *itable)
 		}
 	}
 	else if (interpolated_path && saw_extended_args) {
+		struct strbuf expanded_path = STRBUF_INIT;
+		struct strbuf_expand_dict_entry dict[] = {
+			{ "H", hostname },
+			{ "CH", canon_hostname },
+			{ "IP", ip_address },
+			{ "P", tcp_port },
+			{ "D", directory },
+			{ "%", "%" },
+			{ NULL }
+		};
+
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
 			return NULL;
 		}
 
-		interpolate(interp_path, PATH_MAX, interpolated_path,
-			    interp_table, ARRAY_SIZE(interp_table));
+		strbuf_expand(&expanded_path, interpolated_path,
+				strbuf_expand_dict_cb, &dict);
+		strlcpy(interp_path, expanded_path.buf, PATH_MAX);
+		strbuf_release(&expanded_path);
 		loginfo("Interpolated dir '%s'", interp_path);
 
 		dir = interp_path;
@@ -233,7 +230,7 @@ static char *path_ok(struct interp *itable)
 		 * prefixing the base path
 		 */
 		if (base_path && base_path_relaxed && !retried_path) {
-			dir = itable[INTERP_SLOT_DIR].value;
+			dir = directory;
 			retried_path = 1;
 			continue;
 		}
@@ -299,14 +296,12 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int run_service(struct interp *itable, struct daemon_service *service)
+static int run_service(struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
 
-	loginfo("Request %s for '%s'",
-		service->name,
-		itable[INTERP_SLOT_DIR].value);
+	loginfo("Request %s for '%s'", service->name, directory);
 
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
@@ -314,7 +309,7 @@ static int run_service(struct interp *itable, struct daemon_service *service)
 		return -1;
 	}
 
-	if (!(path = path_ok(itable)))
+	if (!(path = path_ok()))
 		return -1;
 
 	/*
@@ -413,9 +408,8 @@ static void make_service_overridable(const char *name, int ena)
 
 /*
  * Separate the "extra args" information as supplied by the client connection.
- * Any resulting data is squirreled away in the given interpolation table.
  */
-static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
+static void parse_extra_args(char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
@@ -433,9 +427,11 @@ static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
 				if (port) {
 					*port = 0;
 					port++;
-					interp_set_entry(table, INTERP_SLOT_PORT, port);
+					free(tcp_port);
+					tcp_port = xstrdup(port);
 				}
-				interp_set_entry(table, INTERP_SLOT_HOST, host);
+				free(hostname);
+				hostname = xstrdup(host);
 			}
 
 			/* On to the next one */
@@ -444,14 +440,14 @@ static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
 	}
 }
 
-static void fill_in_extra_table_entries(struct interp *itable)
+static void fill_in_extra_table_entries(void)
 {
 	char *hp;
 
 	/*
 	 * Replace literal host with lowercase-ized hostname.
 	 */
-	hp = interp_table[INTERP_SLOT_HOST].value;
+	hp = hostname;
 	if (!hp)
 		return;
 	for ( ; *hp; hp++)
@@ -470,17 +466,17 @@ static void fill_in_extra_table_entries(struct interp *itable)
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		gai = getaddrinfo(interp_table[INTERP_SLOT_HOST].value, 0, &hints, &ai0);
+		gai = getaddrinfo(hostname, 0, &hints, &ai0);
 		if (!gai) {
 			for (ai = ai0; ai; ai = ai->ai_next) {
 				struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
 
 				inet_ntop(AF_INET, &sin_addr->sin_addr,
 					  addrbuf, sizeof(addrbuf));
-				interp_set_entry(interp_table,
-						 INTERP_SLOT_CANON_HOST, ai->ai_canonname);
-				interp_set_entry(interp_table,
-						 INTERP_SLOT_IP, addrbuf);
+				free(canon_hostname);
+				canon_hostname = xstrdup(ai->ai_canonname);
+				free(ip_address);
+				ip_address = xstrdup(addrbuf);
 				break;
 			}
 			freeaddrinfo(ai0);
@@ -493,7 +489,7 @@ static void fill_in_extra_table_entries(struct interp *itable)
 		char **ap;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
-		hent = gethostbyname(interp_table[INTERP_SLOT_HOST].value);
+		hent = gethostbyname(hostname);
 
 		ap = hent->h_addr_list;
 		memset(&sa, 0, sizeof sa);
@@ -504,8 +500,10 @@ static void fill_in_extra_table_entries(struct interp *itable)
 		inet_ntop(hent->h_addrtype, &sa.sin_addr,
 			  addrbuf, sizeof(addrbuf));
 
-		interp_set_entry(interp_table, INTERP_SLOT_CANON_HOST, hent->h_name);
-		interp_set_entry(interp_table, INTERP_SLOT_IP, addrbuf);
+		free(canon_hostname);
+		canon_hostname = xstrdup(hent->h_name);
+		free(ip_address);
+		ip_address = xstrdup(addrbuf);
 	}
 #endif
 }
@@ -557,15 +555,16 @@ static int execute(struct sockaddr *addr)
 		pktlen--;
 	}
 
-	/*
-	 * Initialize the path interpolation table for this connection.
-	 */
-	interp_clear_table(interp_table, ARRAY_SIZE(interp_table));
-	interp_set_entry(interp_table, INTERP_SLOT_PERCENT, "%");
+	free(hostname);
+	free(canon_hostname);
+	free(ip_address);
+	free(tcp_port);
+	free(directory);
+	hostname = canon_hostname = ip_address = tcp_port = directory = NULL;
 
 	if (len != pktlen) {
-	    parse_extra_args(interp_table, line + len + 1, pktlen - len - 1);
-	    fill_in_extra_table_entries(interp_table);
+		parse_extra_args(line + len + 1, pktlen - len - 1);
+		fill_in_extra_table_entries();
 	}
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
@@ -578,9 +577,9 @@ static int execute(struct sockaddr *addr)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			interp_set_entry(interp_table,
-					 INTERP_SLOT_DIR, line + namelen + 5);
-			return run_service(interp_table, s);
+			free(directory);
+			directory = xstrdup(line + namelen + 5);
+			return run_service(s);
 		}
 	}
 
-- 
1.6.0.4.755.g6e139
