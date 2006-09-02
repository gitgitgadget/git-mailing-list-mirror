From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sat, 2 Sep 2006 17:24:45 +0200
Message-ID: <cda58cb80609020824ja524444uc9fe65ea2e4febba@mail.gmail.com>
References: <44F977C0.4060901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Sep 02 17:25:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJXMe-0004zf-Au
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 17:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWIBPYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 11:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWIBPYt
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 11:24:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:14811 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750840AbWIBPYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 11:24:47 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1176381ugc
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 08:24:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsD+VZrrT0hYS3mACrfNvneyoEkLBlfVkJ5fBg+NrCKN6Xp2aVeDPgcXX+AjXxV9M4QsIMgB6t/1MFLYyTD9HI/E0hhG6K+FFqXpKOCLclJ5n6tSxljdmSPP46VA8/8yZvQbHK/qx6kSiouNnwzqgJ0tj3Kuti0+U6zptC0R+qs=
Received: by 10.66.252.4 with SMTP id z4mr1790021ugh;
        Sat, 02 Sep 2006 08:24:45 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Sat, 2 Sep 2006 08:24:45 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44F977C0.4060901@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26339>

Hi,

2006/9/2, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> git-archive-tree is a command to make tar and ZIP archives of a git tree.
> It helps prevent a proliferation of git-{format}-tree commands.  This is
> useful e.g. for remote archive fetching because we only need to write a
> single upload and a single download program that simply pass on the
> format option to git-archive-tree.

OK, Rene you beat me. I started to cook up something this morning but
had no time to go further.

I sent a starting implementation just because it seems complementary
to the one you sent a couple hours ago: it supports '--remote' option.
But it does _not_ have path spec support you introduced. I think it's
cool feature but I would have to dig into git's internal to implement
it, which would have taken me a while.

>From now, do you think we should import my work into your version or
'vice verca' ?

-- >8 --

Subject: [PATCH] Add git-archive (other implementation)

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 .gitignore          |    1
 Makefile            |    1
 builtin-archive.c   |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h           |    1
 generate-cmdlist.sh |    1
 git.c               |    1
 6 files changed, 176 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78cb671..a3e7ca1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,7 @@ git-apply
 git-applymbox
 git-applypatch
 git-archimport
+git-archive
 git-bisect
 git-branch
 git-cat-file
diff --git a/Makefile b/Makefile
index 164dbcf..8d963e0 100644
--- a/Makefile
+++ b/Makefile
@@ -266,6 +266,7 @@ LIB_OBJS = \
 BUILTIN_OBJS = \
 	builtin-add.o \
 	builtin-apply.o \
+	builtin-archive.o \
 	builtin-cat-file.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
diff --git a/builtin-archive.c b/builtin-archive.c
new file mode 100644
index 0000000..47898ee
--- /dev/null
+++ b/builtin-archive.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright (c) 2006 Franck Bui-Huu
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+#include "pkt-line.h"
+
+#define MAX_ARGS	32
+
+static const char *extra_argv[MAX_ARGS];
+static int extra_argc = 1;
+static const char *base;
+static const char *remote;
+
+static const char archive_usage[] = \
+"git-archive -f <format> [extra] [--remote=<repo>] [--prefix=<base>]
<tree-ish>";
+
+/* archiver's options */
+#define NEED_BASE	(1<<0)
+
+struct archiver_info {
+	const char *name;
+	int (*fn)(int argc, const char **argv, const char *prefix);
+	int options;
+};
+
+static struct archiver_info archivers[] = {
+	{ "tar", cmd_tar_tree, NEED_BASE },
+	{ "zip", cmd_zip_tree, NEED_BASE },
+};
+
+static int run_remote_archiver(struct archiver_info *ar, char *url)
+{
+	int fd[2], len, rv;
+	char buf[1024];
+	pid_t pid;
+
+	/*
+	 * For now, remote operations does not support extra options
+	 */
+	if (extra_argc > 2)
+		die("Remote operation does not support extra options yet.");
+
+	sprintf(buf, "git-upload-%s", ar->name);
+	pid = git_connect(fd, url, buf);
+	if (pid < 0)
+		return pid;
+
+	packet_write(fd[1], "want %s\n", extra_argv[1]);
+	if (base)
+		packet_write(fd[1], "base %s\n", base);
+	packet_flush(fd[1]);
+
+	len = packet_read_line(fd[0], buf, sizeof(buf));
+	if (!len)
+		die("git-archive: expected ACK/NAK, got EOF");
+	if (buf[len-1] == '\n')
+		buf[--len] = 0;
+	if (strcmp(buf, "ACK")) {
+		if (len > 5 && !strncmp(buf, "NACK ", 5))
+			die("git-archive: NACK %s", buf + 5);
+		die("git-archive: protocol error");
+	}
+	if (packet_read_line(fd[0], buf, sizeof(buf)))
+		die("git-archive: expected a flush");
+
+	/* Now, start reading from fd[0] and spit it out to stdout */
+	rv = copy_fd(fd[0], 1);
+	close(fd[0]);
+
+	return !!(rv | finish_connect(pid));
+}
+
+void insert_extra_option(const char *option, int idx)
+{
+	const char **argv = extra_argv;	/* some shortcuts... */
+	int argc = extra_argc;
+
+	if (argc > MAX_ARGS - 2)
+		die("Too many args");
+	if (idx > MAX_ARGS - 1)
+		die("idx overflow extra_argv buffer !");
+
+	/* insert at last position ? */
+	if (idx < 0) {
+		argv[argc++] = option;
+		argv[argc] = NULL;
+	} else {
+		argv += idx;
+		memmove(argv + 1, argv, argc * sizeof(*argv));
+		*argv = option;
+	}
+	extra_argc++;
+}
+
+int run_archiver(const char *format)
+{
+	struct archiver_info *ar;
+	char buf[32];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
+		ar = &archivers[i];
+		if (strcmp(format, ar->name))
+			continue;
+		goto found;
+	}
+	return error("Unknown archive format '%s'\n", format);
+found:
+	if (remote) {
+		char *url = strdup(remote+9);	/* --remote=<repo> */
+		return run_remote_archiver(ar, url);
+	}
+	if (base) {
+		i = 1;
+		if (ar->options & NEED_BASE) {
+			base += 9; /* --prefix=<base> */
+			i = -1;
+		}
+		insert_extra_option(base, i);
+	}
+	sprintf(buf, "%s-tree", ar->name);
+	extra_argv[0] = buf;
+
+	return ar->fn(extra_argc, extra_argv, setup_git_directory());
+}
+
+static int show_list_formats(void)
+{
+	int i;
+	
+	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
+		printf("%s\n", archivers[i].name);
+	}
+	return 0;
+}
+
+int cmd_archive(int argc, const char **argv, const char *prefix)
+{
+	static const char *format;
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
+			return show_list_formats();
+		}
+		if (!strncmp(arg, "--format=", 9)) {
+			format = arg+9;
+			continue;
+		}
+		if (!strncmp(arg, "--prefix=", 9)) {
+			base = arg;
+			continue;
+		}
+		if (!strncmp(arg, "--remote=", 9)) {
+			remote = arg;
+			continue;
+		}
+		if (extra_argc > MAX_ARGS - 2)
+			die("Too many options");
+		extra_argv[extra_argc++] = arg;
+	}
+
+	if (!format)
+		die("You must specify an archive format");
+
+	return run_archiver(format);
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..50852cd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -15,6 +15,7 @@ extern int write_tree(unsigned char *sha

 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
+extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const
char *prefix);
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index ec1eda2..5450918 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -12,6 +12,7 @@ struct cmdname_help common_cmds[] = {"
 sort <<\EOF |
 add
 apply
+archive
 bisect
 branch
 checkout
diff --git a/git.c b/git.c
index 403fb3a..ddb1620 100644
--- a/git.c
+++ b/git.c
@@ -218,6 +218,7 @@ static void handle_internal_command(int
 	} commands[] = {
 		{ "add", cmd_add, RUN_SETUP },
 		{ "apply", cmd_apply },
+		{ "archive", cmd_archive },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
-- 
1.4.2.g8ed9-dirty

-- 
VGER BF report: U 0.5
