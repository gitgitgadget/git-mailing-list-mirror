From: =?utf-8?q?Johan=20S=C3=B8rensen?= <johan@johansorensen.com>
Subject: [PATCH] Introduce a filter-path argument to git-daemon, for doing custom path transformations
Date: Thu, 12 Mar 2009 16:48:34 +0100
Message-ID: <1236872914-43327-1-git-send-email-johan@johansorensen.com>
References: <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Johan=20S=C3=B8rensen?= <johan@johansorensen.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 16:55:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhnAm-0003jy-CZ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZCLPsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbZCLPsq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:48:46 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:53288 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZCLPsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 11:48:45 -0400
Received: by bwz26 with SMTP id 26so240271bwz.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 08:48:42 -0700 (PDT)
Received: by 10.216.36.209 with SMTP id w59mr80341wea.67.1236872921768;
        Thu, 12 Mar 2009 08:48:41 -0700 (PDT)
Received: from localhost.localdomain (nat0.troll.no [62.70.27.100])
        by mx.google.com with ESMTPS id d23sm1406968nfh.39.2009.03.12.08.48.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Mar 2009 08:48:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113082>

The parameter for filter-path is an executable that will receive the se=
rvice
name, the client hostname and path to the repos the client requests as =
as
arguments. It is then the responsibility of the script to return a zero
terminated string on its stdout with the real path of the target reposi=
tory.

Signed-off-by: Johan S=C3=B8rensen <johan@johansorensen.com>
---
 Documentation/git-daemon.txt |   15 +++++++++++
 daemon.c                     |   54 ++++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.tx=
t
index 36f00ae..bf8d31f 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	     [--strict-paths] [--base-path=3Dpath] [--base-path-relaxed]
 	     [--user-path | --user-path=3Dpath]
 	     [--interpolated-path=3Dpathtemplate]
+	     [--path-filter=3Dexecutable]
 	     [--reuseaddr] [--detach] [--pid-file=3Dfile]
 	     [--enable=3Dservice] [--disable=3Dservice]
 	     [--allow-override=3Dservice] [--forbid-override=3Dservice]
@@ -71,6 +72,20 @@ OPTIONS
 	After interpolation, the path is validated against the directory
 	whitelist.
=20
+--path-filter=3Dexecutable::
+	To support a more flexible directory layout a path filter script
+	can be used. The executable will receive the service name (upload-pac=
k,
+	upload-archive or receive-pack), the client hostname and the request =
git
+	directory as arguments. The executable must return a zero-terminated
+	string on stdout which is the real path 'git-daemon' should serve. Th=
is
+	is useful when --interpolated-path doesn't buy you enough flexibility=
=2E
+	You could for instance keep support for old clone urls if you rename =
your
+	repository, or fetch a custom url-mapping from a third-party repo man=
ager
+	application, or	map deeply nested repository directories to a more
+	sensible layout for the outside world.
+	Please be aware that the executable spawned will have the same privil=
eges
+	as the user you are running the git-daemon under.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
diff --git a/daemon.c b/daemon.c
index d93cf96..e865e78 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
+#include "run-command.h"
=20
 #include <syslog.h>
=20
@@ -22,6 +23,7 @@ static const char daemon_usage[] =3D
 "           [--strict-paths] [--base-path=3Dpath] [--base-path-relaxed=
]\n"
 "           [--user-path | --user-path=3Dpath]\n"
 "           [--interpolated-path=3Dpath]\n"
+"           [--path-filter=3Dpath]\n"
 "           [--reuseaddr] [--detach] [--pid-file=3Dfile]\n"
 "           [--[enable|disable|allow-override|forbid-override]=3Dservi=
ce]\n"
 "           [--inetd | [--listen=3Dhost_or_ipaddr] [--port=3Dn]\n"
@@ -58,6 +60,11 @@ static char *canon_hostname;
 static char *ip_address;
 static char *tcp_port;
=20
+/* if defined, the script will be executed with the service name, host=
name,
+ * and requested path on stdin and _must_ return with a successful exi=
tcode
+ * and the new path on stdout */
+static char *path_filter_script;
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	if (log_syslog) {
@@ -287,6 +294,42 @@ static int git_daemon_config(const char *var, cons=
t char *value, void *cb)
 	return 0;
 }
=20
+static char *run_path_filter_script(struct daemon_service *s, char *ho=
st,
+			    char *dir) {
+	struct strbuf result_buf =3D STRBUF_INIT;
+	struct child_process filter_cmd;
+	const char *args[] =3D { path_filter_script, s->name, host, dir, NULL=
 };
+
+	loginfo("Executing path filter script: '%s %s %s %s'",
+					path_filter_script, s->name, host, dir);
+	memset(&filter_cmd, 0, sizeof(filter_cmd));
+	filter_cmd.argv =3D args;
+	filter_cmd.out =3D -1;
+
+	if (start_command(&filter_cmd)) {
+		logerror("path filter: unable to fork path_filter_script");
+		return dir;
+	}
+
+	if (strbuf_read(&result_buf, filter_cmd.out, PATH_MAX) < 0) {
+		strbuf_release(&result_buf);
+		close(filter_cmd.out);
+		logerror("path filter: script read returned %s", strerror(errno));
+		return dir;
+	}
+
+	close(filter_cmd.out);
+	if (finish_command(&filter_cmd)) {
+		logerror("path filter script died with strange error");
+		return dir;
+	}
+
+	if (result_buf.len > 0)
+		dir =3D strbuf_detach(&result_buf, NULL);
+
+	return dir;
+}
+
 static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
@@ -557,7 +600,12 @@ static int execute(struct sockaddr *addr)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			if (path_filter_script) {
+				return run_service(run_path_filter_script(s, hostname,
+				                   line + namelen + 5), s);
+			} else {
+				return run_service(line + namelen + 5, s);
+			}
 		}
 	}
=20
@@ -1018,6 +1066,10 @@ int main(int argc, char **argv)
 			pid_file =3D arg + 11;
 			continue;
 		}
+		if (!prefixcmp(arg, "--path-filter=3D")) {
+			path_filter_script =3D arg + 14;
+			continue;
+		}
 		if (!strcmp(arg, "--detach")) {
 			detach =3D 1;
 			log_syslog =3D 1;
--=20
1.6.1
