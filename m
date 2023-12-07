Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E3BD7F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:36 -0800 (PST)
Received: (qmail 9855 invoked by uid 109); 7 Dec 2023 07:11:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 873 invoked by uid 111); 7 Dec 2023 07:11:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:40 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:35 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 7/7] fsck: handle NULL value when parsing message config
Message-ID: <20231207071135.GG1276005@coredump.intra.peff.net>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207071030.GA1275835@coredump.intra.peff.net>

When parsing fsck.*, receive.fsck.*, or fetch.fsck.*, we don't check for
an implicit bool. So any of:

  [fsck]
  badTree
  [receive "fsck"]
  badTree
  [fetch "fsck"]
  badTree

will cause us to segfault. We can fix it with config_error_nonbool() in
the usual way, but we have to make a few more changes to get good error
messages. The problem is that all three spots do:

  if (skip_prefix(var, "fsck.", &var))

to match and parse the actual message id. But that means that "var" now
just says "badTree" instead of "receive.fsck.badTree", making the
resulting message confusing. We can fix that by storing the parsed
message id in its own separate variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 11 +++++++----
 fetch-pack.c           | 12 ++++++++----
 fsck.c                 |  8 ++++++--
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8c4f0cb90a..ccf9738bce 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -142,6 +142,7 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 static int receive_pack_config(const char *var, const char *value,
 			       const struct config_context *ctx, void *cb)
 {
+	const char *msg_id;
 	int status = parse_hide_refs_config(var, value, "receive", &hidden_refs);
 
 	if (status)
@@ -178,12 +179,14 @@ static int receive_pack_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (skip_prefix(var, "receive.fsck.", &var)) {
-		if (is_valid_msg_type(var, value))
+	if (skip_prefix(var, "receive.fsck.", &msg_id)) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (is_valid_msg_type(msg_id, value))
 			strbuf_addf(&fsck_msg_types, "%c%s=%s",
-				fsck_msg_types.len ? ',' : '=', var, value);
+				fsck_msg_types.len ? ',' : '=', msg_id, value);
 		else
-			warning("skipping unknown msg id '%s'", var);
+			warning("skipping unknown msg id '%s'", msg_id);
 		return 0;
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 26999e3b65..31a72d43de 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1862,6 +1862,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 static int fetch_pack_config_cb(const char *var, const char *value,
 				const struct config_context *ctx, void *cb)
 {
+	const char *msg_id;
+
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
 		const char *path;
 
@@ -1873,12 +1875,14 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 		return 0;
 	}
 
-	if (skip_prefix(var, "fetch.fsck.", &var)) {
-		if (is_valid_msg_type(var, value))
+	if (skip_prefix(var, "fetch.fsck.", &msg_id)) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (is_valid_msg_type(msg_id, value))
 			strbuf_addf(&fsck_msg_types, "%c%s=%s",
-				fsck_msg_types.len ? ',' : '=', var, value);
+				fsck_msg_types.len ? ',' : '=', msg_id, value);
 		else
-			warning("Skipping unknown msg id '%s'", var);
+			warning("Skipping unknown msg id '%s'", msg_id);
 		return 0;
 	}
 
diff --git a/fsck.c b/fsck.c
index 6a0bbc5087..b624083a13 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1403,6 +1403,8 @@ int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
 	struct fsck_options *options = cb;
+	const char *msg_id;
+
 	if (strcmp(var, "fsck.skiplist") == 0) {
 		const char *path;
 		struct strbuf sb = STRBUF_INIT;
@@ -1416,8 +1418,10 @@ int git_fsck_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (skip_prefix(var, "fsck.", &var)) {
-		fsck_set_msg_type(options, var, value);
+	if (skip_prefix(var, "fsck.", &msg_id)) {
+		if (!value)
+			return config_error_nonbool(var);
+		fsck_set_msg_type(options, msg_id, value);
 		return 0;
 	}
 
-- 
2.43.0.664.ga12c899002
