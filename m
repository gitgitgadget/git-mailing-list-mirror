Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3315FC4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiLMKxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 05:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiLMKxB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 05:53:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02A10B74
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 02:52:59 -0800 (PST)
Received: (qmail 14336 invoked by uid 109); 13 Dec 2022 10:52:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 10:52:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4113 invoked by uid 111); 13 Dec 2022 10:53:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 05:53:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 05:52:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] server_supports_v2(): use a separate function for
 die_on_error
Message-ID: <Y5hZirNRGLQUZfOZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The server_supports_v2() helper lets a caller find out if the server
supports a feature, and will optionally die if it's not supported. This
makes the return value confusing, as it's only meaningful when the
function is not asked to die.

Coverity flagged a new call like:

  /* check that we support "foo" */
  server_supports_v2("foo", 1);

complaining that we usually checked the return value, but this time we
didn't. But this call is correct, and other ones that did:

  if (server_supports_v2("foo", 1))
          do_something_with_foo();

are "wrong", in the sense that we know the conditional will always be
true (but there's no bug; the code is simply misleading).

Let's split the "die" behavior into its own function which returns void,
and modify each caller to use the correct one.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this is just churn. It does help static analyzers like Coverity
understand better what's going on, though, and when I looked at the
warning it produced, I had to store for a while myself to understand
what was going on. So maybe it's worth doing.

Note that when merged to 'next', it will need these two calls modified
on top (the first one of which is what caused Coverity's useless
warning):

    diff --git a/connect.c b/connect.c
    index 9bb946a238..63e59641c0 100644
    --- a/connect.c
    +++ b/connect.c
    @@ -500,7 +500,7 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
     	int line_nr = 1;
     
     	/* Assert bundle-uri support */
    -	server_supports_v2("bundle-uri", 1);
    +	ensure_server_supports_v2("bundle-uri");
     
     	/* (Re-)send capabilities */
     	send_capabilities(fd_out, reader);
    diff --git a/transport.c b/transport.c
    index 957dca4923..d1a2035eab 100644
    --- a/transport.c
    +++ b/transport.c
    @@ -382,7 +382,7 @@ static int get_bundle_uri(struct transport *transport)
     	 * "Support" protocol v0 and v2 without bundle-uri support by
     	 * silently degrading to a NOOP.
     	 */
    -	if (!server_supports_v2("bundle-uri", 0))
    +	if (!server_supports_v2("bundle-uri"))
     		return 0;
     
     	packet_reader_init(&reader, data->fd[0], NULL, 0,


 connect.c    | 21 ++++++++++++---------
 connect.h    |  3 ++-
 fetch-pack.c | 12 ++++++------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/connect.c b/connect.c
index 5ea53deda2..eef752f14b 100644
--- a/connect.c
+++ b/connect.c
@@ -66,7 +66,7 @@ static NORETURN void die_initial_contact(int unexpected)
 }
 
 /* Checks if the server supports the capability 'c' */
-int server_supports_v2(const char *c, int die_on_error)
+int server_supports_v2(const char *c)
 {
 	int i;
 
@@ -76,11 +76,13 @@ int server_supports_v2(const char *c, int die_on_error)
 		    (!*out || *out == '='))
 			return 1;
 	}
+	return 0;
+}
 
-	if (die_on_error)
+void ensure_server_supports_v2(const char *c)
+{
+	if (!server_supports_v2(c))
 		die(_("server doesn't support '%s'"), c);
-
-	return 0;
 }
 
 int server_feature_v2(const char *c, const char **v)
@@ -477,7 +479,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 {
 	const char *hash_name;
 
-	if (server_supports_v2("agent", 0))
+	if (server_supports_v2("agent"))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
 	if (server_feature_v2("object-format", &hash_name)) {
@@ -504,17 +506,18 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 		&transport_options->unborn_head_target : NULL;
 	*list = NULL;
 
-	if (server_supports_v2("ls-refs", 1))
-		packet_write_fmt(fd_out, "command=ls-refs\n");
+	ensure_server_supports_v2("ls-refs");
+	packet_write_fmt(fd_out, "command=ls-refs\n");
 
 	/* Send capabilities */
 	send_capabilities(fd_out, reader);
 
-	if (server_options && server_options->nr &&
-	    server_supports_v2("server-option", 1))
+	if (server_options && server_options->nr) {
+		ensure_server_supports_v2("server-option");
 		for (i = 0; i < server_options->nr; i++)
 			packet_write_fmt(fd_out, "server-option=%s",
 					 server_options->items[i].string);
+	}
 
 	packet_delim(fd_out);
 	/* When pushing we don't want to request the peeled tags */
diff --git a/connect.h b/connect.h
index c53586e929..b26f7de784 100644
--- a/connect.h
+++ b/connect.h
@@ -20,7 +20,8 @@ enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_hash(const char *desired, int *feature_supported);
 const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset);
-int server_supports_v2(const char *c, int die_on_error);
+int server_supports_v2(const char *c);
+void ensure_server_supports_v2(const char *c);
 int server_feature_v2(const char *c, const char **v);
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error);
diff --git a/fetch-pack.c b/fetch-pack.c
index 998fc2fa1e..04016d1e32 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1317,15 +1317,15 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 {
 	const char *hash_name;
 
-	if (server_supports_v2("fetch", 1))
-		packet_buf_write(req_buf, "command=fetch");
-	if (server_supports_v2("agent", 0))
+	ensure_server_supports_v2("fetch");
+	packet_buf_write(req_buf, "command=fetch");
+	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
-	if (advertise_sid && server_supports_v2("session-id", 0))
+	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
-	if (server_options && server_options->nr &&
-	    server_supports_v2("server-option", 1)) {
+	if (server_options && server_options->nr) {
 		int i;
+		ensure_server_supports_v2("server-option");
 		for (i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
-- 
2.39.0.rc2.569.g45ab4188ae
