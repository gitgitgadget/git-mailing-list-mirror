From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC 2/2] Git-over-TLS (gits://) client side support (part 2 of 2)
Date: Wed, 13 Jan 2010 15:19:46 +0200
Message-ID: <1263388786-6880-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 14:20:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV38r-0007Ab-UB
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 14:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab0AMNUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 08:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754461Ab0AMNT6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 08:19:58 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:57286 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab0AMNT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 08:19:56 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id ED3DBC7E38
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:19:53 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A079CDE980A; Wed, 13 Jan 2010 15:19:53 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 525C241BEE
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:19:51 +0200 (EET)
X-Mailer: git-send-email 1.6.6.102.gd6f8f.dirty
In-Reply-To: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136818>

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 git-over-tls/main.c                       |  460 ++++++++++
 git-over-tls/{home.h => misc.c}           |   12 +-
 git-over-tls/{keypairs.h => misc.h}       |   21 +-
 git-over-tls/mkcert.c                     |  507 +++++++++++
 git-over-tls/prompt.c                     |  100 +++
 git-over-tls/prompt.h                     |   18 +
 git-over-tls/srp_askpass.c                |   90 ++
 git-over-tls/{hostkey.h => srp_askpass.h} |    9 +-
 git-over-tls/user.c                       | 1384 +++++++++++++++++++++++++++++
 git-over-tls/user.h                       |  357 ++++++++
 10 files changed, 2943 insertions(+), 15 deletions(-)
 create mode 100644 git-over-tls/main.c
 copy git-over-tls/{home.h => misc.c} (64%)
 copy git-over-tls/{keypairs.h => misc.h} (50%)
 create mode 100644 git-over-tls/mkcert.c
 create mode 100644 git-over-tls/prompt.c
 create mode 100644 git-over-tls/prompt.h
 create mode 100644 git-over-tls/srp_askpass.c
 copy git-over-tls/{hostkey.h => srp_askpass.h} (59%)
 create mode 100644 git-over-tls/user.c
 create mode 100644 git-over-tls/user.h

diff --git a/git-over-tls/main.c b/git-over-tls/main.c
new file mode 100644
index 0000000..a3c8f51
--- /dev/null
+++ b/git-over-tls/main.c
@@ -0,0 +1,460 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "user.h"
+#include "srp_askpass.h"
+#include "keypairs.h"
+#include "hostkey.h"
+#include "connect.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <gnutls/gnutls.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+struct parsed_addr
+{
+	char *protocol;		/* Protocol part */
+	char *user;		/* User part, NULL if no user */
+	char *host;		/* Hostname */
+	char *uhost;		/* Unique host + port */
+	char *port;		/* Port as string, NULL if no port */
+	char *path;		/* Path part. */
+	char *vhost_header;	/* vhost header to send */
+	unsigned short _port;	/* Port as numeric. */
+};
+
+char *copy_alloc(const char *str, size_t len)
+{
+	char *copy;
+
+	copy = xmalloc(len + 1);
+	copy[len] = 0;
+	strncpy(copy, str, len);
+	return copy;
+}
+
+void append_uniq_address(char* buffer, struct parsed_addr* _addr)
+{
+	if (strchr(_addr->host, ':'))
+		strcat(buffer, "[");
+	strcat(buffer, _addr->host);
+	if (strchr(_addr->host, ':'))
+		strcat(buffer, "]");
+	if (_addr->port) {
+		strcat(buffer, ":");
+		strcat(buffer, _addr->port);
+	}
+}
+
+struct parsed_addr parse_address(const char *addr)
+{
+	struct parsed_addr _addr;
+	const char *proto_end;
+	const char *path_start;
+	const char *uhp_start;
+	const char *uhp_delim;
+	const char *orig_addr = addr;
+	size_t addrlen;
+
+	addrlen = strlen(addr);
+
+	proto_end = strchr(addr, ':');
+	if (!proto_end)
+		goto bad;
+
+	_addr.protocol = copy_alloc(addr, proto_end - addr);
+	if (strncmp(proto_end, "://", 3))
+		goto bad;
+
+	uhp_start = proto_end + 3;
+
+	/* Figure out the user if any. */
+	uhp_delim = strpbrk(uhp_start, "@[:/");
+
+	if (*uhp_delim == '@') {
+		_addr.user = copy_alloc(uhp_start,
+			uhp_delim - uhp_start);
+		uhp_start = uhp_delim + 1;
+	} else {
+		_addr.user = NULL;
+	}
+
+	/* Figure out host. */
+	if (*uhp_start == '[') {
+		uhp_delim = strpbrk(uhp_start, "]");
+		if (uhp_delim) {
+			_addr.host = copy_alloc(uhp_start + 1,
+				uhp_delim - uhp_start - 1);
+			if (uhp_delim[1] != ':' && uhp_delim[1] != '/')
+				goto bad;
+			uhp_start = uhp_delim + 1;
+		} else
+			goto bad;
+	} else {
+		uhp_delim = strpbrk(uhp_start, "[:/");
+		if (*uhp_delim == '[')
+			goto bad;
+		_addr.host = copy_alloc(uhp_start, uhp_delim - uhp_start);
+		uhp_start = uhp_delim;
+	}
+
+	path_start = strchr(uhp_start, '/');
+	if (!path_start)
+		goto bad;
+
+	_addr.path = copy_alloc(path_start, addrlen - (path_start - addr));
+
+	if (*uhp_start == ':')
+		_addr.port = copy_alloc(uhp_start + 1,
+			path_start - uhp_start - 1);
+	else
+		_addr.port = NULL;
+
+	if (!*_addr.host)
+		goto bad;
+
+	if (strcmp(_addr.protocol, "gits") && strcmp(_addr.protocol, "tls") &&
+		strcmp(_addr.protocol, "git")) {
+		die("Unknown protocol %s://", _addr.protocol);
+	}
+
+	if (!strcmp(_addr.protocol, "git") && _addr.user) {
+		die("git:// does not support users");
+	}
+
+	if (_addr.port) {
+		char *end;
+		unsigned long x;
+		x = strtoul(_addr.port, &end, 10);
+		if (*end)
+			goto bad;
+		if (x < 1 || x > 65535)
+			goto bad;
+		_addr._port = (unsigned short)x;
+	} else if (!strcmp(_addr.protocol, "gits")) {
+		_addr._port = 9418;
+	} else if (!strcmp(_addr.protocol, "git")) {
+		_addr._port = 9418;
+	} else if (!strcmp(_addr.protocol, "tls")) {
+		die("tls:// needs port specification");
+	}
+
+	if (_addr.port) {
+		/* 9 is for host=[]:\0 */
+		size_t vhost_len = 7 + strlen(_addr.host) +
+			strlen(_addr.port);
+		_addr.vhost_header = xmalloc(vhost_len);
+		_addr.uhost = xmalloc(vhost_len);
+	} else {
+		/* 8 is for host=[]\0 */
+		size_t vhost_len = 6 + strlen(_addr.host);
+		_addr.vhost_header = xmalloc(vhost_len);
+		_addr.uhost = xmalloc(vhost_len);
+	}
+
+	strcpy(_addr.vhost_header, "host=");
+	append_uniq_address(_addr.vhost_header, &_addr);
+
+	strcpy(_addr.uhost, "");
+	append_uniq_address(_addr.uhost, &_addr);
+
+	return _addr;
+bad:
+	die("Bad URL \"%s\"", orig_addr);
+	/* Can't come here. */
+	return _addr;
+}
+
+#define MODE_ALLOW_EOF 0
+#define MODE_HANDSHAKE 1
+
+static void traffic_loop(struct user *user, int mode)
+{
+	fd_set rfds;
+	fd_set wfds;
+	int failcode = 0;
+	struct timeval deadline;
+	int bound = 0;
+	int r;
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
+	user_add_to_sets(user, &bound, &rfds, &wfds, &deadline);
+	if (bound == 0) {
+		failcode = user_get_failure(user);
+		if (failcode)
+			goto failed;
+		return;
+	}
+	r = select(bound, &rfds, &wfds, NULL, NULL);
+	if (r < 0 && errno != EINTR) {
+		die_errno("select() failed");
+	} else if (r < 0) {
+		FD_ZERO(&rfds);
+		FD_ZERO(&wfds);
+	}
+	user_service(user, &rfds, &wfds);
+	failcode = user_get_failure(user);
+	if (failcode)
+		goto failed;
+	return;
+failed:
+	if (failcode > 0 && mode == MODE_ALLOW_EOF)
+		return;
+	else if (failcode > 0) {
+		die("Expected more data, got connection closed");
+	} else {
+		const char *major;
+		const char *minor;
+
+		major = user_explain_failure(failcode);
+		minor = user_get_error(user);
+
+		if (minor)
+			die("Connection lost: %s (%s)", major, minor);
+		else
+			die("Connection lost: %s", major);
+	}
+}
+
+static int select_keypair(gnutls_certificate_credentials_t creds,
+	const char *username, int must_succeed)
+{
+	int ret;
+	ret = select_keypair_int(creds, username);
+	if (ret < 0 && must_succeed)
+		die("No keypair identity %s found", username);
+	return ret;
+}
+
+static gnutls_session_t session;
+
+static void preconfigure_tls(const char *username)
+{
+	int s;
+	gnutls_certificate_credentials_t creds;
+	int keypair_ok = 0;
+#ifndef DISABLE_SRP
+	const char *srp_password;
+	gnutls_srp_client_credentials_t srp_cred;
+	int kx[3];
+#endif
+
+	s = gnutls_global_init();
+	if (s < 0)
+		die("Can't initialize GnuTLS: %s", gnutls_strerror(s));
+
+	s = gnutls_certificate_allocate_credentials(&creds);
+	if (s < 0)
+		die("Can't allocate cert creds: %s", gnutls_strerror(s));
+
+	s = gnutls_init(&session, GNUTLS_CLIENT);
+	if (s < 0)
+		die("Can't allocate session: %s", gnutls_strerror(s));
+
+#ifndef DISABLE_SRP
+	s = gnutls_priority_set_direct (session, "NORMAL:+SRP-DSS:+SRP-RSA",
+		NULL);
+#else
+	s = gnutls_priority_set_direct (session, "NORMAL", NULL);
+#endif
+	if (s < 0)
+		die("Can't set priority: %s", gnutls_strerror(s));
+
+	if (username) {
+		if (!prefixcmp(username, "key-")) {
+			select_keypair(creds, username + 4, 1);
+			keypair_ok = 1;
+		} else
+			keypair_ok = (select_keypair(creds, username, 0)
+				>= 0);
+	}
+
+	s = gnutls_credentials_set (session, GNUTLS_CRD_CERTIFICATE, creds);
+	if (s < 0)
+		die("Can't set creds: %s", gnutls_strerror(s));
+
+	if (keypair_ok)
+		goto no_srp;
+#ifndef DISABLE_SRP
+	if (username && !prefixcmp(username, "srp-"))
+		username = username + 4;
+	if (!username || !*username)
+		goto no_srp;
+
+	s = gnutls_srp_allocate_client_credentials(&srp_cred);
+	if (s < 0)
+		die("Can't allocate SRP creds: %s", gnutls_strerror(s));
+
+	s = 0;
+	srp_password = get_srp_password(username);
+	s = gnutls_srp_set_client_credentials(srp_cred, username, srp_password);
+	if (s < 0)
+		die("Can't set SRP creds: %s", gnutls_strerror(s));
+
+	s = gnutls_credentials_set(session, GNUTLS_CRD_SRP, srp_cred);
+	if (s < 0)
+		die("Can't use SRP creds: %s", gnutls_strerror(s));
+
+	/* GnuTLS doesn't seem to like to use SRP. Force it. */
+	kx[0] = GNUTLS_KX_SRP_DSS;
+	kx[1] = GNUTLS_KX_SRP_RSA;
+	kx[2] = 0;
+	s = gnutls_kx_set_priority(session, kx);
+	if (s < 0)
+		die("Can't force SRP: %s", gnutls_strerror(s));
+#endif
+no_srp:
+	;
+}
+
+static void configure_tls(struct user *user, const char *hostname)
+{
+	user_configure_tls(user, session);
+
+	/* Wait for TLS connection to establish. */
+	while (!user_get_tls(user))
+		traffic_loop(user, MODE_HANDSHAKE);
+
+	check_hostkey(session, hostname);
+}
+
+#define MAX_REQUEST 8192
+const char *hexes = "0123456789abcdef";
+
+static void do_request(const char *arg, struct parsed_addr *addr,
+	int supress_ok)
+{
+	int fd;
+	struct user *dispatcher;
+	struct cbuffer *inbuf;
+	struct cbuffer *outbuf;
+	const char *major;
+	const char *minor;
+	char reqbuf[MAX_REQUEST + 4];
+	size_t reqsize;
+
+	preconfigure_tls(addr->user);
+
+	fd = connect_host(addr->host, addr->_port);
+
+	/* Create dispatcher with no time limit. */
+	dispatcher = user_create(fd, 65535);
+	if (!dispatcher)
+		die("Can't create connection context");
+	user_clear_deadline(dispatcher);
+
+	inbuf = user_get_red_in(dispatcher);
+	outbuf = user_get_red_out(dispatcher);
+	if (!strcmp(addr->protocol, "git")) {
+		; /* Not protected. */
+	} else if (!strcmp(addr->protocol, "tls")) {
+		configure_tls(dispatcher, addr->uhost);
+	} else {
+		cbuffer_write(inbuf, (unsigned char*)"000cstarttls", 12);
+		while (1) {
+			char tmpbuf[9];
+			int s;
+			traffic_loop(dispatcher, MODE_HANDSHAKE);
+			s = cbuffer_peek(outbuf, (unsigned char*)tmpbuf, 8);
+			tmpbuf[8] = '\0';
+			if (s >= 0 && !strcmp(tmpbuf, "proceed\n"))
+				break;
+			if (user_red_out_eofd(dispatcher))
+				goto wait_eofd;
+			if (user_get_failure(dispatcher))
+				goto wait_failed;
+		}
+		configure_tls(dispatcher, addr->uhost);
+	}
+
+	reqsize = strlen(arg) + strlen(addr->path) +  3 +
+		strlen(addr->vhost_header);
+
+	if (reqsize > MAX_REQUEST)
+		die("Request too big to send");
+
+	memcpy(reqbuf + 4, arg, strlen(arg));
+	reqbuf[strlen(arg) + 4] = ' ';
+	memcpy(reqbuf + strlen(arg) + 5, addr->path, strlen(addr->path) + 1);
+	memcpy(reqbuf + strlen(arg) + 6 + strlen(addr->path),
+		addr->vhost_header, strlen(addr->vhost_header) + 1);
+
+	reqbuf[0] = hexes[((reqsize + 4) >> 12) & 0xF];
+	reqbuf[1] = hexes[((reqsize + 4) >> 8) & 0xF];
+	reqbuf[2] = hexes[((reqsize + 4) >> 4) & 0xF];
+	reqbuf[3] = hexes[(reqsize + 4) & 0xF];
+
+	cbuffer_write(inbuf, (unsigned char*)reqbuf, reqsize + 4);
+	while (cbuffer_used(outbuf))
+		traffic_loop(dispatcher, MODE_HANDSHAKE);
+	/* Ok, remote end has replied. */
+	printf("\n");
+	fflush(stdout);
+	user_set_red_io(dispatcher, 0, 1, -1);
+
+	while (!user_get_failure(dispatcher))
+		traffic_loop(dispatcher, MODE_ALLOW_EOF);
+	exit(0);
+
+wait_failed:
+	major = user_explain_failure(user_get_failure(dispatcher));
+	minor = user_get_error(dispatcher);
+
+	if (minor)
+		die("Connection lost: %s (%s)", major, minor);
+	else
+		die("Connection lost: %s", major);
+	exit(128);
+wait_eofd:
+	die("Expected response to starttls, server closed connection.");
+	exit(128);
+}
+
+int main(int argc, char **argv)
+{
+	struct parsed_addr paddr;
+	char buffer[8192];
+
+	if (argc < 3) {
+		die("Need two arguments");
+	}
+
+	paddr = parse_address(argv[2]);
+
+	if (!prefixcmp(argv[1], "--service=")) {
+		do_request(argv[1] + 10, &paddr, 1);
+		return 0;
+	}
+
+	while (1) {
+		char *cmd;
+
+		cmd = fgets(buffer, 8190, stdin);
+		if (cmd[strlen(cmd) - 1] == '\n')
+			cmd[strlen(cmd) - 1] = '\0';
+
+		if (!strcmp(cmd, "capabilities")) {
+			printf("*connect\n\n");
+			fflush(stdout);
+		} else if (!*cmd) {
+			exit(0);
+		} else if (!prefixcmp(cmd, "connect ")) {
+			do_request(cmd + 8, &paddr, 0);
+			return 0;
+		} else
+			die("Unknown command %s", cmd);
+	}
+	return 0;
+}
diff --git a/git-over-tls/home.h b/git-over-tls/misc.c
similarity index 64%
copy from git-over-tls/home.h
copy to git-over-tls/misc.c
index 133ee78..3d3e0b3 100644
--- a/git-over-tls/home.h
+++ b/git-over-tls/misc.c
@@ -5,9 +5,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef _home__h__included__
-#define _home__h__included__
+#include "misc.h"
+#include <unistd.h>
+#include <errno.h>
 
-const char *get_home();
-
-#endif
+void force_close(int fd)
+{
+	while (close(fd) < 0 && errno != EBADF);
+}
diff --git a/git-over-tls/keypairs.h b/git-over-tls/misc.h
similarity index 50%
copy from git-over-tls/keypairs.h
copy to git-over-tls/misc.h
index 11f4ef7..140341f 100644
--- a/git-over-tls/keypairs.h
+++ b/git-over-tls/misc.h
@@ -5,12 +5,23 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef _keypairs__h__included__
-#define _keypairs__h__included__
+#ifndef _misc__h__included__
+#define _misc__h__included__
 
-#include <gnutls/openpgp.h>
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Forcibly close the file descriptor.
+ *
+ * Input
+ *	fd		The file descriptor.
+ */
+void force_close(int fd);
 
-int select_keypair_int(gnutls_certificate_credentials_t creds,
-	const char *username);
+#ifdef __cplusplus
+}
+#endif
 
 #endif
diff --git a/git-over-tls/mkcert.c b/git-over-tls/mkcert.c
new file mode 100644
index 0000000..597f942
--- /dev/null
+++ b/git-over-tls/mkcert.c
@@ -0,0 +1,507 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009-2010
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "cbuffer.h"
+#include "home.h"
+#include "prompt.h"
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/stat.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#include "run-command.h"
+#endif
+
+#define CERT_MAX 65536
+#define BUFSIZE 8192
+
+void ensure_leading_directories()
+{
+	struct stat s;
+	char fsobj[BUFSIZE];
+	int r;
+
+	sprintf(fsobj, "%s/.gits", get_home());
+	r = stat(fsobj, &s);
+	if (r < 0 && errno != ENOENT)
+		die_errno("Stat $HOME/.gits");
+	else if (r == 0 && !S_ISDIR(s.st_mode))
+		die("$HOME/.gits exists but is not a directory");
+	else if (r < 0) {
+		/* Need to create it. */
+		if (mkdir(fsobj, 0700) < 0)
+			die_errno("Create $HOME/.gits failed");
+	}
+	/* Otherwise, r == 0 && S_ISDIR(s), which is OK. */
+	sprintf(fsobj, "%s/.gits/keys", get_home());
+	r = stat(fsobj, &s);
+	if (r < 0 && errno != ENOENT)
+		die_errno("Stat $HOME/.gits/keys");
+	else if (r == 0 && !S_ISDIR(s.st_mode))
+		die("$HOME/.gits/keys exists but is not a directory");
+	else if (r < 0) {
+		/* Need to create it. */
+		if (mkdir(fsobj, 0700) < 0)
+			die_errno("Create $HOME/.gits/keys failed");
+	 }
+}
+
+
+static int seal_cert(struct cbuffer *sealed, struct cbuffer *unsealed,
+	const char *sealer)
+{
+	struct child_process child;
+	char **argv;
+	char *sealer_copy;
+	int splits = 0;
+	int escape = 0;
+	int ridx, widx, tidx;
+	int cleanup = 0;
+	const char *i;
+
+	signal(SIGPIPE, SIG_IGN);
+
+	for (i = sealer; *i; i++) {
+		if (escape)
+			escape = 0;
+		else if (*i == '\\')
+			escape = 1;
+		else if (*i == ' ')
+			splits++;
+	}
+
+	argv = xmalloc((splits + 2) * sizeof(char*));
+	argv[splits + 1] = NULL;
+
+	sealer_copy = xstrdup(sealer);
+	argv[0] = sealer_copy;
+
+	ridx = 0;
+	widx = 0;
+	tidx = 1;
+	escape = 0;
+	while (sealer_copy[ridx]) {
+		if (escape) {
+			escape = 0;
+			sealer_copy[widx++] = sealer_copy[ridx++];
+		} else if (sealer_copy[ridx] == '\\') {
+			ridx++;
+			escape = 1;
+		} else if (sealer_copy[ridx] == ' ') {
+			sealer_copy[widx++] = '\0';
+			argv[tidx++] = sealer_copy + widx;
+			ridx++;
+		} else
+			sealer_copy[widx++] = sealer_copy[ridx++];
+	}
+	sealer_copy[widx] = '\0';
+
+	memset(&child, 0, sizeof(child));
+	child.argv = (const char**)argv;
+	child.in = -1;
+	child.out = -1;
+	child.err = 0;
+	if (start_command(&child))
+		return -1;
+	cleanup = 1;
+
+	while (1) {
+		int bound;
+		fd_set rf;
+		fd_set wf;
+		int r;
+
+		FD_ZERO(&rf);
+		FD_ZERO(&wf);
+		FD_SET(child.out, &rf);
+		if (cbuffer_used(unsealed))
+			FD_SET(child.in, &wf);
+		else
+			close(child.in);
+
+		if (cbuffer_used(sealed))
+			bound = ((child.out > child.in) ? child.out :
+				child.in) + 1;
+		else
+			bound = child.out + 1;
+
+		r = select(bound, &rf, &wf, NULL, NULL);
+		if (r < 0 && r != EINTR) {
+			perror("Select");
+			goto exit_error;
+		}
+		if (r < 0) {
+			FD_ZERO(&rf);
+			FD_ZERO(&wf);
+			perror("select");
+		}
+
+		if (FD_ISSET(child.out, &rf)) {
+			r = cbuffer_read_fd(sealed, child.out);
+			if (r < 0 && errno != EINTR && errno != EAGAIN) {
+				fprintf(stderr, "Read from sealer "
+					"failed: %s", strerror(errno));
+				goto exit_error;
+			}
+			if (r < 0 && errno == EAGAIN)
+				if (!cbuffer_free(sealed)) {
+					fprintf(stderr, "Keypair too big\n");
+					goto exit_error;
+			}
+			if (r < 0)
+				perror("read");
+			if (r == 0)
+				break;
+			}
+
+			if (FD_ISSET(child.in, &wf)) {
+			r = cbuffer_write_fd(unsealed, child.in);
+			if (r < 0 && errno == EPIPE) {
+				fprintf(stderr, "Sealer exited "
+					"unexpectedly\n");
+				goto exit_error;
+			}
+			if (r < 0 && errno != EINTR && errno != EAGAIN) {
+				fprintf(stderr, "Write to sealer "
+					"failed: %s", strerror(errno));
+				goto exit_error;
+			}
+			if (r < 0)
+				perror("write");
+		}
+	}
+
+	if (finish_command(&child)) {
+		cleanup = 0;
+		goto exit_error;
+	}
+
+	close(child.in);
+	close(child.out);
+
+	return 0;
+exit_error:
+	close(child.in);
+	close(child.out);
+	return -1;
+}
+
+static void append_member(struct cbuffer *cbuf, const char *filename)
+{
+	unsigned char backing[CERT_MAX];
+	struct cbuffer *content;
+	int fd;
+	size_t size = 0;
+	unsigned char buf[2];
+
+	content = cbuffer_create(backing, CERT_MAX);
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+	while (1) {
+		ssize_t r = cbuffer_read_fd(content, fd);
+		if (r < 0) {
+			if (errno == EAGAIN) {
+				if (!cbuffer_free(content)) {
+					fprintf(stderr, "Member too big.\n");
+					unlink("key.private.tmp");
+					unlink("key.public.tmp");
+					exit(1);
+				}
+			} else if (errno != EINTR) {
+				perror("read");
+				exit(1);
+			}
+		} else if (r == 0) {
+			break;
+		} else
+			size += r;
+	}
+	close(fd);
+
+	buf[0] = (unsigned char)((size >> 8) & 0xFF);
+	buf[1] = (unsigned char)((size) & 0xFF);
+	if (cbuffer_write(cbuf, buf, 2) < 0) {
+		fprintf(stderr, "Certificate too big (can't write member header).\n");
+		unlink("key.private.tmp");
+		unlink("key.public.tmp");
+		exit(1);
+	}
+	if (cbuffer_move(cbuf, content, size) < 0) {
+		fprintf(stderr, "Certificate too big (can't write member of %u "
+			"bytes).\n", size);
+		unlink("key.private.tmp");
+		unlink("key.public.tmp");
+		exit(1);
+	}
+
+	cbuffer_destroy(content);
+}
+
+
+static char *escape(char *s)
+{
+	char *ans;
+	int ridx = 0, widx = 0;
+
+	ans = xmalloc(2 * strlen(s) + 1);
+	while (s[ridx]) {
+		if (s[ridx] == '\\') {
+			ans[widx++] = '\\';
+			ans[widx++] = '\\';
+			ridx++;
+		} else if (s[ridx] == ' ') {
+			ans[widx++] = '\\';
+			ans[widx++] = ' ';
+			ridx++;
+		} else {
+			ans[widx++] = s[ridx++];
+		}
+	}
+	ans[widx] = '\0';
+	free(s);
+	return ans;
+}
+
+static int check_name(char* s)
+{
+	size_t x;
+	x = strspn(s, " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"abcdefghijklmmnopqrstuvwxyz!#$%&'*+-/=?^_`{|}~");
+	if (!x || s[x]) {
+		return -1;
+	}
+	return 0;
+}
+
+static int check_comment(char* s)
+{
+	char *at;
+	at = strchr(s, '(');
+	if (at)
+		return -1;
+	at = strchr(s, '\\');
+	if (at)
+		return -1;
+	at = strchr(s, ')');
+	if (at)
+		return -1;
+	at = s;
+	while (*at >= 32 && *at <= 126)
+		at++;
+	if (*at)
+		return -1;
+	return 0;
+}
+
+static int check_email(char* s)
+{
+	size_t x;
+	char *at;
+	at = strchr(s, '@');
+	if (!at)
+		return -1;
+	x = strspn(s, ".0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"abcdefghijklmmnopqrstuvwxyz!#$%&'*+-/=?^_`{|}~");
+	if (s[x] != '@')
+		return -1;
+	if (!at[1])
+		return -1;
+	x = strspn(at + 1, ".0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"abcdefghijklmmnopqrstuvwxyz!#$%&'*+-/=?^_`{|}~");
+	if (at[x + 1])
+		return -1;
+	return 0;
+}
+
+#define BUFSIZE 8192
+
+void write_cert(int server_mode)
+{
+	unsigned char backing1[CERT_MAX];
+	unsigned char backing2[CERT_MAX];
+	unsigned char keytemp[CERT_MAX];
+	struct cbuffer *unsealed;
+	struct cbuffer *sealed;
+	unsigned char *buf = (unsigned char*)"GITSUCERT";
+	unsigned char *buf2 = (unsigned char*)"GITSSCERT\x00\x03gpg";
+	char *name;
+	char fbuffer[BUFSIZE];
+	int fd;
+	int do_seal = 0;
+	int keylen = 1024;
+	char *realname;
+	char *comment;
+	char *email;
+	FILE *script;
+
+	if (!server_mode)
+		ensure_leading_directories();
+
+	unsealed = cbuffer_create(backing1, CERT_MAX);
+	sealed = cbuffer_create(backing2, CERT_MAX);
+
+reask_length:
+	printf("1) 1024 bit key\n");
+	printf("2) 2048 bit key\n");
+	printf("3) 3072 bit key\n");
+	name = prompt_string("Pick key length", 0);
+	if (!strcmp(name, "1"))
+		keylen = 1024;
+	else if (!strcmp(name, "2"))
+		keylen = 2048;
+	else if (!strcmp(name, "3"))
+		keylen = 3072;
+	else {
+		fprintf(stderr, "Bad choice\n");
+		goto reask_length;
+	}
+
+ask_name:
+	realname = prompt_string("Enter name to put into key", 0);
+	if (check_name(realname) < 0) {
+		fprintf(stderr, "Bad name\n");
+		goto ask_name;
+	}
+ask_comment:
+	comment = prompt_string("Enter comment to put into key", 0);
+	if (check_comment(comment) < 0) {
+		fprintf(stderr, "Bad comment\n");
+		goto ask_comment;
+	}
+ask_email:
+	email = prompt_string("Enter E-mail address to put into key", 0);
+	if (check_email(email) < 0) {
+		fprintf(stderr, "Bad E-mail address\n");
+		goto ask_email;
+	}
+
+	script = fopen("key.script.tmp", "w");
+	if (!script)
+		die("Can't create key script");
+	fprintf(script, "Key-Type: DSA\n");
+	fprintf(script, "Key-Length: %i\n", keylen);
+	fprintf(script, "Name-Real: %s\n", realname);
+	if (*comment)
+		fprintf(script, "Name-Comment: %s\n", comment);
+	fprintf(script, "Name-Email: %s\n", email);
+	fprintf(script, "Expire-Date: 0\n");
+	fprintf(script, "%%pubring key.public.tmp\n");
+	fprintf(script, "%%secring key.private.tmp\n");
+	fprintf(script, "%%commit\n");
+	fprintf(script, "%%echo done\n");
+	fclose(script);
+
+	if (system("gpg --batch --gen-key key.script.tmp")) {
+		unlink("key.private.tmp");
+		unlink("key.public.tmp");
+		unlink("key.script.tmp");
+		die("Can't generate key");
+	}
+	unlink("key.script.tmp");
+
+	append_member(unsealed, "key.private.tmp");
+	unlink("key.private.tmp");
+	append_member(unsealed, "key.public.tmp");
+	unlink("key.public.tmp");
+
+reask_seal:
+	if (server_mode)
+		goto no_seal;
+	printf("1) Don't seal key\n");
+	printf("2) Seal using password (gpg)\n");
+	printf("3) Seal using keypair (gpg)\n");
+	name = prompt_string("Pick sealing method", 0);
+	if (!strcmp(name, "1"))
+		do_seal = 0;
+	else if (!strcmp(name, "2"))
+		do_seal = 1;
+	else if (!strcmp(name, "3"))
+		do_seal = 2;
+	else {
+		fprintf(stderr, "Bad choice");
+		goto reask_seal;
+	}
+no_seal:
+	keylen = cbuffer_read_max(unsealed, keytemp, CERT_MAX);
+	cbuffer_write(unsealed, keytemp, keylen);
+
+	if (do_seal == 1) {
+		cbuffer_write(sealed, (unsigned char*)buf2, 14);
+		if (seal_cert(sealed, unsealed, "gpg --symmetric "
+			"--force-mdc") < 0) {
+			cbuffer_clear(sealed);
+			cbuffer_clear(unsealed);
+			cbuffer_write(unsealed, keytemp, keylen);
+			fprintf(stderr, "Sealing failed.\n");
+			goto reask_seal;
+		}
+	} else if (do_seal == 2) {
+		char* hint;
+		cbuffer_write(sealed, (unsigned char*)buf2, 14);
+
+		hint = prompt_string("Seal using whose key", 0);
+		hint = escape(hint);
+		sprintf(fbuffer, "gpg --encrypt --recipient %s "
+			"--force-mdc", hint);
+		free(hint);
+
+		if (seal_cert(sealed, unsealed, fbuffer) < 0) {
+			cbuffer_clear(sealed);
+			cbuffer_clear(unsealed);
+			cbuffer_write(unsealed, keytemp, keylen);
+			fprintf(stderr, "Sealing failed.\n");
+			goto reask_seal;
+		}
+	} else {
+		cbuffer_write(sealed, (unsigned char*)buf, 9);
+		cbuffer_move_nolimit(sealed, unsealed);
+		if (!cbuffer_free(sealed))
+			die("Key too large");
+	}
+
+retry_name:
+	if (server_mode) {
+		name = prompt_string("Enter filename to save key as", 0);
+		strcpy(fbuffer, name);
+	} else {
+		name = prompt_string("Enter name for key", 0);
+		if (strcspn(name, "@:/[") < strlen(name)) {
+			fprintf(stderr, "Bad name\n");
+			goto retry_name;
+		}
+		sprintf(fbuffer, "%s/.gits/keys/%s", get_home(), name);
+	}
+	if (!strcmp(name, "")) {
+		fprintf(stderr, "Bad name\n");
+		goto retry_name;
+	}
+
+	fd = open(fbuffer, O_WRONLY | O_CREAT | O_EXCL, 0600);
+	if (fd < 0) {
+		fprintf(stderr, "Can't open %s: %s\n", fbuffer,
+			strerror(errno));
+		goto retry_name;
+	}
+	while (cbuffer_used(sealed)) {
+		ssize_t r = cbuffer_write_fd(sealed, fd);
+		if (r < 0 && errno != EINTR) {
+			perror("write");
+			exit(1);
+		}
+	}
+	close(fd);
+}
diff --git a/git-over-tls/prompt.c b/git-over-tls/prompt.c
new file mode 100644
index 0000000..380156a
--- /dev/null
+++ b/git-over-tls/prompt.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "prompt.h"
+#include <termios.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <string.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+static int tmpfd;
+
+static void sigint(int x);
+
+void echo_off(int fd)
+{
+	struct termios t;
+
+	if (tcgetattr(fd, &t) < 0)
+		die_errno("Can't read terminal settings");
+
+	t.c_lflag &= ~ECHO;
+
+	tmpfd = fd;
+	signal(SIGINT, sigint);
+
+	if (tcsetattr(fd, TCSANOW, &t) < 0)
+		die_errno("Can't write terminal settings");
+}
+
+void echo_on(int fd)
+{
+	struct termios t;
+
+	if (tcgetattr(fd, &t) < 0)
+		die_errno("Can't read terminal settings");
+
+	t.c_lflag |= ECHO;
+
+	if (tcsetattr(fd, TCSANOW, &t) < 0)
+		die_errno("Can't write terminal settings");
+
+	signal(SIGINT, SIG_DFL);
+}
+
+static void sigint(int x)
+{
+	echo_on(tmpfd);
+	exit(1);
+}
+
+#define PROMPTBUF 8192
+
+char *prompt_string(const char *prompt, int without_echo)
+{
+	char ansbuf[8192];
+	char *ans;
+	int fd;
+	FILE* tty;
+
+	fd = open("/dev/tty", O_RDWR);
+	if (fd < 0)
+		die_errno("Can't open /dev/tty for password prompt");
+
+	tty = xfdopen(fd, "r+");
+
+	fprintf(tty, "%s: ", prompt);
+	fflush(tty);
+	if (without_echo)
+		echo_off(fd);
+
+	if (!fgets(ansbuf, 8190, tty)) {
+		if (without_echo)
+			echo_on(fd);
+		die("Can't read answer");
+	}
+
+	if (without_echo) {
+		fprintf(tty, "\n");
+		echo_on(fd);
+	}
+
+	if (*ansbuf && ansbuf[strlen(ansbuf) - 1] == '\n')
+		ansbuf[strlen(ansbuf) - 1] = '\0';
+
+	fclose(tty);
+
+	ans = xstrdup(ansbuf);
+	return ans;
+}
diff --git a/git-over-tls/prompt.h b/git-over-tls/prompt.h
new file mode 100644
index 0000000..34fc13a
--- /dev/null
+++ b/git-over-tls/prompt.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _prompt__h__included__
+#define _prompt__h__included__
+
+/* Turn terminal echo on specified fd off. */
+void echo_off(int fd);
+/* Turn terminal echo on specified fd on. */
+void echo_on(int fd);
+/* Prompt string from user and return mallocced copy of it. */
+char *prompt_string(const char *prompt, int without_echo);
+
+#endif
diff --git a/git-over-tls/srp_askpass.c b/git-over-tls/srp_askpass.c
new file mode 100644
index 0000000..0c0da36
--- /dev/null
+++ b/git-over-tls/srp_askpass.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "srp_askpass.h"
+#include "prompt.h"
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+#ifdef USE_COMPAT_H
+#include "compat.h"
+#else
+#include "git-compat-util.h"
+#endif
+
+#define PROMPTBUF 8192
+#define CMDBUFSIZE 16384
+
+/* Use GITS_ASKPASS to ask for password. */
+static char *get_password_via_external(const char *username,
+	const char *prog)
+{
+	static char buffer[PROMPTBUF + 1];
+	static char cmdbuffer[CMDBUFSIZE + 1];
+	char *ans;
+	int escape = 0;
+	int idx;
+	int len;
+	int widx = 0;
+	FILE *out;
+
+	if (strchr(username, '\"'))
+		die("Can't prompt for usernames containing '\"'");
+
+	len = snprintf(buffer, PROMPTBUF + 1, "\"Enter SRP password for %s\"",
+		username);
+	if (len < 0 || len > PROMPTBUF)
+		die("SRP Username is insanely long");
+
+	for (idx = 0; prog[idx]; idx++) {
+		if (!escape && prog[idx] == '%')
+			escape = 1;
+		else if (escape && prog[idx] == 'p') {
+			if (widx + strlen(buffer) >= CMDBUFSIZE)
+				die("Command line too long");
+			strcpy(cmdbuffer + widx, buffer);
+			widx += strlen(buffer);
+		} else {
+			if (widx + 1 >= CMDBUFSIZE)
+				die("Command line too long");
+			cmdbuffer[widx++] = prog[idx];
+			escape = 0;
+		}
+	}
+	cmdbuffer[widx++] = '\0';
+
+	out = popen(cmdbuffer, "r");
+	if (!out)
+		die_errno("Can't invoke $GITS_ASKPASS");
+
+	if (!fgets(buffer, PROMPTBUF - 2, out)) {
+		die("Can't read password");
+	}
+
+	if (strlen(buffer) > 0 && buffer[strlen(buffer) - 1] == '\n')
+		buffer[strlen(buffer) - 1] = '\0';
+
+	if (pclose(out))
+		die("Authentication canceled");
+
+	ans = xstrdup(buffer);
+	return ans;
+}
+
+char *get_srp_password(const char *username)
+{
+	static char buffer[PROMPTBUF + 1];
+
+	if (getenv("GITS_ASKPASS"))
+		return get_password_via_external(username,
+			getenv("GITS_ASKPASS"));
+
+	sprintf(buffer, "Enter SRP password for %s", username);
+	return prompt_string(buffer, 1);
+}
diff --git a/git-over-tls/hostkey.h b/git-over-tls/srp_askpass.h
similarity index 59%
copy from git-over-tls/hostkey.h
copy to git-over-tls/srp_askpass.h
index c0e7dfe..d7271fd 100644
--- a/git-over-tls/hostkey.h
+++ b/git-over-tls/srp_askpass.h
@@ -5,11 +5,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef _hostkey__h__included__
-#define _hostkey__h__included__
+#ifndef _srp_askpass__h__included__
+#define _srp_askpass__h__included__
 
-#include <gnutls/gnutls.h>
-
-void check_hostkey(gnutls_session_t session, const char *hostname);
+/* Get SRP password. Return is malloced */
+char *get_srp_password(const char *username);
 
 #endif
diff --git a/git-over-tls/user.c b/git-over-tls/user.c
new file mode 100644
index 0000000..2bb23f5
--- /dev/null
+++ b/git-over-tls/user.c
@@ -0,0 +1,1384 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "user.h"
+#include "cbuffer.h"
+#include "misc.h"
+#include <sys/select.h>
+#include <sys/time.h>
+#include <gnutls/gnutls.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#ifdef USE_TRAP_PAGING
+#include <sys/mman.h>
+#endif
+
+/*
+ * NOTE: This code may not crash, call exit or anything similar unless
+ * program state is corrupt or call parameters are completely invalid.
+ * It also may not call Git APIs.
+ */
+
+/* Main buffer size. */
+#define BUFFERSIZE 65536
+/*
+ * Error buffer can be maximum of 65535-8 bytes and must be smaller or
+ * equal in size to main buffers.
+ */
+#define ERR_BUFFERSIZE (65535-8)
+
+struct user
+{
+	/* If 1, EOF received from black in at transport level. */
+	unsigned u_black_in_eof : 1,
+	/* If 1, EOF sent to black out at transport level. */
+		u_black_out_eof : 1,
+	/* If 1, EOF received from black in at TLS level. */
+		u_black_in_d_eof : 1,
+	/* If 1, EOF sent to black out at TLS level. */
+		u_black_out_d_eof : 1,
+	/* If 1, Assume that there is more input to come from red in. */
+		u_red_assume_more : 1,
+	/* If 1, TLS is active and ready to transfer data. */
+		u_tls_active : 1,
+	/* If 1, there has been data received from red in. */
+		u_red_in_have_data : 1,
+	/*
+	 * Result of last read of decrypted data.
+	 * 0 => Read was successful or not attempted yet.
+	 * 1 => Read was blocked by insufficient input data.
+	 * 2 => Read was blocked by insufficient output space.
+	 * 3 => (Reserved)
+	 */
+		u_want_read : 2,
+	/*
+	 * Result of last write of decrypted data.
+	 * 0 => Write was successful or not attempted yet.
+	 * 1 => Write was blocked by insufficient input data.
+	 * 2 => Write was blocked by insufficient output space.
+	 * 3 => (Reserved)
+	 */
+		u_want_write : 2,
+	/*
+	 * Result of last handshake attempt.
+	 * 0 => Handshake was successful or not attempted yet.
+	 * 1 => Handshake was blocked by insufficient input data.
+	 * 2 => Handshake was blocked by insufficient output space.
+	 * 3 => (Reserved)
+	 */
+		u_want_hand : 2,
+	/* Number of bytes of error header sent (0-8). */
+		u_red_err_hdr_sent : 4,
+	/* Delay TLS failure present. 1 for handshake, 2 otherwise */
+		u_delay_tls_failure : 2,
+	/* Has seen any data received. */
+		u_seen_input_data : 1;
+
+	/* File descriptors. -1 if none. */
+	int u_black_fd;		/* Input/Output */
+	int u_red_in_fd;	/* Input */
+	int u_red_out_fd;	/* Output */
+	int u_red_err_fd;	/* Input */
+	/* The backing buffer for all transfer buffers and its size. */
+	unsigned char *u_buf_backing;
+	size_t u_buf_backing_size;
+	/* The actual transfer buffers. */
+	struct cbuffer *u_black_in_buf;
+	struct cbuffer *u_black_out_buf;
+	struct cbuffer *u_red_in_buf;
+	struct cbuffer *u_red_out_buf;
+	struct cbuffer *u_red_err_buf;
+	/* Deadline. Tv_sec is -1 if there is no deadline. */
+	struct timeval u_deadline;
+	/*
+	 * Why the connection was torn down. Delay_failure is delayed
+	 * failure that becomes real after output buffer is flushed
+	 * so that TLS alerts are sent. Also stored is delayed TLS alert
+	 * that couldn't be sent yet.
+	 */
+	int u_failure;
+	char *u_errmsg;
+	int u_delay_failure;
+	gnutls_alert_description_t u_delay_alert;
+	/* Active TLS session. NULL if no TLS. */
+	gnutls_session_t u_tls_session;
+};
+
+/* Initiate delayed failure on user. */
+static void delay_cleanup_user(struct user *user, int failure,
+	const char *error)
+{
+	/* Store the cause of termination. */
+	if (!user->u_errmsg) {
+		if (error)
+			user->u_errmsg = strdup(error);
+		else
+			user->u_errmsg = NULL;
+	}
+	user->u_delay_failure = failure;
+}
+
+/* Clean up user connection immediately. */
+static void cleanup_user(struct user *user, int failure, const char *error)
+{
+	/* If there is TLS session, deallocate its resources. */
+	if (user->u_tls_session) {
+		gnutls_deinit(user->u_tls_session);
+		user->u_tls_session = NULL;
+	}
+	/* Shutdown and close black input/output. */
+	if (user->u_black_fd >= 0) {
+		shutdown(user->u_black_fd, SHUT_WR);
+		force_close(user->u_black_fd);
+	}
+	user->u_black_fd = -1;
+
+	/* Close red inputs/outputs. */
+	if (user->u_red_in_fd >= 0)
+		force_close(user->u_red_in_fd);
+	user->u_red_in_fd = -1;
+	if (user->u_red_out_fd >= 0)
+		force_close(user->u_red_out_fd);
+	user->u_red_out_fd = -1;
+	if (user->u_red_err_fd >= 0)
+		force_close(user->u_red_err_fd);
+	user->u_red_err_fd = -1;
+
+	/* Store the cause of termination. */
+	if (!user->u_errmsg) {
+		if (error)
+			user->u_errmsg = strdup(error);
+		else
+			user->u_errmsg = NULL;
+	}
+	user->u_failure = failure;
+}
+
+/*
+ * Process delay failure. If there is delayed failure and output buffer is
+ * empty, make it real failure and disconnect user immediately.
+ */
+static int process_delay_failure(struct user *user)
+{
+	if (user->u_failure)
+		return 0;
+	if (!cbuffer_used(user->u_black_out_buf) && user->u_delay_failure) {
+		cleanup_user(user, user->u_delay_failure, NULL);
+		return 0;
+	}
+	return 0;
+}
+
+/* Is this error from I/O syscall fatal? */
+static int is_fatal_error(int error)
+{
+	return (error != EINTR && error != EAGAIN && error != EWOULDBLOCK);
+}
+
+/* Is this error from GnuTLS I/O operation fatal? */
+static int is_fatal_tls_error(int error)
+{
+	/*
+	 * GNUTLS_E_INTERRUPTED should never be seen. since custom push and
+	 * pull functions can't return EINTR, only EAGAIN.
+	 */
+	return (error < 0 && error != GNUTLS_E_AGAIN);
+}
+
+/* Handle fatal error received from GnuTLS functions. */
+static int handle_tls_failure_code(struct user *user, int gnutls_code,
+	int handshaking)
+{
+	int x;
+	char error_buffer[8192];
+	if (gnutls_code == GNUTLS_E_FATAL_ALERT_RECEIVED) {
+		/* Fatal alert. Get the description and format message. */
+		gnutls_alert_description_t alert;
+		alert = gnutls_alert_get(user->u_tls_session);
+		sprintf(error_buffer, "TLS alert received: %s",
+			gnutls_alert_get_name(alert));
+
+		if (alert == GNUTLS_A_BAD_RECORD_MAC && handshaking)
+			sprintf(error_buffer, "TLS alert received: %s "
+				"(incorrect password?)",
+				gnutls_alert_get_name(alert));
+
+		/* Terminate the connection. */
+		if (handshaking)
+			cleanup_user(user, USER_TLS_HAND_ERROR,
+				error_buffer);
+		else
+			cleanup_user(user, USER_TLS_ERROR,
+				error_buffer);
+		return 0;
+	}
+	/*
+	 * Alerts use handshake readyness indicator, so try to set it
+	 * to "perform I/O immediately".
+	 */
+	user->u_want_hand = 0;
+	/*
+	 * Mark that delay TLS failure is present and get the alert
+	 * that should be sent. Also set error message.
+	 */
+	user->u_delay_tls_failure = 1;
+#ifndef DISABLE_SRP
+	/* GnuTLS doesn't seem to have proper code for this. */
+	if (gnutls_code == GNUTLS_E_SRP_PWD_ERROR)
+		user->u_delay_alert = GNUTLS_A_UNKNOWN_PSK_IDENTITY;
+	else
+#endif
+		user->u_delay_alert = (gnutls_alert_description_t)
+			gnutls_error_to_alert((int)gnutls_code, &x);
+	user->u_errmsg = strdup(gnutls_strerror_name((int)gnutls_code));
+	return 1;
+}
+
+/* Handle black input activity */
+static int black_in_handler(struct user *user, fd_set *rfds)
+{
+	/* Don't attempt to read if connection has failed. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* The file descrptor must be marked readable. */
+	if (user->u_black_fd < 0 || !FD_ISSET(user->u_black_fd, rfds))
+		return 0;
+	/* Don't attempt to read already EOF'd file descriptor. */
+	if (user->u_black_in_eof)
+		return 0;
+
+	ssize_t r = cbuffer_read_fd(user->u_black_in_buf, user->u_black_fd);
+	FD_CLR(user->u_black_fd, rfds);
+	if (r < 0 && is_fatal_error(errno)) {
+		/* Inbound connection faulted! */
+		cleanup_user(user, USER_LAYER4_ERROR, strerror(errno));
+	} else if (r == 0) {
+		/* Received EOF. */
+		user->u_black_in_eof = 1;
+	} else if (r > 0) {
+		/* Received some data. */
+		user->u_seen_input_data = 1;
+	}
+	return 1;
+}
+
+/* Handle black output activity. */
+static int black_out_handler(struct user *user, fd_set *wfds)
+{
+	/*
+	 * Don't attempt to write if connection has failed.  This is one of
+	 * the very few handlers still to run in delayed failure.
+	 */
+	if (user->u_failure)
+		return 0;
+	/* The file descrptor must be marked as writable. */
+	if (user->u_black_fd < 0 || !FD_ISSET(user->u_black_fd, wfds))
+		return 0;
+	/* Don't attempt to write if EOF has already been sent. */
+	if (user->u_black_out_eof)
+		return 0;
+
+	ssize_t r = cbuffer_write_fd(user->u_black_out_buf, user->u_black_fd);
+	FD_CLR(user->u_black_fd, wfds);
+	if (r < 0 && is_fatal_error(errno)) {
+		/* Outbound connection faulted! */
+		cleanup_user(user, USER_LAYER4_ERROR, strerror(errno));
+	} else if (r > 0) {
+		/* Sent some data. */
+	}
+	return 1;
+}
+
+/* Send black out EOF if needed (using TLS if it is active) */
+static int black_out_eof_handler(struct user *user)
+{
+	/* Don't operate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate anymore if EOF has been sent outbound. */
+	if (user->u_black_out_eof || user->u_black_out_d_eof)
+		return 0;
+	/* Don't activate if there can be more data from red in. */
+	if (user->u_red_assume_more || user->u_red_in_fd >= 0)
+		return 0;
+	/* Don't activate if there can be more data from red error. */
+	if (user->u_red_err_fd >= 0)
+		return 0;
+	/* Don't activate if there is more data in red input. */
+	if (cbuffer_used(user->u_red_in_buf))
+		return 0;
+	/* Don't activate if there is more data in red error. */
+	if (cbuffer_used(user->u_red_err_buf))
+		return 0;
+	/*
+	 * If not in TLS mode, don't activate if there is data in send
+	 * buffer.
+	 */
+	if (!user->u_tls_session && cbuffer_used(user->u_black_out_buf))
+		return 0;
+
+	if (user->u_tls_session) {
+		int r;
+		/* Try to send the EOF at TLS level. */
+		r = gnutls_bye(user->u_tls_session, GNUTLS_SHUT_WR);
+		if (r == 0) {
+			/* Suceeded. Mark the connection as EOF'd. */
+			user->u_black_out_d_eof = 1;
+			return 1;
+		} else if (is_fatal_tls_error((int)r)) {
+			/* Fatal stream error! */
+			return handle_tls_failure_code(user, (int)r, 0);
+		}
+		/* Otherwise we failed due to non-fatal TLS error. We'll try
+		   again soon. */
+		return 0;
+	} else {
+		/* Try to send normal transport EOF. */
+		if (shutdown(user->u_black_fd, SHUT_WR) < 0) {
+			/* Failed, declare as stream error. */
+			cleanup_user(user, USER_LAYER4_ERROR,
+				strerror(errno));
+			return 0;
+		}
+		user->u_black_out_eof = 1;
+		return 1;
+	}
+	return 0; /* Should not be here. */
+}
+
+/* Send EOF to red output if needed. */
+static int red_out_eof_handler(struct user *user)
+{
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate unless input EOF has been received. */
+	if (!user->u_black_in_eof && !user->u_black_in_d_eof)
+		return 0;
+	/* Don't activate anymore if red out has been closed. */
+	if (user->u_red_out_fd < 0)
+		return 0;
+	/* If not in TLS mode, don't activate if there is data in receive
+	   buffer. */
+	if (!user->u_tls_session && cbuffer_used(user->u_black_in_buf))
+		return 0;
+	/* Don't activate if there is more data in red output. */
+	if (cbuffer_used(user->u_red_out_buf))
+		return 0;
+
+	force_close(user->u_red_out_fd);
+	user->u_red_out_fd = -1;
+	return 1;
+}
+
+/* Send data to file descriptor connected to red output. */
+static int red_out_handler(struct user *user, fd_set *wfds)
+{
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Red out must be writable fd. */
+	if (user->u_red_out_fd < 0 || !FD_ISSET(user->u_red_out_fd, wfds))
+		return 0;
+
+	ssize_t r = cbuffer_write_fd(user->u_red_out_buf, user->u_red_out_fd);
+	FD_CLR(user->u_red_out_fd, wfds);
+	if (r < 0 && errno == EPIPE) {
+		/* EPIPE is treated as special type of EOF. We need to read
+		   EOFs from process. */
+		force_close(user->u_red_out_fd);
+		user->u_red_out_fd = -1;
+		return 1;
+	} else if (r < 0 && is_fatal_error(errno)) {
+		/* Red out connection faulted! */
+		cleanup_user(user, USER_RED_FAILURE, strerror(errno));
+		return 0;
+	} else if (r > 0) {
+		/* Sent some data to red output. */
+		return 1;
+	}
+	/* Can't come here. */
+	return 0;
+}
+
+/* Recieve data from file descriptor connected to red input. */
+static int red_in_handler(struct user *user, fd_set *rfds)
+{
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Red in must be readable fd. */
+	if (user->u_red_in_fd < 0 || !FD_ISSET(user->u_red_in_fd, rfds))
+		return 0;
+
+	ssize_t r = cbuffer_read_fd(user->u_red_in_buf, user->u_red_in_fd);
+	FD_CLR(user->u_red_in_fd, rfds);
+	if (r < 0 && is_fatal_error(errno)) {
+		/* Inbound red connection faulted! */
+		cleanup_user(user, USER_RED_FAILURE, strerror(errno));
+		return 0;
+	} else if (r == 0) {
+		/* Close it so we eventually send EOF. */
+		user->u_red_assume_more = 0;
+		force_close(user->u_red_in_fd);
+		user->u_red_in_fd = -1;
+		return 1;
+	} else if (r > 0) {
+		/* Received some data. */
+		user->u_red_in_have_data = 1;
+
+		/* Clear the error buffer. */
+		cbuffer_clear(user->u_red_err_buf);
+	}
+	return 1;
+}
+
+#define DUMMYBUFSIZE 256
+
+/* Receive data from file descriptor connected to red error. */
+static int red_err_handler(struct user *user, fd_set *rfds)
+{
+	ssize_t r;
+	char buf[DUMMYBUFSIZE];
+
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Red err must be readable fd. */
+	if (user->u_red_err_fd < 0 || !FD_ISSET(user->u_red_err_fd, rfds))
+		return 0;
+
+	if (!user->u_red_in_have_data) {
+		/* Read the red error for real. */
+		r = cbuffer_read_fd(user->u_red_err_buf, user->u_red_err_fd);
+	} else {
+		/* Just do dummy read and discard the reuslts. */
+		r = read(user->u_red_err_fd, buf, DUMMYBUFSIZE);
+	}
+	FD_CLR(user->u_red_err_fd, rfds);
+	if (r < 0 && is_fatal_error(errno)) {
+		/* Inbound red connection faulted! */
+		cleanup_user(user, USER_RED_FAILURE, strerror(errno));
+	} else if (r == 0) {
+		/* Close it so we eventually send EOF. */
+		force_close(user->u_red_err_fd);
+		user->u_red_err_fd = -1;
+	} else if (r > 0) {
+		/*
+		 * Received some data.
+		 *
+		 * HACK ALERT: Some systems seem to like to send these
+		 * non-errors on error channel. Ignore those and treat
+		 * them like data from stdout. (35 is length of that
+		 * string).
+		 */
+		const char* tmsg = "Initialized empty Git repository in";
+		unsigned char tmp[35];
+		if (cbuffer_peek(user->u_red_err_buf, tmp, 35) >= 0 &&
+			!strncmp(tmsg, (char*)tmp, 35)) {
+			user->u_red_in_have_data = 1;
+			cbuffer_clear(user->u_red_err_buf);
+		}
+	}
+	return 1;
+}
+
+/* Terminate the whole connection if needed EOFs have been seen. */
+static int connection_eof_handler(struct user *user)
+{
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate if red out is still open. */
+	if (user->u_red_out_fd >= 0)
+		return 0;
+	/* Don't activate unless output EOF has been asserted. */
+	if (!user->u_black_out_eof && !user->u_black_out_d_eof)
+		return 0;
+	/* Don't assert in TLS mode unless output buffer is empty. */
+	if (user->u_tls_session && cbuffer_used(user->u_black_out_buf))
+		return 0;
+
+	/* Both half-connections have ended. End the entiere connection. */
+	cleanup_user(user, USER_CONNECTION_END, NULL);
+	return 1;
+}
+
+/*
+ * Should operation take place given last operation failed practicular way?
+ * Direction2 is 0 if last operation didn't fail, 1 if it failed due to
+ * insufficient data to read, 2 if it failed due to insufficient space to
+ * write.
+ */
+static int gnutls_blacks_activate2(struct user *user, int direction2)
+{
+	/*
+	 * If not attempted yet, or last time it was successful, attempt
+	 * immediately again.
+	 */
+	if (direction2 == 0)
+		return 1;
+	/*
+	 * If last time it failed due to insufficient read space, try
+	 * again only if there is some data in read buffers now.
+	 */
+	if (direction2 == 1) {
+		if (cbuffer_used(user->u_black_in_buf) != 0)
+			return 1;
+		else if (!user->u_black_in_eof)
+			return 0;
+		else if (user->u_tls_session && user->u_seen_input_data)
+			cleanup_user(user, USER_TLS_ERROR, "Connection "
+				"closed unexpectedly");
+		else if (user->u_tls_session)
+			cleanup_user(user, USER_LAYER4_ERROR, "Connection "
+				"broke before any data was received");
+		else
+			return 0;
+	}
+	/*
+	 * If last time it failed due to insufficient write space, try
+	 * again only if there is some space in write buffers now.
+	 */
+	if (direction2 == 2)
+		return (cbuffer_free(user->u_black_out_buf) != 0);
+	return 0;
+}
+
+/* Copy or decrypt data from black input to red output. */
+static int black_to_red_handler(struct user *user)
+{
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate if there's TLS but it isn't ready yet. */
+	if (user->u_tls_session && !user->u_tls_active)
+		return 0;
+	/* Don't activate if there's no space in red out buffer. */
+	if (!cbuffer_free(user->u_red_out_buf))
+		return 0;
+	/* Don't activate if TLS-level EOF has been received. */
+	if (user->u_black_in_d_eof)
+		return 0;
+	/* Check that we don't fail like last time. */
+	if (!gnutls_blacks_activate2(user, user->u_want_read))
+		return 0;
+
+	if (!user->u_tls_session) {
+		/*
+		 * no-TLS case. Just compute how much data we can move and
+		 * then just move it from black in buffer to red out buffer.
+		 */
+		size_t amount;
+		amount = cbuffer_move_nolimit(user->u_red_out_buf,
+			user->u_black_in_buf);
+		if (amount > 0) {
+			/* Ok, some data to move. Just move it. */
+			user->u_want_read = 0;
+			return 1;
+		} else {
+			/*
+			 * No data to transfer. Mark operation failed due to
+			 * insufficient data to read.
+			 */
+			user->u_want_read = 1;
+			return 0;
+		}
+	} else {
+		unsigned char *ptr;
+		size_t size;
+		ssize_t r;
+
+		/*
+		 * Compute the segment for writing data to. And if we do get
+		 * such segment, receive data to it. The size == 0 case should
+		 * not happen because we checked that there's space in red
+		 * out buffer above.
+		 */
+		cbuffer_fill_w_segment(user->u_red_out_buf, &ptr, &size);
+		r = gnutls_record_recv(user->u_tls_session, ptr, size);
+		if (r > 0) {
+			/* Received TLS data. */
+			cbuffer_commit_w_segment(user->u_red_out_buf, r);
+			user->u_want_read = 0;
+			return 1;
+		} else if (r == 0) {
+			/* Received TLS EOF. */
+			user->u_black_in_d_eof = 1;
+			user->u_want_read = 0;
+			return 1;
+		} else if (is_fatal_tls_error((int)r)) {
+			/* Fatal TLS error. */
+			return handle_tls_failure_code(user, (int)r, 0);
+		} else if (r < 0) {
+			/* Temporary read failure. */
+			user->u_want_read = 1 + gnutls_record_get_direction(
+				user->u_tls_session);
+			return 0;
+		}
+	}
+	/* Can't really come here. */
+	return 0;
+}
+
+/* Copy or encrypt data from red input to black output. */
+static int red_to_black_handler(struct user *user)
+{
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate if TLS is present but not active. */
+	if (user->u_tls_session && !user->u_tls_active)
+		return 0;
+	/* Require data in red in buffer. */
+	if (!cbuffer_used(user->u_red_in_buf))
+		return 0;
+	/* Don't fail like last time. */
+	if (!gnutls_blacks_activate2(user, user->u_want_write))
+		return 0;
+
+	if (!user->u_tls_session) {
+		/*
+		 * No-TLS case. Just find maximum amount of data to move and
+		 * then move the data.
+		 */
+		size_t amount;
+		amount = cbuffer_move_nolimit(user->u_black_out_buf,
+			user->u_red_in_buf);
+		if (amount > 0) {
+			/* Ok, some data to move. Just move it. */
+			user->u_want_write = 0;
+			return 1;
+		} else {
+			/*
+			 * No data to transfer. Mark operation failed due to
+			 * insufficient space to write.
+			 */
+			user->u_want_write = 2;
+			return 0;
+		}
+	} else {
+		unsigned char *ptr;
+		size_t size;
+		ssize_t r = 0;
+
+		/*
+		 * Compute the segment for reading data to. And if we do get
+		 * such segment, send data from it. The size == 0 case should
+		 * not happen because we checked that there's data in red
+		 * in buffer above.
+		 */
+		cbuffer_fill_r_segment(user->u_red_in_buf, &ptr, &size);
+		if (!user->u_want_write)
+			/* Last was success, just send new record. */
+			r = gnutls_record_send(user->u_tls_session, ptr,
+				size);
+		else
+			/* Last time it failed, try to resend the record. */
+			r = gnutls_record_send(user->u_tls_session, NULL, 0);
+		if (r > 0) {
+			/* Sent some TLS data. */
+			cbuffer_commit_r_segment(user->u_red_in_buf, r);
+			user->u_want_write = 0;
+			return 1;
+		} else if (is_fatal_tls_error((int)r)) {
+			/* Fatal TLS error. */
+			return handle_tls_failure_code(user, (int)r, 0);
+		} else if (r < 0) {
+			/* Temporary send failure. */
+			user->u_want_write = 1 + gnutls_record_get_direction(user->u_tls_session);
+			return 0;
+		}
+	}
+	/* Can't really come here. */
+	return 0;
+}
+
+static const char hexes[] = "0123456789abcdef";
+
+#define TMPBUFSIZE 256
+
+/* Copy or encrypt data from red error to black out. */
+static int rederr_to_black_handler(struct user *user)
+{
+	unsigned char hdrbuf[8];
+	unsigned char buffer[TMPBUFSIZE];
+	size_t bufusage = 0;
+	size_t pcktsize;
+	unsigned char *segstart;
+	size_t seglen;
+	size_t maxread;
+
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate if TLS is not yet ready. */
+	if (user->u_tls_session && !user->u_tls_active)
+		return 0;
+	/* Don't activate if there's no data in red error. */
+	if (!cbuffer_used(user->u_red_err_buf))
+		return 0;
+	/* Don't activate if red in hasn't been closed. */
+	if (user->u_red_in_fd >= 0)
+		return 0;
+	/* Don't activate if red error can have more data. */
+	if (user->u_red_err_fd >= 0 && cbuffer_free(user->u_red_err_buf))
+		return 0;
+	/* Don't fail like last write. */
+	if (!gnutls_blacks_activate2(user, user->u_want_write))
+		return 0;
+
+	/* Safety hatch. Truncate error if too long. */
+	if (!cbuffer_free(user->u_red_err_buf) && user->u_red_err_fd >= 0) {
+		force_close(user->u_red_err_fd);
+		user->u_red_err_fd = -1;
+	}
+
+	/* Fill the header. */
+	pcktsize = 8 + cbuffer_used(user->u_red_err_buf);
+	hdrbuf[0] = hexes[pcktsize / 4096 % 16];
+	hdrbuf[1] = hexes[pcktsize / 256 % 16];
+	hdrbuf[2] = hexes[pcktsize / 16 % 16];
+	hdrbuf[3] = hexes[pcktsize % 16];
+	hdrbuf[4] = 'E';
+	hdrbuf[5] = 'R';
+	hdrbuf[6] = 'R';
+	hdrbuf[7] = ' ';
+	/*
+	 * If header hasn't been sent yet, copy the remainder of header to
+	 * transfer buffer.
+	 */
+	if (user->u_red_err_hdr_sent < 8) {
+		memcpy(buffer, hdrbuf + user->u_red_err_hdr_sent,
+			8 - user->u_red_err_hdr_sent);
+		bufusage = (8 - user->u_red_err_hdr_sent);
+	}
+	maxread = TMPBUFSIZE - bufusage;
+
+	/*
+	 * Request read segment out of red error. There's always data in
+	 * red error buffer by checks above. Then copy as much data from
+	 * it as possible.
+	 */
+	cbuffer_fill_r_segment(user->u_red_err_buf, &segstart, &seglen);
+	if (maxread >= seglen) {
+		memcpy(buffer + bufusage, segstart, seglen);
+		bufusage += seglen;
+	} else {
+		memcpy(buffer + bufusage, segstart, maxread);
+		bufusage += maxread;
+	}
+
+	/*
+	 * Bufusage is always positive, since its either equal to seglen
+	 * or maxread, and neither can be zero.
+	 */
+	if (!user->u_tls_session && !user->u_red_in_have_data) {
+		/*
+		 * Compute maximum amount of data that can be copied to
+		 * send buffer (no TLS case).
+		 */
+		bufusage = cbuffer_write_max(user->u_black_out_buf, buffer,
+			bufusage);
+		if (bufusage > 0)
+			user->u_want_write = 0;
+		else {
+			/* No space, mark it failed due to write. */
+			user->u_want_write = 2;
+			return 0;
+		}
+	} else if (!user->u_red_in_have_data) {
+		ssize_t r;
+
+		if (!user->u_want_write)
+			/* Last was success, just send new record. */
+			r = gnutls_record_send(user->u_tls_session, buffer,
+				bufusage);
+		else
+			/* Last time it failed, try to resend the record. */
+			r = gnutls_record_send(user->u_tls_session, NULL, 0);
+		if (r > 0) {
+			/* Successfully sent data. Adjust bufusage. */
+			bufusage = r;
+			user->u_want_write = 0;
+		} else if (is_fatal_tls_error((int)r)) {
+			/* Fatal TLS error. */
+			return handle_tls_failure_code(user, (int)r, 0);
+		} else if (r < 0) {
+			/* Temporary failure. Mark the failure. */
+			user->u_want_write = 1 + gnutls_record_get_direction(
+				user->u_tls_session);
+			bufusage = 0;
+			return 0;
+		}
+	}
+
+	/* Now bufusage is set to amount of bytes sent. ACK the data sent. */
+	if ((size_t)user->u_red_err_hdr_sent + bufusage < 8) {
+		/* Partially sent header. ACK the header sent. */
+		user->u_red_err_hdr_sent += bufusage;
+		bufusage = 0;
+		return 1;
+	} else {
+		/*
+		 * Completely sent the header. ACK rest of it and substract
+		 * it from actual data sent.
+		 */
+		bufusage -= (8 - user->u_red_err_hdr_sent);
+		user->u_red_err_hdr_sent = 8;
+	}
+	/* ACK the actual error data sent. */
+	if (bufusage > 0)
+		cbuffer_commit_r_segment(user->u_red_err_buf, bufusage);
+
+	return 1;
+}
+
+/* Try to send delayed alert. */
+static int tls_alert_handler(struct user *user)
+{
+	int r;
+
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't do this without delayed tls failure. */
+	if (!user->u_delay_tls_failure)
+		return 0;
+	/* Don't fail like last time. */
+	if (!gnutls_blacks_activate2(user, user->u_want_hand))
+		return 0;
+
+	r = gnutls_alert_send(user->u_tls_session, GNUTLS_AL_FATAL,
+		user->u_delay_alert);
+	if (r == 0) {
+		/* The user->u_delay_tls_failure may be 2 too. */
+		if (user->u_delay_tls_failure == 1)
+			delay_cleanup_user(user, USER_TLS_HAND_ERROR,
+				"Fatal alert sent");
+		else
+			delay_cleanup_user(user, USER_TLS_ERROR,
+				"Fatal alert sent");
+		return 0;
+	} else if (is_fatal_tls_error(r)) {
+		const char *err = gnutls_strerror_name((int)r);
+		delay_cleanup_user(user, USER_TLS_ERROR, err);
+		return 1;
+	} else if (r < 0) {
+		/* Still needs more attempts to send. */
+		user->u_want_hand = 1 + gnutls_record_get_direction(
+			user->u_tls_session);
+		return 0;
+	}
+	/* Can't really come here. */
+	return 0;
+}
+
+/* Try to handshake TLS connection. */
+static int handshake_handler(struct user *user)
+{
+	int r;
+
+	/* Don't activate on already failed connections. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Don't activate if TLS is ready or no TLS. */
+	if (user->u_tls_active || !user->u_tls_session)
+		return 0;
+	/* Don't handshake anoymore with delayed TLS failure. */
+	if (user->u_delay_tls_failure)
+		return 0;
+	/* Don't fail like last time. */
+	if (!gnutls_blacks_activate2(user, user->u_want_hand))
+		return 0;
+
+	r = gnutls_handshake(user->u_tls_session);
+	if (r == 0) {
+		/* Handshake completed, TLS ready. */
+		user->u_want_hand = 0;
+		user->u_tls_active = 1;
+		return 1;
+	} else if (is_fatal_tls_error(r)) {
+		/* Fatal TLS error. */
+		return handle_tls_failure_code(user, (int)r, 1);
+	} else if (r < 0) {
+		/* Still needs more handshaking. */
+		user->u_want_hand = 1 + gnutls_record_get_direction(
+			user->u_tls_session);
+		return 0;
+	}
+	/* Can't really come here. */
+	return 0;
+}
+
+/*
+ * Compare two timevals. Returns -1 if first is first, 0 if same, 1 otherwise
+ */
+static int tv_compare(const struct timeval *tv1, const struct timeval *tv2)
+{
+	if (tv1->tv_sec == -1)
+		return (tv2->tv_sec == -1) ? 0 : 1;
+	if (tv2->tv_sec == -1)
+		return -1;
+	if (tv1->tv_sec > tv2->tv_sec)
+		return 1;
+	if (tv1->tv_sec < tv2->tv_sec)
+		return -1;
+	if (tv1->tv_usec > tv2->tv_usec)
+		return 1;
+	if (tv1->tv_usec < tv2->tv_usec)
+		return -1;
+	return 0;
+}
+
+/* Handle timeouts on connection. */
+static int timeout_handler(struct user *user)
+{
+	struct timeval t;
+
+	gettimeofday(&t, NULL);
+
+	/* Don't activate on already failed connection. */
+	if (user->u_failure || user->u_delay_failure)
+		return 0;
+	/* Is it time to activate? */
+	if (tv_compare(&user->u_deadline, &t) >= 0)
+		return 0;
+
+	cleanup_user(user, USER_TIMEOUT, "Request timeout");
+	return 0;
+}
+
+/* GnuTLS push function. */
+static ssize_t gnutls_push_data(gnutls_transport_ptr_t ptr, const void *data,
+	size_t size)
+{
+	struct user *user = (struct user*)ptr;
+
+	/* Compute maximum transfer. */
+	if (size > cbuffer_free(user->u_black_out_buf))
+		size = cbuffer_free(user->u_black_out_buf);
+
+	/* If no data can be read, send EAGAIN. */
+	if (size == 0) {
+		errno = EAGAIN;
+		return -1;
+	}
+
+	cbuffer_write(user->u_black_out_buf, (unsigned char*)data, size);
+	return size;
+}
+
+/* GnuTLS pull function. */
+static ssize_t gnutls_pull_data(gnutls_transport_ptr_t ptr, void *data,
+	size_t size)
+{
+	struct user *user = (struct user*)ptr;
+
+	/* Compute maximum transfer. */
+	if (size > cbuffer_used(user->u_black_in_buf))
+		size = cbuffer_used(user->u_black_in_buf);
+
+	/* If no data can be written, send EAGAIN. */
+	if (size == 0) {
+		errno = EAGAIN;
+		return -1;
+	}
+
+	cbuffer_read(user->u_black_in_buf, (unsigned char*)data, size);
+	return size;
+
+}
+
+void user_configure_tls(struct user *user, gnutls_session_t session)
+{
+	user->u_tls_session = session;
+	user->u_want_hand = 0;
+	user->u_tls_active = 0;
+	/* Configure the TLS session transport level. */
+	gnutls_transport_set_ptr(session, user);
+	gnutls_transport_set_push_function(session, gnutls_push_data);
+	gnutls_transport_set_pull_function(session, gnutls_pull_data);
+	gnutls_transport_set_lowat(session, 0);
+	/*
+	 * For security reasons, clear the red output as that can no
+	 * longer be trusted.
+	 */
+	cbuffer_clear(user->u_red_out_buf);
+}
+
+void user_add_to_sets(struct user *user, int *bound, fd_set *rfds,
+	fd_set *wfds, struct timeval *deadline)
+{
+	/*
+	 * Execute all service handlers in case they alter what
+	 * files should be waited on.
+	 */
+	user_service_nofd(user);
+
+	/* Adjust deadline. */
+	if (tv_compare(deadline, &user->u_deadline) > 0)
+		*deadline = user->u_deadline;
+
+	if (user->u_red_out_fd >= 0 && cbuffer_used(user->u_red_out_buf)) {
+		/* Red out is writable. */
+		FD_SET(user->u_red_out_fd, wfds);
+		if (*bound <= user->u_red_out_fd)
+			*bound = user->u_red_out_fd + 1;
+	}
+	if (user->u_black_fd >= 0 && !user->u_black_in_eof &&
+		/* Black in is readable. */
+		cbuffer_free(user->u_black_in_buf)) {
+		FD_SET(user->u_black_fd, rfds);
+		if (*bound <= user->u_black_fd)
+			*bound = user->u_black_fd + 1;
+	}
+	/* Intentionally bias red to black towards writing to black. */
+	if (user->u_black_fd >= 0 && !user->u_black_out_eof &&
+		/* Black out is writable. */
+		cbuffer_used(user->u_black_out_buf)) {
+		FD_SET(user->u_black_fd, wfds);
+		if (*bound <= user->u_black_fd)
+			*bound = user->u_black_fd + 1;
+	} else if (user->u_red_in_fd >= 0 &&
+		cbuffer_free(user->u_red_in_buf)) {
+		/* Red in is readable. */
+		FD_SET(user->u_red_in_fd, rfds);
+		if (*bound <= user->u_red_in_fd)
+			*bound = user->u_red_in_fd + 1;
+	}
+	if (user->u_red_err_fd >= 0 && cbuffer_free(user->u_red_err_buf)) {
+		/* Red err is readable. */
+		FD_SET(user->u_red_err_fd, rfds);
+		if (*bound <= user->u_red_err_fd)
+			*bound = user->u_red_err_fd + 1;
+	}
+}
+
+void user_service(struct user *user, fd_set *rfds, fd_set *wfds)
+{
+	int newr = 1;
+
+	/* Do this until no service handler makes any progress. */
+	while (newr) {
+		newr = 0;
+		newr = newr | black_in_handler(user, rfds);
+		newr = newr | black_out_handler(user, wfds);
+		newr = newr | red_in_handler(user, rfds);
+		newr = newr | red_out_handler(user, wfds);
+		newr = newr | red_err_handler(user, rfds);
+		newr = newr | black_out_eof_handler(user);
+		newr = newr | red_out_eof_handler(user);
+		newr = newr | connection_eof_handler(user);
+		newr = newr | black_to_red_handler(user);
+		newr = newr | red_to_black_handler(user);
+		newr = newr | rederr_to_black_handler(user);
+		newr = newr | timeout_handler(user);
+		newr = newr | handshake_handler(user);
+		newr = newr | tls_alert_handler(user);
+		newr = newr | process_delay_failure(user);
+	}
+}
+
+void user_service_nofd(struct user *user)
+{
+	fd_set rfds;
+	fd_set wfds;
+
+	/* Clear the fd sets, we don't do I/O here. */
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
+	user_service(user, &rfds, &wfds);
+}
+
+gnutls_session_t user_get_tls(struct user *user)
+{
+	if (user->u_tls_session && user->u_tls_active)
+		return user->u_tls_session;
+	else
+		return NULL;
+}
+
+void user_set_red_io(struct user *user, int red_in, int red_out, int red_err)
+{
+	user->u_red_in_fd = red_in;
+	user->u_red_out_fd = red_out;
+	user->u_red_err_fd = red_err;
+	if (red_in >= 0)
+		fcntl(red_in, F_SETFL, fcntl(red_in, F_GETFL) | O_NONBLOCK);
+	if (red_out >= 0)
+		fcntl(red_out, F_SETFL, fcntl(red_out, F_GETFL) | O_NONBLOCK);
+	if (red_err >= 0)
+		fcntl(red_err, F_SETFL, fcntl(red_err, F_GETFL) | O_NONBLOCK);
+}
+
+void user_clear_red_io(struct user *user)
+{
+	if (user->u_red_out_fd >= 0)
+		force_close(user->u_red_out_fd);
+	user->u_red_out_fd = -1;
+}
+
+struct cbuffer *user_get_red_in(struct user *user)
+{
+	if (user->u_red_in_fd >= 0)
+		return NULL;
+	else
+		return user->u_red_in_buf;
+}
+
+struct cbuffer *user_get_red_out(struct user *user)
+{
+	if (user->u_red_out_fd >= 0)
+		return NULL;
+	else
+		return user->u_red_out_buf;
+}
+
+int user_get_failure(struct user *user)
+{
+	return user->u_failure;
+}
+
+const char *user_get_error(struct user *user)
+{
+	return user->u_errmsg;
+}
+
+void user_send_red_in_eof(struct user *user)
+{
+	user->u_red_assume_more = 0;
+}
+
+struct cbuffer *user_get_red_err(struct user *user)
+{
+	if (user->u_red_err_fd >= 0 || user->u_red_in_have_data)
+		return NULL;
+	else
+		return user->u_red_err_buf;
+}
+
+void user_clear_deadline(struct user *user)
+{
+	user->u_deadline.tv_sec = -1;
+}
+
+size_t round_up(size_t base, size_t divide)
+{
+	return base + (divide - base % divide) % divide;
+}
+
+struct user *user_create(int black_fd, unsigned deadline_secs)
+{
+	struct timeval t;
+	size_t offset[5];
+#ifdef USE_TRAP_PAGING
+	size_t trap[6];
+#endif
+	int i;
+
+	for (i = 0; i < 5; i++)
+		offset[i] = i * BUFFERSIZE;
+
+	fcntl(black_fd, F_SETFL, fcntl(black_fd, F_GETFL) | O_NONBLOCK);
+
+	/* Compute the deadline field value. */
+	gettimeofday(&t, NULL);
+	t.tv_sec += deadline_secs;
+
+	/* How much to allocate for buffers? */
+	int r = 0;
+	size_t allocsize = 4 * BUFFERSIZE + ERR_BUFFERSIZE;
+
+	/* Allocate the primary structure. */
+	struct user *user = (struct user*)malloc(sizeof(struct user));
+	if (!user)
+		return NULL;
+
+	/* Allocate memory for buffer backing buffer. */
+#ifdef USE_TRAP_PAGING
+	allocsize = 4 * round_up(BUFFERSIZE, getpagesize()) +
+		round_up(ERR_BUFFERSIZE, getpagesize()) +
+		6 * getpagesize();
+
+	for (i = 0; i < 5; i++) {
+		offset[i] = i * round_up(BUFFERSIZE, getpagesize()) + (i + 1) * getpagesize();
+		trap[i] = offset[i] - getpagesize();
+	}
+	trap[5] = allocsize - getpagesize();
+
+	user->u_buf_backing_size = allocsize;
+	user->u_buf_backing = (unsigned char*)mmap(NULL,
+		user->u_buf_backing_size,
+		PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (user->u_buf_backing == MAP_FAILED)
+		r = -1;
+	for (i = 0; i < 6; i++)
+		if (mprotect(user->u_buf_backing + trap[i], getpagesize(),
+			PROT_NONE) < 0) {
+			munmap(user->u_buf_backing, user->u_buf_backing_size);
+			r = -1;
+			break;
+		}
+#else
+	user->u_buf_backing = (unsigned char*)malloc(allocsize);
+	user->u_buf_backing_size = 0;
+	if (!user->u_buf_backing)
+		r = -1;
+#endif
+	if (r < 0) {
+		free(user);
+		return NULL;
+	}
+
+	user->u_black_in_eof = 0;
+	user->u_black_out_eof = 0;
+	user->u_black_in_d_eof = 0;
+	user->u_black_out_d_eof = 0;
+	user->u_want_read = 0;
+	user->u_want_write = 0;
+	user->u_want_hand = 0;
+	user->u_red_assume_more = 1;
+	user->u_red_in_have_data = 0;
+	user->u_red_err_hdr_sent = 0;
+	user->u_tls_active = 0;
+	user->u_black_fd = black_fd;
+	user->u_red_in_fd = -1;
+	user->u_red_out_fd = -1;
+	user->u_red_err_fd = -1;
+	user->u_black_in_buf = cbuffer_create(user->u_buf_backing +
+		offset[0], BUFFERSIZE);
+	user->u_black_out_buf = cbuffer_create(user->u_buf_backing +
+		offset[1], BUFFERSIZE);
+	user->u_red_in_buf = cbuffer_create(user->u_buf_backing +
+		offset[2], BUFFERSIZE);
+	user->u_red_out_buf = cbuffer_create(user->u_buf_backing +
+		offset[3], BUFFERSIZE);
+	user->u_red_err_buf = cbuffer_create(user->u_buf_backing +
+		offset[4], ERR_BUFFERSIZE);
+	if (!user->u_black_in_buf || !user->u_black_out_buf ||
+		!user->u_red_in_buf || !user->u_red_out_buf ||
+		!user->u_red_err_buf) {
+		/* Failed to allocate memory. */
+		cbuffer_destroy(user->u_black_in_buf);
+		cbuffer_destroy(user->u_black_out_buf);
+		cbuffer_destroy(user->u_red_in_buf);
+		cbuffer_destroy(user->u_red_out_buf);
+		cbuffer_destroy(user->u_red_err_buf);
+#ifdef USE_TRAP_PAGING
+		munmap(user->u_buf_backing, user->u_buf_backing_size);
+#else
+		free(user->u_buf_backing);
+#endif
+		free(user);
+		return NULL;
+	}
+	user->u_deadline = t;
+	user->u_failure = USER_STILL_ACTIVE;
+	user->u_delay_failure = USER_STILL_ACTIVE;
+	user->u_errmsg = NULL;
+	user->u_tls_session = NULL;
+	user->u_delay_tls_failure = 0;
+	return user;
+}
+
+
+
+void user_release(struct user *user)
+{
+	if (!user->u_failure)
+		cleanup_user(user, USER_KILL, "User session killed");
+
+	cbuffer_destroy(user->u_black_in_buf);
+	cbuffer_destroy(user->u_black_out_buf);
+	cbuffer_destroy(user->u_red_in_buf);
+	cbuffer_destroy(user->u_red_out_buf);
+	cbuffer_destroy(user->u_red_err_buf);
+	free(user->u_errmsg);
+
+#ifdef USE_TRAP_PAGING
+	munmap(user->u_buf_backing, user->u_buf_backing_size);
+#else
+	free(user->u_buf_backing);
+#endif
+	free(user);
+}
+
+int user_tls_configured(struct user *user)
+{
+	return (user->u_tls_session != NULL);
+}
+
+const char *user_explain_failure(int code)
+{
+	switch(code) {
+	case USER_STILL_ACTIVE:
+		return "Still active";
+	case USER_CONNECTION_END:
+		return "Connection closed";
+	case USER_LAYER4_ERROR:
+		return "Transport error";
+	case USER_TLS_ERROR:
+		return "TLS error";
+	case USER_TLS_HAND_ERROR:
+		return "TLS handshake error";
+	case USER_KILL:
+		return "User killed";
+	case USER_RED_FAILURE:
+		return "Subprocess failure";
+	case USER_TIMEOUT:
+		return "Timeout";
+	default:
+		return "Unknown error";
+	}
+}
+
+struct cbuffer *user_get_red_in_force(struct user *user)
+{
+	return user->u_red_in_buf;
+}
+
+struct cbuffer *user_get_red_out_force(struct user *user)
+{
+	return user->u_red_out_buf;
+}
+
+struct cbuffer *user_get_red_err_force(struct user *user)
+{
+	return user->u_red_err_buf;
+}
+
+void user_tls_send_alert(struct user *user, gnutls_alert_description_t alert)
+{
+	char error_buffer[8192];
+	if (!user->u_tls_session)
+		return;
+
+	user->u_delay_tls_failure = 1;
+	user->u_delay_alert = alert;
+	sprintf(error_buffer, "TLS alert forced: %s",
+		gnutls_alert_get_name(alert));
+	user->u_errmsg = strdup(error_buffer);
+}
+
+int user_red_out_eofd(struct user *user)
+{
+	if (user->u_red_out_fd >= 0)
+		return 0;
+	if (user->u_tls_session && !user->u_black_in_d_eof)
+		return 0;
+	if (!user->u_tls_session && cbuffer_used(user->u_black_in_buf))
+		return 0;
+	if (!user->u_tls_session && !user->u_black_in_eof)
+		return 0;
+	return 1;
+}
diff --git a/git-over-tls/user.h b/git-over-tls/user.h
new file mode 100644
index 0000000..e921c98
--- /dev/null
+++ b/git-over-tls/user.h
@@ -0,0 +1,357 @@
+/*
+ * Copyright (C) Ilari Liusvaara 2009
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _user__h__included__
+#define _user__h__included__
+
+#include <gnutls/gnutls.h>
+#include "cbuffer.h"
+#include <stdint.h>
+#include <sys/time.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Terminoloyy:
+ *	black:
+ *		Side of user session connected to socket. Transports
+ *		unencrypted or TLS data between peers.
+ *	red:
+ *		Side of user session connected to server loop or to
+ *		helper program.
+ *	red input:
+ *		Input buffer unencrypted data is read from. May be connected
+ *		to file descriptor. In that case that file descriptor is
+ *		read for data.
+ *	red output:
+ *		Output buffer decrypted data is written to. May be connected
+ *		to file descriptor. In that cse that file descriptor is
+ *		written with the data.
+ *	red error:
+ *		Input buffer error input is read from. May be connecte to
+ *		file descriptor, which is read for input data. If red input
+ *		file descriptor has data succesfully read, the red error buffer
+ *		is cleared and any further error input is redirected to bit
+ *		bucket. If red input closes with red error having data, then
+ *		that data is sent as ERR packet when red error has associated
+ *		file descriptor closed.
+ *	red_in:
+ *		File descriptor associated with red input.
+ *	red_out:
+ *		File descriptor associated with red output.
+ *	red_err:
+ *		File descriptor associated with red error.
+ *	deadline:
+ *		Time to disconnect (some) client on or perform some other
+ *		service.
+ */
+
+/* Main session structure. Opaque type. */
+struct user;
+
+/* Failure codes. */
+/* User still active. */
+#define USER_STILL_ACTIVE	0
+/* Connection normal end. */
+#define USER_CONNECTION_END	1
+/* Transport error. */
+#define USER_LAYER4_ERROR	-1
+/* TLS error while not handshaking. */
+#define USER_TLS_ERROR		-2
+/* TLS handshake error. */
+#define USER_TLS_HAND_ERROR	-3
+/* User killed. Never returned as failure code. */
+#define USER_KILL		-4
+/* Red file descriptor I/O operation failure. */
+#define USER_RED_FAILURE	-5
+/* User timed out. */
+#define USER_TIMEOUT		-6
+
+/*
+ * Create new user session.
+ *
+ * Input:
+ *	black_fd	Black fd. Must be socket.
+ *	timeout_secs	Initial timeout in seconds.
+ *
+ * Output:
+ *	Return value	Newly created session, or NULL on out of
+ *			memory.
+ */
+struct user *user_create(int black_fd, unsigned timeout_secs);
+
+/*
+ * Configure session to use TLS. The TLS session must be preconfigured
+ * (credentials set, etc), but not handshaked.
+ *
+ * Input:
+ *	user		The user session to manipulate.
+ *	session		TLS session to assign.
+ */
+void user_configure_tls(struct user *user, gnutls_session_t session);
+
+/*
+ * Add current user session file descriptors that are ready to read or
+ * write to file descriptor sets for read or write. Also update dead-
+ * line if needed.
+ *
+ * Input:
+ *	user		The user session to handle.
+ *	bound		Current file descriptor bound. 0 if there are
+ *			no file descriptors in either set.
+ *	rfds		Read file descriptor set.
+ *	wfds		Write file descriptor set.
+ *	deadline	Current deadline for select.
+ *
+ * Output:
+ *	bound		Updated file descriptor bound.
+ *	rfds		Updated read file descriptor set.
+ *	wfds		Updated write file descriptor set.
+ *	deadline	Updated deadline for select.
+ */
+void user_add_to_sets(struct user *user, int *bound, fd_set *rfds,
+	fd_set *wfds, struct timeval *deadline);
+
+/*
+ * Service this user.
+ *
+ * Input:
+ *	user		The user session to handle.
+ *	rfds		Ready to read file descriptors.
+ *	wfds		Ready to write file descriptors.
+ */
+void user_service(struct user *user, fd_set *rfds, fd_set *wfds);
+
+/*
+ * Service this user without doing any I/O
+ *
+ * Input:
+ *	user		The user session to handle.
+ */
+void user_service_nofd(struct user *user);
+
+/*
+ * Get failure class.
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	0 if connection is active, 1 if end
+ *			of connection, negative code if connection
+ *			ended with error. See USER_* defintions.
+ */
+int user_get_failure(struct user *user);
+
+/*
+ * Get explanation of failure code.
+ *
+ * Input:
+ *	code		The failure code.
+ *
+ * Output:
+ *	Return value	String explaining the code. Do not
+ *			free this.
+ */
+const char *user_explain_failure(int code);
+
+/*
+ * Get more detailed error message to explain the failure.
+ *
+ * Input:
+ *	user		The user session.
+ *
+ * Output:
+ *	Return value	Error message or NULL if there is
+ *			no more detailed error message. Do
+ *			not free this.
+ *
+ * Notes:
+ *	- Error message can be NULL or not independently of
+ *	  main failure status.
+ */
+const char *user_get_error(struct user *user);
+
+/*
+ * Has TLS been configured?
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	Nonzero if configured, zero if not.
+ */
+/* Returns 1 if TLS has been configured, 0 otherwise. */
+int user_tls_configured(struct user *user);
+
+/*
+ * Return TLS session associated with user session.
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	If TLS is configured and has handshaked, the TLS
+ *			session. Otherwise NULL.
+ */
+gnutls_session_t user_get_tls(struct user *user);
+
+/*
+ * Free user structure. If user is still active, disconnect user hard.
+ *
+ * Input:
+ *	user		The user session to release.
+ */
+void user_release(struct user *user);
+
+/*
+ * Set red I/O file descriptors.
+ *
+ * Input:
+ *	user		The user session to manipulate.
+ *	red_in		Red input file descriptor, -1 for none.
+ *	red_out		Red output file descritpor, -1 for none.
+ *	red_err		Red error file descriptor, -1 for none.
+ *
+ * Notes:
+ *	- red_in and red_err must be read ends if present.
+ *	- red_out must be write end if present.
+ */
+void user_set_red_io(struct user *user, int red_in, int red_out, int red_err);
+
+/*
+ * Clear red I/O by closing red output and marking no red output file
+ * descriptor. This may be neeeded, since red out can't close without
+ * input to transfer.
+ *
+ * Input:
+ *	user		The user session to manipulate.
+ */
+void user_clear_red_io(struct user *user);
+
+/*
+ * Get red input buffer.
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	If red_in is set to none, the buffer, otherwise
+ *			NULL.
+ */
+struct cbuffer *user_get_red_in(struct user *user);
+
+/*
+ * Get red output buffer.
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	If red_out is set to none, the buffer, otherwise
+ *			NULL.
+ */
+struct cbuffer *user_get_red_out(struct user *user);
+
+/*
+ * Get red error buffer.
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	If red_err is set to none and no data has been
+ *			received through red_in, the buffer, otherwise
+ *			NULL.
+ */
+struct cbuffer *user_get_red_err(struct user *user);
+
+/*
+ * Clear deadline (don't generate timeout anymore).
+ *
+ * Input:
+ *	user		The user session to manipulate.
+ */
+void user_clear_deadline(struct user *user);
+
+/*
+ * Send EOF to red input.
+ *
+ * Input:
+ *	user		The user session to manipulate.
+ *
+ * Notes:
+ *	- Only works if red input has no file descriptor associated.
+ *	- EOF is automatically sent if red_in encounters EOF.
+ */
+void user_send_red_in_eof(struct user *user);
+
+/*
+ * Force get red input buffer (even if it shouldn't be available).
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	Red input buffer.
+ */
+struct cbuffer *user_get_red_in_force(struct user *user);
+
+/*
+ * Force get red output buffer (even if it shouldn't be available).
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	Red output buffer.
+ */
+struct cbuffer *user_get_red_out_force(struct user *user);
+
+/*
+ * Force get red error buffer (even if it shouldn't be available).
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	Red error buffer.
+ */
+struct cbuffer *user_get_red_err_force(struct user *user);
+
+/*
+ * Send fatal TLS alert.
+ *
+ * Input:
+ *	user		The user session to manipulate.
+ *	alert		The alert to send.
+ *
+ * Notes:
+ *	- Ignored if no TLS has been configured.
+ */
+void user_tls_send_alert(struct user *user, gnutls_alert_description_t alert);
+
+/*
+ * Has red output been EOF'd?
+ *
+ * Input:
+ *	user		The user session to interrogate.
+ *
+ * Output:
+ *	Return value	Nonzero if red out can receive no more data and
+ *			not connected to file descriptor, otherwise zero
+ *			(more data possible).
+ */
+int user_red_out_eofd(struct user *user);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
1.6.6.102.gd6f8f.dirty
