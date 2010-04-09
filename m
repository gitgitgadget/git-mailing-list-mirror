From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP PATCH 1/4] Prepare checkout_entry() for recursive checkout of
 submodules
Date: Fri, 09 Apr 2010 23:36:09 +0200
Message-ID: <4BBF9DC9.8030905@web.de>
References: <4BBF9D6F.2000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LsO-0007XW-6e
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661Ab0DIVg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 17:36:27 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34988 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511Ab0DIVg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 17:36:26 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id CC7D115647088;
	Fri,  9 Apr 2010 23:36:09 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0Ls1-0004qY-00; Fri, 09 Apr 2010 23:36:09 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BBF9D6F.2000006@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+zRP6Q6LO5L2HUdQRo4lyl/MLEiivPWlFwvGi+
	+HZAM4aHXKRgKn+biWyMTjhyRLkM/i+SzFyaW6qdSMivpDxl+C
	8lFYNA7+G5/VL7z4WqNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144475>

To achieve this, the new member "ignore_submodules" has been added to the
bitfield in "struct checkout". All users of "struct checkout" are setting
this flag to 1 for backward compatibility for now. Also the new function
checkout_submodule() has been added and is called by checkout_entry() when
"ignore_submodules" is false (which will be the default behavior later).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/apply.c          |    1 +
 builtin/checkout-index.c |    1 +
 builtin/checkout.c       |    1 +
 cache.h                  |    3 ++-
 entry.c                  |    9 ++++++---
 submodule.c              |   32 ++++++++++++++++++++++++++++++++
 submodule.h              |    1 +
 unpack-trees.c           |    1 +
 8 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ec755ac..a7788a9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2827,6 +2827,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 			costate.quiet = 0;
 			costate.not_new = 0;
 			costate.refresh_cache = 1;
+			costate.ignore_submodules = 1;
 			if (checkout_entry(*ce, &costate, NULL) ||
 			    lstat(old_name, st))
 				return -1;
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a7a5ee1..c35bad3 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -254,6 +254,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
+	state.ignore_submodules = 1;

 	if (state.base_dir_len || to_tempfile) {
 		/* when --prefix is specified we do not
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c382521..ee198ae 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -248,6 +248,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	memset(&state, 0, sizeof(state));
 	state.force = 1;
 	state.refresh_cache = 1;
+	state.ignore_submodules = 1;
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
diff --git a/cache.h b/cache.h
index 303c107..996fa69 100644
--- a/cache.h
+++ b/cache.h
@@ -802,7 +802,8 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
-		 refresh_cache:1;
+		 refresh_cache:1,
+		 ignore_submodules:1;
 };

 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
diff --git a/entry.c b/entry.c
index 004182c..15dec09 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "dir.h"
+#include "submodule.h"

 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -222,9 +223,11 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 * just do the right thing)
 		 */
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
-			if (S_ISGITLINK(ce->ce_mode))
-				return 0;
+			if (S_ISGITLINK(ce->ce_mode)) {
+				if (state->ignore_submodules)
+					return 0;
+				return checkout_submodule(ce->name, ce->sha1, state->force);
+	       		}
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
diff --git a/submodule.c b/submodule.c
index b3b8bc1..59029b2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -206,3 +206,35 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	strbuf_release(&buf);
 	return dirty_submodule;
 }
+
+int checkout_submodule(const char *path, const unsigned char sha1[20], int force)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process cp;
+	const char *hex_sha1 = sha1_to_hex(sha1);
+	const char *argv[] = {
+		"checkout",
+                force ? "-qf" : "-q",
+		hex_sha1,
+		NULL,
+	};
+	
+	strbuf_addf(&buf, "%s/.git/", path);
+	if (!is_directory(buf.buf)) {
+		strbuf_release(&buf);
+		/* The submodule is not populated, so we can't check it out */
+		return 0;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.out = -1;
+	cp.dir = path;   /* GIT_WORK_TREE doesn't work for git checkout */
+	if (run_command(&cp))
+		return error("Could not checkout submodule %s", path);
+
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index dbda270..fc6909e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -6,5 +6,6 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
+int checkout_submodule(const char *path, const unsigned char sha1[20], int force);

 #endif
diff --git a/unpack-trees.c b/unpack-trees.c
index c29a9e0..151b422 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -711,6 +711,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
+	state.ignore_submodules = 1;

 	memset(&el, 0, sizeof(el));
 	if (!core_apply_sparse_checkout || !o->update)
-- 
1.7.1.rc0.248.g09203
