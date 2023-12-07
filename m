Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9C137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:26:43 -0800 (PST)
Received: (qmail 10040 invoked by uid 109); 7 Dec 2023 07:26:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:26:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1103 invoked by uid 111); 7 Dec 2023 07:26:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:26:47 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:26:42 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 9/9] sequencer: simplify away extra git_config_string() call
Message-ID: <20231207072642.GI1277973@coredump.intra.peff.net>
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

In our config callback, we call git_config_string() to copy the incoming
value string into a local string. But we don't modify or store that
string; we just look at it and then free it. We can make the code
simpler by just looking at the value passed into the callback.

Note that we do need to check for NULL, which is the one bit of logic
git_config_string() did for us. And I could even see an argument that we
are abstracting any error-checking of the value behind the
git_config_string() layer. But in practice no other callbacks behave
this way; it is standard to check for NULL and then just look at the
string directly.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..74c3b1243e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -238,34 +238,29 @@ static int git_sequencer_config(const char *k, const char *v,
 				const struct config_context *ctx, void *cb)
 {
 	struct replay_opts *opts = cb;
-	int status;
 
 	if (!strcmp(k, "commit.cleanup")) {
-		const char *s;
+		if (!v)
+			return config_error_nonbool(k);
 
-		status = git_config_string(&s, k, v);
-		if (status)
-			return status;
-
-		if (!strcmp(s, "verbatim")) {
+		if (!strcmp(v, "verbatim")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
 			opts->explicit_cleanup = 1;
-		} else if (!strcmp(s, "whitespace")) {
+		} else if (!strcmp(v, "whitespace")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
 			opts->explicit_cleanup = 1;
-		} else if (!strcmp(s, "strip")) {
+		} else if (!strcmp(v, "strip")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
 			opts->explicit_cleanup = 1;
-		} else if (!strcmp(s, "scissors")) {
+		} else if (!strcmp(v, "scissors")) {
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SCISSORS;
 			opts->explicit_cleanup = 1;
 		} else {
 			warning(_("invalid commit message cleanup mode '%s'"),
-				  s);
+				  v);
 		}
 
-		free((char *)s);
-		return status;
+		return 0;
 	}
 
 	if (!strcmp(k, "commit.gpgsign")) {
-- 
2.43.0.664.ga12c899002
