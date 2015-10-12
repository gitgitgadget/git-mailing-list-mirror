From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 43/44] refs: add LMDB refs backend
Date: Mon, 12 Oct 2015 17:52:04 -0400
Message-ID: <1444686725-27660-45-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll20-0005Cx-8k
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbbJLVxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:09 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36632 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbJLVxB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:53:01 -0400
Received: by qgx61 with SMTP id 61so129602218qgx.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vIzTFh/oCoXW/rkNAL0hTRqwCGaevRDfBpfFYuNEwco=;
        b=PyJm+Ur8ig6aGDQrtLnpnkufY6QCj4TXS3K9GuVKWl7AOVL9hKC+y6BDUZ4zoHTU4I
         I8P8p7bn06OSzFHW/tjw2e/tyf6P8VbSAgjvNcuWg+QsM2Le4RWS+bWTSM2eHFvJCvZx
         BmnRwncfDUt911jNGZT5QDk4aSLWa7TEYZePprQy9mqdQ2FshAf5DH5HvBqafCjiRWlK
         mDSPAuajwJ1jaTP5oHiLwSCJvaG36copmcUEyYKivKu5u/5qhkVm14NV5c6CB2Wdz65r
         J9lQrGx87sVw8Ko91IKskS/79TaUGXFtoPX/9jfpdIg9Aw48PtkUQNwK8rjiAOrRlfeb
         4x0Q==
X-Gm-Message-State: ALoCoQmRBJHc8za75+dIw8rUgvlAJausbsbMhCvU1mCo8qaWEQd+0+WFeC62/k9YDotPrWD59LS7
X-Received: by 10.140.236.144 with SMTP id h138mr36948121qhc.78.1444686780899;
        Mon, 12 Oct 2015 14:53:00 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:59 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279443>

Add a database backend for refs using LMDB.  This backend runs git
for-each-ref about 30% faster than the files backend with fully-packed
refs on a repo with ~120k refs.  It's also about 4x faster than using
fully-unpacked refs.  In addition, and perhaps more importantly , it
avoids case-conflict issues on OS X.

LMDB has a few features that make it suitable for usage in git:

1. It is relatively lightweight; it requires only one header file, and
the library code takes under 64k at runtime.

2. It is well-tested: it's been used in OpenLDAP for years.

3. It's very fast.  LMDB's benchmarks show that it is among
the fastest key-value stores.

4. It has a relatively simple concurrency story; readers don't
block writers and writers don't block readers.

Ronnie Sahlberg's original version of this patchset used tdb.  The
major disadvantage of tdb is that tdb is hard to build on OS X.  It's
also not in homebrew.  So lmdb seemed simpler.

To test this backend's correctness, I hacked test-lib.sh and
test-lib-functions.sh to run all tests under the refs backend. Dozens
of tests use manual ref/reflog reading/writing, or create submodules
without passing --refs-backend-type to git init.  If those tests are
changed to use the update-ref machinery or test-refs-be-db (or, in the
case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
the only remaining failing tests are the git-new-workdir tests and the
gitweb tests.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 .gitignore                                     |    1 +
 Documentation/config.txt                       |    7 +
 Documentation/git-clone.txt                    |    2 +-
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    6 +
 Documentation/technical/refs-be-lmdb.txt       |   50 +
 Documentation/technical/repository-version.txt |    5 +
 Makefile                                       |   12 +
 builtin/clone.c                                |    2 +-
 builtin/init-db.c                              |   20 +-
 config.c                                       |   34 +
 configure.ac                                   |   33 +
 contrib/workdir/git-new-workdir                |    3 +
 environment.c                                  |    1 +
 refs-be-lmdb.c                                 | 1997 ++++++++++++++++++++++++
 refs.h                                         |   10 +
 setup.c                                        |   32 +-
 test-refs-be-lmdb.c                            |   68 +
 18 files changed, 2275 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/technical/refs-be-lmdb.txt
 create mode 100644 refs-be-lmdb.c
 create mode 100644 test-refs-be-lmdb.c

diff --git a/.gitignore b/.gitignore
index 1c2f832..7decc2f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -199,6 +199,7 @@
 /test-path-utils
 /test-prio-queue
 /test-read-cache
+/test-refs-be-lmdb
 /test-regex
 /test-revision-walking
 /test-run-command
diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab57276..eccfdb6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -496,6 +496,13 @@ core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
 	version.
 
+core.refsBackendType::
+	Type of refs backend. Default is to use the original files
+	based backend. Set to 'lmdb' to activate the lmdb database
+	backend.  If you use the lmdb backend,
+	core.repositoryFormatVersion must be set to 1, and
+	extensions.refBackend must be set to 'lmdb'.
+
 core.sharedRepository::
 	When 'group' (or 'true'), the repository is made shareable between
 	several users in a group (making sure all the files and objects are
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d7a4cb0..6a4cf28 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -219,7 +219,7 @@ objects from the source repository into a pack in the cloned repository.
 
 --refs-backend-type=<name>::
 	Type of refs backend. Default is to use the original files based
-	backend.
+	backend. Set to "lmdb" to activate the lmdb database backend.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..72fbd71 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--refs-backend-type=<name>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..d352788 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>]
 	  [--shared[=<permissions>]] [directory]
+	  [--refs-backend-type=<name>]
 
 
 DESCRIPTION
@@ -113,6 +114,11 @@ does not exist, it will be created.
 
 --
 
+--refs-backend-type=<name>::
+Type of refs backend. Default is to use the original "files" backend,
+which stores ref data in files in .git/refs and .git/packed-refs.  Set
+to "lmdb" to activate the lmdb database backend.
+
 TEMPLATE DIRECTORY
 ------------------
 
diff --git a/Documentation/technical/refs-be-lmdb.txt b/Documentation/technical/refs-be-lmdb.txt
new file mode 100644
index 0000000..c497ffc
--- /dev/null
+++ b/Documentation/technical/refs-be-lmdb.txt
@@ -0,0 +1,50 @@
+Notes on the LMDB refs backend
+==============================
+
+Design:
+------
+
+Refs and reflogs are stored in a lmdb database in .git/refdb.  All
+keys and values are \0-terminated.
+
+Keys for refs are the name of the ref (e.g. refs/heads/master).
+Values are the value of the ref, in hex
+(e.g. 61f23eb0f81357c19fa91e2b8c6f3906c3a8f9b0).
+
+All per-worktree refs (refs/bisect/* and HEAD) are store using
+the traditional files-based backend.
+
+Reflogs are stored as a series of database entries.
+
+For non-empty reflogs, there is one entry per logged ref
+update.  The key format is logs/[refname]\0[timestamp].  The timestamp
+is a 64-bit unsigned integer number of nanoseconds since 1/1/1970.
+This means that reflog entries are chronologically ordered.  Because
+LMDB is a btree database, we can efficiently iterate over these keys.
+
+For an empty reflog, there is a "header" entry to show that a reflog
+exists.  The header has the same format as an ordinary reflog, but with
+a timeztamp of all zeros and an empty value.
+
+Reflog values are in the same format as the original files-based
+reflog.
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
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 3d7106d..04d457d 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -79,3 +79,8 @@ The defined extensions are:
 
 This extension does not change git's behavior at all. It is useful only
 for testing format-1 compatibility.
+
+`refbackend`
+
+This extension allows the user of alternate ref backends.  The only
+defined value is `lmdb`.
diff --git a/Makefile b/Makefile
index 43ceab0..e96f84b 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,6 +1036,17 @@ ifdef USE_LIBPCRE
 	EXTLIBS += -lpcre
 endif
 
+ifdef USE_LIBLMDB
+	BASIC_CFLAGS += -DUSE_LIBLMDB
+	ifdef LIBLMDBDIR
+		BASIC_CFLAGS += -I$(LIBLMDBDIR)/include
+		EXTLIBS += -L$(LIBLMDBDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBLMDBDIR)/$(lib)
+	endif
+	EXTLIBS += -llmdb
+	LIB_OBJS += refs-be-lmdb.o
+	TEST_PROGRAMS_NEED_X += test-refs-be-lmdb
+endif
+
 ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
@@ -2122,6 +2133,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo USE_LIBLMDB=\''$(subst ','\'',$(subst ','\'',$(USE_LIBLMDB)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
diff --git a/builtin/clone.c b/builtin/clone.c
index d489a87..c0f482c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -764,7 +764,7 @@ static void write_config(struct string_list *config)
 	}
 
 	if (refs_backend_type &&
-	    write_one_config("core.refs-backend-type",
+	    write_one_config("core.refsBackendType",
 			     refs_backend_type, NULL) < 0)
 			die("unable to write backend parameter to config file");
 }
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2705739..0483e2d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -179,6 +179,7 @@ static int create_default_files(const char *template_path)
 	int reinit;
 	int filemode;
 	struct strbuf err = STRBUF_INIT;
+	int repo_version = 0;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -204,6 +205,21 @@ static int create_default_files(const char *template_path)
 		adjust_shared_perm(get_git_dir());
 	}
 
+	if (refs_backend_type) {
+		struct refdb_config_data config_data = {NULL};
+		git_config_set("core.refsBackendType", refs_backend_type);
+		config_data.refs_backend_type = refs_backend_type;
+		config_data.refs_base = get_git_dir();
+#ifdef USE_LIBLMDB
+		register_refs_backend(&refs_be_lmdb);
+#endif
+		set_refs_backend(refs_backend_type, &config_data);
+		if (!strcmp(refs_backend_type, "lmdb")) {
+			git_config_set("extensions.refbackend", "lmdb");
+			repo_version = 1;
+		}
+	}
+
 	if (refs_initdb(&err, shared_repository))
 		die("failed to set up refs db: %s", err.buf);
 
@@ -221,7 +237,7 @@ static int create_default_files(const char *template_path)
 
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
+		  "%d", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	/* Check filemode trustability */
@@ -469,6 +485,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "refs-backend-type", &refs_backend_type,
+			   N_("name"), N_("name of backend type to use")),
 		OPT_END()
 	};
 
diff --git a/config.c b/config.c
index 248a21a..c17c7b9 100644
--- a/config.c
+++ b/config.c
@@ -10,6 +10,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "refs.h"
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
@@ -1207,6 +1208,39 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	}
 
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+		struct refdb_config_data refdb_data = {NULL};
+		char *repo_config_copy;
+
+		/*
+		 * make sure we always read the backend config from the
+		 * core section on startup
+		 */
+		ret += git_config_from_file(refdb_config, repo_config,
+					    &refdb_data);
+
+		repo_config_copy = xstrdup(repo_config);
+		refdb_data.refs_base = strdup(dirname(repo_config_copy));
+		free(repo_config_copy);
+
+		if (!refdb_data.refs_backend_type)
+			refdb_data.refs_backend_type = "";
+
+		if ((!*refdb_data.refs_backend_type) ||
+		    (!strcmp(refdb_data.refs_backend_type, "files"))) {
+			/* default backend, nothing to do */
+		} else if (!strcmp(refdb_data.refs_backend_type, "lmdb")) {
+
+#ifdef USE_LIBLMDB
+			refs_backend_type = refdb_data.refs_backend_type;
+			register_refs_backend(&refs_be_lmdb);
+			set_refs_backend(refs_backend_type, &refdb_data);
+#else
+			die("Git was not built with USE_LIBLMDB, so the db refs backend is not available");
+#endif
+		} else {
+			die("Unknown ref backend type '%s'", refdb_data.refs_backend_type);
+		}
+
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
diff --git a/configure.ac b/configure.ac
index 63b7244..ea8e93d 100644
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
index 888c34a..66b7ecf 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -28,6 +28,9 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
   git rev-parse --git-dir 2>/dev/null) ||
   die "Not a git repository: \"$orig_git\""
 
+
+test "$(git config core.refsbackendtype)" = "lmdb" && die "git-new-workdir is incompatible with the refs lmdb backend"
+
 case "$git_dir" in
 .git)
 	git_dir="$orig_git/.git"
diff --git a/environment.c b/environment.c
index c5b65f5..6a2f639 100644
--- a/environment.c
+++ b/environment.c
@@ -65,6 +65,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+const char *refs_backend_type;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/refs-be-lmdb.c b/refs-be-lmdb.c
new file mode 100644
index 0000000..3c41206
--- /dev/null
+++ b/refs-be-lmdb.c
@@ -0,0 +1,1997 @@
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
+#include "tag.h"
+#include "lockfile.h"
+
+static struct trace_key db_trace = TRACE_KEY_INIT(LMDB);
+
+static MDB_env *env;
+
+static char *db_path;
+
+static struct ref_be *files_be;
+
+struct lmdb_transaction {
+	MDB_txn *txn;
+	MDB_dbi dbi;
+	MDB_cursor *cursor;
+	const char *submodule;
+	int flags;
+};
+
+struct lmdb_transaction transaction;
+
+static char *get_refdb_path(const char *base)
+{
+	struct strbuf path_buf = STRBUF_INIT;
+	strbuf_addf(&path_buf, "%s/refdb", base);
+	return strbuf_detach(&path_buf, NULL);
+}
+
+static int in_write_transaction(void)
+{
+	return transaction.txn && !(transaction.flags & MDB_RDONLY);
+}
+
+static void init_env(MDB_env **env, const char *path)
+{
+	int ret;
+	if (*env)
+		return;
+
+	ret = mdb_env_create(env);
+	if (ret)
+		die("mdb_env_create failed: %s", mdb_strerror(ret));
+	ret = mdb_env_set_maxreaders(*env, 1000);
+	if (ret)
+		die("BUG: mdb_env_set_maxreaders failed: %s", mdb_strerror(ret));
+	ret = mdb_env_set_mapsize(*env, (1<<30));
+	if (ret)
+		die("BUG: mdb_set_mapsize failed: %s", mdb_strerror(ret));
+	ret = mdb_env_open(*env, path, 0 , 0664);
+	if (ret)
+		die("BUG: mdb_env_open (%s) failed: %s", path,
+		    mdb_strerror(ret));
+}
+
+static int lmdb_initdb(struct strbuf *err, int shared)
+{
+	/*
+	 * To create a db, all we need to do is make a directory for
+	 * it to live in; lmdb will do the rest.
+	 */
+
+	assert(db_path);
+	if (mkdir(db_path, 0775) && errno != EEXIST) {
+		strbuf_addf(err, "%s", strerror(errno));
+		return -1;
+	}
+	return files_be->initdb(err, shared);
+}
+
+static void lmdb_init_backend(void *cbdata)
+{
+	struct refdb_config_data *data = (struct refdb_config_data *)cbdata;
+
+	if (db_path)
+		return;
+
+	db_path = xstrdup(real_path(get_refdb_path(data->refs_base)));
+
+	files_be = &refs_be_files;
+	files_be->init_backend(NULL);
+	trace_printf_key(&db_trace, "Init backend\n");
+}
+
+static void mdb_cursor_open_or_die(struct lmdb_transaction *transaction,
+				   MDB_cursor **cursor)
+{
+	int ret = mdb_cursor_open(transaction->txn, transaction->dbi, cursor);
+	if (ret)
+		die("mdb_cursor_open failed: %s", mdb_strerror(ret));
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
+				 struct MDB_val *val)
+{
+	static struct strbuf sb = STRBUF_INIT;
+	static struct strbuf path = STRBUF_INIT;
+
+	submodule_path(&path, submodule, refname);
+
+	if (strbuf_read_file(&sb, path.buf, 200) < 0) {
+		strbuf_release(&sb);
+		strbuf_release(&path);
+		if (errno == ENOENT)
+			return MDB_NOTFOUND;
+		return -1;
+	}
+	strbuf_setlen(&sb, sb.len - 1);
+
+	val->mv_data = sb.buf;
+	val->mv_size = sb.len + 1;
+
+	strbuf_detach(&sb, NULL);
+	strbuf_release(&path);
+	return 0;
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
+		die_errno("failed to write new HEAD");
+
+	if (commit_lock_file(&lock))
+		die_errno("failed to write new HEAD");
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
+static int mdb_get_or_die(struct lmdb_transaction *transaction, MDB_val *key,
+			  MDB_val *val)
+{
+	int ret;
+
+	if (ref_type(key->mv_data) != REF_TYPE_NORMAL)
+		return read_per_worktree_ref(transaction->submodule,
+					     key->mv_data, val);
+
+	ret = mdb_get(transaction->txn, transaction->dbi, key, val);
+	if (ret) {
+		if (ret != MDB_NOTFOUND)
+			die("mdb_get failed: %s", mdb_strerror(ret));
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
+			die("mdb_del failed: %s", mdb_strerror(ret));
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
+		if (ret == MDB_BAD_VALSIZE)
+			die("Ref name %s too long (max size is %d)",
+			    (const char *)key->mv_data,
+			    mdb_env_get_maxkeysize(env));
+		else
+			die("mdb_put failed: (%s -> %s) %s",
+			    (const char *)key->mv_data,
+			    (const char *)val->mv_data, mdb_strerror(ret));
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
+			die("mdb_cursor_get failed: %s", mdb_strerror(ret));
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
+			die("mdb_cursor_del failed: %s", mdb_strerror(ret));
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
+int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int flags)
+{
+	int ret;
+	MDB_txn *txn;
+	static size_t last_txnid = 0;
+	int force_restart = 0;
+	MDB_envinfo stat;
+
+	init_env(&env, db_path);
+
+	/*
+	 * Since each transaction sees a consistent view of the db,
+	 * downstream processes that write the db won't be seen in
+	 * this transaction.  We can check if the last transaction id
+	 * has changed since this read transaction was started, and if
+	 * so, we want to reopen the transaction.
+	 */
+
+	mdb_env_info(env, &stat);
+	if (stat.me_last_txnid != last_txnid) {
+		force_restart = 1;
+		last_txnid = stat.me_last_txnid;
+	}
+
+	if (!transaction.txn) {
+		ret = mdb_txn_begin(env, NULL, flags, &txn);
+		if (ret) {
+			strbuf_addf(err, "mdb_txn_begin failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		ret = mdb_dbi_open(txn, NULL, 0, &transaction.dbi);
+		if (ret) {
+			strbuf_addf(err, "mdb_txn_open failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		transaction.txn = txn;
+		transaction.flags = flags;
+		return 0;
+	}
+
+	if (transaction.flags == flags && !(flags & MDB_RDONLY))
+		die("BUG: rw transaction started during another rw txn");
+
+	if (force_restart || (transaction.flags != flags && transaction.flags & MDB_RDONLY)) {
+		/*
+		 * RO -> RW, or forced restart due to possible changes
+		 * from downstream processes.
+		 */
+		mdb_txn_abort(transaction.txn);
+		ret = mdb_txn_begin(env, NULL, flags, &txn);
+		if (ret) {
+			strbuf_addf(err, "restarting txn: mdb_txn_begin failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		ret = mdb_dbi_open(txn, NULL, 0, &transaction.dbi);
+		if (ret) {
+			strbuf_addf(err, "mdb_txn_open failed: %s",
+				    mdb_strerror(ret));
+			return -1;
+		}
+		transaction.txn = txn;
+		transaction.flags = flags;
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
+	return &transaction;
+}
+
+#define MAXDEPTH 5
+
+static const char *parse_ref_data(struct lmdb_transaction *transaction,
+				  const char *refname, const char *ref_data,
+				  unsigned char *sha1, int resolve_flags,
+				  int *flags, int bad_name)
+{
+	int depth = MAXDEPTH;
+	const char *buf;
+	static struct strbuf refname_buffer = STRBUF_INIT;
+	static struct strbuf refdata_buffer = STRBUF_INIT;
+	MDB_val key, val;
+
+	for (;;) {
+		if (--depth < 0)
+			return NULL;
+
+		if (!starts_with(ref_data, "ref:")) {
+			if (get_sha1_hex(ref_data, sha1) ||
+			    (ref_data[40] != '\0' && !isspace(ref_data[40]))) {
+				if (flags)
+					*flags |= REF_ISBROKEN;
+				errno = EINVAL;
+				return NULL;
+			}
+
+			if (bad_name) {
+				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			} else if (is_null_sha1(sha1)) {
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
+			return refname;
+		}
+		if (flags)
+			*flags |= REF_ISSYMREF;
+		buf = ref_data + 4;
+		while (isspace(*buf))
+			buf++;
+		strbuf_reset(&refname_buffer);
+		strbuf_addstr(&refname_buffer, buf);
+		refname = refname_buffer.buf;
+		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
+			hashclr(sha1);
+			return refname;
+		}
+		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+			if (flags)
+				*flags |= REF_ISBROKEN;
+
+			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+			    !refname_is_safe(buf)) {
+				errno = EINVAL;
+				return NULL;
+			}
+			bad_name = 1;
+		}
+
+		key.mv_data = (char *)refname;
+		key.mv_size = strlen(refname) + 1;
+		if (mdb_get_or_die(transaction, &key, &val)) {
+			hashclr(sha1);
+			if (bad_name) {
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
+			if (resolve_flags & RESOLVE_REF_READING)
+				return NULL;
+
+			return refname;
+		}
+		strbuf_reset(&refdata_buffer);
+		strbuf_add(&refdata_buffer, val.mv_data, val.mv_size);
+		ref_data = refdata_buffer.buf;
+	}
+	return refname;
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
+		    ((char*)key.mv_data)[refname_len - 2] == '/') {
+			if (skip && string_list_has_string(skip, key.mv_data))
+				goto next;
+
+			strbuf_addf(err, "'%s' exists; cannot create '%s'", (char *)key.mv_data, refname);
+			goto done;
+		}
+		break;
+	next:
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
+				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
+					    refname, search_key);
+				goto done;
+			}
+
+			key.mv_data = search_key;
+			key.mv_size = i + 1;
+			if (!mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET)) {
+				strbuf_addf(err, "'%s' exists; cannot create '%s'", (char *)key.mv_data, refname);
+				goto done;
+			}
+			search_key[i] = '/';
+		}
+	}
+
+	extra_refname = find_descendant_ref(refname, extras, skip);
+	if (extra_refname) {
+		strbuf_addf(err,
+			    "cannot process '%s' and '%s' at the same time",
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
+static const char *resolve_ref_unsafe_txn(struct lmdb_transaction *transaction,
+					  const char *refname,
+					  int resolve_flags,
+					  unsigned char *sha1,
+					  int *flags)
+{
+	int bad_name = 0;
+	char *ref_data;
+	struct MDB_val key, val;
+	struct strbuf err = STRBUF_INIT;
+
+	val.mv_size = 0;
+	val.mv_data = NULL;
+
+	if (flags)
+		*flags = 0;
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (flags)
+			*flags |= REF_BAD_NAME;
+
+		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+		    !refname_is_safe(refname)) {
+			errno = EINVAL;
+			return NULL;
+		}
+		/*
+		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * missing refs and refs that were present but invalid,
+		 * to complain about the latter to stderr.
+		 *
+		 * We don't know whether the ref exists, so don't set
+		 * REF_ISBROKEN yet.
+		 */
+		bad_name = 1;
+	}
+
+	key.mv_data = (void *)refname;
+	key.mv_size = strlen(refname) + 1;
+	if (mdb_get_or_die(transaction, &key, &val)) {
+		if (bad_name) {
+			hashclr(sha1);
+			if (flags)
+				*flags |= REF_ISBROKEN;
+		}
+
+		if (resolve_flags & RESOLVE_REF_READING)
+			return NULL;
+
+		if (verify_refname_available_txn(transaction, refname, NULL, NULL, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			return NULL;
+		}
+
+		hashclr(sha1);
+		return refname;
+	}
+
+	ref_data = val.mv_data;
+	assert(ref_data[val.mv_size - 1] == 0);
+
+	return parse_ref_data(transaction, refname, ref_data, sha1, resolve_flags,
+			      flags, bad_name);
+}
+
+static const char *lmdb_resolve_ref_unsafe(const char *refname, int resolve_flags,
+					   unsigned char *sha1, int *flags)
+{
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return resolve_ref_unsafe_txn(&transaction, refname,
+				      resolve_flags, sha1, flags);
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
+	/* old (raw) new (raw) name <email> SP time TAB msg LF */
+	if (sb->len < 41 || sb->buf[sb->len - 1] != '\n' ||
+	    !(email_end = strchr(sb->buf + 40, '>')) ||
+	    email_end[1] != ' ' ||
+	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
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
+	char *log_key;
+	int refname_len;
+	MDB_cursor *cursor;
+	struct strbuf buf = STRBUF_INIT;
+	const char *timestamp;
+
+	if (log_all_ref_updates < 0)
+		log_all_ref_updates = !is_bare_repository();
+
+	/* it is assumed that we are in a ref transaction here */
+	assert(transaction.txn);
+
+	result = safe_create_reflog(refname, flags & REF_FORCE_CREATE_REFLOG, err);
+	if (result)
+		return result;
+
+	/* "logs/" + refname + \0 + 8-byte timestamp for sorting and expiry. */
+	refname_len = strlen(refname);
+	key.mv_size = refname_len + 14;
+	log_key = xcalloc(1, key.mv_size);
+	sprintf(log_key, "logs/%s", refname);
+	key.mv_data = log_key;
+
+	mdb_cursor_open_or_die(&transaction, &cursor);
+
+	/* check that a reflog exists */
+	if (mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE) ||
+	    strcmp(key.mv_data, log_key)) {
+		free(log_key);
+		mdb_cursor_close(cursor);
+		return 0;
+	}
+
+	/* Is this a header?  We only need the header for empty reflogs */
+	timestamp = (const char *)key.mv_data + refname_len + 6;
+	if (ntohll(*(uint64_t *)timestamp) == 0)
+		mdb_cursor_del_or_die(cursor, 0);
+
+	key.mv_data = log_key;
+
+	write_u64((char *)key.mv_data + refname_len + 6, htonll(now));
+
+	format_reflog_entry(&buf, old_sha1, new_sha1,
+			    git_committer_info(0), msg);
+	assert(buf.len >= 42);
+	val.mv_data = buf.buf;
+	val.mv_size = buf.len + 1;
+
+	mdb_put_or_die(&transaction, &key, &val, 0);
+
+	strbuf_release(&buf);
+	free(log_key);
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
+	return verify_refname_available_txn(&transaction, refname, extras, skip, err);
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
+	    *type_p = type;
+
+	if (!refname)
+		return NULL;
+
+	/*
+	 * Need to copy refname here because the resolve_ref_unsafe
+	 * returns a pointer to a static buffer that could get mangled
+	 * by the second call.
+	 */
+	resolved_refname = strdup(refname);
+
+	if (old_sha1) {
+		if (flags & REF_NODEREF) {
+			resolve_flags &= ~RESOLVE_REF_NO_RECURSE;
+
+			resolve_ref_unsafe(refname, resolve_flags,
+					   resolved_sha1, &type);
+		}
+		if (hashcmp(old_sha1, resolved_sha1)) {
+			error("ref %s is at %s but expected %s", refname,
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
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return files_be->delete_reflog(refname);
+
+	in_transaction = in_write_transaction();
+
+	len = strlen(refname) + 6;
+	log_path = xmalloc(len);
+	sprintf(log_path, "logs/%s", refname);
+
+	key.mv_data = log_path;
+	key.mv_size = len;
+
+	if (!in_transaction)
+		lmdb_transaction_begin_flags_or_die(0);
+
+	mdb_cursor_open_or_die(&transaction, &cursor);
+
+	mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_SET_RANGE);
+
+	while (!mdb_ret) {
+		if (key.mv_size < len)
+			break;
+
+		if (!starts_with(key.mv_data, log_path) || ((char*)key.mv_data)[len - 1] != 0)
+			break;
+
+		mdb_cursor_del_or_die(cursor, 0);
+		mdb_ret = mdb_cursor_get_or_die(cursor, &key, &val, MDB_NEXT);
+	}
+
+	free(log_path);
+	mdb_cursor_close(cursor);
+	transaction.cursor = NULL;
+
+	if (!in_transaction && mdb_transaction_commit(&transaction, &err)) {
+		warning("%s", err.buf);
+		ret = 01;
+	}
+	strbuf_release(&err);
+	return ret;
+}
+
+#define REF_NO_REFLOG 0x8000
+
+static int lmdb_transaction_update(struct lmdb_transaction *transaction,
+				   const char *refname,
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
+		strbuf_addf(err, "refusing to update ref with bad name %s",
+			    refname);
+		return TRANSACTION_GENERIC_ERROR;
+	}
+
+	refname = check_ref(transaction->txn, orig_refname, old_sha1,
+			    resolved_sha1, flags, &type);
+	if (refname == NULL) {
+		strbuf_addf(err, "cannot lock the ref '%s'", orig_refname);
+		return TRANSACTION_GENERIC_ERROR;
+	}
+
+	if (!(flags & REF_DELETING) && is_null_sha1(resolved_sha1) &&
+	    verify_refname_available_txn(transaction, refname, NULL, NULL, err))
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
+				    "Trying to write ref %s with nonexistent object %s",
+				    refname, sha1_to_hex(new_sha1));
+			goto done;
+		}
+		if (o->type != OBJ_COMMIT && is_branch(refname)) {
+			strbuf_addf(err,
+				    "Trying to write non-commit object %s to branch %s",
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
+			mdb_put_or_die(transaction, &key, &val, 0);
+		}
+	}
+
+	if (flags & REF_DELETING) {
+		if (mdb_del_or_die(transaction, &key, NULL)) {
+			if (old_sha1 && !is_null_sha1(old_sha1)) {
+				strbuf_addf(err, "No such ref %s", refname);
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
+		if (strcmp (refname, orig_refname) &&
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
+	struct lmdb_transaction *lmdb_transaction;
+	struct ref_update **updates = ref_transaction->updates;
+
+	/*
+	 * We might already be in a write transaction, because some
+	 * lmdb backend functionality is implemented in terms of
+	 * (other stuff) + ref_transaction_commit
+	 */
+	if (in_write_transaction())
+		lmdb_transaction = &transaction;
+	else
+		lmdb_transaction = lmdb_transaction_begin_flags_or_die(0);
+
+	for (i = 0; i < n; i++) {
+		struct ref_update *update = updates[i];
+
+		if (lmdb_transaction_update(lmdb_transaction,
+					    update->refname,
+					    update->new_sha1,
+					    (update->flags & REF_HAVE_OLD) ?
+					     update->old_sha1 : NULL,
+					    update->flags,
+					    update->msg,
+					    err)) {
+			mdb_txn_abort(lmdb_transaction->txn);
+			ret = -1;
+			goto cleanup;
+		}
+
+	}
+	ret = mdb_transaction_commit(lmdb_transaction, err);
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
+
+	assert(transaction.cursor);
+
+	if (mdb_cursor_get_or_die(transaction.cursor, &key, &val, MDB_GET_CURRENT))
+		die("renaming ref: mdb_cursor_get failed to get current");
+
+	new_key.mv_size = strlen(newrefname) + 5 + 1 + 8;
+	new_key.mv_data = xmalloc(new_key.mv_size);
+	strcpy(new_key.mv_data, "logs/");
+	strcpy((char *)new_key.mv_data + 5, newrefname);
+	memcpy((char *)new_key.mv_data + new_key.mv_size - 8,
+	       (const char *)key.mv_data + key.mv_size - 8, 8);
+	mdb_put_or_die(&transaction, &new_key, &val, 0);
+	mdb_cursor_del_or_die(transaction.cursor, 0);
+	free(new_key.mv_data);
+	return 0;
+}
+
+static int lmdb_rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	unsigned char orig_sha1[20];
+	int flag = 0;
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
+	symref = resolve_ref_unsafe(oldref, RESOLVE_REF_READING,
+				    orig_sha1, &flag);
+	if (flag & REF_ISSYMREF) {
+		error("refname %s is a symbolic ref, renaming it is not supported",
+		      oldref);
+		goto fail;
+	}
+	if (!symref) {
+		mdb_txn_abort(transaction.txn);
+		error("refname %s not found", oldref);
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
+			error("can't create reflog for %s: %s", newref, err.buf);
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
+		mdb_del_or_die(&transaction, &key, NULL);
+		strbuf_release(&old_log_sentinel);
+	}
+
+	if (ref_transaction_delete(ref_transaction, oldref,
+				   orig_sha1, REF_NODEREF, NULL, &err)) {
+		error("unable to delete old %s", oldref);
+		goto fail;
+	}
+
+	if (ref_transaction_update(ref_transaction, newref, orig_sha1, NULL,
+				    0, logmsg, &err)) {
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
+	mdb_txn_abort(transaction.txn);
+	return 1;
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
+	len = strlen(refname) + 6;
+	log_path = xmalloc(len);
+	search_key = xmalloc(len + 1);
+	sprintf(log_path, "logs/%s", refname);
+	strcpy(search_key, log_path);
+
+	if (reverse) {
+		/*
+		 * For a reverse search, start at the key
+		 * lexicographically after the searched-for key.
+		 * That's the one with \001 appended to the key.
+		 */
+
+		search_key[len - 1] = 1;
+		search_key[len] = 0;
+		key.mv_size = len + 1;
+	} else {
+		key.mv_size = len;
+	}
+
+	key.mv_data = search_key;
+
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+
+	mdb_cursor_open_or_die(&transaction, &cursor);
+
+	transaction.cursor = cursor;
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
+		return files_be->for_each_reflog_ent(refname, fn, cb_data);
+	return lmdb_for_each_reflog_ent_order(refname, fn, cb_data, 0);
+}
+
+static int lmdb_for_each_reflog_ent_reverse(const char *refname,
+					    each_reflog_ent_fn fn,
+					    void *cb_data)
+{
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return files_be->for_each_reflog_ent_reverse(refname, fn, cb_data);
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
+		return files_be->reflog_exists(refname);
+
+	len = strlen(refname) + 6;
+	log_path = xmalloc(len);
+	sprintf(log_path, "logs/%s", refname);
+
+	key.mv_data = log_path;
+	key.mv_size = len;
+
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	mdb_cursor_open_or_die(&transaction, &cursor);
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
+
+	if (!force_create && !should_autocreate_reflog(refname))
+		return 0;
+
+	if (!in_transaction)
+		lmdb_transaction_begin_flags_or_die(0);
+
+	key.mv_size = strlen(refname) + 5 + 1 + 8;
+	key.mv_data = xcalloc(1, key.mv_size);
+	sprintf((char *)key.mv_data, "logs/%s", refname);
+	val.mv_size = 0;
+	val.mv_data = NULL;
+	mdb_put_or_die(&transaction, &key, &val, 0);
+
+	free(key.mv_data);
+	if (!in_transaction)
+		return mdb_transaction_commit(&transaction, err);
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
+			mdb_cursor_del_or_die(transaction.cursor, 0);
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
+int lmdb_reflog_expire(const char *refname, const unsigned char *sha1,
+		       unsigned int flags,
+		       reflog_expiry_prepare_fn prepare_fn,
+		       reflog_expiry_should_prune_fn should_prune_fn,
+		       reflog_expiry_cleanup_fn cleanup_fn,
+		       void *policy_cb_data)
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
+		return files_be->reflog_expire(refname, sha1, flags, prepare_fn,
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
+	resolved = check_ref(transaction.txn, refname, sha1,
+			     resolved_sha1, 0, &type);
+	if (!resolved)
+		die("Failed to resolve %s", refname);
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
+		if (mdb_transaction_commit(&transaction, &err)) {
+			status |= error("couldn't write logs/%s: %s", refname,
+					err.buf);
+			strbuf_release(&err);
+		} else if (update &&
+			   write_ref(refname, cb.last_kept_sha1)) {
+			status |= error("couldn't set %s",
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
+	val.mv_size = strlen(refs_heads_master) + 1 + 5;
+	valdata = xmalloc(val.mv_size);
+	sprintf(valdata, "ref: %s", refs_heads_master);
+	val.mv_data = valdata;
+
+	if (!in_transaction)
+		lmdb_transaction_begin_flags_or_die(0);
+
+	mdb_put_or_die(&transaction, &key, &val, 0);
+
+	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
+	    log_ref_write(ref_target, old_sha1, new_sha1, logmsg, 0, &err)) {
+		error("create_symref: log_ref_write failed: %s", err.buf);
+		ret = -1;
+		goto done;
+	}
+
+	if (!in_transaction && mdb_transaction_commit(&transaction, &err)) {
+		error("create_symref: commit failed: %s", err.buf);
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
+MDB_env *submodule_txn_begin(struct lmdb_transaction *transaction)
+{
+	int ret;
+	MDB_env *submodule_env = NULL;
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_git_path_submodule(&path, transaction->submodule, "refdb");
+
+	if (!is_directory(path.buf))
+		goto done;
+
+	mkdir(path.buf, 0775);
+
+	init_env(&submodule_env, path.buf);
+
+	ret = mdb_txn_begin(submodule_env, NULL, MDB_RDONLY, &transaction->txn);
+	if (ret) {
+		die("mdb_txn_begin failed: %s", mdb_strerror(ret));
+
+	}
+	ret = mdb_dbi_open(transaction->txn, NULL, 0, &transaction->dbi);
+	if (ret) {
+		die("mdb_txn_open failed: %s", mdb_strerror(ret));
+	}
+
+done:
+	strbuf_release(&path);
+	return submodule_env;
+}
+
+static int lmdb_resolve_gitlink_ref(const char *submodule, const char *refname,
+				    unsigned char *sha1)
+{
+	struct lmdb_transaction transaction;
+	MDB_env *submodule_env;
+	int result;
+
+	transaction.txn = NULL;
+	transaction.submodule = submodule;
+	submodule_env = submodule_txn_begin(&transaction);
+	if (!submodule_env)
+		return -1;
+	result = !resolve_ref_unsafe_txn(&transaction, refname,
+					 RESOLVE_REF_READING, sha1, NULL);
+
+	mdb_txn_abort(transaction.txn);
+	mdb_env_close(submodule_env);
+	return result ? -1 : 0;
+}
+
+static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	struct object_id oid;
+	int flag;
+
+	if (submodule) {
+		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
+			return fn("HEAD", &oid, 0, cb_data);
+
+		return 0;
+	}
+
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+		return fn("HEAD", &oid, flag, cb_data);
+
+	return 0;
+}
+
+static int lmdb_head_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_head_ref(NULL, fn, cb_data);
+}
+
+static int lmdb_head_ref_submodule(const char *submodule, each_ref_fn fn,
+				   void *cb_data)
+{
+	return do_head_ref(submodule, fn, cb_data);
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
+static int do_for_each_ref(struct lmdb_transaction *transaction,
+			   const char *base, each_ref_fn fn, int trim,
+			   int flags, void *cb_data)
+{
+
+	MDB_val key, val;
+	MDB_cursor *cursor;
+	int baselen;
+	char *search_key;
+	int retval;
+	int mdb_ret;
+
+	retval = do_for_each_per_worktree_ref(transaction->submodule, base, fn,
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
+	baselen = strlen(base);
+	search_key = xmalloc(baselen + 1);
+	strcpy(search_key, base);
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
+
+		if (memcmp(key.mv_data, base, baselen))
+			break;
+
+		parse_ref_data(transaction, (const char *)key.mv_data + (trim ? baselen : 0),
+			       val.mv_data, oid.hash, 0, &parsed_flags, 0);
+
+		if (flags & DO_FOR_EACH_INCLUDE_BROKEN ||
+		    (!(parsed_flags & REF_ISBROKEN) &&
+		     has_sha1_file(oid.hash))) {
+			retval = fn((const char *)key.mv_data + (trim ? baselen : 0), &oid, parsed_flags, cb_data);
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
+	return retval;
+}
+
+static int lmdb_for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return do_for_each_ref(&transaction, "", fn, 0, 0, cb_data);
+}
+
+static int lmdb_for_each_ref_submodule(const char *submodule, each_ref_fn fn,
+				       void *cb_data)
+{
+	struct lmdb_transaction transaction;
+	MDB_env *submodule_env;
+	int result;
+
+	if (!submodule)
+		return for_each_ref(fn, cb_data);
+
+	transaction.txn = NULL;
+	transaction.submodule = submodule;
+
+	submodule_env = submodule_txn_begin(&transaction);
+	if (!submodule_env)
+		return 0;
+	result = do_for_each_ref(&transaction, "", fn, 0, 0, cb_data);
+	mdb_txn_abort(transaction.txn);
+	mdb_env_close(submodule_env);
+	return result;
+}
+
+static int lmdb_for_each_ref_in(const char *prefix, each_ref_fn fn,
+				 void *cb_data)
+{
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return do_for_each_ref(&transaction, prefix, fn, strlen(prefix),
+			       0, cb_data);
+}
+
+static int lmdb_for_each_fullref_in(const char *prefix, each_ref_fn fn,
+				    void *cb_data, unsigned int broken)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return do_for_each_ref(&transaction, prefix, fn, 0, flag, cb_data);
+}
+
+static int lmdb_for_each_ref_in_submodule(const char *submodule,
+					  const char *prefix,
+					  each_ref_fn fn, void *cb_data)
+{
+	struct lmdb_transaction transaction = {NULL};
+	MDB_env *submodule_env;
+	int result;
+
+	if (!submodule)
+		return for_each_ref_in(prefix, fn, cb_data);
+
+	transaction.submodule = submodule;
+	submodule_env = submodule_txn_begin(&transaction);
+	if (!submodule_env)
+		return 0;
+	result = do_for_each_ref(&transaction, prefix, fn,
+				 strlen(prefix), 0, cb_data);
+	mdb_txn_abort(transaction.txn);
+	mdb_env_close(submodule_env);
+	return result;
+}
+
+static int lmdb_for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return do_for_each_ref(&transaction, git_replace_ref_base, fn,
+			       strlen(git_replace_ref_base), 0, cb_data);
+}
+
+static int lmdb_for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return do_for_each_ref(&transaction, type, fn, 0, flag, cb_data);
+}
+
+static int lmdb_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&buf, "%srefs/", get_git_namespace());
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	ret = do_for_each_ref(&transaction, buf.buf, fn, 0, 0, cb_data);
+	strbuf_release(&buf);
+	return ret;
+}
+
+static int lmdb_for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	return do_for_each_ref(&transaction, "", fn, 0,
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+}
+
+/* For testing only! */
+int test_refdb_raw_read(const char *key)
+{
+	MDB_val key_val, val;
+	char *keydup;
+	int ret;
+
+	lmdb_transaction_begin_flags_or_die(MDB_RDONLY);
+	keydup = xstrdup(key);
+	key_val.mv_data = keydup;
+	key_val.mv_size = strlen(key) + 1;
+
+	ret = mdb_get_or_die(&transaction, &key_val, &val);
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
+	mdb_put_or_die(&transaction, &key_val, &val, 0);
+	assert(mdb_transaction_commit(&transaction, NULL) == 0);
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
+	ret = mdb_del_or_die(&transaction, &key_val, NULL);
+
+	assert(mdb_transaction_commit(&transaction, NULL) == 0);
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
+	if (refname) {
+		len = strlen(refname) + 5 + 1; /* logs/ + 0*/
+		search_key = xmalloc(len);
+		sprintf(search_key, "logs/%s", refname);
+	} else {
+		len = 6; /* logs/ + 0*/
+		search_key = xstrdup("logs/");
+	}
+	key.mv_data = search_key;
+	key.mv_size = len;
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	mdb_cursor_open_or_die(&transaction, &cursor);
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
+	assert(mdb_transaction_commit(&transaction, NULL) == 0);
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
+	msg = strchr(src->buf + 82, '\n');
+	assert(msg);
+	msg += 1;
+
+	format_reflog_entry(dst, osha1, nsha1, src->buf + 82, msg);
+}
+
+/* For testing only! */
+void test_refdb_raw_append_reflog(const char *refname)
+{
+	struct strbuf input = STRBUF_INIT;
+	uint64_t now = getnanotime();
+	MDB_val key, val;
+
+	key.mv_size = strlen(refname) + 14;
+	key.mv_data = xcalloc(1, key.mv_size);
+	sprintf(key.mv_data, "logs/%s", refname);
+
+	lmdb_transaction_begin_flags_or_die(0);
+
+	/* We do not remove the header here, because this is just for
+	 * tests, so it's OK to be a bit inefficient */
+
+	while (strbuf_getwholeline(&input, stdin, '\n') != EOF) {
+		struct strbuf sb = STRBUF_INIT;
+
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
+		mdb_put_or_die(&transaction, &key, &val, 0);
+		strbuf_reset(&sb);
+		input.len = 0;
+	}
+
+	assert(mdb_transaction_commit(&transaction, NULL) == 0);
+	free(key.mv_data);
+}
+
+struct ref_be refs_be_lmdb = {
+	NULL,
+	"lmdb",
+	lmdb_init_backend,
+	lmdb_initdb,
+	lmdb_transaction_commit,
+	lmdb_transaction_commit, /* initial commit */
+	lmdb_rename_ref,
+	lmdb_for_each_reflog_ent,
+	lmdb_for_each_reflog_ent_reverse,
+	lmdb_for_each_reflog,
+	lmdb_reflog_exists,
+	lmdb_create_reflog,
+	lmdb_delete_reflog,
+	lmdb_reflog_expire,
+	lmdb_resolve_ref_unsafe,
+	lmdb_verify_refname_available,
+	lmdb_pack_refs,
+	lmdb_peel_ref,
+	lmdb_create_symref,
+	lmdb_resolve_gitlink_ref,
+	lmdb_head_ref,
+	lmdb_head_ref_submodule,
+	lmdb_for_each_ref,
+	lmdb_for_each_ref_submodule,
+	lmdb_for_each_ref_in,
+	lmdb_for_each_fullref_in,
+	lmdb_for_each_ref_in_submodule,
+	lmdb_for_each_rawref,
+	lmdb_for_each_namespaced_ref,
+	lmdb_for_each_replace_ref,
+	lmdb_for_each_reftype_fullpath,
+};
diff --git a/refs.h b/refs.h
index 45615e8..8d85a6e 100644
--- a/refs.h
+++ b/refs.h
@@ -691,6 +691,15 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/*
+ * Read the refdb configuration data out of the config file
+ */
+struct refdb_config_data {
+	const char *refs_backend_type;
+	const char *refs_base;
+};
+int refdb_config(const char *var, const char *value, void *ptr);
+
 /* refs backends */
 typedef void ref_backend_init_fn(void *data);
 typedef int ref_backend_initdb_fn(struct strbuf *err, int shared);
@@ -789,6 +798,7 @@ struct ref_be {
 
 
 extern struct ref_be refs_be_files;
+extern struct ref_be refs_be_lmdb;
 int set_refs_backend(const char *name, void *init_data);
 void register_refs_backend(struct ref_be *be);
 
diff --git a/setup.c b/setup.c
index 7433eed..c8ed245 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 #include "string-list.h"
 
 static int inside_git_dir = -1;
@@ -263,16 +264,26 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 	return ret;
 }
 
+int refdb_config(const char *var, const char *value, void *ptr)
+{
+       struct refdb_config_data *cdata = ptr;
+
+       if (!strcmp(var, "core.refsbackendtype"))
+	       cdata->refs_backend_type = strdup((char *)value);
+       return 0;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
  *
  *  - either an objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
- *  - a refs/ directory
- *  - either a HEAD symlink or a HEAD file that is formatted as
- *    a proper "ref:", or a regular file HEAD that has a properly
- *    formatted sha1 object name.
+ *  - a refdb/ directory or
+ *    - a refs/ directory
+ *    - either a HEAD symlink or a HEAD file that is formatted as
+ *      a proper "ref:", or a regular file HEAD that has a properly
+ *      formatted sha1 object name.
  */
 int is_git_directory(const char *suspect)
 {
@@ -303,8 +314,13 @@ int is_git_directory(const char *suspect)
 
 	strbuf_setlen(&path, len);
 	strbuf_addstr(&path, "/refs");
-	if (access(path.buf, X_OK))
-		goto done;
+
+	if (access(path.buf, X_OK)) {
+		strbuf_setlen(&path, len);
+		strbuf_addstr(&path, "/refdb");
+		if (access(path.buf, X_OK))
+			goto done;
+	}
 
 	ret = 1;
 done:
@@ -371,6 +387,10 @@ static int check_repo_format(const char *var, const char *value, void *cb)
 		 */
 		if (!strcmp(ext, "noop"))
 			;
+#ifdef USE_LIBLMDB
+		else if (!strcmp(ext, "refbackend") && !strcmp(value, "lmdb"))
+			;
+#endif
 		else
 			string_list_append(&unknown_extensions, ext);
 	}
diff --git a/test-refs-be-lmdb.c b/test-refs-be-lmdb.c
new file mode 100644
index 0000000..bb875ff
--- /dev/null
+++ b/test-refs-be-lmdb.c
@@ -0,0 +1,68 @@
+#include "cache.h"
+#include "string-list.h"
+#include "parse-options.h"
+#include "refs.h"
+
+static const char * const test_refs_be_lmdb_usage[] = {
+	"git test-refs-be-lmdb <key>",
+	"git test-refs-be-lmdb <key> <value>",
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
+	struct refdb_config_data config_data = {NULL};
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
+	git_config(git_default_config, NULL);
+
+	config_data.refs_backend_type = "lmdb";
+	config_data.refs_base = get_git_dir();
+
+	register_refs_backend(&refs_be_lmdb);
+	set_refs_backend("lmdb", &config_data);
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
2.4.2.644.g97b850b-twtrsrc
