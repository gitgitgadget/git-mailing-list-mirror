From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv5 2/4] Add infrastructure for ref namespaces
Date: Fri,  3 Jun 2011 14:29:51 -0700
Message-ID: <1307136593-16306-3-git-send-email-jamey@minilop.net>
References: <1307136593-16306-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSbxb-0007U0-NH
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 23:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab1FCVbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 17:31:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39537 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320Ab1FCVa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 17:30:56 -0400
Received: by pzk9 with SMTP id 9so965768pzk.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:30:56 -0700 (PDT)
Received: by 10.68.63.69 with SMTP id e5mr924094pbs.307.1307136655989;
        Fri, 03 Jun 2011 14:30:55 -0700 (PDT)
Received: from oh.minilop.net (host-246-52.pubnet.pdx.edu [131.252.246.52])
        by mx.google.com with ESMTPS id b8sm1731397pbj.46.2011.06.03.14.30.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 14:30:54 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QSbxE-0004Id-Oi; Fri, 03 Jun 2011 14:30:52 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307136593-16306-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175028>

From: Josh Triplett <josh@joshtriplett.org>

Add support for dividing the refs of a single repository into multiple
namespaces, each of which can have its own branches, tags, and HEAD.
Git can expose each namespace as an independent repository to pull from
and push to, while sharing the object store, and exposing all the refs
to operations such as git-gc.

Storing multiple repositories as namespaces of a single repository
avoids storing duplicate copies of the same objects, such as when
storing multiple branches of the same source.  The alternates mechanism
provides similar support for avoiding duplicates, but alternates do not
prevent duplication between new objects added to the repositories
without ongoing maintenance, while namespaces do.

To specify a namespace, set the GIT_NAMESPACE environment variable to
the namespace.  For each ref namespace, git stores the corresponding
refs in a directory under refs/namespaces/.  For example,
GIT_NAMESPACE=foo will store refs under refs/namespaces/foo/.  You can
also specify namespaces via the --namespace option to git.

Note that namespaces which include a / will expand to a hierarchy of
namespaces; for example, GIT_NAMESPACE=foo/bar will store refs under
refs/namespaces/foo/refs/namespaces/bar/.  This makes GIT_NAMESPACE
behave hierarchically, and avoids ambiguity with namespaces such as
foo/refs/heads.

This adds the infrastructure for ref namespaces: handling the
GIT_NAMESPACE environment variable and --namespace option, and iterating
over refs in a namespace.  Subsequent commits use this infrastructure to
implement the user-visible support for ref namespaces.

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 cache.h                                |    3 ++
 contrib/completion/git-completion.bash |    1 +
 environment.c                          |   41 ++++++++++++++++++++++++++++++++
 git.c                                  |   18 ++++++++++++-
 refs.c                                 |   25 +++++++++++++++++++
 refs.h                                 |    3 ++
 6 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e11cf6a..b256a94 100644
--- a/cache.h
+++ b/cache.h
@@ -379,6 +379,7 @@ static inline enum object_type object_type(unsigned int mode)
 }
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
@@ -419,6 +420,8 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern const char *get_git_namespace(void);
+extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b36290f..b10a1ec 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2640,6 +2640,7 @@ _git ()
 			--exec-path
 			--html-path
 			--work-tree=
+			--namespace=
 			--help
 			"
 			;;
diff --git a/environment.c b/environment.c
index 94d58fd..aad274b 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "refs.h"
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
@@ -65,6 +66,9 @@ int core_preload_index = 0;
 char *git_work_tree_cfg;
 static char *work_tree;
 
+static const char *namespace;
+static size_t namespace_len;
+
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
 
@@ -86,6 +90,27 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
 	NULL
 };
 
+static char *expand_namespace(const char *raw_namespace)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf **components, **c;
+
+	if (!raw_namespace || !*raw_namespace)
+		return xstrdup("");
+
+	strbuf_addstr(&buf, raw_namespace);
+	components = strbuf_split(&buf, '/');
+	strbuf_reset(&buf);
+	for (c = components; *c; c++)
+		if (strcmp((*c)->buf, "/") != 0)
+			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
+	strbuf_list_free(components);
+	if (check_ref_format(buf.buf) != CHECK_REF_FORMAT_OK)
+		die("bad git namespace path \"%s\"", raw_namespace);
+	strbuf_addch(&buf, '/');
+	return strbuf_detach(&buf, NULL);
+}
+
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
@@ -111,6 +136,8 @@ static void setup_git_env(void)
 		git_graft_file = git_pathdup("info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs = 0;
+	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
+	namespace_len = strlen(namespace);
 }
 
 int is_bare_repository(void)
@@ -131,6 +158,20 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+const char *get_git_namespace(void)
+{
+	if (!namespace)
+		setup_git_env();
+	return namespace;
+}
+
+const char *strip_namespace(const char *namespaced_ref)
+{
+	if (prefixcmp(namespaced_ref, get_git_namespace()) != 0)
+		return NULL;
+	return namespaced_ref + namespace_len;
+}
+
 static int git_work_tree_initialized;
 
 /*
diff --git a/git.c b/git.c
index 89721d4..98cbf7b 100644
--- a/git.c
+++ b/git.c
@@ -7,8 +7,8 @@
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
-	"           [--bare] [--git-dir=<path>] [--work-tree=<path>]\n"
+	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
+	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
 	"           [-c name=value] [--help]\n"
 	"           <command> [<args>]";
 
@@ -126,6 +126,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--namespace")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --namespace.\n" );
+				usage(git_usage_string);
+			}
+			setenv(GIT_NAMESPACE_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--namespace=")) {
+			setenv(GIT_NAMESPACE_ENVIRONMENT, cmd + 12, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --work-tree.\n" );
diff --git a/refs.c b/refs.c
index 003680f..20f83c3 100644
--- a/refs.c
+++ b/refs.c
@@ -782,6 +782,31 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
 }
 
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+	unsigned char sha1[20];
+	int flag;
+
+	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
+	if (resolve_ref(buf.buf, sha1, 1, &flag))
+		ret = fn(buf.buf, sha1, flag, cb_data);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+	strbuf_addf(&buf, "%srefs/", get_git_namespace());
+	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	strbuf_release(&buf);
+	return ret;
+}
+
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index 5e7a9a5..9a5c9e0 100644
--- a/refs.h
+++ b/refs.h
@@ -36,6 +36,9 @@ extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, voi
 extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 
+extern int head_ref_namespaced(each_ref_fn fn, void *cb_data);
+extern int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+
 static inline const char *has_glob_specials(const char *pattern)
 {
 	return strpbrk(pattern, "?*[");
-- 
1.7.5.3
