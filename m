From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv9 2/4] ref namespaces: infrastructure
Date: Tue, 5 Jul 2011 10:54:44 -0700
Message-ID: <4022201031d7e2ed11dd1a86e95762b6b468b10c.1309888001.git.josh@joshtriplett.org>
References: <cover.1309888001.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 05 19:54:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe9pr-0000nC-25
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 19:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab1GERyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 13:54:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58418 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1GERyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 13:54:54 -0400
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 4C62AA8085;
	Tue,  5 Jul 2011 19:54:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter8-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qbiBi1D0QIUj; Tue,  5 Jul 2011 19:54:51 +0200 (CEST)
X-Originating-IP: 174.25.139.9
Received: from leaf (174-25-139-9.ptld.qwest.net [174.25.139.9])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 92660A8090;
	Tue,  5 Jul 2011 19:54:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cover.1309888001.git.josh@joshtriplett.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176621>

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
refs/namespaces/foo/refs/namespaces/bar/.  This makes paths in
GIT_NAMESPACE behave hierarchically, so that cloning with
GIT_NAMESPACE=foo/bar produces the same result as cloning with
GIT_NAMESPACE=foo and cloning from that repo with GIT_NAMESPACE=bar.  It
also avoids ambiguity with strange namespace paths such as
foo/refs/heads/, which could otherwise generate directory/file conflicts
within the refs directory.

Add the infrastructure for ref namespaces: handle the GIT_NAMESPACE
environment variable and --namespace option, and support iterating over
refs in a namespace.

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
index bc9e5eb..dc29ef3 100644
--- a/cache.h
+++ b/cache.h
@@ -380,6 +380,7 @@ static inline enum object_type object_type(unsigned int mode)
 }
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
@@ -420,6 +421,8 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern const char *get_git_namespace(void);
+extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5a83090..e0b936d 100755
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
index 8828c18..304522b 100644
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
+				fprintf(stderr, "No namespace given for --namespace.\n" );
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
index 8bf8bb6..6f313a9 100644
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
index 5de06e5..dfb086e 100644
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
1.7.5.4
