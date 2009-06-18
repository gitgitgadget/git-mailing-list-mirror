From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix various sparse warnings in the git source code
Date: Thu, 18 Jun 2009 10:28:43 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906181021520.16802@localhost.localdomain>
References: <E1MFvux-0001ix-I7@fencepost.gnu.org> <alpine.DEB.1.00.0906142215560.26154@pacific.mpi-cbg.de> <E1MG32S-0004C6-8A@fencepost.gnu.org> <alpine.LFD.2.01.0906142118250.3305@localhost.localdomain> <E1MH3bD-0004g2-97@fencepost.gnu.org>
 <alpine.LFD.2.01.0906171543120.16802@localhost.localdomain> <alpine.LFD.2.01.0906171654310.16802@localhost.localdomain> <alpine.DEB.1.00.0906181012050.4848@intel-tinevez-2-302> <alpine.LFD.2.01.0906180856420.16802@localhost.localdomain>
 <alpine.DEB.1.00.0906181845020.4297@intel-tinevez-2-302> <alpine.LFD.2.01.0906181013390.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:29:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHLQE-00066Z-BG
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 19:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbZFRR3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 13:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbZFRR27
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 13:28:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33966 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089AbZFRR25 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 13:28:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5IHSi6Z011702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 10:28:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5IHShoP002414;
	Thu, 18 Jun 2009 10:28:44 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0906181013390.16802@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.472 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121861>


There are a few remaining ones, but this fixes the trivial ones. It boils 
down to two main issues that sparse complains about:

 - warning: Using plain integer as NULL pointer

   Sparse doesn't like you using '0' instead of 'NULL'. For various good 
   reasons, not the least of which is just the visual confusion. A NULL 
   pointer is not an integer, and that whole "0 works as NULL" is a 
   historical accident and not very pretty.

   A few of these remain: zlib is a total mess, and Z_NULL is just a 0. 
   I didn't touch those.

 - warning: symbol 'xyz' was not declared. Should it be static?

   Sparse wwants to see declarations for any functions you export. A lack 
   fo a declaration tends to mean that you should either add one, or you 
   should mark the function 'static' to show that it's in file scope. 

   A few of these remain: I only did the ones that should obviously just 
   be made static.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

With this, and a few sparse fixes, git is _mostly_ sparse-clean.

On Thu, 18 Jun 2009, Linus Torvalds wrote:
> 
> 
> On Thu, 18 Jun 2009, Johannes Schindelin wrote:
> > 
> > The quick hack is not going to be part of sparse.git, I take it?
> 
> Not clear yet. I sent a couple of patches to the sparse list already to 
> make things go better in general with running sparse on git. I can now do
> 
> 	make "CC=cgcc -m64"
> 
> on my git tree, and get reasonable warnings. I'll play around with it 
> that whole left-shift thing a bit more, but before I do that I'll post a 
> patch for all the _other_ things sparse found in git.
> 
> 		Linus
> 

 bisect.c                 |    4 ++--
 builtin-add.c            |    2 +-
 builtin-apply.c          |    2 +-
 builtin-clone.c          |    2 +-
 builtin-fsck.c           |    4 ++--
 builtin-help.c           |    2 +-
 builtin-log.c            |    4 ++--
 builtin-merge.c          |    4 ++--
 builtin-remote.c         |   16 ++++++++--------
 builtin-unpack-objects.c |    6 +++---
 connect.c                |    2 +-
 daemon.c                 |    2 +-
 imap-send.c              |    2 +-
 index-pack.c             |    2 +-
 mailmap.c                |    6 +++---
 merge-recursive.c        |    2 +-
 parse-options.c          |    2 +-
 quote.c                  |    4 ++--
 remote.c                 |    6 +++---
 test-parse-options.c     |    4 ++--
 20 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6fdff05..dbeb287 100644
--- a/bisect.c
+++ b/bisect.c
@@ -454,7 +454,7 @@ static int read_bisect_refs(void)
 	return for_each_ref_in("refs/bisect/", register_ref, NULL);
 }
 
-void read_bisect_paths(struct argv_array *array)
+static void read_bisect_paths(struct argv_array *array)
 {
 	struct strbuf str = STRBUF_INIT;
 	const char *filename = git_path("BISECT_NAMES");
@@ -780,7 +780,7 @@ static void handle_bad_merge_base(void)
 	exit(1);
 }
 
-void handle_skipped_merge_base(const unsigned char *mb)
+static void handle_skipped_merge_base(const unsigned char *mb)
 {
 	char *mb_hex = sha1_to_hex(mb);
 	char *bad_hex = sha1_to_hex(current_bad_sha1);
diff --git a/builtin-add.c b/builtin-add.c
index 566c313..ad8e562 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -160,7 +160,7 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-int edit_patch(int argc, const char **argv, const char *prefix)
+static int edit_patch(int argc, const char **argv, const char *prefix)
 {
 	char *file = xstrdup(git_path("ADD_EDIT.patch"));
 	const char *apply_argv[] = { "apply", "--recount", "--cached",
diff --git a/builtin-apply.c b/builtin-apply.c
index 94ba2bd..bb59567 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2614,7 +2614,7 @@ static int get_current_sha1(const char *path, unsigned char *sha1)
 static void build_fake_ancestor(struct patch *list, const char *filename)
 {
 	struct patch *patch;
-	struct index_state result = { 0 };
+	struct index_state result = { NULL };
 	int fd;
 
 	/* Once we start supporting the reverse patch, it may be
diff --git a/builtin-clone.c b/builtin-clone.c
index 5c46496..2ceacb7 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -141,7 +141,7 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	if (is_bare) {
 		struct strbuf result = STRBUF_INIT;
 		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
-		dir = strbuf_detach(&result, 0);
+		dir = strbuf_detach(&result, NULL);
 	} else
 		dir = xstrndup(start, end - start);
 	/*
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 7da706c..e077e72 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -104,7 +104,7 @@ static int mark_object(struct object *obj, int type, void *data)
 
 static void mark_object_reachable(struct object *obj)
 {
-	mark_object(obj, OBJ_ANY, 0);
+	mark_object(obj, OBJ_ANY, NULL);
 }
 
 static int traverse_one_object(struct object *obj, struct object *parent)
@@ -292,7 +292,7 @@ static int fsck_sha1(const unsigned char *sha1)
 		fprintf(stderr, "Checking %s %s\n",
 			typename(obj->type), sha1_to_hex(obj->sha1));
 
-	if (fsck_walk(obj, mark_used, 0))
+	if (fsck_walk(obj, mark_used, NULL))
 		objerror(obj, "broken links");
 	if (fsck_object(obj, check_strict, fsck_error_func))
 		return -1;
diff --git a/builtin-help.c b/builtin-help.c
index 6e53b23..e1eba77 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -394,7 +394,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
  * HTML.
  */
 #ifndef open_html
-void open_html(const char *path)
+static void open_html(const char *path)
 {
 	execl_git_cmd("web--browse", "-c", "help.browser", path, NULL);
 }
diff --git a/builtin-log.c b/builtin-log.c
index 0d34050..44f9a27 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -94,7 +94,7 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 	printf("Final output: %d %s\n", nr, stage);
 }
 
-struct itimerval early_output_timer;
+static struct itimerval early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
@@ -977,7 +977,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	rev.extra_headers = strbuf_detach(&buf, 0);
+	rev.extra_headers = strbuf_detach(&buf, NULL);
 
 	if (start_number < 0)
 		start_number = 1;
diff --git a/builtin-merge.c b/builtin-merge.c
index 793f2f4..af9adab 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -370,7 +370,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 
 	strbuf_addstr(&buf, "refs/heads/");
 	strbuf_addstr(&buf, remote);
-	resolve_ref(buf.buf, branch_head, 0, 0);
+	resolve_ref(buf.buf, branch_head, 0, NULL);
 
 	if (!hashcmp(remote_head->sha1, branch_head)) {
 		strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
@@ -409,7 +409,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_addstr(&truname, "refs/heads/");
 		strbuf_addstr(&truname, remote);
 		strbuf_setlen(&truname, truname.len - len);
-		if (resolve_ref(truname.buf, buf_sha, 0, 0)) {
+		if (resolve_ref(truname.buf, buf_sha, 0, NULL)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    sha1_to_hex(remote_head->sha1),
diff --git a/builtin-remote.c b/builtin-remote.c
index dfc0b9e..f73c657 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -740,7 +740,7 @@ static int rm(int argc, const char **argv)
 	return result;
 }
 
-void clear_push_info(void *util, const char *string)
+static void clear_push_info(void *util, const char *string)
 {
 	struct push_info *info = util;
 	free(info->dest);
@@ -815,7 +815,7 @@ struct show_info {
 	int any_rebase;
 };
 
-int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
+static int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *info = cb_data;
 	int n = strlen(item->string);
@@ -825,7 +825,7 @@ int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-int show_remote_info_item(struct string_list_item *item, void *cb_data)
+static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *info = cb_data;
 	struct ref_states *states = info->states;
@@ -852,7 +852,7 @@ int show_remote_info_item(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-int add_local_to_show_info(struct string_list_item *branch_item, void *cb_data)
+static int add_local_to_show_info(struct string_list_item *branch_item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct ref_states *states = show_info->states;
@@ -874,7 +874,7 @@ int add_local_to_show_info(struct string_list_item *branch_item, void *cb_data)
 	return 0;
 }
 
-int show_local_info_item(struct string_list_item *item, void *cb_data)
+static int show_local_info_item(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct branch_info *branch_info = item->util;
@@ -906,7 +906,7 @@ int show_local_info_item(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-int add_push_to_show_info(struct string_list_item *push_item, void *cb_data)
+static int add_push_to_show_info(struct string_list_item *push_item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct push_info *push_info = push_item->util;
@@ -935,7 +935,7 @@ static int cmp_string_with_push(const void *va, const void *vb)
 	return cmp ? cmp : strcmp(a_push->dest, b_push->dest);
 }
 
-int show_push_info_item(struct string_list_item *item, void *cb_data)
+static int show_push_info_item(struct string_list_item *item, void *cb_data)
 {
 	struct show_info *show_info = cb_data;
 	struct push_info *push_info = item->util;
@@ -1187,7 +1187,7 @@ static int get_one_remote_for_update(struct remote *remote, void *priv)
 	return 0;
 }
 
-struct remote_group {
+static struct remote_group {
 	const char *name;
 	struct string_list *list;
 } remote_group;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9a77323..f8d597d 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -158,7 +158,7 @@ struct obj_info {
 #define FLAG_WRITTEN (1u<<21)
 
 static struct obj_info *obj_list;
-unsigned nr_objects;
+static unsigned nr_objects;
 
 /*
  * Called only from check_object() after it verified this object
@@ -200,7 +200,7 @@ static int check_object(struct object *obj, int type, void *data)
 
 	if (fsck_object(obj, 1, fsck_error_function))
 		die("Error in object");
-	if (!fsck_walk(obj, check_object, 0))
+	if (!fsck_walk(obj, check_object, NULL))
 		die("Error on reachable objects of %s", sha1_to_hex(obj->sha1));
 	write_cached_object(obj);
 	return 1;
@@ -210,7 +210,7 @@ static void write_rest(void)
 {
 	unsigned i;
 	for (i = 0; i < nr_objects; i++)
-		check_object(obj_list[i].obj, OBJ_ANY, 0);
+		check_object(obj_list[i].obj, OBJ_ANY, NULL);
 }
 
 static void added_object(unsigned nr, enum object_type type,
diff --git a/connect.c b/connect.c
index 0ce941e..76e5427 100644
--- a/connect.c
+++ b/connect.c
@@ -464,7 +464,7 @@ static void git_proxy_connect(int fd[2], char *host)
 
 #define MAX_CMD_LEN 1024
 
-char *get_port(char *host)
+static char *get_port(char *host)
 {
 	char *end;
 	char *p = strchr(host, ':');
diff --git a/daemon.c b/daemon.c
index b2babcc..366db37 100644
--- a/daemon.c
+++ b/daemon.c
@@ -453,7 +453,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		gai = getaddrinfo(hostname, 0, &hints, &ai);
+		gai = getaddrinfo(hostname, NULL, &hints, &ai);
 		if (!gai) {
 			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
 
diff --git a/imap-send.c b/imap-send.c
index e4c83b9..3847fd1 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -238,7 +238,7 @@ static const char *Flags[] = {
 #ifndef NO_OPENSSL
 static void ssl_socket_perror(const char *func)
 {
-	fprintf(stderr, "%s: %s\n", func, ERR_error_string(ERR_get_error(), 0));
+	fprintf(stderr, "%s: %s\n", func, ERR_error_string(ERR_get_error(), NULL));
 }
 #endif
 
diff --git a/index-pack.c b/index-pack.c
index 6e93ee6..4d85aeb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -469,7 +469,7 @@ static void sha1_object(const void *data, unsigned long size,
 				die("invalid %s", typename(type));
 			if (fsck_object(obj, 1, fsck_error_function))
 				die("Error in object");
-			if (fsck_walk(obj, mark_link, 0))
+			if (fsck_walk(obj, mark_link, NULL))
 				die("Not all child objects of %s are reachable", sha1_to_hex(obj->sha1));
 
 			if (obj->type == OBJ_TREE) {
diff --git a/mailmap.c b/mailmap.c
index bb1f2fb..f167c00 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -103,7 +103,7 @@ static char *parse_name_and_email(char *buffer, char **name,
 		char **email, int allow_empty_email)
 {
 	char *left, *right, *nstart, *nend;
-	*name = *email = 0;
+	*name = *email = NULL;
 
 	if ((left = strchr(buffer, '<')) == NULL)
 		return NULL;
@@ -136,7 +136,7 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
 	if (f == NULL)
 		return 1;
 	while (fgets(buffer, sizeof(buffer), f) != NULL) {
-		char *name1 = 0, *email1 = 0, *name2 = 0, *email2 = 0;
+		char *name1 = NULL, *email1 = NULL, *name2 = NULL, *email2 = NULL;
 		if (buffer[0] == '#') {
 			static const char abbrev[] = "# repo-abbrev:";
 			int abblen = sizeof(abbrev) - 1;
@@ -200,7 +200,7 @@ int map_user(struct string_list *map,
 	if (!p) {
 		/* email passed in might not be wrapped in <>, but end with a \0 */
 		p = memchr(email, '\0', maxlen_email);
-		if (p == 0)
+		if (!p)
 			return 0;
 	}
 	if (p - email + 1 < sizeof(buf))
diff --git a/merge-recursive.c b/merge-recursive.c
index f5df9b9..c703445 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -38,7 +38,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
  * A virtual commit has (const char *)commit->util set to the name.
  */
 
-struct commit *make_virtual_commit(struct tree *tree, const char *comment)
+static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
 	commit->tree = tree;
diff --git a/parse-options.c b/parse-options.c
index 79de18b..4eefdb1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -478,7 +478,7 @@ static int usage_argh(const struct option *opts)
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-int usage_with_options_internal(const char * const *usagestr,
+static int usage_with_options_internal(const char * const *usagestr,
 				const struct option *opts, int full)
 {
 	if (!usagestr)
diff --git a/quote.c b/quote.c
index 7a49fcf..48bce2e 100644
--- a/quote.c
+++ b/quote.c
@@ -272,8 +272,8 @@ void write_name_quoted(const char *name, FILE *fp, int terminator)
 	fputc(terminator, fp);
 }
 
-extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
-                                 const char *name, FILE *fp, int terminator)
+void write_name_quotedpfx(const char *pfx, size_t pfxlen,
+                          const char *name, FILE *fp, int terminator)
 {
 	int needquote = 0;
 
diff --git a/remote.c b/remote.c
index 08a5964..c2a2846 100644
--- a/remote.c
+++ b/remote.c
@@ -301,7 +301,7 @@ static void read_branches_file(struct remote *remote)
 		strbuf_addstr(&branch, "HEAD:");
 	}
 	add_url_alias(remote, p);
-	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
+	add_fetch_refspec(remote, strbuf_detach(&branch, NULL));
 	/*
 	 * Cogito compatible push: push current HEAD to remote #branch
 	 * (master if missing)
@@ -312,7 +312,7 @@ static void read_branches_file(struct remote *remote)
 		strbuf_addf(&branch, ":refs/heads/%s", frag);
 	else
 		strbuf_addstr(&branch, ":refs/heads/master");
-	add_push_refspec(remote, strbuf_detach(&branch, 0));
+	add_push_refspec(remote, strbuf_detach(&branch, NULL));
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
@@ -1105,7 +1105,7 @@ int match_refs(struct ref *src, struct ref **dst,
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int errs;
-	static const char *default_refspec[] = { ":", 0 };
+	static const char *default_refspec[] = { ":", NULL };
 	struct ref **dst_tail = tail_ref(dst);
 
 	if (!nr_refspec) {
diff --git a/test-parse-options.c b/test-parse-options.c
index a90bc30..efa734b 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -9,7 +9,7 @@ static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 
-int length_callback(const struct option *opt, const char *arg, int unset)
+static int length_callback(const struct option *opt, const char *arg, int unset)
 {
 	printf("Callback: \"%s\", %d\n",
 		(arg ? arg : "not set"), unset);
@@ -20,7 +20,7 @@ int length_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int number_callback(const struct option *opt, const char *arg, int unset)
+static int number_callback(const struct option *opt, const char *arg, int unset)
 {
 	*(int *)opt->value = strtol(arg, NULL, 10);
 	return 0;
