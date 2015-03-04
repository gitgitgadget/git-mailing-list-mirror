From: Amate Yolande <yolandeamate@gmail.com>
Subject: [PATCH] Adds configuration options for some commonly used
 command-line options (GSOC micro-project)
Date: Thu, 5 Mar 2015 00:59:48 +0100
Message-ID: <CAFAMDXbY6szmQ-gLB0_j2cYRVHCsJfszw2XU16eb6i5NJPX_pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 01:00:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJCx-0008K4-H7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbbCEAAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:00:01 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:40371 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbbCDX7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 18:59:49 -0500
Received: by wevk48 with SMTP id k48so6200829wev.7
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 15:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=C7BnGPaRK38+TZBK7hOwWvawFE7G5/qi9T5ObhvpOPU=;
        b=XxKPS+9QR/Ah6CCuuA+g8UdqqVLPnHTt7/Y1OyQKNLqBERwAkw4ujoTU8bGlCIm03s
         YYU4HlFrrveP5u1LgJz9lGMLMBnv4PUvlr5AYNTlIPjQxhmdiMEUnxpBaSj1a/7nrAoz
         AZIAjNvN3RZPx+BoSHFpbaG3TbT3mgwBL0QrE2ArNjx28MRLW0sEvJoYYuE+SCeFeTFT
         hhuKWHIBLh+9qyFo6WBPyD0O+up3crI2G1AFA0TmZf8CQHUsuRek33uDdSNH9KkB1FRi
         l8jaOVPZpHDC49XjiT+qcEHShpg1X+PFiMFt85yj4s1udd/zfHORpJ8uZYW0QQh4q344
         2uGw==
X-Received: by 10.180.80.230 with SMTP id u6mr60484452wix.69.1425513588534;
 Wed, 04 Mar 2015 15:59:48 -0800 (PST)
Received: by 10.27.206.135 with HTTP; Wed, 4 Mar 2015 15:59:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264795>

	This is a patch for my work on one of the micro projects, as I intend
to apply for the Google Summer of Code 2015 under the Git community.
This patch gives the user the oppotunity to specify configuration
options for some commonly used command-line options for exampel:
	git config defopt.am 'am -3'
---
 Makefile |    1 +
 defopt.c |   24 ++++++++++++++++++++++++
 git.c    |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 defopt.c

diff --git a/Makefile b/Makefile
index 2320de5..e713e23 100644
--- a/Makefile
+++ b/Makefile
@@ -789,6 +789,7 @@ LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
+LIB_OBJS += defopt.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
diff --git a/defopt.c b/defopt.c
new file mode 100644
index 0000000..b4fa9e2
--- /dev/null
+++ b/defopt.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+
+static const char *defopt_key;
+static char *defopt_val;
+
+static int defopt_lookup_cb(const char *k, const char *v, void *cb)
+{
+	const char *name;
+	if (skip_prefix(k, "defopt.", &name) && !strcmp(name, defopt_key)) {
+		if (!v)
+			return config_error_nonbool(k);
+		defopt_val = xstrdup(v);
+		return 0;
+	}
+	return 0;
+}
+
+char *defopt_lookup(const char *defopt)
+{
+	defopt_key = defopt;
+	defopt_val = NULL;
+	git_config(defopt_lookup_cb, NULL);
+	return defopt_val;
+}
diff --git a/git.c b/git.c
index 9c49519..4b556e1 100644
--- a/git.c
+++ b/git.c
@@ -223,6 +223,59 @@ static int handle_options(const char ***argv, int
*argc, int *envchanged)
 	return (*argv) - orig_argv;
 }

+static int handle_defopt(int *argcp, const char ***argv)
+{	
+	int envchanged = 0, ret = 0, saved_errno = errno;
+	const char *subdir;
+	int count, option_count;
+	const char **new_argv;
+	const char *defopt_command;
+	char *defopt_string;
+	int unused_nongit;
+
+	subdir = setup_git_directory_gently(&unused_nongit);
+
+	defopt_command = (*argv)[0];
+	defopt_string = defopt_lookup(defopt_command);
+	if (defopt_string) {
+		
+		count = split_cmdline(defopt_string, &new_argv);
+		if (count < 0)
+			return;
+		option_count = handle_options(&new_argv, &count, &envchanged);
+		
+		memmove(new_argv - option_count, new_argv,
+				count * sizeof(char *));
+		new_argv -= option_count;
+
+		if (count < 1)
+			return;
+
+		if (strcmp(defopt_command, new_argv[0]))
+			return;
+
+		trace_argv_printf(new_argv,
+				  "trace: defopt: %s =>",
+				  defopt_command);
+
+		new_argv = xrealloc(new_argv, sizeof(char *) *
+				    (count + *argcp));
+		/* insert after command name */
+		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
+
+		*argv = new_argv;
+		*argcp += count - 1;
+
+	}
+
+	if (subdir && chdir(subdir))
+		die_errno("Cannot change to '%s'", subdir);
+
+	errno = saved_errno;
+
+}
+
+
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
@@ -517,6 +570,9 @@ static void handle_builtin(int argc, const char **argv)
 		argv[1] = argv[0];
 		argv[0] = cmd = "help";
 	}
+	
+	if(is_builtin(cmd) && argc == 1)
+		handle_defopt(&argc, &argv);

 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
-- 
	Signed-off-by: Yolande Amate <yolandeamate@gmail.com>
1.7.10.4
