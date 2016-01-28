From: Matthias Asshauer <mha1993@live.de>
Subject: [PATCH 1/2] stash--helper: implement "git stash--helper"
Date: Thu, 28 Jan 2016 20:36:05 +0000
Message-ID: <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
References: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:45:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtRj-0007n3-OP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 21:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966993AbcA1Upg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 15:45:36 -0500
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:38468
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966982AbcA1Upe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 15:45:34 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2016 15:45:34 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1454013365;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=5k6izX/2X/0Lr+Jh4Ff5DufhpRruZLw5xZe4JrKP6vc=;
	b=VPID38hnyK/n9qW25w1t3oxEy1k83lAE3ovcuUH7fwCa3RE+3omZXcfXI7lTYgM0
	NPJtyDPuKvpLxLKypFmir9pkHN9KAWHIwSMZCmyG9ZASehyQShcMBLWFiQQwQbNen/j
	n4nlRyJT7M/LWQ3v2prr9kVPmZ3RfoY9iWHbCI3Y=
In-Reply-To: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
X-SES-Outgoing: 2016.01.28-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285028>

=46rom: Matthias A=C3=9Fhauer <mha1993@live.de>

This patch implements a new "git stash--helper" builtin plumbing
command that will be used to migrate "git-stash.sh" to C.

We start by implementing only the "--non-patch" option that will
handle the core part of the non-patch stashing.

Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
---
 Makefile                |  2 ++
 builtin.h               |  1 +
 builtin/stash--helper.c | 13 ++++++++++
 git.c                   |  1 +
 stash.c                 | 65 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 stash.h                 | 11 +++++++++
 6 files changed, 93 insertions(+)
 create mode 100644 builtin/stash--helper.c
 create mode 100644 stash.c
 create mode 100644 stash.h

diff --git a/Makefile b/Makefile
index fc2f1ab..88c07ea 100644
--- a/Makefile
+++ b/Makefile
@@ -792,6 +792,7 @@ LIB_OBJS +=3D shallow.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D split-index.o
+LIB_OBJS +=3D stash.o
 LIB_OBJS +=3D strbuf.o
 LIB_OBJS +=3D streaming.o
 LIB_OBJS +=3D string-list.o
@@ -913,6 +914,7 @@ BUILTIN_OBJS +=3D builtin/send-pack.o
 BUILTIN_OBJS +=3D builtin/shortlog.o
 BUILTIN_OBJS +=3D builtin/show-branch.o
 BUILTIN_OBJS +=3D builtin/show-ref.o
+BUILTIN_OBJS +=3D builtin/stash--helper.o
 BUILTIN_OBJS +=3D builtin/stripspace.o
 BUILTIN_OBJS +=3D builtin/submodule--helper.o
 BUILTIN_OBJS +=3D builtin/symbolic-ref.o
diff --git a/builtin.h b/builtin.h
index 6b95006..f1c8b39 100644
--- a/builtin.h
+++ b/builtin.h
@@ -118,6 +118,7 @@ extern int cmd_send_pack(int argc, const char **arg=
v, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *pr=
efix);
+extern int cmd_stash__helper(int argc, const char **argv, const char *=
prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_stripspace(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_submodule__helper(int argc, const char **argv, const ch=
ar *prefix);
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
new file mode 100644
index 0000000..542e782
--- /dev/null
+++ b/builtin/stash--helper.c
@@ -0,0 +1,13 @@
+#include "../stash.h"
+#include <string.h>
+
+static const char builtin_stash__helper_usage[] =3D {
+	"Usage: git stash--helper --non-patch <tmp_indexfile> <i_tree>"
+};
+
+int cmd_stash__helper(int argc, const char **argv, const char *prefix)
+{
+	if (argc =3D=3D 4 && !strcmp("--non-patch", argv[1]))
+		return stash_non_patch(argv[2], argv[3], prefix);
+	usage(builtin_stash__helper_usage);
+}
diff --git a/git.c b/git.c
index da278c3..9829ee8 100644
--- a/git.c
+++ b/git.c
@@ -470,6 +470,7 @@ static struct cmd_struct commands[] =3D {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
diff --git a/stash.c b/stash.c
new file mode 100644
index 0000000..c3d6e67
--- /dev/null
+++ b/stash.c
@@ -0,0 +1,65 @@
+#include "stash.h"
+#include "strbuf.h"
+
+static int prepare_update_index_argv(struct argv_array *args,
+	struct strbuf *buf)
+{
+	struct strbuf **bufs, **b;
+
+	bufs =3D strbuf_split(buf, '\0');
+	for (b =3D bufs; *b; b++)
+		argv_array_pushf(args, "%s", (*b)->buf);
+	argv_array_push(args, "--");
+	strbuf_list_free(bufs);
+
+	return 0;
+}
+
+int stash_non_patch(const char *tmp_indexfile, const char *i_tree,
+	const char *prefix)
+{
+	int result;
+	struct child_process read_tree =3D CHILD_PROCESS_INIT;
+	struct child_process diff =3D CHILD_PROCESS_INIT;
+	struct child_process update_index =3D CHILD_PROCESS_INIT;
+	struct child_process write_tree =3D CHILD_PROCESS_INIT;
+	struct strbuf buf =3D STRBUF_INIT;
+
+	argv_array_push(&read_tree.args, "read-tree");
+	argv_array_pushf(&read_tree.args, "--index-output=3D%s", tmp_indexfil=
e);
+	argv_array_pushl(&read_tree.args, "-m", i_tree, NULL);
+
+	argv_array_pushl(&diff.args, "diff", "--name-only", "-z", "HEAD", "--=
",
+		NULL);
+
+	argv_array_pushl(&update_index.args, "update-index", "--add",
+		"--remove", NULL);
+
+	argv_array_push(&write_tree.args, "write-tree");
+
+	read_tree.env =3D
+		diff.env =3D
+		update_index.env =3D
+		write_tree.env =3D prefix;
+
+	read_tree.use_shell =3D
+		diff.use_shell =3D
+		update_index.use_shell =3D
+		write_tree.use_shell =3D 1;
+
+	read_tree.git_cmd =3D
+		diff.git_cmd =3D
+		update_index.git_cmd =3D
+		write_tree.git_cmd =3D 1;
+
+	result =3D run_command(&read_tree) ||
+		setenv("GIT_INDEX_FILE", tmp_indexfile, 1) ||
+		capture_command(&diff, &buf, 0) ||
+		prepare_update_index_argv(&update_index.args, &buf) ||
+		run_command(&update_index) ||
+		run_command(&write_tree) ||
+		remove(tmp_indexfile);
+
+	strbuf_release(&buf);
+	return result;
+}
diff --git a/stash.h b/stash.h
new file mode 100644
index 0000000..0880456
--- /dev/null
+++ b/stash.h
@@ -0,0 +1,11 @@
+#ifndef STASH_H
+#define STASH_H
+
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "run-command.h"
+
+extern int stash_non_patch(const char *tmp_indexfile, const char *i_tr=
ee,
+	const char *prefix);
+
+#endif /* STASH_H */

--
https://github.com/git/git/pull/191
