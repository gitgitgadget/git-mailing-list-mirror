From: Jeff King <peff@peff.net>
Subject: [PATCH 10/13] credentials: add "cache" helper
Date: Thu, 24 Nov 2011 06:07:10 -0500
Message-ID: <20111124110710.GH8417@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 12:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX9H-0006gB-6K
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab1KXLHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:07:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49651
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab1KXLHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:07:13 -0500
Received: (qmail 10329 invoked by uid 107); 24 Nov 2011 11:07:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 06:07:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 06:07:10 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185905>

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
This required some rewriting to handle the new helper protocol. I also
incorporated suggestions from Ramsay Jones to handle cleanup of the
socket better.

I suspect this will all have to get turned off for msysgit, unless
somebody feels like writing a unix-sockets abstraction layer.

 .gitignore                                     |    2 +
 Documentation/git-credential-cache--daemon.txt |   26 +++
 Documentation/git-credential-cache.txt         |   77 +++++++
 Documentation/gitcredentials.txt               |   17 +-
 Makefile                                       |    3 +
 credential-cache--daemon.c                     |  269 ++++++++++++++++++++++++
 credential-cache.c                             |  120 +++++++++++
 git-compat-util.h                              |    1 +
 t/lib-credential.sh                            |  219 +++++++++++++++++++
 t/t0301-credential-cache.sh                    |   18 ++
 unix-socket.c                                  |   56 +++++
 unix-socket.h                                  |    7 +
 12 files changed, 810 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-credential-cache--daemon.txt
 create mode 100644 Documentation/git-credential-cache.txt
 create mode 100644 credential-cache--daemon.c
 create mode 100644 credential-cache.c
 create mode 100755 t/t0301-credential-cache.sh
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
index 0000000..f3d09c5
--- /dev/null
+++ b/Documentation/git-credential-cache.txt
@@ -0,0 +1,77 @@
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
+This command caches credentials in memory for use by future git
+programs. The stored credentials never touch the disk, and are forgotten
+after a configurable timeout.  The cache is accessible over a Unix
+domain socket, restricted to the current user by filesystem permissions.
+
+You probably don't want to invoke this command directly; it is meant to
+be used as a credential helper by other parts of git. See
+linkgit:gitcredentials[7] or `EXAMPLES` below.
+
+OPTIONS
+-------
+
+--timeout <seconds>::
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
+CONTROLLING THE DAEMON
+----------------------
+
+If you would like the daemon to exit early, forgetting all cached
+credentials before their timeout, you can issue an `exit` action:
+
+--------------------------------------
+git credential-cache exit
+--------------------------------------
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
+-------------------------------------------------------
+$ git config credential.helper 'cache --timeout=300'
+-------------------------------------------------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 1e54117..a1592ed 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -63,11 +63,18 @@ Credential helpers, on the other hand, are external programs from which git can
 request both usernames and passwords; they typically interface with secure
 storage provided by the OS or other programs.
 
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
index 5ca363b..5d41c29 100644
--- a/Makefile
+++ b/Makefile
@@ -427,6 +427,8 @@ PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
+PROGRAM_OBJS += credential-cache.o
+PROGRAM_OBJS += credential-cache--daemon.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
@@ -699,6 +701,7 @@ LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
+LIB_OBJS += unix-socket.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += url.o
 LIB_OBJS += usage.o
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
new file mode 100644
index 0000000..390f194
--- /dev/null
+++ b/credential-cache--daemon.c
@@ -0,0 +1,269 @@
+#include "cache.h"
+#include "credential.h"
+#include "unix-socket.h"
+#include "sigchain.h"
+
+static const char *socket_path;
+
+static void cleanup_socket(void)
+{
+	if (socket_path)
+		unlink(socket_path);
+}
+
+static void cleanup_socket_on_signal(int sig)
+{
+	cleanup_socket();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+struct credential_cache_entry {
+	struct credential item;
+	unsigned long expiration;
+};
+static struct credential_cache_entry *entries;
+static int entries_nr;
+static int entries_alloc;
+
+static void cache_credential(struct credential *c, int timeout)
+{
+	struct credential_cache_entry *e;
+
+	ALLOC_GROW(entries, entries_nr + 1, entries_alloc);
+	e = &entries[entries_nr++];
+
+	/* take ownership of pointers */
+	memcpy(&e->item, c, sizeof(*c));
+	memset(c, 0, sizeof(*c));
+	e->expiration = time(NULL) + timeout;
+}
+
+static struct credential_cache_entry *lookup_credential(const struct credential *c)
+{
+	int i;
+	for (i = 0; i < entries_nr; i++) {
+		struct credential *e = &entries[i].item;
+		if (credential_match(c, e))
+			return &entries[i];
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
+	static unsigned long wait_for_entry_until;
+	int i = 0;
+	unsigned long now = time(NULL);
+	unsigned long next = (unsigned long)-1;
+
+	/*
+	 * Initially give the client 30 seconds to actually contact us
+	 * and store a credential before we decide there's no point in
+	 * keeping the daemon around.
+	 */
+	if (!wait_for_entry_until)
+		wait_for_entry_until = now + 30;
+
+	while (i < entries_nr) {
+		if (entries[i].expiration <= now) {
+			entries_nr--;
+			credential_clear(&entries[i].item);
+			if (i != entries_nr)
+				memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));
+			/*
+			 * Stick around 30 seconds in case a new credential
+			 * shows up (e.g., because we just removed a failed
+			 * one, and we will soon get the correct one).
+			 */
+			wait_for_entry_until = now + 30;
+		}
+		else {
+			if (entries[i].expiration < next)
+				next = entries[i].expiration;
+			i++;
+		}
+	}
+
+	if (!entries_nr) {
+		if (wait_for_entry_until <= now)
+			return 0;
+		next = wait_for_entry_until;
+	}
+
+	return next - now;
+}
+
+static int read_request(FILE *fh, struct credential *c,
+			struct strbuf *action, int *timeout) {
+	static struct strbuf item = STRBUF_INIT;
+	const char *p;
+
+	strbuf_getline(&item, fh, '\n');
+	p = skip_prefix(item.buf, "action=");
+	if (!p)
+		return error("client sent bogus action line: %s", item.buf);
+	strbuf_addstr(action, p);
+
+	strbuf_getline(&item, fh, '\n');
+	p = skip_prefix(item.buf, "timeout=");
+	if (!p)
+		return error("client sent bogus timeout line: %s", item.buf);
+	*timeout = atoi(p);
+
+	if (credential_read(c, fh) < 0)
+		return -1;
+	return 0;
+}
+
+static void serve_one_client(FILE *in, FILE *out)
+{
+	struct credential c = CREDENTIAL_INIT;
+	struct strbuf action = STRBUF_INIT;
+	int timeout = -1;
+
+	if (read_request(in, &c, &action, &timeout) < 0)
+		/* ignore error */ ;
+	else if (!strcmp(action.buf, "get")) {
+		struct credential_cache_entry *e = lookup_credential(&c);
+		if (e) {
+			fprintf(out, "username=%s\n", e->item.username);
+			fprintf(out, "password=%s\n", e->item.password);
+		}
+	}
+	else if (!strcmp(action.buf, "exit"))
+		exit(0);
+	else if (!strcmp(action.buf, "erase"))
+		remove_credential(&c);
+	else if (!strcmp(action.buf, "store")) {
+		if (timeout < 0)
+			warning("cache client didn't specify a timeout");
+		else if (!c.username || !c.password)
+			warning("cache client gave us a partial credential");
+		else {
+			remove_credential(&c);
+			cache_credential(&c, timeout);
+		}
+	}
+	else
+		warning("cache client sent unknown action: %s", action.buf);
+
+	credential_clear(&c);
+	strbuf_release(&action);
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
+	socket_path = argv[1];
+
+	if (!socket_path)
+		die("usage: git-credential-cache--daemon <socket_path>");
+	check_socket_directory(socket_path);
+
+	atexit(cleanup_socket);
+	sigchain_push_common(cleanup_socket_on_signal);
+
+	serve_cache(socket_path);
+
+	return 0;
+}
diff --git a/credential-cache.c b/credential-cache.c
new file mode 100644
index 0000000..482c4b1
--- /dev/null
+++ b/credential-cache.c
@@ -0,0 +1,120 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+#include "parse-options.h"
+#include "unix-socket.h"
+#include "run-command.h"
+
+#define FLAG_SPAWN 0x1
+#define FLAG_RELAY 0x2
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
+static void do_cache(const char *socket, const char *action, int timeout,
+		     int flags)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "action=%s\n", action);
+	strbuf_addf(&buf, "timeout=%d\n", timeout);
+	if (flags & FLAG_RELAY) {
+		if (strbuf_read(&buf, 0, 0) < 0)
+			die_errno("unable to relay credential");
+	}
+
+	if (!send_request(socket, &buf))
+		return;
+	if (flags & FLAG_SPAWN) {
+		spawn_daemon(socket);
+		send_request(socket, &buf);
+	}
+	strbuf_release(&buf);
+}
+
+int main(int argc, const char **argv)
+{
+	char *socket_path = NULL;
+	int timeout = 900;
+	const char *op;
+	const char * const usage[] = {
+		"git credential-cache [options] <action>",
+		NULL
+	};
+	struct option options[] = {
+		OPT_INTEGER(0, "timeout", &timeout,
+			    "number of seconds to cache credentials"),
+		OPT_STRING(0, "socket", &socket_path, "path",
+			   "path of cache-daemon socket"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (!argc)
+		usage_with_options(usage, options);
+	op = argv[0];
+
+	if (!socket_path)
+		socket_path = expand_user_path("~/.git-credential-cache/socket");
+	if (!socket_path)
+		die("unable to find a suitable socket path; use --socket");
+
+	if (!strcmp(op, "exit"))
+		do_cache(socket_path, op, timeout, 0);
+	else if (!strcmp(op, "get") || !strcmp(op, "erase"))
+		do_cache(socket_path, op, timeout, FLAG_RELAY);
+	else if (!strcmp(op, "store"))
+		do_cache(socket_path, op, timeout, FLAG_RELAY|FLAG_SPAWN);
+	else
+		die("unknown operation: %s", op);
+
+	return 0;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 8b4dd5c..5c238bd 100644
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
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 54ae1f4..ac54b38 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -21,6 +21,225 @@ read_chunk() {
 	done
 }
 
+# Clear any residual data from previous tests. We only
+# need this when testing third-party helpers which read and
+# write outside of our trash-directory sandbox.
+#
+# Don't bother checking for success here, as it is
+# outside the scope of tests and represents a best effort to
+# clean up after ourselves.
+helper_test_clean() {
+	reject $1 https example.com store-user
+	reject $1 https example.com user1
+	reject $1 https example.com user2
+	reject $1 ftp other.tld user
+	reject $1 https timeout.tld user
+}
+
+reject() {
+	(
+		echo protocol=$2
+		echo host=$3
+		echo username=$4
+	) | test-credential reject $1
+}
+
+helper_test() {
+	HELPER=$1
+
+	test_expect_success "helper ($HELPER) has no existing data" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://example.com'\'':
+		askpass: Password for '\''https://askpass-username@example.com'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) stores password" '
+		check approve $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=store-user
+		password=store-pass
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) can retrieve password" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		username=store-user
+		password=store-pass
+		--
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) requires matching protocol" '
+		check fill $HELPER <<-\EOF
+		protocol=http
+		host=example.com
+		--
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''http://example.com'\'':
+		askpass: Password for '\''http://askpass-username@example.com'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) requires matching host" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=other.tld
+		--
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://other.tld'\'':
+		askpass: Password for '\''https://askpass-username@other.tld'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) requires matching username" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=other
+		--
+		username=other
+		password=askpass-password
+		--
+		askpass: Password for '\''https://other@example.com'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) requires matching path" '
+		check approve $HELPER <<-\EOF &&
+		protocol=ftp
+		host=other.tld
+		path=foo.git
+		username=user
+		password=pass
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=ftp
+		host=other.tld
+		path=bar.git
+		--
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''ftp://other.tld/bar.git'\'':
+		askpass: Password for '\''ftp://askpass-username@other.tld/bar.git'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) can forget host" '
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://example.com'\'':
+		askpass: Password for '\''https://askpass-username@example.com'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) can store multiple users" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user1
+		password=pass1
+		EOF
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user2
+		password=pass2
+		EOF
+		check fill $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user1
+		--
+		username=user1
+		password=pass1
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user2
+		--
+		username=user2
+		password=pass2
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) can forget user" '
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user1
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user1
+		--
+		username=user1
+		password=askpass-password
+		--
+		askpass: Password for '\''https://user1@example.com'\'':
+	'
+
+	test_expect_success "helper ($HELPER) remembers other user" '
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		username=user2
+		--
+		username=user2
+		password=pass2
+		EOF
+	'
+}
+
+helper_test_timeout() {
+	HELPER="$*"
+
+	test_expect_success "helper ($HELPER) times out" '
+		check approve "$HELPER" <<-\EOF &&
+		protocol=https
+		host=timeout.tld
+		username=user
+		password=pass
+		EOF
+		sleep 2 &&
+		check fill "$HELPER" <<-\EOF
+		protocol=https
+		host=timeout.tld
+		--
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://timeout.tld'\'':
+		askpass: Password for '\''https://askpass-username@timeout.tld'\'':
+		EOF
+	'
+}
 
 cat >askpass <<\EOF
 #!/bin/sh
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
new file mode 100755
index 0000000..3a65f99
--- /dev/null
+++ b/t/t0301-credential-cache.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='credential-cache tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+# don't leave a stale daemon running
+trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
+
+helper_test cache
+helper_test_timeout cache --timeout=1
+
+# we can't rely on our "trap" above working after test_done,
+# as test_done will delete the trash directory containing
+# our socket, leaving us with no way to access the daemon.
+git credential-cache exit
+
+test_done
diff --git a/unix-socket.c b/unix-socket.c
new file mode 100644
index 0000000..84b1509
--- /dev/null
+++ b/unix-socket.c
@@ -0,0 +1,56 @@
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
+	unlink(path);
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		close(fd);
+		return -1;
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
1.7.7.4.5.gb32a5
