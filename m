From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v5 3/3] git-remote-ext
Date: Fri,  8 Oct 2010 21:40:00 +0300
Message-ID: <1286563200-7270-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 20:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4HmR-00034e-FC
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 20:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023Ab0JHSd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 14:33:56 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:51735 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0JHSdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 14:33:53 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 61BFD13C328
	for <git@vger.kernel.org>; Fri,  8 Oct 2010 21:33:51 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A040115B670; Fri, 08 Oct 2010 21:33:51 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 32B8B2BD45
	for <git@vger.kernel.org>; Fri,  8 Oct 2010 21:33:50 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
In-Reply-To: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158523>

This remote helper invokes external command and passes raw smart transport
stream through it. This is useful for instance for invoking ssh with
one-off odd options, connecting to git services in unix domain
sockets, in abstract namespace, using TLS or other secure protocols,
etc...

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 .gitignore                       |    1 +
 Documentation/git-remote-ext.txt |  125 +++++++++++++++++++
 Makefile                         |    1 +
 builtin.h                        |    1 +
 builtin/remote-ext.c             |  243 ++++++++++++++++++++++++++++++++++++++
 git.c                            |    1 +
 6 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-ext.txt
 create mode 100644 builtin/remote-ext.c

diff --git a/.gitignore b/.gitignore
index 89f37f4..87b833c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,7 @@
 /git-remote-ftp
 /git-remote-ftps
 /git-remote-fd
+/git-remote-ext
 /git-remote-testgit
 /git-repack
 /git-replace
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
new file mode 100644
index 0000000..8fb260b
--- /dev/null
+++ b/Documentation/git-remote-ext.txt
@@ -0,0 +1,125 @@
+git-remote-ext(1)
+=================
+
+NAME
+----
+git-remote-ext - Bridge smart transport to external command.
+
+SYNOPSIS
+--------
+git remote add nick "ext::<command>[ <arguments>...]"
+
+DESCRIPTION
+-----------
+This remote helper uses the specified 'program' to connect
+to a remote git server.
+
+Data written to stdin of this specified 'program' is assumed
+to be sent to git:// server, git-upload-pack, git-receive-pack
+or git-upload-archive (depending on situation), and data read
+from stdout of this program is assumed to be received from
+the same service.
+
+Command and arguments are separated by unescaped space.
+
+The following sequences have a special meaning:
+
+'% '::
+	Literal space in command or argument.
+
+'%%'::
+	Literal percent sign.
+
+'%s'::
+	Replaced with name (receive-pack, upload-pack, or
+	upload-archive) of the service git wants to invoke.
+
+'%S'::
+	Replaced with long name (git-receive-pack,
+	git-upload-pack, or git-upload-archive) of the service
+	git wants to invoke.
+
+'%G<repository>' (as argument)::
+	This argument will not be passed to 'program'. Instead, it
+	will cause helper to start by sending git:// service request to
+	remote side with service field set to approiate value and
+	repository field set to <repository>. Default is not to send
+	such request.
++
+This is useful if remote side is git:// server accessed over
+some tunnel.
+
+'%V<host>' (as argument)::
+	This argument will not be passed to 'program'. Instead it sets
+	the vhost field in git:// service request. Default is not to
+	send vhost in such request (if sent).
+
+ENVIRONMENT VARIABLES:
+----------------------
+
+GIT_TRANSLOOP_DEBUG::
+	If set, prints debugging information about various reads/writes.
+
+ENVIRONMENT VARIABLES PASSED TO COMMAND:
+----------------------------------------
+
+GIT_EXT_SERVICE::
+	Set to long name (git-upload-pack, etc...) of service helper needs
+	to invoke.
+
+GIT_EXT_SERVICE_NOPREFIX::
+	Set to long name (upload-pack, etc...) of service helper needs
+	to invoke.
+
+
+EXAMPLES:
+---------
+This remote helper is transparently used by git when
+you use commands such as "git fetch <URL>", "git clone <URL>",
+, "git push <URL>" or "git remote add nick <URL>", where <URL>
+begins with `ext::`.  Examples:
+
+"ext::ssh -i /home/foo/.ssh/somekey user&#64;host.example %S 'foo/repo'"::
+	Like host.example:foo/repo, but use /home/foo/.ssh/somekey as
+	keypair and user as user on remote side. This avoids needing to
+	edit .ssh/config.
+
+"ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
+	Represents repository with path /somerepo accessable over
+	git protocol at abstract namespace address /git-server.
+
+"ext::git-server-alias foo %G/repo"::
+	Represents a repository with path /repo accessed using the
+	helper program "git-server-alias foo".  The path to the
+	repository and type of request are not passed on the command
+	line but as part of the protocol stream, as usual with git://
+	protocol.
+
+"ext::git-server-alias foo %G/repo %Vfoo"::
+	Represents a repository with path /repo accessed using the
+	helper program "git-server-alias foo".  The hostname for the
+	remote server passed in the protocol stream will be "foo"
+	(this allows multiple virtual git servers to share a
+	link-level address).
+
+"ext::git-server-alias foo %G/repo% with% spaces %Vfoo"::
+	Represents a repository with path '/repo with spaces' accessed
+	using the helper program "git-server-alias foo".  The hostname for
+	the remote server passed in the protocol stream will be "foo"
+	(this allows multiple virtual git servers to share a
+	link-level address).
+
+"ext::git-ssl foo.example /bar"::
+	Represents a repository accessed using the helper program
+	"git-ssl foo.example /bar".  The type of request can be
+	determined by the helper using environment variables (see
+	above).
+
+Documentation
+--------------
+Documentation by Ilari Liusvaara, Jonathan Nieder and the git list
+<git@vger.kernel.org>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 7da54d7..9909ca1 100644
--- a/Makefile
+++ b/Makefile
@@ -728,6 +728,7 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
+BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
diff --git a/builtin.h b/builtin.h
index 1a816e1..a4bba61 100644
--- a/builtin.h
+++ b/builtin.h
@@ -108,6 +108,7 @@ extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
+extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
new file mode 100644
index 0000000..b2041ff
--- /dev/null
+++ b/builtin/remote-ext.c
@@ -0,0 +1,243 @@
+#include "git-compat-util.h"
+#include "transport.h"
+#include "run-command.h"
+
+/*
+ * URL syntax:
+ *	'command [arg1 [arg2 [...]]]'	Invoke command with given arguments.
+ *	Special characters:
+ *	'% ': Literal space in argument.
+ *	'%%': Literal percent sign.
+ *	'%S': Name of service (git-upload-pack/git-upload-archive/
+ *		git-receive-pack.
+ *	'%s': Same as \s, but with possible git- prefix stripped.
+ *	'%G': Only allowed as first 'character' of argument. Do not pass this
+ *		Argument to command, instead send this as name of repository
+ *		in in-line git://-style request (also activates sending this
+ *		style of request).
+ *	'%V': Only allowed as first 'character' of argument. Used in
+ *		conjunction with '%G': Do not pass this argument to command,
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
+	size_t rpos = 0;
+	int escape = 0;
+	char special = 0;
+	size_t pslen = 0;
+	size_t pSlen = 0;
+	size_t psoff = 0;
+	struct strbuf ret = STRBUF_INIT;
+
+	/* Calculate prefix length for \s and lengths for \s and \S */
+	if (!strncmp(service, "git-", 4))
+		psoff = 4;
+	pSlen = strlen(service);
+	pslen = pSlen - psoff;
+
+	/* Pass the service to command. */
+	setenv("GIT_EXT_SERVICE", service, 1);
+	setenv("GIT_EXT_SERVICE_NOPREFIX", service + psoff, 1);
+
+	/* Scan the length of argument. */
+	while (str[rpos] && (escape || str[rpos] != ' ')) {
+		if (escape) {
+			switch (str[rpos]) {
+			case ' ':
+			case '%':
+			case 's':
+			case 'S':
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
+			escape = (str[rpos] == '%');
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
+	rpos = special ? 2 : 0;		/* Skip first 2 bytes in specials. */
+	escape = 0;
+	while (str[rpos] && (escape || str[rpos] != ' ')) {
+		if (escape) {
+			switch(str[rpos]) {
+			case ' ':
+			case '%':
+				strbuf_addch(&ret, str[rpos]);
+				break;
+			case 's':
+				strbuf_addstr(&ret, service + psoff);
+				break;
+			case 'S':
+				strbuf_addstr(&ret, service);
+				break;
+			}
+			escape = 0;
+		} else
+			switch(str[rpos]) {
+			case '%':
+				escape = 1;
+				break;
+			default:
+				strbuf_addch(&ret, str[rpos]);
+				break;
+			}
+		rpos++;
+	}
+	switch(special) {
+	case 'G':
+		git_req = strbuf_detach(&ret, NULL);
+		return NULL;
+	case 'V':
+		git_req_vhost = strbuf_detach(&ret, NULL);
+		return NULL;
+	default:
+		return strbuf_detach(&ret, NULL);
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
+	/* Make the packet. */
+	wpos = sprintf(buffer, "%04x%s %s%c", (unsigned)bufferspace,
+		serv, repo, 0);
+
+	/* Add vhost if any. */
+	if (vhost)
+		sprintf(buffer + wpos, "host=%s%c", vhost, 0);
+
+	/* Send the request */
+	if (write_in_full(stdin_fd, buffer, bufferspace) < 0)
+		die_errno("Failed to send request");
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
+		/* Strip end of line characters. */
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
index b7b96b0..e95a1ba 100644
--- a/git.c
+++ b/git.c
@@ -374,6 +374,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "remote-ext", cmd_remote_ext },
 		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
-- 
1.7.3.1.53.gb58bd
