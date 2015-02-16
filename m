From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Mon, 16 Feb 2015 00:47:54 -0500
Message-ID: <20150216054754.GB25088@peff.net>
References: <20150216054550.GA24611@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEXI-0008Hz-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbBPFr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:47:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:49372 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbbBPFr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:47:56 -0500
Received: (qmail 8102 invoked by uid 102); 16 Feb 2015 05:47:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Feb 2015 23:47:56 -0600
Received: (qmail 12252 invoked by uid 107); 16 Feb 2015 05:48:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:48:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 00:47:54 -0500
Content-Disposition: inline
In-Reply-To: <20150216054550.GA24611@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263872>

When the "push_default" flag was originally added, it was
made globally visible to all code. This might have been
useful if other commands or library calls ended up depending
on it, but as it turns out, only builtin/push.c cares.

Let's make it a static variable in builtin/push.c. Since it
is no longer globally visible, it only needs to be set
inside that function. That means we can drop the
git_push_default_config function (which is called from
git_default_config for all commands) and just set it as part
of git_push_config.

That in turn makes it easier for people adding new config to
git-push to know which callback function to add to (since
there is only one now).

Signed-off-by: Jeff King <peff@peff.net>
---
We know this is safe because no other callers needed tweaked when the
variable went out of scope. :) It would only be a bad idea if we
were planning on having other code in the future depend on push_default
(e.g., the code in remote.c to find the push destination). But it does
not seem to have needed that in the intervening years, so it's probably
fine to do this cleanup now.

 builtin/push.c | 33 +++++++++++++++++++++++++++++++++
 cache.h        | 10 ----------
 config.c       | 32 --------------------------------
 environment.c  |  1 -
 4 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index aa9334c..ab99f4c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -23,6 +23,15 @@ static int progress = -1;
 
 static struct push_cas_option cas;
 
+static enum push_default_type {
+	PUSH_DEFAULT_NOTHING = 0,
+	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_SIMPLE,
+	PUSH_DEFAULT_UPSTREAM,
+	PUSH_DEFAULT_CURRENT,
+	PUSH_DEFAULT_UNSPECIFIED
+} push_default = PUSH_DEFAULT_UNSPECIFIED;
+
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
@@ -478,6 +487,30 @@ static int git_push_config(const char *k, const char *v, void *cb)
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
+
+	if (!strcmp(k, "push.default")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!strcmp(v, "nothing"))
+			push_default = PUSH_DEFAULT_NOTHING;
+		else if (!strcmp(v, "matching"))
+			push_default = PUSH_DEFAULT_MATCHING;
+		else if (!strcmp(v, "simple"))
+			push_default = PUSH_DEFAULT_SIMPLE;
+		else if (!strcmp(v, "upstream"))
+			push_default = PUSH_DEFAULT_UPSTREAM;
+		else if (!strcmp(v, "tracking")) /* deprecated */
+			push_default = PUSH_DEFAULT_UPSTREAM;
+		else if (!strcmp(v, "current"))
+			push_default = PUSH_DEFAULT_CURRENT;
+		else {
+			error("Malformed value for %s: %s", k, v);
+			return error("Must be one of nothing, matching, simple, "
+				     "upstream or current.");
+		}
+		return 0;
+	}
+
 	return git_default_config(k, v, NULL);
 }
 
diff --git a/cache.h b/cache.h
index f704af5..5394546 100644
--- a/cache.h
+++ b/cache.h
@@ -636,18 +636,8 @@ enum rebase_setup_type {
 	AUTOREBASE_ALWAYS
 };
 
-enum push_default_type {
-	PUSH_DEFAULT_NOTHING = 0,
-	PUSH_DEFAULT_MATCHING,
-	PUSH_DEFAULT_SIMPLE,
-	PUSH_DEFAULT_UPSTREAM,
-	PUSH_DEFAULT_CURRENT,
-	PUSH_DEFAULT_UNSPECIFIED
-};
-
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
-extern enum push_default_type push_default;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index e5e64dc..5782442 100644
--- a/config.c
+++ b/config.c
@@ -952,35 +952,6 @@ static int git_default_branch_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_push_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "push.default")) {
-		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcmp(value, "nothing"))
-			push_default = PUSH_DEFAULT_NOTHING;
-		else if (!strcmp(value, "matching"))
-			push_default = PUSH_DEFAULT_MATCHING;
-		else if (!strcmp(value, "simple"))
-			push_default = PUSH_DEFAULT_SIMPLE;
-		else if (!strcmp(value, "upstream"))
-			push_default = PUSH_DEFAULT_UPSTREAM;
-		else if (!strcmp(value, "tracking")) /* deprecated */
-			push_default = PUSH_DEFAULT_UPSTREAM;
-		else if (!strcmp(value, "current"))
-			push_default = PUSH_DEFAULT_CURRENT;
-		else {
-			error("Malformed value for %s: %s", var, value);
-			return error("Must be one of nothing, matching, simple, "
-				     "upstream or current.");
-		}
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
-}
-
 static int git_default_mailmap_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "mailmap.file"))
@@ -1006,9 +977,6 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (starts_with(var, "branch."))
 		return git_default_branch_config(var, value);
 
-	if (starts_with(var, "push."))
-		return git_default_push_config(var, value);
-
 	if (starts_with(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
diff --git a/environment.c b/environment.c
index 1ade5c9..bea09b6 100644
--- a/environment.c
+++ b/environment.c
@@ -51,7 +51,6 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
2.3.0.rc1.287.g761fd19
