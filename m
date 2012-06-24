From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] add 'git credential' plumbing command
Date: Sun, 24 Jun 2012 13:39:59 +0200
Message-ID: <1340538001-18625-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqr4t5j5yw.fsf@bauges.imag.fr>
Cc: peff@peff.net,
	Javier Roucher Iglesias 
	<Javier.Roucher-Iglesias@ensimag.imag.fr>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 24 13:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SilB7-0007Oz-KO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 13:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab2FXLkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jun 2012 07:40:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39576 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab2FXLkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 07:40:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5OBdjFo000422
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Jun 2012 13:39:45 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SilAt-0006PQ-CJ; Sun, 24 Jun 2012 13:40:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SilAt-0004r3-B6; Sun, 24 Jun 2012 13:40:15 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <vpqr4t5j5yw.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 24 Jun 2012 13:39:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5OBdjFo000422
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341142785.70386@BXz/hSdSU3gCSV4dElRpiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200522>

From: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>

The credential API is in C, and not available to scripting languages.
Expose the functionalities of the API by wrapping them into a new
plumbing command "git credentials".

In other words, replace the internal "test-credential" by an official Git
command.

Most documentation writen by: Jeff King <peff@peff.net>
Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 .gitignore                                  |   2 +-
 Documentation/git-credential.txt            | 136 ++++++++++++++++++++++++++++
 Documentation/technical/api-credentials.txt |  39 +-------
 Makefile                                    |   2 +-
 builtin.h                                   |   1 +
 test-credential.c => builtin/credential.c   |  20 ++--
 git.c                                       |   1 +
 t/lib-credential.sh                         |  14 ++-
 8 files changed, 163 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/git-credential.txt
 rename test-credential.c => builtin/credential.c (63%)

diff --git a/.gitignore b/.gitignore
index bf66648..c188d0b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,6 +31,7 @@
 /git-commit-tree
 /git-config
 /git-count-objects
+/git-credential
 /git-credential-cache
 /git-credential-cache--daemon
 /git-credential-store
@@ -172,7 +173,6 @@
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /test-chmtime
-/test-credential
 /test-ctype
 /test-date
 /test-delta
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
new file mode 100644
index 0000000..d5228a3
--- /dev/null
+++ b/Documentation/git-credential.txt
@@ -0,0 +1,136 @@
+git-credential(7)
+=================
+
+NAME
+----
+git-credential - retrieve and store user credentials
+
+SYNOPSIS
+--------
+------------------
+git credential <fill|approve|reject>
+------------------
+
+DESCRIPTION
+-----------
+
+Git has an internal interface for storing and retrieving credentials
+from system-specific helpers, as well as prompting the user for
+usernames and passwords. The git-credential command exposes this
+interface to scripts which may want to retrieve, store, or prompt for
+credentials in the same manner as git. The design of this scriptable
+interface models the internal C API; see
+link:technical/api-credentials.txt[the git credential API] for more
+background on the concepts.
+
+git-credential takes an "action" option on the command-line (one of
+`fill`, `approve`, or `reject`) and reads a credential description
+on stdin (see <<IOFMT,INPUT/OUTPUT FORMAT>>).
+
+If the action is `fill`, git-credential will attempt to add "username"
+and "password" attributes to the description by reading config files,
+by contacting any configured credential helpers, or by prompting the
+user. The username and password attributes of the credential
+description are then printed to stdout together with the attributes
+already provided.
+
+If the action is `approve`, git-credential will send the description
+to any configured credential helpers, which may store the credential
+for later use. 
+
+If the action is `reject`, git-credential will send the description to
+any configured credential helpers, which may erase any stored
+credential matching the description.
+
+If the action is `approve` or `reject`, no output should be emitted.
+
+TYPICAL USE OF GIT CREDENTIAL
+-----------------------------
+
+An application using git-credential will typically use `git
+credential` following these steps:
+
+  1. Generate a credential description based on the context.
++
+For example, if we want a password for
+`https://example.com/foo.git`, we might generate the following
+credential description (don't forget the blank line at the end; it
+tells `git credential` that the application finished feeding all the
+infomation it has):
+
+         protocol=https
+         host=example.com
+         path=foo.git
+
+  2. Ask git-credential to give us a username and password for this
+     description. This is done by running `git credential fill`,
+     feeding the description from step (1) to its standard input. The
+     credential will be produced on standard output, like:
+
+	username=bob
+	password=secr3t
++
+If the `git credential` knew about the password, this step may
+not have involved the user actually typing this password (the
+user may have typed a password to unlock the keychain instead,
+or no user interaction was done if the keychain was already
+unlocked) before it returned `password=secr3t`.
+
+  3. Use the credential (e.g., access the URL with the username and
+     password from step (2)), and see if it's accepted.
+
+  4. Report on the success or failure of the password. If the
+     credential allowed the operation to complete successfully, then
+     it can be marked with an "approve" action to tell `git
+     credential` to reuse it in its next invocation. If the credential
+     was rejected during the operation, use the "reject" action so
+     that `git credential` will ask for a new password in its next
+     invocation. In either case, `git credential` should be fed with
+     the credential description obtained from step (2) together with
+     the ones already provided in step (1).
+
+[[IOFMT]]
+INPUT/OUTPUT FORMAT
+-------------------
+
+`git credential` reads and/or writes (depending on the action used)
+credential information in its standard input/output. These information
+can correspond either to keys for which `git credential` will obtain
+the login/password information (e.g. host, protocol, path), or to the
+actual credential data to be obtained (login/password).
+
+The credential is split into a set of named attributes.
+Attributes are provided to the helper, one per line. Each attribute is
+specified by a key-value pair, separated by an `=` (equals) sign,
+followed by a newline. The key may contain any bytes except `=`,
+newline, or NUL. The value may contain any bytes except newline or NUL.
+In both cases, all bytes are treated as-is (i.e., there is no quoting,
+and one cannot transmit a value with newline or NUL in it). The list of
+attributes is terminated by a blank line or end-of-file.
+Git will send the following attributes (but may not send all of
+them for a given credential; for example, a `host` attribute makes no
+sense when dealing with a non-network protocol):
+
+`protocol`::
+
+	The protocol over which the credential will be used (e.g.,
+	`https`).
+
+`host`::
+
+	The remote hostname for a network credential.
+
+`path`::
+
+	The path with which the credential will be used. E.g., for
+	accessing a remote https repository, this will be the
+	repository's path on the server.
+
+`username`::
+
+	The credential's username, if we already have one (e.g., from a
+	URL, from the user, or from a previously run helper).
+
+`password`::
+
+	The credential's password, if we are asking it to be stored.
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index adb6f0c..5977b58 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -241,42 +241,9 @@ appended to its command line, which is one of:
 	Remove a matching credential, if any, from the helper's storage.
 
 The details of the credential will be provided on the helper's stdin
-stream. The credential is split into a set of named attributes.
-Attributes are provided to the helper, one per line. Each attribute is
-specified by a key-value pair, separated by an `=` (equals) sign,
-followed by a newline. The key may contain any bytes except `=`,
-newline, or NUL. The value may contain any bytes except newline or NUL.
-In both cases, all bytes are treated as-is (i.e., there is no quoting,
-and one cannot transmit a value with newline or NUL in it). The list of
-attributes is terminated by a blank line or end-of-file.
-
-Git will send the following attributes (but may not send all of
-them for a given credential; for example, a `host` attribute makes no
-sense when dealing with a non-network protocol):
-
-`protocol`::
-
-	The protocol over which the credential will be used (e.g.,
-	`https`).
-
-`host`::
-
-	The remote hostname for a network credential.
-
-`path`::
-
-	The path with which the credential will be used. E.g., for
-	accessing a remote https repository, this will be the
-	repository's path on the server.
-
-`username`::
-
-	The credential's username, if we already have one (e.g., from a
-	URL, from the user, or from a previously run helper).
-
-`password`::
-
-	The credential's password, if we are asking it to be stored.
+stream. The exact format is the same as the input/output format of the
+`git credential` plumbing command (see the section `INPUT/OUTPUT
+FORMAT` in linkgit:git-credential[7] for a detailed specification).
 
 For a `get` operation, the helper should produce a list of attributes
 on stdout in the same format. A helper is free to produce a subset, or
diff --git a/Makefile b/Makefile
index f62ca2a..d5d46d9 100644
--- a/Makefile
+++ b/Makefile
@@ -487,7 +487,6 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
-TEST_PROGRAMS_NEED_X += test-credential
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
@@ -835,6 +834,7 @@ BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
+BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
diff --git a/builtin.h b/builtin.h
index dea1643..a945a4a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -65,6 +65,7 @@ extern int cmd_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_credential(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/test-credential.c b/builtin/credential.c
similarity index 63%
rename from test-credential.c
rename to builtin/credential.c
index dee200e..c185c07 100644
--- a/test-credential.c
+++ b/builtin/credential.c
@@ -1,21 +1,18 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "credential.h"
-#include "string-list.h"
+#include "builtin.h"
 
 static const char usage_msg[] =
-"test-credential <fill|approve|reject> [helper...]";
+	"git credential [fill|approve|reject]";
 
-int main(int argc, const char **argv)
+int cmd_credential(int argc, const char **argv, const char *prefix)
 {
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
-	int i;
 
 	op = argv[1];
 	if (!op)
 		usage(usage_msg);
-	for (i = 2; i < argc; i++)
-		string_list_append(&c.helpers, argv[i]);
 
 	if (credential_read(&c, stdin) < 0)
 		die("unable to read credential from stdin");
@@ -26,13 +23,12 @@ int main(int argc, const char **argv)
 			printf("username=%s\n", c.username);
 		if (c.password)
 			printf("password=%s\n", c.password);
-	}
-	else if (!strcmp(op, "approve"))
+	} else if (!strcmp(op, "approve")) {
 		credential_approve(&c);
-	else if (!strcmp(op, "reject"))
+	} else if (!strcmp(op, "reject")) {
 		credential_reject(&c);
-	else
+	} else {
 		usage(usage_msg);
-
+	}
 	return 0;
 }
diff --git a/git.c b/git.c
index 4da3db5..8788b32 100644
--- a/git.c
+++ b/git.c
@@ -351,6 +351,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "credential", cmd_credential, RUN_SETUP_GENTLY },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 4a37cd7..7c4826e 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -4,10 +4,20 @@
 # stdout and stderr should be provided on stdin,
 # separated by "--".
 check() {
+	credential_opts=
+	credential_cmd=$1
+	shift
+	for arg in "$@"; do
+		credential_opts="$credential_opts -c credential.helper='$arg'"
+	done
 	read_chunk >stdin &&
 	read_chunk >expect-stdout &&
 	read_chunk >expect-stderr &&
-	test-credential "$@" <stdin >stdout 2>stderr &&
+	if ! eval "git $credential_opts credential $credential_cmd <stdin >stdout 2>stderr"; then
+		echo "git credential failed with code $?" &&
+		cat stderr &&
+		false
+	fi &&
 	test_cmp expect-stdout stdout &&
 	test_cmp expect-stderr stderr
 }
@@ -41,7 +51,7 @@ reject() {
 		echo protocol=$2
 		echo host=$3
 		echo username=$4
-	) | test-credential reject $1
+	) | git -c credential.helper=$1 credential reject
 }
 
 helper_test() {
-- 
1.7.11.5.g0c7e058.dirty
