From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Add virtualization support to git-daemon
Date: Sat, 16 Sep 2006 17:38:29 -0500
Message-ID: <E1GOint-00048W-2A@jdl.com>
X-From: git-owner@vger.kernel.org Sun Sep 17 00:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOio0-0002n8-QA
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWIPWid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWIPWid
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 18:38:33 -0400
Received: from colo.jdl.com ([66.118.10.122]:7111 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964807AbWIPWic (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 18:38:32 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GOint-00048W-2A
	for git@vger.kernel.org; Sat, 16 Sep 2006 17:38:31 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27141>


Signed-off-by: Jon Loeliger

---

Junio,

Here is a rebase of my patches to support virtual hosts
in git-daemon.  This rebase accounts for the changes in
handling the table of daemon services recently introduced.

I use an inetd invocation like this example:

    git  stream  tcp  nowait  nobody  /usr/bin/git-daemon git-daemon --inetd
        --verbose --syslog
        --export-all --interpolated-path=/pub/%H/%D
	/pub/software /software
	/pub/www.example.com/software
	/pub/www.example.org/software
	/pub

Still room for improvements, of course.

Thanks,
jdl


 Makefile      |    4 ++
 daemon.c      |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 interpolate.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 interpolate.h |   13 +++++++
 4 files changed, 189 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..673ba2d 100644
--- a/Makefile
+++ b/Makefile
@@ -244,7 +244,9 @@ DIFF_OBJS = \
 
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
index b14d808..7822545 100644
--- a/daemon.c
+++ b/daemon.c
@@ -12,6 +12,7 @@ #include <grp.h>
 #include "pkt-line.h"
 #include "cache.h"
 #include "exec_cmd.h"
+#include "interpolate.h"
 
 static int log_syslog;
 static int verbose;
@@ -21,6 +22,7 @@ static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
+"           [--interpolated-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--user=user [[--group=group]] [directory...]";
@@ -34,6 +36,10 @@ static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
 static char *base_path;
+static char *interpolated_path;
+
+/* Flag indicating client sent extra args. */
+static int saw_extended_args;
 
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
@@ -45,6 +51,23 @@ static const char *user_path;
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
@@ -152,10 +175,14 @@ static int avoid_alias(char *p)
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
 
 	if (avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
@@ -184,16 +211,34 @@ static char *path_ok(char *dir)
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
@@ -257,12 +302,14 @@ static int git_daemon_config(const char 
 	return 0;
 }
 
-static int run_service(char *dir, struct daemon_service *service)
+static int run_service(struct interp *itable, struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
 
-	loginfo("Request %s for '%s'", service->name, dir);
+	loginfo("Request %s for '%s'",
+		service->name,
+		itable[INTERP_SLOT_DIR].value);
 
 	if (!enabled && !service->overridable) {
 		logerror("'%s': service not enabled.", service->name);
@@ -270,7 +317,7 @@ static int run_service(char *dir, struct
 		return -1;
 	}
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(itable)))
 		return -1;
 
 	/*
@@ -351,6 +398,29 @@ static void make_service_overridable(con
 	die("No such service %s", name);
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
@@ -391,13 +461,19 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
+	if (len != pktlen) {
+	    parse_extra_args(line + len + 1, pktlen - len - 1);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		int namelen = strlen(s->name);
 		if (!strncmp("git-", line, 4) &&
 		    !strncmp(s->name, line + 4, namelen) &&
-		    line[namelen + 4] == ' ')
-			return run_service(line + namelen + 5, s);
+		    line[namelen + 4] == ' ') {
+			interp_table[INTERP_SLOT_DIR].value = line+namelen+5;
+			return run_service(interp_table, s);
+		}
 	}
 
 	logerror("Protocol error: '%s'", line);
@@ -860,6 +936,10 @@ int main(int argc, char **argv)
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
