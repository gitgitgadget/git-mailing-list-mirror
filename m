From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Add init-serve, the remote side of "git init
 --remote=host:path"
Date: Sat, 28 Feb 2009 13:12:23 -0800
Message-ID: <7vsklye05k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 22:14:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdWVa-0000Ry-JB
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 22:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbZB1VMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 16:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbZB1VMi
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 16:12:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZB1VMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 16:12:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D9212277;
	Sat, 28 Feb 2009 16:12:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2229B2276; Sat,
 28 Feb 2009 16:12:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8524EC52-05DC-11DE-B8E7-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111792>

This is still sprinkled with a few NEEDSWORK, but should be good enough
to start developing and testing the requesting side of the protocol pair.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile             |    1 +
 builtin-init-serve.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h            |    1 +
 git.c                |    1 +
 4 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 builtin-init-serve.c

diff --git a/Makefile b/Makefile
index 0675c43..c0d0cfd 100644
--- a/Makefile
+++ b/Makefile
@@ -544,6 +544,7 @@ BUILTIN_OBJS += builtin-gc.o
 BUILTIN_OBJS += builtin-grep.o
 BUILTIN_OBJS += builtin-help.o
 BUILTIN_OBJS += builtin-init-db.o
+BUILTIN_OBJS += builtin-init-serve.o
 BUILTIN_OBJS += builtin-log.o
 BUILTIN_OBJS += builtin-ls-files.o
 BUILTIN_OBJS += builtin-ls-remote.o
diff --git a/builtin-init-serve.c b/builtin-init-serve.c
new file mode 100644
index 0000000..9d701e7
--- /dev/null
+++ b/builtin-init-serve.c
@@ -0,0 +1,117 @@
+#include "cache.h"
+#include "builtin.h"
+#include "pkt-line.h"
+#include "run-command.h"
+#include "strbuf.h"
+
+/*
+ * The other end gives the command line arguments to "git init"
+ * one by one over pkt-line, and then expects a message back.
+ *
+ * We need to read them all even if we know we will reject
+ * the request before responding.
+ */
+static int serve(const char *errmsg)
+{
+	int argc = 0;
+	const char *argv[64];
+
+	argv[argc++] = "git";
+	argv[argc++] = "init";
+	for (;;) {
+		char line[1000];
+		int len;
+
+		len = packet_read_line(0, line, sizeof(line));
+		if (!len)
+			break;
+
+		if (!*errmsg) {
+			/*
+			 * Notice any command line arguments that we
+			 * may not want to invoke "git init" with when
+			 * we are doing this remotely, and reject the
+			 * request.
+			 */
+			if (!prefixcmp(line, "--template=")) {
+				static char err[1000];
+				snprintf(err, sizeof(err),
+					 "forbidden option to 'git init': %s",
+					 line);
+				errmsg = err;
+			} else if (argc + 1 < ARRAY_SIZE(argv))
+				argv[argc++] = xstrdup(line);
+			else
+				errmsg = "arg list too long";
+		}
+	}
+
+	if (*errmsg)
+		packet_write(1, "ng init - %s\n", errmsg);
+	else {
+		/*
+		 * NEEDSWORK: refactor this list in the codepath for
+		 * local pipe transport in connect.c and use it here
+		 * and also over there.
+		 */
+		const char *sanitize_env[] = {
+			ALTERNATE_DB_ENVIRONMENT,
+			DB_ENVIRONMENT,
+			GIT_DIR_ENVIRONMENT,
+			GIT_WORK_TREE_ENVIRONMENT,
+			GRAFT_ENVIRONMENT,
+			INDEX_ENVIRONMENT,
+			NULL
+		};
+		struct child_process child;
+
+		argv[argc] = NULL;
+		memset(&child, 0, sizeof(child));
+		child.argv = argv;
+		child.env = sanitize_env;
+
+		/*
+		 * NEEDSWORK: I do not currently think it is worth it,
+		 * but this might want to set up and use the sideband
+		 * to capture and send output from the child back to
+		 * the requestor.  At least this comment needs to be removed
+		 * once we make the decision.
+		 */
+		child.stdout_to_stderr = 1;
+
+		/*
+		 * NEEDSWORK: we might want to distinguish various
+		 * error codes from run_command() and return different
+		 * messages back.  I am too lazy to be bothered.
+		 */
+		if (run_command(&child))
+			packet_write(1, "ng init\n");
+		else
+			packet_write(1, "ok init\n");
+	}
+	return 0;
+}
+
+int cmd_init_serve(int argc, const char **argv, const char *prefix)
+{
+	const char *dir;
+	struct strbuf errmsg = STRBUF_INIT;
+
+	if (argc != 2)
+		return serve("init /p/a/th");
+	dir = argv[1];
+
+	/*
+	 * Perhaps lift avoid_alias() from daemon.c and check
+	 * dir with it, as programs like gitosis may
+	 * want to restrict the arguments to this service.
+	 */
+	if (mkdir(dir, 0777))
+		strbuf_addf(&errmsg,
+			    "cannot mkdir('%s'): %s", dir, strerror(errno));
+	else if (chdir(dir))
+		strbuf_addf(&errmsg,
+			    "cannot chdir('%s'): %s", dir, strerror(errno));
+
+	return serve(errmsg.buf);
+}
diff --git a/builtin.h b/builtin.h
index 1495cf6..e9f9ffb 100644
--- a/builtin.h
+++ b/builtin.h
@@ -59,6 +59,7 @@ extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
+extern int cmd_init_serve(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index c2b181e..1df8584 100644
--- a/git.c
+++ b/git.c
@@ -311,6 +311,7 @@ static void handle_internal_command(int argc, const char **argv)
 #endif
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
+		{ "init-serve", cmd_init_serve },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-- 
1.6.2.rc2.99.g9f3bb
