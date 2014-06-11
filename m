From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] verify-commit: scriptable commit signature verification
Date: Wed, 11 Jun 2014 21:48:48 +0200
Message-ID: <42816455-e873-4c81-a630-0be1869e9233@email.android.com>
References: <cover.1402063795.git.git@drmicha.warpmail.net> <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 21:49:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuoWi-0001fc-4H
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 21:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbaFKTtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 15:49:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53226 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbaFKTtd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 15:49:33 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A150F217F8
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 15:49:31 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 11 Jun 2014 15:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=in-reply-to:references:mime-version
	:content-transfer-encoding:content-type:subject:from:date:to
	:message-id; s=smtpout; bh=teHyGNBzI9sjo3MISS6kOA8oqLo=; b=KU8nS
	0/kfcF8vQCOxHFUjiol0dKS2BIWShSrvSOcyVcxrtLLbtD5VWfhBPOh5avPgqDKu
	XY56EWJiazg/RBYVC+raP4yTgBqLz6Bb5sQUF055ZN9jjDJz4Jv6/bcajKdlvzgI
	IauXEMr4FwrR/742Q/5V8zELCMGKoMKxakNq38=
X-Sasl-enc: LVVmCL273vpjf8ifHXePgUnC/KWFmCRQUBFCOLoxE+Ov 1402516171
Received: from SevenOfNexus.fritz.box (unknown [88.71.250.201])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1C601680135
	for <git@vger.kernel.org>; Wed, 11 Jun 2014 15:49:30 -0400 (EDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <cc5fd1d554e0357dfb514e3f9ad100d98c16d4d5.1402063796.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251383>



On 6. Juni 2014 16:15:28 MESZ, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>Commit signatures can be verified using "git show -s --show-signature"
>or the "%G?" pretty format and parsing the output, which is well suited
>for user inspection, but not for scripting.
>
>Provide a command "verify-commit" which is analogous to "verify-tag":
>It
>returns 0 for good signatures and non-zero otherwise, has the gpg
>output
>on stderr and (optionally) the commit object on stdout, sans the
>signature, just like "verify-tag" does.
>
>Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>---
> Documentation/git-verify-commit.txt | 28 +++++++++++
> Makefile                            |  1 +
> builtin.h                           |  1 +
>builtin/verify-commit.c             | 98
>+++++++++++++++++++++++++++++++++++++
> command-list.txt                    |  1 +
> git.c                               |  1 +
> 6 files changed, 130 insertions(+)
> create mode 100644 Documentation/git-verify-commit.txt
> create mode 100644 builtin/verify-commit.c
>
>diff --git a/Documentation/git-verify-commit.txt
>b/Documentation/git-verify-commit.txt
>new file mode 100644
>index 0000000..dcd7803
>--- /dev/null
>+++ b/Documentation/git-verify-commit.txt
>@@ -0,0 +1,28 @@
>+git-verify-commit(1)
>+=================

That line will need 3 more "=" thanks to asciidoc stubbornness.

v2 plus the tests coming tomorrow when my dev box is online again.

>+
>+NAME
>+----
>+git-verify-commit - Check the GPG signature of commits
>+
>+SYNOPSIS
>+--------
>+[verse]
>+'git verify-commit' <commit>...
>+
>+DESCRIPTION
>+-----------
>+Validates the gpg signature created by 'git commit -S'.
>+
>+OPTIONS
>+-------
>+-v::
>+--verbose::
>+	Print the contents of the commit object before validating it.
>+
>+<commit>...::
>+	SHA-1 identifiers of Git commit objects.
>+
>+GIT
>+---
>+Part of the linkgit:git[1] suite
>diff --git a/Makefile b/Makefile
>index 07ea105..b92418d 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -999,6 +999,7 @@ BUILTIN_OBJS += builtin/update-ref.o
> BUILTIN_OBJS += builtin/update-server-info.o
> BUILTIN_OBJS += builtin/upload-archive.o
> BUILTIN_OBJS += builtin/var.o
>+BUILTIN_OBJS += builtin/verify-commit.o
> BUILTIN_OBJS += builtin/verify-pack.o
> BUILTIN_OBJS += builtin/verify-tag.o
> BUILTIN_OBJS += builtin/write-tree.o
>diff --git a/builtin.h b/builtin.h
>index c47c110..5d91f31 100644
>--- a/builtin.h
>+++ b/builtin.h
>@@ -128,6 +128,7 @@ extern int cmd_update_server_info(int argc, const
>char **argv, const char *prefi
>extern int cmd_upload_archive(int argc, const char **argv, const char
>*prefix);
>extern int cmd_upload_archive_writer(int argc, const char **argv, const
>char *prefix);
> extern int cmd_var(int argc, const char **argv, const char *prefix);
>+extern int cmd_verify_commit(int argc, const char **argv, const char
>*prefix);
>extern int cmd_verify_tag(int argc, const char **argv, const char
>*prefix);
>extern int cmd_version(int argc, const char **argv, const char
>*prefix);
>extern int cmd_whatchanged(int argc, const char **argv, const char
>*prefix);
>diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
>new file mode 100644
>index 0000000..69b7c6d
>--- /dev/null
>+++ b/builtin/verify-commit.c
>@@ -0,0 +1,98 @@
>+/*
>+ * Builtin "git commit-commit"
>+ *
>+ * Copyright (c) 2014 Michael J Gruber <git@drmicha.warpmail.net>
>+ *
>+ * Based on git-verify-tag
>+ */
>+#include "cache.h"
>+#include "builtin.h"
>+#include "commit.h"
>+#include "run-command.h"
>+#include <signal.h>
>+#include "parse-options.h"
>+#include "gpg-interface.h"
>+
>+static const char * const verify_commit_usage[] = {
>+		N_("git verify-commit [-v|--verbose] <commit>..."),
>+		NULL
>+};
>+
>+static int run_gpg_verify(const unsigned char *sha1, const char *buf,
>unsigned long size, int verbose)
>+{
>+	struct signature_check signature_check;
>+
>+	memset(&signature_check, 0, sizeof(signature_check));
>+
>+	check_commit_signature(lookup_commit(sha1), &signature_check);
>+
>+	if (verbose && signature_check.payload)
>+		fputs(signature_check.payload, stdout);
>+
>+	if (signature_check.gpg_output)
>+		fputs(signature_check.gpg_output, stderr);
>+
>+	free(signature_check.gpg_output);
>+	free(signature_check.gpg_status);
>+	free(signature_check.signer);
>+	free(signature_check.key);
>+	return signature_check.result != 'G';
>+}
>+
>+static int verify_commit(const char *name, int verbose)
>+{
>+	enum object_type type;
>+	unsigned char sha1[20];
>+	char *buf;
>+	unsigned long size;
>+	int ret;
>+
>+	if (get_sha1(name, sha1))
>+		return error("commit '%s' not found.", name);
>+
>+	type = sha1_object_info(sha1, NULL);
>+	if (type != OBJ_COMMIT)
>+		return error("%s: cannot verify a non-commit object of type %s.",
>+				name, typename(type));
>+
>+	buf = read_sha1_file(sha1, &type, &size);
>+	if (!buf)
>+		return error("%s: unable to read file.", name);
>+
>+	ret = run_gpg_verify(sha1, buf, size, verbose);
>+
>+	free(buf);
>+	return ret;
>+}
>+
>+static int git_verify_commit_config(const char *var, const char
>*value, void *cb)
>+{
>+	int status = git_gpg_config(var, value, cb);
>+	if (status)
>+		return status;
>+	return git_default_config(var, value, cb);
>+}
>+
>+int cmd_verify_commit(int argc, const char **argv, const char *prefix)
>+{
>+	int i = 1, verbose = 0, had_error = 0;
>+	const struct option verify_commit_options[] = {
>+		OPT__VERBOSE(&verbose, N_("print commit contents")),
>+		OPT_END()
>+	};
>+
>+	git_config(git_verify_commit_config, NULL);
>+
>+	argc = parse_options(argc, argv, prefix, verify_commit_options,
>+			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
>+	if (argc <= i)
>+		usage_with_options(verify_commit_usage, verify_commit_options);
>+
>+	/* sometimes the program was terminated because this signal
>+	 * was received in the process of writing the gpg input: */
>+	signal(SIGPIPE, SIG_IGN);
>+	while (i < argc)
>+		if (verify_commit(argv[i++], verbose))
>+			had_error = 1;
>+	return had_error;
>+}
>diff --git a/command-list.txt b/command-list.txt
>index cf36c3d..a3ff0c9 100644
>--- a/command-list.txt
>+++ b/command-list.txt
>@@ -132,6 +132,7 @@ git-update-server-info                 
>synchingrepositories
> git-upload-archive                      synchelpers
> git-upload-pack                         synchelpers
> git-var                                 plumbinginterrogators
>+git-verify-commit                       ancillaryinterrogators
> git-verify-pack                         plumbinginterrogators
> git-verify-tag                          ancillaryinterrogators
> gitweb                                  ancillaryinterrogators
>diff --git a/git.c b/git.c
>index 7780572..bbc3293 100644
>--- a/git.c
>+++ b/git.c
>@@ -441,6 +441,7 @@ static struct cmd_struct commands[] = {
> 	{ "upload-archive", cmd_upload_archive },
> 	{ "upload-archive--writer", cmd_upload_archive_writer },
> 	{ "var", cmd_var, RUN_SETUP_GENTLY },
>+	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
> 	{ "verify-pack", cmd_verify_pack },
> 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
> 	{ "version", cmd_version },
