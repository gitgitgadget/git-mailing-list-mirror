Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044EB137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:26:12 -0800 (PST)
Received: (qmail 10026 invoked by uid 109); 7 Dec 2023 07:26:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:26:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1092 invoked by uid 111); 7 Dec 2023 07:26:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:26:16 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:26:11 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 6/9] config: use git_config_string() for
 core.checkRoundTripEncoding
Message-ID: <20231207072611.GF1277973@coredump.intra.peff.net>
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

Since this code path was recently converted to check for a NULL value,
it now behaves exactly like git_config_string(). We can shorten the code
a bit by using that helper.

Note that git_config_string() takes a const pointer, but our storage
variable is non-const. We're better off making this "const", though,
since the default value points to a string literal (and thus it would be
an error if anybody tried to write to it).

Signed-off-by: Jeff King <peff@peff.net>
---
An observant reader may notice that this means duplicate config like:

  [core]
  checkRoundTripEncoding = foo
  checkRoundTripEncoding = bar

will leak the string for "foo". That is true before this patch, too, and
is true of all callers of git_config_string(). I'm going to punt on that
for now, and look into it as a separate series.

 config.c      | 8 ++------
 convert.h     | 2 +-
 environment.c | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index d997c55e33..00a11b5d98 100644
--- a/config.c
+++ b/config.c
@@ -1551,12 +1551,8 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.checkroundtripencoding")) {
-		if (!value)
-			return config_error_nonbool(var);
-		check_roundtrip_encoding = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "core.checkroundtripencoding"))
+		return git_config_string(&check_roundtrip_encoding, var, value);
 
 	if (!strcmp(var, "core.notesref")) {
 		if (!value)
diff --git a/convert.h b/convert.h
index d925589444..ab8b4fa68d 100644
--- a/convert.h
+++ b/convert.h
@@ -92,7 +92,7 @@ void convert_attrs(struct index_state *istate,
 		   struct conv_attrs *ca, const char *path);
 
 extern enum eol core_eol;
-extern char *check_roundtrip_encoding;
+extern const char *check_roundtrip_encoding;
 const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path);
 const char *get_wt_convert_stats_ascii(const char *path);
diff --git a/environment.c b/environment.c
index 9e37bf58c0..90632a39bc 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
-char *check_roundtrip_encoding = "SHIFT-JIS";
+const char *check_roundtrip_encoding = "SHIFT-JIS";
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
-- 
2.43.0.664.ga12c899002

