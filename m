From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC] Secure central repositories by UNIX socket authentication
Date: Sun, 27 Jan 2008 05:39:35 -0500
Message-ID: <20080127103934.GA2735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 11:40:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ4w6-0003nd-VS
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 11:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYA0Kjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 05:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbYA0Kjn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 05:39:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37690 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYA0Kjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 05:39:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJ4vG-0001X7-NH
	for git@vger.kernel.org; Sun, 27 Jan 2008 05:39:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AED0520FBAE; Sun, 27 Jan 2008 05:39:35 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71813>

This isn't anywhere near ready for application, but I'm floating
it out there to see what people think.  Its a cool new feature that
will certainly *not* be in 1.5.4.  :-)

In a central repository configuration users may not have access
to write new objects into a Git repository, or to edit the refs,
especially if the repository is being protected by an update hook
(e.g. contrib/hooks/updated-paranoid).

This change allows any repository owner to setup a git-daemon
that other users on the same host can connect through to perform
upload-pack or receive-pack.  It also allows the update hook to
authorize the user via $GIT_REMOTE_USER.  For example:

    ## Owner (not jdoe)
    ##
  cat >foo.git/hooks/update <<'EOF'
  #!/bin/sh
  test -z "$GIT_REMOTE_USER" || exit
  case "$GIT_REMOTE_USER" in
  jdoe)     exit 0;;
  spearce)  exit 0;;
  *)        exit 1
  esac
  EOF
  chmod u+x foo.git/hooks/update
  chmod 700 foo.git

  git daemon \
      --export-all \
      --enable=receive-pack \
      --base=`pwd` \
      --listen=/tmp/shawn-git

    ## Other User
    ##
  git push jdoe@server:/tmp/shawn-git/foo.git master

allows user jdoe to push into foo.git, even though it is restricted.
This works by:

  *) git-push executes
     "ssh jdoe@server git-receive-pack /tmp/shawn-git/foo.git"

  *) git-receive-pack realizes its actually a socket, connects
     to /tmp/shawn-git and asks for service "git-receive-pack"
     on directory "/foo.git"

  *) git-daemon authenticates the user via the kernel's secure
     peer id call and sets GIT_REMOTE_USER with their username.

  *) git-daemon starts another git-receive-pack on foo.git, using
     its normal access control and path resolving rules.

  *) The first git-receive-pack acts as a shuttle to copy
     data between the two peers.

  *) The second git-receive-pack runs the update hook, which has
     GIT_REMOTE_USER defined from git-daemon.


There's a few small problems with this, which is partly why this
isn't ready for application yet:

1) Error messages from the pre-receive or update hooks don't make it
   back to the client as send-pack and receive-pack don't implement
   the sideband protocol.  This is harder than it sounds as the
   pkt-line protocol they currently use for status can't be easily
   layered into a sideband protocol.

2) There is currently no "authorization" hook for upload-pack (aka
   the fetch server) like we have for receive-pack (aka the push
   server) so we cannot make use of $GIT_REMOTE_USER to perform
   user authorization.  Currently Git relies on UNIX filesystem
   access, but this daemon approach bypasses those.  There was a
   conversation on #git tonight about adding a hook that filters
   the list of allowed refs during fetch, for exactly this reason.

3) The system call to get the peer UID via the kernel is not POSIX
   so its implemented differently on basically every OS we support,
   if it is even implemented there.  The patch below should provide
   support for Solaris 8/9/10, FreeBSD, Darwin/Mac OS X, and Linux.
   But is thus far only tested on Mac OS 10.4.

---

 Documentation/git-daemon.txt |   11 ++-
 Makefile                     |   14 ++-
 builtin-upload-archive.c     |    3 +
 daemon-redirect.c            |  282 ++++++++++++++++++++++++++++++++++++++++++
 daemon-redirect.h            |   12 ++
 daemon.c                     |  132 +++++++++++++++-----
 git-compat-util.h            |    1 +
 receive-pack.c               |    3 +
 upload-pack.c                |    3 +
 9 files changed, 429 insertions(+), 32 deletions(-)
 create mode 100644 daemon-redirect.c
 create mode 100644 daemon-redirect.h

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fd83bc7..1f9d9a1 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -15,7 +15,7 @@ SYNOPSIS
              [--reuseaddr] [--detach] [--pid-file=file]
              [--enable=service] [--disable=service]
 	     [--allow-override=service] [--forbid-override=service]
-	     [--inetd | [--listen=host_or_ipaddr] [--port=n] [--user=user [--group=group]]
+	     [--inetd | [--listen=host_or_ipaddr_or_path] [--port=n] [--user=user [--group=group]]
 	     [directory...]
 
 DESCRIPTION
@@ -79,12 +79,19 @@ OPTIONS
 	Have the server run as an inetd service. Implies --syslog.
 	Incompatible with --port, --listen, --user and --group options.
 
---listen=host_or_ipaddr::
+--listen=host_or_ipaddr_or_path::
 	Listen on an a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPV6 address if supported.  If IPv6
 	is not supported, then --listen=hostname is also not supported and
 	--listen must be given an IPv4 address.
 	Incompatible with '--inetd' option.
++
+If the address is an absolute path in the filesystem then git-daemon
+listens on a UNIX domain socket at the given path.  This can be used
+to support authenticated redirection from linkgit:git-upload-pack[1]
+or linkgit:git-receive-pack[1].  Child processes (including hooks)
+can obtain the authenticated username from the `GIT_REMOTE_USER`
+environment variable.
 
 --port=n::
 	Listen on an alternative port.  Incompatible with '--inetd' option.
diff --git a/Makefile b/Makefile
index a0c0998..6f8f3ad 100644
--- a/Makefile
+++ b/Makefile
@@ -295,7 +295,8 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h \
+	daemon-redirect.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -309,6 +310,7 @@ LIB_OBJS = \
 	lockfile.o \
 	patch-ids.o \
 	object.o pack-check.o pack-write.o patch-delta.o path.o pkt-line.o \
+	daemon-redirect.o \
 	sideband.o reachable.o reflog-walk.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
@@ -417,6 +419,7 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	HAVE_GETPEEREID = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -426,6 +429,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
+	HAVE_STREAMS_CONNLD = YesPlease
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
@@ -463,6 +467,7 @@ endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
 	NO_MEMMEM = YesPlease
+	HAVE_GETPEEREID = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 endif
@@ -470,6 +475,7 @@ ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	HAVE_GETPEEREID = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 endif
@@ -659,6 +665,12 @@ else
 	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in6
 endif
 endif
+ifdef HAVE_STREAMS_CONNLD
+	BASIC_CFLAGS += -DHAVE_STREAMS_CONNLD
+endif
+ifdef HAVE_GETPEEREID
+	BASIC_CFLAGS += -DHAVE_GETPEEREID
+endif
 ifdef NO_INET_NTOP
 	LIB_OBJS += compat/inet_ntop.o
 endif
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 48ae09e..5599e3b 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
+#include "daemon-redirect.h"
 #include "sideband.h"
 
 static const char upload_archive_usage[] =
@@ -35,6 +36,8 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 
 	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
 
+	if (redirect_execute("upload-archive", buf))
+		return 0;
 	if (!enter_repo(buf, 0))
 		die("not a git archive");
 
diff --git a/daemon-redirect.c b/daemon-redirect.c
new file mode 100644
index 0000000..8474ddd
--- /dev/null
+++ b/daemon-redirect.c
@@ -0,0 +1,282 @@
+#include "daemon-redirect.h"
+#include "pkt-line.h"
+
+static int redirect_connect(const char *path);
+
+#ifdef HAVE_STREAMS_CONNLD
+
+int redirect_listen(const char *path)
+{
+	int fd_pair[2];
+
+	if (pipe(fd_pair) || ioctl(fd_pair[0], I_PUSH, "connld"))
+		die("redirect listen failed: %s", strerror(errno));
+	ioctl(fd_pair[0], I_CANPUT, 0);
+
+	unlink(path);
+	if (close(creat(path, 0666)) || fattach(fd_pair[0], path))
+		die("redirect listen failed on %s: %s", path, strerror(errno));
+	close(fd_pair[0]); /* can i really do that? */
+	return fd_pair[1];
+}
+
+int redirect_accept(int srv_fd, uid_t *cli_uid)
+{
+	struct strrecvfd rfd;
+
+	if (ioctl(srv_fd, I_RECVFD, &rfd))
+		return -1;
+	*cli_uid = rfd.uid;
+	return rfd.fd;
+}
+
+static int redirect_connect(const char *path)
+{
+	int cli_fd = open(path, O_RDWR);
+	if (cli_fd < 0)
+		die("redirect connect failed on %s: %s", path, strerror(errno));
+	return cli_fd;
+}
+
+#else /* ! HAVE_STREAMS_CONNLD */
+
+int redirect_listen(const char *path)
+{
+	int srv_fd;
+	struct sockaddr_un addr;
+
+	if (strlen(path) > sizeof(addr.sun_path))
+		die("redirect listen path too long");
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, path);
+	unlink(path);
+
+	srv_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (srv_fd < 0)
+		die("redirect listen failed: %s", strerror(errno));
+	if (bind(srv_fd, (struct sockaddr*)&addr, sizeof(addr)))
+		die("redirect listen failed on %s: %s", path, strerror(errno));
+	if (listen(srv_fd, 10))
+		die("redirect listen failed: %s", strerror(errno));
+
+	return srv_fd;
+}
+
+static int peer_uid(int cli_fd, uid_t *cli_uid);
+
+#if defined(HAVE_GETPEEREID) /* OpenBSD / FreeBSD / Darwin */
+static int peer_uid(int cli_fd, uid_t *cli_uid)
+{
+	gid_t cli_gid;
+	return getpeereid(cli_fd, cli_uid, &cli_gid);
+}
+#elif defined(SO_PEERCRED) /* Linux */
+static int peer_uid(int cli_fd, uid_t *cli_uid)
+{
+	struct ucred creds;
+	int len = sizeof(creds);
+	if (getsockopt(cli_fd, SOL_SOCKET, SO_PEERCRED, &creds, &len))
+		return -1;
+	*cli_uid = creds.uid;
+}
+#else /* Not supported */
+static int peer_uid(int cli_fd, uid_t *cli_uid)
+{
+	error("UNIX peer authentication not compiled in");
+	errno = ENOSYS;
+	return -1;
+}
+#endif
+
+int redirect_accept(int srv_fd, uid_t *cli_uid)
+{
+	int cli_fd;
+	struct sockaddr_un ss;
+	unsigned int sslen = sizeof(ss);
+
+	cli_fd = accept(srv_fd, (struct sockaddr*)&ss, &sslen);
+	if (cli_fd < 0)
+		return -1;
+
+	if (peer_uid(cli_fd, cli_uid)) {
+		error("redirect accept creds failed: %s", strerror(errno));
+		close(cli_fd);
+		errno = ECONNABORTED;
+		return -1;
+	}
+
+	return cli_fd;
+}
+
+static int redirect_connect(const char *path)
+{
+	int cli_fd;
+	struct sockaddr_un addr;
+
+	if (strlen(path) > sizeof(addr.sun_path))
+		die("redirect socket path too long");
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, path);
+
+	cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (cli_fd < 0)
+		die("redirect connect failed: %s", strerror(errno));
+	if (connect(cli_fd, (struct sockaddr*)&addr, sizeof(addr)))
+		die("redirect connect failed on %s: %s", path, strerror(errno));
+	return cli_fd;
+}
+
+#endif
+
+struct fd_copy_buffer {
+	int live;
+	int in_fd;
+	int out_fd;
+	size_t avail;
+	size_t off;
+	char buf[4096];
+};
+
+static int buf_poll(struct pollfd *p, struct fd_copy_buffer *b)
+{
+	if (!b->live)
+		return 0;
+
+	if (b->avail) {
+		p->fd = b->out_fd;
+		p->events = POLLOUT;
+	} else {
+		p->fd = b->in_fd;
+		p->events = POLLIN;
+	}
+	return 1;
+}
+
+static int buf_copy(struct pollfd *p, struct fd_copy_buffer *b)
+{
+	if (!b->live)
+		return 0;
+
+	if (p->revents & POLLIN) {
+		b->avail = read(b->in_fd, b->buf, sizeof(b->buf));
+		b->off = 0;
+		if (!b->avail) {
+			b->live = 0;
+			close(b->in_fd);
+			shutdown(b->out_fd, 1);
+		} else if (b->avail < 0)
+			die("input failure: %s", strerror(errno));
+	}
+
+	if (p->revents & POLLOUT) {
+		ssize_t r = write(b->out_fd, b->buf + b->off, b->avail);
+		if (r <= 0)
+			die("output failure: %s", strerror(errno));
+		b->avail -= r;
+		b->off += r;
+	}
+
+	return 1;
+}
+
+static void execute(
+	const char *service,
+	const char *sock_name,
+	const char *repo_name)
+{
+	int cli_fd;
+	struct pollfd pfd[2];
+	struct fd_copy_buffer in_buf, out_buf;
+
+	cli_fd = redirect_connect(sock_name);
+	packet_write(cli_fd, "git-%s /%s", service, repo_name);
+
+	in_buf.live = 1;
+	in_buf.in_fd = 0;
+	in_buf.out_fd = cli_fd;
+	in_buf.avail = 0;
+
+	out_buf.live = 1;
+	out_buf.in_fd = cli_fd;
+	out_buf.out_fd = 1;
+	out_buf.avail = 0;
+
+	while (out_buf.live) {
+		int cnt = 0;
+
+		cnt += buf_poll(&pfd[cnt], &in_buf);
+		cnt += buf_poll(&pfd[cnt], &out_buf);
+
+		if (poll(pfd, cnt, -1) < 0) {
+			if (errno != EINTR) {
+				error("poll failed, resuming: %s", strerror(errno));
+				sleep(1);
+			}
+			continue;
+		}
+
+		cnt = 0;
+		cnt += buf_copy(&pfd[cnt], &in_buf);
+		cnt += buf_copy(&pfd[cnt], &out_buf);
+	}
+
+	close(cli_fd);
+}
+
+int redirect_execute(const char *service, const char *path)
+{
+	struct stat sb;
+	char *sock_name, *s, *repo_name;
+
+	/* Exists and is a directory?  Assume the caller is
+	 * the named service and can directly access this
+	 * location itself, without redirect sockets.
+	 */
+	if (!stat(path, &sb) && S_ISDIR(sb.st_mode))
+		return 0;
+	s = strrchr(path, '/');
+	if (!s)
+		return 0;
+
+	sock_name = xstrdup(path);
+	s = sock_name + (s - path);
+	*s = 0;
+	repo_name = s + 1;
+
+	for (;;) {
+		if (!stat(sock_name, &sb)) {
+			if (S_ISDIR(sb.st_mode))
+				break;
+			if (S_ISSOCK(sb.st_mode)) {
+				execute(service, sock_name, repo_name);
+				free(sock_name);
+				return 1;
+			}
+		}
+
+		s = strrchr(sock_name, '/');
+		if (!s || s == sock_name)
+			break;
+
+		*s = 0;
+		*(--repo_name) = '/';
+		repo_name = s + 1;
+	}
+
+	/* Assume redirection shouldn't be applied and that the
+	 * path is also completely incorrect.  Allow the caller
+	 * to handle this error condition as before.
+	 */
+	free(sock_name);
+	return 0;
+}
+
+void redirect_unlisten(int srv_fd, const char *path)
+{
+	close(srv_fd);
+	unlink(path);
+}
diff --git a/daemon-redirect.h b/daemon-redirect.h
new file mode 100644
index 0000000..5d85e10
--- /dev/null
+++ b/daemon-redirect.h
@@ -0,0 +1,12 @@
+#ifndef DAEMON_REDIRECT_H
+#define DAEMON_REDIRECT_H
+
+#include "git-compat-util.h"
+
+extern int redirect_listen(const char *path);
+extern int redirect_accept(int, uid_t *);
+extern void redirect_unlisten(int, const char *);
+
+extern int redirect_execute(const char *, const char *);
+
+#endif
diff --git a/daemon.c b/daemon.c
index 41a60af..6c4897d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "daemon-redirect.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
 #include "interpolate.h"
@@ -16,6 +17,7 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
+static char *listen_addr;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--export-all]\n"
@@ -25,7 +27,7 @@ static const char daemon_usage[] =
 "           [--interpolated-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
-"           [--inetd | [--listen=host_or_ipaddr] [--port=n]\n"
+"           [--inetd | [--listen=host_or_ipaddr_or_path] [--port=n]\n"
 "                      [--user=user [--group=group]]\n"
 "           [directory...]";
 
@@ -318,13 +320,24 @@ static int git_daemon_config(const char *var, const char *value)
 	return 0;
 }
 
-static int run_service(struct interp *itable, struct daemon_service *service)
+static int run_service(struct interp *itable, struct daemon_service *service, uid_t uid)
 {
 	const char *path;
+	struct passwd *pw = getpwuid(uid);
 	int enabled = service->enabled;
+	char *pw_name;
 
-	loginfo("Request %s for '%s'",
+	if (pw)
+		pw_name = xstrdup(pw->pw_name);
+	else {
+		pw_name = xmalloc(64);
+		snprintf(pw_name, 64, "uid %u", uid);
+	}
+	setenv("GIT_REMOTE_USER", pw_name, 1);
+
+	loginfo("Request %s for %s in '%s'",
 		service->name,
+		pw_name,
 		itable[INTERP_SLOT_DIR].value);
 
 	if (!enabled && !service->overridable) {
@@ -530,7 +543,7 @@ static void fill_in_extra_table_entries(struct interp *itable)
 }
 
 
-static int execute(struct sockaddr *addr)
+static int execute(struct sockaddr *addr, uid_t uid)
 {
 	static char line[1000];
 	int pktlen, len, i;
@@ -595,7 +608,7 @@ static int execute(struct sockaddr *addr)
 			 */
 			interp_set_entry(interp_table,
 					 INTERP_SLOT_DIR, line + namelen + 5);
-			return run_service(interp_table, s);
+			return run_service(interp_table, s, uid);
 		}
 	}
 
@@ -636,7 +649,10 @@ static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
 {
 	live_child[idx].pid = pid;
 	live_child[idx].addrlen = addrlen;
-	memcpy(&live_child[idx].address, addr, addrlen);
+	if (addr)
+		memcpy(&live_child[idx].address, addr, addrlen);
+	else
+		memset(&live_child[idx].address, 0, sizeof(live_child[idx].address));
 }
 
 /*
@@ -726,7 +742,7 @@ static void check_max_connections(void)
 	}
 }
 
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, int addrlen, uid_t uid)
 {
 	pid_t pid = fork();
 
@@ -749,7 +765,7 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 	dup2(incoming, 1);
 	close(incoming);
 
-	exit(execute(addr));
+	exit(execute(addr, uid));
 }
 
 static void child_handler(int signo)
@@ -790,7 +806,7 @@ static int set_reuse_addr(int sockfd)
 
 #ifndef NO_IPV6
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int socksetup(int listen_port, int **socklist_p)
 {
 	int socknum = 0, *socklist = NULL;
 	int maxfd = -1;
@@ -864,7 +880,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 #else /* NO_IPV6 */
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int socksetup(int listen_port, int **socklist_p)
 {
 	struct sockaddr_in sin;
 	int sockfd;
@@ -912,8 +928,15 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 #endif
 
+static volatile int end_daemon;
+static void term_handler(int signo)
+{
+	end_daemon = 1;
+}
+
 static int service_loop(int socknum, int *socklist)
 {
+	uid_t uid = getuid();
 	struct pollfd *pfd;
 	int i;
 
@@ -924,9 +947,7 @@ static int service_loop(int socknum, int *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	signal(SIGCHLD, child_handler);
-
-	for (;;) {
+	while (!end_daemon) {
 		int i;
 
 		if (poll(pfd, socknum, -1) < 0) {
@@ -950,13 +971,36 @@ static int service_loop(int socknum, int *socklist)
 					case ECONNABORTED:
 						continue;
 					default:
-						die("accept returned %s", strerror(errno));
+						error("accept returned %s", strerror(errno));
+						return 1;
 					}
 				}
-				handle(incoming, (struct sockaddr *)&ss, sslen);
+				handle(incoming, (struct sockaddr *)&ss, sslen, uid);
 			}
 		}
 	}
+	return 0;
+}
+
+static int redirect_loop(int srv_fd)
+{
+	while (!end_daemon) {
+		uid_t uid;
+		int incoming = redirect_accept(srv_fd, &uid);
+		if (incoming < 0) {
+			switch (errno) {
+			case EAGAIN:
+			case EINTR:
+			case ECONNABORTED:
+				continue;
+			default:
+				error("accept returned %s", strerror(errno));
+				return 1;
+			}
+		}
+		handle(incoming, NULL, 0, uid);
+	}
+	return 0;
 }
 
 /* if any standard file descriptor is missing open it to /dev/null */
@@ -998,27 +1042,51 @@ static void store_pid(const char *path)
 		die("failed to write pid file %s: %s", path, strerror(errno));
 }
 
-static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
+static int serve(int listen_port, struct passwd *pass, gid_t gid)
 {
-	int socknum, *socklist;
-
-	socknum = socksetup(listen_addr, listen_port, &socklist);
-	if (socknum == 0)
-		die("unable to allocate any listen sockets on host %s port %u",
-		    listen_addr, listen_port);
+	int socknum, *socklist, status;
+	int is_redirect = is_absolute_path(listen_addr);
+	struct sigaction sa;
+
+	if (is_redirect) {
+		socknum = 1;
+		socklist = xmalloc(sizeof(int));
+		socklist[0] = redirect_listen(listen_addr);
+	} else {
+		socknum = socksetup(listen_port, &socklist);
+		if (socknum == 0)
+			die("unable to allocate any listen sockets"
+				" on host %s port %u",
+				listen_addr, listen_port);
+	}
 
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
 	     setuid(pass->pw_uid)))
 		die("cannot drop privileges");
 
-	return service_loop(socknum, socklist);
+	signal(SIGCHLD, child_handler);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = term_handler;
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	if (is_redirect) {
+		status = redirect_loop(socklist[0]);
+		redirect_unlisten(socklist[0], listen_addr);
+	} else {
+		status = service_loop(socknum, socklist);
+		while (--socknum >= 0)
+			close(socklist[socknum]);
+	}
+	return status;
 }
 
 int main(int argc, char **argv)
 {
 	int listen_port = 0;
-	char *listen_addr = NULL;
 	int inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
@@ -1038,9 +1106,13 @@ int main(int argc, char **argv)
 		if (!prefixcmp(arg, "--listen=")) {
 		    char *p = arg + 9;
 		    char *ph = listen_addr = xmalloc(strlen(arg + 9) + 1);
-		    while (*p)
-			*ph++ = tolower(*p++);
-		    *ph = 0;
+		    if (is_absolute_path(p))
+				strcpy(ph, p);
+		    else {
+				while (*p)
+					*ph++ = tolower(*p++);
+				*ph = 0;
+		    }
 		    continue;
 		}
 		if (!prefixcmp(arg, "--port=")) {
@@ -1154,6 +1226,8 @@ int main(int argc, char **argv)
 
 	if (inetd_mode && (listen_port || listen_addr))
 		die("--listen= and --port= are incompatible with --inetd");
+	else if (listen_port && listen_addr && is_absolute_path(listen_addr))
+		die("--listen path and --port are incompatible");
 	else if (listen_port == 0)
 		listen_port = DEFAULT_GIT_PORT;
 
@@ -1194,7 +1268,7 @@ int main(int argc, char **argv)
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
 
-		return execute(peer);
+		return execute(peer, getuid());
 	}
 
 	if (detach)
@@ -1205,5 +1279,5 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
-	return serve(listen_addr, listen_port, pass, gid);
+	return serve(listen_port, pass, gid);
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index b6ef544..892b7f9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -74,6 +74,7 @@
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>
+#include <sys/un.h>
 #include <netdb.h>
 #include <pwd.h>
 #include <inttypes.h>
diff --git a/receive-pack.c b/receive-pack.c
index 3267495..6970979 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -2,6 +2,7 @@
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "daemon-redirect.h"
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "commit.h"
@@ -469,6 +470,8 @@ int main(int argc, char **argv)
 	if (!dir)
 		usage(receive_pack_usage);
 
+	if (redirect_execute("receive-pack", dir))
+		return 0;
 	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
diff --git a/upload-pack.c b/upload-pack.c
index 7e04311..8102126 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
+#include "daemon-redirect.h"
 #include "sideband.h"
 #include "tag.h"
 #include "object.h"
@@ -622,6 +623,8 @@ int main(int argc, char **argv)
 		usage(upload_pack_usage);
 	dir = argv[i];
 
+	if (redirect_execute("upload-pack", dir))
+		return 0;
 	if (!enter_repo(dir, strict))
 		die("'%s': unable to chdir or not a git archive", dir);
 	if (is_repository_shallow())
-- 
1.5.4.rc4.1142.gf5a97
