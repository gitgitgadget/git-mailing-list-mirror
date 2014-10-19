From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/2] use env_array member of struct child_process
Date: Sun, 19 Oct 2014 13:14:20 +0200
Message-ID: <54439D0C.1070308@web.de>
References: <54390DC0.8060302@web.de> <20141012015321.GA15272@peff.net> <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?UTF-8?B?Tmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 13:14:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfoRi-0000b5-E6
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 13:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbaJSLOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 07:14:43 -0400
Received: from mout.web.de ([212.227.15.3]:57904 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbaJSLOm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 07:14:42 -0400
Received: from [192.168.178.27] ([79.253.132.15]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LZeou-1YQzhb286e-00lZNu; Sun, 19 Oct 2014 13:14:39
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:3cmi9bqxPhAOuC7NmG6ulRETasQXwHRR5OEJFKJUxIrmtTDsiBe
 DHyTEr4AMYpeq48Nj3Ni4+9nDKe76RjJ5LpzX2O1xPCxsjuFwQ4mt7sOaih0jocqgj1nN/Y
 0BqKZHYPe+FivSP4isVAie9asAY/1vNKxUy9qAjXvjjcp9MZxya2xhOlGsC+22e6NahhMrA
 tekAM/fYhTRB2iNxWjyAQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert users of struct child_process to using the managed env_array for
specifying environment variables instead of supplying an array on the
stack or bringing their own argv_array.  This shortens and simplifies
the code and ensures automatically that the allocated memory is freed
after use.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/receive-pack.c | 23 ++++++++++++++---------
 http-backend.c         |  9 +++------
 pager.c                | 15 ++++-----------
 transport-helper.c     | 10 ++--------
 wt-status.c            |  6 ++----
 5 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f2f6c67..7593861 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -453,7 +453,6 @@ leave:
 static void prepare_push_cert_sha1(struct child_process *proc)
 {
 	static int already_done;
-	struct argv_array env = ARGV_ARRAY_INIT;
 
 	if (!push_cert.len)
 		return;
@@ -487,20 +486,26 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
 	if (!is_null_sha1(push_cert_sha1)) {
-		argv_array_pushf(&env, "GIT_PUSH_CERT=%s", sha1_to_hex(push_cert_sha1));
-		argv_array_pushf(&env, "GIT_PUSH_CERT_SIGNER=%s",
+		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
+				 sha1_to_hex(push_cert_sha1));
+		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
 				 sigcheck.signer ? sigcheck.signer : "");
-		argv_array_pushf(&env, "GIT_PUSH_CERT_KEY=%s",
+		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
 				 sigcheck.key ? sigcheck.key : "");
-		argv_array_pushf(&env, "GIT_PUSH_CERT_STATUS=%c", sigcheck.result);
+		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
+				 sigcheck.result);
 		if (push_cert_nonce) {
-			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE=%s", push_cert_nonce);
-			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_STATUS=%s", nonce_status);
+			argv_array_pushf(&proc->env_array,
+					 "GIT_PUSH_CERT_NONCE=%s",
+					 push_cert_nonce);
+			argv_array_pushf(&proc->env_array,
+					 "GIT_PUSH_CERT_NONCE_STATUS=%s",
+					 nonce_status);
 			if (nonce_status == NONCE_SLOP)
-				argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_SLOP=%ld",
+				argv_array_pushf(&proc->env_array,
+						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 						 nonce_stamp_slop);
 		}
-		proc->env = env.argv;
 	}
 }
 
diff --git a/http-backend.c b/http-backend.c
index 404e682..e3e0dda 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -314,7 +314,6 @@ static void run_service(const char **argv)
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
 	const char *user = getenv("REMOTE_USER");
 	const char *host = getenv("REMOTE_ADDR");
-	struct argv_array env = ARGV_ARRAY_INIT;
 	int gzipped_request = 0;
 	struct child_process cld = CHILD_PROCESS_INIT;
 
@@ -329,13 +328,12 @@ static void run_service(const char **argv)
 		host = "(none)";
 
 	if (!getenv("GIT_COMMITTER_NAME"))
-		argv_array_pushf(&env, "GIT_COMMITTER_NAME=%s", user);
+		argv_array_pushf(&cld.env_array, "GIT_COMMITTER_NAME=%s", user);
 	if (!getenv("GIT_COMMITTER_EMAIL"))
-		argv_array_pushf(&env, "GIT_COMMITTER_EMAIL=%s@http.%s",
-				 user, host);
+		argv_array_pushf(&cld.env_array,
+				 "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	cld.argv = argv;
-	cld.env = env.argv;
 	if (gzipped_request)
 		cld.in = -1;
 	cld.git_cmd = 1;
@@ -350,7 +348,6 @@ static void run_service(const char **argv)
 
 	if (finish_command(&cld))
 		exit(1);
-	argv_array_clear(&env);
 }
 
 static int show_text_ref(const char *name, const unsigned char *sha1,
diff --git a/pager.c b/pager.c
index b2b805a..f6e8c33 100644
--- a/pager.c
+++ b/pager.c
@@ -74,17 +74,10 @@ void setup_pager(void)
 	pager_process.use_shell = 1;
 	pager_process.argv = pager_argv;
 	pager_process.in = -1;
-	if (!getenv("LESS") || !getenv("LV")) {
-		static const char *env[3];
-		int i = 0;
-
-		if (!getenv("LESS"))
-			env[i++] = "LESS=FRX";
-		if (!getenv("LV"))
-			env[i++] = "LV=-c";
-		env[i] = NULL;
-		pager_process.env = env;
-	}
+	if (!getenv("LESS"))
+		argv_array_push(&pager_process.env_array, "LESS=FRX");
+	if (!getenv("LV"))
+		argv_array_push(&pager_process.env_array, "LV=-c");
 	if (start_command(&pager_process))
 		return;
 
diff --git a/transport-helper.c b/transport-helper.c
index 2b24d51..033a228 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -108,12 +108,6 @@ static struct child_process *get_helper(struct transport *transport)
 	int refspec_alloc = 0;
 	int duped;
 	int code;
-	char git_dir_buf[sizeof(GIT_DIR_ENVIRONMENT) + PATH_MAX + 1];
-	const char *helper_env[] = {
-		git_dir_buf,
-		NULL
-	};
-
 
 	if (data->helper)
 		return data->helper;
@@ -129,8 +123,8 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
-	snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=%s", GIT_DIR_ENVIRONMENT, get_git_dir());
-	helper->env = helper_env;
+	argv_array_pushf(&helper->env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
+			 get_git_dir());
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
diff --git a/wt-status.c b/wt-status.c
index 1bf5d72..66d267c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -726,14 +726,14 @@ static void wt_status_print_changed(struct wt_status *s)
 static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary = CHILD_PROCESS_INIT;
-	struct argv_array env = ARGV_ARRAY_INIT;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf cmd_stdout = STRBUF_INIT;
 	struct strbuf summary = STRBUF_INIT;
 	char *summary_content;
 	size_t len;
 
-	argv_array_pushf(&env, "GIT_INDEX_FILE=%s", s->index_file);
+	argv_array_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s",
+			 s->index_file);
 
 	argv_array_push(&argv, "submodule");
 	argv_array_push(&argv, "summary");
@@ -745,14 +745,12 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 		argv_array_push(&argv, s->amend ? "HEAD^" : "HEAD");
 
 	sm_summary.argv = argv.argv;
-	sm_summary.env = env.argv;
 	sm_summary.git_cmd = 1;
 	sm_summary.no_stdin = 1;
 	fflush(s->fp);
 	sm_summary.out = -1;
 
 	run_command(&sm_summary);
-	argv_array_clear(&env);
 	argv_array_clear(&argv);
 
 	len = strbuf_read(&cmd_stdout, sm_summary.out, 1024);
-- 
2.1.2
