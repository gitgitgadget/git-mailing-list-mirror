Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B9B137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:25:24 -0800 (PST)
Received: (qmail 10020 invoked by uid 109); 7 Dec 2023 07:25:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:25:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1088 invoked by uid 111); 7 Dec 2023 07:25:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:25:28 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:25:23 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 5/9] diff: give more detailed messages for bogus diff.* config
Message-ID: <20231207072523.GE1277973@coredump.intra.peff.net>
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

The config callbacks for a few diff.* variables simply return -1 when we
encounter an error. The message you get mentions the offending location,
like:

  fatal: bad config variable 'diff.algorithm' in file '.git/config' at line 7

but is vague about "bad" (as it must be, since the message comes from
the generic config code). Most callbacks add their own messages here, so
let's do the same. E.g.:

  error: unknown value for config 'diff.algorithm': foo
  fatal: bad config variable 'diff.algorithm' in file '.git/config' at line 7

I've written the string in a way that should be reusable for
translators, and matches another similar message in transport.c (there
doesn't yet seem to be a popular generic message to reuse here, so
hopefully this will get the ball rolling).

Note that in the case of diff.algorithm, our parse_algorithm_value()
helper does detect a NULL value string. But it's still worth detecting
it ourselves here, since we can give a more specific error message (and
which is the usual one for unexpected implicit-bool values).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 5b213a4b44..a2def45644 100644
--- a/diff.c
+++ b/diff.c
@@ -445,9 +445,12 @@ int git_diff_ui_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "diff.algorithm")) {
+		if (!value)
+			return config_error_nonbool(var);
 		diff_algorithm = parse_algorithm_value(value);
 		if (diff_algorithm < 0)
-			return -1;
+			return error(_("unknown value for config '%s': %s"),
+				     var, value);
 		return 0;
 	}
 
@@ -486,7 +489,8 @@ int git_diff_basic_config(const char *var, const char *value,
 			return config_error_nonbool(var);
 		val = parse_ws_error_highlight(value);
 		if (val < 0)
-			return -1;
+			return error(_("unknown value for config '%s': %s"),
+				     var, value);
 		ws_error_highlight_default = val;
 		return 0;
 	}
-- 
2.43.0.664.ga12c899002

