Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B0137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:25:17 -0800 (PST)
Received: (qmail 10017 invoked by uid 109); 7 Dec 2023 07:25:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:25:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1084 invoked by uid 111); 7 Dec 2023 07:25:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:25:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:25:16 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 4/9] config: use config_error_nonbool() instead of custom
 messages
Message-ID: <20231207072516.GD1277973@coredump.intra.peff.net>
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

A few config callbacks use their own custom messages to report an
unexpected implicit bool like:

  [merge "foo"]
  driver

These should just use config_error_nonbool(), so the user sees
consistent messages.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c       | 2 +-
 merge-ll.c        | 2 +-
 xdiff-interface.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 5b0fe4f95a..9c4df7bbc8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1346,7 +1346,7 @@ static int git_imap_config(const char *var, const char *val,
 		server.port = git_config_int(var, val, ctx->kvi);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
-			return error("Missing value for 'imap.host'");
+			return config_error_nonbool(var);
 		} else {
 			if (starts_with(val, "imap:"))
 				val += 5;
diff --git a/merge-ll.c b/merge-ll.c
index 8fcf2d3710..1df58ebaac 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -301,7 +301,7 @@ static int read_merge_config(const char *var, const char *value,
 
 	if (!strcmp("driver", key)) {
 		if (!value)
-			return error("%s: lacks value", var);
+			return config_error_nonbool(var);
 		/*
 		 * merge.<name>.driver specifies the command line:
 		 *
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 05d6475a09..d788689d01 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -314,7 +314,7 @@ int git_xmerge_config(const char *var, const char *value,
 {
 	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
-			return error(_("'%s' is not a boolean"), var);
+			return config_error_nonbool(var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_DIFF3;
 		else if (!strcmp(value, "zdiff3"))
-- 
2.43.0.664.ga12c899002

