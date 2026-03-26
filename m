Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A423218DD
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568282; cv=none; b=ACu3Bh8aIfwlLL/YbBB497GMTIBo/Yud5Tgt+xnBxQJ8oWbSaXgLBjOVlhvpTBnqLAEQaviKUjLkI/o9wSJabVPxrZZxHxS+3e6q0kIfPAtQuoPts3QjKv2qO4J+doE1hOWCOpTK4MeX98Sen2+55Pj9Q486M1Z+ZKa64A2fIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568282; c=relaxed/simple;
	bh=F/4GrhPt7JYEIIjMvpI9ZNGGhGA8KwTXSm473T1bCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvXxuK/xlsDE1+sikUXyZ3PCZn1X5zO0gStXA+gPNCUpL0XHgQwAJnPewlik3w9nby/RK3U6fBrYyZALjJlqF1CVSvD06vEGiX2cW4m6euF8XPhrT+yqlkhwVnXMMEKIoll/8rz7hx/OLFdyM3BErnWI9LnaQbNwtclE0JrCVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fhgDy1BxMz9tWS;
	Fri, 27 Mar 2026 00:37:54 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of wesleys@opperschaap.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=wesleys@opperschaap.net
From: Wesley Schwengle <wesleys@opperschaap.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] connect: Rename name to command in connect_git()
Date: Thu, 26 Mar 2026 19:37:36 -0400
Message-ID: <20260326233739.2911354-2-wesleys@opperschaap.net>
In-Reply-To: <20260326233739.2911354-1-wesleys@opperschaap.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4fhgDy1BxMz9tWS

connect_git has `char *name' in its signature and it caught me a little
offguard. I initially thought it was the remote name. But when you look
closer at the various call sites it is actually a command that is send
over the wire, eg . `git-receive-pack'. Change the naming makes it
easier to read the code and understand its intention.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 connect.c   | 4 ++--
 connect.h   | 2 +-
 transport.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index a02583a102..29af453b41 100644
--- a/connect.c
+++ b/connect.c
@@ -1420,35 +1420,35 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
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
-				  const char *name,
+				  const char *command,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
 	struct child_process *conn;
 	enum protocol protocol;
 	enum protocol_version version = get_protocol_version_config();
 
 	/*
 	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
 	 * to perform any operation that doesn't involve upload-pack (i.e., a
 	 * fetch, ls-remote, etc), then fallback to v0 since we don't know how
 	 * to do anything else (like push or remote archive) via v2.
 	 */
-	if (version == protocol_v2 && strcmp("git-upload-pack", name))
+	if (version == protocol_v2 && strcmp("git-upload-pack", command))
 		version = protocol_v0;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &hostandport, &path);
 	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
diff --git a/connect.h b/connect.h
index 1645126c17..f993626473 100644
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
-struct child_process *git_connect(int fd[2], const char *url, const char *name, const char *prog, int flags);
+struct child_process *git_connect(int fd[2], const char *url, const char *command, const char *prog, int flags);
 int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
 int parse_feature_request(const char *features, const char *feature);
 const char *server_feature_value(const char *feature, size_t *len_ret);
 int url_is_local_not_ssh(const char *url);
 
 struct packet_reader;
 enum protocol_version discover_version(struct packet_reader *reader);
 
diff --git a/transport.c b/transport.c
index cb1befba8c..27a99190c0 100644
--- a/transport.c
+++ b/transport.c
@@ -949,26 +949,26 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	close(data->fd[1]);
 	close(data->fd[0]);
 	ret |= finish_connect(data->conn);
 	data->conn = NULL;
 	data->finished_handshake = 0;
 
 	return ret;
 }
 
-static int connect_git(struct transport *transport, const char *name,
+static int connect_git(struct transport *transport, const char *command,
 		       const char *executable, int fd[2])
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 name, executable, 0);
+				 command, executable, 0);
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

