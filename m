From: Jon Loeliger <jdl@jdl.com>
Subject: [RFC] Add first whack at interpolated daemon paths.
Date: Sun, 04 Jun 2006 22:54:59 -0500
Message-ID: <E1Fn6B9-00017u-BV@jdl.com>
X-From: git-owner@vger.kernel.org Mon Jun 05 05:55:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn6BJ-0007ZU-Ci
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 05:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWFEDzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 23:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWFEDzE
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 23:55:04 -0400
Received: from jdl.com ([66.118.10.122]:8426 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932327AbWFEDzC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 23:55:02 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1Fn6B9-00017u-BV
	for git@vger.kernel.org; Sun, 04 Jun 2006 22:55:01 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21311>


Modify git protocol to pass in client hostname and
allow it to be interpolated into daemon source dir.
New --interpolated-path=<path> option.
---
 Makefile      |    1 +
 connect.c     |   16 +++++++-
 daemon.c      |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 interpolate.c |   74 +++++++++++++++++++++++++++++++++++++
 interpolate.h |   10 +++++
 5 files changed, 198 insertions(+), 16 deletions(-)

This is really RFC-ish.  No canonicalization of hostname is done.
It is backwards compatible with existing daemon path handling,
but also allows for future extensibility with more "extended"
client args being supplied.  The interpolate code is pretty
generic, but the table driving it in this case is hard coded.
Tons of loginfo() crap left in here to be cleaned up.


diff --git a/Makefile b/Makefile
index 004c216..6a02236 100644
--- a/Makefile
+++ b/Makefile
@@ -211,6 +211,7 @@ DIFF_OBJS = \
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
+	interpolate.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o dir.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
diff --git a/connect.c b/connect.c
index 54f7bf7..9e7b276 100644
--- a/connect.c
+++ b/connect.c
@@ -374,7 +374,13 @@ static int git_tcp_connect(int fd[2], co
 
 	fd[0] = sockfd;
 	fd[1] = sockfd;
-	packet_write(sockfd, "%s %s\n", prog, path);
+
+	/*
+	 * Separate original protocol components prog and path
+	 * from extended components with a NUL byte.
+	 */
+	packet_write(sockfd, "%s %s%cHOST=%s\n", prog, path, 0, host);
+
 	return 0;
 }
 
@@ -443,7 +449,13 @@ static int git_tcp_connect(int fd[2], co
 
 	fd[0] = sockfd;
 	fd[1] = sockfd;
-	packet_write(sockfd, "%s %s\n", prog, path);
+
+	/*
+	 * Separate original protocol components prog and path
+	 * from extended components with a NUL byte.
+	 */
+	packet_write(sockfd, "%s %s%cHOST=%s\n", prog, path, 0, host);
+
 	return 0;
 }
 
diff --git a/daemon.c b/daemon.c
index 776749e..0c9ebe3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -10,6 +10,7 @@ #include <syslog.h>
 #include "pkt-line.h"
 #include "cache.h"
 #include "exec_cmd.h"
+#include "interpolate.h"
 
 static int log_syslog;
 static int verbose;
@@ -18,7 +19,8 @@ static int reuseaddr;
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [--user-path | --user-path=path]\n"
+"           [--base-path=path] [--interpolated-path=path]\n"
+"           [--user-path | --user-path=path]\n"
 "           [--reuseaddr] [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -28,8 +30,15 @@ static int strict_paths = 0;
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees = 0;
 
-/* Take all paths relative to this one if non-NULL */
+/*
+ * Take all paths relative to this one if non-NULL.
+ * 
+ */
 static char *base_path = NULL;
+static char *interpolated_path = NULL;
+
+/* Flag indicating client sent extra args. */
+int saw_extended_args = 0;
 
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
@@ -41,6 +50,23 @@ static char *user_path = NULL;
 static unsigned int timeout = 0;
 static unsigned int init_timeout = 0;
 
+/*
+ * Static table for now.  Ugh.
+ * Feel free to make dynamic as needed.
+ */
+#define INTERP_SLOT_HOST	(0)
+#define INTERP_SLOT_DIR		(1)
+#define INTERP_SLOT_PERCENT	(2)
+
+struct interp interp_table[] = {
+	{ "%H", 0},
+	{ "%D", 0},
+	{ "%%", "%"},
+};
+
+#define N_INTERPS	(sizeof(interp_table) / sizeof(struct interp))
+
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	/* We should do a single write so that it is atomic and output
@@ -142,10 +168,15 @@ static int avoid_alias(char *p)
 	}
 }
 
-static char *path_ok(char *dir)
+static char *path_ok(struct interp *itable)
 {
 	static char rpath[PATH_MAX];
+	static char interp_path[PATH_MAX];
 	char *path;
+	char *dir;
+
+	dir = itable[INTERP_SLOT_DIR].value;
+	loginfo("Request for '%s'", dir);
 
 	if (avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
@@ -174,16 +205,34 @@ static char *path_ok(char *dir)
 			dir = rpath;
 		}
 	}
+	else if (interpolated_path && saw_extended_args) {
+		if (*dir != '/') {
+			/* Allow only absolute */
+			logerror("'%s': Non-absolute path denied (interpolated-path active)", dir);
+			return NULL;
+		}
+
+		loginfo("Before interpolation '%s'", dir);
+		loginfo("Interp slot 0 (%s,%s)",
+			interp_table[0].name, interp_table[0].value);
+		loginfo("Interp slot 1 (%s,%s)",
+			interp_table[1].name, interp_table[1].value);
+		interpolate(interp_path, PATH_MAX, interpolated_path,
+			    interp_table, N_INTERPS);
+		loginfo("After interpolation '%s'", interp_path);
+		dir = interp_path;
+	}
 	else if (base_path) {
 		if (*dir != '/') {
 			/* Allow only absolute */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
 			return NULL;
 		}
-		else {
-			snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
-			dir = rpath;
-		}
+		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+		loginfo("dir was %s", dir);
+		loginfo("base_path is %s", base_path);
+		loginfo("rpath now %s", rpath);
+		dir = rpath;
 	}
 
 	path = enter_repo(dir, strict_paths);
@@ -223,15 +272,13 @@ static char *path_ok(char *dir)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-static int upload(char *dir)
+static int upload(struct interp *itable)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
 	const char *path;
 
-	loginfo("Request for '%s'", dir);
-
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(itable)))
 		return -1;
 
 	/*
@@ -264,10 +311,34 @@ static int upload(char *dir)
 	return -1;
 }
 
+void parse_extra_args(char *extra_args, int buflen)
+{
+	char *val;
+	int vallen;
+	char *end = extra_args + buflen;
+
+	while (extra_args < end && *extra_args) {
+		saw_extended_args = 1;
+		loginfo("Extended arg %s", extra_args);
+		if (strncasecmp("host=", extra_args, 5) == 0) {
+			val = extra_args + 5;
+			vallen = strlen(val) + 1;
+			if (*val) {
+				char *save = xmalloc(vallen);
+				interp_table[INTERP_SLOT_HOST].value = save;
+				safe_strncpy(save, val, vallen);
+			}
+			/* On to the next one */
+			extra_args = val + vallen;
+		}
+	}
+}
+
 static int execute(void)
 {
 	static char line[1000];
-	int len;
+	int len;	/* full packet length, including extended args */
+	int n;		/* original protocol part size */
 
 	alarm(init_timeout ? init_timeout : timeout);
 	len = packet_read_line(0, line, sizeof(line));
@@ -276,8 +347,18 @@ static int execute(void)
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
+	/*
+	 * Check for extended args after a NUL byte.
+	 */
+	n = strlen(line);
+	if (n != len) {
+	    parse_extra_args(line + n + 1, len - n - 1);
+	}
+
+	if (!strncmp("git-upload-pack ", line, 16)) {
+		interp_table[INTERP_SLOT_DIR].value = line+16;
+		return upload(interp_table);
+	}
 
 	logerror("Protocol error: '%s'", line);
 	return -1;
@@ -711,6 +792,10 @@ int main(int argc, char **argv)
 			base_path = arg+12;
 			continue;
 		}
+		if (!strncmp(arg, "--interpolated-path=", 20)) {
+			interpolated_path = arg+20;
+			continue;
+		}
 		if (!strcmp(arg, "--reuseaddr")) {
 			reuseaddr = 1;
 			continue;
diff --git a/interpolate.c b/interpolate.c
new file mode 100644
index 0000000..d936022
--- /dev/null
+++ b/interpolate.c
@@ -0,0 +1,74 @@
+#include <string.h>
+
+#include "interpolate.h"
+
+
+int
+interpolate(char *result, int reslen, char *orig,
+	    struct interp *interps, int ninterps)
+{
+    int i;
+    char *p;
+    char *src = orig;
+    char *dest = result;
+    int newlen = 0;
+
+    char *name;
+    char *value;
+    int valuelen;
+
+    do {
+
+	p = strchr(src, '%');
+	
+	if (p) {
+	    /*
+	     * Found a potential interpolation point.
+	     */
+	    for (i = 0; i < ninterps; i++) {
+		name = interps[i].name;
+		if (strncmp(p, name, strlen(name)) == 0)
+		    break;
+	    }
+
+	    value = interps[i].value;
+	    valuelen = strlen(value);
+	    printf("Interp: %s to %s\n", name, value);
+
+	    int len = p - src;
+	    if (newlen + len < reslen) {
+		strncpy(dest, src, len);
+		newlen += len;
+		dest += len;
+		*dest = 0;
+		src = p + strlen(name);
+		if (newlen + valuelen < reslen) {
+		    strncpy(dest, value, valuelen);
+		    newlen += valuelen;
+		    dest += valuelen;
+		    *dest = 0;
+		} else {
+		    printf("new value %s didn't fit.\n", value);
+		    return 0;	/* something's not fitting. */
+		}
+	    } else {
+		printf("orig part %s didn't fit.\n", src);
+		return 0;	/* something's not fitting. */
+	    }
+
+	} else {
+	    /* Copy remainder */
+	    int len = strlen(src);
+	    if (newlen < reslen) {
+		strncpy(dest, src, len);
+		dest += len;
+		*dest = 0;
+	    } else {
+		printf("Remainder %s didn't fit.\n", src);
+		return 0;
+	    }
+	}
+    } while (p);
+
+    return 1;	/* successful */
+}
diff --git a/interpolate.h b/interpolate.h
new file mode 100644
index 0000000..3b710ad
--- /dev/null
+++ b/interpolate.h
@@ -0,0 +1,10 @@
+
+struct interp {
+	char *name;
+	char *value;
+};
+
+
+extern int interpolate(char *result, int reslen, char *orig,
+		       struct interp *interps, int ninterps);
+
-- 
1.3.3.g16a4-dirty
