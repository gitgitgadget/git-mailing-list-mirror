From: Jonathan Callen <abcd@gentoo.org>
Subject: [PATCH 1/3] Support building on systems without poll(2)
Date: Thu, 27 May 2010 04:19:42 -0400
Message-ID: <1274948384-167-2-git-send-email-abcd@gentoo.org>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Cc: mduft@gentoo.org, jrnieder@gmail.com,
	Jonathan Callen <abcd@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 10:20:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYKF-0004F7-Bt
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab0E0IUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 04:20:00 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45282 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0E0IT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 04:19:57 -0400
Received: from localhost.localdomain (pool-72-86-43-250.clppva.fios.verizon.net [72.86.43.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 76FED1B405A;
	Thu, 27 May 2010 08:19:54 +0000 (UTC)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147836>

Some systems do not have sys/poll.h or poll(2).  Don't build
git-daemon, git-upload-archive, or git-upload-pack on such systems.

Signed-off-by: Jonathan Callen <abcd@gentoo.org>
---
 Makefile          |   21 ++++++++++++++++-----
 builtin.h         |    2 ++
 git-compat-util.h |    2 ++
 git.c             |    2 ++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 07cab8f..4b36534 100644
--- a/Makefile
+++ b/Makefile
@@ -62,6 +62,8 @@ all::
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
 #
+# Define NO_POLL if you don't have poll in the C library, or it does not work.
+#
 # Define NO_LIBGEN_H if you don't have libgen.h.
 #
 # Define NEEDS_LIBGEN if your libgen needs -lgen when linking
@@ -386,7 +388,6 @@ PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
-PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
@@ -434,9 +435,7 @@ OTHER_PROGRAMS = git$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
-BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
-BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
@@ -722,7 +721,6 @@ BUILTIN_OBJS += builtin/unpack-objects.o
 BUILTIN_OBJS += builtin/update-index.o
 BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
-BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
@@ -1162,8 +1160,17 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS += -lz
 
+ifndef NO_POLL
+	BUILTIN_OBJS += builtin/upload-archive.o
+	PROGRAM_OBJS += upload-pack.o
+	BINDIR_PROGRAMS_NEED_X += git-upload-archive
+	BINDIR_PROGRAMS_NEED_X += git-upload-pack
+endif
+
 ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAM_OBJS += daemon.o
+	ifndef NO_POLL
+		PROGRAM_OBJS += daemon.o
+	endif
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
@@ -1322,6 +1329,10 @@ ifdef OLD_ICONV
 	BASIC_CFLAGS += -DOLD_ICONV
 endif
 
+ifdef NO_POLL
+	BASIC_CFLAGS += -DNO_POLL
+endif
+
 ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
diff --git a/builtin.h b/builtin.h
index 5c887ef..165a748 100644
--- a/builtin.h
+++ b/builtin.h
@@ -127,7 +127,9 @@ extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
+#ifdef NO_POLL
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
+#endif
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/git-compat-util.h b/git-compat-util.h
index edf352d..c5188e5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -94,7 +94,9 @@
 #include <utime.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
+#ifndef NO_POLL
 #include <sys/poll.h>
+#endif
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
diff --git a/git.c b/git.c
index 99f0363..8c081db 100644
--- a/git.c
+++ b/git.c
@@ -390,7 +390,9 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
+#ifndef NO_POLL
 		{ "upload-archive", cmd_upload_archive },
+#endif
 		{ "var", cmd_var },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
-- 
1.7.1
