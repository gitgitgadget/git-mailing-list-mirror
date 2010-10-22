From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 15/15] daemon: opt-out on features that require posix
Date: Fri, 22 Oct 2010 02:05:44 +0200
Message-ID: <1287705944-5668-15-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95AM-0004aC-5P
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936Ab0JVAHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:07:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56736 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759304Ab0JVAHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:07:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so355721ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=smYhGhwXe8DBuYB++3Y/of4bEjl0JC9I7LauKWFD5ls=;
        b=Qh0Wbxrys87Ts/9uL1yS8Dei+PvK0PvUVtRUCDBeq4+os81t7l1dxXFxzonpxLzu9C
         Je4UHasa2LHhB79tBh+LNZ+prT4y8YgxwXE9fm3OfhH4J+EzkTzzi9wPEE0gDE+OobaS
         9Y53EAdtn1BdLMByqQu4mlrVtzWVwdHx3u1nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u0hzGvqNPLHXGsXfS9ShVQVWIB7SiGgDD+Xu+t/OGDRmfGhLERYyeC5ugMqIgMKm7A
         VobM9xrzoAUyeJxkGEaddi8plheBwVoSzvksi7ltT3hu0RvmT48FK/BGFByAdvS0d3W5
         M6IlZQUw47VAnqyeGnrufAkaHJ3ATCKJDCumE=
Received: by 10.213.98.78 with SMTP id p14mr8811053ebn.54.1287706019951;
        Thu, 21 Oct 2010 17:06:59 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm2463547eeh.23.2010.10.21.17.06.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159606>

Windows does not supply the POSIX-functions fork(), setuuid(), setgid(),
setsid() and initgroups(). Error out if --user or --detach is specified
when if so.

MinGW doesn't have prototypes and headers for inet_ntop and inet_pton,
so include our implementation instead. MSVC does, so avoid doing so
there.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |   14 ++++++---
 daemon.c |   90 +++++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 75 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 46034bf..53986b1 100644
--- a/Makefile
+++ b/Makefile
@@ -401,6 +401,7 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
+PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += shell.o
@@ -1066,7 +1067,6 @@ ifeq ($(uname_S),Windows)
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -1077,6 +1077,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
@@ -1119,7 +1120,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -1130,6 +1130,9 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
+	NO_POSIX_GOODIES = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1249,9 +1252,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAM_OBJS += daemon.o
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
@@ -1419,6 +1419,10 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef NO_POSIX_GOODIES
+	BASIC_CFLAGS += -DNO_POSIX_GOODIES
+endif
+
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
diff --git a/daemon.c b/daemon.c
index fc55367..64646cd 100644
--- a/daemon.c
+++ b/daemon.c
@@ -26,7 +26,9 @@ static const char daemon_usage[] =
 "           [--reuseaddr] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
+#ifndef NO_POSIX_GOODIES
 "                      [--detach] [--user=user [--group=group]]\n"
+#endif
 "           [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -934,6 +936,62 @@ static void sanitize_stdfds(void)
 		close(fd);
 }
 
+#ifdef NO_POSIX_GOODIES
+
+struct credentials;
+
+static void drop_privileges(struct credentials *cred)
+{
+	/* nothing */
+}
+
+static void daemonize(void)
+{
+	die("--detach not supported on this platform");
+}
+
+static struct credentials *prepare_credentials(const char *user_name,
+    const char *group_name)
+{
+	die("--user not supported on this platform");
+}
+
+#else
+
+struct credentials {
+	struct passwd *pass;
+	gid_t gid;
+};
+
+static void drop_privileges(struct credentials *cred)
+{
+	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
+	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
+		die("cannot drop privileges");
+}
+
+static struct credentials *prepare_credentials(const char *user_name,
+    const char *group_name)
+{
+	static struct credentials c;
+
+	c.pass = getpwnam(user_name);
+	if (!c.pass)
+		die("user not found - %s", user_name);
+
+	if (!group_name)
+		c.gid = c.pass->pw_gid;
+	else {
+		struct group *group = getgrnam(group_name);
+		if (!group)
+			die("group not found - %s", group_name);
+
+		c.gid = group->gr_gid;
+	}
+
+	return &c;
+}
+
 static void daemonize(void)
 {
 	switch (fork()) {
@@ -951,6 +1009,7 @@ static void daemonize(void)
 	close(2);
 	sanitize_stdfds();
 }
+#endif
 
 static void store_pid(const char *path)
 {
@@ -961,7 +1020,8 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }
 
-static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
+static int serve(struct string_list *listen_addr, int listen_port,
+    struct credentials *cred)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
@@ -970,10 +1030,7 @@ static int serve(struct string_list *listen_addr, int listen_port, struct passwd
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);
 
-	if (pass && gid &&
-	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
-	     setuid(pass->pw_uid)))
-		die("cannot drop privileges");
+	drop_privileges(cred);
 
 	return service_loop(&socklist);
 }
@@ -985,9 +1042,7 @@ int main(int argc, char **argv)
 	int serve_mode = 0, inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
-	struct passwd *pass = NULL;
-	struct group *group;
-	gid_t gid = 0;
+	struct credentials *cred = NULL;
 	int i;
 
 	git_extract_argv0_path(argv[0]);
@@ -1133,21 +1188,8 @@ int main(int argc, char **argv)
 	if (group_name && !user_name)
 		die("--group supplied without --user");
 
-	if (user_name) {
-		pass = getpwnam(user_name);
-		if (!pass)
-			die("user not found - %s", user_name);
-
-		if (!group_name)
-			gid = pass->pw_gid;
-		else {
-			group = getgrnam(group_name);
-			if (!group)
-				die("group not found - %s", group_name);
-
-			gid = group->gr_gid;
-		}
-	}
+	if (user_name)
+		cred = prepare_credentials(user_name, group_name);
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
@@ -1181,5 +1223,5 @@ int main(int argc, char **argv)
 	cld_argv[argc] = "--serve";
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, pass, gid);
+	return serve(&listen_addr, listen_port, cred);
 }
-- 
1.7.3.1.199.g72340
