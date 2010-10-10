From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 14/14] daemon: only use posix features on posix systems
Date: Sun, 10 Oct 2010 15:20:54 +0200
Message-ID: <1286716854-5744-15-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:23:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vsK-0005Oo-7i
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105Ab0JJNX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:23:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757748Ab0JJNX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:23:28 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sY7+wW6PnRyw1qahtvvIVjS/xso44qEJUJWn15l+sjU=;
        b=IsjGLxjEX9sxseiUBbdxiKAPMueNKp8S/aRQ5eRbE+npOAl1sE11ZIlFu60zqbB5+o
         asBEskaCQxG5r+VygMs6WCmg9hrylnh2jVWhpnPJlCmN87qaBIPOaRDs0M0abUg1iD3k
         SBeCI5xkzQQAkqkJ9WFL8VZtYOEN/YUb2vWgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZvPmp+1PV9fs/aXRQAW76yDcoGzEQqcJn+znoSCGhbMugaZq73slhxtZg93zJYRZEe
         HH2kW7T2ErP54iELuWftWA6E/CO4BaIPsTF/Bce8OYrm9I//dH37NpsLQrMRWzvt4TX6
         qZ1Mu7ZHIoK2fpVBSifQRh3z2p1jfwWJ/i1I8=
Received: by 10.213.35.77 with SMTP id o13mr1241620ebd.11.1286717006855;
        Sun, 10 Oct 2010 06:23:26 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id z55sm9038371eeh.21.2010.10.10.06.23.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:23:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158673>

Windows does not supply the POSIX-functions fork(), setuuid(), setgid(),
setsid() and initgroups(). Disable support for --user, --group and
--detach on platforms lacking _POSIX_VERSION.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

This might be a bit controversial; does anyone know of any systems that
implements fork(), setuuid(), setgid() and setsid() but does not define
_POSIX_VERSION? Perhaps we should have a separate makefile-switch instead?

 Makefile |    8 +++-----
 daemon.c |   43 +++++++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 42baa4d..f5992da 100644
--- a/Makefile
+++ b/Makefile
@@ -401,6 +401,7 @@ EXTRA_PROGRAMS =
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 
+PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += shell.o
@@ -1064,7 +1065,6 @@ ifeq ($(uname_S),Windows)
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -1117,7 +1117,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -1128,6 +1127,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
 	ETAGS_TARGET = ETAGS
+	NO_INET_PTON = YesPlease
+	NO_INET_NTOP = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1246,9 +1247,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAM_OBJS += daemon.o
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
diff --git a/daemon.c b/daemon.c
index 54bbec2..56a9bed 100644
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
+#ifdef _POSIX_VERSION
+"           [--detach] [--user=user [--group=group]]\n"
+#endif
 "           [directory...]";
 
 /* List of acceptable pathname prefixes */
@@ -593,7 +595,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, int addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -672,7 +674,7 @@ static char *get_addrstr(int *port, struct sockaddr *addr)
 }
 
 char **cld_argv;
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = { 0 };
 	char *addrstr, envbuf[300] = "REMOTE_ADDR=";
@@ -908,7 +910,7 @@ static int service_loop(struct socketlist *socklist)
 		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
@@ -938,6 +940,7 @@ static void sanitize_stdfds(void)
 		close(fd);
 }
 
+#ifdef _POSIX_VERSION
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
+#ifdef _POSIX_VERSION
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
 
+#ifdef _POSIX_VERSION
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
+#ifdef _POSIX_VERSION
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
+#ifdef _POSIX_VERSION
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
 
+#ifdef _POSIX_VERSION
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
+#endif
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
 
+#ifdef _POSIX_VERSION
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
@@ -1180,11 +1197,13 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
+#ifdef _POSIX_VERSION
 	if (detach) {
 		daemonize();
 		loginfo("Ready to rumble");
 	}
 	else
+#endif
 		sanitize_stdfds();
 
 	if (pid_file)
@@ -1197,5 +1216,5 @@ int main(int argc, char **argv)
 	cld_argv[argc] = "--serve";
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, pass, gid);
+	return serve(&listen_addr, listen_port);
 }
-- 
1.7.3.1.51.ge462f.dirty
