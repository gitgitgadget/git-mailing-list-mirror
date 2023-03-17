Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB425C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCQTI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCQTI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:08:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83457CA1E6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:08:53 -0700 (PDT)
Received: (qmail 25962 invoked by uid 109); 17 Mar 2023 19:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 19:08:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27411 invoked by uid 111); 17 Mar 2023 19:08:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 15:08:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 15:08:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] git_connect(): fix corner cases in downgrading v2 to v0
Message-ID: <ZBS6wwWXcEBwGBm/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's code in git_connect() that checks whether we are doing a push
with protocol_v2, and if so, drops us to protocol_v0 (since we only know
how to do v0 for fetches). But it misses some corner cases:

  1. it checks the "prog" variable, which is actually the path to
     receive-pack on the remote side. By default this is just
     "git-receive-pack", but it could be an arbitrary string (like
     "/path/to/git receive-pack", etc). We'd accidentally stay in v2
     mode in this case.

  2. besides "receive-pack" and "upload-pack", there's one other value
     we'd expect: "upload-archive" for handling "git archive --remote".
     Like receive-pack, this doesn't understand v2, and should use the
     v0 protocol.

In practice, neither of these causes bugs in the real world so far. We
do send a "we understand v2" probe to the server, but since no server
implements v2 for anything but upload-pack, it's simply ignored. But
this would eventually become a problem if we do implement v2 for those
endpoints, as older clients would falsely claim to understand it,
leading to a server response they can't parse.

We can fix (1) by passing in both the program path and the "name" of the
operation. I treat the name as a string here, because that's the pattern
set in transport_connect(), which is one of our callers (we were simply
throwing away the "name" value there before).

We can fix (2) by allowing only known-v2 protocols ("upload-pack"),
rather than blocking unknown ones ("receive-pack" and "upload-archive").
That will mean whoever eventually implements v2 push will have to adjust
this list, but that's reasonable. We'll do the safe, conservative thing
(sticking to v0) by default, and anybody working on v2 will quickly
realize this spot needs to be updated.

The new tests cover the receive-pack and upload-archive cases above, and
re-confirm that we allow v2 with an arbitrary "--upload-pack" path (that
already worked before this patch, of course, but it would be an easy
thing to break if we flipped the allow/block logic without also handling
"name" separately).

Here are a few miscellaneous implementation notes, since I had to do a
little head-scratching to understand who calls what:

  - transport_connect() is called only for git-upload-archive. For
    non-http git remotes, that resolves to the virtual connect_git()
    function (which then calls git_connect(); confused yet?). So
    plumbing through "name" in connect_git() covers that.

  - for regular fetches and pushes, callers use higher-level functions
    like transport_fetch_refs(). For non-http git remotes, that means
    calling git_connect() under the hood via connect_setup(). And that
    uses the "for_push" flag to decide which name to use.

  - likewise, plumbing like fetch-pack and send-pack may call
    git_connect() directly; they each know which name to use.

  - for remote helpers (including http), we already have separate
    parameters for "name" and "exec" (another name for "prog"). In
    process_connect_service(), we feed the "name" to the helper via
    "connect" or "stateless-connect" directives.

    There's also a "servpath" option, which can be used to tell the
    helper about the "exec" path. But no helpers we implement support
    it! For http it would be useless anyway (no reasonable server
    implementation will allow you to send a shell command to run the
    server). In theory it would be useful for more obscure helpers like
    remote-ext, but even there it is not implemented.

    It's tempting to get rid of it simply to reduce confusion, but we
    have publicly documented it since it was added in fa8c097cc9
    (Support remote helpers implementing smart transports, 2009-12-09),
    so it's possible some helper in the wild is using it.

  - So for v2, helpers (again, including http) are mainly used via
    stateless-connect, driven by the main program. But they do still
    need to decide whether to do a v2 probe. And so there's similar
    logic in remote-curl.c's discover_refs() that looks for
    "git-receive-pack". But it's not buggy in the same way. Since it
    doesn't support servpath, it is always dealing with a "service"
    string like "git-receive-pack". And since it doesn't support
    straight "connect", it can't be used for "upload-archive".

    So we could leave that spot alone. But I've updated it here to match
    the logic we're changing in connect_git(). That seems like the least
    confusing thing for somebody who has to touch both of these spots
    later (say, to add v2 push support). I didn't add a new test to make
    sure this doesn't break anything; we already have several tests (in
    t5551 and elsewhere) that make sure we are using v2 over http.

Signed-off-by: Jeff King <peff@peff.net>
---
To some degree, this is closing the barn door after the horse is out. If
we were to add v2 push support in the next year or so, I'd probably
suggest using "v3" as the probe to differentiate requests from older,
buggy clients. But IMHO this is still worth fixing, if only because from
a cleanliness perspective. And if we wait long enough to do v2 push,
then maybe it would be safe to discount older, buggy clients. ;)

Also, just a side note: I found this bug because of the unused "name"
parameter in connect_git(). I was tempted to mark it UNUSED and move on,
but digging revealed this rather curious situation.

 builtin/fetch-pack.c   |  4 ++--
 builtin/send-pack.c    |  2 +-
 connect.c              |  8 +++++---
 connect.h              |  2 +-
 remote-curl.c          |  7 ++++---
 t/t5702-protocol-v2.sh | 27 +++++++++++++++++++++++++++
 transport.c            | 10 +++++++---
 7 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index afe679368de..a71dbc9988d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -211,8 +211,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		int flags = args.verbose ? CONNECT_VERBOSE : 0;
 		if (args.diag_url)
 			flags |= CONNECT_DIAG_URL;
-		conn = git_connect(fd, dest, args.uploadpack,
-				   flags);
+		conn = git_connect(fd, dest, "git-upload-pack",
+				   args.uploadpack, flags);
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4c5d125fa0a..2452e3cceb6 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -275,7 +275,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		fd[0] = 0;
 		fd[1] = 1;
 	} else {
-		conn = git_connect(fd, dest, receivepack,
+		conn = git_connect(fd, dest, "git-receive-pack", receivepack,
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
diff --git a/connect.c b/connect.c
index 63e59641c0d..fc977256572 100644
--- a/connect.c
+++ b/connect.c
@@ -1406,6 +1406,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
  * the connection failed).
  */
 struct child_process *git_connect(int fd[2], const char *url,
+				  const char *name,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
@@ -1415,10 +1416,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 	/*
 	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
-	 * to perform a push, then fallback to v0 since the client doesn't know
-	 * how to push yet using v2.
+	 * to perform any operation that doesn't involve upload-pack (i.e., a
+	 * fetch, ls-remote, etc), then fallback to v0 since we don't know how
+	 * to do anything else (like push or remote archive) via v2.
 	 */
-	if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
+	if (version == protocol_v2 && strcmp("git-upload-pack", name))
 		version = protocol_v0;
 
 	/* Without this we cannot rely on waitpid() to tell
diff --git a/connect.h b/connect.h
index b26f7de7841..f41a0b4c1fb 100644
--- a/connect.h
+++ b/connect.h
@@ -7,7 +7,7 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
-struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+struct child_process *git_connect(int fd[2], const char *url, const char *name, const char *prog, int flags);
 int finish_connect(struct child_process *conn);
 int git_connection_is_socket(struct child_process *conn);
 int server_supports(const char *feature);
diff --git a/remote-curl.c b/remote-curl.c
index a76b6405eb2..812e940f10a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -472,10 +472,11 @@ static struct discovery *discover_refs(const char *service, int for_push)
 
 	/*
 	 * NEEDSWORK: If we are trying to use protocol v2 and we are planning
-	 * to perform a push, then fallback to v0 since the client doesn't know
-	 * how to push yet using v2.
+	 * to perform any operation that doesn't involve upload-pack (i.e., a
+	 * fetch, ls-remote, etc), then fallback to v0 since we don't know how
+	 * to do anything else (like push or remote archive) via v2.
 	 */
-	if (version == protocol_v2 && !strcmp("git-receive-pack", service))
+	if (version == protocol_v2 && strcmp("git-upload-pack", service))
 		version = protocol_v0;
 
 	/* Add the extra Git-Protocol header */
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e4db7513f42..71aabe30b7d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -728,6 +728,33 @@ test_expect_success 'file:// --negotiate-only with protocol v0' '
 	test_i18ngrep "negotiate-only requires protocol v2" err
 '
 
+test_expect_success 'push with custom path does not request v2' '
+	rm -f env.trace &&
+	git -C client push \
+		--receive-pack="env >../env.trace; git-receive-pack" \
+		origin HEAD:refs/heads/custom-push-test &&
+	test_path_is_file env.trace &&
+	! grep ^GIT_PROTOCOL env.trace
+'
+
+test_expect_success 'fetch with custom path does request v2' '
+	rm -f env.trace &&
+	git -C client fetch \
+		--upload-pack="env >../env.trace; git-upload-pack" \
+		origin HEAD &&
+	grep ^GIT_PROTOCOL=version=2 env.trace
+'
+
+test_expect_success 'archive with custom path does not request v2' '
+	rm -f env.trace &&
+	git -C client archive \
+		--exec="env >../env.trace; git-upload-archive" \
+		--remote=origin \
+		HEAD >/dev/null &&
+	test_path_is_file env.trace &&
+	! grep ^GIT_PROTOCOL env.trace
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/transport.c b/transport.c
index 77a61a9d7bb..81950bf755f 100644
--- a/transport.c
+++ b/transport.c
@@ -276,8 +276,12 @@ static int connect_setup(struct transport *transport, int for_push)
 	}
 
 	data->conn = git_connect(data->fd, transport->url,
-				 for_push ? data->options.receivepack :
-				 data->options.uploadpack,
+				 for_push ?
+					"git-receive-pack" :
+					"git-upload-pack",
+				 for_push ?
+					data->options.receivepack :
+					data->options.uploadpack,
 				 flags);
 
 	return 0;
@@ -911,7 +915,7 @@ static int connect_git(struct transport *transport, const char *name,
 {
 	struct git_transport_data *data = transport->data;
 	data->conn = git_connect(data->fd, transport->url,
-				 executable, 0);
+				 name, executable, 0);
 	fd[0] = data->fd[0];
 	fd[1] = data->fd[1];
 	return 0;
-- 
2.40.0.581.g8d688c70eca
