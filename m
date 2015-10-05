From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Mon, 05 Oct 2015 17:47:03 +0200
Message-ID: <56129B77.1030409@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-43-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 17:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj7yt-0004GZ-N6
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 17:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbbJEPrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 11:47:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49934 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761AbbJEPrI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 11:47:08 -0400
X-AuditID: 12074413-f79bd6d000007ac2-9f-56129b791566
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 37.55.31426.97B92165; Mon,  5 Oct 2015 11:47:05 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t95Fl3nL020773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 11:47:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-43-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqFs5WyjMYMp9KYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmLmjaxFEz+wVixcekG5gbGdUcYuxg5OSQE
	TCT2LjrLBGGLSVy4t56ti5GLQ0jgMqPEr+737BDOOSaJdRc2s4BU8QpoS9w++I0dxGYRUJXo
	n/uNFcRmE9CVWNTTDDZJVCBIYsXyF4wQ9YISJ2c+AesVEXCQuLzrKDOILSxgKXH4cSMrxII2
	Rompr+eBNXMKeElM3/IFrJlZQE9ix/VfrBC2vETz1tnMExj5ZyGZOwtJ2SwkZQsYmVcxyiXm
	lObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihASm8A7GXSflDjEKcDAq8fBKJAmGCbEm
	lhVX5h5ilORgUhLlLZopFCbEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhLehAyjHm5JYWZValA+T
	kuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg/TQLqFGwKDU9tSItM6cEIc3EwQkynEtK
	pDg1LyW1KLG0JCMeFJnxxcDYBEnxAO31B2nnLS5IzAWKQrSeYlSUEuc1B0kIgCQySvPgxsLS
	zStGcaAvhXnPglTxAFMVXPcroMFMQIP75cEGlyQipKQaGFc7nDszoYo9SHC22VnVp8tnLz6z
	SMct51pI1Ir25Re/bv+y0/nactn/xiU/E3NzsndKGLlcCzqj18qjeuho5Af7jH+t0je2e9vu
	uLfQuLfarU9RwJP5+vmik7sntiXkOdz5zqAv8/LK9BqzCw4hnJuyte2780Tr6s2v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279058>

On 09/29/2015 12:02 AM, David Turner wrote:
> Add a database backend for refs using LMDB.  This backend runs git
> for-each-ref about 30% faster than the files backend with fully-packed
> refs on a repo with ~120k refs.  It's also about 4x faster than using
> fully-unpacked refs.  In addition, and perhaps more importantly , it
> avoids case-conflict issues on OS X.
> 
> LMDB has a few features that make it suitable for usage in git:
> 
> 1. It is relatively lightweight; it requires only one header file, and
> the library code takes under 64k at runtime.
> 
> 2. It is well-tested: it's been used in OpenLDAP for years.
> 
> 3. It's very fast.  LMDB's benchmarks show that it is among
> the fastest key-value stores.
> 
> 4. It has a relatively simple concurrency story; readers don't
> block writers and writers don't block readers.

It would be great if you would go into more detail about this point in
the permanent technical documentation
(Documentation/technical/refs-be-lmdb.txt): how exactly do readers &
writers interact with each others, and how do writers interact with
other writers?

I think you have said before that if one writer holds the write lock on
the DB, then other writers fail immediately. Is that correct? If so, is
that something that can be adjusted? I think it would be preferable for
the second writer to retry acquiring the write lock for a little while
with a timeout (as we now do when trying to acquire the packed-refs
lock). Otherwise you could have the unhappy situation that somebody
spends a long time pushing a packfile to a server, only to have the
reference update be rejected at the last moment due to a lock conflict
with another process that was touching completely different references.
We already do before/after consistency checks when updating references,
so you wouldn't even have to add such code in the backend yourself.

> Ronnie Sahlberg's original version of this patchset used tdb.  The
> major disadvantage of tdb is that tdb is hard to build on OS X.  It's
> also not in homebrew.  So lmdb seemed simpler.
> 
> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend. Dozens
> of tests use manual ref/reflog reading/writing, or create submodules
> without passing --refs-backend-type to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-be-db (or, in the
> case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
> the only remaining failing tests are the git-new-workdir tests and the
> gitweb tests.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  .gitignore                               |    1 +
>  Documentation/git-clone.txt              |    2 +-
>  Documentation/git-init-db.txt            |    2 +-
>  Documentation/git-init.txt               |    6 +
>  Documentation/technical/refs-be-lmdb.txt |   39 +
>  Makefile                                 |   12 +
>  builtin/init-db.c                        |   13 +
>  config.c                                 |   27 +
>  configure.ac                             |   33 +
>  contrib/workdir/git-new-workdir          |    2 +
>  environment.c                            |    1 +
>  refs-be-lmdb.c                           | 2003 ++++++++++++++++++++++++++++++
>  refs.h                                   |   10 +
>  setup.c                                  |   28 +-
>  test-refs-be-lmdb.c                      |   68 +
>  15 files changed, 2239 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/technical/refs-be-lmdb.txt
>  create mode 100644 refs-be-lmdb.c
>  create mode 100644 test-refs-be-lmdb.c
> 
> diff --git a/.gitignore b/.gitignore
> index 1c2f832..7decc2f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -199,6 +199,7 @@
>  /test-path-utils
>  /test-prio-queue
>  /test-read-cache
> +/test-refs-be-lmdb
>  /test-regex
>  /test-revision-walking
>  /test-run-command
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index d7a4cb0..6a4cf28 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -219,7 +219,7 @@ objects from the source repository into a pack in the cloned repository.
>  
>  --refs-backend-type=<name>::
>  	Type of refs backend. Default is to use the original files based
> -	backend.
> +	backend. Set to "lmdb" to activate the lmdb database backend.
>  
>  <repository>::
>  	The (possibly remote) repository to clone from.  See the
> diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
> index 648a6cd..72fbd71 100644
> --- a/Documentation/git-init-db.txt
> +++ b/Documentation/git-init-db.txt
> @@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
> +'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--refs-backend-type=<name>]
>  
>  
>  DESCRIPTION
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 8174d27..d352788 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>  	  [--separate-git-dir <git dir>]
>  	  [--shared[=<permissions>]] [directory]
> +	  [--refs-backend-type=<name>]
>  
>  
>  DESCRIPTION
> @@ -113,6 +114,11 @@ does not exist, it will be created.
>  
>  --
>  
> +--refs-backend-type=<name>::
> +Type of refs backend. Default is to use the original "files" backend,
> +which stores ref data in files in .git/refs and .git/packed-refs.  Set
> +to "lmdb" to activate the lmdb database backend.
> +
>  TEMPLATE DIRECTORY
>  ------------------
>  
> diff --git a/Documentation/technical/refs-be-lmdb.txt b/Documentation/technical/refs-be-lmdb.txt
> new file mode 100644
> index 0000000..98c13ec
> --- /dev/null
> +++ b/Documentation/technical/refs-be-lmdb.txt
> @@ -0,0 +1,39 @@
> +Notes on the LMDB refs backend
> +==============================
> +
> +Design:
> +------
> +
> +Refs and reflogs are stored in a lmdb database in .git/refdb.  All
> +keys and values are \0-terminated.
> +
> +Keys for refs are the name of the ref (e.g. refs/heads/master).
> +Values are the value of the ref
> +(e.g. 61f23eb0f81357c19fa91e2b8c6f3906c3a8f9b0).

Please document more unambiguously whether the value is stored as
40-char hexadecimal or 20-byte binary.

Do you store "peeled" reference values for tags, as is done in
packed-refs? I think that is an important optimization.

> +All per-worktree refs (refs/bisect/* and HEAD) are store using
> +the traditional files-based backend.
> +
> +Reflogs are stored as a series of database entries.
> +
> +For an empty reflog, there is a "header" entry to show that a reflog
> +exists.

What key is used for the "header" entry? Does it have a value?

> +         For non-empty reflogs, there is one entry per logged ref
> +update.  The key format is logs/[refname]\0[timestamp].  The timestamp
> +is a 64-bit unsigned integer number of nanoseconds since 1/1/1970.
> +This means that reflog entries are chronologically ordered.  Because
> +LMDB is a btree database, we can efficiently iterate over these keys.

Currently we discard the reflog for a reference when the reference is
deleted. This is mostly due to a limitation of the filesystem-based
storage scheme--otherwise the reflog left over from a deleted reference
could prevent the creation of a reflog for another reference whose name
overlaps with it (in the sense of is_refname_available()).

It is a pretty nasty limitation because it is one of the few ways that
your actions can cause Git to lose data in a way that it is hard to
recover from.

Have you thought about removing this limitation in the lbdb backend?

> +Reflog values are in the same format as the original files-based
> +reflog.
> +
> +Weaknesses:
> +-----------
> +
> +The reflog format is somewhat inefficient: a binary format could store
> +reflog date/time information in somewhat less space.
> +
> +The rsync and file:// transports don't work yet, because they
> +don't use the refs API.

Do they fail gracefully?

> +git new-workdir is incompatible with the lmdb backend.  Fortunately,
> +git new-workdir is deprecated, and worktrees work fine.
> diff --git a/Makefile b/Makefile
> index 43ceab0..e96f84b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1036,6 +1036,17 @@ ifdef USE_LIBPCRE
>  	EXTLIBS += -lpcre
>  endif
>  
> +ifdef USE_LIBLMDB
> +	BASIC_CFLAGS += -DUSE_LIBLMDB
> +	ifdef LIBLMDBDIR
> +		BASIC_CFLAGS += -I$(LIBLMDBDIR)/include
> +		EXTLIBS += -L$(LIBLMDBDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBLMDBDIR)/$(lib)
> +	endif
> +	EXTLIBS += -llmdb
> +	LIB_OBJS += refs-be-lmdb.o
> +	TEST_PROGRAMS_NEED_X += test-refs-be-lmdb
> +endif
> +
>  ifdef HAVE_ALLOCA_H
>  	BASIC_CFLAGS += -DHAVE_ALLOCA_H
>  endif
> @@ -2122,6 +2133,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
>  	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
>  	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
> +	@echo USE_LIBLMDB=\''$(subst ','\'',$(subst ','\'',$(USE_LIBLMDB)))'\' >>$@+
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 504a2dc..89f2c05 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -203,6 +203,17 @@ static int create_default_files(const char *template_path)
>  		adjust_shared_perm(get_git_dir());
>  	}
>  
> +	if (refs_backend_type) {
> +		struct refdb_config_data config_data = {NULL};
> +		git_config_set("core.refs-backend-type", refs_backend_type);
> +		config_data.refs_backend_type = refs_backend_type;
> +		config_data.refs_base = get_git_dir();
> +#ifdef USE_LIBLMDB
> +		register_refs_backend(&refs_be_lmdb);
> +#endif
> +		set_refs_backend(refs_backend_type, &config_data);
> +	}
> +
>  	if (refs_initdb(&err, shared_repository))
>  		die("failed to set up refs db: %s", err.buf);
>  
> @@ -468,6 +479,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
> +		OPT_STRING(0, "refs-backend-type", &refs_backend_type,
> +			   N_("name"), N_("name of backend type to use")),
>  		OPT_END()
>  	};
>  
> diff --git a/config.c b/config.c
> index 248a21a..9ce2ed2 100644
> --- a/config.c
> +++ b/config.c
> @@ -10,6 +10,7 @@
>  #include "exec_cmd.h"
>  #include "strbuf.h"
>  #include "quote.h"
> +#include "refs.h"
>  #include "hashmap.h"
>  #include "string-list.h"
>  #include "utf8.h"
> @@ -1207,6 +1208,32 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  	}
>  
>  	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> +		struct refdb_config_data refdb_data = {NULL};
> +		char *repo_config_copy;
> +
> +		/*
> +		 * make sure we always read the backend config from the
> +		 * core section on startup
> +		 */
> +		ret += git_config_from_file(refdb_config, repo_config,
> +					    &refdb_data);
> +
> +		repo_config_copy = xstrdup(repo_config);
> +		refdb_data.refs_base = strdup(dirname(repo_config_copy));
> +		free(repo_config_copy);
> +
> +		if (refdb_data.refs_backend_type &&
> +		    !strcmp(refdb_data.refs_backend_type, "lmdb")) {
> +
> +#ifdef USE_LIBLMDB
> +			refs_backend_type = refdb_data.refs_backend_type;
> +			register_refs_backend(&refs_be_lmdb);
> +			set_refs_backend(refs_backend_type, &refdb_data);
> +#else
> +			die("Git was not built with USE_LIBLMDB, so the db refs backend is not available");

s/db/lmdb/

I'm somewhat surprised that you only register the lmdb backend if it is
used in the main repo. I would expect the backend to be registered
unconditionally on startup. The cost is trivial, isn't it?

It appears that you recognize "lmdb" but you treat a missing value *or
any other value* like "files". I think you should be more conservative
here and die() if you see a backend type that you don't recognize.

> +#endif
> +		}
> +
>  		ret += git_config_from_file(fn, repo_config, data);
>  		found += 1;
>  	}
> diff --git a/configure.ac b/configure.ac
> index 63b7244..ea8e93d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -271,6 +271,24 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
>          dnl it yet.
>  	GIT_CONF_SUBST([LIBPCREDIR])
>      fi)
> +
> +USE_LIBLMDB=YesPlease
> +AC_ARG_WITH(liblmdb,
> +AS_HELP_STRING([--with-liblmdb],[support lmdb (default is YES])
> +AS_HELP_STRING([],           [ARG can be also prefix for liblmdb library and headers]),
> +    if test "$withval" = "no"; then
> +	USE_LIBLMDB=
> +    elif test "$withval" = "yes"; then
> +	USE_LIBLMDB=YesPlease
> +    else
> +	USE_LIBLMDB=YesPlease
> +	LIBLMDBDIR=$withval
> +	AC_MSG_NOTICE([Setting LIBLMDBDIR to $LIBLMDBDIR])
> +        dnl USE_LIBLMDB can still be modified below, so don't substitute
> +        dnl it yet.
> +	GIT_CONF_SUBST([LIBLMDBDIR])
> +    fi)
> +
>  #
>  # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
>  AC_FUNC_ALLOCA
> @@ -510,6 +528,21 @@ GIT_CONF_SUBST([USE_LIBPCRE])
>  
>  fi
>  
> +if test -n "$USE_LIBLMDB"; then
> +
> +GIT_STASH_FLAGS($LIBLMDBDIR)
> +
> +AC_CHECK_LIB([lmdb], [mdb_env_open],
> +[USE_LIBLMDB=YesPlease],
> +[USE_LIBLMDB=])
> +
> +GIT_UNSTASH_FLAGS($LIBLMDBDIR)
> +
> +GIT_CONF_SUBST([USE_LIBLMDB])
> +
> +fi
> +
> +
>  #
>  # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
>  # git-http-push are not built, and you cannot use http:// and https://
> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> index 888c34a..9761a1a 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -28,6 +28,8 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
>    git rev-parse --git-dir 2>/dev/null) ||
>    die "Not a git repository: \"$orig_git\""
>  
> +test -d $git_dir/refdb && die "git-new-workdir is incompatible with the refs db backend"
> +

It would be safer to check $(git config core.refs-backend-type) to avoid
depending on an implementation detail of the LMDB backend (and as a bit
of safety against any backends that might be added in the future).

>  case "$git_dir" in
>  .git)
>  	git_dir="$orig_git/.git"
> diff --git a/environment.c b/environment.c
> index c5b65f5..6a2f639 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -65,6 +65,7 @@ int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  struct startup_info *startup_info;
>  unsigned long pack_size_limit_cfg;
> +const char *refs_backend_type;
>  
>  #ifndef PROTECT_HFS_DEFAULT
>  #define PROTECT_HFS_DEFAULT 0
> diff --git a/refs-be-lmdb.c b/refs-be-lmdb.c
> new file mode 100644
> index 0000000..99cbd29
> --- /dev/null
> +++ b/refs-be-lmdb.c
> @@ -0,0 +1,2003 @@
> +/*
> + * This file implements a lmdb backend for refs.
> + *
> + * The design of this backend relies on lmdb's write lock -- that is, any
> + * write transaction blocks all other writers.  Thus, as soon as a ref
> + * transaction is opened, we know that any values we read won't
> + * change out from under us, and we have a fully-consistent view of the
> + * database.
> + *
> + * We store the content of refs including the trailing \0 so that
> + * standard C string functions can handle them.  Just like struct
> + * strbuf.
> + */
> +#include <lmdb.h>
> +#include <sys/uio.h>
> +#include "cache.h"
> +#include "object.h"
> +#include "refs.h"
> +#include "tag.h"
> +#include "lockfile.h"
> +#include "run-command.h"
> +
> +static struct trace_key db_trace = TRACE_KEY_INIT(LMDB);
> +
> +static MDB_env *env;
> +
> +static char *db_path;
> +
> +struct lmdb_transaction_info {
> +	MDB_txn *txn;
> +	MDB_dbi dbi;
> +	const char *submodule;
> +};
> +
> +struct lmdb_transaction {
> +	struct ref_transaction base;
> +	MDB_cursor *cursor;
> +	struct lmdb_transaction_info info;
> +	struct hashmap updated_refs;
> +	unsigned int flags;
> +};
> +
> +static struct lmdb_transaction transaction = {{}, NULL};
> +
> +struct ref_update {
> +	struct hashmap_entry ent;  /* must be first */
> +	size_t len;
> +	char refname[FLEX_ARRAY];
> +};
> +
> +static char *get_refdb_path(const char *base)
> +{
> +	struct strbuf path_buf = STRBUF_INIT;
> +	strbuf_addf(&path_buf, "%s/refdb", base);
> +	return strbuf_detach(&path_buf, NULL);
> +}
> +
> +static int in_write_transaction(void)
> +{
> +	return transaction.info.txn && !(transaction.flags & MDB_RDONLY);
> +}
> +
> +static void init_env(MDB_env **env, const char *path)
> +{
> +	int ret;
> +	if (*env)
> +		return;
> +
> +	if ((ret = mdb_env_create(env)) != MDB_SUCCESS)
> +		die("mdb_env_create failed: %s", mdb_strerror(ret));

The LMDB docs seem to say that their functions "return a non-zero error
value on failure and 0 on success". So can we avoid writing MDB_SUCCESS
everywhere and just compare to zero?

Also, the Git project CodingGuidelines say to avoid assignments in the
condition of an "if" statement.

So all in all I think these should be written like

        ret = mdb_env_create(env);
        if (ret)
                die("mdb_env_create failed: %s", mdb_strerror(ret));

> +	if ((ret = mdb_env_set_maxreaders(*env, 1000)) != MDB_SUCCESS)
> +		die("BUG: mdb_env_set_maxreaders failed: %s", mdb_strerror(ret));
> +	if ((ret = mdb_env_set_mapsize(*env, (1<<30))) != MDB_SUCCESS)
> +		die("BUG: mdb_set_mapsize failed: %s", mdb_strerror(ret));
> +	if ((ret = mdb_env_open(*env, path, 0 , 0664)) != MDB_SUCCESS)
> +		die("BUG: mdb_env_open (%s) failed: %s", path, mdb_strerror(ret));
> +}
> +
> +static int lmdb_initdb(struct strbuf *err, int shared)
> +{
> +	/* To create a db, all we need to do is make a directory for
> +	   it to live in; lmdb will do the rest. */
> +
> +	assert(db_path);
> +	if (mkdir(db_path, 0775)) {
> +		if (errno != EEXIST) {
> +			strbuf_addf(err, "%s", strerror(errno));
> +			return -1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void lmdb_init_backend(struct refdb_config_data *data)
> +{
> +	if (db_path)
> +		return;
> +
> +	db_path = xstrdup(real_path(get_refdb_path(data->refs_base)));
> +	trace_printf_key(&db_trace, "Init backend\n");
> +}
> +
> +int ref_update_cmp(const void *entry, const void *entry_or_key, const void *keydata)

The usual convention for a "cmp" function is that it returns <0, =0, or
>0 depending on the relative ordering of its arguments. This one can
only be used for equality/inequality. Please add a comment warning the
reader of this (and maybe rename it, e.g., to ref_update_not_equal(), to
further reduce the chance of confusion).

Aside: the hashmap_init() documentation is very confusing. Based on the
documentation alone, I would have thought that its `equals_function`
should return true if the two arguments are *equal*.

> +{
> +
> +	const struct ref_update *existing = entry;
> +	const struct ref_update *incoming = entry_or_key;
> +
> +	return existing->len != incoming->len ||
> +		memcmp(existing->refname, incoming->refname, existing->len);
> +}
> +
> +static void mdb_cursor_open_or_die(struct lmdb_transaction_info *info,
> +				   MDB_cursor **cursor)
> +{
> +	int ret = mdb_cursor_open(info->txn, info->dbi, cursor);
> +	if (ret)
> +		die("mdb_cursor_open failed: %s", mdb_strerror(ret));
> +}
> +
> +static void submodule_path(struct strbuf *sb, const char *submodule,
> +			   const char *refname)
> +{
> +	if (submodule)
> +		strbuf_git_path_submodule(sb, submodule, "%s", refname);
> +	else
> +		strbuf_git_path(sb, "%s", refname);
> +}
> +
> +static int read_per_worktree_ref(const char *submodule, const char *refname,
> +				 struct MDB_val *val)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +	static struct strbuf path = STRBUF_INIT;
> +
> +	submodule_path(&path, submodule, refname);
> +
> +	if (strbuf_read_file(&sb, path.buf, 200) < 0) {
> +		strbuf_release(&sb);
> +		strbuf_release(&path);
> +		if (errno == ENOENT)
> +			return MDB_NOTFOUND;
> +		return -1;
> +	}
> +	strbuf_setlen(&sb, sb.len - 1);
> +
> +	val->mv_data = sb.buf;
> +	val->mv_size = sb.len + 1;
> +
> +	strbuf_detach(&sb, NULL);
> +	strbuf_release(&path);
> +	return 0;
> +}
> +
> +static void write_per_worktree_ref(const char *submodule, const char *refname,
> +				   MDB_val *val)
> +{
> +	static struct lock_file lock;
> +	int fd;
> +	int len = val->mv_size - 1;
> +	struct strbuf path = STRBUF_INIT;
> +
> +	submodule_path(&path, submodule, refname);
> +	safe_create_leading_directories(path.buf);
> +
> +	fd = hold_lock_file_for_update(&lock, path.buf, LOCK_DIE_ON_ERROR);
> +	strbuf_release(&path);
> +
> +	if (write_in_full(fd, val->mv_data, len) != len ||
> +	    write_in_full(fd, "\n", 1) != 1)
> +		die_errno("failed to write new HEAD");
> +
> +	if (commit_lock_file(&lock))
> +		die_errno("failed to write new HEAD");
> +}
> +
> +static int del_per_worktree_ref(const char *submodule, const char *refname,
> +				MDB_val *val)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	int result;
> +
> +	/*
> +	 * Returning deleted ref data is not yet implemented, but no
> +	 * callers need it.
> +	 */
> +	assert(val == NULL);
> +
> +	submodule_path(&path, submodule, refname);
> +
> +	result = unlink(path.buf);
> +	strbuf_release(&path);
> +	if (result) {
> +		if (errno == ENOENT)
> +			return 0;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mdb_get_or_die(struct lmdb_transaction_info *info, MDB_val *key, MDB_val *val)
> +{
> +	int ret;
> +
> +	if (ref_type(key->mv_data) != REF_TYPE_NORMAL)
> +		return read_per_worktree_ref(info->submodule, key->mv_data, val);
> +
> +	ret = mdb_get(info->txn, info->dbi, key, val);
> +	if (ret) {
> +		if (ret != MDB_NOTFOUND)
> +			die("mdb_get failed: %s", mdb_strerror(ret));
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int mdb_del_or_die(struct lmdb_transaction_info *info, MDB_val *key, MDB_val *val)
> +{
> +	int ret;
> +
> +	if (ref_type(key->mv_data) != REF_TYPE_NORMAL)
> +		return del_per_worktree_ref(info->submodule, key->mv_data, val);
> +
> +	ret = mdb_del(info->txn, info->dbi, key, val);
> +	if (ret) {
> +		if (ret != MDB_NOTFOUND)
> +			die("mdb_del failed: %s", mdb_strerror(ret));
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static void mdb_put_or_die(struct lmdb_transaction_info *info, MDB_val *key, MDB_val *val, int mode)
> +{
> +	int ret;
> +
> +	if (ref_type(key->mv_data) != REF_TYPE_NORMAL) {
> +		write_per_worktree_ref(info->submodule, key->mv_data, val);
> +		return;
> +	}
> +	assert(val->mv_size == 0 || ((char *)val->mv_data)[val->mv_size - 1] == 0);
> +
> +	ret = mdb_put(info->txn, info->dbi, key, val, mode);
> +	if (ret) {
> +		if (ret == MDB_BAD_VALSIZE)
> +			die("Ref name %s too long (max size is %d)",
> +			    (const char *)key->mv_data,
> +			    mdb_env_get_maxkeysize(env));
> +		else
> +			die("mdb_put failed: %s", mdb_strerror(ret));
> +	}
> +}
> +
> +static int mdb_cursor_get_or_die(MDB_cursor *cursor, MDB_val *key, MDB_val *val, int mode)
> +{
> +	int ret;
> +
> +	ret = mdb_cursor_get(cursor, key, val, mode);
> +	if (ret) {
> +		if (ret != MDB_NOTFOUND)
> +			die("mdb_cursor_get failed: %s", mdb_strerror(ret));
> +		return ret;
> +	}
> +	assert(((char *)val->mv_data)[val->mv_size - 1] == 0);
> +	return 0;
> +}
> +
> +static int mdb_cursor_del_or_die(MDB_cursor *cursor, int flags)
> +{
> +	int ret = mdb_cursor_del(cursor, flags);
> +	if (ret) {
> +		if (ret != MDB_NOTFOUND)
> +			die("mdb_cursor_del failed: %s", mdb_strerror(ret));
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Begin a transaction. Because only one transaction per thread is
> + * permitted, we use a global transaction object.  If a read-write
> + * transaction is presently already in-progress, and a read-only
> + * transaction is requested, the read-write transaction will be
> + * returned instead.  If a read-write transaction is requested and a
> + * read-only transaction is open, the read-only transaction will be
> + * closed.
> + *
> + * It is a bug to request a read-write transaction during another
> + * read-write transaction.
> + *
> + * As a result, it is unsafe to retain read-only transactions past the
> + * point where a read-write transaction might be needed.  For
> + * instance, any call that has callbacks outside this module must
> + * conclude all of its reads from the database before calling those
> + * callbacks, or must reacquire the transaction after its callbacks
> + * are completed.
> + */
> +int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int flags)
> +{
> +	int ret;
> +	MDB_txn *txn;
> +	static int last_commands_run = 0;
> +	int force_restart = 0;
> +
> +	init_env(&env, db_path);
> +
> +	if (total_commands_run != last_commands_run) {
> +		/*
> +		 * Since each transaction sees a consistent view of
> +		 * the db, downstream processes that write the db
> +		 * won't be seen in this transaction.  We don't know
> +		 * whether any given downstream process has made any
> +		 * writes, so if there have been any downstream processes,
> +		 * we had better reopen the transaction.
> +		 */

Is it possible to tell from the database whether there has been a write
since the current read transaction was started? It seems like this would
be a more reliable method, given that an unrelated process might have
updated references while this command was running, or a long-running
background process (like Duy's background `git gc --auto`) might still
continue running even after the original command exits.

Of course in the end checks like this can never 100% prevent races. The
only way, it would seem, would be to check-and-set during a single write
transaction that holds a write lock on the DB.

That's exactly what we do for file-based references: ideally, the only
allowed changes are compare-and-set operations that are made atomic by
holding a lock while it is occurring (one or more loose reference
lockfiles and/or the packed-refs lockfile). That is why our ref_updates
have old_sha1 and new_sha1, and old_sha1 is always used for operations
that start before a lock is held.

So I guess my question is this: to what extent are you relying on this
total_commands_run mechanism for correctness, vs. just using it to avoid
using reference values that are *really* old?

It seems to me that a very important feature of Git is the following:

    Two processes *must not* block each other (except possibly
    for a very brief time) if they are updating disjoint sets
    of references.

With the file-backed reference backend, this feature is accomplished via
the following mechanisms:

* Locks are only held for very short periods of time, and never when
  calling other processes.

* Locks usually only apply to single references (loose references).
  Sometimes the packed-refs file has to be locked, but in such cases
  a second writer retries the lock acquisition for long enough that
  it should usually succeed.

* If a reference value was checked before a lock was held, then it
  is always re-checked after acquiring the lock to make sure that
  another process didn't change it in the meantime. (If the
  reference *was* changed from its expected value, it is ok to
  die().) This is necessary to preserve safety even if a lock is
  not held for the duration of a command.

In particular, locks are only held for the duration of the call to
ref_transaction_commit(), *not* while building up a transaction using
ref_transaction_update() etc.

I am afraid that the LMDB backend as currently implemented will be more
subject to locking conflicts because the LMDB locks are broader in both
time and space:

1. You are holding the LMDB transaction open for longer (during the
   whole time that the ref_transaction is being built up). This is
   worse simply because it is a longer time. But it is also worse
   because the process that is building up the transaction might be
   doing other things while holding the write lock. Have you checked
   whether any callers do things that could change references (for
   example, invoke user hooks) between the calls to
   ref_transaction_begin() and ref_transaction_commit()? With the
   files backend this isn't an issue because the lock isn't acquired
   until ref_transaction_commit() is called.

2. The LMDB write lock is database-wide. This means that a single
   writer, even if modifying only a single reference, blocks all
   writes to all references.

Therefore I am worried that the LMDB backend will be susceptable to more
lock conflicts than the files backend.

Would would be the disadvantage of letting ref_transaction_update() and
its friends build up `struct ref_update` objects in memory (much like
they do in the files backend), and only start the LMDB write transaction
when ref_transaction_commit() is called? Obviously it would cost some
more bookkeeping, but that code is already written. This would be much
closer to the files backend model.

This is where I stopped for the day.

I have a bunch of small stylistic and formatting suggestions regarding
this patch in particular. Rather than describe them all in prose, I just
made the suggested changes and pushed them to my GitHub fork [1], branch
"refs-be-lmdb-housecleaning". Feel free to squash the ones you want into
this commit.

A lot of these problems were found by gcc, which I apparently have
configured more strictly than yours. You might want to pick some options
from my config.mak [2] to make gcc enforce some of the Git project
policies automatically. (Every dev on this list probably has his/her own
variation on this file.)

I apologize again for not having reviewed your patches more promptly. I
really think it is good and important work. I've just been so busy with
other things and I knew it would take a couple of solid days of work to
get through it. I'll try to review the rest tomorrow, but since I don't
know anything about the LMDB API, the review will either be superficial
or it will take a long time...

Let me finish up by stating (also to remind myself!) that it is not
crucial to get everything perfect in the first iteration. As long as the
database format is correct, other things can be improved over time. This
reference backend will inevitably go though a longish period when it is
considered experimental, during which we will have time to hammer bugs
out of it.

Michael

[1] https://github.com/mhagger/git
[2] https://gist.github.com/mhagger/b321e423481b3de405d2

-- 
Michael Haggerty
mhagger@alum.mit.edu
