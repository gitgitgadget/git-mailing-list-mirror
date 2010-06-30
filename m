From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 3/4] extent setup_revisions() so it works with submodules
Date: Wed, 30 Jun 2010 21:23:50 +0200
Message-ID: <295caa3c60660e7b6463518cd704e9f1aaa0ac7c.1277923844.git.hvoigt@hvoigt.net>
References: <cover.1277923843.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 30 21:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU2tV-0007Ks-GP
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 21:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850Ab0F3TYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 15:24:05 -0400
Received: from darksea.de ([83.133.111.250]:55020 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752401Ab0F3TXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 15:23:55 -0400
Received: (qmail 18732 invoked from network); 30 Jun 2010 21:23:53 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 30 Jun 2010 21:23:53 +0200
X-Mailer: git-send-email 1.7.1.528.gb3958.dirty
In-Reply-To: <cover.1277923843.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1277923843.git.hvoigt@hvoigt.net>
References: <cover.1277923843.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149986>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

What I do not like about this patch is that I have to duplicate a whole
set of functions to extend them for submodules. Anyone an idea how to
solve this more elegantly?

 refs.c     |   31 +++++++++++++++++++++++++++++++
 refs.h     |    8 ++++++++
 revision.c |   32 ++++++++++++++++++--------------
 revision.h |    1 +
 4 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 5a461d2..c2c1850 100644
--- a/refs.c
+++ b/refs.c
@@ -712,31 +712,62 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return do_head_ref(NULL, fn, cb_data);
 }
 
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return do_head_ref(submodule, fn, cb_data);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
 }
 
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, "refs/", fn, 0, 0, cb_data);
+}
+
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+		each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
+}
+
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
+int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
+}
+
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in("refs/heads/", fn, cb_data);
 }
 
+int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
+}
+
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in("refs/remotes/", fn, cb_data);
 }
 
+int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
+}
+
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
diff --git a/refs.h b/refs.h
index 762ce50..5e7a9a5 100644
--- a/refs.h
+++ b/refs.h
@@ -28,6 +28,14 @@ extern int for_each_replace_ref(each_ref_fn, void *);
 extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
+extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+		each_ref_fn fn, void *cb_data);
+extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
diff --git a/revision.c b/revision.c
index b209d49..0a5d8f9 100644
--- a/revision.c
+++ b/revision.c
@@ -721,12 +721,12 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 	cb->all_flags = flags;
 }
 
-static void handle_refs(struct rev_info *revs, unsigned flags,
-		int (*for_each)(each_ref_fn, void *))
+static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
+		int (*for_each)(const char *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(handle_one_ref, &cb);
+	for_each(submodule, handle_one_ref, &cb);
 }
 
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
@@ -1308,14 +1308,14 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 	ctx->argc -= n;
 }
 
-static int for_each_bad_bisect_ref(each_ref_fn fn, void *cb_data)
+static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/bisect/bad", fn, cb_data);
+	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
 }
 
-static int for_each_good_bisect_ref(each_ref_fn fn, void *cb_data)
+static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in("refs/bisect/good", fn, cb_data);
+	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
 }
 
 static void append_prune_data(const char ***prune_data, const char **av)
@@ -1357,6 +1357,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 {
 	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
 	const char **prune_data = NULL;
+	const char *submodule = NULL;
+
+	if (opt)
+		submodule = opt->submodule;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1381,26 +1385,26 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			int opts;
 
 			if (!strcmp(arg, "--all")) {
-				handle_refs(revs, flags, for_each_ref);
-				handle_refs(revs, flags, head_ref);
+				handle_refs(submodule, revs, flags, for_each_ref_submodule);
+				handle_refs(submodule, revs, flags, head_ref_submodule);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				handle_refs(revs, flags, for_each_branch_ref);
+				handle_refs(submodule, revs, flags, for_each_branch_ref_submodule);
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				handle_refs(revs, flags, for_each_bad_bisect_ref);
-				handle_refs(revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
+				handle_refs(submodule, revs, flags, for_each_bad_bisect_ref);
+				handle_refs(submodule, revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
 				revs->bisect = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
-				handle_refs(revs, flags, for_each_tag_ref);
+				handle_refs(submodule, revs, flags, for_each_tag_ref_submodule);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				handle_refs(revs, flags, for_each_remote_ref);
+				handle_refs(submodule, revs, flags, for_each_remote_ref_submodule);
 				continue;
 			}
 			if (!prefixcmp(arg, "--glob=")) {
diff --git a/revision.h b/revision.h
index 568f1c9..0fe4322 100644
--- a/revision.h
+++ b/revision.h
@@ -145,6 +145,7 @@ extern volatile show_early_output_fn_t show_early_output;
 struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
+	const char *submodule;
 };
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
-- 
1.7.1.528.gb3958.dirty
