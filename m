From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 2/2] New remote helper: git-remote-ext
Date: Mon, 28 Jun 2010 10:11:51 +0300
Message-ID: <1277709111-11230-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1277709111-11230-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 09:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT8Ui-0006ys-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 09:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab0F1HKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 03:10:50 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:48277 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab0F1HKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 03:10:48 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id C256C18D4FB
	for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:10:46 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A003BABFA79; Mon, 28 Jun 2010 10:10:46 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id A7563158A65
	for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:10:45 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1277709111-11230-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149817>

Invokes specified command and directs smart transport streams to its
stdin/stdout. Handy for e.g. invoking ssh with some one-off parameters.
---
 Makefile             |    1 +
 builtin.h            |    1 +
 builtin/remote-ext.c |  300 ++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c                |    1 +
 4 files changed, 303 insertions(+), 0 deletions(-)
 create mode 100644 builtin/remote-ext.c

diff --git a/Makefile b/Makefile
index ad53b52..88e752f 100644
--- a/Makefile
+++ b/Makefile
@@ -702,6 +702,7 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
+BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
diff --git a/builtin.h b/builtin.h
index af60b28..eb9074d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -139,5 +139,6 @@ extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
+extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
new file mode 100644
index 0000000..e9852ca
--- /dev/null
+++ b/builtin/remote-ext.c
@@ -0,0 +1,300 @@
+#include "git-compat-util.h"
+#include "transport.h"
+#include "run-command.h"
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+
+/*
+ * URL syntax:
+ *	'command [arg1 [arg2 [...]]]'	Invoke command with given arguments.
+ *	Special characters:
+ *	'\ ': Literal space in argument.
+ *	'\\': Literal backslash.
+ *	'\S': Name of service (git-upload-pack/git-upload-archive/
+ *		git-receive-pack.
+ *	'\s': Same as \s, but with possible git- prefix stripped.
+ *	'\G': Only allowed as first 'character' of argument. Do not pass this
+ *		Argument to command, instead send this as name of repository
+ *		in in-line git://-style request (also activates sending this
+ *		style of request).
+ *	'\V': Only allowed as first 'character' of argument. Used in
+ *		conjunction with '\G': Do not pass this argument to command,
+ *		instead send this as vhost in git://-style request (note: does
+ *		not activate sending git:// style request).
+ */
+
+char* git_req = NULL;
+char* git_req_vhost = NULL;
+
+static char *strip_escapes(const char *str, const char *service,
+	const char **next)
+{
+	char *ret;
+	size_t rpos = 0;
+	size_t wpos = 0;
+	size_t finallen = 0;
+	int escape = 0;
+	char special = 0;
+	size_t pslen = 0;
+	size_t pSlen = 0;
+	size_t psoff = 0;
+
+	/* Calculate prefix length for \s and lengths for \s and \S */
+	if (!strncmp(service, "git-", 4))
+		psoff = 4;
+	pSlen = strlen(service);
+	pslen = pSlen - psoff;
+
+	/* Calculate output length and start of next argument. */
+	while (str[rpos] && (escape || str[rpos] != ' ')) {
+		if (escape) {
+			switch (str[rpos]) {
+			case ' ':
+			case '\\':
+				finallen++;
+				break;
+			case 's':
+				finallen += pslen;
+				break;
+			case 'S':
+				finallen += pSlen;
+				break;
+			case 'G':
+			case 'V':
+				special = str[rpos];
+				if (rpos == 1)
+					break;
+				/* Fall-through to error. */
+			default:
+				die("Bad remote-ext placeholder '\\%c'.",
+					str[rpos]);
+			}
+			escape = 0;
+		} else
+			switch (str[rpos]) {
+			case '\\':
+				escape = 1;
+				break;
+			default:
+				finallen++;
+				break;
+			}
+		rpos++;
+	}
+	if (escape && !str[rpos])
+		die("remote-ext command has incomplete placeholder");
+	*next = str + rpos;
+	if (**next == ' ')
+		++*next;	/* Skip over space */
+
+	/*
+	 * Do the actual placeholder substitution. The string will be short
+	 * enough not to overflow integers.
+	 */
+	ret = xmalloc(finallen + 1);
+	rpos = special ? 2 : 0;		/* Skip first 2 bytes in specials. */
+	escape = 0;
+	while (str[rpos] && (escape || str[rpos] != ' ')) {
+		if (escape) {
+			switch(str[rpos]) {
+			case ' ':
+			case '\\':
+				ret[wpos++] = str[rpos];
+				break;
+			case 's':
+				strcpy(ret + wpos, service + psoff);
+				wpos += pslen;
+				break;
+			case 'S':
+				strcpy(ret + wpos, service);
+				wpos += pSlen;
+				break;
+			}
+			escape = 0;
+		} else
+			switch(str[rpos]) {
+			case '\\':
+				escape = 1;
+				break;
+			default:
+				ret[wpos++] = str[rpos];
+				break;
+			}
+		rpos++;
+	}
+	ret[wpos] = 0;
+	switch(special) {
+	case 'G':
+		git_req = ret;
+		return NULL;
+	case 'V':
+		git_req_vhost = ret;
+		return NULL;
+	default:
+		return ret;
+	}
+}
+
+/* Should be enough... */
+#define MAXARGUMENTS 256
+
+static const char **parse_argv(const char *arg, const char *service)
+{
+	int arguments = 0;
+	int i;
+	char** ret;
+	char *(temparray[MAXARGUMENTS + 1]);
+
+	while (*arg) {
+		char* ret;
+		if (arguments == MAXARGUMENTS)
+			die("remote-ext command has too many arguments");
+		ret = strip_escapes(arg, service, &arg);
+		if (ret)
+			temparray[arguments++] = ret;
+	}
+
+	ret = xcalloc(arguments + 1, sizeof(char*));
+	for (i = 0; i < arguments; i++)
+		ret[i] = temparray[i];
+
+	return (const char**)ret;
+}
+
+static void send_git_request(int stdin_fd, const char *serv, const char *repo,
+	const char *vhost)
+{
+	size_t bufferspace;
+	size_t wpos = 0;
+	size_t spos = 0;
+	size_t tmp;
+	char* buffer;
+
+	/*
+	 * Request needs 12 bytes extra if there is vhost (xxxx \0host=\0) and
+	 * 6 bytes extra (xxxx \0) if there is no vhost.
+	 */
+	if (vhost)
+		bufferspace = strlen(serv) + strlen(repo) + strlen(vhost) + 12;
+	else
+		bufferspace = strlen(serv) + strlen(repo) + 6;
+
+	if (bufferspace > 0xFFFF)
+		die("Request too large to send");
+	buffer = xmalloc(bufferspace);
+
+	/* Packet length. */
+	sprintf(buffer + wpos, "%04x", (unsigned)bufferspace);
+	wpos += 4;
+
+	/* Service. */
+	tmp = strlen(serv);
+	memcpy(buffer + wpos, serv, tmp);
+	wpos += tmp;
+
+	/* Space. */
+	buffer[wpos++] = ' ';
+
+	/* Repo. */
+	tmp = strlen(repo);
+	memcpy(buffer + wpos, repo, tmp);
+	wpos += tmp;
+
+	/* NUL. */
+	buffer[wpos++] = '\0';
+
+	/* Vhost if any. */
+	if (vhost) {
+		/* Header name. */
+		strcpy(buffer + wpos, "host=");
+		wpos += 5;
+
+		/* Actual vhost */
+		tmp = strlen(vhost);
+		memcpy(buffer + wpos, vhost, tmp);
+		wpos += tmp;
+
+		/* NUL. */
+		buffer[wpos++] = '\0';
+	}
+
+	/* Send the request */
+	while (spos < wpos) {
+		ssize_t r;
+		r = write(stdin_fd, buffer + spos, wpos - spos);
+		if (r < 0 && errno != EINTR && errno != EAGAIN &&
+			errno != EWOULDBLOCK)
+			die_errno("Failed to send request");
+		else if (r < 0)
+			continue;	/* Try again. */
+		else
+			spos += r;
+	}
+
+	free(buffer);
+}
+
+static int run_child(const char *arg, const char *service)
+{
+	int r;
+	struct child_process child;
+
+	memset(&child, 0, sizeof(child));
+	child.in = -1;
+	child.out = -1;
+	child.err = 0;
+	child.argv = parse_argv(arg, service);
+
+	if (start_command(&child) < 0)
+		die("Can't run specified command");
+
+	if (git_req)
+		send_git_request(child.in, service, git_req, git_req_vhost);
+
+	r = bidirectional_transfer_loop(child.out, child.in);
+	if (!r)
+		r = finish_command(&child);
+	else
+		finish_command(&child);
+	return r;
+}
+
+#define MAXCOMMAND 4096
+
+static int command_loop(const char *child)
+{
+	char buffer[MAXCOMMAND];
+
+	while (1) {
+		if (!fgets(buffer, MAXCOMMAND - 1, stdin))
+			exit(0);
+		//Strip end of line characters.
+		while (isspace((unsigned char)buffer[strlen(buffer) - 1]))
+			buffer[strlen(buffer) - 1] = 0;
+
+		if (!strcmp(buffer, "capabilities")) {
+			printf("*connect\n\n");
+			fflush(stdout);
+		} else if (!strncmp(buffer, "connect ", 8)) {
+			printf("\n");
+			fflush(stdout);
+			return run_child(child, buffer + 8);
+		} else {
+			fprintf(stderr, "Bad command");
+			return 1;
+		}
+	}
+}
+
+int cmd_remote_ext(int argc, const char **argv, const char *prefix)
+{
+	if (argc < 3) {
+		fprintf(stderr, "Error: URL missing");
+		exit(1);
+	}
+
+	return command_loop(argv[2]);
+}
diff --git a/git.c b/git.c
index 91de3d6..2cc0826 100644
--- a/git.c
+++ b/git.c
@@ -368,6 +368,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "remote-ext", cmd_remote_ext, 0 },
 		{ "remote-fd", cmd_remote_fd, 0 },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config },
-- 
1.7.1.335.g93705.dirty
