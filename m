From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Mon, 11 Oct 2010 23:50:29 +0200
Message-ID: <1286833829-5116-16-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QJE-00079M-3N
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab0JKVxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:53:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab0JKVxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:53:17 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PDe5kKrXoXS+i4AUeTYb7KSlvzf5kp508kBm6AHy4NU=;
        b=KRkIplTVqxSxB6IS2hPK2rOEmLqJQyk5RX/ccTLLv/ZFCATLakQE82JAKZy/HC22Qm
         e4vn43EXavDO8l3EgFaJpcY2UW9b/DLaQT6VfBcgYNeddCKRM8EvqN/xvw4MignslPv4
         l3oNKLI/904YvAmQxVlkJvtkkW5cdNRuoomBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gya6gXkHd1ozesqpQxWTxnvaQlzKOW5k+IOJqPKACwUjPnvh9LolKT9w10epxY3tdB
         BmYQ5dyyf7bOTLIY9pSBTFIbkpmw/2cxkMDlhkg5J11XpO3FhILt0VbmOr3xwxlTA+p1
         IzEMOgXFbpEkHdGtRkV2rCkff+F/3dP+Y/5aE=
Received: by 10.213.28.195 with SMTP id n3mr2005752ebc.79.1286833996951;
        Mon, 11 Oct 2010 14:53:16 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q54sm7815674eeh.18.2010.10.11.14.53.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:53:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158807>

Windows does not supply the POSIX-functions fork(), setuuid(), setgid(),
setsid() and initgroups(). Disable support for --user, --group and
--detach if the NO_POSIX_GOODIES flag is set.

MinGW doesn't have prototypes and headers for inet_ntop and inet_pton,
so include our implementation instead. MSVC does have, so avoid doing
so there.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |   14 +++++++++-----
 daemon.c |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 14 deletions(-)

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
index 9b97b58..aa580f6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -23,10 +23,12 @@ static const char daemon_usage[] =
 "           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
-"           [--reuseaddr] [--detach] [--pid-file=file]\n"
+"           [--reuseaddr] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
 "           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
-"                      [--user=user [--group=group]]\n"
+#ifndef NO_POSIX_GOODIES
+"           [--detach] [--user=user [--group=group]]\n"
+#endif
 "           [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -938,6 +940,7 @@ static void sanitize_stdfds(void)
 		close(fd);
 }
 
+#ifndef NO_POSIX_GOODIES
 static void daemonize(void)
 {
 	switch (fork()) {
@@ -955,6 +958,7 @@ static void daemonize(void)
 	close(2);
 	sanitize_stdfds();
 }
+#endif
 
 static void store_pid(const char *path)
 {
@@ -965,7 +969,12 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }
 
-static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
+#ifndef NO_POSIX_GOODIES
+static struct passwd *pass;
+static gid_t gid;
+#endif
+
+static int serve(struct string_list *listen_addr, int listen_port)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
@@ -974,10 +983,12 @@ static int serve(struct string_list *listen_addr, int listen_port, struct passwd
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);
 
+#ifndef NO_POSIX_GOODIES
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
 	     setuid(pass->pw_uid)))
 		die("cannot drop privileges");
+#endif
 
 	return service_loop(&socklist);
 }
@@ -987,11 +998,11 @@ int main(int argc, char **argv)
 	int listen_port = 0;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
 	int serve_mode = 0, inetd_mode = 0;
-	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
+	const char *pid_file = NULL;
+#ifndef NO_POSIX_GOODIES
 	int detach = 0;
-	struct passwd *pass = NULL;
-	struct group *group;
-	gid_t gid = 0;
+	const char *user_name = NULL, *group_name = NULL;
+#endif
 	int i;
 
 	git_extract_argv0_path(argv[0]);
@@ -1080,6 +1091,7 @@ int main(int argc, char **argv)
 			pid_file = arg + 11;
 			continue;
 		}
+#ifndef NO_POSIX_GOODIES
 		if (!strcmp(arg, "--detach")) {
 			detach = 1;
 			log_syslog = 1;
@@ -1093,6 +1105,7 @@ int main(int argc, char **argv)
 			group_name = arg + 8;
 			continue;
 		}
+#endif
 		if (!prefixcmp(arg, "--enable=")) {
 			enable_service(arg + 9, 1);
 			continue;
@@ -1127,14 +1140,17 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);
 
+#ifndef NO_POSIX_GOODIES
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
+#endif
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
 
+#ifndef NO_POSIX_GOODIES
 	if (group_name && !user_name)
 		die("--group supplied without --user");
 
@@ -1146,13 +1162,14 @@ int main(int argc, char **argv)
 		if (!group_name)
 			gid = pass->pw_gid;
 		else {
-			group = getgrnam(group_name);
+			struct group *group = getgrnam(group_name);
 			if (!group)
 				die("group not found - %s", group_name);
 
 			gid = group->gr_gid;
 		}
 	}
+#endif
 
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
@@ -1168,11 +1185,13 @@ int main(int argc, char **argv)
 		return execute();
 	}
 
+#ifndef NO_POSIX_GOODIES
 	if (detach) {
 		daemonize();
 		loginfo("Ready to rumble");
 	}
 	else
+#endif
 		sanitize_stdfds();
 
 	if (pid_file)
@@ -1185,5 +1204,5 @@ int main(int argc, char **argv)
 	cld_argv[argc] = "--serve";
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, pass, gid);
+	return serve(&listen_addr, listen_port);
 }
-- 
1.7.3.1.199.g72340
