Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2739BD44
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:26:24 -0800 (PST)
Received: (qmail 10032 invoked by uid 109); 7 Dec 2023 07:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:26:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1095 invoked by uid 111); 7 Dec 2023 07:26:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:26:27 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:26:22 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 7/9] push: drop confusing configset/callback redundancy
Message-ID: <20231207072622.GG1277973@coredump.intra.peff.net>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207072338.GA1277727@coredump.intra.peff.net>

We parse push config by calling git_config() with our git_push_config()
callback. But inside that callback, when we see "push.gpgsign", we
ignore the value passed into the callback and instead make a new call to
git_config_get_value().

This is unnecessary at best, and slightly wrong at worst (if there are
multiple instances, get_value() only returns one; both methods end up
with last-one-wins, but we'd fail to report errors if earlier
incarnations were bogus).

The call was added by 68c757f219 (push: add a config option push.gpgSign
for default signed pushes, 2015-08-19). That commit doesn't give any
reason to deviate from the usual strategy here; it was probably just
somebody unfamiliar with our config API and its conventions.

It also added identical code to builtin/send-pack.c, which also handles
push.gpgsign.

And then the same issue spread to its neighbor in b33a15b081 (push: add
recurseSubmodules config option, 2015-11-17), presumably via
cargo-culting.

This patch fixes all three to just directly use the value provided to
the callback. While I was adjusting the code to do so, I noticed that
push.gpgsign is overly careful about a NULL value. After
git_parse_maybe_bool() has returned anything besides 1, we know that the
value cannot be NULL (if it were, it would be an implicit "true", and
many callers of maybe_bool rely on that). Here that lets us shorten "if
(v && !strcasecmp(v, ...))" to just "if (!strcasecmp(v, ...))".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/push.c      | 31 +++++++++++++------------------
 builtin/send-pack.c | 27 ++++++++++++---------------
 2 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2e708383c2..58a9273e90 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -526,26 +526,21 @@ static int git_push_config(const char *k, const char *v,
 			*flags |= TRANSPORT_PUSH_AUTO_UPSTREAM;
 		return 0;
 	} else if (!strcmp(k, "push.gpgsign")) {
-		const char *value;
-		if (!git_config_get_value("push.gpgsign", &value)) {
-			switch (git_parse_maybe_bool(value)) {
-			case 0:
-				set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_NEVER);
-				break;
-			case 1:
-				set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_ALWAYS);
-				break;
-			default:
-				if (value && !strcasecmp(value, "if-asked"))
-					set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_IF_ASKED);
-				else
-					return error(_("invalid value for '%s'"), k);
-			}
+		switch (git_parse_maybe_bool(v)) {
+		case 0:
+			set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_NEVER);
+			break;
+		case 1:
+			set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_ALWAYS);
+			break;
+		default:
+			if (!strcasecmp(v, "if-asked"))
+				set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_IF_ASKED);
+			else
+				return error(_("invalid value for '%s'"), k);
 		}
 	} else if (!strcmp(k, "push.recursesubmodules")) {
-		const char *value;
-		if (!git_config_get_value("push.recursesubmodules", &value))
-			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
+		recurse_submodules = parse_push_recurse_submodules_arg(k, v);
 	} else if (!strcmp(k, "submodule.recurse")) {
 		int val = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index cd6d9e4112..00e6c90477 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -135,21 +135,18 @@ static int send_pack_config(const char *k, const char *v,
 			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "push.gpgsign")) {
-		const char *value;
-		if (!git_config_get_value("push.gpgsign", &value)) {
-			switch (git_parse_maybe_bool(value)) {
-			case 0:
-				args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
-				break;
-			case 1:
-				args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
-				break;
-			default:
-				if (value && !strcasecmp(value, "if-asked"))
-					args.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
-				else
-					return error(_("invalid value for '%s'"), k);
-			}
+		switch (git_parse_maybe_bool(v)) {
+		case 0:
+			args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
+			break;
+		case 1:
+			args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;
+			break;
+		default:
+			if (!strcasecmp(v, "if-asked"))
+				args.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
+			else
+				return error(_("invalid value for '%s'"), k);
 		}
 	}
 	return git_default_config(k, v, ctx, cb);
-- 
2.43.0.664.ga12c899002

