Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C332475E3
	for <git@vger.kernel.org>; Tue, 19 May 2026 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168143; cv=none; b=DFO1yepnTGF8Pr22ETeWFY/ppc0xlZKttWx/LkNkmBxGCKk2Vb17MM18sccE8DOCr2eKCx2RznRWOwjx6sykAVFPbdN8D7ybjhGbKKKWvyRu6eQuPm6m7s1WCW8HgOJpy6jbbNiSj5H+B/EZcdbKMuyntFpryPIth/WOM2UIA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168143; c=relaxed/simple;
	bh=lTdCME73yKQVbLaVMQuzbaNU/hHRC33YA0JjDhgmgqk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AjMF4SV//5921iT/GHdaSL1epHKy5wKpaoV9/8GiqIG1B5EsSDBCAs4ErqMgdn9Q/FC4OckvcKIzDR6/l6HGt7xj0O/JaMn53J+2RhWE+uWjGByWjWDJInucuXjZTP7dxjSR302HSkOGDikZlJIZCziBjL1NXM/CqWvt48KOcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PYgzHdae; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PYgzHdae"
Received: (qmail 17351 invoked by uid 106); 19 May 2026 05:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=lTdCME73yKQVbLaVMQuzbaNU/hHRC33YA0JjDhgmgqk=; b=PYgzHdae1ziqByM/z1qVtzk/L+6qoPoj2pqVNUhxi2B1gQeI09/8og8msk1vdBnuGm0YmqtehVKkygxF0w7RDubcFb7gM74iCfs8sgBkuRDJqXKNIT/X86vUXqr8qWf2RwBFRqm4B003BFvaBEk+tAzBcnQKjf5icivaZUYYFc6kbRGI5q+PmW7vBpwnt1nILBRWuASWTkddBWvuSUxIiocxCRvZ+Phzgan/PdzI9BxFe2DPT0k6XdIY9v52xHqI62rA4D2DP3i3TelqkWKQns5z5ZNBzaXP8ksx5mdDYIl6CQSIwjAellDcFHAB8M98EVWIyIBq95wwTyfROA9BNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 05:22:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 43036 invoked by uid 111); 19 May 2026 05:22:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2026 01:22:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 May 2026 01:22:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] connect: use "service" enum for "name" argument
Message-ID: <20260519052219.GA1703179@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The git_connect() function takes a "name" argument which is a bit
confusing. It is _not_ the program to run on the remote repo, which is
specified by the "prog" argument. It should instead be one of a few
well-known strings specifying the type of operation (e.g.,
"git-upload-pack"). But to add to the confusion, unless otherwise
configured, those well-known strings will also be the same as the
programs we run, making it easy to mistake which variable is which.

This confusion comes from eaa0fd6584 (git_connect(): fix corner cases in
downgrading v2 to v0, 2023-03-17), though in its defense, the term
"name" and the use of a string are found in other connect code, going
all the way back to b236752a87 (Support remote archive from all smart
transports, 2009-12-09).

But let's see if we can clean things up a bit. The term "name" is overly
vague. We use "service" in other places, including in the smart-http
protocol, so let's use it here, too.

Using a string invites the notion that it can be anything, not one of a
defined set. Let's instead introduce an enum, which has the added bonus
that the compiler can catch typos for us, rather than quietly choosing
the wrong service from an unexpected strcmp() result.

We do still have to turn our enum into those well-known strings to pass
along in the remote-helper protocol (e.g., for a stateless-connect
directive). But now we do so explicitly and in a way that I think is
much more obvious to follow.

This is a pure cleanup; there should be no behavior change.

Signed-off-by: Jeff King <peff@peff.net>
---
This was a cleanup that come out of discussion on another patch a month
or two ago:

  https://lore.kernel.org/git/20260327213308.GA598533@coredump.intra.peff.net/

 builtin/archive.c    |  2 +-
 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  5 +++--
 connect.c            |  4 ++--
 connect.h            |  7 ++++++-
 transport-helper.c   | 43 ++++++++++++++++++++++++++++++-------------
 transport-internal.h |  5 ++++-
 transport.c          | 14 ++++++++------
 transport.h          |  4 +++-
 9 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 13ea7308c8..3c1288a123 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -31,7 +31,7 @@ static int run_remote_archiver(int argc, const char **argv,
 
 	_remote = remote_get(remote);
 	transport = transport_get(_remote, _remote->url.v[0]);
-	transport_connect(transport, "git-upload-archive", exec, fd);
+	transport_connect(transport, GIT_CONNECT_UPLOAD_ARCHIVE, exec, fd);
 
 	/*
 	 * Inject a fake --format field at the beginning of the
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d9e42bad58..316badd969 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -223,7 +223,7 @@ int cmd_fetch_pack(int argc,
 		int flags = args.verbose ? CONNECT_VERBOSE : 0;
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
-		conn = git_connect(fd, dest, "git-upload-pack",
+		conn = git_connect(fd, dest, GIT_CONNECT_UPLOAD_PACK,
 				   args.uploadpack, flags);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8b81c8a848..1412b49bc8 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -273,8 +273,9 @@ int cmd_send_pack(int argc,
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, "git-receive-pack", receivepack,
-			args.verbose ? CONNECT_VERBOSE : 0);
+		conn = git_connect(fd, dest, GIT_CONNECT_RECEIVE_PACK,
+				   receivepack,
+				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
diff --git a/connect.c b/connect.c
index a02583a102..9af277bed6 100644
--- a/connect.c
+++ b/connect.c
@@ -1427,7 +1427,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
  * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url,
-				  const char *name,
+				  enum git_connect_service service,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
@@ -1441,7 +1441,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 * fetch, ls-remote, etc), then fallback to v0 since we don't know how
 	 * to do anything else (like push or remote archive) via v2.
 	 */
-	if (version == protocol_v2 && strcmp("git-upload-pack", name))
+	if (version == protocol_v2 && service != GIT_CONNECT_UPLOAD_PACK)
 		version = protocol_v0;
 
 	/* Without this we cannot rely on waitpid() to tell
diff --git a/connect.h b/connect.h
index 1645126c17..c56ecddc0e 100644
--- a/connect.h
+++ b/connect.h
@@ -7,7 +7,12 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
-struct child_process *git_connect(int fd[2], const char *url, const char *name, const char *prog, int flags);
+enum git_connect_service {
+    GIT_CONNECT_UPLOAD_PACK,
+    GIT_CONNECT_RECEIVE_PACK,
+    GIT_CONNECT_UPLOAD_ARCHIVE,
+};
+struct child_process *git_connect(int fd[2], const char *url, enum git_connect_service, const char *prog, int flags);
 int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
diff --git a/transport-helper.c b/transport-helper.c
index 4614036c99..bf37c5280c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -620,8 +620,22 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	return ret;
 }
 
+static const char *connect_service_cmd(enum git_connect_service service)
+{
+	switch (service) {
+	case GIT_CONNECT_UPLOAD_PACK:
+		return "git-upload-pack";
+	case GIT_CONNECT_RECEIVE_PACK:
+		return "git-receive-pack";
+	case GIT_CONNECT_UPLOAD_ARCHIVE:
+		return "git-upload-archive";
+	}
+	BUG("unknown git_connect_type: %d", service);
+}
+
 static int process_connect_service(struct transport *transport,
-				   const char *name, const char *exec)
+				   enum git_connect_service service,
+				   const char *exec)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf cmdbuf = STRBUF_INIT;
@@ -631,7 +645,7 @@ static int process_connect_service(struct transport *transport,
 	 * Handle --upload-pack and friends. This is fire and forget...
 	 * just warn if it fails.
 	 */
-	if (strcmp(name, exec)) {
+	if (strcmp(connect_service_cmd(service), exec)) {
 		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
 			warning(_("setting remote service path not supported by protocol"));
@@ -640,13 +654,15 @@ static int process_connect_service(struct transport *transport,
 	}
 
 	if (data->connect) {
-		strbuf_addf(&cmdbuf, "connect %s\n", name);
+		strbuf_addf(&cmdbuf, "connect %s\n",
+			    connect_service_cmd(service));
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
 		   (get_protocol_version_config() == protocol_v2) &&
-		   (!strcmp("git-upload-pack", name) ||
-		    !strcmp("git-upload-archive", name))) {
-		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
+		   (service == GIT_CONNECT_UPLOAD_PACK ||
+		    service == GIT_CONNECT_UPLOAD_ARCHIVE)) {
+		strbuf_addf(&cmdbuf, "stateless-connect %s\n",
+			    connect_service_cmd(service));
 		ret = run_connect(transport, &cmdbuf);
 		if (ret)
 			transport->stateless_rpc = 1;
@@ -660,32 +676,33 @@ static int process_connect(struct transport *transport,
 				     int for_push)
 {
 	struct helper_data *data = transport->data;
-	const char *name;
+	enum git_connect_service service;
 	const char *exec;
 	int ret;
 
-	name = for_push ? "git-receive-pack" : "git-upload-pack";
+	service = for_push ? GIT_CONNECT_RECEIVE_PACK : GIT_CONNECT_UPLOAD_PACK;
 	if (for_push)
 		exec = data->transport_options.receivepack;
 	else
 		exec = data->transport_options.uploadpack;
 
-	ret = process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, service, exec);
 	if (ret)
 		do_take_over(transport);
 	return ret;
 }
 
-static int connect_helper(struct transport *transport, const char *name,
-		   const char *exec, int fd[2])
+static int connect_helper(struct transport *transport, enum git_connect_service service,
+			  const char *exec, int fd[2])
 {
 	struct helper_data *data = transport->data;
 
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 
-	if (!process_connect_service(transport, name, exec))
-		die(_("can't connect to subservice %s"), name);
+	if (!process_connect_service(transport, service, exec))
+		die(_("can't connect to subservice %s"),
+		    connect_service_cmd(service));
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
diff --git a/transport-internal.h b/transport-internal.h
index 90ea749e5c..051f3ab0dc 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -1,6 +1,8 @@
 #ifndef TRANSPORT_INTERNAL_H
 #define TRANSPORT_INTERNAL_H
 
+#include "connect.h"
+
 struct ref;
 struct transport;
 struct strvec;
@@ -58,7 +60,8 @@ struct transport_vtable {
 	 * process involved generating new commits.
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
-	int (*connect)(struct transport *connection, const char *name,
+	int (*connect)(struct transport *connection,
+		       enum git_connect_service service,
 		       const char *executable, int fd[2]);
 
 	/** get_refs_list(), fetch(), and push_refs() can keep
diff --git a/transport.c b/transport.c
index 9cde4a4e43..132c93e665 100644
--- a/transport.c
+++ b/transport.c
@@ -309,8 +309,8 @@ static int connect_setup(struct transport *transport, int for_push)
 
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ?
-					"git-receive-pack" :
-					"git-upload-pack",
+					GIT_CONNECT_RECEIVE_PACK :
+					GIT_CONNECT_UPLOAD_PACK,
 				 for_push ?
 					data->options.receivepack :
 					data->options.uploadpack,
@@ -957,12 +957,13 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	return ret;
 }
 
-static int connect_git(struct transport *transport, const char *name,
+static int connect_git(struct transport *transport,
+		       enum git_connect_service service,
 		       const char *executable, int fd[2])
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 name, executable, 0);
+				 service, executable, 0);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
@@ -1656,11 +1657,12 @@ void transport_unlock_pack(struct transport *transport, unsigned int flags)
 		string_list_clear(&transport->pack_lockfiles, 0);
 }
 
-int transport_connect(struct transport *transport, const char *name,
+int transport_connect(struct transport *transport,
+		      enum git_connect_service service,
 		      const char *exec, int fd[2])
 {
 	if (transport->vtable->connect)
-		return transport->vtable->connect(transport, name, exec, fd);
+		return transport->vtable->connect(transport, service, exec, fd);
 	else
 		die(_("operation not supported by protocol"));
 }
diff --git a/transport.h b/transport.h
index 892f19454a..78e9ea8ad1 100644
--- a/transport.h
+++ b/transport.h
@@ -5,6 +5,7 @@
 #include "remote.h"
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "connect.h"
 
 struct git_transport_options {
 	unsigned thin : 1;
@@ -324,7 +325,8 @@ char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
 			 struct child_process *child);
 
-int transport_connect(struct transport *transport, const char *name,
+int transport_connect(struct transport *transport,
+		      enum git_connect_service service,
 		      const char *exec, int fd[2]);
 
 /* Transport methods defined outside transport.c */
-- 
2.54.0.524.g198262df96
