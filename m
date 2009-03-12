From: =?utf-8?q?Johan=20S=C3=B8rensen?= <johan@johansorensen.com>
Subject: [PATCH] Introduce a filter-path argument to git-daemon, for doing custom path transformations
Date: Thu, 12 Mar 2009 11:13:40 +0100
Message-ID: <1236852820-12980-1-git-send-email-johan@johansorensen.com>
References: <49B7DFA1.4030409@viscovery.net>
Cc: =?utf-8?q?Johan=20S=C3=B8rensen?= <johan@johansorensen.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 11:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhhwl-0000XA-8p
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbZCLKN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbZCLKN5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:13:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:38573 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539AbZCLKNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:13:55 -0400
Received: by nf-out-0910.google.com with SMTP id d21so79077nfb.21
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 03:13:51 -0700 (PDT)
Received: by 10.216.29.208 with SMTP id i58mr3907424wea.85.1236852831045;
        Thu, 12 Mar 2009 03:13:51 -0700 (PDT)
Received: from localhost.localdomain (nat0.troll.no [62.70.27.100])
        by mx.google.com with ESMTPS id f8sm884042nfh.2.2009.03.12.03.13.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Mar 2009 03:13:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <49B7DFA1.4030409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113035>

The parameter for filter-path is an executable that will receive the service
name, the client hostname and path to the repos the client requests as as
arguments. It is then the responsibility of the script to return a zero
terminated string on its stdout with the real path of the target repository.
---
 Documentation/git-daemon.txt |   13 ++++++++++
 daemon.c                     |   53 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 36f00ae..efd1687 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	     [--strict-paths] [--base-path=path] [--base-path-relaxed]
 	     [--user-path | --user-path=path]
 	     [--interpolated-path=pathtemplate]
+	     [--path-filter=executable]
 	     [--reuseaddr] [--detach] [--pid-file=file]
 	     [--enable=service] [--disable=service]
 	     [--allow-override=service] [--forbid-override=service]
@@ -71,6 +72,18 @@ OPTIONS
 	After interpolation, the path is validated against the directory
 	whitelist.
 
+--path-filter=executable::
+	To support a more flexible directory layout a path filter script 
+	can be used. The executable will receive the service name (upload-pack, 
+	upload-archive or receive-pack), the client hostname and the request git 
+	directory as arguments. The executable must return a zero-terminated string
+	on stdout which is the real path 'git-daemon' should serve. This is useful
+	when --interpolated-path doesn't buy you enough flexibility. You could for
+	instance keep support for old clone urls if you rename your repository, or
+	fetch a custom url-mapping from a third-party repo manager application, or
+	map deeply nested repository directories to a more sensible layout for the 
+	outside world.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
diff --git a/daemon.c b/daemon.c
index d93cf96..e6777c6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 
 #include <syslog.h>
 
@@ -22,6 +23,7 @@ static const char daemon_usage[] =
 "           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
+"           [--path-filter=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
@@ -58,6 +60,10 @@ static char *canon_hostname;
 static char *ip_address;
 static char *tcp_port;
 
+/* if defined, the script will be executed with the requested path on stdin
+ * and _must_ return with a successful exitcode and the new path on stdout */
+static char *path_filter_script;
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	if (log_syslog) {
@@ -287,6 +293,37 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static char *run_path_filter_script(struct daemon_service *s, char *host, char *dir) {
+	char result[256]; /* arbitary */
+	char *real_path;
+	struct child_process filter_cmd;
+	const char *args[] = { path_filter_script, s->name, host, dir, NULL };
+
+	loginfo("Executing path filter script: '%s %s'", path_filter_script, dir);
+	memset(&filter_cmd, 0, sizeof(filter_cmd));
+	filter_cmd.argv = args;
+	filter_cmd.out = -1;
+	
+	if (start_command(&filter_cmd)) {
+		logerror("path filter: unable to fork path_filter_script");
+		return NULL;
+	}
+	
+	read(filter_cmd.out, result, sizeof(result) - 1);
+	
+	close(filter_cmd.out);
+	if (finish_command(&filter_cmd)) {
+		logerror("path filter died with strange error");
+		return NULL;
+	}
+
+	if (result) {
+		real_path = result;
+		return real_path;
+	}
+	return NULL;
+}
+
 static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
@@ -495,6 +532,7 @@ static void parse_extra_args(char *extra_args, int buflen)
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
+	char *path;
 	int pktlen, len, i;
 
 	if (addr) {
@@ -553,11 +591,20 @@ static int execute(struct sockaddr *addr)
 		if (!prefixcmp(line, "git-") &&
 		    !strncmp(s->name, line + 4, namelen) &&
 		    line[namelen + 4] == ' ') {
+			path = line + namelen + 5;
+			if (path_filter_script) {
+				loginfo("path_filter_script %s for path %s", path_filter_script, path);
+				char *tdir;
+				if ((tdir = run_path_filter_script(s, hostname, path))) {
+					path = tdir;
+				}
+			}
+			
 			/*
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			return run_service(path, s);
 		}
 	}
 
@@ -1018,6 +1065,10 @@ int main(int argc, char **argv)
 			pid_file = arg + 11;
 			continue;
 		}
+		if (!prefixcmp(arg, "--path-filter=")) {
+			path_filter_script = arg + 14;
+			continue;
+		}
 		if (!strcmp(arg, "--detach")) {
 			detach = 1;
 			log_syslog = 1;
-- 
1.6.1
