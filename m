From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] avoid marking char arrays static when they don't have to
Date: Tue, 23 Feb 2010 22:34:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002232231110.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 04:34:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk81R-00054C-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 04:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab0BXDen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 22:34:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63564 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108Ab0BXDem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 22:34:42 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KYB00G0PTXTX3C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 23 Feb 2010 22:34:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140895>

Many arrays of size PATH_MAX are marked static and therefore enlarge
the .bss segment uselessly.

Before:

   text    data     bss     dec     hex filename
1076212   21004  309216 1406432  1575e0 git

After:

   text    data     bss     dec     hex filename
1076124   21004  263872 1361000  14c468 git

Only the trivial cases were modified.  Many still remain.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

diff --git a/builtin-index-pack.c b/builtin-index-pack.c
index b4cf8c5..eb7e5b3 100644
--- a/builtin-index-pack.c
+++ b/builtin-index-pack.c
@@ -171,7 +171,7 @@ static const char *open_pack_file(const char *pack_name)
 	if (from_stdin) {
 		input_fd = 0;
 		if (!pack_name) {
-			static char tmpfile[PATH_MAX];
+			char tmpfile[PATH_MAX];
 			output_fd = odb_mkstemp(tmpfile, sizeof(tmpfile),
 						"pack/tmp_pack_XXXXXX");
 			pack_name = xstrdup(tmpfile);
diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..9ebb6dd 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -169,7 +169,7 @@ static int create_default_files(const char *template_path)
 {
 	const char *git_dir = get_git_dir();
 	unsigned len = strlen(git_dir);
-	static char path[PATH_MAX];
+	char path[PATH_MAX];
 	struct stat st1;
 	char repo_version_string[10];
 	char junk[2];
@@ -443,7 +443,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		usage(init_db_usage[0]);
 	}
 	if (is_bare_repository_cfg == 1) {
-		static char git_dir[PATH_MAX+1];
+		char git_dir[PATH_MAX+1];
 
 		setenv(GIT_DIR_ENVIRONMENT,
 			getcwd(git_dir, sizeof(git_dir)), 0);
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index f9463de..2e98f45 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -42,7 +42,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 void prune_packed_objects(int opts)
 {
 	int i;
-	static char pathname[PATH_MAX];
+	char pathname[PATH_MAX];
 	const char *dir = get_object_directory();
 	int len = strlen(dir);
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 0559fcc..43914b1 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -190,7 +190,6 @@ static int copy_to_sideband(int in, int out, void *arg)
 
 static int run_receive_hook(const char *hook_name)
 {
-	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 	struct command *cmd;
 	struct child_process proc;
 	struct async muxer;
@@ -232,6 +231,7 @@ static int run_receive_hook(const char *hook_name)
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string) {
+			char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
 				sha1_to_hex(cmd->old_sha1),
 				sha1_to_hex(cmd->new_sha1),
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a8c5043..2819b89 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -636,7 +636,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--git-dir")) {
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
-				static char cwd[PATH_MAX];
+				char cwd[PATH_MAX];
 				if (gitdir) {
 					puts(gitdir);
 					continue;
diff --git a/compat/mingw.c b/compat/mingw.c
index ab65f77..f0b14dd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -190,7 +190,7 @@ static int do_lstat(const char *file_name, struct stat *buf)
 int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	int namelen;
-	static char alt_name[PATH_MAX];
+	char alt_name[PATH_MAX];
 
 	if (!do_lstat(file_name, buf))
 		return 0;
diff --git a/daemon.c b/daemon.c
index 3769b6f..a0e655d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -105,8 +105,8 @@ static void NORETURN daemon_die(const char *err, va_list params)
 
 static char *path_ok(char *directory)
 {
-	static char rpath[PATH_MAX];
-	static char interp_path[PATH_MAX];
+	char rpath[PATH_MAX];
+	char interp_path[PATH_MAX];
 	char *path;
 	char *dir;
 
diff --git a/entry.c b/entry.c
index 004182c..fabc590 100644
--- a/entry.c
+++ b/entry.c
@@ -194,7 +194,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 
 int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath)
 {
-	static char path[PATH_MAX + 1];
+	char path[PATH_MAX + 1];
 	struct stat st;
 	int len = state->base_dir_len;
 
diff --git a/fast-import.c b/fast-import.c
index 309f2c5..02083f2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -829,7 +829,7 @@ static struct tree_content *dup_tree_content(struct tree_content *s)
 
 static void start_packfile(void)
 {
-	static char tmpfile[PATH_MAX];
+	char tmpfile[PATH_MAX];
 	struct packed_git *p;
 	struct pack_header hdr;
 	int pack_fd;
@@ -905,7 +905,7 @@ static char *keep_pack(const char *curr_index_name)
 
 static void unkeep_all_packs(void)
 {
-	static char name[PATH_MAX];
+	char name[PATH_MAX];
 	int k;
 
 	for (k = 0; k < pack_id; k++) {
diff --git a/git.c b/git.c
index 61a5408..4483a85 100644
--- a/git.c
+++ b/git.c
@@ -122,7 +122,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
-			static char git_dir[PATH_MAX+1];
+			char git_dir[PATH_MAX+1];
 			is_bare_repository_cfg = 1;
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
diff --git a/pack-write.c b/pack-write.c
index a905ca4..e60f874 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -43,7 +43,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		sorted_by_sha = list = last = NULL;
 
 	if (!index_name) {
-		static char tmpfile[PATH_MAX];
+		char tmpfile[PATH_MAX];
 		fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX");
 		index_name = xstrdup(tmpfile);
 	} else {
diff --git a/sha1_file.c b/sha1_file.c
index 006321e..ca366eb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2286,7 +2286,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	git_SHA_CTX c;
 	unsigned char parano_sha1[20];
 	char *filename;
-	static char tmpfile[PATH_MAX];
+	char tmpfile[PATH_MAX];
 
 	filename = sha1_file_name(sha1);
 	fd = create_tmpfile(tmpfile, sizeof(tmpfile), filename);
diff --git a/transport.c b/transport.c
index 1a360cf..0b2638a 100644
--- a/transport.c
+++ b/transport.c
@@ -97,7 +97,7 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 static void insert_packed_refs(const char *packed_refs, struct ref **list)
 {
 	FILE *f = fopen(packed_refs, "r");
-	static char buffer[PATH_MAX];
+	char buffer[PATH_MAX];
 
 	if (!f)
 		return;
