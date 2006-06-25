From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 5/7] Make it possible to set up libgit directly (instead of from the environment)
Date: Sun, 25 Jun 2006 03:54:30 +0200
Message-ID: <20060625015430.29906.5569.stgit@machine.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJpg-0006BB-Ie
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWFYByd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWFYByd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1706 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751352AbWFYByc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:32 -0400
Received: (qmail 29974 invoked from network); 25 Jun 2006 03:54:30 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:30 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22575>

This introduces a setup_git() function which is essentialy a (public)
backend for setup_git_env() which lets anyone specify custom sources
for the various paths instead of environment variables. Since the repositories
may get switched on the fly, this also updates code that caches paths to
invalidate them properly; I hope neither of those is a sweet spot.

It is used by Git.xs' xs__call_gate() to set up per-repository data
for libgit's consumption. No code actually takes advantage of it yet
but get_object() will in the next patches.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 cache.h       |    3 +++
 commit.c      |   23 +++++++++++++++++++----
 environment.c |   45 +++++++++++++++++++++++++++++++++++++++------
 perl/Git.pm   |    8 ++++----
 perl/Git.xs   |   16 +++++++++++++++-
 sha1_file.c   |   30 ++++++++++++++++++++++++------
 sha1_name.c   |   10 ++++++++--
 7 files changed, 112 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index efeafea..9844e88 100644
--- a/cache.h
+++ b/cache.h
@@ -116,6 +116,9 @@ extern struct cache_entry **active_cache
 extern unsigned int active_nr, active_alloc, active_cache_changed;
 extern struct cache_tree *active_cache_tree;
 
+extern void setup_git(char *new_git_dir, char *new_git_object_dir,
+                      char *new_git_index_file, char *new_git_graft_file);
+
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
diff --git a/commit.c b/commit.c
index 946615d..6c4acc2 100644
--- a/commit.c
+++ b/commit.c
@@ -163,6 +163,14 @@ int register_commit_graft(struct commit_
 	return 0;
 }
 
+void free_commit_grafts(void)
+{
+	int pos = commit_graft_nr;
+	while (pos >= 0)
+		free(commit_graft[pos--]);
+	commit_graft_nr = 0;
+}
+
 struct commit_graft *read_graft_line(char *buf, int len)
 {
 	/* The format is just "Commit Parent1 Parent2 ...\n" */
@@ -215,11 +223,18 @@ int read_graft_file(const char *graft_fi
 static void prepare_commit_graft(void)
 {
 	static int commit_graft_prepared;
-	char *graft_file;
+	static char *last_graft_file;
+	char *graft_file = get_graft_file();
+
+	if (last_graft_file) {
+		if (!strcmp(graft_file, last_graft_file))
+			return;
+		free_commit_grafts();
+	}
+	if (last_graft_file)
+		free(last_graft_file);
+	last_graft_file = strdup(graft_file);
 
-	if (commit_graft_prepared)
-		return;
-	graft_file = get_graft_file();
 	read_graft_file(graft_file);
 	commit_graft_prepared = 1;
 }
diff --git a/environment.c b/environment.c
index 3de8eb3..6b64d11 100644
--- a/environment.c
+++ b/environment.c
@@ -21,28 +21,61 @@ char git_commit_encoding[MAX_ENCODING_LE
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
 
+static int dyn_git_object_dir, dyn_git_index_file, dyn_git_graft_file;
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
-static void setup_git_env(void)
+
+void setup_git(char *new_git_dir, char *new_git_object_dir,
+               char *new_git_index_file, char *new_git_graft_file)
 {
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
+	git_dir = new_git_dir;
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
-	git_object_dir = getenv(DB_ENVIRONMENT);
+
+	if (dyn_git_object_dir)
+		free(git_object_dir);
+	git_object_dir = new_git_object_dir;
 	if (!git_object_dir) {
 		git_object_dir = xmalloc(strlen(git_dir) + 9);
 		sprintf(git_object_dir, "%s/objects", git_dir);
+		dyn_git_object_dir = 1;
+	} else {
+		dyn_git_object_dir = 0;
 	}
+
+	if (git_refs_dir)
+		free(git_refs_dir);
 	git_refs_dir = xmalloc(strlen(git_dir) + 6);
 	sprintf(git_refs_dir, "%s/refs", git_dir);
-	git_index_file = getenv(INDEX_ENVIRONMENT);
+
+	if (dyn_git_index_file)
+		free(git_index_file);
+	git_index_file = new_git_index_file;
 	if (!git_index_file) {
 		git_index_file = xmalloc(strlen(git_dir) + 7);
 		sprintf(git_index_file, "%s/index", git_dir);
+		dyn_git_index_file = 1;
+	} else {
+		dyn_git_index_file = 0;
 	}
-	git_graft_file = getenv(GRAFT_ENVIRONMENT);
-	if (!git_graft_file)
+
+	if (dyn_git_graft_file)
+		free(git_graft_file);
+	git_graft_file = new_git_graft_file;
+	if (!git_graft_file) {
 		git_graft_file = strdup(git_path("info/grafts"));
+		dyn_git_graft_file = 1;
+	} else {
+		dyn_git_graft_file = 0;
+	}
+}
+
+static void setup_git_env(void)
+{
+	setup_git(getenv(GIT_DIR_ENVIRONMENT),
+	          getenv(DB_ENVIRONMENT),
+	          getenv(INDEX_ENVIRONMENT),
+	          getenv(GRAFT_ENVIRONMENT));
 }
 
 char *get_git_dir(void)
diff --git a/perl/Git.pm b/perl/Git.pm
index 1c3a2ec..c490e0c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -92,6 +92,7 @@ increate nonwithstanding).
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
+use Scalar::Util;
 
 require XSLoader;
 XSLoader::load('Git', $VERSION);
@@ -822,11 +823,10 @@ sub _call_gate {
 	if (defined $self) {
 		# XXX: We ignore the WorkingCopy! To properly support
 		# that will require heavy changes in libgit.
+		# For now, when we will need to do it we could temporarily
+		# chdir() there and then chdir() back after the call is done.
 
-		# XXX: And we ignore everything else as well. libgit
-		# at least needs to be extended to let us specify
-		# the $GIT_DIR instead of looking it up in environment.
-		#xs_call_gate($self->{opts}->{Repository});
+		xs__call_gate(Scalar::Util::refaddr($self), $self->repo_path());
 	}
 
 	# Having to call throw from the C code is a sure path to insanity.
diff --git a/perl/Git.xs b/perl/Git.xs
index 2fd1c67..4e85d69 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -59,7 +59,21 @@ BOOT:
 }
 
 
-# /* TODO: xs_call_gate(). See Git.pm. */
+void
+xs__call_gate(repoid, git_dir)
+	long repoid;
+	char *git_dir;
+CODE:
+{
+	static long last_repoid;
+	if (repoid != last_repoid) {
+		setup_git(git_dir,
+		          getenv(DB_ENVIRONMENT),
+		          getenv(INDEX_ENVIRONMENT),
+		          getenv(GRAFT_ENVIRONMENT));
+		last_repoid = repoid;
+	}
+}
 
 
 const char *
diff --git a/sha1_file.c b/sha1_file.c
index c80528b..8d24f50 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -126,16 +126,22 @@ static void fill_sha1_path(char *pathbuf
 char *sha1_file_name(const unsigned char *sha1)
 {
 	static char *name, *base;
+	static const char *last_objdir;
+	const char *sha1_file_directory = get_object_directory();
 
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
+	if (!last_objdir || strcmp(last_objdir, sha1_file_directory)) {
 		int len = strlen(sha1_file_directory);
+		if (base)
+			free(base);
 		base = xmalloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
 		memset(base+len, 0, 60);
 		base[len] = '/';
 		base[len+3] = '/';
 		name = base + len + 1;
+		if (last_objdir)
+			free((char *) last_objdir);
+		last_objdir = strdup(sha1_file_directory);
 	}
 	fill_sha1_path(name, sha1);
 	return base;
@@ -145,14 +151,20 @@ char *sha1_pack_name(const unsigned char
 {
 	static const char hex[] = "0123456789abcdef";
 	static char *name, *base, *buf;
+	static const char *last_objdir;
+	const char *sha1_file_directory = get_object_directory();
 	int i;
 
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
+	if (!last_objdir || strcmp(last_objdir, sha1_file_directory)) {
 		int len = strlen(sha1_file_directory);
+		if (base)
+			free(base);
 		base = xmalloc(len + 60);
 		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
 		name = base + len + 11;
+		if (last_objdir)
+			free((char *) last_objdir);
+		last_objdir = strdup(sha1_file_directory);
 	}
 
 	buf = name;
@@ -170,14 +182,20 @@ char *sha1_pack_index_name(const unsigne
 {
 	static const char hex[] = "0123456789abcdef";
 	static char *name, *base, *buf;
+	static const char *last_objdir;
+	const char *sha1_file_directory = get_object_directory();
 	int i;
 
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
+	if (!last_objdir || strcmp(last_objdir, sha1_file_directory)) {
 		int len = strlen(sha1_file_directory);
+		if (base)
+			free(base);
 		base = xmalloc(len + 60);
 		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.idx", sha1_file_directory);
 		name = base + len + 11;
+		if (last_objdir)
+			free((char *) last_objdir);
+		last_objdir = strdup(sha1_file_directory);
 	}
 
 	buf = name;
diff --git a/sha1_name.c b/sha1_name.c
index cd85d1f..1451cb6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -12,15 +12,21 @@ static int find_short_object_filename(in
 	char hex[40];
 	int found = 0;
 	static struct alternate_object_database *fakeent;
+	static const char *last_objdir;
+	const char *objdir = get_object_directory();
 
-	if (!fakeent) {
-		const char *objdir = get_object_directory();
+	if (!last_objdir || strcmp(last_objdir, objdir)) {
 		int objdir_len = strlen(objdir);
 		int entlen = objdir_len + 43;
+		if (fakeent)
+			free(fakeent);
 		fakeent = xmalloc(sizeof(*fakeent) + entlen);
 		memcpy(fakeent->base, objdir, objdir_len);
 		fakeent->name = fakeent->base + objdir_len + 1;
 		fakeent->name[-1] = '/';
+		if (last_objdir)
+			free((char *) last_objdir);
+		last_objdir = strdup(objdir);
 	}
 	fakeent->next = alt_odb_list;
 
