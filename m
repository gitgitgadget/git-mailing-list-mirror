From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] daemon: prepare for multiple services.
Date: Sun, 20 Aug 2006 19:09:19 -0700
Message-ID: <7v3bbqyh4g.fsf@assigned-by-dhcp.cox.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
	<1155923876.10054.205.camel@cashmere.sps.mot.com>
	<7vy7tjxdas.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 21 04:09:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEzED-00037P-Kx
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 04:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWHUCJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 22:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWHUCJV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 22:09:21 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48568 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750811AbWHUCJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 22:09:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060821020920.DUK12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Aug 2006 22:09:20 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25775>

This adds an infrastructure to selectively enable and disable
more than one services in git-daemon.  Currently upload-pack
service, which serves the git-fetch-pack and git-peek-remote
clients, is the only service that is defined.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 daemon.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/daemon.c b/daemon.c
index 012936f..0a6cbb4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -229,13 +229,42 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+typedef int (*daemon_service_fn)(void);
+struct daemon_service {
+	const char *name;
+	const char *config_name;
+	daemon_service_fn fn;
+	int enabled;
+	int overridable;
+};
+
+static struct daemon_service *service_looking_at;
+static int service_enabled;
+
+static int git_daemon_config(const char *var, const char *value)
+{
+	if (!strncmp(var, "daemon.", 7) &&
+	    !strcmp(var + 7, service_looking_at->config_name)) {
+		service_enabled = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* we are not interested in parsing any other configuration here */
+	return 0;
+}
+
+static int run_service(char *dir, struct daemon_service *service)
 {
-	/* Timeout as string */
-	char timeout_buf[64];
 	const char *path;
+	int enabled = service->enabled;
+
+	loginfo("Request %s for '%s'", service->name, dir);
 
-	loginfo("Request for '%s'", dir);
+	if (!enabled && !service->overridable) {
+		logerror("'%s': service not enabled.", service->name);
+		errno = EACCES;
+		return -1;
+	}
 
 	if (!(path = path_ok(dir)))
 		return -1;
@@ -257,12 +286,34 @@ static int upload(char *dir)
 		return -1;
 	}
 
+	if (service->overridable) {
+		service_looking_at = service;
+		service_enabled = -1;
+		git_config(git_daemon_config);
+		if (0 <= service_enabled)
+			enabled = service_enabled;
+	}
+	if (!enabled) {
+		logerror("'%s': service not enabled for '%s'",
+			 service->name, path);
+		errno = EACCES;
+		return -1;
+	}
+
 	/*
 	 * We'll ignore SIGTERM from now on, we have a
 	 * good client.
 	 */
 	signal(SIGTERM, SIG_IGN);
 
+	return service->fn();
+}
+
+static int upload_pack(void)
+{
+	/* Timeout as string */
+	char timeout_buf[64];
+
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
 
 	/* git-upload-pack only ever reads stuff, so this is safe */
@@ -270,10 +321,36 @@ static int upload(char *dir)
 	return -1;
 }
 
+static struct daemon_service daemon_service[] = {
+	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
+};
+
+static void enable_service(const char *name, int ena) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+		if (!strcmp(daemon_service[i].name, name)) {
+			daemon_service[i].enabled = ena;
+			return;
+		}
+	}
+	die("No such service %s", name);
+}
+
+static void make_service_overridable(const char *name, int ena) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+		if (!strcmp(daemon_service[i].name, name)) {
+			daemon_service[i].overridable = ena;
+			return;
+		}
+	}
+	die("No such service %s", name);
+}
+
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
-	int pktlen, len;
+	int pktlen, len, i;
 
 	if (addr) {
 		char addrbuf[256] = "";
@@ -310,8 +387,14 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
+	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
+		struct daemon_service *s = &(daemon_service[i]);
+		int namelen = strlen(s->name);
+		if (!strncmp("git-", line, 4) &&
+		    !strncmp(s->name, line + 4, namelen) &&
+		    line[namelen + 4] == ' ')
+			return run_service(line + namelen + 5, s);
+	}
 
 	logerror("Protocol error: '%s'", line);
 	return -1;
@@ -791,6 +874,22 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--enable=", 9)) {
+			enable_service(arg + 9, 1);
+			continue;
+		}
+		if (!strncmp(arg, "--disable=", 10)) {
+			enable_service(arg + 10, 0);
+			continue;
+		}
+		if (!strncmp(arg, "--enable-override=", 18)) {
+			make_service_overridable(arg + 18, 1);
+			continue;
+		}
+		if (!strncmp(arg, "--disable-override=", 19)) {
+			make_service_overridable(arg + 19, 0);
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
-- 
1.4.2.g0cac8
