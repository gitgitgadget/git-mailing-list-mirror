Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86984C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCSGxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCSGxT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:53:19 -0400
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E022DD1
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:53:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 4131F160066
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:44:13 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dkdarnmKsWmQ; Sat, 18 Mar 2023 23:44:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 6FBBB160054;
        Sat, 18 Mar 2023 23:44:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu 6FBBB160054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1679208251;
        bh=W85bXyL8cf+k1CFEpcuvxumEeyW0yTANJWnZOMNKT9M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=vBCRxvCe7V63h5jaoXfjDaGNK+it4rN1asAvyU4ddu7JOHEgxRTG0sIfn65Cas1UM
         gQ0Sfv4+jawkTIfF317JiPp7dE/bWuisnSJqZ8P1oy16UMRel2OMLBEnuYISOfGxco
         ZVJ76Fwdt2YxPCSrPy1cWMooOQ/2Y8KYeud2pwiY=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FL5SY5VwqrBr; Sat, 18 Mar 2023 23:44:11 -0700 (PDT)
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 3E112160045;
        Sat, 18 Mar 2023 23:44:11 -0700 (PDT)
From:   Paul Eggert <eggert@cs.ucla.edu>
To:     git@vger.kernel.org
Cc:     Paul Eggert <eggert@cs.ucla.edu>
Subject: [PATCH 1/2] git-compat-util: time_now for current time
Date:   Sat, 18 Mar 2023 23:43:52 -0700
Message-Id: <20230319064353.686226-2-eggert@cs.ucla.edu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230319064353.686226-1-eggert@cs.ucla.edu>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function time_now to get the current time as a time_t value.
All uses of time(NULL) or time(&xxx) changed to use this new function.
This refactoring does not change behavior.

Signed-off-by: Paul Eggert <eggert@cs.ucla.edu>
---
 archive.c                          | 2 +-
 blame.c                            | 2 +-
 builtin/bugreport.c                | 2 +-
 builtin/credential-cache--daemon.c | 4 ++--
 builtin/diagnose.c                 | 2 +-
 builtin/fast-import.c              | 2 +-
 builtin/fsmonitor--daemon.c        | 4 ++--
 builtin/gc.c                       | 2 +-
 builtin/log.c                      | 2 +-
 builtin/receive-pack.c             | 2 +-
 builtin/reflog.c                   | 2 +-
 commit-graph.c                     | 4 ++--
 compat/nedmalloc/malloc.c.h        | 2 +-
 credential.c                       | 4 ++--
 date.c                             | 6 +++---
 git-compat-util.h                  | 5 +++++
 http-backend.c                     | 2 +-
 http-push.c                        | 6 +++---
 rerere.c                           | 2 +-
 run-command.c                      | 4 ++--
 t/helper/test-chmtime.c            | 4 ++--
 t/helper/test-simple-ipc.c         | 4 ++--
 22 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/archive.c b/archive.c
index 1c2ca78e52..5cdafc9b56 100644
--- a/archive.c
+++ b/archive.c
@@ -472,7 +472,7 @@ static void parse_treeish_arg(const char **argv,
 		archive_time =3D commit->date;
 	} else {
 		commit_oid =3D NULL;
-		archive_time =3D time(NULL);
+		archive_time =3D time_now();
 	}
 	if (ar_args->mtime_option)
 		archive_time =3D approxidate(ar_args->mtime_option);
diff --git a/blame.c b/blame.c
index e45d8a3bf9..df14c1dfe4 100644
--- a/blame.c
+++ b/blame.c
@@ -192,7 +192,7 @@ static struct commit *fake_working_tree_commit(struct=
 repository *r,
 	struct strbuf msg =3D STRBUF_INIT;
=20
 	repo_read_index(r);
-	time(&now);
+	now =3D time_now();
 	commit =3D alloc_commit_node(r);
 	commit->object.parsed =3D 1;
 	commit->date =3D now;
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 5bc254be80..bba5820787 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -98,7 +98,7 @@ int cmd_bugreport(int argc, const char **argv, const ch=
ar *prefix)
 	struct strbuf buffer =3D STRBUF_INIT;
 	struct strbuf report_path =3D STRBUF_INIT;
 	int report =3D -1;
-	time_t now =3D time(NULL);
+	time_t now =3D time_now();
 	struct tm tm;
 	enum diagnose_mode diagnose =3D DIAGNOSE_NONE;
 	char *option_output =3D NULL;
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cach=
e--daemon.c
index 6e509d02c3..7a87df16d2 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -27,7 +27,7 @@ static void cache_credential(struct credential *c, int =
timeout)
 	/* take ownership of pointers */
 	memcpy(&e->item, c, sizeof(*c));
 	memset(c, 0, sizeof(*c));
-	e->expiration =3D time(NULL) + timeout;
+	e->expiration =3D time_now() + timeout;
 }
=20
 static struct credential_cache_entry *lookup_credential(const struct cre=
dential *c)
@@ -54,7 +54,7 @@ static timestamp_t check_expirations(void)
 {
 	static timestamp_t wait_for_entry_until;
 	int i =3D 0;
-	timestamp_t now =3D time(NULL);
+	timestamp_t now =3D time_now();
 	timestamp_t next =3D TIME_MAX;
=20
 	/*
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index d52015c67a..c502096e6c 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -11,7 +11,7 @@ static const char * const diagnose_usage[] =3D {
 int cmd_diagnose(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf zip_path =3D STRBUF_INIT;
-	time_t now =3D time(NULL);
+	time_t now =3D time_now();
 	struct tm tm;
 	enum diagnose_mode mode =3D DIAGNOSE_STATS;
 	char *option_output =3D NULL;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f7548ff4a3..9096f52075 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -335,7 +335,7 @@ static void write_crash_report(const char *err)
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpi=
d());
 	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getpp=
id());
-	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(ISO8601)=
));
+	fprintf(rpt, "    at %s\n", show_date(time_now(), 0, DATE_MODE(ISO8601)=
));
 	fputc('\n', rpt);
=20
 	fputs("fatal: ", rpt);
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index cae804a190..45cc8134cc 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -415,7 +415,7 @@ static struct fsmonitor_token_data *fsmonitor_new_tok=
en_data(void)
 	 * events to accumulate.
 	 */
 	if (test_env_value)
-		batch->pinned_time =3D time(NULL);
+		batch->pinned_time =3D time_now();
=20
 	return token;
 }
@@ -772,7 +772,7 @@ static int do_handle_client(struct fsmonitor_daemon_s=
tate *state,
 	 */
 	token_data =3D state->current_token_data;
 	batch_head =3D token_data->batch_head;
-	((struct fsmonitor_batch *)batch_head)->pinned_time =3D time(NULL);
+	((struct fsmonitor_batch *)batch_head)->pinned_time =3D time_now();
=20
 	/*
 	 * FSMonitor Protocol V2 requires that we send a response header
diff --git a/builtin/gc.c b/builtin/gc.c
index c58fe8c936..029bd2ba5c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -450,7 +450,7 @@ static const char *lock_repo_for_gc(int force, pid_t*=
 ret_pid)
 			 * after the user verifies that no gc is
 			 * running.
 			 */
-			time(NULL) - st.st_mtime <=3D 12 * 3600 &&
+			time_now() - st.st_mtime <=3D 12 * 3600 &&
 			fscanf(fp, scan_fmt, &pid, locking_host) =3D=3D 2 &&
 			/* be gentle to concurrent "gc" on remote hosts */
 			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno =3D=3D EPERM=
);
diff --git a/builtin/log.c b/builtin/log.c
index b62e629ba8..bdc62d9b9e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1168,7 +1168,7 @@ static void gen_message_id(struct rev_info *info, c=
har *base)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
-		    (timestamp_t) time(NULL),
+		    (timestamp_t) time_now(),
 		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id =3D strbuf_detach(&buf, NULL);
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fe68c79ee3..3fedeea65c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2504,7 +2504,7 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
=20
 	git_config(receive_pack_config, NULL);
 	if (cert_nonce_seed)
-		push_cert_nonce =3D prepare_push_cert_nonce(service_dir, time(NULL));
+		push_cert_nonce =3D prepare_push_cert_nonce(service_dir, time_now());
=20
 	if (0 <=3D transfer_unpack_limit)
 		unpack_limit =3D transfer_unpack_limit;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 270681dcdf..013673e768 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -237,7 +237,7 @@ static int cmd_reflog_show(int argc, const char **arg=
v, const char *prefix)
 static int cmd_reflog_expire(int argc, const char **argv, const char *pr=
efix)
 {
 	struct cmd_reflog_expire_cb cmd =3D { 0 };
-	timestamp_t now =3D time(NULL);
+	timestamp_t now =3D time_now();
 	int i, status, do_all, all_worktrees =3D 1;
 	unsigned int flags =3D 0;
 	int verbose =3D 0;
diff --git a/commit-graph.c b/commit-graph.c
index 5e6098ff35..4c75d96fc4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2196,7 +2196,7 @@ static void merge_commit_graphs(struct write_commit=
_graph_context *ctx)
 static void mark_commit_graphs(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
-	time_t now =3D time(NULL);
+	time_t now =3D time_now();
=20
 	for (i =3D ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs=
_before; i++) {
 		struct stat st;
@@ -2217,7 +2217,7 @@ static void expire_commit_graphs(struct write_commi=
t_graph_context *ctx)
 	DIR *dir;
 	struct dirent *de;
 	size_t dirnamelen;
-	timestamp_t expire_time =3D time(NULL);
+	timestamp_t expire_time =3D time_now();
=20
 	if (ctx->opts && ctx->opts->expire_time)
 		expire_time =3D ctx->opts->expire_time;
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 814845d4b3..4c30a49e60 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -3085,7 +3085,7 @@ static int init_mparams(void) {
 #ifdef WIN32
 	magic =3D (size_t)(GetTickCount() ^ (size_t)0x55555555U);
 #else
-      magic =3D (size_t)(time(0) ^ (size_t)0x55555555U);
+      magic =3D (size_t)(time_now() ^ (size_t)0x55555555U);
 #endif
       magic |=3D (size_t)8U;    /* ensure nonzero */
       magic &=3D ~(size_t)7U;   /* improve chances of fault for bad valu=
es */
diff --git a/credential.c b/credential.c
index ea40a2a410..dc750fa502 100644
--- a/credential.c
+++ b/credential.c
@@ -356,7 +356,7 @@ void credential_fill(struct credential *c)
=20
 	for (i =3D 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
-		if (c->password_expiry_utc < time(NULL)) {
+		if (c->password_expiry_utc < time_now()) {
 			/* Discard expired password */
 			FREE_AND_NULL(c->password);
 			/* Reset expiry to maintain consistency */
@@ -380,7 +380,7 @@ void credential_approve(struct credential *c)
=20
 	if (c->approved)
 		return;
-	if (!c->username || !c->password || c->password_expiry_utc < time(NULL)=
)
+	if (!c->username || !c->password || c->password_expiry_utc < time_now()=
)
 		return;
=20
 	credential_apply_config(c);
diff --git a/date.c b/date.c
index 6f45eeb356..16717be397 100644
--- a/date.c
+++ b/date.c
@@ -597,7 +597,7 @@ static int match_multi_number(timestamp_t num, char c=
, const char *date,
 	case '/':
 	case '.':
 		if (!now)
-			now =3D time(NULL);
+			now =3D time_now();
 		refuse_future =3D NULL;
 		if (gmtime_r(&now, &now_tm))
 			refuse_future =3D &now_tm;
@@ -712,7 +712,7 @@ static int match_digit(const char *date, struct tm *t=
m, int *offset, int *tm_gmt
 		unsigned int num2 =3D (num % 10000) / 100;
 		unsigned int num3 =3D num % 100;
 		if (n =3D=3D 8)
-			set_date(num1, num2, num3, NULL, time(NULL), tm);
+			set_date(num1, num2, num3, NULL, time_now(), tm);
 		else if (n =3D=3D 6 && set_time(num1, num2, num3, tm) =3D=3D 0 &&
 			 *end =3D=3D '.' && isdigit(end[1]))
 			strtoul(end + 1, &end, 10);
@@ -1041,7 +1041,7 @@ void datestamp(struct strbuf *out)
 	int offset;
 	struct tm tm =3D { 0 };
=20
-	time(&now);
+	now =3D time_now();
=20
 	offset =3D tm_to_time_t(localtime_r(&now, &tm)) - now;
 	offset /=3D 60;
diff --git a/git-compat-util.h b/git-compat-util.h
index 1e6592624d..d05f4bac22 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -339,6 +339,11 @@ static inline const char *precompose_string_if_neede=
d(const char *in)
 int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 #endif
=20
+static inline time_t time_now(void)
+{
+	return time(NULL);
+}
+
 #ifdef NO_STRUCT_ITIMERVAL
 struct itimerval {
 	struct timeval it_interval;
diff --git a/http-backend.c b/http-backend.c
index 9cfc6f2541..d533989e32 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -113,7 +113,7 @@ static void hdr_nocache(struct strbuf *hdr)
=20
 static void hdr_cache_forever(struct strbuf *hdr)
 {
-	timestamp_t now =3D time(NULL);
+	timestamp_t now =3D time_now();
 	hdr_date(hdr, "Date", now);
 	hdr_date(hdr, "Expires", now + 31536000);
 	hdr_str(hdr, "Cache-Control", "public, max-age=3D31536000");
diff --git a/http-push.c b/http-push.c
index 88aa045ecb..d8158667a0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -459,7 +459,7 @@ static int refresh_lock(struct remote_lock *lock)
 			fprintf(stderr, "LOCK HTTP error %ld\n",
 				results.http_code);
 		} else {
-			lock->start_time =3D time(NULL);
+			lock->start_time =3D time_now();
 			rc =3D 1;
 		}
 	}
@@ -473,7 +473,7 @@ static int refresh_lock(struct remote_lock *lock)
 static void check_locks(void)
 {
 	struct remote_lock *lock =3D repo->locks;
-	time_t current_time =3D time(NULL);
+	time_t current_time =3D time_now();
 	int time_remaining;
=20
 	while (lock) {
@@ -933,7 +933,7 @@ static struct remote_lock *lock_remote(const char *pa=
th, long timeout)
 		FREE_AND_NULL(lock);
 	} else {
 		lock->url =3D url;
-		lock->start_time =3D time(NULL);
+		lock->start_time =3D time_now();
 		lock->next =3D repo->locks;
 		repo->locks =3D lock;
 	}
diff --git a/rerere.c b/rerere.c
index a67abaab07..ac36a9c234 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1179,7 +1179,7 @@ void rerere_gc(struct repository *r, struct string_=
list *rr)
 	DIR *dir;
 	struct dirent *e;
 	int i;
-	timestamp_t now =3D time(NULL);
+	timestamp_t now =3D time_now();
 	timestamp_t cutoff_noresolve =3D now - 15 * 86400;
 	timestamp_t cutoff_resolve =3D now - 60 * 86400;
=20
diff --git a/run-command.c b/run-command.c
index ba617655b2..fbf9afdb27 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1864,7 +1864,7 @@ enum start_bg_result start_bg_command(struct child_=
process *cmd,
 		goto done;
 	}
=20
-	time(&time_limit);
+	time_limit =3D time_now();
 	time_limit +=3D timeout_sec;
=20
 wait:
@@ -1891,7 +1891,7 @@ enum start_bg_result start_bg_command(struct child_=
process *cmd,
 			 */
 			time_t now;
=20
-			time(&now);
+			now =3D time_now();
 			if (now < time_limit)
 				goto wait;
=20
diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index dc28890a18..f48a07f6f7 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -7,7 +7,7 @@
  *
  *	test-tool chmtime =3D<seconds> file...
  *
- * Relative to the current time as returned by time(3):
+ * Relative to the current time as returned by time_now():
  *
  *	test-tool chmtime =3D+<seconds> (or =3D-<seconds>) file...
  *
@@ -60,7 +60,7 @@ static int timespec_arg(const char *arg, long int *set_=
time, int *set_eq)
 		return 0;
 	}
 	if ((*set_eq && *set_time < 0) || *set_eq =3D=3D 2) {
-		time_t now =3D time(NULL);
+		time_t now =3D time_now();
 		*set_time +=3D now;
 	}
 	return 1;
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 3d1436da59..2267cd9fac 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -411,7 +411,7 @@ static int client__stop_server(void)
 	time_t time_limit, now;
 	enum ipc_active_state s;
=20
-	time(&time_limit);
+	time_limit =3D time_now();
 	time_limit +=3D cl_args.max_wait_sec;
=20
 	cl_args.token =3D "quit";
@@ -434,7 +434,7 @@ static int client__stop_server(void)
 			return 0;
 		}
=20
-		time(&now);
+		now =3D time_now();
 		if (now > time_limit)
 			return error("daemon has not shutdown yet");
 	}
--=20
2.39.2

