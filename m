From: =?utf-8?q?Johan=20S=C3=B8rensen?= <johan@johansorensen.com>
Subject: [PATCH] Introduce a filter-path argument to git-daemon, for doing custom path transformations
Date: Wed, 11 Mar 2009 16:17:27 +0100
Message-ID: <1236784647-71388-1-git-send-email-johan@johansorensen.com>
Cc: =?utf-8?q?Johan=20S=C3=B8rensen?= <johan@johansorensen.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 16:19:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQD9-0002Me-OJ
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbZCKPRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbZCKPRj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:17:39 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:7699 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZCKPRi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 11:17:38 -0400
Received: by ey-out-2122.google.com with SMTP id 25so12826eya.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 08:17:35 -0700 (PDT)
Received: by 10.216.26.201 with SMTP id c51mr3446217wea.228.1236784655118;
        Wed, 11 Mar 2009 08:17:35 -0700 (PDT)
Received: from localhost.localdomain (nat0.troll.no [62.70.27.100])
        by mx.google.com with ESMTPS id f8sm12074360nfh.2.2009.03.11.08.17.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Mar 2009 08:17:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112938>

The argument is an executable script that will receive the path to the repos
the client wishes to clone as an argument. It is then the responsibility of the
script to return a zero-terminated string on its stdout with the real path of
the target repository.

This buys us a lot of flexibility when it comes to managing different
repositories, possibly located in many different dirs, but with a uniform
url-structure to the outside world.
---
 Documentation/git-daemon.txt |    7 ++++
 daemon.c                     |   75 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 36f00ae..1eca344 100644
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
@@ -71,6 +72,12 @@ OPTIONS
 	After interpolation, the path is validated against the directory
 	whitelist.
 
+--path-filter=executable::
+	To support a more flexible directory layout a path filter script 
+	can be used. The executable will receive the requested path from
+	the client as arg0. The executable must return a zero-terminated
+	string on stdout which is the real path 'git-daemon' should serve.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
diff --git a/daemon.c b/daemon.c
index d93cf96..b2571df 100644
--- a/daemon.c
+++ b/daemon.c
@@ -22,6 +22,7 @@ static const char daemon_usage[] =
 "           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
+"           [--path-filter=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
@@ -58,6 +59,10 @@ static char *canon_hostname;
 static char *ip_address;
 static char *tcp_port;
 
+/* if defined, the script will be executed with the requested path on stdin
+ * and _must_ return with a successful exitcode and the new path on stdout */
+static char *path_filter_script;
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	if (log_syslog) {
@@ -287,9 +292,62 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+static char *run_path_filter_script(char *requested_dir) {
+	pid_t pid;
+	char result[256]; /* arbitary */
+	char *real_path;
+	int pipe_out[2];
+	int exit_code = 1;
+
+	pipe(pipe_out);
+
+	loginfo("Executing path filter script: '%s %s'", path_filter_script, requested_dir);
+
+	switch ((pid = fork())) {
+		case -1:
+			logerror("path filter script fork() failed: %s", strerror(errno));
+			return NULL;
+		case 0:
+		close(pipe_out[0]);
+		dup2(pipe_out[1], 1);
+		close(pipe_out[1]);
+
+		execl(path_filter_script, path_filter_script, requested_dir, NULL);
+
+		/* execl failed if we got here */
+		logerror("path filter script execl() failed: %s", strerror(errno));
+		return NULL;
+	default:
+		close(pipe_out[1]);
+	
+		while(waitpid(pid, &exit_code, 0) < 0) {
+			switch(errno) {
+			case EINTR:
+			continue;
+			default:
+				logerror("path filter script waitpid() fail: %s", strerror(errno));
+				goto waitpid_error;
+			}
+		}
+		if (WIFEXITED(exit_code) && WEXITSTATUS(exit_code) == 0) {
+			read(pipe_out[0], result, sizeof(result) - 1);
+			loginfo("path filter script result: %s", result);
+		}
+		waitpid_error:
+		close(pipe_out[0]);
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
+	char *real_dir;
 	int enabled = service->enabled;
 
 	loginfo("Request %s for '%s'", service->name, dir);
@@ -299,8 +357,19 @@ static int run_service(char *dir, struct daemon_service *service)
 		errno = EACCES;
 		return -1;
 	}
+	loginfo("path_filter_script %s", path_filter_script);
+	if (!path_filter_script) {
+		real_dir = dir;
+	} else {
+		char *tdir;
+		if ((tdir = run_path_filter_script(dir))) {
+			real_dir = tdir;
+		} else {
+			real_dir = dir;
+		}
+	}
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(real_dir)))
 		return -1;
 
 	/*
@@ -1018,6 +1087,10 @@ int main(int argc, char **argv)
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
