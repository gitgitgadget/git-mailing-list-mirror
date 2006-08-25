From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH/RFC] Add interpolated git-daemon virtualization support.
Date: Fri, 25 Aug 2006 10:26:53 -0500
Message-ID: <E1GGda9-0003Qm-Ly@jdl.com>
X-From: git-owner@vger.kernel.org Fri Aug 25 17:27:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGdaH-0001Ra-Lf
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 17:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWHYP06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 11:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWHYP06
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 11:26:58 -0400
Received: from colo.jdl.com ([66.118.10.122]:53415 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030245AbWHYP05 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 11:26:57 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GGda9-0003Qm-Ly
	for git@vger.kernel.org; Fri, 25 Aug 2006 10:26:56 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25999>


---

Junio,

Here are my patches for the git daemon virtualization after
I rewrote the interpolation code.  I think there are still
issues with the path/directory specification mechanism, as
I end up with crufty inetd invocation:

    git  stream  tcp  nowait  nobody  /usr/bin/git-daemon git-daemon --inetd
        --verbose --syslog
        --export-all --interpolated-path=/pub/%H/%D
	/pub/software /software
	/pub/www.example.com/software
	/pub/www.example.org/software
	/pub

A natural suggestion here is to supply %PeerIP from the connection.

Feel free to extend, augment or make suggestions, of course.

Thanks,
jdl



 Makefile      |    4 ++
 daemon.c      |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 interpolate.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 interpolate.h |   13 +++++++
 4 files changed, 188 insertions(+), 13 deletions(-)


diff --git a/Makefile b/Makefile
index b15b420..2691a58 100644
--- a/Makefile
+++ b/Makefile
@@ -242,7 +242,9 @@ DIFF_OBJS = \
 
 LIB_OBJS = \
 	blob.o commit.o connect.o csum-file.o cache-tree.o base85.o \
-	date.o diff-delta.o entry.o exec_cmd.o ident.o lockfile.o \
+	date.o diff-delta.o entry.o exec_cmd.o ident.o \
+	interpolate.o \
+	lockfile.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
diff --git a/daemon.c b/daemon.c
index 012936f..67a3646 100644
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
 "           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -30,6 +32,10 @@ static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
 static char *base_path;
+static char *interpolated_path;
+
+/* Flag indicating client sent extra args. */
+static int saw_extended_args;
 
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
@@ -41,6 +47,23 @@ static const char *user_path;
 static unsigned int timeout;
 static unsigned int init_timeout;
 
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
@@ -148,10 +171,15 @@ static int avoid_alias(char *p)
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
@@ -180,16 +208,34 @@ static char *path_ok(char *dir)
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
@@ -229,15 +275,13 @@ static char *path_ok(char *dir)
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
@@ -270,6 +314,29 @@ static int upload(char *dir)
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
+				strlcpy(save, val, vallen);
+			}
+			/* On to the next one */
+			extra_args = val + vallen;
+		}
+	}
+}
+
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
@@ -310,8 +377,14 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (!strncmp("git-upload-pack ", line, 16))
-		return upload(line+16);
+	if (len != pktlen) {
+	    parse_extra_args(line + len + 1, pktlen - len - 1);
+	}
+
+	if (!strncmp("git-upload-pack ", line, 16)) {
+		interp_table[INTERP_SLOT_DIR].value = line+16;
+		return upload(interp_table);
+	}
 
 	logerror("Protocol error: '%s'", line);
 	return -1;
@@ -770,6 +843,10 @@ int main(int argc, char **argv)
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
index 0000000..30fa7a1
--- /dev/null
+++ b/interpolate.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright 2006 Jon Loeliger
+ */
+
+#include <string.h>
+
+#include "interpolate.h"
+
+
+/*
+ * Convert a NUL-terminated string in buffer orig
+ * into the supplied buffer, result, whose length is reslen,
+ * performing substitutions on %-named sub-strings from
+ * the table, interps, with ninterps entries.
+ *
+ * Example interps:
+ *    {
+ *        { "%H", "example.org"},
+ *        { "%port", "123"},
+ *        { "%%", "%"},
+ *    }
+ *
+ * Returns 1 on a successful substitution pass that fits in result,
+ * Returns 0 on a failed or overflowing substitution pass.
+ */
+
+int
+interpolate(char *result, int reslen,
+	    char *orig,
+	    struct interp *interps, int ninterps)
+{
+	char *src = orig;
+	char *dest = result;
+	int newlen = 0;
+	char *name, *value;
+	int namelen, valuelen;
+	int i;
+	char c;
+
+	bzero(result, reslen);
+
+	while ((c = *src) && newlen < reslen - 1) {
+		if (c == '%') {
+			/* Try to match an interpolation string. */
+			for (i = 0; i < ninterps; i++) {
+				name = interps[i].name;
+				namelen = strlen(name);
+				if (strncmp(src, name, namelen) == 0) {
+					break;
+				}
+			}
+
+			/* Check for valid interpolation. */
+			if (i < ninterps) {
+				value = interps[i].value;
+				valuelen = strlen(value);
+
+				if (newlen + valuelen < reslen - 1) {
+					/* Substitute. */
+					strncpy(dest, value, valuelen);
+					newlen += valuelen;
+					dest += valuelen;
+					src += namelen;
+				} else {
+					/* Something's not fitting. */
+					return 0;
+				}
+
+			} else {
+				/* Skip bogus interpolation. */
+				*dest++ = *src++;
+				newlen++;
+			}
+
+		} else {
+			/* Straight copy one non-interpolation character. */
+			*dest++ = *src++;
+			newlen++;
+		}
+	}
+
+	return newlen < reslen - 1;
+}
diff --git a/interpolate.h b/interpolate.h
new file mode 100644
index 0000000..241af7c
--- /dev/null
+++ b/interpolate.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright 2006 Jon Loeliger
+ */
+
+struct interp {
+	char *name;
+	char *value;
+};
+
+extern int interpolate(char *result, int reslen,
+		       char *orig,
+		       struct interp *interps, int ninterps);
+
