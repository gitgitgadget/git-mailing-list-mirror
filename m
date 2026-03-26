Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE53451A6
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568283; cv=none; b=c5qdmP5H8dhhxohP5szKStS/7vMTC9jsgOyIj62aTkOBE8l/NeLN50pAJk0MP96l59nfHjfZxzWFc78o86XfNhHXW8Qj/Ck5m0NMtIYEEFRzvqYckpCJxUzdakzQotLkItRnPTnfmS85wdiDv65X7NPMEZaK/9paB2LPpLicYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568283; c=relaxed/simple;
	bh=S3TEMcUlZVfCgKO3nYOrW+fYODuOcV1GEUANKWGmYVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5aDBixoQhVls7UTuc/JNoI5FvFsvGVtajcMrh+U9lLueGOEd4kyyBVmVsZB6ULzP4TC6sAAS8/idatZjTwXDzk/ZQFckAAZ+qhMLVAzLbxSrbSzzsfXq09ApcZEG+AFGbEKl3PxQkHbJ7T3iNhB/Oq2SgzNiUlA9o8T103NSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fhgF13qj1z9vCh;
	Fri, 27 Mar 2026 00:37:57 +0100 (CET)
From: Wesley Schwengle <wesleys@opperschaap.net>
To: git@vger.kernel.org
Cc: Li Linchao <lilinchao@oschina.cn>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 2/3] connect: Add transport->remote->name to git_connect()
Date: Thu, 26 Mar 2026 19:37:37 -0400
Message-ID: <20260326233739.2911354-3-wesleys@opperschaap.net>
In-Reply-To: <20260326233739.2911354-1-wesleys@opperschaap.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support `remote.$name.sshIdentityFile', and `remote.$name.sshOpts' for
connecting to various remotes I need to pass around the remote down to
git_connect. This commit introduces the `remote_name' and sprinkles all
call sites to pass `NULL'. This is a non-breaking forward change

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 builtin/fetch-pack.c | 2 +-
 builtin/send-pack.c  | 2 +-
 connect.c            | 5 +++--
 connect.h            | 2 +-
 transport.c          | 7 ++++++-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d9e42bad58..f422acce06 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -217,21 +217,21 @@ int cmd_fetch_pack(int argc,
 
 	if (args.stateless_rpc) {
 		conn = NULL;
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
 		int flags = args.verbose ? CONNECT_VERBOSE : 0;
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
 		conn = git_connect(fd, dest, "git-upload-pack",
-				   args.uploadpack, flags);
+				   args.uploadpack, NULL, flags);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	version = discover_version(&reader);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8b81c8a848..65efa91208 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -266,21 +266,21 @@ int cmd_send_pack(int argc,
 
 	if (progress == -1)
 		progress = !args.quiet && isatty(2);
 	args.progress = progress;
 
 	if (args.stateless_rpc) {
 		conn = NULL;
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, "git-receive-pack", receivepack,
+		conn = git_connect(fd, dest, "git-receive-pack", receivepack, NULL,
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	switch (discover_version(&reader)) {
 	case protocol_v2:
diff --git a/connect.c b/connect.c
index 29af453b41..5749ddec9b 100644
--- a/connect.c
+++ b/connect.c
@@ -1420,22 +1420,22 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
  * does not need fork(2), or a struct child_process object if it does.  Once
  * done, finish the connection with finish_connect() with the value returned
  * from this function (it is safe to call finish_connect() with NULL to
  * support the former case).
  *
  * If it returns, the connect is successful; it just dies on errors (this
  * will hopefully be changed in a libification effort, to return NULL when
  * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url,
-				  const char *command,
-				  const char *prog, int flags)
+				  const char *command, const char *prog,
+				  const char *remote_name, int flags)
 {
 	char *hostandport, *path;
 	struct child_process *conn;
 	enum protocol protocol;
 	enum protocol_version version = get_protocol_version_config();
 
 	/*
 	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
 	 * to perform any operation that doesn't involve upload-pack (i.e., a
 	 * fetch, ls-remote, etc), then fallback to v0 since we don't know how
@@ -1487,20 +1487,21 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 			if (!port)
 				port = get_port(ssh_host);
 
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
 				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
 				printf("Diag: port=%s\n", port ? port : "NONE");
 				printf("Diag: path=%s\n", path ? path : "NULL");
+				printf("Diag: remote=%s\n", remote_name ? remote_name : "NULL");
 
 				free(hostandport);
 				free(path);
 				child_process_clear(conn);
 				free(conn);
 				strbuf_release(&cmd);
 				return NULL;
 			}
 			conn->trace2_child_class = "transport/ssh";
 			fill_ssh_args(conn, ssh_host, port, version, flags);
diff --git a/connect.h b/connect.h
index f993626473..ff54061e81 100644
--- a/connect.h
+++ b/connect.h
@@ -1,20 +1,20 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
 #include "protocol.h"
 
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
-struct child_process *git_connect(int fd[2], const char *url, const char *command, const char *prog, int flags);
+struct child_process *git_connect(int fd[2], const char *url, const char *command, const char *prog, const char *remote_name, int flags);
 int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
 int parse_feature_request(const char *features, const char *feature);
 const char *server_feature_value(const char *feature, size_t *len_ret);
 int url_is_local_not_ssh(const char *url);
 
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
diff --git a/transport.c b/transport.c
index 27a99190c0..b9dcbf8d9e 100644
--- a/transport.c
+++ b/transport.c
@@ -289,37 +289,39 @@ static int set_git_option(struct git_transport_options *opts,
 		opts->reject_shallow = !!value;
 		return 0;
 	}
 	return 1;
 }
 
 static int connect_setup(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
 	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
+	const char *remote_name = transport->remote->name;
 
 	if (data->conn)
 		return 0;
 
 	switch (transport->family) {
 	case TRANSPORT_FAMILY_ALL: break;
 	case TRANSPORT_FAMILY_IPV4: flags |= CONNECT_IPV4; break;
 	case TRANSPORT_FAMILY_IPV6: flags |= CONNECT_IPV6; break;
 	}
 
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ?
 					"git-receive-pack" :
 					"git-upload-pack",
 				 for_push ?
 					data->options.receivepack :
 					data->options.uploadpack,
+				 remote_name,
 				 flags);
 
 	return 0;
 }
 
 static void die_if_server_options(struct transport *transport)
 {
 	if (!transport->server_options || !transport->server_options->nr)
 		return;
 	advise(_("see protocol.version in 'git help config' for more details"));
@@ -953,22 +955,25 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	data->conn = NULL;
 	data->finished_handshake = 0;
 
 	return ret;
 }
 
 static int connect_git(struct transport *transport, const char *command,
 		       const char *executable, int fd[2])
 {
 	struct git_transport_data *data = transport->data;
+	const char *remote_name = transport->remote->name;
+
 	data->conn = git_connect(data->fd, transport->url,
-				 command, executable, 0);
+				 command, executable, remote_name,
+				 0);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
 }
 
 static int disconnect_git(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
 	if (data->conn) {
 		if (data->finished_handshake && !transport->stateless_rpc)
-- 
2.53.0.722.g8e572876c5

