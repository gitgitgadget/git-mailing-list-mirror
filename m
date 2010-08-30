From: cdahlin@redhat.com
Subject: [RFC PATCH] Introduce git-hive
Date: Mon, 30 Aug 2010 15:59:27 -0400
Message-ID: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
Cc: luke.leighton@gmail.com, Casey Dahlin <cdahlin@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 22:00:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqAWv-0001Ph-SD
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 22:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052Ab0H3T7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 15:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab0H3T7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 15:59:38 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7UJxa00018425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 30 Aug 2010 15:59:36 -0400
Received: from foucault.redhat.com (vpn-11-195.rdu.redhat.com [10.11.11.195])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7UJxYsr008692;
	Mon, 30 Aug 2010 15:59:34 -0400
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154842>

From: Casey Dahlin <cdahlin@redhat.com>

This isn't really what I'd normally call ready for public consumption, but
since there's been some minimal list chatter on a similar subject I figured I'd
put this out there early.

git-hive is a peer to peer service for exchanging branches. When started it
runs a small daemon to publish your repository on a random (or specified) port.
Two hive daemons connected to oneanother can exchange branch lists and
introduce eachother to more hive daemons to widen the network.

Currently each hive daemon is associated with a project URI to identify what
project is being hosted.

Commands introduced are:
  git hive start - start the hive daemon and join a network
  git hive stop - stop the hive daemon
  git hive show - list peers and branches
  git hive fetch - fetch a branch

As I've said, there's some rough edges around this, so here's some things that
I'm very shortly going to be adding:

* Mechanism to track when a peer was last heard about, and re-verify or flush
old ones. Also don't forward information about a peer that hasn't been verified
recently. This will make things a LOT more robust, and prevent the flaming
clusterfuck that happens during netsplits right now (once done netsplits should
be an almost uninteresting occurance).

* Commit lines in branch listings. Fairly obvious UI thing that for some reason
I only just thought of.

* Improve tolerance of \0 in pkt_line strings as the spec says I should (and
take advantage of it! the protocol could be much easier to parse if I used \0
as a separator).

* Right now git-hive links against code from fetch-pack that clearly reaks of
abandonment, though not specifically deprecated. Its a conflict of my two
concerns 1) make this change uninvasive until people have warmed up to the
patch and 2) don't reimplement anything. I'm pretty sure there's a better way
to grab fetch functionality.

* Either some more commands for pull/etc. or some way to integrate better with
the normal versions of those commands (I thought of a uri helper but I'm not
sure what sort of uri you'd use to refer to a hive location that would be clean
for the user)

* Peer discovery. I'd like to use Avahi for this if there's no objections.

* Tests :)

Signed-off-by: Casey Dahlin <cdahlin@redhat.com>
---
 .gitignore |    1 +
 Makefile   |    5 +
 hive.c     | 1825 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1831 insertions(+), 0 deletions(-)
 create mode 100644 hive.c

diff --git a/.gitignore b/.gitignore
index 14e2b6b..447b889 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,7 @@
 /bin-wrappers/
 /git
 /git-add
+/git-hive
 /git-add--interactive
 /git-am
 /git-annotate
diff --git a/Makefile b/Makefile
index e151516..190d540 100644
--- a/Makefile
+++ b/Makefile
@@ -399,6 +399,7 @@ PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
+PROGRAM_OBJS += hive.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
@@ -449,6 +450,7 @@ BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
+BINDIR_PROGRAMS_NEED_X += git-hive
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
@@ -1893,6 +1895,9 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+git-hive$X: hive.o $(GITLIBS) builtin/fetch-pack.o
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
diff --git a/hive.c b/hive.c
new file mode 100644
index 0000000..63b3ee4
--- /dev/null
+++ b/hive.c
@@ -0,0 +1,1825 @@
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/timerfd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+
+#include "pkt-line.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "exec_cmd.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "refs.h"
+#include "fetch-pack.h"
+
+extern int accept4 (int sockfd, struct sockaddr *addr, socklen_t *addrlen,
+		    int flags);
+extern int dup3 (int oldfd, int newfd, int flags);
+
+struct peer {
+	char *user_id;
+	struct sockaddr *addr;
+	size_t failures;
+	int peer_ok;
+	struct sock_handler *handler;
+	struct peer *next;
+	struct peer *prev;
+};
+
+static struct peer self;
+static size_t active_peers;
+
+/* TODO: Options to change these */
+static size_t min_peers = 1;
+static size_t max_peers = 10; 
+static size_t max_alternates = 24;
+
+static size_t max_retries = 5;
+
+static char *proj_uri;
+
+typedef uint32_t (*sock_callback_t)(struct sock_handler *handler,
+				    uint32_t events);
+struct sock_handler {
+	sock_callback_t function;
+	int fd;
+	struct epoll_event event;
+};
+
+struct timer;
+typedef int (*timer_callback_t)(struct timer *timer);
+struct timer {
+	struct sock_handler handler;
+	timer_callback_t function;
+	void *data;
+};
+
+static size_t sock_handler_count = 0;
+
+static int poll_fd;
+static int ctl_sock;
+static struct sock_handler *ctl_handler;
+static struct sock_handler *abort_timer = NULL;
+
+struct pkt_handler;
+typedef enum {
+	PKT_DONE_CLOSE = 0,
+	PKT_DONE_REPURPOSED,
+	PKT_MORE,
+} pkt_status_t;
+typedef pkt_status_t (*pkt_callback_t)(struct pkt_handler *pkh);
+struct pkt_handler {
+	struct sock_handler handler;
+	size_t line_ct;
+	size_t sent;
+	size_t got;
+	size_t to_fill;
+	char linelen[4];
+	char *buf;
+	char **lines;
+	void *data;
+	struct strbuf output;
+	pkt_callback_t function;
+	int need_flush;
+};
+
+struct listen_sock_handler {
+	struct sock_handler handler;
+	pkt_callback_t sock_callback;
+};
+
+static const char hive_usage[] =
+"git hive {start | show | fetch} [options...]";
+
+static const char *const hive_start_usage[] = {
+	"git hive start [options] <peer> <port>",
+	"git hive start [options] <peer>:<port>",
+	NULL
+};
+
+static const char hive_stop_usage[] = "git hive stop";
+
+static const char *const hive_show_usage[] = {
+	"git hive show [--ip] [--[no-]branches] [regex]",
+	NULL
+};
+
+static const char *const hive_fetch_usage[] = {
+	"git hive fetch <user regex> <branch> [target]",
+	NULL
+};
+
+#define PT_OPS_IP 1
+#define PT_OPS_BRANCHES 2
+#define PT_OPS_SKIPLINE 4
+typedef uint32_t pt_ops_t;
+
+struct peer_list {
+	char **entries;
+	size_t len;
+};
+
+static int shutting_down = 0;
+
+static void do_term(int sig)
+{
+	if (! sig == SIGTERM)
+		die("TERM handler called from strange place");
+
+	shutting_down = 1;
+}
+
+struct sigaction term_action = {
+	.sa_handler = do_term,
+	.sa_flags = SA_RESTART,
+};
+
+static void handler_register(struct sock_handler *handler);
+#define pkt_handler_write(_pkh_i, ...) ({		\
+	struct pkt_handler *_pkh = (void *)(_pkh_i);	\
+	packet_buf_write(&_pkh->output, __VA_ARGS__);	\
+	_pkh->need_flush = 1;				\
+	_pkh->handler.event.events |= EPOLLOUT;		\
+	handler_register(&_pkh->handler);		\
+})
+
+static void pkt_handler_flush(struct pkt_handler *pkh)
+{
+	if (! pkh->need_flush)
+		return;
+
+	packet_buf_flush(&pkh->output);
+	pkh->need_flush = 0;
+}
+
+static char *getaddrstr(struct sockaddr *addr)
+{
+	char hostname[128];
+	char port[8];
+	size_t pos;
+	int gaierror;
+
+	if ((gaierror = getnameinfo(addr, sizeof(struct sockaddr_in),
+				    hostname, 120, port, 8,
+				    NI_NUMERICHOST | NI_NUMERICSERV)))
+		die("getnameinfo failed: %s", gai_strerror(gaierror));
+
+	pos = strlen(hostname);
+	hostname[pos] = ':';
+
+	memcpy(hostname + pos + 1, port, strlen(port) + 1);
+
+	return xstrdup(hostname);
+}
+
+static struct sockaddr *getaddrstruct(const char *str)
+{
+	char *ip;
+	int gairet;
+	const char *port = rindex(str, ':');
+	struct addrinfo *info;
+	struct sockaddr *ret;
+	struct addrinfo hint = {
+		.ai_family = AF_INET,
+		.ai_socktype = SOCK_STREAM,
+	};
+
+	if (! port)
+		die("invalid ip/port specification");
+
+	ip = xstrndup(str, (port++) - str);
+
+	if ((gairet = getaddrinfo(ip, port, &hint, &info)))
+		die("could not interpret address: %s", gai_strerror(gairet));
+
+	free(ip);
+
+	ret = memcpy(xmalloc(info->ai_addrlen), info->ai_addr,
+		     info->ai_addrlen);
+
+	freeaddrinfo(info);
+
+	return ret;
+}
+
+static void peer_announce(struct pkt_handler *pkh, struct peer *peer,
+			  const char *ann_type)
+{
+	char *addr = getaddrstr(peer->addr);
+
+	pkt_handler_write(pkh, "%s %s %s\n", ann_type, addr, peer->user_id);
+
+	free(addr);
+}
+
+static void handler_register(struct sock_handler *handler)
+{
+	int op = EPOLL_CTL_MOD;
+
+	while (epoll_ctl(poll_fd, op, handler->fd, &handler->event)) {
+		if (op != EPOLL_CTL_MOD || errno != ENOENT)
+			die_errno("epoll_ctl");
+
+		op = EPOLL_CTL_ADD;
+	}
+}
+
+static void broadcast_peer(struct peer *origin, struct peer *peer,
+			   const char *ann_type)
+{
+	struct peer *cur;
+
+	for (cur = self.next; cur != &self; cur = cur->next) {
+		struct pkt_handler *pkh;
+
+		if (! cur->handler)
+			continue;
+		if (cur == origin)
+			continue;
+		if (cur == peer)
+			continue;
+
+		pkh = (struct pkt_handler *)cur->handler;
+
+		if (ann_type)
+			peer_announce(pkh, peer, ann_type);
+		else
+			pkt_handler_flush(pkh);
+	}
+}
+
+static struct peer *lookup_peer(const char *user_id, struct sockaddr *addr,
+				struct peer *start)
+{
+	if (! start)
+		start = &self;
+
+	for (start = start->next; start != &self; start = start->next) {
+		if (user_id && start->user_id &&
+		    strcmp(start->user_id, user_id))
+			continue;
+
+		if (addr && memcmp(addr, start->addr,
+				   sizeof(struct sockaddr_in)))
+			continue;
+
+		return start;
+	}
+
+	return NULL;
+}
+
+static void destroy_sock_handler(struct sock_handler *handler)
+{
+	free(handler);
+	sock_handler_count--;
+}
+
+static void init_sock_handler(struct sock_handler *handler, int fd,
+			      sock_callback_t function)
+{
+	handler->fd = fd;
+	handler->function = function;
+	handler->event.events = EPOLLIN;
+	handler->event.data.ptr = handler;
+
+	sock_handler_count++;
+}
+
+static int pkt_handler_load_line_length(struct pkt_handler *pkh)
+{
+	int i;
+
+	for(i = 0; i < 4; i++) {
+		unsigned char c = pkh->linelen[i];
+		pkh->to_fill <<= 4;
+		if (c >= '0' && c <= '9') {
+			pkh->to_fill += c - '0';
+			continue;
+		}
+		if (c >= 'a' && c <= 'f') {
+			pkh->to_fill += c - 'a' + 10;
+			continue;
+		}
+		if (c >= 'A' && c <= 'F') {
+			pkh->to_fill += c - 'A' + 10;
+			continue;
+		}
+
+		return -1;
+	}
+
+	return 0;
+}
+
+static void pkt_handler_push_buf(struct pkt_handler *pkh)
+{
+		size_t line_spc = pkh->line_ct - 1;
+		int i;
+
+		if (! pkh->buf)
+			die("unexpected empty line");
+
+		for (i = 1; i < sizeof(line_spc) * 8; i *= 2)
+			line_spc |= line_spc >> i;
+		line_spc++;
+
+		if (line_spc < 2);
+			line_spc = 2;
+
+		if (line_spc == pkh->line_ct || !pkh->lines)
+			pkh->lines = xrealloc(pkh->lines,
+					      line_spc * sizeof(char *) * 2);
+
+		pkh->lines[pkh->line_ct++] = pkh->buf;
+
+		pkh->buf = NULL;
+		pkh->got = 0;
+		pkh->to_fill = 4;
+}
+
+static void pkt_handler_drop_data(struct pkt_handler *pkh)
+{
+	int i;
+
+	if (pkh->buf)
+		free(pkh->buf);
+	pkh->buf = NULL;
+
+	for (i = 0; i < pkh->line_ct; i++)
+		free(pkh->lines[i]);
+
+	free(pkh->lines);
+	pkh->lines = NULL;
+	pkh->line_ct = 0;
+
+	pkh->got = 0;
+	pkh->to_fill = 4;
+}
+
+static uint32_t handle_timer(struct sock_handler *handler, uint32_t events)
+{
+	struct timer *timer = (struct timer *)handler;
+	uint64_t expiry;
+
+	if (! (events & EPOLLIN))
+		die("timerfd error");
+
+	switch (read(handler->fd, &expiry, 8)) {
+	case -1:
+		die_errno("timerfd encountered error");
+	case 8:
+		break;
+	case 0:
+		die_errno("timerfd encountered unexpected EOF");
+	default:
+		die("timerfd underrun");
+	}
+
+	if (expiry > 1)
+		warning("lost timer events");
+
+	if (timer->function(timer))
+		return EPOLLIN;
+
+	return 0;
+}
+
+static uint32_t handle_pkt(struct sock_handler *handler, uint32_t events)
+{
+	struct pkt_handler *pkh = (struct pkt_handler *)handler;
+	char *pos = pkh->buf;
+	ssize_t got = -1;
+	pkt_status_t status;
+
+	if (! (events & (EPOLLIN | EPOLLOUT))) {
+		warning("unexpected poll event");
+		pkt_handler_drop_data(pkh);
+		goto closeout;
+	}
+
+	pkt_handler_flush(pkh);
+
+	if ((events & EPOLLOUT) && pkh->output.len > 0) {
+		ssize_t wrote = -1;
+
+		errno = EINTR;
+		while (wrote < 0 && errno == EINTR)
+			wrote = write(handler->fd, pkh->output.buf,
+				      pkh->output.len);
+
+		if (wrote < 0) {
+			warning("write error: %s", strerror(errno));
+			pkt_handler_drop_data(pkh);
+			goto closeout;
+		}
+
+		strbuf_remove(&pkh->output, 0, wrote);
+	}
+
+	
+	if (! pkh->function) {
+		if (pkh->output.len)
+			return EPOLLOUT;
+		goto closeout;
+	}
+
+	if (! (events & EPOLLIN))
+		goto next_batch;
+
+	if (! pos)
+		pos = pkh->linelen;
+
+	pos += pkh->got;
+
+	errno = EINTR;
+	while (got < 0 && errno == EINTR)
+		got = read(handler->fd, pos, pkh->to_fill);
+
+	if (got == -1) {
+		error("read error: %s", strerror(errno));
+		pkt_handler_drop_data(pkh);
+		goto closeout;
+	}
+
+	if (! got) {
+		error("Peer hung up unexpectedly");
+		/* FIXME: this */
+		pkh->function(pkh);
+		pkt_handler_drop_data(pkh);
+		goto closeout;
+	}
+
+	pkh->got += got;
+	pkh->to_fill -= got;
+
+	if (pkh->to_fill)
+		goto next_batch;
+
+	if (pkh->buf) {
+		pkt_handler_push_buf(pkh);
+		goto next_batch;
+	}
+
+	pkh->got = 0;
+	pkh->to_fill = 0;
+
+	if (pkt_handler_load_line_length(pkh)) {
+		error("Peer gave invalid pkt line: invalid length");
+		pkt_handler_drop_data(pkh);
+		goto closeout;
+	}
+
+	if (pkh->to_fill > 3) {
+		pkh->to_fill -= 4;
+		pkh->buf = xmallocz(pkh->to_fill);
+		goto next_batch;
+	}
+
+	if (pkh->to_fill > 0) {
+		error("Peer gave invalid pkt line: length too short");
+		pkt_handler_drop_data(pkh);
+		goto closeout;
+	}
+
+	status = pkh->function(pkh);
+	pkt_handler_drop_data(pkh);
+
+	if (status == PKT_MORE)
+		goto next_batch;
+
+	if (status == PKT_DONE_REPURPOSED) {
+		pkt_handler_drop_data(pkh);
+		return 0;
+	}
+
+	if (pkh->output.len) {
+		pkh->function = NULL;
+		return EPOLLOUT;
+	}
+
+closeout:
+	close(handler->fd);
+	strbuf_release(&pkh->output);
+	return 0;
+
+next_batch:
+	if (pkh->output.len)
+		return EPOLLIN | EPOLLOUT;
+	else
+		return EPOLLIN;
+}
+
+static struct sock_handler *create_timer(struct timespec *time,
+					 timer_callback_t function, void *data,
+					 int is_absolute)
+{
+	int fd = timerfd_create(CLOCK_MONOTONIC, O_CLOEXEC);
+	struct timer *ret = xmalloc(sizeof(struct timer));
+	struct itimerspec timerspec = {
+		.it_value = *time,
+	};
+
+	is_absolute = is_absolute ? TFD_TIMER_ABSTIME : 0;
+
+	if (fd < 0)
+		die_errno("could not create timerfd");
+
+	if (timerfd_settime(fd, is_absolute, &timerspec, NULL))
+		die_errno("could not set timer");
+
+	init_sock_handler(&ret->handler, fd, handle_timer);
+	ret->function = function;
+	ret->data = data;
+
+	return &ret->handler;
+}
+
+static void cancel_timer(struct timer *timer)
+{
+	close(timer->handler.fd);
+	timer->handler.fd = -1;
+	timer->function(timer);
+	free(timer);
+}
+
+static struct sock_handler *create_pkt_handler(int fd,
+					       pkt_callback_t function,
+					       void *data)
+{
+	struct pkt_handler *pkh = xmalloc(sizeof(struct pkt_handler));
+
+	init_sock_handler(&pkh->handler, fd, handle_pkt);
+
+	pkh->got = 0;
+	pkh->to_fill = 4;
+	pkh->buf = NULL;
+	pkh->data = data;
+	pkh->function = function;
+	pkh->line_ct = 0;
+	pkh->lines = NULL;
+	pkh->sent = 0;
+	pkh->need_flush = 0;
+	strbuf_init(&pkh->output, 80);
+
+	return &pkh->handler;
+}
+
+static int begin_listen(void)
+{
+	int fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+
+	if (fd < 0)
+		die_errno("Could not create socket");
+
+	if (bind(fd, (struct sockaddr *)self.addr,
+		 sizeof (struct sockaddr_in))) {
+		switch(errno) {
+		case EACCES:
+		case EADDRINUSE:
+			goto fail;
+		default:
+			die_errno("Could not bind to port");
+		}
+	}
+
+	if (!listen(fd, 5))
+		return fd;
+
+	if (errno != EADDRINUSE)
+		die_errno("Could not listen on port");
+
+fail:
+	close(fd);
+	return -1;
+}
+
+struct sockaddr *parse_txt_peer(char *input, char **user_id_ret)
+{
+	char *user_id;
+
+	user_id = index(input, ' ');
+
+	if (! user_id)
+		return NULL;
+
+	*(user_id++) = '\0';
+
+	user_id[strlen(user_id) - 1] = '\0';
+
+	if (user_id_ret)
+		*user_id_ret = xstrdup(user_id);
+
+	return getaddrstruct(input);
+}
+
+static pkt_status_t handle_peer(struct pkt_handler *pkh);
+
+static struct peer *create_peer(const char *user_id, struct sockaddr *addr,
+				struct peer *broadcast_origin)
+{
+	struct peer *new;
+
+	new = xmalloc(sizeof(struct peer));
+	if (user_id)
+		new->user_id = xstrdup(user_id);
+	else
+		new->user_id = NULL;
+	new->addr = addr;
+	new->failures = 0;
+	new->peer_ok = 0;
+	new->handler = NULL;
+
+	new->next = self.next;
+	new->prev = &self;
+	self.next = new;
+	new->next->prev = new;
+
+	if (broadcast_origin)
+		broadcast_peer(broadcast_origin, new, "remote-peer");
+
+	return new;
+}
+
+static struct peer *add_peer(int fd, const char *user_id,
+			     struct sockaddr *addr,
+			     struct peer *broadcast_origin)
+{
+	struct peer *new = NULL;
+	struct sock_handler *handler;
+	int port = -1;
+
+	if (fd < 0 && ! addr)
+		die("Invalid arguments to add_peer: "
+		    "no file descriptor or address");
+
+	if (fd >= 0) {
+		if (addr)
+			port = ((struct sockaddr_in *)addr)->sin_port;
+		socklen_t size = sizeof(struct sockaddr_in);
+		addr = xmalloc(size);
+
+		if (getpeername(fd, addr, &size))
+			die_errno("getpeername");
+
+		if (port >= 0)
+			((struct sockaddr_in *)addr)->sin_port = port;
+	}
+
+	if (user_id)
+		new = lookup_peer(user_id, addr, NULL);
+
+	if (! new) {
+		new = create_peer(user_id, addr, broadcast_origin);
+
+		if (fd < 0)
+			return new;
+	} else if (fd < 0) {
+		return new;
+	} else if (new->handler) {
+		return NULL;
+	}
+
+	handler = create_pkt_handler(fd, handle_peer, new);
+	handler_register(handler);
+	new->handler = handler;
+	active_peers++;
+
+	return new;
+}
+
+static int add_peer_txt(char *line, struct peer *broadcast_origin)
+{
+	char *user_id;
+	struct sockaddr *addr;
+
+	addr = parse_txt_peer(line, &user_id);
+
+	if (! addr)
+		return -1;
+
+	add_peer(-1, user_id, addr, broadcast_origin);
+	return 0;
+}
+
+static void lost_peer(struct peer *peer, struct peer *broadcast_origin)
+{
+	peer->prev->next = peer->next;
+	peer->next->prev = peer->prev;
+
+	if (broadcast_origin)
+		broadcast_peer(broadcast_origin, peer, "lost-peer");
+
+	if (peer->handler)
+		active_peers--;
+
+	free(peer->user_id);
+	free(peer->addr);
+	free(peer);
+}
+
+static size_t lost_peers(char *user_id, struct sockaddr *addr,
+			 struct peer *broadcast_origin)
+{
+	struct peer *peer = NULL;
+	size_t ret = 0;
+
+	for (peer = lookup_peer(user_id, addr, peer); peer;
+	     peer = lookup_peer(user_id, addr, peer)) {
+		struct peer *old_peer = peer;
+		/* For active peers we don't care about third party
+		 * announcements
+		 */
+		if (peer->handler)
+			continue;
+
+		peer = peer->prev;
+
+		lost_peer(old_peer, broadcast_origin);
+
+		ret++;
+	}
+
+	return ret;
+}
+
+static ssize_t lost_peer_txt(char *line, struct peer *broadcast_origin)
+{
+	char *user_id;
+	struct sockaddr *addr;
+	size_t ret = 0;
+
+	addr = parse_txt_peer(line, &user_id);
+
+	if (! addr)
+		return -1;
+
+	ret = lost_peers(user_id, addr, broadcast_origin);
+
+	free(addr);
+
+	return ret;
+}
+
+void write_hangup_message(struct pkt_handler *pkh)
+{
+	if (active_peers == 1 &&
+	    (shutting_down || (self.next->handler && self.prev->handler)))
+		pkt_handler_write(pkh, "hangup-bye\n");
+	else
+		pkt_handler_write(pkh, "hangup\n");
+}
+
+static void deactivate_peer(struct peer *peer, int failed)
+{
+	if (! peer->handler)
+		return;
+
+	if (failed && ++peer->failures >= max_retries) {
+		lost_peer(peer, &self);
+		return;
+	}
+
+	peer->peer_ok = 0;
+	peer->handler = NULL;
+	active_peers--;
+}
+
+static pkt_status_t handle_peer(struct pkt_handler *pkh)
+{
+	struct peer *peer = pkh->data;
+	size_t i;
+
+	if (! pkh) {
+		lost_peer(peer, &self);
+		broadcast_peer(&self, NULL, NULL);
+		return PKT_DONE_CLOSE;
+	}
+
+	for (i = 0; i < pkh->line_ct; i++) {
+		char *line = pkh->lines[i];
+
+		if (! strncmp(line, "peer-ok ", 8)) {
+			if (! peer->user_id) {
+				peer->user_id = xstrdup(line + 8);
+				peer->user_id[strlen(peer->user_id) - 1] = '\0';
+			}
+			peer->peer_ok = 1;
+			continue;
+		} else if (! strncmp(line, "err-", 4) && index(line, ' ')) {
+			int count_failure = 1;
+
+			count_failure = count_failure &&
+				strncmp(line, "err-too-many ", 13);
+				/* && strncmp(line, "err-something-else"...*/
+
+			error("%s", index(line, ' ') + 1);
+			deactivate_peer(peer, count_failure);
+		} else if (! peer->peer_ok) {
+			pkt_handler_write(pkh, "err-proto Protocol error\n");
+			deactivate_peer(peer, 1);
+		} else if (! strncmp(line, "remote-peer ", 12)) {
+			if (! add_peer_txt(line + 12, peer))
+				continue;
+			pkt_handler_write(pkh, "err-proto Protocol error\n");
+			deactivate_peer(peer, 1);
+		} else if (! strncmp(line, "lost-peer ", 10)) {
+			if (lost_peer_txt(line + 10, peer) < 0)
+				continue;
+			pkt_handler_write(pkh, "err-proto Protocol error\n");
+			deactivate_peer(peer, 1);
+		} else if (! strcmp(line, "hangup\n")) {
+			deactivate_peer(peer, 0);
+		} else if (! strcmp(line, "hangup-bye\n")) {
+			lost_peer(peer, &self);
+		} else {
+			pkt_handler_write(pkh, "err-proto Protocol error\n");
+			deactivate_peer(peer, 1);
+		}
+
+		write_hangup_message(pkh);
+
+		return PKT_DONE_CLOSE;
+	}
+
+	return PKT_MORE;
+}
+
+static int ref_published(const char *refname, int is_tag)
+{
+	return 1;
+}
+
+static int output_branch(const char *refname, const unsigned char *sha1,
+			 int flags, void *cb_data)
+{
+	int is_tag;
+
+	if (! strncmp(refname, "refs/heads/", 11)) {
+		refname += 11;
+		is_tag = 0;
+	} else if (! strncmp(refname, "refs/tags/", 10)) {
+		refname += 10;
+		is_tag = 1;
+	} else {
+		return 0;
+	}
+
+	if (! ref_published(refname, 1))
+		return 0;
+
+	pkt_handler_write(cb_data, "branch %s\n", refname);
+	return 0;
+}
+
+static pkt_status_t handle_initial_connect(struct pkt_handler *pkh)
+{
+	char *peer;
+	char *ip;
+	struct peer *new;
+	struct peer *other;
+	struct sockaddr *addr;
+
+	if (! pkh->line_ct)
+		return PKT_MORE;
+
+	if (pkh->line_ct > 1) {
+		pkt_handler_write(pkh, "err-proto Protocol error\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	peer = pkh->lines[0];
+
+	if (! strcmp(peer, "hangup\n")) {
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	if (! strncmp(peer, "err-", 4)) {
+		if (peer[strlen(peer) - 1] == '\n')
+			peer[strlen(peer) - 1] = '\0';
+		error("%s", peer);
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	if (strncmp(peer, "1 ", 2)) {
+		pkt_handler_write(pkh, "err-version Unsupported version\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	peer += 2;
+
+	if (! strcmp(peer, "branch-list\n")) {
+		for_each_rawref(output_branch, pkh);
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	if (! strcmp(peer, "upload-pack\n")) {
+		switch(fork()) {
+		case -1:
+			die_errno("could not fork");
+		case 0:
+			if (dup2(pkh->handler.fd, 0) < 0)
+				die_errno("dup2");
+			if (dup2(pkh->handler.fd, 1) < 0)
+				die_errno("dup2");
+
+			switch(fork()) {
+			case -1:
+				die_errno("could not fork");
+			case 0:
+				execl_git_cmd("upload-pack", get_git_dir(), NULL);
+				die_errno("failed to run git upload-pack");
+			default:
+				exit(0);
+			}
+
+		default:
+			wait(NULL);
+			return PKT_DONE_CLOSE;
+		}
+	}
+
+	if (strncmp(peer, "peer ", 5)) {
+		pkt_handler_write(pkh, "err-proto Protocol error\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	if (active_peers >= max_peers) {
+		size_t announced = 0;
+		struct peer *peer = self.next;
+
+		pkt_handler_write(pkh, "err-load We have too many peers already\n");
+
+		while (peer != &self && announced < max_alternates) {
+			peer_announce(pkh, peer, "remote-peer");
+			peer = peer->next;
+			announced++;
+		}
+
+		pkt_handler_write(pkh, "hangup\n");
+
+		return PKT_DONE_CLOSE;
+	}
+
+	peer += 5;
+
+	if (strncmp(peer, proj_uri, strlen(proj_uri))) {
+		pkt_handler_write(pkh, "err-proj Unknown project\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	peer += strlen(proj_uri);
+
+	if (*peer != ' ') {
+		pkt_handler_write(pkh, "err-proto Protocol error\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	peer++;
+
+	ip = peer;
+
+	peer = index(peer, ' ');
+
+	if (! peer) {
+		pkt_handler_write(pkh, "err-proto Protocol error\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	ip = xstrndup(ip, peer - ip);
+
+	peer++;
+
+	/* Kill the \n */
+	peer[strlen(peer) - 1] = '\0';
+
+	addr = getaddrstruct(ip);
+	new = add_peer(pkh->handler.fd, peer, addr, &self);
+	free(addr);
+
+	if (! new) {
+		pkt_handler_write(pkh, "err-too-many Too many connections\n");
+		pkt_handler_write(pkh, "hangup\n");
+		return PKT_DONE_CLOSE;
+	}
+
+	broadcast_peer(new, NULL, NULL);
+
+	new->peer_ok = 1;
+	pkt_handler_write(new->handler, "peer-ok %s\n", self.user_id);
+	for (other = self.next; other != &self; other = other->next)
+		if (other != new)
+			peer_announce((struct pkt_handler *)new->handler,
+				      other, "remote-peer");
+
+	return PKT_DONE_REPURPOSED;
+}
+
+static uint32_t handle_listen_sock(struct sock_handler *handler,
+				   uint32_t events)
+{
+	int newfd = -1;
+	socklen_t slen = sizeof(struct sockaddr_in);
+	struct sockaddr *addr = xmalloc(slen);
+	struct sock_handler *new;
+	struct listen_sock_handler *lhand =
+		(struct listen_sock_handler *)handler;
+
+	if (! (events & EPOLLIN))
+		die("Listen socket got unexpected epoll event");
+
+	newfd = accept4(handler->fd, addr, &slen, O_CLOEXEC);
+
+	if (newfd == -1) {
+		free(addr);
+		error("Failed to accept new peer: %s", strerror(errno));
+		return EPOLLIN;
+	}
+
+	new = create_pkt_handler(newfd, lhand->sock_callback, addr);
+
+	handler_register(new);
+	return EPOLLIN;
+}
+
+static struct sock_handler *create_listen_handler(int fd,
+						  pkt_callback_t function)
+{
+	struct listen_sock_handler *ret =
+		xmalloc(sizeof(struct listen_sock_handler));
+
+	init_sock_handler(&ret->handler, fd, handle_listen_sock);
+	ret->sock_callback = function;
+
+	return &ret->handler;
+}
+
+static void activate_peer(struct peer *peer)
+{
+	struct sock_handler *handler;
+	char *ip;
+	int fd;
+
+	if (peer->handler)
+		return;
+
+	fd = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+
+	if (fd < 0) {
+		error("Failed to activate peer: %s", strerror(errno));
+		return;
+	}
+
+	if (connect(fd, peer->addr, sizeof(struct sockaddr_in))) {
+		close(fd);
+		error("Could not reach peer: %s", strerror(errno));
+
+		if (++peer->failures >= max_retries)
+			lost_peer(peer, &self);
+
+		return;
+	}
+
+	handler = create_pkt_handler(fd, handle_peer, peer);
+	handler->event.events |= EPOLLOUT;
+	handler_register(handler);
+	peer->handler = handler;
+	active_peers++;
+
+	ip = getaddrstr(self.addr);
+	pkt_handler_write(handler, "1 peer %s %s %s\n", proj_uri, ip,
+			  self.user_id);
+	pkt_handler_flush((struct pkt_handler *)handler);
+	free(ip);
+}
+
+static pkt_status_t handle_ctl_sock(struct pkt_handler *pkh)
+{
+	size_t i;
+
+	if (! pkh->line_ct)
+		return PKT_MORE;
+
+	for (i = 0; i < pkh->line_ct; i++) {
+		char *line = pkh->lines[i];
+
+		if (! strcmp(line, "show\n")) {
+			struct peer *peer;
+
+			for (peer = self.next; peer != &self;
+			     peer = peer->next) {
+				char *addr;
+
+				if (! peer->user_id)
+					continue;
+
+				addr = getaddrstr(peer->addr);
+
+				pkt_handler_write(pkh, "have-peer %s %s\n",
+						  addr, peer->user_id);
+
+				free(addr);
+			}
+
+			pkt_handler_write(pkh, "end-show\n");
+		} else if (! strcmp(line, "hangup\n")) {
+			pkt_handler_flush(pkh);
+			return PKT_DONE_CLOSE;
+		} else if (! strcmp(line, "pid\n")) {
+			pkt_handler_write(pkh, "pid %u\n", getpid());
+		} else {
+			pkt_handler_write(pkh, "err-did-not-understand %s\n", line);
+		}
+	}
+
+	return PKT_MORE;
+}
+
+static int handle_abort_expire(struct timer *timer)
+{
+	die("clean shutdown took too long");
+}
+
+void do_shutdown(void)
+{
+	char *ctl_path;
+	struct peer *peer;
+	struct timespec onemin = {
+		.tv_sec = 60,
+	};
+
+	close(self.handler->fd);
+	destroy_sock_handler(self.handler);
+	self.handler = NULL;
+
+	ctl_path = git_pathdup("hive_ctl");
+	unlink(ctl_path);
+	free(ctl_path);
+
+	close(ctl_sock);
+	destroy_sock_handler(ctl_handler);
+
+	for (peer = self.next; peer != &self; peer = peer->next) {
+		struct peer *old;
+
+		if (peer->handler) {
+			struct pkt_handler *pkh =
+				(struct pkt_handler *)peer->handler;
+			write_hangup_message(pkh);
+
+			pkt_handler_drop_data(pkh);
+			pkh->function = NULL;
+		}
+
+		old = peer->prev;
+		lost_peer(peer, NULL);
+		peer = old;
+	}
+
+	abort_timer = create_timer(&onemin, handle_abort_expire, NULL, 0);
+	handler_register(abort_timer);
+}
+
+static int run_server(int min_listen_port, int max_listen_port)
+{
+	int i;
+	int log_fd;
+	int listen_fd = -1;
+	char *log_path;
+	char *ctl_path;
+	struct sock_handler *handler;
+	struct sockaddr_in *addr = xmalloc(sizeof(struct sockaddr_in));
+	struct epoll_event events[32];
+	struct sockaddr_un ctl_addr = { .sun_family = AF_UNIX };
+
+	int port_delta = max_listen_port - min_listen_port + 1;
+	int start_offset;
+
+	log_path = git_pathdup("hive_log");
+	ctl_path = git_pathdup("hive_ctl");
+	memcpy(ctl_addr.sun_path, ctl_path, strlen(ctl_path) + 1);
+	free(ctl_path);
+	
+	ctl_sock = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	if (ctl_sock < 0)
+		die_errno("could not create control socket");
+
+	while (bind(ctl_sock, (struct sockaddr *)&ctl_addr,
+		    sizeof(struct sockaddr_un))) {
+		if (errno != EADDRINUSE)
+			die_errno("could not bind control socket");
+
+		if (! connect(ctl_sock, (struct sockaddr *)&ctl_addr,
+			    sizeof(struct sockaddr_un))) {
+			packet_write(ctl_sock, "hangup\n");
+			packet_flush(ctl_sock);
+
+			die("hive server already running");
+		}
+
+		if (errno == ECONNREFUSED) {
+			unlink(ctl_addr.sun_path);
+		} else if (errno != ENOENT) {
+			die_errno("could not connect to running instance");
+		}
+	}
+
+	if (listen(ctl_sock, 20))
+		die_errno("could not listen on control socket");
+
+	log_fd = open(log_path, O_APPEND | O_CREAT | O_WRONLY, 0644);
+	free(log_path);
+
+	if (log_fd < 0)
+		die_errno("could not open log file");
+
+	srand(time(NULL));
+
+	start_offset = rand() % port_delta;
+
+	*addr = (struct sockaddr_in) { .sin_family = AF_INET };
+	self.addr = (struct sockaddr *)addr;
+
+	for (i = 0; i < port_delta && listen_fd < 0; i++) {
+		int port = (i + start_offset) % port_delta + min_listen_port;
+		addr->sin_port = htons(port);
+		listen_fd = begin_listen();
+	}
+
+	if (listen_fd < 0) {
+		if (min_listen_port != max_listen_port)
+			die("could not find available listen port");
+		else
+			die("port %d unavailable", min_listen_port);
+	}
+
+	handler = create_listen_handler(listen_fd, handle_initial_connect);
+	self.handler = handler;
+
+	ctl_handler = create_listen_handler(ctl_sock, handle_ctl_sock);
+
+	poll_fd = epoll_create1(EPOLL_CLOEXEC);
+
+	if (poll_fd < 0)
+		die_errno("epoll_create1");
+
+	handler_register(handler);
+	handler_register(ctl_handler);
+
+	switch (fork()) {
+	case -1:
+		die_errno("could not fork");
+	case 0:
+		break;
+	default:
+		return 0;
+	}
+
+	setsid();
+
+	if (dup3(log_fd, 1, O_CLOEXEC) < 0)
+		die_errno("could not set stdout");
+	if (dup2(log_fd, 2) < 0)
+		die_errno("could not set stderr");
+
+	close(0);
+	close(log_fd);
+
+	switch (open("/dev/null", O_RDONLY | O_CLOEXEC) != 0) {
+	case -1:
+		die_errno("could not set stdin");
+	case 0:
+		break;
+	default:
+		die("could not set stdin");
+	}
+
+	if (sigaction (SIGTERM, &term_action, NULL))
+		die_errno("could not set TERM action");
+
+	i = 0;
+	do {
+		struct peer *peer;
+
+		while (i-- >= 1) {
+			struct sock_handler *hand = events[i].data.ptr;
+			uint32_t next_events =
+				hand->function(hand, events[i].events);
+
+			if (! next_events) {
+				/* The file descriptor should have been removed
+				 * from poll_fd or repurposed therein at this
+				 * point.
+				 */
+				destroy_sock_handler(hand);
+				continue;
+			} else if (next_events == hand->event.events) {
+				continue;
+			}
+
+			hand->event.events = next_events;
+
+			handler_register(hand);
+		}
+
+
+		if (shutting_down) {
+			if (self.handler)
+				do_shutdown();
+
+			if (sock_handler_count == 1) {
+				close(abort_timer->fd);
+				destroy_sock_handler(abort_timer);
+			}
+
+			if (! sock_handler_count)
+				return 0;
+
+			continue;
+		}
+
+		for (peer = self.next; peer != &self &&
+		     active_peers < min_peers; peer = peer->next)
+			if (! peer->handler)
+				activate_peer(peer);
+
+		if (! sock_handler_count)
+			die("file descriptor listen queue depleted");
+	} while ((i = epoll_wait(poll_fd, events, 32, -1)) >= 0 || errno == EINTR);
+
+	die_errno("epoll_wait");
+}
+
+static int read_repo_config(const char *key_, const char *value_, void *cb)
+{
+	if (!strcmp(key_, "hive.uri"))
+		proj_uri = xstrdup(value_);
+
+	return 0;
+}
+
+static void init_self(char *user_id)
+{
+	self.user_id = user_id;
+	self.addr = NULL;
+	self.handler = NULL;
+	self.failures = 0;
+	self.next = &self;
+	self.prev = &self;
+
+	active_peers = 0;
+}
+
+static int start(int argc, const char **argv)
+{
+	int nongit;
+	char *user_name = NULL;
+	char *user_email = NULL;
+	char *user_id;
+	char *repo_config;
+	const char *prefix = setup_git_directory_gently(&nongit);
+	char *addr_str;
+	int min_listen_port = -1;
+	int max_listen_port = -1;
+	int listen_port = -1;
+
+	struct sockaddr *sockaddr;
+
+	proj_uri = NULL;
+	repo_config = git_pathdup("config");
+	git_config_from_file(read_repo_config, repo_config, NULL);
+	free(repo_config);
+
+	struct option options[] = {
+		OPT_GROUP("Identification options"),
+		OPT_STRING(0, "proj-uri", &proj_uri, "URI", "Upstream URI to identify project"),
+		OPT_STRING(0, "name", &user_name, "NAME", "Published name of the owner of this repository"),
+		OPT_STRING(0, "email", &user_email, "EMAIL", "Published email of the owner of this repository"),
+
+		OPT_GROUP("Communication options"),
+		OPT_INTEGER(0, "listen-port", &listen_port, "Port to listen for peers on. Defaults to random"),
+		OPT_INTEGER(0, "min-port", &min_listen_port, "Mininmum port to select as a listen port. Defaults to 10000"),
+		OPT_INTEGER(0, "max-port", &max_listen_port, "Maximum port to select as a listen port. Defaults to 65535"),
+		OPT_END(),
+	};
+
+	if (nongit)
+		die("not a git repository");
+
+	argc = parse_options(argc, argv, prefix, options, hive_start_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	user_id = xstrdup(fmt_name(user_name, user_email));
+
+	if (! proj_uri) {
+		error("You must use --proj-uri or set hive.uri in the "
+		      "repository configuration");
+		usage_with_options(hive_start_usage, options);
+	}
+
+	if (index(proj_uri, ' ')) {
+		error("project URI cannot contain space");
+		usage_with_options(hive_start_usage, options);
+	}
+
+	if (listen_port != -1) {
+		if (min_listen_port != -1) {
+			error("cannot specify --listen-port with --min-port");
+			usage_with_options(hive_start_usage, options);
+		}
+
+		if (max_listen_port != -1) {
+			error("cannot specify --listen-port with --max-port");
+			usage_with_options(hive_start_usage, options);
+		}
+
+		min_listen_port = max_listen_port = listen_port;
+	}
+
+	if (max_listen_port < min_listen_port) {
+		error("maximum port value must be greater than minimum");
+		usage_with_options(hive_start_usage, options);
+	}
+
+	if (min_listen_port == -1 && max_listen_port == -1) {
+		min_listen_port = 10000;
+		max_listen_port = 65535;
+	}
+
+	if (min_listen_port < 0 || max_listen_port > 65535) {
+		error("port values must be in the range of 0..65535");
+		usage_with_options(hive_start_usage, options);
+	}
+
+	if (argc > 2) {
+		error("wrong number of arguments");
+		usage_with_options(hive_start_usage, options);
+	}
+
+	init_self(user_id);
+
+	if (argc == 0)
+		return run_server(min_listen_port, max_listen_port);
+
+	if (argc == 2) {
+		addr_str = xmallocz(strlen(argv[0]) + strlen(argv[1]) + 1);
+		sprintf(addr_str, "%s:%s", argv[0], argv[1]);
+	} else {
+		addr_str = xstrdup(argv[0]);
+	}
+
+	sockaddr = getaddrstruct(addr_str);
+	free(addr_str);
+
+	add_peer(-1, NULL, sockaddr, NULL);
+
+	return run_server(min_listen_port, max_listen_port);
+}
+
+void select_peer(const char *peerstr, void *data)
+{
+	const char *user_id_brk = index(peerstr, ' ');
+	struct peer_list *list = data;
+
+	printf("%lu) %s", ++list->len, peerstr);
+
+	list->entries = xrealloc(list->entries,
+				 sizeof(char *) * (list->len + 1));
+	list->entries[list->len] = NULL;
+	list->entries[list->len - 1] =
+		xstrndup(peerstr, user_id_brk - peerstr);
+}
+
+void print_peer(const char *peerstr, void *data)
+{
+	const char *user_id_brk = index(peerstr, ' ');
+	char *ip;
+	pt_ops_t flags = *(pt_ops_t *)data;
+	struct sockaddr *sockaddr;
+	int peer_sock;
+	char buf[1024];
+
+	if (! (flags & PT_OPS_IP))
+		printf("%s", user_id_brk + 1);
+	else
+		printf("%s", peerstr);
+
+	if (! (flags & PT_OPS_BRANCHES))
+		return;
+
+	ip = xstrndup(peerstr, user_id_brk - peerstr);
+
+	sockaddr = getaddrstruct(ip);
+
+	free(ip);
+
+	peer_sock = socket(AF_INET, SOCK_STREAM, 0);
+
+	if (peer_sock < 0)
+		die_errno("could not create socket");
+
+	if (connect(peer_sock, sockaddr, sizeof(struct sockaddr_in))) {
+		warning("could not connect to peer: %s", strerror(errno));
+		free(sockaddr);
+		close(peer_sock);
+		return;
+	}
+
+	free(sockaddr);
+
+	packet_write(peer_sock, "1 branch-list\n");
+	packet_flush(peer_sock);
+
+	if (flags & PT_OPS_SKIPLINE)
+		printf("\n");
+
+	(*(pt_ops_t *)data) |= PT_OPS_SKIPLINE;
+
+	while (packet_read_line(peer_sock, buf, 1024)) {
+		if (! strcmp(buf, "hangup\n"))
+			break;
+		if (strncmp(buf, "branch ", 7)) {
+			warning("protocol error from peer");
+			break;
+		}
+		printf("\t%s", buf + 7);
+	}
+
+	packet_write(peer_sock, "hangup\n");
+	packet_flush(peer_sock);
+	close(peer_sock);
+	return;
+}
+
+int get_ctl_socket(void)
+{
+	int ctl_fd;
+	char *ctl_path;
+	struct sockaddr_un addr = { .sun_family = AF_UNIX };
+
+	ctl_path = git_pathdup("hive_ctl");
+	ctl_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+
+	if (ctl_fd < 0)
+		die_errno("could not create control client socket");
+
+	memcpy(addr.sun_path, ctl_path, strlen(ctl_path) + 1);
+	free(ctl_path);
+
+	if (connect(ctl_fd, (struct sockaddr *)&addr,
+		    sizeof(struct sockaddr_un)))
+		die_errno("could not connect to control socket");
+
+	return ctl_fd;
+}
+
+int do_for_peers(void (*func)(const char *, void *), regex_t *pat, void *data)
+{
+	int ctl_fd;
+	char buf[1024];
+
+	ctl_fd = get_ctl_socket();
+
+	packet_write(ctl_fd, "show\n");
+	packet_write(ctl_fd, "hangup\n");
+	packet_flush(ctl_fd);
+
+	while (packet_read_line(ctl_fd, buf, 1024)) {
+		char *user_id;
+		if (! strcmp(buf, "end-show\n")) {
+			close(ctl_fd);
+			return 0;
+		}
+
+		if (strncmp(buf, "have-peer ", 10))
+			die("malformed response from daemon");
+
+		user_id = index(buf + 10, ' ');
+
+		if (! user_id)
+			die("malformed response from daemon");
+
+		user_id++;
+
+		if (pat && regexec(pat, user_id, 0, NULL, 0))
+			continue;
+
+		func(buf + 10, data);
+	}
+
+	die_errno("daemon hung up unexpectedly");
+}
+
+int fetch(int argc, const char **argv)
+{
+	int nongit;
+	regex_t regex;
+	const char *prefix = setup_git_directory_gently(&nongit);
+	const char *newbranch;
+	int ret;
+	int peer_sock[2];
+	char *heads[] = { NULL, NULL };
+	struct peer_list peer_list= { NULL, 0 };
+	size_t peer_idx = 0;
+	struct sockaddr *addr;
+	struct fetch_pack_args fpa = { .uploadpack = "git-upload-pack" };
+	struct ref *ref = NULL;
+
+	struct option options[] = {
+		OPT_GROUP("Generic options"),
+		OPT_END(),
+	};
+
+	if (nongit)
+		die("not a git repository");
+
+	argc = parse_options(argc, argv, prefix, options, hive_show_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc < 2 || argc > 3)
+		usage_with_options(hive_show_usage, options);
+
+	ret = regcomp(&regex, argv[0], REG_EXTENDED | REG_ICASE | REG_NOSUB);
+
+	if (ret) {
+		char errbuf[256];
+		regerror(ret, &regex, errbuf, 256);
+		error("Invalid regex: %s", errbuf);
+		usage_with_options(hive_show_usage, options);
+	}
+
+	do_for_peers(select_peer, &regex, &peer_list);
+
+	regfree(&regex);
+
+	if (! peer_list.len)
+		die("No such peer");
+
+	if (peer_list.len > 1) {
+		while (peer_idx < 1 || peer_idx > peer_list.len) {
+			printf("Choose peer: ");
+			scanf("%lu", &peer_idx);
+		}
+
+		peer_idx--;
+	}
+
+	addr = getaddrstruct(peer_list.entries[peer_idx]);
+	free(peer_list.entries);
+
+	peer_sock[0] = peer_sock[1] = socket(AF_INET, SOCK_STREAM, 0);
+
+	if (peer_sock[0] < 0)
+		die_errno("could not create socket");
+
+	if (connect(peer_sock[0], addr, sizeof(struct sockaddr_in)))
+		die_errno("could not connect to peer");
+
+	free(addr);
+
+	packet_write(peer_sock[0], "1 upload-pack\n");
+	packet_flush(peer_sock[0]);
+
+	heads[0] = (char *)argv[1];
+
+	get_remote_heads(peer_sock[0], &ref, 0, NULL, 0, NULL);
+	ref = fetch_pack(&fpa, peer_sock, NULL, ref, NULL, 1, heads, NULL);
+
+	close(peer_sock[0]);
+
+	if (heads[0] && heads[0][0])
+		die("No such remote ref");
+
+	if (argc == 3)
+		newbranch = argv[2];
+	else
+		newbranch = rindex(ref->name, '/') + 1;
+
+	execl_git_cmd("branch", newbranch, sha1_to_hex(ref->old_sha1), NULL);
+	die_errno("Could not create branch");
+}
+
+int show(int argc, const char **argv)
+{
+	int branches = 0;
+	int ip = 0;
+	int ret;
+	int nongit;
+	pt_ops_t opts = 0;
+	regex_t regex;
+	const char *prefix = setup_git_directory_gently(&nongit);
+
+	struct option options[] = {
+		OPT_GROUP("Generic options"),
+		OPT_BOOLEAN('i', "ip", &ip, "Print IP and port with each peer"),
+		OPT_UYN(0, "branches", &branches, "Show branches for each peer. This is default if a regex is given"),
+		OPT_END(),
+	};
+
+	if (nongit)
+		die("not a git repository");
+
+	argc = parse_options(argc, argv, prefix, options, hive_show_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc > 1)
+		usage_with_options(hive_show_usage, options);
+
+	if (ip)
+		opts |= PT_OPS_IP;
+
+	if (argc == 0) {
+		if (branches)
+			opts |= PT_OPS_BRANCHES;
+
+		return do_for_peers(print_peer, NULL, &opts);
+	}
+
+	if (! branches)
+		branches = 1;
+
+	if (branches != 2)
+		opts |= PT_OPS_BRANCHES;
+
+	ret = regcomp(&regex, argv[0], REG_EXTENDED | REG_ICASE | REG_NOSUB);
+
+	if (ret) {
+		char errbuf[256];
+		regerror(ret, &regex, errbuf, 256);
+		error("Invalid regex: %s", errbuf);
+		usage_with_options(hive_show_usage, options);
+	}
+
+	ret = do_for_peers(print_peer, &regex, &opts);
+
+	regfree(&regex);
+
+	return ret;
+}
+
+int stop(int argc, const char **argv)
+{
+	int ctl_fd;
+	pid_t pid;
+	char buf[1024];
+	char *pid_txt;
+
+	if (argc != 1)
+		usage(hive_stop_usage);
+
+	ctl_fd = get_ctl_socket();
+
+	packet_write(ctl_fd, "pid\n");
+	packet_write(ctl_fd, "hangup\n");
+	packet_flush(ctl_fd);
+
+	if (! packet_read_line(ctl_fd, buf, 1024))
+		die("daemon hung up unexpectedly");
+
+	if (strncmp(buf, "pid ", 4))
+		die("unknown response from daemon");
+
+	pid_txt = buf;
+	pid_txt += 4;
+
+	if (! sscanf(pid_txt, "%u", &pid))
+		die("malformed response from daemon");
+
+	kill(pid, SIGTERM);
+	return 0;
+}
+
+int main(int argc, const char **argv)
+{
+	if (argc < 2)
+		usage(hive_usage);
+
+	argv++;
+	argc--;
+
+	if (!strcmp(*argv, "start"))
+		return start(argc, argv);
+
+	if (!strcmp(*argv, "fetch"))
+		return fetch(argc, argv);
+
+	if (!strcmp(*argv, "show"))
+		return show(argc, argv);
+
+	if (!strcmp(*argv, "stop"))
+		return stop(argc, argv);
+
+	usage(hive_usage);
+}
-- 
1.7.2.1
