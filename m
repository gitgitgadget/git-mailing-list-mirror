From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/5] verify-commit: scriptable commit signature verification
Date: Mon, 23 Jun 2014 09:05:49 +0200
Message-ID: <f344d5a5b1d336e1d7a3c4c0f225a3f3fc62beac.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:06:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WyyKc-0000rM-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 09:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbaFWHGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 03:06:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59896 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593AbaFWHGB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2014 03:06:01 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1EBD020C3A;
	Mon, 23 Jun 2014 03:05:57 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 23 Jun 2014 03:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=8n
	lm8rDaSwiROi51l1Hk2rM0mlk=; b=aJB6TmzB7Zz+HJGRbMXkETqFSSXn+GUlTA
	D0QK+1aCG/CzAfvDTTekZUM87AGL9ThE0Ex8OL/qwXei+9aBRKmGRJNkUl8GKZ2a
	5HyGCziDYvZKa2c9OgbYPp6MKaGspuB5Juzjhqctm7exsK2+7wxSmJiTlsnu6pG5
	kTb7eT4T8=
X-Sasl-enc: ujt/Br/Zn50mIQCRpTeBEo9WK+53vUEBhb+Up/A8cdqO 1403507157
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 152406801C0;
	Mon, 23 Jun 2014 03:05:56 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.426.g37dbf84
In-Reply-To: <cover.1402655838.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1403506792.git.git@drmicha.warpmail.net>
References: <cover.1403506792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252324>

Commit signatures can be verified using "git show -s --show-signature"
or the "%G?" pretty format and parsing the output, which is well suited
for user inspection, but not for scripting.

Provide a command "verify-commit" which is analogous to "verify-tag": It
returns 0 for good signatures and non-zero otherwise, has the gpg output
on stderr and (optionally) the commit object on stdout, sans the
signature, just like "verify-tag" does.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-verify-commit.txt | 28 +++++++++++
 Makefile                            |  1 +
 builtin.h                           |  1 +
 builtin/verify-commit.c             | 93 +++++++++++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 git.c                               |  1 +
 6 files changed, 125 insertions(+)
 create mode 100644 Documentation/git-verify-commit.txt
 create mode 100644 builtin/verify-commit.c

diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
new file mode 100644
index 0000000..9413e28
--- /dev/null
+++ b/Documentation/git-verify-commit.txt
@@ -0,0 +1,28 @@
+git-verify-commit(1)
+====================
+
+NAME
+----
+git-verify-commit - Check the GPG signature of commits
+
+SYNOPSIS
+--------
+[verse]
+'git verify-commit' <commit>...
+
+DESCRIPTION
+-----------
+Validates the gpg signature created by 'git commit -S'.
+
+OPTIONS
+-------
+-v::
+--verbose::
+	Print the contents of the commit object before validating it.
+
+<commit>...::
+	SHA-1 identifiers of Git commit objects.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 07ea105..b92418d 100644
--- a/Makefile
+++ b/Makefile
@@ -999,6 +999,7 @@ BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
 BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/var.o
+BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o
diff --git a/builtin.h b/builtin.h
index c47c110..5d91f31 100644
--- a/builtin.h
+++ b/builtin.h
@@ -128,6 +128,7 @@ extern int cmd_update_server_info(int argc, const char **argv, const char *prefi
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
+extern int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
new file mode 100644
index 0000000..b0f8504
--- /dev/null
+++ b/builtin/verify-commit.c
@@ -0,0 +1,93 @@
+/*
+ * Builtin "git commit-commit"
+ *
+ * Copyright (c) 2014 Michael J Gruber <git@drmicha.warpmail.net>
+ *
+ * Based on git-verify-tag
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "commit.h"
+#include "run-command.h"
+#include <signal.h>
+#include "parse-options.h"
+#include "gpg-interface.h"
+
+static const char * const verify_commit_usage[] = {
+		N_("git verify-commit [-v|--verbose] <commit>..."),
+		NULL
+};
+
+static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, int verbose)
+{
+	struct signature_check signature_check;
+
+	memset(&signature_check, 0, sizeof(signature_check));
+
+	check_commit_signature(lookup_commit(sha1), &signature_check);
+
+	if (verbose && signature_check.payload)
+		fputs(signature_check.payload, stdout);
+
+	if (signature_check.gpg_output)
+		fputs(signature_check.gpg_output, stderr);
+
+	signature_check_clear(&signature_check);
+	return signature_check.result != 'G';
+}
+
+static int verify_commit(const char *name, int verbose)
+{
+	enum object_type type;
+	unsigned char sha1[20];
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	if (get_sha1(name, sha1))
+		return error("commit '%s' not found.", name);
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.", name);
+	if (type != OBJ_COMMIT)
+		return error("%s: cannot verify a non-commit object of type %s.",
+				name, typename(type));
+
+	ret = run_gpg_verify(sha1, buf, size, verbose);
+
+	free(buf);
+	return ret;
+}
+
+static int git_verify_commit_config(const char *var, const char *value, void *cb)
+{
+	int status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
+	return git_default_config(var, value, cb);
+}
+
+int cmd_verify_commit(int argc, const char **argv, const char *prefix)
+{
+	int i = 1, verbose = 0, had_error = 0;
+	const struct option verify_commit_options[] = {
+		OPT__VERBOSE(&verbose, N_("print commit contents")),
+		OPT_END()
+	};
+
+	git_config(git_verify_commit_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, verify_commit_options,
+			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
+	if (argc <= i)
+		usage_with_options(verify_commit_usage, verify_commit_options);
+
+	/* sometimes the program was terminated because this signal
+	 * was received in the process of writing the gpg input: */
+	signal(SIGPIPE, SIG_IGN);
+	while (i < argc)
+		if (verify_commit(argv[i++], verbose))
+			had_error = 1;
+	return had_error;
+}
diff --git a/command-list.txt b/command-list.txt
index cf36c3d..a3ff0c9 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -132,6 +132,7 @@ git-update-server-info                  synchingrepositories
 git-upload-archive                      synchelpers
 git-upload-pack                         synchelpers
 git-var                                 plumbinginterrogators
+git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 gitweb                                  ancillaryinterrogators
diff --git a/git.c b/git.c
index 7780572..bbc3293 100644
--- a/git.c
+++ b/git.c
@@ -441,6 +441,7 @@ static struct cmd_struct commands[] = {
 	{ "upload-archive", cmd_upload_archive },
 	{ "upload-archive--writer", cmd_upload_archive_writer },
 	{ "var", cmd_var, RUN_SETUP_GENTLY },
+	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
-- 
2.0.0.426.g37dbf84
