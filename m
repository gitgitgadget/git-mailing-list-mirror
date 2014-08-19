From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 1/4] run-command: introduce CHILD_PROCESS_INIT
Date: Tue, 19 Aug 2014 21:09:35 +0200
Message-ID: <53F3A0EF.7050107@web.de>
References: <53EFE15B.7030805@web.de> <53F05DE2.5080806@kdbg.org>	<20140817084832.GL23808@peff.net> <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:10:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJoo0-0004v9-ST
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 21:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbaHSTKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 15:10:48 -0400
Received: from mout.web.de ([212.227.15.14]:57476 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbaHSTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 15:10:46 -0400
Received: from [192.168.178.27] ([79.250.174.3]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MWBA1-1Wr0L23J17-00XNVU; Tue, 19 Aug 2014 21:10:33
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:iPUyyU2l2lGPvrsOOc9t4xU/6x3Mvr0f0V4AhtY+pYm3A8Bkv+9
 qfGKlC3ilPWURJRXXwfRRmuLggxfhhGBqZ13CcexF68Ivtjp7fxSWCEJe+T/rg2GbypT2+A
 pjax2L+hHODVTDQFeOPp6Nurzkkgkg4qaUixVIEigB7dcs54AweLjPR+uYlEq1+D6iC4oUa
 UaoySESMFEdZ9HXfgwKqQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255508>

Most struct child_process variables are cleared using memset first after
declaration.  Provide a macro, CHILD_PROCESS_INIT, that can be used to
initialize them statically instead.  That's shorter, doesn't require a
function call and is slightly more readable (especially given that we
already have STRBUF_INIT, ARGV_ARRAY_INIT etc.).

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Now with ARGV_ARRAY_INIT and more conversions.

 Documentation/technical/api-run-command.txt |  4 ++--
 archive-tar.c                               |  3 +--
 builtin/add.c                               |  3 +--
 builtin/commit.c                            |  3 +--
 builtin/help.c                              |  3 +--
 builtin/merge.c                             |  3 +--
 builtin/notes.c                             |  3 +--
 builtin/receive-pack.c                      | 12 ++++--------
 builtin/remote-ext.c                        |  3 +--
 builtin/repack.c                            |  3 +--
 builtin/replace.c                           |  4 ++--
 builtin/verify-pack.c                       |  3 +--
 bundle.c                                    |  6 ++----
 column.c                                    |  2 +-
 connect.c                                   |  2 +-
 connected.c                                 |  3 +--
 convert.c                                   |  3 +--
 credential-cache.c                          |  3 +--
 credential.c                                |  3 +--
 daemon.c                                    |  8 +++-----
 diff.c                                      |  3 +--
 editor.c                                    |  3 +--
 fetch-pack.c                                |  3 +--
 gpg-interface.c                             |  6 ++----
 http-backend.c                              |  3 +--
 http.c                                      |  3 +--
 imap-send.c                                 |  2 +-
 pager.c                                     |  2 +-
 prompt.c                                    |  3 +--
 remote-curl.c                               |  3 +--
 remote-testsvn.c                            |  3 +--
 run-command.c                               |  3 +--
 run-command.h                               |  2 ++
 send-pack.c                                 |  3 +--
 submodule.c                                 | 21 +++++++--------------
 test-run-command.c                          |  4 +---
 test-subprocess.c                           |  3 +--
 transport.c                                 | 12 ++++--------
 upload-pack.c                               |  5 ++---
 wt-status.c                                 |  3 +--
 40 files changed, 60 insertions(+), 107 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 69510ae..ca066bf 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -96,8 +96,8 @@ command to run in a sub-process.
 
 The caller:
 
-1. allocates and clears (memset(&chld, 0, sizeof(chld));) a
-   struct child_process variable;
+1. allocates and clears (memset(&chld, 0, sizeof(chld)); or
+   using CHILD_PROCESS_INIT) a struct child_process variable;
 2. initializes the members;
 3. calls start_command();
 4. processes the data;
diff --git a/archive-tar.c b/archive-tar.c
index 719b629..0d1e6bd 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -395,7 +395,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
 	struct strbuf cmd = STRBUF_INIT;
-	struct child_process filter;
+	struct child_process filter = CHILD_PROCESS_INIT;
 	const char *argv[2];
 	int r;
 
@@ -406,7 +406,6 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (args->compression_level >= 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
 
-	memset(&filter, 0, sizeof(filter));
 	argv[0] = cmd.buf;
 	argv[1] = NULL;
 	filter.argv = argv;
diff --git a/builtin/add.c b/builtin/add.c
index 4baf3a5..352b85e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -180,7 +180,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	char *file = git_pathdup("ADD_EDIT.patch");
 	const char *apply_argv[] = { "apply", "--recount", "--cached",
 		NULL, NULL };
-	struct child_process child;
+	struct child_process child = CHILD_PROCESS_INIT;
 	struct rev_info rev;
 	int out;
 	struct stat st;
@@ -214,7 +214,6 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (!st.st_size)
 		die(_("Empty patch. Aborted."));
 
-	memset(&child, 0, sizeof(child));
 	child.git_cmd = 1;
 	child.argv = apply_argv;
 	if (run_command(&child))
diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..b8b8663 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1508,7 +1508,7 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 {
 	/* oldsha1 SP newsha1 LF NUL */
 	static char buf[2*40 + 3];
-	struct child_process proc;
+	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
 	int code;
 	size_t n;
@@ -1520,7 +1520,6 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	argv[1] = "amend";
 	argv[2] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
diff --git a/builtin/help.c b/builtin/help.c
index 1fdefeb..8343b40 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -79,12 +79,11 @@ static const char *get_man_viewer_info(const char *name)
 static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	struct child_process ec_process;
+	struct child_process ec_process = CHILD_PROCESS_INIT;
 	const char *argv_ec[] = { "emacsclient", "--version", NULL };
 	int version;
 
 	/* emacsclient prints its version number on stderr */
-	memset(&ec_process, 0, sizeof(ec_process));
 	ec_process.argv = argv_ec;
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
diff --git a/builtin/merge.c b/builtin/merge.c
index ce82eb2..9da9e30 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -237,11 +237,10 @@ static void drop_save(void)
 static int save_state(unsigned char *stash)
 {
 	int len;
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
 	const char *argv[] = {"stash", "create", NULL};
 
-	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.out = -1;
 	cp.git_cmd = 1;
diff --git a/builtin/notes.c b/builtin/notes.c
index 820c341..c25a412 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -122,12 +122,11 @@ static void write_commented_object(int fd, const unsigned char *object)
 {
 	const char *show_args[5] =
 		{"show", "--stat", "--no-notes", sha1_to_hex(object), NULL};
-	struct child_process show;
+	struct child_process show = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf cbuf = STRBUF_INIT;
 
 	/* Invoke "git show --stat --no-notes $object" */
-	memset(&show, 0, sizeof(show));
 	show.argv = show_args;
 	show.no_stdin = 1;
 	show.out = -1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f93ac45..5ad9075 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -255,7 +255,7 @@ static int copy_to_sideband(int in, int out, void *arg)
 typedef int (*feed_fn)(void *, const char **, size_t *);
 static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_state)
 {
-	struct child_process proc;
+	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
 	const char *argv[2];
 	int code;
@@ -266,7 +266,6 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 
 	argv[1] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
@@ -350,7 +349,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name,
 static int run_update_hook(struct command *cmd)
 {
 	const char *argv[5];
-	struct child_process proc;
+	struct child_process proc = CHILD_PROCESS_INIT;
 	int code;
 
 	argv[0] = find_hook("update");
@@ -362,7 +361,6 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
@@ -598,7 +596,7 @@ static void run_update_post_hook(struct command *commands)
 	struct command *cmd;
 	int argc;
 	const char **argv;
-	struct child_process proc;
+	struct child_process proc = CHILD_PROCESS_INIT;
 	char *hook;
 
 	hook = find_hook("post-update");
@@ -621,7 +619,6 @@ static void run_update_post_hook(struct command *commands)
 	}
 	argv[argc] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
@@ -911,7 +908,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	const char *hdr_err;
 	int status;
 	char hdr_arg[38];
-	struct child_process child;
+	struct child_process child = CHILD_PROCESS_INIT;
 	int fsck_objects = (receive_fsck_objects >= 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >= 0
@@ -933,7 +930,6 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&av, "--shallow-file", alt_shallow_file, NULL);
 	}
 
-	memset(&child, 0, sizeof(child));
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		argv_array_pushl(&av, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 692c834..d699d28 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -179,9 +179,8 @@ static void send_git_request(int stdin_fd, const char *serv, const char *repo,
 static int run_child(const char *arg, const char *service)
 {
 	int r;
-	struct child_process child;
+	struct child_process child = CHILD_PROCESS_INIT;
 
-	memset(&child, 0, sizeof(child));
 	child.in = -1;
 	child.out = -1;
 	child.err = 0;
diff --git a/builtin/repack.c b/builtin/repack.c
index a77e743..fc088db 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -133,7 +133,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		{".idx"},
 		{".bitmap", 1},
 	};
-	struct child_process cmd;
+	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct argv_array cmd_args = ARGV_ARRAY_INIT;
 	struct string_list names = STRING_LIST_INIT_DUP;
@@ -250,7 +250,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	argv_array_push(&cmd_args, packtmp);
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv = cmd_args.argv;
 	cmd.git_cmd = 1;
 	cmd.out = -1;
diff --git a/builtin/replace.c b/builtin/replace.c
index 294b61b..d2aac64 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -197,7 +197,7 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 static void export_object(const unsigned char *sha1, enum object_type type,
 			  int raw, const char *filename)
 {
-	struct child_process cmd = { NULL };
+	struct child_process cmd = CHILD_PROCESS_INIT;
 	int fd;
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
@@ -234,7 +234,7 @@ static void import_object(unsigned char *sha1, enum object_type type,
 
 	if (!raw && type == OBJ_TREE) {
 		const char *argv[] = { "mktree", NULL };
-		struct child_process cmd = { argv };
+		struct child_process cmd = CHILD_PROCESS_INIT;
 		struct strbuf result = STRBUF_INIT;
 
 		cmd.argv = argv;
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 972579f..7747537 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -8,7 +8,7 @@
 
 static int verify_one_pack(const char *path, unsigned int flags)
 {
-	struct child_process index_pack;
+	struct child_process index_pack = CHILD_PROCESS_INIT;
 	const char *argv[] = {"index-pack", NULL, NULL, NULL };
 	struct strbuf arg = STRBUF_INIT;
 	int verbose = flags & VERIFY_PACK_VERBOSE;
@@ -32,7 +32,6 @@ static int verify_one_pack(const char *path, unsigned int flags)
 		strbuf_addstr(&arg, ".pack");
 	argv[2] = arg.buf;
 
-	memset(&index_pack, 0, sizeof(index_pack));
 	index_pack.argv = argv;
 	index_pack.git_cmd = 1;
 
diff --git a/bundle.c b/bundle.c
index 71a21a6..d6b4df8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -240,7 +240,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	int i, ref_count = 0;
 	struct strbuf buf = STRBUF_INIT;
 	struct rev_info revs;
-	struct child_process rls;
+	struct child_process rls = CHILD_PROCESS_INIT;
 	FILE *rls_fout;
 
 	bundle_to_stdout = !strcmp(path, "-");
@@ -258,7 +258,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 	init_revisions(&revs, NULL);
 
 	/* write prerequisites */
-	memset(&rls, 0, sizeof(rls));
 	argv_array_pushl(&rls.args,
 			 "rev-list", "--boundary", "--pretty=oneline",
 			 NULL);
@@ -417,14 +416,13 @@ int unbundle(struct bundle_header *header, int bundle_fd, int flags)
 {
 	const char *argv_index_pack[] = {"index-pack",
 					 "--fix-thin", "--stdin", NULL, NULL};
-	struct child_process ip;
+	struct child_process ip = CHILD_PROCESS_INIT;
 
 	if (flags & BUNDLE_VERBOSE)
 		argv_index_pack[3] = "-v";
 
 	if (verify_bundle(header, 0))
 		return -1;
-	memset(&ip, 0, sizeof(ip));
 	ip.argv = argv_index_pack;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
diff --git a/column.c b/column.c
index ca878bc..76b615d 100644
--- a/column.c
+++ b/column.c
@@ -367,7 +367,7 @@ int parseopt_column_callback(const struct option *opt,
 }
 
 static int fd_out = -1;
-static struct child_process column_process;
+static struct child_process column_process = CHILD_PROCESS_INIT;
 
 int run_column_filter(int colopts, const struct column_options *opts)
 {
diff --git a/connect.c b/connect.c
index 5047402..f5b930a 100644
--- a/connect.c
+++ b/connect.c
@@ -639,7 +639,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	return protocol;
 }
 
-static struct child_process no_fork;
+static struct child_process no_fork = CHILD_PROCESS_INIT;
 
 /*
  * This returns a dummy child_process if the transport protocol does not
diff --git a/connected.c b/connected.c
index dae9c99..299c560 100644
--- a/connected.c
+++ b/connected.c
@@ -25,7 +25,7 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 					   struct transport *transport,
 					   const char *shallow_file)
 {
-	struct child_process rev_list;
+	struct child_process rev_list = CHILD_PROCESS_INIT;
 	const char *argv[9];
 	char commit[41];
 	unsigned char sha1[20];
@@ -60,7 +60,6 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 		argv[ac++] = "--quiet";
 	argv[ac] = NULL;
 
-	memset(&rev_list, 0, sizeof(rev_list));
 	rev_list.argv = argv;
 	rev_list.git_cmd = 1;
 	rev_list.in = -1;
diff --git a/convert.c b/convert.c
index cb5fbb4..aa7a139 100644
--- a/convert.c
+++ b/convert.c
@@ -321,7 +321,7 @@ static int filter_buffer(int in, int out, void *data)
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
-	struct child_process child_process;
+	struct child_process child_process = CHILD_PROCESS_INIT;
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
 	const char *argv[] = { NULL, NULL };
@@ -344,7 +344,6 @@ static int filter_buffer(int in, int out, void *data)
 
 	argv[0] = cmd.buf;
 
-	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
 	child_process.use_shell = 1;
 	child_process.in = -1;
diff --git a/credential-cache.c b/credential-cache.c
index 9a03792..8689a15 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -37,12 +37,11 @@ static int send_request(const char *socket, const struct strbuf *out)
 
 static void spawn_daemon(const char *socket)
 {
-	struct child_process daemon;
+	struct child_process daemon = CHILD_PROCESS_INIT;
 	const char *argv[] = { NULL, NULL, NULL };
 	char buf[128];
 	int r;
 
-	memset(&daemon, 0, sizeof(daemon));
 	argv[0] = "git-credential-cache--daemon";
 	argv[1] = socket;
 	daemon.argv = argv;
diff --git a/credential.c b/credential.c
index 4d79d32..1886ea5 100644
--- a/credential.c
+++ b/credential.c
@@ -205,11 +205,10 @@ static int run_credential_helper(struct credential *c,
 				 const char *cmd,
 				 int want_output)
 {
-	struct child_process helper;
+	struct child_process helper = CHILD_PROCESS_INIT;
 	const char *argv[] = { NULL, NULL };
 	FILE *fp;
 
-	memset(&helper, 0, sizeof(helper));
 	argv[0] = cmd;
 	helper.argv = argv;
 	helper.use_shell = 1;
diff --git a/daemon.c b/daemon.c
index e6b51ed..a5953de 100644
--- a/daemon.c
+++ b/daemon.c
@@ -259,7 +259,7 @@ static const char *access_hook;
 
 static int run_access_hook(struct daemon_service *service, const char *dir, const char *path)
 {
-	struct child_process child;
+	struct child_process child = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *argv[8];
 	const char **arg = argv;
@@ -277,7 +277,6 @@ static int run_access_hook(struct daemon_service *service, const char *dir, cons
 	*arg = NULL;
 #undef STRARG
 
-	memset(&child, 0, sizeof(child));
 	child.use_shell = 1;
 	child.argv = argv;
 	child.no_stdin = 1;
@@ -406,9 +405,8 @@ static void copy_to_log(int fd)
 
 static int run_service_command(const char **argv)
 {
-	struct child_process cld;
+	struct child_process cld = CHILD_PROCESS_INIT;
 
-	memset(&cld, 0, sizeof(cld));
 	cld.argv = argv;
 	cld.git_cmd = 1;
 	cld.err = -1;
@@ -733,7 +731,7 @@ static void check_dead_children(void)
 static char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
-	struct child_process cld = { NULL };
+	struct child_process cld = CHILD_PROCESS_INIT;
 	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
 	char *env[] = { addrbuf, portbuf, NULL };
 
diff --git a/diff.c b/diff.c
index 867f034..e7d4d42 100644
--- a/diff.c
+++ b/diff.c
@@ -4931,7 +4931,7 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	struct diff_tempfile *temp;
 	const char *argv[3];
 	const char **arg = argv;
-	struct child_process child;
+	struct child_process child = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	int err = 0;
 
@@ -4940,7 +4940,6 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	*arg++ = temp->name;
 	*arg = NULL;
 
-	memset(&child, 0, sizeof(child));
 	child.use_shell = 1;
 	child.argv = argv;
 	child.out = -1;
diff --git a/editor.c b/editor.c
index 0abbd8d..01c644c 100644
--- a/editor.c
+++ b/editor.c
@@ -38,10 +38,9 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, real_path(path), NULL };
-		struct child_process p;
+		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
 
-		memset(&p, 0, sizeof(p));
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index b8a58fa..18d4c8f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -666,7 +666,7 @@ static int get_pack(struct fetch_pack_args *args,
 	char hdr_arg[256];
 	const char **av, *cmd_name;
 	int do_keep = args->keep_pack;
-	struct child_process cmd;
+	struct child_process cmd = CHILD_PROCESS_INIT;
 	int ret;
 
 	memset(&demux, 0, sizeof(demux));
@@ -685,7 +685,6 @@ static int get_pack(struct fetch_pack_args *args,
 	else
 		demux.out = xd[0];
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv = argv;
 	av = argv;
 	*hdr_arg = 0;
diff --git a/gpg-interface.c b/gpg-interface.c
index ff07012..1ef73fb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -55,12 +55,11 @@ const char *get_signing_key(void)
  */
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
-	struct child_process gpg;
+	struct child_process gpg = CHILD_PROCESS_INIT;
 	const char *args[4];
 	ssize_t len;
 	size_t i, j, bottom;
 
-	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args;
 	gpg.in = -1;
 	gpg.out = -1;
@@ -116,7 +115,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
 {
-	struct child_process gpg;
+	struct child_process gpg = CHILD_PROCESS_INIT;
 	const char *args_gpg[] = {NULL, "--status-fd=1", "--verify", "FILE", "-", NULL};
 	char path[PATH_MAX];
 	int fd, ret;
@@ -133,7 +132,6 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 			     path, strerror(errno));
 	close(fd);
 
-	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args_gpg;
 	gpg.in = -1;
 	gpg.out = -1;
diff --git a/http-backend.c b/http-backend.c
index 80790bb..2d4d105 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -323,7 +323,7 @@ static void run_service(const char **argv)
 	const char *host = getenv("REMOTE_ADDR");
 	struct argv_array env = ARGV_ARRAY_INIT;
 	int gzipped_request = 0;
-	struct child_process cld;
+	struct child_process cld = CHILD_PROCESS_INIT;
 
 	if (encoding && !strcmp(encoding, "gzip"))
 		gzipped_request = 1;
@@ -341,7 +341,6 @@ static void run_service(const char **argv)
 		argv_array_pushf(&env, "GIT_COMMITTER_EMAIL=%s@http.%s",
 				 user, host);
 
-	memset(&cld, 0, sizeof(cld));
 	cld.argv = argv;
 	cld.env = env.argv;
 	if (gzipped_request)
diff --git a/http.c b/http.c
index c8cd50d..a23c399 100644
--- a/http.c
+++ b/http.c
@@ -1332,7 +1332,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
 	char *tmp_idx;
-	struct child_process ip;
+	struct child_process ip = CHILD_PROCESS_INIT;
 	const char *ip_argv[8];
 
 	close_pack_index(p);
@@ -1355,7 +1355,6 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	ip_argv[3] = preq->tmpfile;
 	ip_argv[4] = NULL;
 
-	memset(&ip, 0, sizeof(ip));
 	ip.argv = ip_argv;
 	ip.git_cmd = 1;
 	ip.no_stdin = 1;
diff --git a/imap-send.c b/imap-send.c
index 524fbab..d8fb10f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -962,7 +962,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 
 	if (srvc->tunnel) {
 		const char *argv[] = { srvc->tunnel, NULL };
-		struct child_process tunnel = {NULL};
+		struct child_process tunnel = CHILD_PROCESS_INIT;
 
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
diff --git a/pager.c b/pager.c
index 8b5cbc5..d0e4bc8 100644
--- a/pager.c
+++ b/pager.c
@@ -18,7 +18,7 @@ struct pager_config {
  */
 
 static const char *pager_argv[] = { NULL, NULL };
-static struct child_process pager_process;
+static struct child_process pager_process = CHILD_PROCESS_INIT;
 
 static void wait_for_pager(void)
 {
diff --git a/prompt.c b/prompt.c
index d7bb17c..e5b4938 100644
--- a/prompt.c
+++ b/prompt.c
@@ -6,7 +6,7 @@
 
 static char *do_askpass(const char *cmd, const char *prompt)
 {
-	struct child_process pass;
+	struct child_process pass = CHILD_PROCESS_INIT;
 	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
 	int err = 0;
@@ -15,7 +15,6 @@ static char *do_askpass(const char *cmd, const char *prompt)
 	args[1]	= prompt;
 	args[2] = NULL;
 
-	memset(&pass, 0, sizeof(pass));
 	pass.argv = args;
 	pass.out = -1;
 
diff --git a/remote-curl.c b/remote-curl.c
index 0fcf2ce..017ddd9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -623,10 +623,9 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	const char *svc = rpc->service_name;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf *preamble = rpc->stdin_preamble;
-	struct child_process client;
+	struct child_process client = CHILD_PROCESS_INIT;
 	int err = 0;
 
-	memset(&client, 0, sizeof(client));
 	client.in = -1;
 	client.out = -1;
 	client.git_cmd = 1;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 686e07d..48bf6eb 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -175,7 +175,7 @@ static int cmd_import(const char *line)
 	char *note_msg;
 	unsigned char head_sha1[20];
 	unsigned int startrev;
-	struct child_process svndump_proc;
+	struct child_process svndump_proc = CHILD_PROCESS_INIT;
 	const char *command = "svnrdump";
 
 	if (read_ref(private_ref, head_sha1))
@@ -200,7 +200,6 @@ static int cmd_import(const char *line)
 		if(dumpin_fd < 0)
 			die_errno("Couldn't open svn dump file %s.", url);
 	} else {
-		memset(&svndump_proc, 0, sizeof(struct child_process));
 		svndump_proc.out = -1;
 		argv_array_push(&svndump_proc.args, command);
 		argv_array_push(&svndump_proc.args, "dump");
diff --git a/run-command.c b/run-command.c
index 35a3ebf..a29a34f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -763,14 +763,13 @@ char *find_hook(const char *name)
 
 int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
-	struct child_process hook;
+	struct child_process hook = CHILD_PROCESS_INIT;
 	const char *p;
 
 	p = find_hook(name);
 	if (!p)
 		return 0;
 
-	memset(&hook, 0, sizeof(hook));
 	argv_array_push(&hook.args, p);
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&hook.args, p);
diff --git a/run-command.h b/run-command.h
index ea73de3..5484400 100644
--- a/run-command.h
+++ b/run-command.h
@@ -44,6 +44,8 @@ struct child_process {
 	unsigned clean_on_exit:1;
 };
 
+#define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT }
+
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
diff --git a/send-pack.c b/send-pack.c
index 6129b0f..8b4cbf0 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -47,7 +47,7 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 		NULL,
 		NULL,
 	};
-	struct child_process po;
+	struct child_process po = CHILD_PROCESS_INIT;
 	int i;
 
 	i = 4;
@@ -59,7 +59,6 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 		argv[i++] = "-q";
 	if (args->progress)
 		argv[i++] = "--progress";
-	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
diff --git a/submodule.c b/submodule.c
index c3a61e7..0690dc5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -433,13 +433,12 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
 		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
-		struct child_process cp;
+		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
 		struct strbuf buf = STRBUF_INIT;
 		int needs_pushing = 0;
 
 		argv[1] = sha1_to_hex(sha1);
-		memset(&cp, 0, sizeof(cp));
 		cp.argv = argv;
 		cp.env = local_repo_env;
 		cp.git_cmd = 1;
@@ -524,10 +523,9 @@ static int push_submodule(const char *path)
 		return 1;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
-		struct child_process cp;
+		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"push", NULL};
 
-		memset(&cp, 0, sizeof(cp));
 		cp.argv = argv;
 		cp.env = local_repo_env;
 		cp.git_cmd = 1;
@@ -569,12 +567,11 @@ static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
 		/* Even if the submodule is checked out and the commit is
 		 * present, make sure it is reachable from a ref. */
-		struct child_process cp;
+		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"rev-list", "-n", "1", NULL, "--not", "--all", NULL};
 		struct strbuf buf = STRBUF_INIT;
 
 		argv[3] = sha1_to_hex(sha1);
-		memset(&cp, 0, sizeof(cp));
 		cp.argv = argv;
 		cp.env = local_repo_env;
 		cp.git_cmd = 1;
@@ -695,7 +692,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 			       int quiet)
 {
 	int i, result = 0;
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list_item *name_for_path;
 	const char *work_tree = get_git_work_tree();
@@ -711,7 +708,6 @@ int fetch_populated_submodules(const struct argv_array *options,
 	argv_array_push(&argv, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	memset(&cp, 0, sizeof(cp));
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
@@ -794,7 +790,7 @@ out:
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {
 		"status",
 		"--porcelain",
@@ -821,7 +817,6 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (ignore_untracked)
 		argv[2] = "-uno";
 
-	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
@@ -862,7 +857,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 int submodule_uses_gitfile(const char *path)
 {
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {
 		"submodule",
 		"foreach",
@@ -883,7 +878,6 @@ int submodule_uses_gitfile(const char *path)
 	strbuf_release(&buf);
 
 	/* Now test that all nested submodules use a gitfile too */
-	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
@@ -901,7 +895,7 @@ int ok_to_remove_submodule(const char *path)
 {
 	struct stat st;
 	ssize_t len;
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {
 		"status",
 		"--porcelain",
@@ -918,7 +912,6 @@ int ok_to_remove_submodule(const char *path)
 	if (!submodule_uses_gitfile(path))
 		return 0;
 
-	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.env = local_repo_env;
 	cp.git_cmd = 1;
diff --git a/test-run-command.c b/test-run-command.c
index 37918e1..89c7de2 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -15,9 +15,7 @@
 
 int main(int argc, char **argv)
 {
-	struct child_process proc;
-
-	memset(&proc, 0, sizeof(proc));
+	struct child_process proc = CHILD_PROCESS_INIT;
 
 	if (argc < 3)
 		return 1;
diff --git a/test-subprocess.c b/test-subprocess.c
index 93525eb..56881a0 100644
--- a/test-subprocess.c
+++ b/test-subprocess.c
@@ -3,7 +3,7 @@
 
 int main(int argc, char **argv)
 {
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	int nogit = 0;
 
 	setup_git_directory_gently(&nogit);
@@ -13,7 +13,6 @@ int main(int argc, char **argv)
 		setup_work_tree();
 		argv++;
 	}
-	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
 	cp.argv = (const char **)argv + 1;
 	return run_command(&cp);
diff --git a/transport.c b/transport.c
index 662421b..7388bb8 100644
--- a/transport.c
+++ b/transport.c
@@ -201,7 +201,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
 	struct ref dummy = {NULL}, *tail = &dummy;
-	struct child_process rsync;
+	struct child_process rsync = CHILD_PROCESS_INIT;
 	const char *args[5];
 	int temp_dir_len;
 
@@ -218,7 +218,6 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 	strbuf_addstr(&buf, rsync_url(transport->url));
 	strbuf_addstr(&buf, "/refs");
 
-	memset(&rsync, 0, sizeof(rsync));
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
@@ -263,9 +262,8 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 static int fetch_objs_via_rsync(struct transport *transport,
 				int nr_objs, struct ref **to_fetch)
 {
-	struct child_process rsync;
+	struct child_process rsync = CHILD_PROCESS_INIT;
 
-	memset(&rsync, 0, sizeof(rsync));
 	rsync.stdout_to_stderr = 1;
 	argv_array_push(&rsync.args, "rsync");
 	argv_array_push(&rsync.args, (transport->verbose > 1) ? "-rv" : "-r");
@@ -327,7 +325,7 @@ static int rsync_transport_push(struct transport *transport,
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
 	int result = 0, i;
-	struct child_process rsync;
+	struct child_process rsync = CHILD_PROCESS_INIT;
 	const char *args[10];
 
 	if (flags & TRANSPORT_PUSH_MIRROR)
@@ -338,7 +336,6 @@ static int rsync_transport_push(struct transport *transport,
 	strbuf_addstr(&buf, rsync_url(transport->url));
 	strbuf_addch(&buf, '/');
 
-	memset(&rsync, 0, sizeof(rsync));
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	i = 0;
@@ -1056,7 +1053,7 @@ static int run_pre_push_hook(struct transport *transport,
 {
 	int ret = 0, x;
 	struct ref *r;
-	struct child_process proc;
+	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf;
 	const char *argv[4];
 
@@ -1067,7 +1064,6 @@ static int run_pre_push_hook(struct transport *transport,
 	argv[2] = transport->url;
 	argv[3] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.argv = argv;
 	proc.in = -1;
 
diff --git a/upload-pack.c b/upload-pack.c
index 01de944..c9ea1d3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -80,7 +80,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 
 static void create_pack_file(void)
 {
-	struct child_process pack_objects;
+	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	char data[8193], progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
@@ -108,7 +108,6 @@ static void create_pack_file(void)
 		argv[arg++] = "--include-tag";
 	argv[arg++] = NULL;
 
-	memset(&pack_objects, 0, sizeof(pack_objects));
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
@@ -448,7 +447,7 @@ static void check_non_tip(void)
 	static const char *argv[] = {
 		"rev-list", "--stdin", NULL,
 	};
-	static struct child_process cmd;
+	static struct child_process cmd = CHILD_PROCESS_INIT;
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
diff --git a/wt-status.c b/wt-status.c
index 27da529..1bf5d72 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -725,7 +725,7 @@ static void wt_status_print_changed(struct wt_status *s)
 
 static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
-	struct child_process sm_summary;
+	struct child_process sm_summary = CHILD_PROCESS_INIT;
 	struct argv_array env = ARGV_ARRAY_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
@@ -744,7 +744,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	if (!uncommitted)
 		argv_array_push(&argv, s->amend ? "HEAD^" : "HEAD");
 
-	memset(&sm_summary, 0, sizeof(sm_summary));
 	sm_summary.argv = argv.argv;
 	sm_summary.env = env.argv;
 	sm_summary.git_cmd = 1;
-- 
2.1.0
