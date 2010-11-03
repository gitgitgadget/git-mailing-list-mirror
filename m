From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 16/16] daemon: opt-out on features that require posix
Date: Wed,  3 Nov 2010 17:31:34 +0100
Message-ID: <1288801894-1168-17-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGY-0002aC-78
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab0KCQcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:33 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab0KCQcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:31 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cv5OoA8oeSRj1bgRkB820M0IphforAqtgds5NYTns1M=;
        b=nE3UXCJSZ/SXxOPAJ9eCrwtPhS8/O1kxG6rkiJc8WjaD5lFAniGoUr/b6c0MY1ORs5
         WeMIOWtuEEVHGrIoXQnpI7LjZ31ra9hybavHea0M+3wxpY/eVrlwVq3nIiCGe1TcIhvf
         IZxItzkvKHdY0800eYpLFa3nhmrFG+/3zjNqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k0VdruAbIiCDHnxSbDnv10ClNwl2SInwr8NxccWy8VUiZ0nLoBcHFy4EzL2+ATuTxf
         0GYyFCgLqWwlr/JNN5qiViloyYKNVlSB3mPJEfRbf1HuzWzZ6aSysoW27NthBdSAIgTJ
         AJn+kHmsW08PF6LGIf71KfuF8uoCRVpzXNurk=
Received: by 10.213.28.205 with SMTP id n13mr4754122ebc.5.1288801950736;
        Wed, 03 Nov 2010 09:32:30 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id b52sm6705198eei.19.2010.11.03.09.32.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160615>

Windows does not supply the POSIX-functions fork(), setuuid(), setgid(),
setsid() and initgroups(). Error out if --user or --detach is specified
when if so.

MinGW doesn't have prototypes and headers for inet_ntop and inet_pton,
so include our implementation instead. MSVC does, so avoid doing so
there.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |   14 ++++++---
 daemon.c |   88 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 29 deletions(-)

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
index 485bec5..299201f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -934,6 +934,62 @@ static void sanitize_stdfds(void)
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
@@ -951,6 +1007,7 @@ static void daemonize(void)
 	close(2);
 	sanitize_stdfds();
 }
+#endif
 
 static void store_pid(const char *path)
 {
@@ -961,7 +1018,8 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }
 
-static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
+static int serve(struct string_list *listen_addr, int listen_port,
+    struct credentials *cred)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
@@ -970,10 +1028,7 @@ static int serve(struct string_list *listen_addr, int listen_port, struct passwd
 		die("unable to allocate any listen sockets on port %u",
 		    listen_port);
 
-	if (pass && gid &&
-	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
-	     setuid(pass->pw_uid)))
-		die("cannot drop privileges");
+	drop_privileges(cred);
 
 	return service_loop(&socklist);
 }
@@ -985,9 +1040,7 @@ int main(int argc, char **argv)
 	int serve_mode = 0, inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
-	struct passwd *pass = NULL;
-	struct group *group;
-	gid_t gid = 0;
+	struct credentials *cred = NULL;
 	int i;
 
 	git_extract_argv0_path(argv[0]);
@@ -1133,21 +1186,8 @@ int main(int argc, char **argv)
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
@@ -1181,5 +1221,5 @@ int main(int argc, char **argv)
 	cld_argv[argc] = "--serve";
 	cld_argv[argc+1] = NULL;
 
-	return serve(&listen_addr, listen_port, pass, gid);
+	return serve(&listen_addr, listen_port, cred);
 }
-- 
1.7.3.2.161.gd6e00
