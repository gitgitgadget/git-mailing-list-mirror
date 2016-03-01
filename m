From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 31/33] refs: add LMDB refs storage backend
Date: Mon, 29 Feb 2016 19:53:04 -0500
Message-ID: <1456793586-22082-32-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYa6-0007RW-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbcCAAyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:13 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34714 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbcCAAyE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:54:04 -0500
Received: by mail-qg0-f51.google.com with SMTP id b67so130622971qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xdg8RlcucA8w1mHx06lW6RGdRcpBV4Ae65j2+rSmW8c=;
        b=WX32WgMzsisSpOCIMTPp1AjElPgD9tLlhszK/yldIfgaAhrPB6oJssglxrCNk7sHPr
         oErZRCHQCHqZgpZnkv0lp+5QZqONL7tl25fzDvVXWMGWd+MhD5B8jv//pPJcR4yzmAML
         Ah7mFVm4fVLgiR90SlgjJ0no7By7dfFov0YLSUCNni5oSe2xEdleGdlBFfyjZ5Pu3msy
         CP5orvNMT+iQwDR7JAm4q8f1caVAUrt7F+1bS9IKjEPVmYLoVm70kDsbVCWNry/Y7e0w
         SA754tLotZasyxA4v+fJqN24CWzFSb4YQi1jOJltM0cFSJApK3roim6FISR/lCihVy0Q
         78EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xdg8RlcucA8w1mHx06lW6RGdRcpBV4Ae65j2+rSmW8c=;
        b=TUTIKenMCPK263yOM01o9JMp2+1fX/obU2O1oR3M0Ai8HoWQi+khc5DJJ1kSi1oiST
         ShpzDmVir33AmVLm6aGSiVQtEHcKHBqyxhVrEgHEQViifsQkCauOatndKEzd0REQECBW
         0Jti/YaLzpzp8A5XetjMu816gmNGSD9MeevmIYqwG8xBuzqbeynnx3RmwQcEk6Ssw9i2
         wbkW8Z3Noc9/zzSxHJmLl/YmGTdEnIVmldV2iXqb2ur7bVDZnCCg9LA98eItyLGoUoEw
         gyKLPkU+1JKvt5Ob4FoXPJTqN1QLUCYEyGC2vUaZV7o8wC1YVHjHI8Ejpcr9Anoqojs4
         qgJw==
X-Gm-Message-State: AD7BkJJWq0EbWpv3dTzF+iHeQsheskwrgbyuRUyZaV5qxTkeU2pEN5kSrm6xIHbXHvE10Q==
X-Received: by 10.140.236.68 with SMTP id h65mr24678271qhc.13.1456793643382;
        Mon, 29 Feb 2016 16:54:03 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.54.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:54:02 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287968>

Add a database backend for refs using LMDB.  This backend runs git
for-each-ref about 30% faster than the files backend with fully-packed
refs on a repo with ~120k refs.  It's also about 4x faster than using
fully-unpacked refs.  In addition, and perhaps more importantly, it
avoids case-conflict issues on OS X.

LMDB has a few features that make it suitable for usage in git:

1. It is licensed under the OpenLDAP Public License, which is
GPL-compatible [1].

[1] http://www.gnu.org/licenses/license-list.en.html#newOpenLDAP

2. It is relatively lightweight; it requires only one header file, and
the library code takes under 64k at runtime.

3. It is well-tested: it's been used in OpenLDAP for years.

4. It's very fast.  LMDB's benchmarks show that it is among
the fastest key-value stores.

5. It has a relatively simple concurrency story; readers don't
block writers and writers don't block readers.

Ronnie Sahlberg's original version of this patchset used tdb.  The
major disadvantage of tdb is that tdb is hard to build on OS X.  It's
also not in homebrew.  So lmdb seemed simpler.

To test this backend's correctness, I added support to the test suite
to run under LMDB.  Dozens of tests use manual ref/reflog
reading/writing, or create submodules without passing --ref-storage to
git init.  If those tests are changed to use the update-ref machinery
or test-refs-lmdb-backend (or, in the case of packed-refs, corrupt
refs, and dumb fetch tests, are skipped), the only remaining failing
tests are the git-new-workdir tests.  Later, we'll add this support
to the test suite.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                                     |    1 +
 Documentation/config.txt                       |    9 +
 Documentation/git-clone.txt                    |    3 +-
 Documentation/git-init.txt                     |    3 +-
 Documentation/technical/refs-lmdb-backend.txt  |   61 +
 Documentation/technical/repository-version.txt |    7 +
 Makefile                                       |   12 +
 configure.ac                                   |   33 +
 contrib/workdir/git-new-workdir                |    3 +
 path.c                                         |    1 +
 refs/lmdb-backend.c                            | 1886 ++++++++++++++++++++++++
 test-refs-lmdb-backend.c                       |   66 +
 12 files changed, 2083 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100644 test-refs-lmdb-backend.c

diff --git a/.gitignore b/.gitignore
index 5087ce1..b07bec1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -200,6 +200,7 @@
 /test-path-utils
 /test-prio-queue
 /test-read-cache
+/test-refs-lmdb-backend
 /test-regex
 /test-revision-walking
 /test-run-command
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59d7046..3677b75 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1153,6 +1153,15 @@ difftool.<tool>.cmd::
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
+extensions.refStorage::
+	Type of ref storage backend. Default is to use the original
+	files based ref storage.  When set to "lmdb", refs are stored
+	in an LMDB database.  This setting reflects the refs storage
+	backend that was chosen via the --ref-storage option when the
+	repository was originally created. It is currently not
+	possible to change the refs storage backend of an existing
+	repository.
+
 fetch.recurseSubmodules::
 	This option can be either set to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index a5a48cb..cd6dc38 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -235,7 +235,8 @@ objects from the source repository into a pack in the cloned repository.
 
 --ref-storage=<name>::
 	Type of ref storage backend. Default is to use the original files
-	based ref storage.
+	based ref storage. Set to "lmdb" to store refs in the LMDB database
+	backend.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 93f8d0c..129702b 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -116,7 +116,8 @@ does not exist, it will be created.
 --ref-storage=<name>::
 Type of refs storage backend. Default is to use the original "files"
 storage, which stores ref data in files in `$GIT_DIR/refs` and
-`$GIT_DIR/packed-refs`.
+`$GIT_DIR/packed-refs`. Set to "lmdb" to activate the LMDB storage
+backend.
 
 TEMPLATE DIRECTORY
 ------------------
diff --git a/Documentation/technical/refs-lmdb-backend.txt b/Documentation/technical/refs-lmdb-backend.txt
new file mode 100644
index 0000000..b8b5a0a
--- /dev/null
+++ b/Documentation/technical/refs-lmdb-backend.txt
@@ -0,0 +1,61 @@
+Notes on the LMDB refs backend
+==============================
+
+Design:
+------
+
+Refs and reflogs are stored in a lmdb database in .git/refs.lmdb.  All
+keys and values are \0-terminated.
+
+Keys for refs are the name of the ref (e.g. refs/heads/master).
+Values are the value of the ref, in hex
+(e.g. 61f23eb0f81357c19fa91e2b8c6f3906c3a8f9b0).
+
+All per-worktree refs (refs/bisect/* and HEAD) are stored using
+the traditional files-based backend.
+
+Reflogs are stored as a series of database entries.
+
+For non-empty reflogs, there is one entry per logged ref update.  The
+key format is logs/[refname]\0[timestamp].  The timestamp is a 64-bit
+unsigned integer number of nanoseconds since 1/1/1970, stored in
+network byte order.  This means that reflog entries are
+chronologically ordered.  Because LMDB is a btree database, we can
+efficiently iterate over these keys.
+
+For an empty reflog, there is a "header" entry to show that a reflog
+exists.  The header has the same format as an ordinary reflog entry,
+but with a timestamp of all zeros and an empty value.
+
+Reflog values are in almost the same format as the original
+files-based reflog, including the trailing LF. The exception is that
+the SHAs are stored in binary instead of hex. The date in the reflog
+value matches the date in the timestamp field.
+
+Weaknesses:
+-----------
+
+The reflog format is somewhat inefficient: a binary format could store
+reflog date/time information in somewhat less space.
+
+The rsync and file:// transports don't work yet, because they
+don't use the refs API.
+
+git new-workdir is incompatible with the lmdb backend.  Fortunately,
+git new-workdir is deprecated, and worktrees work fine.
+
+LMDB locks the entire database for write.  Any other writer waits
+until the first writer is done before beginning.  Readers do not wait
+for writers, and writers do not wait for readers.  The underlying
+scheme is approximately MVCC; each reader's queries see the state of
+the database as-of the time that the reader acquired its read lock.
+This is not too far off from the files backend, which loads all refs
+into memory when one is requested.
+
+LMDB requires write access to the filesystem for locking.  In the case
+where there are only readers (e.g. read-only repositories), this
+requirement can be relaxed using the MDB_NOLOCK option.  But we don't
+yet have a config to do that.
+
+Don't use this over NFS or other remote filesystems.  LMDB doesn't work
+there.
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad379..b317ba9 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,10 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`refStorage`
+~~~~~~~~~~~~
+This extension allows the use of alternate ref storage backends.  The
+only defined values are `lmdb`, `files`, and the empty string (meaning
+`files`).  The latter two values should never be used, because the
+files backend is the default and does not need repository version 1.
diff --git a/Makefile b/Makefile
index 10566d6..fd80e94 100644
--- a/Makefile
+++ b/Makefile
@@ -1042,6 +1042,17 @@ ifdef USE_LIBPCRE
 	EXTLIBS += -lpcre
 endif
 
+ifdef USE_LIBLMDB
+	BASIC_CFLAGS += -DUSE_LIBLMDB
+	ifdef LIBLMDBDIR
+		BASIC_CFLAGS += -I$(LIBLMDBDIR)/include
+		EXTLIBS += -L$(LIBLMDBDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBLMDBDIR)/$(lib)
+	endif
+	EXTLIBS += -llmdb
+	LIB_OBJS += refs/lmdb-backend.o
+	TEST_PROGRAMS_NEED_X += test-refs-lmdb-backend
+endif
+
 ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
@@ -2140,6 +2151,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo USE_LIBLMDB=\''$(subst ','\'',$(subst ','\'',$(USE_LIBLMDB)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
diff --git a/configure.ac b/configure.ac
index 89e2590..3853bec 100644
--- a/configure.ac
+++ b/configure.ac
@@ -271,6 +271,24 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
         dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
+
+USE_LIBLMDB=YesPlease
+AC_ARG_WITH(liblmdb,
+AS_HELP_STRING([--with-liblmdb],[support lmdb (default is YES])
+AS_HELP_STRING([],           [ARG can be also prefix for liblmdb library and headers]),
+    if test "$withval" = "no"; then
+	USE_LIBLMDB=
+    elif test "$withval" = "yes"; then
+	USE_LIBLMDB=YesPlease
+    else
+	USE_LIBLMDB=YesPlease
+	LIBLMDBDIR=$withval
+	AC_MSG_NOTICE([Setting LIBLMDBDIR to $LIBLMDBDIR])
+        dnl USE_LIBLMDB can still be modified below, so don't substitute
+        dnl it yet.
+	GIT_CONF_SUBST([LIBLMDBDIR])
+    fi)
+
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 AC_FUNC_ALLOCA
@@ -510,6 +528,21 @@ GIT_CONF_SUBST([USE_LIBPCRE])
 
 fi
 
+if test -n "$USE_LIBLMDB"; then
+
+GIT_STASH_FLAGS($LIBLMDBDIR)
+
+AC_CHECK_LIB([lmdb], [mdb_env_open],
+[USE_LIBLMDB=YesPlease],
+[USE_LIBLMDB=])
+
+GIT_UNSTASH_FLAGS($LIBLMDBDIR)
+
+GIT_CONF_SUBST([USE_LIBLMDB])
+
+fi
+
+
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 888c34a..d153ddf 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -28,6 +28,9 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
   git rev-parse --git-dir 2>/dev/null) ||
   die "Not a git repository: \"$orig_git\""
 
+ref_storage=$(git config extensions.refstorage || echo "files")
+test "$ref_storage" != "files" && die "git-new-workdir is incompatible with ref storage other than 'files'"
+
 case "$git_dir" in
 .git)
 	git_dir="$orig_git/.git"
diff --git a/path.c b/path.c
index 2e67a2b..347aba4 100644
--- a/path.c
+++ b/path.c
@@ -112,6 +112,7 @@ static struct common_dir common_list[] = {
 	{ 0, 1, 0, "lost-found" },
 	{ 0, 1, 0, "objects" },
 	{ 0, 1, 0, "refs" },
+	{ 0, 1, 0, "refs.lmdb" },
 	{ 0, 1, 1, "refs/bisect" },
 	{ 0, 1, 0, "remotes" },
 	{ 0, 1, 0, "worktrees" },
diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
new file mode 100644
index 0000000..3e391e61
--- /dev/null
+++ b/refs/lmdb-backend.c
@@ -0,0 +1,1886 @@
+/*
+ * This file implements a lmdb backend for refs.
+ *
+ * The design of this backend relies on lmdb's write lock -- that is, any
+ * write transaction blocks all other writers.  Thus, as soon as a ref
+ * transaction is opened, we know that any values we read won't
+ * change out from under us, and we have a fully-consistent view of the
+ * database.
+ *
+ * We store the content of refs including the trailing \0 so that
+ * standard C string functions can handle them.  Just like struct
+ * strbuf.
+ */
+#include "cache.h"
+#include <lmdb.h>
+#include "object.h"
+#include "refs.h"
+#include "refs-internal.h"
+#include "tag.h"
+#include "lockfile.h"
+
+static MDB_env *main_env;
+
+static char *db_path;
+
+struct lmdb_transaction {
+	MDB_txn *txn;
+	MDB_dbi dbi;
+	MDB_cursor *cursor;
+	const char *submodule;
+	int flags;
+};
+
+static struct lmdb_transaction main_transaction;
+
+static int in_write_transaction(void)
+{
+	return main_transaction.txn && !(main_transaction.flags & MDB_RDONLY);
+}
+
+static int cleanup_registered;
+
+static void cleanup_txn(void)
+{
+	if (main_transaction.txn)
+		mdb_txn_abort(main_transaction.txn);
+}
+
+static void init_env(MDB_env **env, const char *path)
+{
+	int ret;
+	if (*env)
+		return;
+
+	assert(path);
+
+	ret = mdb_env_create(env);
+	if (ret)
+		die("BUG: mdb_env_create failed: %s", mdb_strerror(ret));
+	ret = mdb_env_set_maxreaders(*env, 1000);
+	if (ret)
+		die("BUG: mdb_env_set_maxreaders failed: %s", mdb_strerror(ret));
+	ret = mdb_env_set_mapsize(*env, (1<<30));
+	if (ret)
+		die("BUG: mdb_set_mapsize failed: %s", mdb_strerror(ret));
+	for (;;) {
+		/*
+		 * The LMDB docs say, "Opening a database can fail if
+		 * another process is opening or closing it at exactly
+		 * the same time."  They don't specify what will
+		 * happen in this case.  From reading LDMB's code, it
+		 * appears that init_env will return an error code
+		 * from fcntl: EAGAIN or EACCES.  So we'll retry in
+		 * those cases.
+		 */
+		ret = mdb_env_open(*env, path, MDB_NOSUBDIR, 0664);
+		if (ret == 0)
+			break;
+		if (ret != EAGAIN && ret != EACCES)
+			die("BUG: mdb_env_open (%s) failed: %s", path,
+			    mdb_strerror(ret));
+	}
+
+	if (!cleanup_registered) {
+		cleanup_registered = 1;
+		atexit(cleanup_txn);
+	}
+}
+
+static int lmdb_init_db(int shared, struct strbuf *err)
+{
+	/*
+	 * To create a db, all we need to do is set up the db path
+	 * variable.
+	 */
+
+	if (!db_path)
+		db_path = xstrdup(real_path(git_path("refs.lmdb")));
+	return 0;
+}
+
+static void mdb_cursor_open_or_die(struct lmdb_transaction *transaction,
+				   MDB_cursor **cursor)
+{
+	int ret = mdb_cursor_open(transaction->txn, transaction->dbi, cursor);
+	if (ret)
+		die("BUG: mdb_cursor_open failed: %s", mdb_strerror(ret));
+}
+
+static void submodule_path(struct strbuf *sb, const char *submodule,
+			   const char *refname)
+{
+	if (submodule)
+		strbuf_git_path_submodule(sb, submodule, "%s", refname);
+	else
+		strbuf_git_path(sb, "%s", refname);
+}
+
+static int read_per_worktree_ref(const char *submodule, const char *refname,
+				 struct MDB_val *val, int *needs_free)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct stat st;
+	int ret = -1;
+	int symlink_head;
+
+	submodule_path(&path, submodule, refname);
+
+#ifdef NO_SYMLINK_HEAD
+	symlink_head = 0;
+#else
+	symlink_head = 1;
+#endif
+
+	if (symlink_head) {
+		if (lstat(path.buf, &st)) {
+			if (errno == ENOENT)
+				ret = MDB_NOTFOUND;
+			goto done;
+		}
+		if (S_ISLNK(st.st_mode)) {
+			strbuf_readlink(&sb, path.buf, 0);
+			if (starts_with(sb.buf, "refs/") &&
+			    !check_refname_format(sb.buf, 0)) {
+				val->mv_data = xstrfmt("ref: %s", sb.buf);
+				val->mv_size = strlen(val->mv_data) + 1;
+				ret = 0;
+			} else {
+				ret = MDB_NOTFOUND;
+			}
+			strbuf_release(&sb);
+			goto done;
+		}
+	}
+
+	if (strbuf_read_file(&sb, path.buf, 200) < 0) {
+		strbuf_release(&sb);
+		if (errno == ENOENT)
+			ret = MDB_NOTFOUND;
+		goto done;
+	}
+	strbuf_rtrim(&sb);
+
+	val->mv_data = strbuf_detach(&sb, &val->mv_size);
+	val->mv_size++;
+
+	ret = 0;
+done:
+	strbuf_release(&path);
+	*needs_free = !ret;
+	return ret;
+}
+
+static void write_per_worktree_ref(const char *submodule, const char *refname,
+				   MDB_val *val)
+{
+	static struct lock_file lock;
+	int fd;
+	int len = val->mv_size - 1;
+	struct strbuf path = STRBUF_INIT;
+
+	submodule_path(&path, submodule, refname);
+	safe_create_leading_directories(path.buf);
+
+	fd = hold_lock_file_for_update(&lock, path.buf, LOCK_DIE_ON_ERROR);
+	strbuf_release(&path);
+
+	if (write_in_full(fd, val->mv_data, len) != len ||
+	    write_in_full(fd, "\n", 1) != 1)
+		die_errno(_("failed to write new HEAD"));
+
+	if (commit_lock_file(&lock))
+		die_errno(_("failed to write new HEAD"));
+}
+
+static int del_per_worktree_ref(const char *submodule, const char *refname,
+				MDB_val *val)
+{
+	struct strbuf path = STRBUF_INIT;
+	int result;
+
+	/*
+	 * Returning deleted ref data is not yet implemented, but no
+	 * callers need it.
+	 */
+	assert(val == NULL);
+
+	submodule_path(&path, submodule, refname);
+
+	result = unlink(path.buf);
+	strbuf_release(&path);
+	if (result && errno != ENOENT)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Read a ref.  If the ref is a per-worktree ref, read it from disk.
+ * Otherwise, read it from LMDB.  LMDB manages its own memory, so the
+ * data returned in *val will ordinarily not need to be freed.  But
+ * when a per-worktree ref is (successfully) read, non-LMDB memory is
+ * allocated.  In this case, *needs_free is set so that the caller can
+ * free the memory when it is done with it.
+ */
+static int mdb_get_or_die(struct lmdb_transaction *transaction, MDB_val *key,
+			  MDB_val *val, int *needs_free)
+{
+	int ret;
+
+	if (ref_type(key->mv_data) != REF_TYPE_NORMAL)
+		return read_per_worktree_ref(transaction->submodule,
+					     key->mv_data, val, needs_free);
+
+	*needs_free = 0;
+	ret = mdb_get(transaction->txn, transaction->dbi, key, val);
+	if (ret) {
+		if (ret != MDB_NOTFOUND)
+			die("BUG: mdb_get failed: %s", mdb_strerror(ret));
+		return ret;
+	}
+	return 0;
+}
+
+static int mdb_del_or_die(struct lmdb_transaction *transaction, MDB_val *key,
+			  MDB_val *val)
+{
+	int ret;
+
+	if (ref_type(key->mv_data) != REF_TYPE_NORMAL)
+		die("BUG: this backend should only try to delete normal refs");
+
+	ret = mdb_del(transaction->txn, transaction->dbi, key, val);
+	if (ret) {
+		if (ret != MDB_NOTFOUND)
+			die("BUG: mdb_del failed: %s", mdb_strerror(ret));
+		return ret;
+	}
+	return 0;
+}
+
+static void mdb_put_or_die(struct lmdb_transaction *transaction, MDB_val *key,
+			   MDB_val *val, int mode)
+{
+	int ret;
+
+	if (ref_type(key->mv_data) != REF_TYPE_NORMAL)
+		die("BUG: this backend should only try to write normal refs");
+
+	ret = mdb_put(transaction->txn, transaction->dbi, key, val, mode);
+	if (ret) {
+		if (ret == MDB_BAD_VALSIZE) {
+			MDB_env *env = mdb_txn_env(transaction->txn);
+			die(_("Ref name %s too long (max size is %d)"),
+			    (const char *)key->mv_data,
+			    mdb_env_get_maxkeysize(env));
+		} else {
+			die("BUG: mdb_put failed: (%s -> %s) %s",
+			    (const char *)key->mv_data,
+			    (const char *)val->mv_data, mdb_strerror(ret));
+		}
+	}
+}
+
+static int mdb_cursor_get_or_die(MDB_cursor *cursor, MDB_val *key, MDB_val *val, int mode)
+{
+	int ret;
+
+	ret = mdb_cursor_get(cursor, key, val, mode);
+	if (ret) {
+		if (ret != MDB_NOTFOUND)
+			die("BUG: mdb_cursor_get failed: %s", mdb_strerror(ret));
+		return ret;
+	}
+	assert(((char *)val->mv_data)[val->mv_size - 1] == 0);
+	return 0;
+}
+
+static int mdb_cursor_del_or_die(MDB_cursor *cursor, int flags)
+{
+	int ret = mdb_cursor_del(cursor, flags);
+	if (ret) {
+		if (ret != MDB_NOTFOUND)
+			die("BUG: mdb_cursor_del failed: %s", mdb_strerror(ret));
+		return ret;
+	}
+	return 0;
+}
+
+/*
+ * Begin a transaction. Because only one transaction per thread is
+ * permitted, we use a global transaction object.  If a read-write
+ * transaction is presently already in-progress, and a read-only
+ * transaction is requested, the read-write transaction will be
+ * returned instead.  If a read-write transaction is requested and a
+ * read-only transaction is open, the read-only transaction will be
+ * closed.
+ *
+ * It is a bug to request a read-write transaction during another
+ * read-write transaction.
+ *
+ * As a result, it is unsafe to retain read-only transactions past the
+ * point where a read-write transaction might be needed.  For
+ * instance, any call that has callbacks outside this module must
+ * conclude all of its reads from the database before calling those
+ * callbacks, or must reacquire the transaction after its callbacks
+ * are completed.
+ */
+static int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int flags)
+{
+	int ret;
+	MDB_txn *txn;
+	static size_t last_txnid;
+	int force_restart = 0;
+	MDB_envinfo stat;
+
+	if (!db_path)
+		db_path = xstrdup(real_path(git_path("refs.lmdb")));
+
+	init_env(&main_env, db_path);
+
+	/*
+	 * Since each transaction sees a consistent view of the db,
+	 * downstream processes that write the db won't be seen in
+	 * this transaction.  We can check if the last transaction id
+	 * has changed since this read transaction was started, and if
+	 * so, we want to reopen the transaction.
+	 */
+
+	mdb_env_info(main_env, &stat);
+	if (stat.me_last_txnid != last_txnid) {
+		force_restart = 1;
+		last_txnid = stat.me_last_txnid;
+	}
+
+	if (!main_transaction.txn) {
+		ret = mdb_txn_begin(main_env, NULL, flags, &txn);
+		if (ret) {
+			strbuf_addf(err, "BUG: mdb_txn_begin failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		ret = mdb_dbi_open(txn, NULL, 0, &main_transaction.dbi);
+		if (ret) {
+			strbuf_addf(err, "BUG: mdb_txn_open failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		main_transaction.txn = txn;
+		main_transaction.flags = flags;
+		return 0;
+	}
+
+	if (main_transaction.flags == flags && !(flags & MDB_RDONLY))
+		die("BUG: rw transaction started during another rw txn");
+
+	if (force_restart || (main_transaction.flags != flags && main_transaction.flags & MDB_RDONLY)) {
+		/*
+		 * RO -> RW, or forced restart due to possible changes
+		 * from downstream processes.
+		 */
+		mdb_txn_abort(main_transaction.txn);
+		main_transaction.txn = NULL;
+		ret = mdb_txn_begin(main_env, NULL, flags, &txn);
+		if (ret) {
+			strbuf_addf(err, "BUG: restarting txn: mdb_txn_begin failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		ret = mdb_dbi_open(txn, NULL, 0, &main_transaction.dbi);
+		if (ret) {
+			strbuf_addf(err, "BUG: mdb_txn_open failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		main_transaction.txn = txn;
+		main_transaction.flags = flags;
+	}
+	/* RW -> RO just keeps the RW txn */
+	return 0;
+}
+
+static struct lmdb_transaction *lmdb_transaction_begin_flags_or_die(int flags)
+{
+	struct strbuf err = STRBUF_INIT;
+	if (lmdb_transaction_begin_flags(&err, flags))
+		die("%s", err.buf);
+	return &main_transaction;
+}
+
+static int verify_refname_available_txn(struct lmdb_transaction *transaction,
+					const char *refname,
+					struct string_list *extras,
+					struct string_list *skip,
+					struct strbuf *err)
+{
+	MDB_cursor *cursor;
+	MDB_val key;
+	MDB_val val;
+	int mdb_ret;
+	size_t refname_len;
+	char *search_key;
+	const char *extra_refname;
+	int ret = 1;
+	size_t i;
+
+	mdb_cursor_open_or_die(transaction, &cursor);
+
+	refname_len = strlen(refname) + 2;
+	key.mv_size = refname_len;
+	search_key = xmalloc(refname_len);
+	memcpy(search_key, refname, refname_len - 2);
+	search_key[refname_len - 2] = '/';
+	search_key[refname_len - 1] = 0;
+	key.mv_data = search_key;
+
+	/* Check for subdirs of refname: we start at refname/ */
+	mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE);
+
+	while (!mdb_ret) {
+		if (starts_with(key.mv_data, refname) &&
+		    ((char *)key.mv_data)[refname_len - 2] == '/') {
+			if (skip && string_list_has_string(skip, key.mv_data))
+				goto next;
+
+			strbuf_addf(err, _("'%s' exists; cannot create '%s'"), (char *)key.mv_data, refname);
+			goto done;
+		}
+		break;
+next:
+		mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_NEXT);
+	}
+
+	/* Check for parent dirs of refname. */
+	for (i = 0; i < refname_len - 2; i++) {
+		if (search_key[i] == '/') {
+			search_key[i] = 0;
+			if (skip && string_list_has_string(skip, search_key)) {
+				search_key[i] = '/';
+				continue;
+			}
+
+			if (extras && string_list_has_string(extras, search_key)) {
+				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+					    refname, search_key);
+				goto done;
+			}
+
+			key.mv_data = search_key;
+			key.mv_size = i + 1;
+			if (!mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET)) {
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"), (char *)key.mv_data, refname);
+				goto done;
+			}
+			search_key[i] = '/';
+		}
+	}
+
+	extra_refname = find_descendant_ref(refname, extras, skip);
+	if (extra_refname) {
+		strbuf_addf(err,
+			    _("cannot process '%s' and '%s' at the same time"),
+			    refname, extra_refname);
+		ret = 1;
+	} else {
+		ret = 0;
+	}
+done:
+	mdb_cursor_close(cursor);
+	free(search_key);
+	return ret;
+}
+
+static MDB_env *submodule_txn_begin(struct lmdb_transaction *transaction)
+{
+	int ret;
+	MDB_env *submodule_env = NULL;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_git_path_submodule(&path, transaction->submodule, "refs.lmdb");
+
+	init_env(&submodule_env, path.buf);
+
+	ret = mdb_txn_begin(submodule_env, NULL, MDB_RDONLY, &transaction->txn);
+	if (ret)
+		die("BUG: mdb_txn_begin failed: %s", mdb_strerror(ret));
+
+	ret = mdb_dbi_open(transaction->txn, NULL, 0, &transaction->dbi);
+	if (ret)
+		die("BUG: mdb_txn_open failed: %s", mdb_strerror(ret));
+
+	strbuf_release(&path);
+	return submodule_env;
+}
+
+static struct lmdb_transaction *get_submodule_transaction(const char *submodule)
+{
+	static char *last_submodule;
+	static struct lmdb_transaction transaction = {NULL};
+	static MDB_env *env;
+
+	if (submodule == NULL) {
+		if (last_submodule != NULL) {
+			if (env)
+				mdb_env_close(env);
+			env = NULL;
+			free((char *)transaction.submodule);
+			transaction.submodule = NULL;
+			free(last_submodule);
+			last_submodule = NULL;
+		}
+		return lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	}
+
+	if (submodule != NULL && last_submodule != NULL &&
+	     !strcmp(submodule, last_submodule) && transaction.txn != NULL)
+		return &transaction;
+
+	free((char *)transaction.submodule);
+	transaction.submodule = xstrdup(submodule);
+	transaction.txn = NULL;
+
+	last_submodule = xstrdup(submodule);
+	env = submodule_txn_begin(&transaction);
+
+	return &transaction;
+}
+
+static int lmdb_read_raw_ref(const char *submodule, const char *refname,
+			     unsigned char *sha1, struct strbuf *symref,
+			     struct strbuf *sb_path, unsigned int *flags)
+{
+	char *buf;
+	struct MDB_val key, val;
+	int needs_free = 0;
+	int ret = -1;
+	struct lmdb_transaction *transaction;
+
+	transaction = get_submodule_transaction(submodule);
+
+	val.mv_size = 0;
+	val.mv_data = NULL;
+
+	if (flags)
+		*flags = 0;
+
+	key.mv_data = (void *)refname;
+	key.mv_size = strlen(refname) + 1;
+	if (mdb_get_or_die(transaction, &key, &val, &needs_free)) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	buf = val.mv_data;
+	assert(buf[val.mv_size - 1] == 0);
+
+	if (starts_with(buf, "ref:")) {
+		buf += 4;
+		while (isspace(*buf))
+			buf++;
+
+		strbuf_reset(symref);
+		strbuf_addstr(symref, buf);
+		if (flags)
+			*flags |= REF_ISSYMREF;
+		ret = 0;
+		goto done;
+	}
+
+	/*
+	 * Please note that FETCH_HEAD has additional
+	 * data after the sha.
+	 */
+	if (get_sha1_hex(buf, sha1) ||
+	    (buf[40] != '\0' && !isspace(buf[40]))) {
+		if (flags)
+			*flags |= REF_ISBROKEN;
+		errno = EINVAL;
+		goto done;
+	}
+	ret = 0;
+	goto done;
+
+done:
+	if (needs_free)
+		free(val.mv_data);
+	return ret;
+
+}
+
+static void write_u64(char *buf, uint64_t number)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		buf[i] = (number >> (i * 8)) & 0xff;
+}
+
+static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
+{
+	unsigned char osha1[20], nsha1[20];
+	char *email_end, *message;
+	unsigned long timestamp;
+	int tz;
+
+	/* old (raw sha) new (raw sha) name <email> SP time TAB msg LF */
+	if (sb->len < 41 || sb->buf[sb->len - 1] != '\n' ||
+	    !(email_end = strchr(sb->buf + 40, '>')) ||
+	    email_end[1] != ' ')
+		return 0; /* corrupt? */
+
+	timestamp = strtoul(email_end + 2, &message, 10);
+
+	if (!timestamp ||
+	    !message || message[0] != ' ' ||
+	    (message[1] != '+' && message[1] != '-') ||
+	    !isdigit(message[2]) || !isdigit(message[3]) ||
+	    !isdigit(message[4]) || !isdigit(message[5]))
+		return 0; /* corrupt? */
+
+	hashcpy(osha1, (const unsigned char *)sb->buf);
+	hashcpy(nsha1, (const unsigned char *)sb->buf + 20);
+
+	email_end[1] = '\0';
+	tz = strtol(message + 1, NULL, 10);
+	if (message[6] != '\t')
+		message += 6;
+	else
+		message += 7;
+	return fn(osha1, nsha1, sb->buf + 40, timestamp, tz, message, cb_data);
+}
+
+static void format_reflog_entry(struct strbuf *buf,
+				const unsigned char *old_sha1,
+				const unsigned char *new_sha1,
+				const char *committer, const char *msg)
+{
+	int len;
+	int msglen;
+
+	assert(buf->len == 0);
+	strbuf_add(buf, old_sha1, 20);
+	strbuf_add(buf, new_sha1, 20);
+	strbuf_addstr(buf, committer);
+	strbuf_addch(buf, '\n');
+
+	len = buf->len;
+	msglen = msg ? strlen(msg) : 0;
+	if (msglen) {
+		int copied;
+		strbuf_grow(buf, msglen + 1);
+		copied = copy_reflog_msg(buf->buf + 40 + strlen(committer), msg) - 1;
+		buf->len = len + copied;
+		buf->buf[buf->len] = 0;
+	}
+}
+
+static int log_ref_write(const char *refname,
+			 const unsigned char *old_sha1,
+			 const unsigned char *new_sha1,
+			 const char *msg,
+			 int flags,
+			 struct strbuf *err)
+{
+	MDB_val key, val;
+	uint64_t now = getnanotime();
+	int result;
+	struct strbuf log_key = STRBUF_INIT;
+	int refname_len;
+	MDB_cursor *cursor;
+	struct strbuf buf = STRBUF_INIT;
+	const char *timestamp;
+	uint64_t zero = 0;
+
+	if (log_all_ref_updates < 0)
+		log_all_ref_updates = !is_bare_repository();
+
+	/* it is assumed that we are in a ref transaction here */
+	assert(main_transaction.txn);
+
+	result = safe_create_reflog(refname, flags & REF_FORCE_CREATE_REFLOG, err);
+	if (result)
+		return result;
+
+	/* "logs/" + refname + \0 + 8-byte timestamp for sorting and expiry. */
+	refname_len = strlen(refname);
+
+	strbuf_addf(&log_key, "logs/%s", refname);
+	strbuf_add(&log_key, &zero, 8);
+	key.mv_data = log_key.buf;
+	key.mv_size = log_key.len + 1;
+
+	mdb_cursor_open_or_die(&main_transaction, &cursor);
+
+	/* if no reflog exists, we're done */
+	if (mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE) ||
+	    strcmp(key.mv_data, log_key.buf))
+		goto done;
+
+	/* Is this a header?  We only need the header for empty reflogs */
+	timestamp = (const char *)key.mv_data + refname_len + 6;
+	if (ntohll(*(uint64_t *)timestamp) == 0)
+		mdb_cursor_del_or_die(cursor, 0);
+
+	key.mv_data = log_key.buf;
+
+	write_u64((char *)key.mv_data + refname_len + 6, htonll(now));
+
+	format_reflog_entry(&buf, old_sha1, new_sha1,
+			    git_committer_info(0), msg);
+	assert(buf.len >= 42);
+	val.mv_data = buf.buf;
+	val.mv_size = buf.len + 1;
+
+	mdb_put_or_die(&main_transaction, &key, &val, 0);
+	strbuf_release(&buf);
+
+done:
+	strbuf_release(&log_key);
+	mdb_cursor_close(cursor);
+	return 0;
+}
+
+static int lmdb_verify_refname_available(const char *refname,
+					 struct string_list *extras,
+					 struct string_list *skip,
+					 struct strbuf *err)
+{
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return verify_refname_available_txn(&main_transaction, refname, extras, skip, err);
+}
+
+/*
+ * Attempt to resolve `refname` to `old_sha1` (if old_sha1 is
+ * non-null).  The return value is a pointer to a newly-allocated
+ * string containing the next ref name that this resolves to.  So if
+ * HEAD is a symbolic ref to refs/heads/example, which is itself a
+ * symbolic ref to refs/heads/foo, return refs/heads/example,
+ * and fill in resolved_sha1 with the sha of refs/heads/foo.
+ */
+static char *check_ref(MDB_txn *txn, const char *refname,
+		       const unsigned char *old_sha1,
+		       unsigned char *resolved_sha1, int flags,
+		       int *type_p)
+{
+	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
+	int resolve_flags = 0;
+	int type;
+	char *resolved_refname;
+
+	if (mustexist)
+		resolve_flags |= RESOLVE_REF_READING;
+	if (flags & REF_DELETING) {
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
+		if (flags & REF_NODEREF)
+			resolve_flags |= RESOLVE_REF_NO_RECURSE;
+	}
+
+	/*
+	 * The first time we resolve the refname, we're just trying to
+	 * see if there is any ref at all by this name, even if it is
+	 * a broken symref.
+	 */
+	refname = resolve_ref_unsafe(refname, resolve_flags,
+				     resolved_sha1, &type);
+	if (type_p)
+		*type_p = type;
+
+	if (!refname)
+		return NULL;
+
+	/*
+	 * Need to copy refname here because the resolve_ref_unsafe
+	 * returns a pointer to a static buffer that could get mangled
+	 * by the second call.
+	 */
+	resolved_refname = xstrdup(refname);
+
+	if (old_sha1) {
+		if (flags & REF_NODEREF) {
+			resolve_flags &= ~RESOLVE_REF_NO_RECURSE;
+
+			resolve_ref_unsafe(refname, resolve_flags,
+					   resolved_sha1, &type);
+		}
+		if (hashcmp(old_sha1, resolved_sha1)) {
+			error(_("ref %s is at %s but expected %s"), refname,
+			      sha1_to_hex(resolved_sha1), sha1_to_hex(old_sha1));
+
+			return NULL;
+		}
+	}
+	return resolved_refname;
+}
+
+static int mdb_transaction_commit(struct lmdb_transaction *transaction,
+				  struct strbuf *err)
+{
+	int result;
+
+	result = mdb_txn_commit(transaction->txn);
+	if (result && err)
+		strbuf_addstr(err, mdb_strerror(result));
+
+	transaction->txn = NULL;
+	return result;
+}
+
+static void mdb_transaction_abort(struct lmdb_transaction *transaction)
+{
+	mdb_txn_abort(transaction->txn);
+	transaction->txn = NULL;
+}
+
+static int lmdb_delete_reflog(const char *refname)
+{
+	MDB_val key, val;
+	char *log_path;
+	int len;
+	MDB_cursor *cursor;
+	int ret = 0;
+	int mdb_ret;
+	struct strbuf err = STRBUF_INIT;
+	int in_transaction;
+
+	in_transaction = in_write_transaction();
+
+	log_path = xstrfmt("logs/%s", refname);
+	len = strlen(log_path) + 1;
+
+	key.mv_data = log_path;
+	key.mv_size = len;
+
+	if (!in_transaction)
+		lmdb_transaction_begin_flags_or_die(0);
+
+	mdb_cursor_open_or_die(&main_transaction, &cursor);
+
+	mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE);
+
+	while (!mdb_ret) {
+		if (key.mv_size < len)
+			break;
+
+		if (!starts_with(key.mv_data, log_path) ||
+		    ((char *)key.mv_data)[len - 1] != 0)
+			break;
+
+		mdb_cursor_del_or_die(cursor, 0);
+		mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_NEXT);
+	}
+
+	free(log_path);
+	mdb_cursor_close(cursor);
+	main_transaction.cursor = NULL;
+
+	if (!in_transaction && mdb_transaction_commit(&main_transaction, &err)) {
+		warning("%s", err.buf);
+		ret = 01;
+	}
+	strbuf_release(&err);
+	return ret;
+}
+
+#define REF_NO_REFLOG 0x8000
+
+static int lmdb_transaction_update(const char *refname,
+				   const unsigned char *new_sha1,
+				   const unsigned char *old_sha1,
+				   unsigned int flags, const char *msg,
+				   struct strbuf *err)
+{
+	const char *orig_refname = refname;
+	MDB_val key, val;
+	unsigned char resolved_sha1[20];
+	int type;
+	int ret = -1;
+
+	if ((flags & REF_HAVE_NEW) && is_null_sha1(new_sha1))
+		flags |= REF_DELETING;
+
+	if (new_sha1 && !is_null_sha1(new_sha1) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(err, _("refusing to update ref with bad name %s"),
+			    refname);
+		return TRANSACTION_GENERIC_ERROR;
+	}
+
+	refname = check_ref(main_transaction.txn, orig_refname, old_sha1,
+			    resolved_sha1, flags, &type);
+	if (refname == NULL) {
+		strbuf_addf(err, _("cannot lock the ref '%s'"), orig_refname);
+		return TRANSACTION_GENERIC_ERROR;
+	}
+
+	if (!(flags & REF_DELETING) && is_null_sha1(resolved_sha1) &&
+	    verify_refname_available_txn(&main_transaction, refname, NULL, NULL, err))
+		return TRANSACTION_NAME_CONFLICT;
+
+	if (flags & REF_NODEREF) {
+		free((void *)refname);
+		refname = orig_refname;
+	}
+
+	key.mv_size = strlen(refname) + 1;
+	key.mv_data = (void *)refname;
+
+	if ((flags & REF_HAVE_NEW) && !is_null_sha1(new_sha1)) {
+		int overwriting_symref = ((type & REF_ISSYMREF) &&
+					  (flags & REF_NODEREF));
+
+		struct object *o = parse_object(new_sha1);
+		if (!o) {
+			strbuf_addf(err,
+				    _("Trying to write ref %s with nonexistent object %s"),
+				    refname, sha1_to_hex(new_sha1));
+			goto done;
+		}
+		if (o->type != OBJ_COMMIT && is_branch(refname)) {
+			strbuf_addf(err,
+				    _("Trying to write non-commit object %s to branch %s"),
+				    sha1_to_hex(new_sha1), refname);
+			goto done;
+		}
+
+		if (!overwriting_symref
+		    && !hashcmp(resolved_sha1, new_sha1)) {
+			/*
+			 * The reference already has the desired
+			 * value, so we don't need to write it.
+			 */
+			flags |= REF_NO_REFLOG;
+		} else {
+			val.mv_size = 41;
+			if (new_sha1)
+				val.mv_data = sha1_to_hex(new_sha1);
+			else
+				val.mv_data = sha1_to_hex(null_sha1);
+			mdb_put_or_die(&main_transaction, &key, &val, 0);
+		}
+	}
+
+	if (flags & REF_DELETING) {
+		if (mdb_del_or_die(&main_transaction, &key, NULL)) {
+			if (old_sha1 && !is_null_sha1(old_sha1)) {
+				strbuf_addf(err, _("No such ref %s"), refname);
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto done;
+			}
+		}
+		lmdb_delete_reflog(orig_refname);
+	} else if (!(flags & REF_NO_REFLOG)) {
+		if (!new_sha1)
+			new_sha1 = null_sha1;
+		if (log_ref_write(orig_refname, resolved_sha1,
+				  new_sha1, msg, flags, err) < 0)
+			goto done;
+		if (strcmp(refname, orig_refname) &&
+		    log_ref_write(refname, resolved_sha1,
+				  new_sha1, msg, flags, err) < 0)
+			goto done;
+	}
+
+	ret = 0;
+done:
+	if (refname != orig_refname)
+		free((void *) refname);
+	return ret;
+}
+
+static int lmdb_transaction_commit(struct ref_transaction *ref_transaction,
+				   struct string_list *affected_refnames,
+				   struct strbuf *err)
+{
+	int ret = 0, i;
+	int n = ref_transaction->nr;
+	struct ref_update **updates = ref_transaction->updates;
+
+	/*
+	 * We might already be in a write transaction, because some
+	 * lmdb backend functionality is implemented in terms of
+	 * (other stuff) + ref_transaction_commit
+	 */
+	if (!in_write_transaction())
+		lmdb_transaction_begin_flags_or_die(0);
+
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (lmdb_transaction_update(update->refname,
+					    update->new_sha1,
+					    (update->flags & REF_HAVE_OLD) ?
+					     update->old_sha1 : NULL,
+					    update->flags,
+					    update->msg,
+					    err)) {
+			mdb_transaction_abort(&main_transaction);
+			ret = -1;
+			goto cleanup;
+		}
+
+	}
+	ret = mdb_transaction_commit(&main_transaction, err);
+
+cleanup:
+	ref_transaction->state = REF_TRANSACTION_CLOSED;
+	return ret;
+}
+
+static int rename_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *email, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+
+	const char *newrefname = cb_data;
+	MDB_val key, new_key, val;
+	struct strbuf new_key_buf = STRBUF_INIT;
+
+	assert(main_transaction.cursor);
+
+	if (mdb_cursor_get_or_die(main_transaction.cursor, &key, &val, MDB_GET_CURRENT))
+		die("BUG: renaming ref: mdb_cursor_get failed to get current");
+
+	/* This must really be a reflog entry */
+	assert(val.mv_size > 42);
+
+	strbuf_addf(&new_key_buf, "logs/%s", newrefname);
+	strbuf_add(&new_key_buf, (char *)key.mv_data + key.mv_size - 8, 8);
+
+	new_key.mv_size = new_key_buf.len + 1;
+	new_key.mv_data = new_key_buf.buf;
+	mdb_put_or_die(&main_transaction, &new_key, &val, 0);
+	mdb_cursor_del_or_die(main_transaction.cursor, 0);
+	strbuf_release(&new_key_buf);
+	return 0;
+}
+
+static int lmdb_rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	unsigned char orig_sha1[20];
+	int flag = 0, resolve_flags;
+	int log = reflog_exists(oldref);
+	const char *symref = NULL;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *ref_transaction;
+
+	if (!strcmp(oldref, newref))
+		return 0;
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	ref_transaction = ref_transaction_begin(&err);
+	if (!ref_transaction)
+		die("%s", err.buf);
+
+	resolve_flags = RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE;
+	symref = resolve_ref_unsafe(oldref, resolve_flags,
+				    orig_sha1, &flag);
+	if (flag & REF_ISSYMREF) {
+		error(_("refname %s is a symbolic ref, renaming it is not supported"),
+		      oldref);
+		goto fail;
+	}
+	if (!symref) {
+		mdb_transaction_abort(&main_transaction);
+		error(_("refname %s not found"), oldref);
+		goto fail;
+	}
+	if (!rename_ref_available(oldref, newref))
+		goto fail;
+
+	/* Copy the reflog from the old to the new */
+	if (log) {
+		struct strbuf old_log_sentinel = STRBUF_INIT;
+		MDB_val key;
+		int log_all;
+
+		log_all = log_all_ref_updates;
+		log_all_ref_updates = 1;
+		if (safe_create_reflog(newref, 0, &err)) {
+			error(_("can't create reflog for %s: %s"), newref, err.buf);
+			strbuf_release(&err);
+			goto fail;
+		}
+		log_all_ref_updates = log_all;
+
+		for_each_reflog_ent(oldref, rename_reflog_ent, (void *)newref);
+		strbuf_addf(&old_log_sentinel, "logs/%sxxxxxxxx", oldref);
+		memset(old_log_sentinel.buf + old_log_sentinel.len - 8, 0, 8);
+
+		key.mv_size = old_log_sentinel.len;
+		key.mv_data = old_log_sentinel.buf;
+
+		/* It's OK if the old reflog is missing */
+		mdb_del_or_die(&main_transaction, &key, NULL);
+		strbuf_release(&old_log_sentinel);
+	}
+
+	if (ref_transaction_delete(ref_transaction, oldref,
+				   orig_sha1, REF_NODEREF, NULL, &err)) {
+		error(_("unable to delete old %s"), oldref);
+		goto fail;
+	}
+
+	if (ref_transaction_update(ref_transaction, newref, orig_sha1, NULL,
+				    REF_NODEREF, logmsg, &err)) {
+		error("%s", err.buf);
+		goto fail;
+	}
+
+	if (ref_transaction_commit(ref_transaction, &err)) {
+		error("%s", err.buf);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	ref_transaction_free(ref_transaction);
+	strbuf_release(&err);
+	mdb_transaction_abort(&main_transaction);
+	main_transaction.txn = NULL;
+	return 1;
+}
+
+static int lmdb_delete_refs(struct string_list *refnames)
+{
+	int i;
+	struct strbuf err = STRBUF_INIT;
+	int result = 0;
+
+	if (!refnames->nr)
+		return 0;
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	for (i = 0; i < refnames->nr; i++) {
+		const char *refname = refnames->items[i].string;
+
+		if (lmdb_transaction_update(refname, null_sha1, NULL,
+					    REF_DELETING, NULL, &err))
+			result |= error(_("could not remove reference %s: %s"),
+					refname, err.buf);
+	}
+
+	result |= mdb_transaction_commit(&main_transaction, &err);
+	strbuf_release(&err);
+	return 0;
+}
+
+static int lmdb_for_each_reflog_ent_order(const char *refname,
+					  each_reflog_ent_fn fn,
+					  void *cb_data, int reverse)
+{
+	MDB_val key, val;
+	char *search_key;
+	char *log_path;
+	int len;
+	MDB_cursor *cursor;
+	int ret = 0;
+	struct strbuf sb = STRBUF_INIT;
+	enum MDB_cursor_op direction = reverse ? MDB_PREV : MDB_NEXT;
+	uint64_t zero = 0ULL;
+
+	log_path = xstrfmt("logs/%s", refname);
+	len = strlen(log_path) + 1;
+
+	if (reverse) {
+		/*
+		 * For a reverse search, start at the key
+		 * lexicographically after the searched-for key.
+		 * That's the one with \1 appended to the key.
+		 */
+		search_key = xstrfmt("%s\1", log_path);
+		key.mv_size = len + 1;
+	} else {
+		search_key = xstrdup(log_path);
+		key.mv_size = len;
+	}
+
+	key.mv_data = search_key;
+
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+
+	mdb_cursor_open_or_die(&main_transaction, &cursor);
+
+	main_transaction.cursor = cursor;
+
+	/*
+	 * MDB's cursor API requires that the first mdb_cursor_get be
+	 * called with MDB_SET_RANGE.  For reverse searches, this will
+	 * give us the entry one-past the entry we're looking for, so
+	 * we should jump back using MDB_PREV.
+	 */
+	mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE);
+	if (direction == MDB_PREV)
+		mdb_cursor_get_or_die(cursor, &key, &val, direction);
+
+	do {
+		if (key.mv_size < len)
+			break;
+
+		if (!starts_with(key.mv_data, log_path) || ((char *)key.mv_data)[len - 1] != 0)
+			break;
+
+		if (!memcmp(&zero, ((char *)key.mv_data) + key.mv_size - 8, 8))
+			continue;
+
+		assert(val.mv_size != 0);
+
+		strbuf_add(&sb, val.mv_data, val.mv_size - 1);
+		ret = show_one_reflog_ent(&sb, fn, cb_data);
+		if (ret)
+			break;
+
+		strbuf_reset(&sb);
+	} while (!mdb_cursor_get_or_die(cursor, &key, &val, direction));
+
+	strbuf_release(&sb);
+	free(log_path);
+	free(search_key);
+	mdb_cursor_close(cursor);
+	return ret;
+}
+
+static int lmdb_for_each_reflog_ent(const char *refname,
+				    each_reflog_ent_fn fn,
+				    void *cb_data)
+{
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return refs_be_files.for_each_reflog_ent(refname, fn, cb_data);
+	return lmdb_for_each_reflog_ent_order(refname, fn, cb_data, 0);
+}
+
+static int lmdb_for_each_reflog_ent_reverse(const char *refname,
+					    each_reflog_ent_fn fn,
+					    void *cb_data)
+{
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return refs_be_files.for_each_reflog_ent_reverse(refname, fn, cb_data);
+	return lmdb_for_each_reflog_ent_order(refname, fn, cb_data, 1);
+}
+
+static int lmdb_reflog_exists(const char *refname)
+{
+	MDB_val key, val;
+	char *log_path;
+	int len;
+	MDB_cursor *cursor;
+	int ret = 1;
+
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return refs_be_files.reflog_exists(refname);
+
+	log_path = xstrfmt("logs/%s", refname);
+	len = strlen(log_path) + 1;
+
+	key.mv_data = log_path;
+	key.mv_size = len;
+
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	mdb_cursor_open_or_die(&main_transaction, &cursor);
+
+	if (mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE) ||
+	    !starts_with(key.mv_data, log_path))
+		ret = 0;
+
+	free(log_path);
+	mdb_cursor_close(cursor);
+
+	return ret;
+}
+
+struct wrapped_each_ref_fn {
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
+static int check_reflog(const char *refname,
+			const struct object_id *oid, int flags, void *cb_data)
+{
+	struct wrapped_each_ref_fn *wrapped = cb_data;
+
+	if (reflog_exists(refname))
+		return wrapped->fn(refname, oid, 0, wrapped->cb_data);
+
+	return 0;
+}
+
+static int lmdb_for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	struct wrapped_each_ref_fn wrapped = {fn, cb_data};
+	int result = head_ref(fn, cb_data);
+	if (result)
+		return result;
+	return for_each_ref(check_reflog, &wrapped);
+}
+
+static void strbuf_reflog_header(struct strbuf *sb, const char *refname)
+{
+	uint64_t zero = 0;
+
+	strbuf_addf(sb, "logs/%s", refname);
+	strbuf_add(sb, &zero, 8);
+}
+
+static int lmdb_create_reflog(const char *refname, int force_create, struct strbuf *err)
+{
+	/*
+	 * We mark that there is a reflog by creating a key of the
+	 * form logs/$refname followed by nine \0 (one for
+	 * string-termination, 8 in lieu of a timestamp), with an empty
+	 * value.
+	 */
+
+	int in_transaction = in_write_transaction();
+	MDB_val key, val;
+	struct strbuf key_buf = STRBUF_INIT;
+
+	if (!force_create && !should_autocreate_reflog(refname))
+		return 0;
+
+	if (!in_transaction)
+		lmdb_transaction_begin_flags_or_die(0);
+
+	strbuf_reflog_header(&key_buf, refname);
+	key.mv_size = key_buf.len + 1;
+	key.mv_data = key_buf.buf;
+
+	val.mv_size = 0;
+	val.mv_data = NULL;
+	mdb_put_or_die(&main_transaction, &key, &val, 0);
+
+	strbuf_release(&key_buf);
+	if (!in_transaction)
+		return mdb_transaction_commit(&main_transaction, err);
+	return 0;
+}
+
+struct expire_reflog_cb {
+	unsigned int flags;
+	reflog_expiry_should_prune_fn *should_prune_fn;
+	void *policy_cb;
+	unsigned char last_kept_sha1[20];
+};
+
+static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+			     const char *email, unsigned long timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
+
+	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
+		osha1 = cb->last_kept_sha1;
+
+	if ((*cb->should_prune_fn)(osha1, nsha1, email, timestamp, tz,
+				   message, policy_cb)) {
+		if (cb->flags & EXPIRE_REFLOGS_DRY_RUN)
+			printf("would prune %s", message);
+		else {
+			if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
+				printf("prune %s", message);
+
+			mdb_cursor_del_or_die(main_transaction.cursor, 0);
+		}
+	} else {
+		hashcpy(cb->last_kept_sha1, nsha1);
+		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
+			printf("keep %s", message);
+	}
+	return 0;
+}
+
+static int write_ref(const char *refname, const unsigned char *sha1)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	if (ref_transaction_update(transaction, refname, sha1, NULL,
+				   REF_NO_REFLOG, NULL, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	if (ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int lmdb_reflog_expire(const char *refname, const unsigned char *sha1,
+			      unsigned int flags,
+			      reflog_expiry_prepare_fn prepare_fn,
+			      reflog_expiry_should_prune_fn should_prune_fn,
+			      reflog_expiry_cleanup_fn cleanup_fn,
+			      void *policy_cb_data)
+{
+	struct expire_reflog_cb cb;
+	int dry_run = flags & EXPIRE_REFLOGS_DRY_RUN;
+	int status = 0;
+	struct strbuf err = STRBUF_INIT;
+	unsigned char resolved_sha1[20];
+	int type;
+	char *resolved;
+
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return refs_be_files.reflog_expire(refname, sha1, flags, prepare_fn,
+					       should_prune_fn, cleanup_fn,
+					       policy_cb_data);
+
+	memset(&cb, 0, sizeof(cb));
+	cb.flags = flags;
+	cb.policy_cb = policy_cb_data;
+	cb.should_prune_fn = should_prune_fn;
+
+	lmdb_transaction_begin_flags_or_die(dry_run ? MDB_RDONLY : 0);
+
+	resolved = check_ref(main_transaction.txn, refname, sha1,
+			     resolved_sha1, 0, &type);
+	if (!resolved)
+		die(_("Failed to resolve %s"), refname);
+	free(resolved);
+
+	(*prepare_fn)(refname, sha1, cb.policy_cb);
+	lmdb_for_each_reflog_ent(refname, expire_reflog_ent, &cb);
+	(*cleanup_fn)(cb.policy_cb);
+
+	if (!dry_run) {
+		/*
+		 * It doesn't make sense to adjust a reference pointed
+		 * to by a symbolic ref based on expiring entries in
+		 * the symbolic reference's reflog. Nor can we update
+		 * a reference if there are no remaining reflog
+		 * entries.
+		 */
+		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+			!(type & REF_ISSYMREF) &&
+			!is_null_sha1(cb.last_kept_sha1);
+
+		if (mdb_transaction_commit(&main_transaction, &err)) {
+			status |= error(_("couldn't write logs/%s: %s"),
+					refname, err.buf);
+			strbuf_release(&err);
+		} else if (update && write_ref(refname, cb.last_kept_sha1)) {
+			status |= error(_("couldn't set %s"),
+					refname);
+		}
+	}
+	return status;
+}
+
+static int lmdb_pack_refs(unsigned int flags)
+{
+	/* This concept does not exist in this backend. */
+	return 0;
+}
+
+static int lmdb_peel_ref(const char *refname, unsigned char *sha1)
+{
+	int flag;
+	unsigned char base[20];
+
+	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
+		return -1;
+
+	return peel_object(base, sha1);
+}
+
+static int lmdb_create_symref(const char *ref_target,
+			      const char *refs_heads_master,
+			      const char *logmsg)
+{
+
+	struct strbuf err = STRBUF_INIT;
+	unsigned char old_sha1[20], new_sha1[20];
+	MDB_val key, val;
+	char *valdata;
+	int ret = 0;
+	int in_transaction;
+
+	in_transaction = in_write_transaction();
+
+	if (logmsg && read_ref(ref_target, old_sha1))
+		hashclr(old_sha1);
+
+	key.mv_size = strlen(ref_target) + 1;
+	key.mv_data = xstrdup(ref_target);
+
+	valdata = xstrfmt("ref: %s", refs_heads_master);
+	val.mv_data = valdata;
+	val.mv_size = strlen(valdata) + 1;
+
+	if (!in_transaction)
+		lmdb_transaction_begin_flags_or_die(0);
+
+	mdb_put_or_die(&main_transaction, &key, &val, 0);
+
+	/* TODO: Don't create ref d/f conflicts */
+
+	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
+	    log_ref_write(ref_target, old_sha1, new_sha1, logmsg, 0, &err)) {
+		error(_("create_symref: log_ref_write failed: %s"), err.buf);
+		ret = -1;
+		goto done;
+	}
+
+	if (!in_transaction && mdb_transaction_commit(&main_transaction, &err)) {
+		error(_("create_symref: commit failed: %s"), err.buf);
+		ret = -1;
+	}
+
+done:
+	strbuf_release(&err);
+	free(key.mv_data);
+	free(valdata);
+
+	return ret;
+}
+
+static int lmdb_resolve_gitlink_ref(const char *submodule, const char *refname,
+				    unsigned char *sha1)
+{
+	static struct strbuf sb_refname = STRBUF_INIT;
+	struct strbuf sb_path = STRBUF_INIT;
+	const char *ret;
+
+	ret = resolve_ref_unsafe_submodule(submodule, refname,
+					   RESOLVE_REF_READING, sha1,
+					   NULL, &sb_refname, &sb_path);
+	strbuf_release(&sb_path);
+	strbuf_release(&sb_refname);
+	return ret ? 0 : -1;
+}
+
+/*
+ * Call fn for each reference for which the refname begins with base.
+ * If trim is non-zero, then trim that many characters off the
+ * beginning of each refname before passing the refname to fn.  flags
+ * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
+ * the iteration.  If fn ever returns a non-zero value, stop the
+ * iteration and return that value; otherwise, return 0.
+ */
+static int lmdb_do_for_each_ref(const char *submodule, const char *base,
+				each_ref_fn fn, int trim, int flags,
+				void *cb_data)
+{
+
+	MDB_val key, val;
+	MDB_cursor *cursor;
+	int baselen;
+	char *search_key;
+	int retval;
+	int mdb_ret;
+	struct lmdb_transaction *transaction;
+
+	retval = do_for_each_per_worktree_ref(submodule, base, fn,
+					      trim, flags, cb_data);
+	if (retval)
+		return retval;
+
+	if (ref_paranoia < 0)
+		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
+	if (ref_paranoia)
+		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
+
+	if (!base || !*base) {
+		base = "refs/";
+		trim = 0;
+	}
+
+	transaction = get_submodule_transaction(submodule);
+
+	search_key = xstrdup(base);
+	baselen = strlen(base);
+	key.mv_size = baselen + 1;
+	key.mv_data = search_key;
+
+	mdb_cursor_open_or_die(transaction, &cursor);
+
+	mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE);
+
+	while (!mdb_ret) {
+		struct object_id oid;
+		int parsed_flags = 0;
+		const char *refname;
+		struct strbuf sb_refname = STRBUF_INIT;
+		struct strbuf sb_path = STRBUF_INIT;
+
+		if (memcmp(key.mv_data, base, baselen))
+			break;
+
+		refname = (const char *)key.mv_data;
+		resolve_ref_unsafe_submodule(submodule, refname, 0, oid.hash,
+					     &parsed_flags, &sb_refname,
+					     &sb_path);
+		if (!(parsed_flags & REF_ISBROKEN) && is_null_oid(&oid))
+			parsed_flags |= REF_ISBROKEN;
+
+		strbuf_release(&sb_path);
+		strbuf_release(&sb_refname);
+
+		if (flags & DO_FOR_EACH_INCLUDE_BROKEN ||
+		    (!(parsed_flags & REF_ISBROKEN) &&
+		     has_sha1_file(oid.hash))) {
+			retval = fn(refname + (trim ? baselen : 0), &oid, parsed_flags, cb_data);
+			if (retval)
+				break;
+		}
+
+		mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_NEXT);
+	}
+
+	mdb_cursor_close(cursor);
+	free(search_key);
+
+	if (submodule) {
+		MDB_env *env = mdb_txn_env(transaction->txn);
+		mdb_transaction_abort(transaction);
+		mdb_env_close(env);
+	}
+	return retval;
+}
+
+/* For testing only! */
+int test_refdb_raw_read(const char *key)
+{
+	MDB_val key_val, val;
+	char *keydup;
+	int ret;
+	int needs_free = 0;
+
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	keydup = xstrdup(key);
+	key_val.mv_data = keydup;
+	key_val.mv_size = strlen(key) + 1;
+
+	ret = mdb_get_or_die(&main_transaction, &key_val, &val, &needs_free);
+	free(keydup);
+	switch (ret) {
+	case 0:
+		printf("%s\n", (char *)val.mv_data);
+		return 0;
+	case MDB_NOTFOUND:
+		fprintf(stderr, "%s not found\n", key);
+		return 1;
+	default:
+		return 2;
+	}
+	if (needs_free)
+		free(val.mv_data);
+}
+
+/* For testing only! */
+void test_refdb_raw_write(const char *key, const char *value)
+{
+	MDB_val key_val, val;
+	char *keydup, *valdup;
+
+	if (ref_type(key) != REF_TYPE_NORMAL) {
+		val.mv_data = (void *)value;
+		val.mv_size = strlen(value) + 1;
+		write_per_worktree_ref(NULL, key, &val);
+		return;
+	}
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	keydup = xstrdup(key);
+	key_val.mv_data = keydup;
+	key_val.mv_size = strlen(key) + 1;
+
+	valdup = xstrdup(value);
+	val.mv_data = valdup;
+	val.mv_size = strlen(value) + 1;
+
+	mdb_put_or_die(&main_transaction, &key_val, &val, 0);
+	assert(mdb_transaction_commit(&main_transaction, NULL) == 0);
+
+	free(keydup);
+	free(valdup);
+}
+
+/* For testing only! */
+int test_refdb_raw_delete(const char *key)
+{
+	MDB_val key_val;
+	char *keydup;
+	int ret;
+
+	if (ref_type(key) != REF_TYPE_NORMAL)
+		return del_per_worktree_ref(NULL, key, NULL);
+
+	lmdb_transaction_begin_flags_or_die(0);
+	keydup = xstrdup(key);
+	key_val.mv_data = keydup;
+	key_val.mv_size = strlen(key) + 1;
+
+	ret = mdb_del_or_die(&main_transaction, &key_val, NULL);
+
+	assert(mdb_transaction_commit(&main_transaction, NULL) == 0);
+
+	free(keydup);
+	return ret;
+}
+
+static int print_raw_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+				const char *email, unsigned long timestamp,
+				int tz, const char *message, void *cb_data)
+{
+	int *any = cb_data;
+	*any = 1;
+
+	if (*message != '\n')
+		printf("%s %s %s %lu %+05d\t%s", sha1_to_hex(osha1),
+		       sha1_to_hex(nsha1),
+		       email, timestamp, tz, message);
+	else
+		printf("%s %s %s %lu %+05d\n", sha1_to_hex(osha1),
+		       sha1_to_hex(nsha1),
+		       email, timestamp, tz);
+	return 0;
+}
+
+/* For testing only! */
+int test_refdb_raw_reflog(const char *refname)
+{
+	int any = 0;
+
+	for_each_reflog_ent(refname, print_raw_reflog_ent, &any);
+
+	return !any;
+}
+
+/* For testing only! */
+void test_refdb_raw_delete_reflog(char *refname)
+{
+	MDB_val key, val;
+	int mdb_ret;
+	char *search_key;
+	MDB_cursor *cursor;
+	int len;
+
+	search_key = xstrfmt("logs/%s", refname ? refname : "");
+	len = strlen(search_key) + 1;
+
+	key.mv_data = search_key;
+	key.mv_size = len;
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	mdb_cursor_open_or_die(&main_transaction, &cursor);
+
+	mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE);
+	while (!mdb_ret) {
+		if (!starts_with(key.mv_data, search_key))
+			break;
+		if (refname && ((char *)val.mv_data)[len - 1] == 0)
+			break;
+
+		mdb_cursor_del_or_die(cursor, 0);
+		mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_NEXT);
+	}
+
+	free(search_key);
+	mdb_cursor_close(cursor);
+
+	assert(mdb_transaction_commit(&main_transaction, NULL) == 0);
+	return;
+}
+
+static void format_lmdb_reflog_ent(struct strbuf *dst, struct strbuf *src)
+{
+	unsigned char osha1[20], nsha1[20];
+	const char *msg;
+
+	get_sha1_hex(src->buf, osha1);
+	get_sha1_hex(src->buf + 41, nsha1);
+
+	msg = strchr(src->buf + 82, '\t');
+	if (msg)
+		msg += 1;
+
+	format_reflog_entry(dst, osha1, nsha1, src->buf + 82, msg);
+}
+
+/* For testing only! */
+void test_refdb_raw_append_reflog(const char *refname)
+{
+	struct strbuf input = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	uint64_t now = getnanotime();
+	MDB_val key, val;
+	struct strbuf key_buf = STRBUF_INIT;
+
+	strbuf_reflog_header(&key_buf, refname);
+	key.mv_size = key_buf.len + 1;
+	key.mv_data = key_buf.buf;
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	/* We do not remove the header entry here, because this is
+	 * just for tests, so it's OK to be a bit inefficient */
+
+	while (strbuf_getline(&input, stdin) != EOF) {
+		/* "logs/" + \0 + 8-byte timestamp for sorting and expiry */
+		write_u64((char *)key.mv_data + key.mv_size - 8, htonll(now++));
+
+		/*
+		 * Convert the input from files-reflog format to
+		 * lmdb-reflog-format
+		 */
+
+		format_lmdb_reflog_ent(&sb, &input);
+		val.mv_data = sb.buf;
+		val.mv_size = sb.len + 1;
+		mdb_put_or_die(&main_transaction, &key, &val, 0);
+		strbuf_reset(&sb);
+		input.len = 0;
+	}
+
+	strbuf_release(&input);
+	strbuf_release(&sb);
+	assert(mdb_transaction_commit(&main_transaction, NULL) == 0);
+	strbuf_release(&key_buf);
+}
+
+struct ref_storage_be refs_be_lmdb = {
+	NULL,
+	"lmdb",
+	lmdb_init_db,
+	lmdb_transaction_commit,
+	lmdb_transaction_commit, /* initial commit */
+
+	lmdb_for_each_reflog_ent,
+	lmdb_for_each_reflog_ent_reverse,
+	lmdb_for_each_reflog,
+	lmdb_reflog_exists,
+	lmdb_create_reflog,
+	lmdb_delete_reflog,
+	lmdb_reflog_expire,
+
+	lmdb_pack_refs,
+	lmdb_peel_ref,
+	lmdb_create_symref,
+	lmdb_delete_refs,
+	lmdb_rename_ref,
+
+	lmdb_read_raw_ref,
+	lmdb_verify_refname_available,
+	lmdb_resolve_gitlink_ref,
+
+	lmdb_do_for_each_ref,
+};
diff --git a/test-refs-lmdb-backend.c b/test-refs-lmdb-backend.c
new file mode 100644
index 0000000..f1b18c3
--- /dev/null
+++ b/test-refs-lmdb-backend.c
@@ -0,0 +1,66 @@
+#include "cache.h"
+#include "string-list.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "refs/refs-internal.h"
+
+static const char * const test_refs_be_lmdb_usage[] = {
+	"git test-refs-lmdb-backend <key>",
+	"git test-refs-lmdb-backend <key> <value>",
+	NULL,
+};
+
+int test_refdb_raw_read(const char *key);
+void test_refdb_raw_write(const char *key, const char *value);
+int test_refdb_raw_reflog(const char *refname);
+int test_refdb_raw_delete(const char *key);
+void test_refdb_raw_delete_reflog(const char *refname);
+void test_refdb_raw_append_reflog(const char *refname);
+
+int main(int argc, const char **argv)
+{
+	const char *delete = NULL;
+	const char *reflog = NULL;
+	const char *append_reflog = NULL;
+	int delete_missing_error = 0;
+	int clear_reflog = 0;
+
+	struct option options[] = {
+		OPT_STRING('d', NULL, &delete, "branch", "delete refdb entry"),
+		OPT_STRING('l', NULL, &reflog, "branch", "show reflog"),
+		OPT_STRING('a', NULL, &append_reflog, "branch", "append to reflog"),
+		OPT_BOOL('c', NULL, &clear_reflog, "delete reflog. If a branch is provided, the reflog for that branch will be deleted; else all reflogs will be deleted."),
+		OPT_BOOL('x', NULL, &delete_missing_error,
+			 "deleting a missing key is an error"),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, "", options, test_refs_be_lmdb_usage,
+			     0);
+
+	if (!append_reflog && !clear_reflog && !delete && !reflog && argc != 1 && argc != 2)
+		usage_with_options(test_refs_be_lmdb_usage,
+				   options);
+
+	setup_git_directory();
+	git_config(git_default_config, NULL);
+
+	if (set_ref_storage_backend("lmdb"))
+		die("could not set lmdb reference backend");
+
+	if (clear_reflog) {
+		test_refdb_raw_delete_reflog(argv[0]);
+	} else if (append_reflog) {
+		test_refdb_raw_append_reflog(append_reflog);
+	} else if (reflog) {
+		return test_refdb_raw_reflog(reflog);
+	} else if (delete) {
+		if (test_refdb_raw_delete(delete) && delete_missing_error)
+			return 1;
+	} else if (argc == 1) {
+		return test_refdb_raw_read(argv[0]);
+	} else {
+		test_refdb_raw_write(argv[0], argv[1]);
+	}
+	return 0;
+}
-- 
2.4.2.767.g62658d5-twtrsrc
