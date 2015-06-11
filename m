From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Allow to control the namespace for replace refs
Date: Thu, 11 Jun 2015 10:47:15 +0900
Message-ID: <1433987235-17385-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 03:47:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2rab-0004lH-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 03:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbFKBrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 21:47:25 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:48888 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbFKBrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 21:47:23 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Z2raN-0004X4-6o; Thu, 11 Jun 2015 10:47:15 +0900
X-Mailer: git-send-email 2.4.3.1.gb3b6c0d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271372>

It can be useful to have grafts or replace refs for specific use-cases while
keeping the default "view" of the repository pristine (or with a different
set of grafts/replace refs).

It is possible to use a different graft file with GIT_GRAFT_FILE, but while
replace refs are more powerful, they don't have an equivalent override.

Add a GIT_REPLACE_NAMESPACE environment variable to control where git is
going to look for replace refs.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

I'm not sure if I need to care about avoiding strlen in log-tree.c, or if I
should handle the lack of a / at the end of GIT_REPLACE_NAMESPACE.

 builtin/replace.c | 6 +++---
 cache.h           | 2 ++
 environment.c     | 6 ++++++
 log-tree.c        | 5 +++--
 refs.c            | 3 ++-
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 54bf01a..bb5bc84 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -104,9 +104,9 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 			continue;
 		}
 		full_hex = sha1_to_hex(sha1);
-		snprintf(ref, sizeof(ref), "refs/replace/%s", full_hex);
+		snprintf(ref, sizeof(ref), "%s%s", git_replace_namespace, full_hex);
 		/* read_ref() may reuse the buffer */
-		full_hex = ref + strlen("refs/replace/");
+		full_hex = ref + strlen(git_replace_namespace);
 		if (read_ref(ref, sha1)) {
 			error("replace ref '%s' not found.", full_hex);
 			had_error = 1;
@@ -134,7 +134,7 @@ static void check_ref_valid(unsigned char object[20],
 			    int force)
 {
 	if (snprintf(ref, ref_size,
-		     "refs/replace/%s",
+		     "%s%s", git_replace_namespace,
 		     sha1_to_hex(object)) > ref_size - 1)
 		die("replace ref name too long: %.*s...", 50, ref);
 	if (check_refname_format(ref, 0))
diff --git a/cache.h b/cache.h
index badf3da..9553edc 100644
--- a/cache.h
+++ b/cache.h
@@ -384,6 +384,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
+#define GIT_REPLACE_NAMESPACE_ENVIRONMENT "GIT_REPLACE_NAMESPACE"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -605,6 +606,7 @@ extern unsigned long pack_size_limit_cfg;
  * been sought but there were none.
  */
 extern int check_replace_refs;
+extern char *git_replace_namespace;
 
 extern int fsync_object_files;
 extern int core_preload_index;
diff --git a/environment.c b/environment.c
index a40044c..c836b61 100644
--- a/environment.c
+++ b/environment.c
@@ -47,6 +47,7 @@ const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
+char *git_replace_namespace;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -109,6 +110,7 @@ const char * const local_repo_env[] = {
 	GRAFT_ENVIRONMENT,
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
+	GIT_REPLACE_NAMESPACE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	NULL
@@ -145,6 +147,7 @@ static void setup_git_env(void)
 {
 	const char *gitfile;
 	const char *shallow_file;
+	const char *replace_namespace;
 
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
@@ -156,6 +159,9 @@ static void setup_git_env(void)
 	git_graft_file = git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
+	replace_namespace = getenv(GIT_REPLACE_NAMESPACE_ENVIRONMENT);
+	git_replace_namespace = xstrdup(replace_namespace ? replace_namespace
+							  : "refs/replace/");
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/log-tree.c b/log-tree.c
index c931615..9e60137 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -96,11 +96,12 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 
 	assert(cb_data == NULL);
 
-	if (starts_with(refname, "refs/replace/")) {
+	if (starts_with(refname, git_replace_namespace)) {
 		unsigned char original_sha1[20];
 		if (!check_replace_refs)
 			return 0;
-		if (get_sha1_hex(refname + 13, original_sha1)) {
+		if (get_sha1_hex(refname + strlen(git_replace_namespace),
+				 original_sha1)) {
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
diff --git a/refs.c b/refs.c
index 67d6745..0993d1c 100644
--- a/refs.c
+++ b/refs.c
@@ -2089,7 +2089,8 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(&ref_cache, git_replace_namespace, fn,
+			       strlen(git_replace_namespace), 0, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-- 
2.4.3.1.gb3b6c0d.dirty
