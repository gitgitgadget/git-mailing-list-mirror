From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Wed, 23 Dec 2015 15:32:30 +0100
Message-ID: <567AB07E.1010803@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-16-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 15:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBka1-000148-FW
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 15:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257AbbLWOjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 09:39:49 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43400 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752956AbbLWOjr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 09:39:47 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2015 09:39:47 EST
X-AuditID: 1207440e-f79516d0000012b3-37-567ab0805284
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id FA.B9.04787.080BA765; Wed, 23 Dec 2015 09:32:32 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBNEWU6n028123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 09:32:31 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <1449102921-7707-16-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42IRYndR1G3YUBVmcLNVy2L+phOMFl1Xupkc
	mDwWPL/P7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8baG/IFi/sYK17+mcrSwLi0oIuRk0NCwETi
	9o43zBC2mMSFe+vZuhi5OIQELjNKHNt1hRnCucAk8fDKBnaQKmEBM4ltjx6wgtgiAg4Sl3cd
	hSpqY5TYv206WBGbgK7Eop5mJoixchK93ZNYQGxeAW2Jw9/OgzWzCKhKNCydDbZaVCBEYu/O
	DqgaQYmTM5+A2ZwCnhITLswBs5kF9CR2XP/FCmHLSzRvnc08gVFgFpKWWUjKZiEpW8DIvIpR
	LjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJFj5djC2r5c5xCjAwajEw+vYVhkm
	xJpYVlyZe4hRkoNJSZQ3uqoqTIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb/o7oHLelMTKqtSi
	fJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSv93qgoYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgaI0vBsYrSIoHaO9akHbe4oLEXKAoROspRkUpcd7LIAkBkERGaR7c
	WFgKesUoDvSlMG8CSBUPMH3Bdb8CGswENPjPunKQwSWJCCmpBkbfZf+aty/MX3FXMnBbtHuo
	eXe/2EHheS+0Txy20TD8OnHPtbOmwutfTOG9cvjgnfBWZ/a0bVPm2IcVcLzPuBW9wKvn+Ivn
	85pelCtZz6nvLdq56eJ9r9xd9/MzykRFyz39wqMO7nv4g9mtVXK6AbdkhPdX2WPb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282948>

On 12/03/2015 01:35 AM, David Turner wrote:
> Add a database backend for refs using LMDB.  This backend runs git
> for-each-ref about 30% faster than the files backend with fully-packed
> refs on a repo with ~120k refs.  It's also about 4x faster than using
> fully-unpacked refs.  In addition, and perhaps more importantly, it
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
> 
> Ronnie Sahlberg's original version of this patchset used tdb.  The
> major disadvantage of tdb is that tdb is hard to build on OS X.  It's
> also not in homebrew.  So lmdb seemed simpler.
> 
> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend. Dozens
> of tests use manual ref/reflog reading/writing, or create submodules
> without passing --refs-backend-type to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-lmdb-backend (or,
> in the case of packed-refs, corrupt refs, and dumb fetch tests, are
> skipped), the only remaining failing tests are the git-new-workdir
> tests and the gitweb tests.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  .gitignore                                     |    1 +
>  Documentation/config.txt                       |    7 +
>  Documentation/git-clone.txt                    |    2 +-
>  Documentation/git-init.txt                     |    3 +-
>  Documentation/technical/refs-lmdb-backend.txt  |   50 +
>  Documentation/technical/repository-version.txt |    5 +
>  Makefile                                       |   12 +
>  builtin/init-db.c                              |   10 +-
>  config.c                                       |   20 +-
>  configure.ac                                   |   33 +
>  contrib/workdir/git-new-workdir                |    3 +
>  refs.h                                         |    1 +
>  refs/lmdb-backend.c                            | 2054 ++++++++++++++++++++++++
>  setup.c                                        |   22 +-
>  test-refs-lmdb-backend.c                       |   68 +
>  15 files changed, 2279 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/technical/refs-lmdb-backend.txt
>  create mode 100644 refs/lmdb-backend.c
>  create mode 100644 test-refs-lmdb-backend.c
> 
> diff --git a/.gitignore b/.gitignore
> index 1c2f832..87d45a2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -199,6 +199,7 @@
>  /test-path-utils
>  /test-prio-queue
>  /test-read-cache
> +/test-refs-lmdb-backend
>  /test-regex
>  /test-revision-walking
>  /test-run-command
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f617886..5fb25ed 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -496,6 +496,13 @@ core.repositoryFormatVersion::
>  	Internal variable identifying the repository format and layout
>  	version.
>  
> +core.refsBackendType::
> +	Type of refs backend. Default is to use the original files
> +	based backend. Set to 'lmdb' to activate the lmdb database
> +	backend.  If you use the lmdb backend,
> +	core.repositoryFormatVersion must be set to 1, and
> +	extensions.refBackend must be set to 'lmdb'.

This phrasing makes it sound like I can go into an existing repository,
change this repository setting, and *presto* I will have a LMDB-backed
repository. I suggest rewording it more along the lines of "this setting
reflects the refs backend that is currently in use".

Also please see my earlier question about whether users should see the
term "backend" or whether other terms would be easier to understand.

> +
>  core.sharedRepository::
>  	When 'group' (or 'true'), the repository is made shareable between
>  	several users in a group (making sure all the files and objects are
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 431575b..739c116 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -224,7 +224,7 @@ objects from the source repository into a pack in the cloned repository.
>  
>  --refs-backend-type=<name>::
>  	Type of refs backend. Default is to use the original files based
> -	backend.
> +	backend. Set to "lmdb" to activate the lmdb database backend.
>  
>  <repository>::
>  	The (possibly remote) repository to clone from.  See the
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 9ea6753..bbe253f 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -115,7 +115,8 @@ does not exist, it will be created.
>  
>  --refs-backend-type=<name>::
>  Type of refs backend. Default is to use the original "files" backend,
> -which stores ref data in files in .git/refs and .git/packed-refs.
> +which stores ref data in files in .git/refs and .git/packed-refs.  Set
> +to "lmdb" to activate the lmdb database backend.
>  
>  TEMPLATE DIRECTORY
>  ------------------
> diff --git a/Documentation/technical/refs-lmdb-backend.txt b/Documentation/technical/refs-lmdb-backend.txt
> new file mode 100644
> index 0000000..c497ffc
> --- /dev/null
> +++ b/Documentation/technical/refs-lmdb-backend.txt
> @@ -0,0 +1,50 @@
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
> +Values are the value of the ref, in hex
> +(e.g. 61f23eb0f81357c19fa91e2b8c6f3906c3a8f9b0).
> +
> +All per-worktree refs (refs/bisect/* and HEAD) are store using

s/store/stored/

> +the traditional files-based backend.
> +
> +Reflogs are stored as a series of database entries.
> +
> +For non-empty reflogs, there is one entry per logged ref
> +update.  The key format is logs/[refname]\0[timestamp].  The timestamp
> +is a 64-bit unsigned integer number of nanoseconds since 1/1/1970.
> +This means that reflog entries are chronologically ordered.  Because
> +LMDB is a btree database, we can efficiently iterate over these keys.

Is there a guarantee that the reflog entries for all references updated
in a single transaction have the same timestamp? Is there a guarantee
that updates that happened in *different* transactions have different
timestamps? These might be useful properties if they are easy to
implement, because then one could deduce the scope of transactions from
the reflog. But of course, they admittedly go beyond what the files
backend offers and so are not a requirement.

Is the timestamp in ASCII base 10, binary format, or or something else?

> +For an empty reflog, there is a "header" entry to show that a reflog
> +exists.  The header has the same format as an ordinary reflog, but with
> +a timeztamp of all zeros and an empty value.
> +
> +Reflog values are in the same format as the original files-based
> +reflog.

I assume that means that each entry has the same contents as one line
from a reflog file. Does the value include a trailing LF? (From above I
guess it does have a trailing NUL.)

Is the timestamp within the reflog entry guaranteed to agree with the
timestamp in the key? This might be a convenient property for debugging.

> +Weaknesses:
> +-----------
> +
> +The reflog format is somewhat inefficient: a binary format could store
> +reflog date/time information in somewhat less space.
> +
> +The rsync and file:// transports don't work yet, because they
> +don't use the refs API.
> +
> +git new-workdir is incompatible with the lmdb backend.  Fortunately,
> +git new-workdir is deprecated, and worktrees work fine.
> +
> +LMDB locks the entire database for write.  Any other writer waits
> +until the first writer is done before beginning.  Readers do not wait
> +for writers, and writers do not wait for readers.  The underlying
> +scheme is approximately MVCC; each reader's queries see the state of
> +the database as-of the time that the reader acquired its read lock.
> +This is not too far off from the files backend, which loads all refs
> +into memory when one is requested.
> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> index 00ad379..04c085d 100644
> --- a/Documentation/technical/repository-version.txt
> +++ b/Documentation/technical/repository-version.txt
> @@ -86,3 +86,8 @@ for testing format-1 compatibility.
>  When the config key `extensions.preciousObjects` is set to `true`,
>  objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
>  `git repack -d`).
> +
> +`refBackend`
> +~~~~~~~~~~~~
> +This extension allows the user of alternate ref backends.  The only
> +defined value is `lmdb`.

s/user/use/

> diff --git a/Makefile b/Makefile
> index 5bd68e0..77b96d9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1037,6 +1037,17 @@ ifdef USE_LIBPCRE
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
> +	LIB_OBJS += refs/lmdb-backend.o
> +	TEST_PROGRAMS_NEED_X += test-refs-lmdb-backend
> +endif
> +
>  ifdef HAVE_ALLOCA_H
>  	BASIC_CFLAGS += -DHAVE_ALLOCA_H
>  endif
> @@ -2124,6 +2135,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
>  	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
>  	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
> +	@echo USE_LIBLMDB=\''$(subst ','\'',$(subst ','\'',$(USE_LIBLMDB)))'\' >>$@+
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 44db591..1eb2feb 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -179,6 +179,7 @@ static int create_default_files(const char *template_path)
>  	int reinit;
>  	int filemode;
>  	struct strbuf err = STRBUF_INIT;
> +	int repo_version = 0;
>  
>  	/* Just look for `init.templatedir` */
>  	git_config(git_init_db_config, NULL);
> @@ -209,7 +210,14 @@ static int create_default_files(const char *template_path)
>  		git_config_set("core.refsBackendType", refs_backend_type);
>  		config_data.refs_backend_type = refs_backend_type;
>  		config_data.refs_base = get_git_dir();
> +#ifdef USE_LIBLMDB
> +		register_refs_backend(&refs_be_lmdb);
> +#endif
>  		set_refs_backend(refs_backend_type, &config_data);
> +		if (!strcmp(refs_backend_type, "lmdb")) {

Wouldn't expressing this condition as

    if (strcmp(refs_backend_type, "files"))

better reflect the reason that we might need to set
"extensions.refBackend" and use repo_version "1"? (You might also need a
"refs_backend_type &&" and/or a "*refs_backend_type &&" in there.)

> +			git_config_set("extensions.refbackend", "lmdb");
> +			repo_version = 1;
> +		}
>  	}
>  
>  	if (refs_init_db(&err, shared_repository))
> @@ -229,7 +237,7 @@ static int create_default_files(const char *template_path)
>  
>  	/* This forces creation of new config file */
>  	xsnprintf(repo_version_string, sizeof(repo_version_string),
> -		  "%d", GIT_REPO_VERSION);
> +		  "%d", repo_version);
>  	git_config_set("core.repositoryformatversion", repo_version_string);
>  
>  	/* Check filemode trustability */
> diff --git a/config.c b/config.c
> index 210aa08..779bb73 100644
> --- a/config.c
> +++ b/config.c
> @@ -1222,9 +1222,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  		refdb_data.refs_base = xstrdup(dirname(repo_config_copy));
>  		free(repo_config_copy);
>  
> -		if (refdb_data.refs_backend_type &&
> -		    strcmp(refdb_data.refs_backend_type, "files")) {
> -			die("Unexpected backend %s", refdb_data.refs_backend_type);
> +		if (!refdb_data.refs_backend_type)
> +			refdb_data.refs_backend_type = "";
> +
> +		if ((!*refdb_data.refs_backend_type) ||
> +		    (!strcmp(refdb_data.refs_backend_type, "files"))) {
> +			/* default backend, nothing to do */
> +		} else if (!strcmp(refdb_data.refs_backend_type, "lmdb")) {
> +
> +#ifdef USE_LIBLMDB
> +			refs_backend_type = refdb_data.refs_backend_type;
> +			register_refs_backend(&refs_be_lmdb);
> +			set_refs_backend(refs_backend_type, &refdb_data);
> +#else
> +			die("Git was not built with USE_LIBLMDB, so the db refs backend is not available");
> +#endif
> +		} else {
> +			die("Unknown ref backend type '%s'", refdb_data.refs_backend_type);
>  		}
>  
>  		ret += git_config_from_file(fn, repo_config, data);
> diff --git a/configure.ac b/configure.ac
> index 89e2590..3853bec 100644
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
> index 888c34a..66b7ecf 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -28,6 +28,9 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
>    git rev-parse --git-dir 2>/dev/null) ||
>    die "Not a git repository: \"$orig_git\""
>  
> +
> +test "$(git config core.refsbackendtype)" = "lmdb" && die "git-new-workdir is incompatible with the refs lmdb backend"
> +
>  case "$git_dir" in
>  .git)
>  	git_dir="$orig_git/.git"
> diff --git a/refs.h b/refs.h
> index c3670e8..0cbfda9 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -520,6 +520,7 @@ struct refdb_config_data {
>  int refdb_config(const char *var, const char *value, void *ptr);
>  
>  struct ref_be;
> +extern struct ref_be refs_be_lmdb;
>  int set_refs_backend(const char *name, void *data);
>  
>  void register_refs_backend(struct ref_be *be);
> diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
> [...]
> [...]
> [...]
> [...]
> [...]
> diff --git a/setup.c b/setup.c
> index de6b8ac..9724c0b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -279,10 +279,11 @@ int refdb_config(const char *var, const char *value, void *ptr)
>   *
>   *  - either an objects/ directory _or_ the proper
>   *    GIT_OBJECT_DIRECTORY environment variable
> - *  - a refs/ directory
> - *  - either a HEAD symlink or a HEAD file that is formatted as
> - *    a proper "ref:", or a regular file HEAD that has a properly
> - *    formatted sha1 object name.
> + *  - a refdb/ directory or
> + *    - a refs/ directory
> + *    - either a HEAD symlink or a HEAD file that is formatted as
> + *      a proper "ref:", or a regular file HEAD that has a properly
> + *      formatted sha1 object name.

The indentation looks wrong here. I think the requirement is

*  - either a refdb/ directory or a refs/ directory
*  - either a HEAD symlink or a HEAD file that is formatted as
*    a proper "ref:", or a regular file HEAD that has a properly
*    formatted sha1 object name.

though the test of the *contents* of HEAD is currently skipped for
non-files backends.

>   */
>  int is_git_directory(const char *suspect)
>  {
> @@ -313,8 +314,13 @@ int is_git_directory(const char *suspect)
>  
>  	strbuf_setlen(&path, len);
>  	strbuf_addstr(&path, "/refs");
> -	if (access(path.buf, X_OK))
> -		goto done;
> +
> +	if (access(path.buf, X_OK)) {
> +		strbuf_setlen(&path, len);
> +		strbuf_addstr(&path, "/refdb");
> +		if (access(path.buf, X_OK))
> +			goto done;
> +	}
>  
>  	ret = 1;
>  done:
> @@ -383,6 +389,10 @@ static int check_repo_format(const char *var, const char *value, void *cb)
>  			;
>  		else if (!strcmp(ext, "preciousobjects"))
>  			repository_format_precious_objects = git_config_bool(var, value);
> +#ifdef USE_LIBLMDB
> +		else if (!strcmp(ext, "refbackend") && !strcmp(value, "lmdb"))
> +			;
> +#endif
>  		else
>  			string_list_append(&unknown_extensions, ext);
>  	}
> diff --git a/test-refs-lmdb-backend.c b/test-refs-lmdb-backend.c
> [...]

I haven't actually reviewed the LMDB-specific code, just the glue code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
