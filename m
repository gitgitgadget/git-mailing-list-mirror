From: Jeff King <peff@peff.net>
Subject: [PATCHv3 03/13] introduce credentials API
Date: Sat, 10 Dec 2011 05:31:11 -0500
Message-ID: <20111210103111.GC16529@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:31:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKDA-0005rR-FO
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1LJKbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:31:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab1LJKbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:31:13 -0500
Received: (qmail 13898 invoked by uid 107); 10 Dec 2011 10:37:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:37:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:31:11 -0500
Content-Disposition: inline
In-Reply-To: <20111210102827.GA16460@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186735>

There are a few places in git that need to get a username
and password credential from the user; the most notable one
is HTTP authentication for smart-http pushing.

Right now the only choices for providing credentials are to
put them plaintext into your ~/.netrc, or to have git prompt
you (either on the terminal or via an askpass program). The
former is not very secure, and the latter is not very
convenient.

Unfortunately, there is no "always best" solution for
password management. The details will depend on the tradeoff
you want between security and convenience, as well as how
git can integrate with other security systems (e.g., many
operating systems provide a keychain or password wallet for
single sign-on).

This patch provides an abstract notion of credentials as a
data item, and provides three basic operations:

  - fill (i.e., acquire from external storage or from the
    user)

  - approve (mark a credential as "working" for further
    storage)

  - reject (mark a credential as "not working", so it can
    be removed from storage)

These operations can be backed by external helper processes
that interact with system- or user-specific secure storage.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                                  |    1 +
 Documentation/technical/api-credentials.txt |  241 +++++++++++++++++++++++++++
 Makefile                                    |    3 +
 credential.c                                |  234 ++++++++++++++++++++++++++
 credential.h                                |   28 +++
 t/lib-credential.sh                         |   33 ++++
 t/t0300-credentials.sh                      |  195 ++++++++++++++++++++++
 test-credential.c                           |   38 +++++
 8 files changed, 773 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-credentials.txt
 create mode 100644 credential.c
 create mode 100644 credential.h
 create mode 100755 t/lib-credential.sh
 create mode 100755 t/t0300-credentials.sh
 create mode 100644 test-credential.c

diff --git a/.gitignore b/.gitignore
index 8572c8c..7d2fefc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -167,6 +167,7 @@
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
 /test-chmtime
+/test-credential
 /test-ctype
 /test-date
 /test-delta
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
new file mode 100644
index 0000000..f624aef
--- /dev/null
+++ b/Documentation/technical/api-credentials.txt
@@ -0,0 +1,241 @@
+credentials API
+===============
+
+The credentials API provides an abstracted way of gathering username and
+password credentials from the user (even though credentials in the wider
+world can take many forms, in this document the word "credential" always
+refers to a username and password pair).
+
+Data Structures
+---------------
+
+`struct credential`::
+
+	This struct represents a single username/password combination
+	along with any associated context. All string fields should be
+	heap-allocated (or NULL if they are not known or not applicable).
+	The meaning of the individual context fields is the same as
+	their counterparts in the helper protocol; see the section below
+	for a description of each field.
++
+The `helpers` member of the struct is a `string_list` of helpers.  Each
+string specifies an external helper which will be run, in order, to
+either acquire or store credentials. See the section on credential
+helpers below.
++
+This struct should always be initialized with `CREDENTIAL_INIT` or
+`credential_init`.
+
+
+Functions
+---------
+
+`credential_init`::
+
+	Initialize a credential structure, setting all fields to empty.
+
+`credential_clear`::
+
+	Free any resources associated with the credential structure,
+	returning it to a pristine initialized state.
+
+`credential_fill`::
+
+	Instruct the credential subsystem to fill the username and
+	password fields of the passed credential struct by first
+	consulting helpers, then asking the user. After this function
+	returns, the username and password fields of the credential are
+	guaranteed to be non-NULL. If an error occurs, the function will
+	die().
+
+`credential_reject`::
+
+	Inform the credential subsystem that the provided credentials
+	have been rejected. This will cause the credential subsystem to
+	notify any helpers of the rejection (which allows them, for
+	example, to purge the invalid credentials from storage).  It
+	will also free() the username and password fields of the
+	credential and set them to NULL (readying the credential for
+	another call to `credential_fill`). Any errors from helpers are
+	ignored.
+
+`credential_approve`::
+
+	Inform the credential subsystem that the provided credentials
+	were successfully used for authentication.  This will cause the
+	credential subsystem to notify any helpers of the approval, so
+	that they may store the result to be used again.  Any errors
+	from helpers are ignored.
+
+Example
+-------
+
+The example below shows how the functions of the credential API could be
+used to login to a fictitious "foo" service on a remote host:
+
+-----------------------------------------------------------------------
+int foo_login(struct foo_connection *f)
+{
+	int status;
+	/*
+	 * Create a credential with some context; we don't yet know the
+	 * username or password.
+	 */
+
+	struct credential c = CREDENTIAL_INIT;
+	c.protocol = xstrdup("foo");
+	c.host = xstrdup(f->hostname);
+
+	/*
+	 * Fill in the username and password fields by contacting
+	 * helpers and/or asking the user. The function will die if it
+	 * fails.
+	 */
+	credential_fill(&c);
+
+	/*
+	 * Otherwise, we have a username and password. Try to use it.
+	 */
+	status = send_foo_login(f, c.username, c.password);
+	switch (status) {
+	case FOO_OK:
+		/* It worked. Store the credential for later use. */
+		credential_accept(&c);
+		break;
+	case FOO_BAD_LOGIN:
+		/* Erase the credential from storage so we don't try it
+		 * again. */
+		credential_reject(&c);
+		break;
+	default:
+		/*
+		 * Some other error occured. We don't know if the
+		 * credential is good or bad, so report nothing to the
+		 * credential subsystem.
+		 */
+	}
+
+	/* Free any associated resources. */
+	credential_clear(&c);
+
+	return status;
+}
+-----------------------------------------------------------------------
+
+
+Credential Helpers
+------------------
+
+Credential helpers are programs executed by git to fetch or save
+credentials from and to long-term storage (where "long-term" is simply
+longer than a single git process; e.g., credentials may be stored
+in-memory for a few minutes, or indefinitely on disk).
+
+Each helper is specified by a single string. The string is transformed
+by git into a command to be executed using these rules:
+
+  1. If the helper string begins with "!", it is considered a shell
+     snippet, and everything after the "!" becomes the command.
+
+  2. Otherwise, if the helper string begins with an absolute path, the
+     verbatim helper string becomes the command.
+
+  3. Otherwise, the string "git credential-" is prepended to the helper
+     string, and the result becomes the command.
+
+The resulting command then has an "operation" argument appended to it
+(see below for details), and the result is executed by the shell.
+
+Here are some example specifications:
+
+----------------------------------------------------
+# run "git credential-foo"
+foo
+
+# same as above, but pass an argument to the helper
+foo --bar=baz
+
+# the arguments are parsed by the shell, so use shell
+# quoting if necessary
+foo --bar="whitespace arg"
+
+# you can also use an absolute path, which will not use the git wrapper
+/path/to/my/helper --with-arguments
+
+# or you can specify your own shell snippet
+!f() { echo "password=`cat $HOME/.secret`"; }; f
+----------------------------------------------------
+
+Generally speaking, rule (3) above is the simplest for users to specify.
+Authors of credential helpers should make an effort to assist their
+users by naming their program "git-credential-$NAME", and putting it in
+the $PATH or $GIT_EXEC_PATH during installation, which will allow a user
+to enable it with `git config credential.helper $NAME`.
+
+When a helper is executed, it will have one "operation" argument
+appended to its command line, which is one of:
+
+`get`::
+
+	Return a matching credential, if any exists.
+
+`store`::
+
+	Store the credential, if applicable to the helper.
+
+`erase`::
+
+	Remove a matching credential, if any, from the helper's storage.
+
+The details of the credential will be provided on the helper's stdin
+stream. The credential is split into a set of named attributes.
+Attributes are provided to the helper, one per line. Each attribute is
+specified by a key-value pair, separated by an `=` (equals) sign,
+followed by a newline. The key may contain any bytes except `=`,
+newline, or NUL. The value may contain any bytes except newline or NUL.
+In both cases, all bytes are treated as-is (i.e., there is no quoting,
+and one cannot transmit a value with newline or NUL in it). The list of
+attributes is terminated by a blank line or end-of-file.
+
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
+
+For a `get` operation, the helper should produce a list of attributes
+on stdout in the same format. A helper is free to produce a subset, or
+even no values at all if it has nothing useful to provide. Any provided
+attributes will overwrite those already known about by git.
+
+For a `store` or `erase` operation, the helper's output is ignored.
+If it fails to perform the requested operation, it may complain to
+stderr to inform the user. If it does not support the requested
+operation (e.g., a read-only store), it should silently ignore the
+request.
+
+If a helper receives any other operation, it should silently ignore the
+request. This leaves room for future operations to be added (older
+helpers will just ignore the new requests).
diff --git a/Makefile b/Makefile
index ed82320..d69f1dd 100644
--- a/Makefile
+++ b/Makefile
@@ -431,6 +431,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-credential
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
@@ -525,6 +526,7 @@ LIB_H += compat/win32/poll.h
 LIB_H += compat/win32/dirent.h
 LIB_H += connected.h
 LIB_H += convert.h
+LIB_H += credential.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -611,6 +613,7 @@ LIB_OBJS += connect.o
 LIB_OBJS += connected.o
 LIB_OBJS += convert.o
 LIB_OBJS += copy.o
+LIB_OBJS += credential.o
 LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
diff --git a/credential.c b/credential.c
new file mode 100644
index 0000000..86397f3
--- /dev/null
+++ b/credential.c
@@ -0,0 +1,234 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+#include "run-command.h"
+
+void credential_init(struct credential *c)
+{
+	memset(c, 0, sizeof(*c));
+	c->helpers.strdup_strings = 1;
+}
+
+void credential_clear(struct credential *c)
+{
+	free(c->protocol);
+	free(c->host);
+	free(c->path);
+	free(c->username);
+	free(c->password);
+	string_list_clear(&c->helpers, 0);
+
+	credential_init(c);
+}
+
+static void credential_describe(struct credential *c, struct strbuf *out)
+{
+	if (!c->protocol)
+		return;
+	strbuf_addf(out, "%s://", c->protocol);
+	if (c->username && *c->username)
+		strbuf_addf(out, "%s@", c->username);
+	if (c->host)
+		strbuf_addstr(out, c->host);
+	if (c->path)
+		strbuf_addf(out, "/%s", c->path);
+}
+
+static char *credential_ask_one(const char *what, struct credential *c)
+{
+	struct strbuf desc = STRBUF_INIT;
+	struct strbuf prompt = STRBUF_INIT;
+	char *r;
+
+	credential_describe(c, &desc);
+	if (desc.len)
+		strbuf_addf(&prompt, "%s for '%s': ", what, desc.buf);
+	else
+		strbuf_addf(&prompt, "%s: ", what);
+
+	/* FIXME: for usernames, we should do something less magical that
+	 * actually echoes the characters. However, we need to read from
+	 * /dev/tty and not stdio, which is not portable (but getpass will do
+	 * it for us). http.c uses the same workaround. */
+	r = git_getpass(prompt.buf);
+
+	strbuf_release(&desc);
+	strbuf_release(&prompt);
+	return xstrdup(r);
+}
+
+static void credential_getpass(struct credential *c)
+{
+	if (!c->username)
+		c->username = credential_ask_one("Username", c);
+	if (!c->password)
+		c->password = credential_ask_one("Password", c);
+}
+
+int credential_read(struct credential *c, FILE *fp)
+{
+	struct strbuf line = STRBUF_INIT;
+
+	while (strbuf_getline(&line, fp, '\n') != EOF) {
+		char *key = line.buf;
+		char *value = strchr(key, '=');
+
+		if (!line.len)
+			break;
+
+		if (!value) {
+			warning("invalid credential line: %s", key);
+			strbuf_release(&line);
+			return -1;
+		}
+		*value++ = '\0';
+
+		if (!strcmp(key, "username")) {
+			free(c->username);
+			c->username = xstrdup(value);
+		} else if (!strcmp(key, "password")) {
+			free(c->password);
+			c->password = xstrdup(value);
+		} else if (!strcmp(key, "protocol")) {
+			free(c->protocol);
+			c->protocol = xstrdup(value);
+		} else if (!strcmp(key, "host")) {
+			free(c->host);
+			c->host = xstrdup(value);
+		} else if (!strcmp(key, "path")) {
+			free(c->path);
+			c->path = xstrdup(value);
+		}
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
+	}
+
+	strbuf_release(&line);
+	return 0;
+}
+
+static void credential_write_item(FILE *fp, const char *key, const char *value)
+{
+	if (!value)
+		return;
+	fprintf(fp, "%s=%s\n", key, value);
+}
+
+static void credential_write(const struct credential *c, FILE *fp)
+{
+	credential_write_item(fp, "protocol", c->protocol);
+	credential_write_item(fp, "host", c->host);
+	credential_write_item(fp, "path", c->path);
+	credential_write_item(fp, "username", c->username);
+	credential_write_item(fp, "password", c->password);
+}
+
+static int run_credential_helper(struct credential *c,
+				 const char *cmd,
+				 int want_output)
+{
+	struct child_process helper;
+	const char *argv[] = { NULL, NULL };
+	FILE *fp;
+
+	memset(&helper, 0, sizeof(helper));
+	argv[0] = cmd;
+	helper.argv = argv;
+	helper.use_shell = 1;
+	helper.in = -1;
+	if (want_output)
+		helper.out = -1;
+	else
+		helper.no_stdout = 1;
+
+	if (start_command(&helper) < 0)
+		return -1;
+
+	fp = xfdopen(helper.in, "w");
+	credential_write(c, fp);
+	fclose(fp);
+
+	if (want_output) {
+		int r;
+		fp = xfdopen(helper.out, "r");
+		r = credential_read(c, fp);
+		fclose(fp);
+		if (r < 0) {
+			finish_command(&helper);
+			return -1;
+		}
+	}
+
+	if (finish_command(&helper))
+		return -1;
+	return 0;
+}
+
+static int credential_do(struct credential *c, const char *helper,
+			 const char *operation)
+{
+	struct strbuf cmd = STRBUF_INIT;
+	int r;
+
+	if (helper[0] == '!')
+		strbuf_addstr(&cmd, helper + 1);
+	else if (is_absolute_path(helper))
+		strbuf_addstr(&cmd, helper);
+	else
+		strbuf_addf(&cmd, "git credential-%s", helper);
+
+	strbuf_addf(&cmd, " %s", operation);
+	r = run_credential_helper(c, cmd.buf, !strcmp(operation, "get"));
+
+	strbuf_release(&cmd);
+	return r;
+}
+
+void credential_fill(struct credential *c)
+{
+	int i;
+
+	if (c->username && c->password)
+		return;
+
+	for (i = 0; i < c->helpers.nr; i++) {
+		credential_do(c, c->helpers.items[i].string, "get");
+		if (c->username && c->password)
+			return;
+	}
+
+	credential_getpass(c);
+	if (!c->username && !c->password)
+		die("unable to get password from user");
+}
+
+void credential_approve(struct credential *c)
+{
+	int i;
+
+	if (c->approved)
+		return;
+	if (!c->username || !c->password)
+		return;
+
+	for (i = 0; i < c->helpers.nr; i++)
+		credential_do(c, c->helpers.items[i].string, "store");
+	c->approved = 1;
+}
+
+void credential_reject(struct credential *c)
+{
+	int i;
+
+	for (i = 0; i < c->helpers.nr; i++)
+		credential_do(c, c->helpers.items[i].string, "erase");
+
+	free(c->username);
+	c->username = NULL;
+	free(c->password);
+	c->password = NULL;
+	c->approved = 0;
+}
diff --git a/credential.h b/credential.h
new file mode 100644
index 0000000..2ea7d49
--- /dev/null
+++ b/credential.h
@@ -0,0 +1,28 @@
+#ifndef CREDENTIAL_H
+#define CREDENTIAL_H
+
+#include "string-list.h"
+
+struct credential {
+	struct string_list helpers;
+	unsigned approved:1;
+
+	char *username;
+	char *password;
+	char *protocol;
+	char *host;
+	char *path;
+};
+
+#define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }
+
+void credential_init(struct credential *);
+void credential_clear(struct credential *);
+
+void credential_fill(struct credential *);
+void credential_approve(struct credential *);
+void credential_reject(struct credential *);
+
+int credential_read(struct credential *, FILE *);
+
+#endif /* CREDENTIAL_H */
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
new file mode 100755
index 0000000..54ae1f4
--- /dev/null
+++ b/t/lib-credential.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+# Try a set of credential helpers; the expected stdin,
+# stdout and stderr should be provided on stdin,
+# separated by "--".
+check() {
+	read_chunk >stdin &&
+	read_chunk >expect-stdout &&
+	read_chunk >expect-stderr &&
+	test-credential "$@" <stdin >stdout 2>stderr &&
+	test_cmp expect-stdout stdout &&
+	test_cmp expect-stderr stderr
+}
+
+read_chunk() {
+	while read line; do
+		case "$line" in
+		--) break ;;
+		*) echo "$line" ;;
+		esac
+	done
+}
+
+
+cat >askpass <<\EOF
+#!/bin/sh
+echo >&2 askpass: $*
+what=`echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z`
+echo "askpass-$what"
+EOF
+chmod +x askpass
+GIT_ASKPASS="$PWD/askpass"
+export GIT_ASKPASS
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
new file mode 100755
index 0000000..81a455f
--- /dev/null
+++ b/t/t0300-credentials.sh
@@ -0,0 +1,195 @@
+#!/bin/sh
+
+test_description='basic credential helper tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+test_expect_success 'setup helper scripts' '
+	cat >dump <<-\EOF &&
+	whoami=`echo $0 | sed s/.*git-credential-//`
+	echo >&2 "$whoami: $*"
+	while IFS== read key value; do
+		echo >&2 "$whoami: $key=$value"
+		eval "$key=$value"
+	done
+	EOF
+
+	cat >git-credential-useless <<-\EOF &&
+	#!/bin/sh
+	. ./dump
+	exit 0
+	EOF
+	chmod +x git-credential-useless &&
+
+	cat >git-credential-verbatim <<-\EOF &&
+	#!/bin/sh
+	user=$1; shift
+	pass=$1; shift
+	. ./dump
+	test -z "$user" || echo username=$user
+	test -z "$pass" || echo password=$pass
+	EOF
+	chmod +x git-credential-verbatim &&
+
+	PATH="$PWD:$PATH"
+'
+
+test_expect_success 'credential_fill invokes helper' '
+	check fill "verbatim foo bar" <<-\EOF
+	--
+	username=foo
+	password=bar
+	--
+	verbatim: get
+	EOF
+'
+
+test_expect_success 'credential_fill invokes multiple helpers' '
+	check fill useless "verbatim foo bar" <<-\EOF
+	--
+	username=foo
+	password=bar
+	--
+	useless: get
+	verbatim: get
+	EOF
+'
+
+test_expect_success 'credential_fill stops when we get a full response' '
+	check fill "verbatim one two" "verbatim three four" <<-\EOF
+	--
+	username=one
+	password=two
+	--
+	verbatim: get
+	EOF
+'
+
+test_expect_success 'credential_fill continues through partial response' '
+	check fill "verbatim one \"\"" "verbatim two three" <<-\EOF
+	--
+	username=two
+	password=three
+	--
+	verbatim: get
+	verbatim: get
+	verbatim: username=one
+	EOF
+'
+
+test_expect_success 'credential_fill passes along metadata' '
+	check fill "verbatim one two" <<-\EOF
+	protocol=ftp
+	host=example.com
+	path=foo.git
+	--
+	username=one
+	password=two
+	--
+	verbatim: get
+	verbatim: protocol=ftp
+	verbatim: host=example.com
+	verbatim: path=foo.git
+	EOF
+'
+
+test_expect_success 'credential_approve calls all helpers' '
+	check approve useless "verbatim one two" <<-\EOF
+	username=foo
+	password=bar
+	--
+	--
+	useless: store
+	useless: username=foo
+	useless: password=bar
+	verbatim: store
+	verbatim: username=foo
+	verbatim: password=bar
+	EOF
+'
+
+test_expect_success 'do not bother storing password-less credential' '
+	check approve useless <<-\EOF
+	username=foo
+	--
+	--
+	EOF
+'
+
+
+test_expect_success 'credential_reject calls all helpers' '
+	check reject useless "verbatim one two" <<-\EOF
+	username=foo
+	password=bar
+	--
+	--
+	useless: erase
+	useless: username=foo
+	useless: password=bar
+	verbatim: erase
+	verbatim: username=foo
+	verbatim: password=bar
+	EOF
+'
+
+test_expect_success 'usernames can be preserved' '
+	check fill "verbatim \"\" three" <<-\EOF
+	username=one
+	--
+	username=one
+	password=three
+	--
+	verbatim: get
+	verbatim: username=one
+	EOF
+'
+
+test_expect_success 'usernames can be overridden' '
+	check fill "verbatim two three" <<-\EOF
+	username=one
+	--
+	username=two
+	password=three
+	--
+	verbatim: get
+	verbatim: username=one
+	EOF
+'
+
+test_expect_success 'do not bother completing already-full credential' '
+	check fill "verbatim three four" <<-\EOF
+	username=one
+	password=two
+	--
+	username=one
+	password=two
+	--
+	EOF
+'
+
+# We can't test the basic terminal password prompt here because
+# getpass() tries too hard to find the real terminal. But if our
+# askpass helper is run, we know the internal getpass is working.
+test_expect_success 'empty helper list falls back to internal getpass' '
+	check fill <<-\EOF
+	--
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
+test_expect_success 'internal getpass does not ask for known username' '
+	check fill <<-\EOF
+	username=foo
+	--
+	username=foo
+	password=askpass-password
+	--
+	askpass: Password:
+	EOF
+'
+
+test_done
diff --git a/test-credential.c b/test-credential.c
new file mode 100644
index 0000000..dee200e
--- /dev/null
+++ b/test-credential.c
@@ -0,0 +1,38 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+
+static const char usage_msg[] =
+"test-credential <fill|approve|reject> [helper...]";
+
+int main(int argc, const char **argv)
+{
+	const char *op;
+	struct credential c = CREDENTIAL_INIT;
+	int i;
+
+	op = argv[1];
+	if (!op)
+		usage(usage_msg);
+	for (i = 2; i < argc; i++)
+		string_list_append(&c.helpers, argv[i]);
+
+	if (credential_read(&c, stdin) < 0)
+		die("unable to read credential from stdin");
+
+	if (!strcmp(op, "fill")) {
+		credential_fill(&c);
+		if (c.username)
+			printf("username=%s\n", c.username);
+		if (c.password)
+			printf("password=%s\n", c.password);
+	}
+	else if (!strcmp(op, "approve"))
+		credential_approve(&c);
+	else if (!strcmp(op, "reject"))
+		credential_reject(&c);
+	else
+		usage(usage_msg);
+
+	return 0;
+}
-- 
1.7.8.rc2.40.gaf387
