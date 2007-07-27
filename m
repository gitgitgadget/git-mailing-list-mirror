From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make verify-tag a builtin.
Date: Fri, 27 Jul 2007 06:07:34 +0200
Message-ID: <46A96F86.2030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEH7H-0001RH-QW
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbXG0EHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXG0EHp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:07:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:13510 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXG0EHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:07:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so644959ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 21:07:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LbZFpoOkMFUEkjvQtkSSNOhXnbXFxcxgLHld/ZwNfH+0yfP3hPyuZj9E2j+06prNT27GK48ljXNE2Kv5a/gcFvSZQj7NzjYTZIev+roJD+6tLC/3wR6Qqqgd2fxkUk4w+kKw485n+yxSEAJdn+/ECpVk49dJYhP6Wra7yAGH+4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=m1dTJiGcJ645XXAqEttfwu/lWa3ewHcdVfA6j1Kz3Orx5SBvudNUwdg47sOUcxdJcQtxDgGmM+MuX2KDFcCqIgrQyjG0q5b1mbcRx9z+uuTdT6Bbq3uIj4nyLGNphOg5A79BfOZGyVLqZr6jm6ADoWZR4kE2y6ahuTQOvtoFEA0=
Received: by 10.66.218.3 with SMTP id q3mr2651594ugg.1185509262537;
        Thu, 26 Jul 2007 21:07:42 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id f6sm8886911nfh.2007.07.26.21.07.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jul 2007 21:07:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53878>

This replaces "git-verify-tag.sh" with "builtin-verify-tag.c".

Testing relies on the "git tag -v" tests calling this command.

A temporary file is needed when calling to gpg, because git is
already creating detached signatures (gpg option -b) to sign tags
(instead of leaving gpg to add the signature to the file by itself),
and those signatures need to be supplied in a separate file to be
verified by gpg.

The program uses git_mkstemp to create that temporary file needed by
gpg, instead of the previously used "$GIT_DIR/.tmp-vtag", in order to
allow the command to be used in read-only repositories, and also
prevent other instances of git to read or remove the same file.

Signal SIGPIPE is ignored because the program sometimes was
terminated because that signal when writing the input for gpg.

The command now can receive many tag names to be verified.
Documentation is also updated here to reflect this new behaviour.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   This resend is addressing the questions commented in:
   http://thread.gmane.org/gmane.comp.version-control.git/53376

   Function verify_tag is designed to be easily reused in the
   upcoming "builtin-tag.c", although it is declared static now.

 Documentation/git-verify-tag.txt                   |    4 +-
 Makefile                                           |    3 +-
 builtin-verify-tag.c                               |  111 ++++++++++++++++++++
 builtin.h                                          |    1 +
 .../examples/git-verify-tag.sh                     |    0
 git.c                                              |    1 +
 6 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 builtin-verify-tag.c
 rename git-verify-tag.sh => contrib/examples/git-verify-tag.sh (100%)

diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 48d17fd..ac7fb19 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -3,11 +3,11 @@ git-verify-tag(1)

 NAME
 ----
-git-verify-tag - Check the GPG signature of tag
+git-verify-tag - Check the GPG signature of tags

 SYNOPSIS
 --------
-'git-verify-tag' <tag>
+'git-verify-tag' <tag>...

 DESCRIPTION
 -----------
diff --git a/Makefile b/Makefile
index 73b487f..c6ed79f 100644
--- a/Makefile
+++ b/Makefile
@@ -206,7 +206,7 @@ SCRIPT_SH = \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
-	git-tag.sh git-verify-tag.sh \
+	git-tag.sh \
 	git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
@@ -367,6 +367,7 @@ BUILTIN_OBJS = \
 	builtin-update-ref.o \
 	builtin-upload-archive.o \
 	builtin-verify-pack.o \
+	builtin-verify-tag.o \
 	builtin-write-tree.o \
 	builtin-show-ref.o \
 	builtin-pack-refs.o
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
new file mode 100644
index 0000000..11b971e
--- /dev/null
+++ b/builtin-verify-tag.c
@@ -0,0 +1,111 @@
+/*
+ * Builtin "git verify-tag"
+ *
+ * Copyright (c) 2007 Carlos Rica <jasampler@gmail.com>
+ *
+ * Based on git-verify-tag.sh
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "tag.h"
+#include "run-command.h"
+#include <signal.h>
+
+static const char builtin_verify_tag_usage[] =
+		"git-verify-tag [-v|--verbose] <tag>...";
+
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+
+static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
+{
+	struct child_process gpg;
+	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
+	char path[PATH_MAX], *eol;
+	size_t len;
+	int fd, ret;
+
+	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
+	if (fd < 0)
+		return error("could not create temporary file '%s': %s",
+						path, strerror(errno));
+	if (write_in_full(fd, buf, size) < 0)
+		return error("failed writing temporary file '%s': %s",
+						path, strerror(errno));
+	close(fd);
+
+	/* find the length without signature */
+	len = 0;
+	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE "\n")) {
+		eol = memchr(buf + len, '\n', size - len);
+		len += eol ? eol - (buf + len) + 1 : size - len;
+	}
+	if (verbose)
+		write_in_full(1, buf, len);
+
+	memset(&gpg, 0, sizeof(gpg));
+	gpg.argv = args_gpg;
+	gpg.in = -1;
+	gpg.out = 1;
+	args_gpg[2] = path;
+	if (start_command(&gpg))
+		return error("could not run gpg.");
+
+	write_in_full(gpg.in, buf, len);
+	close(gpg.in);
+	gpg.close_in = 0;
+	ret = finish_command(&gpg);
+
+	unlink(path);
+	free(path);
+
+	return ret;
+}
+
+static int verify_tag(const char *name, int verbose)
+{
+	enum object_type type;
+	unsigned char sha1[20];
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	if (get_sha1(name, sha1))
+		return error("tag '%s' not found.", name);
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				name, typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.", name);
+
+	ret = run_gpg_verify(buf, size, verbose);
+
+	free(buf);
+	return ret;
+}
+
+int cmd_verify_tag(int argc, const char **argv, const char *prefix)
+{
+	int i = 1, verbose = 0, had_error = 0;
+
+	git_config(git_default_config);
+
+	if (argc == 1)
+		usage(builtin_verify_tag_usage);
+
+	if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
+		verbose = 1;
+		i++;
+	}
+
+	/* sometimes the program was terminated because this signal
+	 * was received in the process of writing the gpg input: */
+	signal(SIGPIPE, SIG_IGN);
+	while (i < argc)
+		if (verify_tag(argv[i++], verbose))
+			had_error = 1;
+	return had_error;
+}
diff --git a/builtin.h b/builtin.h
index 4cc228d..cb860a0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -76,6 +76,7 @@ extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
+extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
diff --git a/git-verify-tag.sh b/contrib/examples/git-verify-tag.sh
similarity index 100%
rename from git-verify-tag.sh
rename to contrib/examples/git-verify-tag.sh
diff --git a/git.c b/git.c
index a647f9c..1dfe120 100644
--- a/git.c
+++ b/git.c
@@ -368,6 +368,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
+		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
-- 
1.5.0
