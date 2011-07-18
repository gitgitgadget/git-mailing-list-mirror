From: Jeff King <peff@peff.net>
Subject: [PATCH 06/14] introduce credentials API
Date: Mon, 18 Jul 2011 03:50:34 -0400
Message-ID: <20110718075034.GF12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiibB-0004OZ-QB
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab1GRHuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:50:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50623
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1GRHug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:50:36 -0400
Received: (qmail 19829 invoked by uid 107); 18 Jul 2011 07:51:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:51:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:50:34 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177349>

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

This patch abstracts the notion of gathering user
credentials into a few simple functions. These functions can
be backed by our internal git_getpass implementation (which
just prompts the user), or by external helpers which are
free to consult system-specific password wallets, make
custom policy decisions on password caching and storage, or
prompt the user in a non-traditional manner.

The helper protocol aims for simplicity of helper
implementation; see the newly added documentation for
details.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                                  |    1 +
 Documentation/technical/api-credentials.txt |  113 ++++++++++++++++
 Makefile                                    |    3 +
 credential.c                                |  190 +++++++++++++++++++++++++++
 credential.h                                |   19 +++
 t/t0300-credentials.sh                      |  175 ++++++++++++++++++++++++
 test-credential.c                           |   47 +++++++
 7 files changed, 548 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-credentials.txt
 create mode 100644 credential.c
 create mode 100644 credential.h
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
index 0000000..880db92
--- /dev/null
+++ b/Documentation/technical/api-credentials.txt
@@ -0,0 +1,113 @@
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
+	This struct represents a single username/password combination.
+	The `username` and `password` fields should be heap-allocated
+	strings (or NULL if they are not yet known). The `unique` field,
+	if non-NULL, should be a heap-allocated string indicating a
+	unique context for this credential (e.g., a protocol and server
+	name for a remote credential). The `description` field, if
+	non-NULL, should point to a string containing a human-readable
+	description of this credential.
+
+`struct string_list methods`::
+
+	The credential functions take a `string_list` of methods for
+	acquiring credentials. Each string specifies an external
+	helper which will be run, in order, to acquire credentials,
+	until both a username and password have been acquired. A NULL or
+	empty methods list indicates that the internal
+	`credential_getpass` function should be used.
+
+
+Functions
+---------
+
+`credential_fill_gently`::
+
+	Attempt to fill the username and password fields of the passed
+	credential struct. If they cannot be filled after trying each
+	available method, returns -1. Otherwise, returns 0.
+
+`credential_fill`::
+
+	Like `credential_fill_gently`, but `die()` if credentials cannot
+	be gathered.
+
+`credential_reject`::
+
+	Inform the credential subsystem that the provided credentials
+	have been rejected. This will clear the username and password
+	fields in `struct credential`, as well as notify any helpers of
+	the rejection (which may, for example, purge the invalid
+	credentials from storage).
+
+`credential_getpass`::
+
+	Fetch credentials from the user either using an "askpass" helper
+	(see the discussion of core.askpass and GIT_ASKPASS in
+	linkgit:git-config[1] and linkgit:git[1], respectively) or by
+	prompting the user via the terminal.
+
+
+Credential Helpers
+------------------
+
+Credential helpers are programs executed by git to fetch credentials
+from storage or from the user. The default behavior when no helpers are
+defined is to use the internal `credential_askpass` function.
+
+When a helper is executed, it may receive the following options on the
+command line:
+
+`--reject`::
+
+	Specify that the provided credential has been rejected; the
+	helper may take appropriate action to purge any credential
+	storage or cache. If this option is not given, the helper should
+	assume a credential is being requested.
+
+`--description=<X>`::
+
+	`<X>` will contain a human-readable description of the
+	credential being requested. If this option is not given, no
+	description is available.
+
+`--unique=<X>`::
+
+	`<X>` will contain a token to uniquely identify the context of
+	the credential (e.g., a host name for network authentication).
+	If this option is not given, no context is available.
+
+`--username=<X>`::
+
+	`<X>` will contain the username requested by the user. If this
+	option is not given, no username is available, and the helper
+	should provide both a username and password.
+
+The helper should produce a list of items on stdout, each followed by a
+newline character. Each item should consist of a key-value pair, separated
+by an `=` (equals) sign. The value may contain any bytes except a
+newline. When reading the response, git understands the following keys:
+
+`username`::
+
+	The username part of the credential. If a username was given to
+	the helper via `--username`, the new value will override it.
+
+`password`::
+
+	The password part of the credential.
+
+It is perfectly acceptable for a helper to provide only part of a
+credential, or nothing at all.
diff --git a/Makefile b/Makefile
index 46793d1..16515bf 100644
--- a/Makefile
+++ b/Makefile
@@ -421,6 +421,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_PROGRAMS_NEED_X += test-chmtime
+TEST_PROGRAMS_NEED_X += test-credential
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
@@ -511,6 +512,7 @@ LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
 LIB_H += compat/win32/sys/poll.h
 LIB_H += compat/win32/dirent.h
+LIB_H += credential.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -590,6 +592,7 @@ LIB_OBJS += config.o
 LIB_OBJS += connect.o
 LIB_OBJS += convert.o
 LIB_OBJS += copy.o
+LIB_OBJS += credential.o
 LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
diff --git a/credential.c b/credential.c
new file mode 100644
index 0000000..c403289
--- /dev/null
+++ b/credential.c
@@ -0,0 +1,190 @@
+#include "cache.h"
+#include "credential.h"
+#include "quote.h"
+#include "string-list.h"
+#include "run-command.h"
+
+static char *credential_ask_one(const char *what, const char *desc)
+{
+	struct strbuf prompt = STRBUF_INIT;
+	char *r;
+
+	if (desc)
+		strbuf_addf(&prompt, "%s for '%s': ", what, desc);
+	else
+		strbuf_addf(&prompt, "%s: ", what);
+
+	/* FIXME: for usernames, we should do something less magical that
+	 * actually echoes the characters. However, we need to read from
+	 * /dev/tty and not stdio, which is not portable (but getpass will do
+	 * it for us). http.c uses the same workaround. */
+	r = git_getpass(prompt.buf);
+
+	strbuf_release(&prompt);
+	return xstrdup(r);
+}
+
+int credential_getpass(struct credential *c)
+{
+
+	if (!c->username)
+		c->username = credential_ask_one("Username", c->description);
+	if (!c->password)
+		c->password = credential_ask_one("Password", c->description);
+	return 0;
+}
+
+static int read_credential_response(struct credential *c, FILE *fp)
+{
+	struct strbuf response = STRBUF_INIT;
+
+	while (strbuf_getline(&response, fp, '\n') != EOF) {
+		char *key = response.buf;
+		char *value = strchr(key, '=');
+
+		if (!value) {
+			warning("bad output from credential helper: %s", key);
+			strbuf_release(&response);
+			return -1;
+		}
+		*value++ = '\0';
+
+		if (!strcmp(key, "username")) {
+			free(c->username);
+			c->username = xstrdup(value);
+		}
+		else if (!strcmp(key, "password")) {
+			free(c->password);
+			c->password = xstrdup(value);
+		}
+		/* ignore other responses; we don't know what they mean */
+	}
+
+	strbuf_release(&response);
+	return 0;
+}
+
+static int run_credential_helper(struct credential *c, const char *cmd)
+{
+	struct child_process helper;
+	const char *argv[] = { NULL, NULL };
+	FILE *fp;
+	int r;
+
+	memset(&helper, 0, sizeof(helper));
+	argv[0] = cmd;
+	helper.argv = argv;
+	helper.use_shell = 1;
+	helper.no_stdin = 1;
+	helper.out = -1;
+
+	if (start_command(&helper))
+		return -1;
+	fp = xfdopen(helper.out, "r");
+
+	r = read_credential_response(c, fp);
+
+	fclose(fp);
+	if (finish_command(&helper))
+		r = -1;
+
+	return r;
+}
+
+static void add_item(struct strbuf *out, const char *key, const char *value)
+{
+	if (!value)
+		return;
+	strbuf_addf(out, " --%s=", key);
+	sq_quote_buf(out, value);
+}
+
+static int first_word_is_alnum(const char *s)
+{
+	for (; *s && *s != ' '; s++)
+		if (!isalnum(*s))
+			return 0;
+	return 1;
+}
+
+static int credential_do(struct credential *c, const char *method,
+			 const char *extra)
+{
+	struct strbuf cmd = STRBUF_INIT;
+	int r;
+
+	if (first_word_is_alnum(method))
+		strbuf_addf(&cmd, "git credential-%s", method);
+	else
+		strbuf_addstr(&cmd, method);
+
+	if (extra)
+		strbuf_addf(&cmd, " %s", extra);
+
+	add_item(&cmd, "description", c->description);
+	add_item(&cmd, "unique", c->unique);
+	add_item(&cmd, "username", c->username);
+
+	r = run_credential_helper(c, cmd.buf);
+
+	strbuf_release(&cmd);
+	return r;
+}
+
+void credential_fill(struct credential *c, const struct string_list *methods)
+{
+	struct strbuf err = STRBUF_INIT;
+
+	if (!credential_fill_gently(c, methods))
+		return;
+
+	strbuf_addstr(&err, "unable to get credentials");
+	if (c->description)
+		strbuf_addf(&err, "for '%s'", c->description);
+	if (methods && methods->nr == 1)
+		strbuf_addf(&err, "; tried '%s'", methods->items[0].string);
+	else if (methods) {
+		int i;
+		strbuf_addstr(&err, "; tried:");
+		for (i = 0; i < methods->nr; i++)
+			strbuf_addf(&err, "\n  %s", methods->items[i].string);
+	}
+	die(err.buf);
+}
+
+int credential_fill_gently(struct credential *c,
+			   const struct string_list *methods)
+{
+	int i;
+
+	if (c->username && c->password)
+		return 0;
+
+	if (!methods || !methods->nr)
+		return credential_getpass(c);
+
+	for (i = 0; i < methods->nr; i++) {
+		if (!credential_do(c, methods->items[i].string, NULL) &&
+		    c->username && c->password)
+			return 0;
+	}
+
+	return -1;
+}
+
+void credential_reject(struct credential *c, const struct string_list *methods)
+{
+	int i;
+
+	if (methods && c->username) {
+		for (i = 0; i < methods->nr; i++) {
+			/* ignore errors, there's nothing we can do */
+			credential_do(c, methods->items[i].string, "--reject");
+		}
+	}
+
+	free(c->username);
+	c->username = NULL;
+	free(c->password);
+	c->password = NULL;
+}
diff --git a/credential.h b/credential.h
new file mode 100644
index 0000000..383b720
--- /dev/null
+++ b/credential.h
@@ -0,0 +1,19 @@
+#ifndef CREDENTIAL_H
+#define CREDENTIAL_H
+
+struct credential {
+	char *description;
+	char *username;
+	char *password;
+	char *unique;
+};
+
+struct string_list;
+
+int credential_getpass(struct credential *);
+
+int credential_fill_gently(struct credential *, const struct string_list *methods);
+void credential_fill(struct credential *, const struct string_list *methods);
+void credential_reject(struct credential *, const struct string_list *methods);
+
+#endif /* CREDENTIAL_H */
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
new file mode 100755
index 0000000..447e983
--- /dev/null
+++ b/t/t0300-credentials.sh
@@ -0,0 +1,175 @@
+#!/bin/sh
+
+test_description='basic credential helper tests'
+. ./test-lib.sh
+
+# Try a set of credential helpers; the expected
+# stdout and stderr should be provided on stdin,
+# separated by "--".
+check() {
+	while read line; do
+		case "$line" in
+		--) break ;;
+		*) echo "$line" ;;
+		esac
+	done >expect-stdout &&
+	cat >expect-stderr &&
+	test-credential "$@" >stdout 2>stderr &&
+	test_cmp expect-stdout stdout &&
+	test_cmp expect-stderr stderr
+}
+
+test_expect_success 'setup helper scripts' '
+	cat >dump <<-\EOF &&
+	whoami=$1; shift
+	if test $# = 0; then
+		echo >&2 "$whoami: <empty>"
+	else
+		for i in "$@"; do
+			echo >&2 "$whoami: $i"
+		done
+	fi
+	EOF
+	chmod +x dump &&
+
+	cat >git-credential-useless <<-\EOF &&
+	#!/bin/sh
+	dump useless "$@"
+	exit 0
+	EOF
+	chmod +x git-credential-useless &&
+
+	cat >git-credential-verbatim <<-\EOF &&
+	#!/bin/sh
+	user=$1; shift
+	pass=$1; shift
+	dump verbatim "$@"
+	test -z "$user" || echo username=$user
+	test -z "$pass" || echo password=$pass
+	EOF
+	chmod +x git-credential-verbatim &&
+
+	cat >askpass <<-\EOF &&
+	#!/bin/sh
+	echo >&2 askpass: $*
+	echo askpass-result
+	EOF
+	chmod +x askpass &&
+	GIT_ASKPASS=askpass &&
+	export GIT_ASKPASS &&
+
+	PATH="$PWD:$PATH"
+'
+
+test_expect_success 'credential_fill invokes helper' '
+	check "verbatim foo bar" <<-\EOF
+	username=foo
+	password=bar
+	--
+	verbatim: <empty>
+	EOF
+'
+
+test_expect_success 'credential_fill invokes multiple helpers' '
+	check useless "verbatim foo bar" <<-\EOF
+	username=foo
+	password=bar
+	--
+	useless: <empty>
+	verbatim: <empty>
+	EOF
+'
+
+test_expect_success 'credential_fill stops when we get a full response' '
+	check "verbatim one two" "verbatim three four" <<-\EOF
+	username=one
+	password=two
+	--
+	verbatim: <empty>
+	EOF
+'
+
+test_expect_success 'credential_fill continues through partial response' '
+	check "verbatim one \"\"" "verbatim two three" <<-\EOF
+	username=two
+	password=three
+	--
+	verbatim: <empty>
+	verbatim: --username=one
+	EOF
+'
+
+test_expect_success 'credential_fill passes along metadata' '
+	check --description=foo --unique=bar "verbatim one two" <<-\EOF
+	username=one
+	password=two
+	--
+	verbatim: --description=foo
+	verbatim: --unique=bar
+	EOF
+'
+
+test_expect_success 'credential_reject calls all helpers' '
+	check --reject --username=foo useless "verbatim one two" <<-\EOF
+	--
+	useless: --reject
+	useless: --username=foo
+	verbatim: --reject
+	verbatim: --username=foo
+	EOF
+'
+
+test_expect_success 'do not bother rejecting empty credential' '
+	check --reject useless <<-\EOF
+	--
+	EOF
+'
+
+test_expect_success 'usernames can be preserved' '
+	check --username=one "verbatim \"\" three" <<-\EOF
+	username=one
+	password=three
+	--
+	verbatim: --username=one
+'
+
+test_expect_success 'usernames can be overridden' '
+	check --username=one "verbatim two three" <<-\EOF
+	username=two
+	password=three
+	--
+	verbatim: --username=one
+	EOF
+'
+
+test_expect_success 'do not bother completing already-full credential' '
+	check --username=one --password=two "verbatim three four" <<-\EOF
+	username=one
+	password=two
+	--
+	EOF
+'
+
+# We can't test the basic terminal password prompt here because
+# getpass() tries too hard to find the real terminal. But if our
+# askpass helper is run, we know the internal getpass is working.
+test_expect_success 'empty methods falls back to internal getpass' '
+	check <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
+test_expect_success 'internal getpass does not ask for known username' '
+	check --username=foo <<-\EOF
+	username=foo
+	password=askpass-result
+	--
+	askpass: Password:
+	EOF
+'
+
+test_done
diff --git a/test-credential.c b/test-credential.c
new file mode 100644
index 0000000..3929efd
--- /dev/null
+++ b/test-credential.c
@@ -0,0 +1,47 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+#include "parse-options.h"
+
+int main(int argc, const char **argv)
+{
+	int reject = 0;
+	struct credential c = { NULL };
+	struct string_list methods = STRING_LIST_INIT_NODUP;
+	const char *const usage[] = {
+		"test-credential [options] [method...]",
+		NULL
+	};
+	struct option options[] = {
+		OPT_BOOLEAN(0, "reject", &reject, "reject"),
+		OPT_STRING(0, "description", &c.description, "desc",
+			   "description"),
+		OPT_STRING(0, "unique", &c.unique, "token",
+			   "unique"),
+		OPT_STRING(0, "username", &c.username, "name", "username"),
+		OPT_STRING(0, "password", &c.password, "pass", "password"),
+		OPT_END()
+	};
+	int i;
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	for (i = 0; i < argc; i++)
+		string_list_append(&methods, argv[i]);
+	/* credential_reject will try to free() */
+	if (c.username)
+		c.username = xstrdup(c.username);
+	if (c.password)
+		c.password = xstrdup(c.password);
+
+	if (reject)
+		credential_reject(&c, &methods);
+	else
+		credential_fill(&c, &methods);
+
+	if (c.username)
+		printf("username=%s\n", c.username);
+	if (c.password)
+		printf("password=%s\n", c.password);
+
+	return 0;
+}
-- 
1.7.6.rc1.12.g65e2
