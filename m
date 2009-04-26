From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and
 gid
Date: Sun, 26 Apr 2009 12:25:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904261159190.7331@localhost.localdomain>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com> <200904261306.15448.robin.rosenberg.lists@dewire.com> <7vocujjm5r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyA2V-0004PM-SN
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 21:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbZDZT1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 15:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZDZT1s
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 15:27:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51107 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752649AbZDZT1q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 15:27:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3QJPEJ8012324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Apr 2009 12:25:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3QJPDkC009997;
	Sun, 26 Apr 2009 12:25:13 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vocujjm5r.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.456 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117623>



On Sun, 26 Apr 2009, Junio C Hamano wrote:
> 
> I had a similar patch that disables inum checking in my private tree for
> different reasons of my own; the set of fields your patch ignores is a
> compatible superset of, and I think makes more sense than, what I was
> planning to do, so no objections from me on this _optional_ feature.

Maybe we should just remove those checks entirely?

I started out wanting to check the stat information as much as possible, 
but realistically, nobody probably really cares. We already effectively 
removed st_dev checking and nsec checks.

And ctime checks can be turned off because they were so annoying for the 
crazy gnome 'beagle' piece-of-sh*t that changes ctime while indexing 
files.

So in the end, maybe we should just agree to only care about mtime and 
inode size. And just remove the rest in the name of least annoyances with 
broken systems.

IOW, maybe we should just do this, and remove over a hundred lines of dead 
code or commentary/config. And never have to worry about these kinds of 
issues with different environments again.

I dunno. This is one of my "throw-away" patches. Apply it or not, I don't 
really care. But if you want to apply it, you can have my sign-off:

	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

(I'm leaving the fields in the cache-entry, along with the nsec fields, 
but I guess they could be removed too, for yet a few more lines removed)

			Linus

---
 Documentation/config.txt               |    7 -----
 Documentation/git-update-index.txt     |    5 ---
 Documentation/technical/racy-git.txt   |    8 ------
 Makefile                               |   20 ---------------
 builtin-fetch-pack.c                   |    8 +----
 cache.h                                |    1 -
 config.c                               |    4 ---
 configure.ac                           |   10 -------
 contrib/completion/git-completion.bash |    1 -
 environment.c                          |    1 -
 git-compat-util.h                      |   14 ----------
 read-cache.c                           |   43 +++----------------------------
 12 files changed, 7 insertions(+), 115 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 35056e1..c256180 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -128,13 +128,6 @@ core.ignoreCygwinFSTricks::
 	is true, in which case ignoreCygwinFSTricks is ignored as Cygwin's
 	POSIX emulation is required to support core.filemode.
 
-core.trustctime::
-	If false, the ctime differences between the index and the
-	working copy are ignored; useful when the inode change time
-	is regularly modified by something outside Git (file system
-	crawlers and some backup systems).
-	See linkgit:git-update-index[1]. True by default.
-
 core.quotepath::
 	The commands that output paths (e.g. 'ls-files',
 	'diff'), when not given the `-z` option, will quote
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 25e0bbe..b7ab71b 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -323,11 +323,6 @@ from symbolic link to regular file.
 The command looks at `core.ignorestat` configuration variable.  See
 'Using "assume unchanged" bit' section above.
 
-The command also looks at `core.trustctime` configuration variable.
-It can be useful when the inode change time is regularly modified by
-something outside Git (file system crawlers and backup systems use
-ctime for marking files processed) (see linkgit:git-config[1]).
-
 
 SEE ALSO
 --------
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 48bb97f..dff8ee3 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -37,14 +37,6 @@ is not useful.  Currently, git compares the file type (regular
 files vs symbolic links) and executable bits (only for regular
 files) from `st_mode` member, `st_mtime` and `st_ctime`
 timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
-With a `USE_STDEV` compile-time option, `st_dev` is also
-compared, but this is not enabled by default because this member
-is not stable on network filesystems.  With `USE_NSEC`
-compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
-members are also compared, but this is not enabled by default
-because the value of this member becomes meaningless once the
-inode is evicted from the inode cache on filesystems that do not
-store it on disk.
 
 
 Racy git
diff --git a/Makefile b/Makefile
index 49f36f5..9b27fe2 100644
--- a/Makefile
+++ b/Makefile
@@ -120,21 +120,9 @@ all::
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
 #
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
 # Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
 # "st_ctim"
 #
-# Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
-# available.  This automatically turns USE_NSEC off.
-#
-# Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-index perspective.
-#
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
@@ -766,7 +754,6 @@ ifeq ($(uname_S),AIX)
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_STRLCPY = YesPlease
-	NO_NSEC = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
@@ -832,7 +819,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	RUNTIME_PREFIX = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
@@ -956,15 +942,9 @@ endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
-ifdef USE_NSEC
-	BASIC_CFLAGS += -DUSE_NSEC
-endif
 ifdef USE_ST_TIMESPEC
 	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
 endif
-ifdef NO_NSEC
-	BASIC_CFLAGS += -DNO_NSEC
-endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS += -DNO_C99_FORMAT
 endif
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 5d134be..c980a48 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -800,15 +800,11 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		int fd;
 
 		mtime.sec = st.st_mtime;
-		mtime.nsec = ST_MTIME_NSEC(st);
+		mtime.nsec = 0;
 		if (stat(shallow, &st)) {
 			if (mtime.sec)
 				die("shallow file was removed during fetch");
-		} else if (st.st_mtime != mtime.sec
-#ifdef USE_NSEC
-				|| ST_MTIME_NSEC(st) != mtime.nsec
-#endif
-			  )
+		} else if (st.st_mtime != mtime.sec)
 			die("shallow file was changed during fetch");
 
 		fd = hold_lock_file_for_update(&lock, shallow,
diff --git a/cache.h b/cache.h
index ab1294d..ca0510f 100644
--- a/cache.h
+++ b/cache.h
@@ -499,7 +499,6 @@ extern int delete_ref(const char *, const unsigned char *sha1, int delopt);
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int trust_ctime;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int ignore_case;
diff --git a/config.c b/config.c
index 8c1ae59..d3619ab 100644
--- a/config.c
+++ b/config.c
@@ -360,10 +360,6 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
-		return 0;
-	}
 
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
diff --git a/configure.ac b/configure.ac
index 4e728bc..9d49ad1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -225,16 +225,6 @@ GIT_PARSE_WITH(iconv))
 
 ## --enable-FEATURE[=ARG] and --disable-FEATURE
 #
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
-# Define USE_STDEV below if you want git to care about the underlying device
-# change being considered an inode change from the update-index perspective.
-
-#
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
 #
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1a90cb8..1d0402c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1447,7 +1447,6 @@ _git_config ()
 		core.safecrlf
 		core.sharedRepository
 		core.symlinks
-		core.trustctime
 		core.warnAmbiguousRefs
 		core.whitespace
 		core.worktree
diff --git a/environment.c b/environment.c
index 4696885..a2497b9 100644
--- a/environment.c
+++ b/environment.c
@@ -13,7 +13,6 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
-int trust_ctime = 1;
 int has_symlinks = 1;
 int ignore_case;
 int assume_unchanged;
diff --git a/git-compat-util.h b/git-compat-util.h
index 785aa31..6678e4d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -394,20 +394,6 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 # define FORCE_DIR_SET_GID 0
 #endif
 
-#ifdef NO_NSEC
-#undef USE_NSEC
-#define ST_CTIME_NSEC(st) 0
-#define ST_MTIME_NSEC(st) 0
-#else
-#ifdef USE_ST_TIMESPEC
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
-#else
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
-#endif
-#endif
-
 #ifdef UNRELIABLE_FSTAT
 #define fstat_is_reliable() 0
 #else
diff --git a/read-cache.c b/read-cache.c
index 3f58711..9a452b0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -69,8 +69,8 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 {
 	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
 	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
-	ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
-	ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
+	ce->ce_ctime.nsec = 0;
+	ce->ce_mtime.nsec = 0;
 	ce->ce_dev = st->st_dev;
 	ce->ce_ino = st->st_ino;
 	ce->ce_uid = st->st_uid;
@@ -200,31 +200,6 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
-
-#ifdef USE_NSEC
-	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
-#endif
-
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
-		changed |= INODE_CHANGED;
-
-#ifdef USE_STDEV
-	/*
-	 * st_dev breaks on network filesystems where different
-	 * clients will have different views of what "device"
-	 * the filesystem is on
-	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
-		changed |= INODE_CHANGED;
-#endif
 
 	if (ce->ce_size != (unsigned int) st->st_size)
 		changed |= DATA_CHANGED;
@@ -242,15 +217,7 @@ static int is_racy_timestamp(const struct index_state *istate, struct cache_entr
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
 		istate->timestamp.sec &&
-#ifdef USE_NSEC
-		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < ce->ce_mtime.sec ||
-		 (istate->timestamp.sec == ce->ce_mtime.sec &&
-		  istate->timestamp.nsec <= ce->ce_mtime.nsec))
-#else
-		istate->timestamp.sec <= ce->ce_mtime.sec
-#endif
-		 );
+		istate->timestamp.sec <= ce->ce_mtime.sec);
 }
 
 int ie_match_stat(const struct index_state *istate,
@@ -1299,7 +1266,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		dst_offset += ce_size(ce);
 	}
 	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	istate->timestamp.nsec = 0;
 
 	while (src_offset <= mmap_size - 20 - 8) {
 		/* After an array of active_nr index entries,
@@ -1564,7 +1531,7 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
+	istate->timestamp.nsec = 0;
 	return 0;
 }
 
