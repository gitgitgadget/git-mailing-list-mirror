From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH V2] Add virtualization support to git-daemon
Date: Tue, 19 Sep 2006 20:31:51 -0500
Message-ID: <E1GPqwJ-0002xt-Bt@jdl.com>
X-From: git-owner@vger.kernel.org Wed Sep 20 03:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPqwY-0001fF-5i
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 03:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWITBb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 21:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWITBb6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 21:31:58 -0400
Received: from mail.jdl.com ([66.118.10.122]:49882 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750757AbWITBb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 21:31:56 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GPqwJ-0002xt-Bt
	for git@vger.kernel.org; Tue, 19 Sep 2006 20:31:55 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27324>


Signed-off-by: Jon Loeliger

---

Avast Matey! [*1*]

Phat loot!

Here be the promised respin o' me patch.  We be supportin'
git-daemon virtualization with this one.  No more dreaded
hackery for multiple hosts, eh?  A flaggon of mead around!
Aye, it's a bloody good start, here, eh?, but she could
sure use some keel-haulin' and testin'!

Cap'n jdl


[*1*] http://talklikeapirate.com/


 Documentation/git-daemon.txt |   47 ++++++++++++++++++++++
 Makefile                     |    4 +-
 daemon.c                     |   89 +++++++++++++++++++++++++++++++++++++-----
 interpolate.c                |   82 +++++++++++++++++++++++++++++++++++++++
 interpolate.h                |   18 ++++++++
 5 files changed, 229 insertions(+), 11 deletions(-)


diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 741f2c6..87444b4 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
+             [--interpolated-path=pathtemplate]
              [--enable=service] [--disable=service]
 	     [--allow-override=service] [--forbid-override=service]
              [--reuseaddr] [--detach] [--pid-file=file]
@@ -50,6 +51,12 @@ OPTIONS
 	'git://example.com/hello.git', `git-daemon` will interpret the path
 	as '/srv/git/hello.git'.
 
+--interpolated-path=pathtemplate::
+	To support virtual hosting, an interpolated path template can be
+	used to dynamically construct alternate paths.  The template
+	supports %H for the target hostname as supplied by the client,
+	and %D for the absolute path of the named repository.	
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
@@ -135,6 +142,46 @@ upload-pack::
 	disable it by setting `daemon.uploadpack` configuration
 	item to `false`.
 
+EXAMPLES
+--------
+git-daemon as inetd server::
+	To set up `git-daemon` as an inetd service that handles any
+	repository under the whitelisted set of directories, /pub/foo
+	and /pub/bar, place an entry like the following into
+	/etc/inetd all on one line:
++
+------------------------------------------------
+	git stream tcp nowait nobody  /usr/bin/git-daemon
+		git-daemon --inetd --verbose
+		--syslog --export-all
+		/pub/foo /pub/bar
+------------------------------------------------
+
+
+git-daemon as inetd server for virtual hosts::
+	To set up `git-daemon` as an inetd service that handles
+	repositories for different virtual hosts, `www.example.com`
+	and `www.example.org`, place an entry like the following into
+	`/etc/inetd` all on one line:
++
+------------------------------------------------
+	git stream tcp nowait nobody /usr/bin/git-daemon
+		git-daemon --inetd --verbose
+		--syslog --export-all
+		--interpolated-path=/pub/%H%D
+		/pub/www.example.org/software
+		/pub/www.example.com/software
+		/software
+------------------------------------------------
++
+In this example, the root-level directory `/pub` will contain
+a subdirectory for each virtual host name supported.
+Further, both hosts advertise repositories simply as
+`git://www.example.com/software/repo.git`.  For pre-1.4.0
+clients, a symlink from `/software` into the appropriate
+default repository could be made as well.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
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
index b14d808..ef3a955 100644
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
@@ -45,6 +51,21 @@ static const char *user_path;
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
+static struct interp interp_table[] = {
+	{ "%H", 0},
+	{ "%D", 0},
+	{ "%%", "%"},
+};
+
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	/* We should do a single write so that it is atomic and output
@@ -152,10 +173,14 @@ static int avoid_alias(char *p)
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
@@ -184,16 +209,27 @@ static char *path_ok(char *dir)
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
+		interpolate(interp_path, PATH_MAX, interpolated_path,
+			    interp_table, ARRAY_SIZE(interp_table));
+		loginfo("Interpolated dir '%s'", interp_path);
+
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
+		dir = rpath;
 	}
 
 	path = enter_repo(dir, strict_paths);
@@ -257,12 +293,14 @@ static int git_daemon_config(const char 
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
@@ -270,7 +308,7 @@ static int run_service(char *dir, struct
 		return -1;
 	}
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(itable)))
 		return -1;
 
 	/*
@@ -351,6 +389,28 @@ static void make_service_overridable(con
 	die("No such service %s", name);
 }
 
+static void parse_extra_args(char *extra_args, int buflen)
+{
+	char *val;
+	int vallen;
+	char *end = extra_args + buflen;
+
+	while (extra_args < end && *extra_args) {
+		saw_extended_args = 1;
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
@@ -391,13 +451,18 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
+	if (len != pktlen)
+	    parse_extra_args(line + len + 1, pktlen - len - 1);
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
@@ -860,6 +925,10 @@ int main(int argc, char **argv)
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
index 0000000..d82f1b5
--- /dev/null
+++ b/interpolate.c
@@ -0,0 +1,82 @@
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
+int interpolate(char *result, int reslen,
+		char *orig,
+		struct interp *interps, int ninterps)
+{
+	char *src = orig;
+	char *dest = result;
+	int newlen = 0;
+	char *name, *value;
+	int namelen, valuelen;
+	int i;
+	char c;
+
+        memset(result, 0, reslen);
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
index 0000000..00c63a5
--- /dev/null
+++ b/interpolate.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2006 Jon Loeliger
+ */
+
+#ifndef INTERPOLATE_H
+#define INTERPOLATE_H
+
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
+#endif /* INTERPOLATE_H */
