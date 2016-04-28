From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] submodule--helper: move config-sanitizing to submodule.c
Date: Thu, 28 Apr 2016 09:38:20 -0400
Message-ID: <20160428133819.GD25319@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:38:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avm9D-00058S-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbcD1NiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:38:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:58309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752287AbcD1NiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:38:22 -0400
Received: (qmail 25633 invoked by uid 102); 28 Apr 2016 13:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:38:22 -0400
Received: (qmail 9624 invoked by uid 107); 28 Apr 2016 13:38:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:38:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:38:20 -0400
Content-Disposition: inline
In-Reply-To: <20160428133534.GA19056@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292879>

These functions should be used by any code which spawns a
submodule process, which may happen in submodule.c (e.g.,
for spawning fetch). Let's move them there and make them
public so that submodule--helper can continue to use them.

Sine they're now public, let's also provide a basic overview
of their intended use.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c | 48 --------------------------------------------
 submodule.c                 | 49 +++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                 | 16 +++++++++++++++
 3 files changed, 65 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3bd6883..de3ad5b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -119,54 +119,6 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-/*
- * Rules to sanitize configuration variables that are Ok to be passed into
- * submodule operations from the parent project using "-c". Should only
- * include keys which are both (a) safe and (b) necessary for proper
- * operation.
- */
-static int submodule_config_ok(const char *var)
-{
-	if (starts_with(var, "credential."))
-		return 1;
-	return 0;
-}
-
-static int sanitize_submodule_config(const char *var, const char *value, void *data)
-{
-	struct strbuf *out = data;
-
-	if (submodule_config_ok(var)) {
-		if (out->len)
-			strbuf_addch(out, ' ');
-
-		if (value)
-			sq_quotef(out, "%s=%s", var, value);
-		else
-			sq_quote_buf(out, var);
-	}
-
-	return 0;
-}
-
-static void prepare_submodule_repo_env(struct argv_array *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
-			struct strbuf sanitized_config = STRBUF_INIT;
-			git_config_from_parameters(sanitize_submodule_config,
-						   &sanitized_config);
-			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
-			strbuf_release(&sanitized_config);
-		} else {
-			argv_array_push(out, *var);
-		}
-	}
-
-}
-
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, const char *reference, int quiet)
 {
diff --git a/submodule.c b/submodule.c
index 90825e1..02eaf0e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -13,6 +13,7 @@
 #include "argv-array.h"
 #include "blob.h"
 #include "thread-utils.h"
+#include "quote.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int parallel_jobs = 1;
@@ -1129,3 +1130,51 @@ int parallel_submodules(void)
 {
 	return parallel_jobs;
 }
+
+/*
+ * Rules to sanitize configuration variables that are Ok to be passed into
+ * submodule operations from the parent project using "-c". Should only
+ * include keys which are both (a) safe and (b) necessary for proper
+ * operation.
+ */
+static int submodule_config_ok(const char *var)
+{
+	if (starts_with(var, "credential."))
+		return 1;
+	return 0;
+}
+
+int sanitize_submodule_config(const char *var, const char *value, void *data)
+{
+	struct strbuf *out = data;
+
+	if (submodule_config_ok(var)) {
+		if (out->len)
+			strbuf_addch(out, ' ');
+
+		if (value)
+			sq_quotef(out, "%s=%s", var, value);
+		else
+			sq_quote_buf(out, var);
+	}
+
+	return 0;
+}
+
+void prepare_submodule_repo_env(struct argv_array *out)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
+			struct strbuf sanitized_config = STRBUF_INIT;
+			git_config_from_parameters(sanitize_submodule_config,
+						   &sanitized_config);
+			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
+			strbuf_release(&sanitized_config);
+		} else {
+			argv_array_push(out, *var);
+		}
+	}
+
+}
diff --git a/submodule.h b/submodule.h
index 7ef3775..7577b3b 100644
--- a/submodule.h
+++ b/submodule.h
@@ -61,4 +61,20 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
+/*
+ * This function is intended as a callback for use with
+ * git_config_from_parameters(). It ignores any config options which
+ * are not suitable for passing along to a submodule, and accumulates the rest
+ * in "data", which must be a pointer to a strbuf. The end result can
+ * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
+ */
+int sanitize_submodule_config(const char *var, const char *value, void *data);
+
+/*
+ * Prepare the "env_array" parameter of a "struct child_process" for executing
+ * a submodule by clearing any repo-specific envirionment variables, but
+ * retaining any config approved by sanitize_submodule_config().
+ */
+void prepare_submodule_repo_env(struct argv_array *out);
+
 #endif
-- 
2.8.1.617.gbdccc2d
