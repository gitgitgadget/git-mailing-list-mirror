Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9ED5E
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:24:51 -0800 (PST)
Received: (qmail 10009 invoked by uid 109); 7 Dec 2023 07:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:24:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1045 invoked by uid 111); 7 Dec 2023 07:24:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:24:54 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:24:49 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/9] git_xmerge_config(): prefer error() to die()
Message-ID: <20231207072449.GB1277973@coredump.intra.peff.net>
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

When parsing merge config, a few code paths die on error. It's
preferable for us to call error() here, because the resulting error
message from the config parsing code contains much more detail.

For example, before:

  fatal: unknown style 'bogus' given for 'merge.conflictstyle'

and after:

  error: unknown style 'bogus' given for 'merge.conflictstyle'
  fatal: bad config variable 'merge.conflictstyle' in file '.git/config' at line 7

Since we're touching these lines, I also marked them for translation.
There's no reason they shouldn't behave like most other config-parsing
errors.

Signed-off-by: Jeff King <peff@peff.net>
---
Before anyone mentions config_error_nonbool(), yes, the first hunk here
gets simplified to that in a later patch.

 xdiff-interface.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index adcea109fa..05d6475a09 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "config.h"
 #include "hex.h"
 #include "object-store-ll.h"
@@ -313,7 +314,7 @@ int git_xmerge_config(const char *var, const char *value,
 {
 	if (!strcmp(var, "merge.conflictstyle")) {
 		if (!value)
-			die("'%s' is not a boolean", var);
+			return error(_("'%s' is not a boolean"), var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_DIFF3;
 		else if (!strcmp(value, "zdiff3"))
@@ -325,8 +326,8 @@ int git_xmerge_config(const char *var, const char *value,
 		 * git-completion.bash when you add new merge config
 		 */
 		else
-			die("unknown style '%s' given for '%s'",
-			    value, var);
+			return error(_("unknown style '%s' given for '%s'"),
+				     value, var);
 		return 0;
 	}
 	return git_default_config(var, value, ctx, cb);
-- 
2.43.0.664.ga12c899002

