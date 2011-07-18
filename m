From: Jeff King <peff@peff.net>
Subject: [PATCH 12/14] credentials: add "cache" helper
Date: Mon, 18 Jul 2011 03:55:12 -0400
Message-ID: <20110718075512.GL12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:55:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiifj-0005p7-75
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab1GRHzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:55:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54114
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab1GRHzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:55:14 -0400
Received: (qmail 20000 invoked by uid 107); 18 Jul 2011 07:55:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:55:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:55:12 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177355>

If you access repositories over smart-http using http
authentication, then it can be annoying to have git ask you
for your password repeatedly. We cache credentials in
memory, of course, but git is composed of many small
programs. Having to input your password for each one can be
frustrating.

This patch introduces a credential helper that will cache
passwords in memory for a short period of time.

Signed-off-by: Jeff King <peff@peff.net>
---
This uses unix sockets (protected by filesystem permissions) to talk to
the daemon. I have no idea if emulation is available on Windows, or if
there's some equivalent we can use.

 .gitignore                                     |    2 +
 Documentation/git-credential-cache--daemon.txt |   26 +++
 Documentation/git-credential-cache.txt         |   84 ++++++++
 Documentation/gitcredentials.txt               |   17 +-
 Makefile                                       |    3 +
 credential-cache--daemon.c                     |  268 ++++++++++++++++++++++++
 credential-cache.c                             |  163 ++++++++++++++
 git-compat-util.h                              |    1 +
 t/t0300-credentials.sh                         |   91 ++++++++
 unix-socket.c                                  |   58 +++++
 unix-socket.h                                  |    7 +
 11 files changed, 715 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-credential-cache--daemon.txt
 create mode 100644 Documentation/git-credential-cache.txt
 create mode 100644 credential-cache--daemon.c
 create mode 100644 credential-cache.c
 create mode 100644 unix-socket.c
 create mode 100644 unix-socket.h

diff --git a/.gitignore b/.gitignore
index 7d2fefc..a6b0bd4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,8 @@
 /git-commit-tree
 /git-config
 /git-count-objects
+/git-credential-cache
+/git-credential-cache--daemon
 /git-cvsexportcommit
 /git-cvsimport
 /git-cvsserver
diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.txt
new file mode 100644
index 0000000..11edc5a
--- /dev/null
+++ b/Documentation/git-credential-cache--daemon.txt
@@ -0,0 +1,26 @@
+git-credential-cache--daemon(1)
+===============================
+
+NAME
+----
+git-credential-cache--daemon - temporarily store user credentials in memory
+
+SYNOPSIS
+--------
+[verse]
+git credential-cache--daemon <socket>
+
+DESCRIPTION
+-----------
+
+NOTE: You probably don't want to invoke this command yourself; it is
+started automatically when you use linkgit:git-credential-cache[1].
+
+This command listens on the Unix domain socket specified by `<socket>`
+for `git-credential-cache` clients. Clients may store and retrieve
+credentials. Each credential is held for a timeout specified by the
+client; once no credentials are held, the daemon exits.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
new file mode 100644
index 0000000..563fdae
--- /dev/null
+++ b/Documentation/git-credential-cache.txt
@@ -0,0 +1,84 @@
+git-credential-cache(1)
+=======================
+
+NAME
+----
+git-credential-cache - helper to temporarily store passwords in memory
+
+SYNOPSIS
+--------
+-----------------------------
+git config credential.helper 'cache [options]'
+-----------------------------
+
+DESCRIPTION
+-----------
+
+This command requests credentials from the user and caches them in
+memory for use by future git programs. The stored credentials never
+touch the disk, and are forgotten after a configurable timeout.  The
+cache is accessible over a Unix domain socket, restricted to the current
+user by filesystem permissions.
+
+You probably don't want to invoke this command directly; it is meant to
+be used as a credential helper by other parts of git. See
+linkgit:gitcredentials[7] or `EXAMPLES` below.
+
+OPTIONS
+-------
+
+--timeout::
+
+	Number of seconds to cache credentials (default: 900).
+
+--socket <path>::
+
+	Use `<path>` to contact a running cache daemon (or start a new
+	cache daemon if one is not started). Defaults to
+	`~/.git-credential-cache/socket`. If your home directory is on a
+	network-mounted filesystem, you may need to change this to a
+	local filesystem.
+
+--chain <helper>::
+
+	Specify an external helper to use for retrieving credentials
+	from the user, instead of the default method. The resulting
+	credentials are then cached as normal. This option can be
+	given multiple times; each chained helper will be tried until
+	credentials are received.
+
+--exit::
+
+	Tell a running daemon to exit, forgetting all cached
+	credentials.
+
+Git may provide other options to the program when it is called as a
+credential helper; see linkgit:gitcredentials[7].
+
+EXAMPLES
+--------
+
+The point of this helper is to reduce the number of times you must type
+your username or password. For example:
+
+------------------------------------
+$ git config credential.helper cache
+$ git push http://example.com/repo.git
+Username: <type your username>
+Password: <type your password>
+
+[work for 5 more minutes]
+$ git push http://example.com/repo.git
+[your credentials are used automatically]
+------------------------------------
+
+You can provide options via the credential.helper configuration
+variable (this example drops the cache time to 5 minutes):
+
+------------------------------------
+$ git config credential.helper 'cache --timeout=300'
+------------------------------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 74136ee..bd1a3b6 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -80,11 +80,18 @@ CREDENTIAL HELPERS
 Credential helpers are external programs from which git can request
 usernames and passwords.
 
-To use a helper, you must first select one to use.  Git does not yet
-include any credential helpers, but you may have third-party helpers
-installed; search for `credential-*` in the output of `git help -a`, and
-consult the documentation of individual helpers.  Once you have selected
-a helper, you can tell git to use it by putting its name into the
+To use a helper, you must first select one to use. Git currently
+includes the following helpers:
+
+cache::
+
+	Cache credentials in memory for a short period of time. See
+	linkgit:git-credential-cache[1] for details.
+
+You may may also have third-party helpers installed; search for
+`credential-*` in the output of `git help -a`, and consult the
+documentation of individual helpers.  Once you have selected a helper,
+you can tell git to use it by putting its name into the
 credential.helper variable.
 
 1. Find a helper.
diff --git a/Makefile b/Makefile
index 16515bf..2ecfd90 100644
--- a/Makefile
+++ b/Makefile
@@ -417,6 +417,8 @@ PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
+PROGRAM_OBJS += credential-cache.o
+PROGRAM_OBJS += credential-cache--daemon.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
@@ -677,6 +679,7 @@ LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
+LIB_OBJS += unix-socket.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += url.o
 LIB_OBJS += usage.o
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
new file mode 100644
index 0000000..f520347
--- /dev/null
+++ b/credential-cache--daemon.c
@@ -0,0 +1,268 @@
+#include "cache.h"
+#include "credential.h"
+#include "unix-socket.h"
+
+struct credential_cache_entry {
+	struct credential item;
+	unsigned long expiration;
+};
+static struct credential_cache_entry *entries;
+static int entries_nr;
+static int entries_alloc;
+
+static void cache_credential(const struct credential *c, int timeout)
+{
+	struct credential_cache_entry *e;
+
+	ALLOC_GROW(entries, entries_nr + 1, entries_alloc);
+	e = &entries[entries_nr++];
+
+	memcpy(&e->item, c, sizeof(*c));
+	e->expiration = time(NULL) + timeout;
+}
+
+static struct credential_cache_entry *lookup_credential(const struct credential *c)
+{
+	int i;
+	for (i = 0; i < entries_nr; i++) {
+		struct credential *e = &entries[i].item;
+
+		/* We must either both have the same unique token,
+		 * or we must not be using unique tokens at all. */
+		if (e->unique) {
+			if (!c->unique || strcmp(e->unique, c->unique))
+				continue;
+		}
+		else if (c->unique)
+			continue;
+
+		/* If we have a username, it must match. Otherwise,
+		 * we will fill in the username. */
+		if (c->username && strcmp(e->username, c->username))
+			continue;
+
+		return &entries[i];
+	}
+	return NULL;
+}
+
+static void remove_credential(const struct credential *c)
+{
+	struct credential_cache_entry *e;
+
+	e = lookup_credential(c);
+	if (e)
+		e->expiration = 0;
+}
+
+static int check_expirations(void)
+{
+	int i = 0;
+	unsigned long now = time(NULL);
+	unsigned long next = (unsigned long)-1;
+
+	while (i < entries_nr) {
+		if (entries[i].expiration <= now) {
+			entries_nr--;
+			if (!entries_nr)
+				return 0;
+			free(entries[i].item.description);
+			free(entries[i].item.unique);
+			free(entries[i].item.username);
+			free(entries[i].item.password);
+			memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));
+		}
+		else {
+			if (entries[i].expiration < next)
+				next = entries[i].expiration;
+			i++;
+		}
+	}
+
+	return next - now;
+}
+
+static int read_credential_request(FILE *fh, struct credential *c,
+				   char **action, int *timeout) {
+	struct strbuf item = STRBUF_INIT;
+
+	while (strbuf_getline(&item, fh, '\0') != EOF) {
+		char *key = item.buf;
+		char *value = strchr(key, '=');
+
+		if (!value) {
+			warning("cache client sent bogus input: %s", key);
+			strbuf_release(&item);
+			return -1;
+		}
+		*value++ = '\0';
+
+		if (!strcmp(key, "action"))
+			*action = xstrdup(value);
+		else if (!strcmp(key, "unique"))
+			c->unique = xstrdup(value);
+		else if (!strcmp(key, "username"))
+			c->username = xstrdup(value);
+		else if (!strcmp(key, "password"))
+			c->password = xstrdup(value);
+		else if (!strcmp(key, "timeout"))
+			*timeout = atoi(value);
+		else {
+			warning("cache client sent bogus key: %s", key);
+			strbuf_release(&item);
+			return -1;
+		}
+	}
+	strbuf_release(&item);
+	return 0;
+}
+
+static void serve_one_client(FILE *in, FILE *out)
+{
+	struct credential c = { NULL };
+	int timeout = -1;
+	char *action = NULL;
+
+	if (read_credential_request(in, &c, &action, &timeout) < 0)
+		return;
+
+	if (!action) {
+		warning("cache client didn't specify an action");
+		return;
+	}
+
+	if (!strcmp(action, "exit"))
+		exit(0);
+
+	if (!strcmp(action, "get")) {
+		struct credential_cache_entry *e = lookup_credential(&c);
+		if (e) {
+			fprintf(out, "username=%s\n", e->item.username);
+			fprintf(out, "password=%s\n", e->item.password);
+		}
+		return;
+	}
+
+	if (!strcmp(action, "erase")) {
+		remove_credential(&c);
+		return;
+	}
+
+	if (!strcmp(action, "store")) {
+		if (timeout < 0) {
+			warning("cache client didn't specify a timeout");
+			return;
+		}
+
+		remove_credential(&c);
+		cache_credential(&c, timeout);
+		return;
+	}
+
+	warning("cache client sent unknown action: %s", action);
+	return;
+}
+
+static int serve_cache_loop(int fd)
+{
+	struct pollfd pfd;
+	unsigned long wakeup;
+
+	wakeup = check_expirations();
+	if (!wakeup)
+		return 0;
+
+	pfd.fd = fd;
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, 1000 * wakeup) < 0) {
+		if (errno != EINTR)
+			die_errno("poll failed");
+		return 1;
+	}
+
+	if (pfd.revents & POLLIN) {
+		int client, client2;
+		FILE *in, *out;
+
+		client = accept(fd, NULL, NULL);
+		if (client < 0) {
+			warning("accept failed: %s", strerror(errno));
+			return 1;
+		}
+		client2 = dup(client);
+		if (client2 < 0) {
+			warning("dup failed: %s", strerror(errno));
+			close(client);
+			return 1;
+		}
+
+		in = xfdopen(client, "r");
+		out = xfdopen(client2, "w");
+		serve_one_client(in, out);
+		fclose(in);
+		fclose(out);
+	}
+	return 1;
+}
+
+static void serve_cache(const char *socket_path)
+{
+	int fd;
+
+	fd = unix_stream_listen(socket_path);
+	if (fd < 0)
+		die_errno("unable to bind to '%s'", socket_path);
+
+	printf("ok\n");
+	fclose(stdout);
+
+	while (serve_cache_loop(fd))
+		; /* nothing */
+
+	close(fd);
+	unlink(socket_path);
+}
+
+static const char permissions_advice[] =
+"The permissions on your socket directory are too loose; other\n"
+"users may be able to read your cached credentials. Consider running:\n"
+"\n"
+"	chmod 0700 %s";
+static void check_socket_directory(const char *path)
+{
+	struct stat st;
+	char *path_copy = xstrdup(path);
+	char *dir = dirname(path_copy);
+
+	if (!stat(dir, &st)) {
+		if (st.st_mode & 077)
+			die(permissions_advice, dir);
+		free(path_copy);
+		return;
+	}
+
+	/*
+	 * We must be sure to create the directory with the correct mode,
+	 * not just chmod it after the fact; otherwise, there is a race
+	 * condition in which somebody can chdir to it, sleep, then try to open
+	 * our protected socket.
+	 */
+	if (safe_create_leading_directories_const(dir) < 0)
+		die_errno("unable to create directories for '%s'", dir);
+	if (mkdir(dir, 0700) < 0)
+		die_errno("unable to mkdir '%s'", dir);
+	free(path_copy);
+}
+
+int main(int argc, const char **argv)
+{
+	const char *socket_path = argv[1];
+
+	if (!socket_path)
+		die("usage: git-credential-cache--daemon <socket_path>");
+	check_socket_directory(socket_path);
+
+	serve_cache(socket_path);
+
+	return 0;
+}
diff --git a/credential-cache.c b/credential-cache.c
new file mode 100644
index 0000000..f495043
--- /dev/null
+++ b/credential-cache.c
@@ -0,0 +1,163 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+#include "parse-options.h"
+#include "unix-socket.h"
+#include "run-command.h"
+
+static int send_request(const char *socket, const struct strbuf *out)
+{
+	int got_data = 0;
+	int fd = unix_stream_connect(socket);
+
+	if (fd < 0)
+		return -1;
+
+	if (write_in_full(fd, out->buf, out->len) < 0)
+		die_errno("unable to write to cache daemon");
+	shutdown(fd, SHUT_WR);
+
+	while (1) {
+		char in[1024];
+		int r;
+
+		r = read_in_full(fd, in, sizeof(in));
+		if (r == 0)
+			break;
+		if (r < 0)
+			die_errno("read error from cache daemon");
+		write_or_die(1, in, r);
+		got_data = 1;
+	}
+	return got_data;
+}
+
+static void out_str(struct strbuf *out, const char *key, const char *value)
+{
+	if (!value)
+		return;
+	strbuf_addf(out, "%s=%s", key, value);
+	strbuf_addch(out, '\0');
+}
+
+static void out_int(struct strbuf *out, const char *key, int value)
+{
+	strbuf_addf(out, "%s=%d", key, value);
+	strbuf_addch(out, '\0');
+}
+
+static int do_cache(const char *socket, const char *action,
+		    const struct credential *c, int timeout)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	out_str(&buf, "action", action);
+	if (c) {
+		out_str(&buf, "unique", c->unique);
+		out_str(&buf, "username", c->username);
+		out_str(&buf, "password", c->password);
+	}
+	if (timeout > 0)
+		out_int(&buf, "timeout", timeout);
+
+	ret = send_request(socket, &buf);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void spawn_daemon(const char *socket)
+{
+	struct child_process daemon;
+	const char *argv[] = { NULL, NULL, NULL };
+	char buf[128];
+	int r;
+
+	memset(&daemon, 0, sizeof(daemon));
+	argv[0] = "git-credential-cache--daemon";
+	argv[1] = socket;
+	daemon.argv = argv;
+	daemon.no_stdin = 1;
+	daemon.out = -1;
+
+	if (start_command(&daemon))
+		die_errno("unable to start cache daemon");
+	r = read_in_full(daemon.out, buf, sizeof(buf));
+	if (r < 0)
+		die_errno("unable to read result code from cache daemon");
+	if (r != 3 || memcmp(buf, "ok\n", 3))
+		die("cache daemon did not start: %.*s", r, buf);
+	close(daemon.out);
+}
+
+int main(int argc, const char **argv)
+{
+	struct credential c = { NULL };
+	char *socket_path = NULL;
+	int timeout = 900;
+	struct string_list chain = STRING_LIST_INIT_NODUP;
+	int exit_mode = 0;
+	int reject_mode = 0;
+	const char * const usage[] = {
+		"git credential-cache [options]",
+		NULL
+	};
+	struct option options[] = {
+		OPT_BOOLEAN(0, "exit", &exit_mode,
+			    "tell a running daemon to exit"),
+		OPT_BOOLEAN(0, "reject", &reject_mode,
+			    "reject a cached credential"),
+		OPT_INTEGER(0, "timeout", &timeout,
+			    "number of seconds to cache credentials"),
+		OPT_STRING(0, "socket", &socket_path, "path",
+			   "path of cache-daemon socket"),
+		OPT_STRING_LIST(0, "chain", &chain, "helper",
+				"use <helper> to get non-cached credentials"),
+		OPT_STRING(0, "username", &c.username, "name",
+			   "an existing username"),
+		OPT_STRING(0, "description", &c.description, "desc",
+			   "human-readable description of the credential"),
+		OPT_STRING(0, "unique", &c.unique, "token",
+			   "a unique context for the credential"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc)
+		usage_with_options(usage, options);
+	/* credential_reject wants to free() these */
+	if (c.username)
+		c.username = xstrdup(c.username);
+	if (c.password)
+		c.password = xstrdup(c.password);
+
+	if (!socket_path)
+		socket_path = expand_user_path("~/.git-credential-cache/socket");
+	if (!socket_path)
+		die("unable to find a suitable socket path; use --socket");
+
+	if (exit_mode) {
+		do_cache(socket_path, "exit", NULL, -1);
+		return 0;
+	}
+
+	if (reject_mode) {
+		do_cache(socket_path, "erase", &c, -1);
+		credential_reject(&c, &chain);
+		return 0;
+	}
+
+	if (do_cache(socket_path, "get", &c, -1) > 0)
+		return 0;
+
+	credential_fill(&c, &chain);
+	printf("username=%s\n", c.username);
+	printf("password=%s\n", c.password);
+
+	if (do_cache(socket_path, "store", &c, timeout) < 0) {
+		spawn_daemon(socket_path);
+		do_cache(socket_path, "store", &c, timeout);
+	}
+	return 0;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index a75530d..8cced82 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -130,6 +130,7 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+#include <sys/un.h>
 #ifndef NO_INTTYPES_H
 #include <inttypes.h>
 #else
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 68d838c..994a0aa 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -182,4 +182,95 @@ test_expect_success 'internal getpass can pull from config' '
 	EOF
 '
 
+test_expect_success 'credential-cache caches password' '
+	test_when_finished "git credential-cache --exit" &&
+	check --unique=host cache <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --unique=host cache <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	EOF
+'
+
+test_expect_success 'credential-cache requires matching unique token' '
+	test_when_finished "git credential-cache --exit" &&
+	check --unique=host cache <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --unique=host2 cache <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
+test_expect_success 'credential-cache requires matching usernames' '
+	test_when_finished "git credential-cache --exit" &&
+	check --unique=host cache <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --unique=host --username=other cache <<-\EOF
+	username=other
+	password=askpass-result
+	--
+	askpass: Password:
+	EOF
+'
+
+test_expect_success 'credential-cache times out' '
+	test_when_finished "git credential-cache --exit || true" &&
+	check --unique=host "cache --timeout=1" <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	sleep 2 &&
+	check --unique=host cache <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
+test_expect_success 'credential-cache removes rejected credentials' '
+	test_when_finished "git credential-cache --exit || true" &&
+	check --unique=host cache <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --reject --unique=host --username=askpass-result cache <<-\EOF &&
+	--
+	EOF
+	check --unique=host cache <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
 test_done
diff --git a/unix-socket.c b/unix-socket.c
new file mode 100644
index 0000000..cf9890f
--- /dev/null
+++ b/unix-socket.c
@@ -0,0 +1,58 @@
+#include "cache.h"
+#include "unix-socket.h"
+
+static int unix_stream_socket(void)
+{
+	int fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		die_errno("unable to create socket");
+	return fd;
+}
+
+static void unix_sockaddr_init(struct sockaddr_un *sa, const char *path)
+{
+	int size = strlen(path) + 1;
+	if (size > sizeof(sa->sun_path))
+		die("socket path is too long to fit in sockaddr");
+	memset(sa, 0, sizeof(*sa));
+	sa->sun_family = AF_UNIX;
+	memcpy(sa->sun_path, path, size);
+}
+
+int unix_stream_connect(const char *path)
+{
+	int fd;
+	struct sockaddr_un sa;
+
+	unix_sockaddr_init(&sa, path);
+	fd = unix_stream_socket();
+	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
+int unix_stream_listen(const char *path)
+{
+	int fd;
+	struct sockaddr_un sa;
+
+	unix_sockaddr_init(&sa, path);
+	fd = unix_stream_socket();
+
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		unlink(path);
+		if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+			close(fd);
+			return -1;
+		}
+	}
+
+	if (listen(fd, 5) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
diff --git a/unix-socket.h b/unix-socket.h
new file mode 100644
index 0000000..e271aee
--- /dev/null
+++ b/unix-socket.h
@@ -0,0 +1,7 @@
+#ifndef UNIX_SOCKET_H
+#define UNIX_SOCKET_H
+
+int unix_stream_connect(const char *path);
+int unix_stream_listen(const char *path);
+
+#endif /* UNIX_SOCKET_H */
-- 
1.7.6.rc1.12.g65e2
