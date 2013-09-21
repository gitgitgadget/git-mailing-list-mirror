From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 1/7] Add support for ruby commands
Date: Sat, 21 Sep 2013 13:48:09 -0500
Message-ID: <1379789295-18519-2-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:53:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJZ-0000Wi-7z
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab3IUSxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:53:52 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:53317 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3IUSxw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:53:52 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so2143699obc.10
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyifpPIAKCl4tvfG58NTyRVs2znVWVn6MP/CQjOSUHg=;
        b=GrzQIVdfE7KbRznHHfFDFCXhaTEdZ+Iw9ICSjbaf9KAIMY3Pt8XhU6aaM8v8QDGTyK
         PZoYKAww+y5W+ugc/+r884HksTvLTj2FL5PndsMh40P3P37gixLHAZysXUxSC6/5ZvQL
         VDxbgvbkmFpFEKyBS1R2VC+WySBkbje3EpMQic4Ab3TkXgs1xvFuwgFc8VbZCZ2m/lpC
         nwqkAzZj2B9lwiVLrU2swlM0j/9P6ACiiZFsJ/qwmH7pWJqyCQY1KmW3c40Qj/LQHt/3
         c+J+Tmjz41tSoFck+yEb2NxrT10wIBRJXmU3qujH3IEKgD19UJHosuEG7GNB9XAk188O
         kh9A==
X-Received: by 10.60.51.7 with SMTP id g7mr11986064oeo.6.1379789631593;
        Sat, 21 Sep 2013 11:53:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm8631751obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:53:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235136>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile |  4 ++++
 cache.h  |  2 ++
 git.c    |  3 +++
 ruby.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100644 ruby.c

diff --git a/Makefile b/Makefile
index 3588ca1..7cbcbcb 100644
--- a/Makefile
+++ b/Makefile
@@ -899,6 +899,7 @@ LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
+LIB_OBJS += ruby.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/annotate.o
@@ -1502,6 +1503,9 @@ ifneq (,$(XDL_FAST_HASH))
 	BASIC_CFLAGS += -DXDL_FAST_HASH
 endif
 
+EXTLIBS += $(shell pkg-config --libs ruby-2.0)
+BASIC_CFLAGS += $(shell pkg-config --cflags ruby-2.0)
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/cache.h b/cache.h
index 85b544f..4b1abd4 100644
--- a/cache.h
+++ b/cache.h
@@ -1393,4 +1393,6 @@ int stat_validity_check(struct stat_validity *sv, const char *path);
  */
 void stat_validity_update(struct stat_validity *sv, int fd);
 
+extern void handle_ruby_command(int argc, const char **argv);
+
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 2025f77..0e1d97d 100644
--- a/git.c
+++ b/git.c
@@ -499,6 +499,9 @@ static int run_argv(int *argcp, const char ***argv)
 		/* See if it's an internal command */
 		handle_internal_command(*argcp, *argv);
 
+		/* See if it's a ruby command */
+		handle_ruby_command(*argcp, *argv);
+
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
diff --git a/ruby.c b/ruby.c
new file mode 100644
index 0000000..5701753
--- /dev/null
+++ b/ruby.c
@@ -0,0 +1,48 @@
+#include "cache.h"
+#include "exec_cmd.h"
+
+#undef NORETURN
+#undef PATH_SEP
+
+#include <ruby.h>
+
+static const char *commands[] = {
+};
+
+static void run_ruby_command(int argc, const char **argv)
+{
+	const char *cmd = argv[0];
+	static char buf[PATH_MAX + 1];
+	const char *dir;
+	char *args[argc + 2];
+	void *node;
+	VALUE prefix;
+	int i;
+
+	dir = git_exec_path();
+	snprintf(buf, PATH_MAX, "%s/git-%s.rb", dir, cmd);
+
+	ruby_init();
+
+	prefix = Qnil;
+	rb_define_variable("$prefix", &prefix);
+
+	args[0] = "git";
+	args[1] = buf;
+	for (i = 0; i < argc; i++)
+		args[i + 2] = (char*)argv[i];
+	node = ruby_options(argc + 2, args);
+
+	exit(ruby_run_node(node));
+}
+
+void handle_ruby_command(int argc, const char **argv)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		if (strcmp(commands[i], argv[0]))
+			continue;
+
+		run_ruby_command(argc, argv);
+	}
+}
-- 
1.8.4-fc
