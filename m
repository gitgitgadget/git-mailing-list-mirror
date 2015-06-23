From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] introduce "extensions" form of
 core.repositoryformatversion
Date: Tue, 23 Jun 2015 06:53:58 -0400
Message-ID: <20150623105357.GA12518@peff.net>
References: <20150623105042.GA10888@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 12:54:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7LqJ-0001wm-16
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 12:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbbFWKyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 06:54:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:50410 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754679AbbFWKyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 06:54:01 -0400
Received: (qmail 18551 invoked by uid 102); 23 Jun 2015 10:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 05:54:00 -0500
Received: (qmail 17937 invoked by uid 107); 23 Jun 2015 10:54:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 06:54:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2015 06:53:58 -0400
Content-Disposition: inline
In-Reply-To: <20150623105042.GA10888@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272450>

Normally we try to avoid bumps of the whole-repository
core.repositoryformatversion field. However, it is
unavoidable if we want to safely change certain aspects of
git in a backwards-incompatible way (e.g., modifying the set
of ref tips that we must traverse to generate a list of
unreachable, safe-to-prune objects).

If we were to bump the repository version for every such
change, then any implementation understanding version `X`
would also have to understand `X-1`, `X-2`, and so forth,
even though the incompatibilities may be in orthogonal parts
of the system, and there is otherwise no reason we cannot
implement one without the other (or more importantly, that
the user cannot choose to use one feature without the other,
weighing the tradeoff in compatibility only for that
particular feature).

This patch documents the existing repositoryformatversion
strategy and introduces a new format, "1", which lets a
repository specify that it must run with an arbitrary set of
extensions. This can be used, for example:

 - to inform git that the objects should not be pruned based
   only on the reachability of the ref tips (e.g, because it
   has "clone --shared" children)

 - that the refs are stored in a format besides the usual
   "refs" and "packed-refs" directories

Because we bump to format "1", and because format "1"
requires that a running git knows about any extensions
mentioned, we know that older versions of the code will not
do something dangerous when confronted with these new
formats.

For example, if the user chooses to use database storage for
refs, they may set the "extensions.refbackend" config to
"db". Older versions of git will not understand format "1"
and bail. Versions of git which understand "1" but do not
know about "refbackend", or which know about "refbackend"
but not about the "db" backend, will refuse to run. This is
annoying, of course, but much better than the alternative of
claiming that there are no refs in the repository, or
writing to a location that other implementations will not
read.

Note that we are only defining the rules for format 1 here.
We do not ever write format 1 ourselves; it is a tool that
is meant to be used by users and future extensions to
provide safety with older implementations.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/repository-version.txt | 81 ++++++++++++++++++++++++++
 cache.h                                        |  6 ++
 setup.c                                        | 37 +++++++++++-
 t/t1302-repo-version.sh                        | 38 ++++++++++++
 4 files changed, 159 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/technical/repository-version.txt

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
new file mode 100644
index 0000000..3d7106d
--- /dev/null
+++ b/Documentation/technical/repository-version.txt
@@ -0,0 +1,81 @@
+Git Repository Format Versions
+==============================
+
+Every git repository is marked with a numeric version in the
+`core.repositoryformatversion` key of its `config` file. This version
+specifies the rules for operating on the on-disk repository data. An
+implementation of git which does not understand a particular version
+advertised by an on-disk repository MUST NOT operate on that repository;
+doing so risks not only producing wrong results, but actually losing
+data.
+
+Because of this rule, version bumps should be kept to an absolute
+minimum. Instead, we generally prefer these strategies:
+
+  - bumping format version numbers of individual data files (e.g.,
+    index, packfiles, etc). This restricts the incompatibilities only to
+    those files.
+
+  - introducing new data that gracefully degrades when used by older
+    clients (e.g., pack bitmap files are ignored by older clients, which
+    simply do not take advantage of the optimization they provide).
+
+A whole-repository format version bump should only be part of a change
+that cannot be independently versioned. For instance, if one were to
+change the reachability rules for objects, or the rules for locking
+refs, that would require a bump of the repository format version.
+
+Note that this applies only to accessing the repository's disk contents
+directly. An older client which understands only format `0` may still
+connect via `git://` to a repository using format `1`, as long as the
+server process understands format `1`.
+
+The preferred strategy for rolling out a version bump (whether whole
+repository or for a single file) is to teach git to read the new format,
+and allow writing the new format with a config switch or command line
+option (for experimentation or for those who do not care about backwards
+compatibility with older gits). Then after a long period to allow the
+reading capability to become common, we may switch to writing the new
+format by default.
+
+The currently defined format versions are:
+
+Version `0`
+-----------
+
+This is the format defined by the initial version of git, including but
+not limited to the format of the repository directory, the repository
+configuration file, and the object and ref storage. Specifying the
+complete behavior of git is beyond the scope of this document.
+
+Version `1`
+-----------
+
+This format is identical to version `0`, with the following exceptions:
+
+  1. When reading the `core.repositoryformatversion` variable, a git
+     implementation which supports version 1 MUST also read any
+     configuration keys found in the `extensions` section of the
+     configuration file.
+
+  2. If a version-1 repository specifies any `extensions.*` keys that
+     the running git has not implemented, the operation MUST NOT
+     proceed. Similarly, if the value of any known key is not understood
+     by the implementation, the operation MUST NOT proceed.
+
+Note that if no extensions are specified in the config file, then
+`core.repositoryformatversion` SHOULD be set to `0` (setting it to `1`
+provides no benefit, and makes the repository incompatible with older
+implementations of git).
+
+This document will serve as the master list for extensions. Any
+implementation wishing to define a new extension should make a note of
+it here, in order to claim the name.
+
+The defined extensions are:
+
+`noop`
+~~~~~~
+
+This extension does not change git's behavior at all. It is useful only
+for testing format-1 compatibility.
diff --git a/cache.h b/cache.h
index 571c98f..bee425b 100644
--- a/cache.h
+++ b/cache.h
@@ -686,7 +686,13 @@ extern char *notes_ref_name;
 
 extern int grafts_replace_parents;
 
+/*
+ * GIT_REPO_VERSION is the version we write by default. The
+ * _READ variant is the highest number we know how to
+ * handle.
+ */
 #define GIT_REPO_VERSION 0
+#define GIT_REPO_VERSION_READ 1
 extern int repository_format_version;
 extern int check_repository_format(void);
 
diff --git a/setup.c b/setup.c
index 82c0cc2..0d53846 100644
--- a/setup.c
+++ b/setup.c
@@ -5,6 +5,7 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
+static struct string_list unknown_extensions = STRING_LIST_INIT_DUP;
 
 /*
  * The input parameter must contain an absolute path, and it must already be
@@ -352,10 +353,23 @@ void setup_work_tree(void)
 
 static int check_repo_format(const char *var, const char *value, void *cb)
 {
+	const char *ext;
+
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
+	else if (skip_prefix(var, "extensions.", &ext)) {
+		/*
+		 * record any known extensions here; otherwise,
+		 * we fall through to recording it as unknown, and
+		 * check_repository_format will complain
+		 */
+		if (!strcmp(ext, "noop"))
+			;
+		else
+			string_list_append(&unknown_extensions, ext);
+	}
 	return 0;
 }
 
@@ -366,6 +380,8 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	config_fn_t fn;
 	int ret = 0;
 
+	string_list_clear(&unknown_extensions, 0);
+
 	if (get_common_dir(&sb, gitdir))
 		fn = check_repo_format;
 	else
@@ -383,16 +399,31 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	 * is a good one.
 	 */
 	git_config_early(fn, NULL, repo_config);
-	if (GIT_REPO_VERSION < repository_format_version) {
+	if (GIT_REPO_VERSION_READ < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <= %d, found %d",
-			     GIT_REPO_VERSION, repository_format_version);
+			     GIT_REPO_VERSION_READ, repository_format_version);
 		warning("Expected git repo version <= %d, found %d",
-			GIT_REPO_VERSION, repository_format_version);
+			GIT_REPO_VERSION_READ, repository_format_version);
 		warning("Please upgrade Git");
 		*nongit_ok = -1;
 		ret = -1;
 	}
+
+	if (repository_format_version >= 1 && unknown_extensions.nr) {
+		int i;
+
+		if (!nongit_ok)
+			die("unknown repository extension: %s",
+			    unknown_extensions.items[0].string);
+
+		for (i = 0; i < unknown_extensions.nr; i++)
+			warning("unknown repository extension: %s",
+				unknown_extensions.items[i].string);
+		*nongit_ok = -1;
+		ret = -1;
+	}
+
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 0d9388a..8dd6fd7 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -67,4 +67,42 @@ test_expect_success 'gitdir required mode' '
 	)
 '
 
+check_allow () {
+	git rev-parse --git-dir >actual &&
+	echo .git >expect &&
+	test_cmp expect actual
+}
+
+check_abort () {
+	test_must_fail git rev-parse --git-dir
+}
+
+# avoid git-config, since it cannot be trusted to run
+# in a repository with a broken version
+mkconfig () {
+	echo '[core]' &&
+	echo "repositoryformatversion = $1" &&
+	shift &&
+
+	if test $# -gt 0; then
+		echo '[extensions]' &&
+		for i in "$@"; do
+			echo "$i"
+		done
+	fi
+}
+
+while read outcome version extensions; do
+	test_expect_success "$outcome version=$version $extensions" "
+		mkconfig $version $extensions >.git/config &&
+		check_${outcome}
+	"
+done <<\EOF
+allow 0
+allow 1
+allow 1 noop
+abort 1 no-such-extension
+allow 0 no-such-extension
+EOF
+
 test_done
-- 
2.4.4.719.g3984bc6
