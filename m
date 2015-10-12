From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/8] fetch submodules in parallel
Date: Mon, 12 Oct 2015 11:47:13 -0700
Message-ID: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:48:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8k-0006ca-TX
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbbJLSsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:48:00 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33666 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbJLSr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:26 -0400
Received: by pabrc13 with SMTP id rc13so25735240pab.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zZ/gk2TFauyz9rpEw05LOoxG2ktruY3cWibw8drFjgA=;
        b=g/B4OBpmk+pj4pEriJEBrdBiUSd84lNhzeH6KVtQ46886JqNaqxZK5zhset5INDsml
         la0O097kMpkhIP6oqBc4lrkZAjgAUWKejF3IQbCdfVoDoxD7RW/q5VgJ2fO9/HCPGGDT
         s+KNE+6vs36S2aB0eCX7dPxYgBwAfLaDK5cVEeNtWk1j8J9DVkICQpUJzwzJ6iODq5vh
         qtxf7JLStr4PWIxybyJmICzwiR6wJGN1c37bmP+rz9TvBLOLijslCE+72clBxN75KXMH
         +/Z1COd5rpAsEaHhYYQpm5q740OIzByV27HPWWDPanWyNJfc9QEDwFP2/AW7epHjpDRw
         v/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zZ/gk2TFauyz9rpEw05LOoxG2ktruY3cWibw8drFjgA=;
        b=BIOepO3ulxa/Wop+4sCzemief6e+MAcjPT4OSGpdgETgiiKB/CkV+Qn5AQTpu51UuI
         h/gxzsTpIsdoltCBVEE4IKYLSsqRYhuhhYvAI23kzVb1CbUFxbrYkQCCJjcgxgOkApEd
         +cq41Te8mIKdfZm1Bk9T+bRbMHJd0dVcGu4YLf6MyG8VtHohrSWOh6XTr10ha6ejpVlu
         tzJX4Zq+t707lPoTnz/u4LmFrfgCWovLnCEqH+/e3XG7lzmfz5CgrzrkG3RLZ3/oU4nK
         sEiaL+Zw1Nlt1aXkHfshx+Rmiok45SlMk7yOnsxreEespulB4nwgfKdnTS8mTZFyBFlp
         VsCg==
X-Gm-Message-State: ALoCoQm1T5zeOlxxutW5GjivDOuYxkUgx1XUjRCWh9zPpEO4N/tWr2Plis41eUd8BVsHXCBCJRPI
X-Received: by 10.66.124.229 with SMTP id ml5mr35674753pab.77.1444675646165;
        Mon, 12 Oct 2015 11:47:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id ze3sm19827768pac.5.2015.10.12.11.47.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279402>

fixing two smaller nits noticed by Ramsay
 * make struct parallel_processes static
 * omit the forward declaration of get_next_submodule by reordering.

Jonathan Nieder (1):
  submodule.c: write "Fetching submodule <foo>" to stderr

Stefan Beller (7):
  xread: poll on non blocking fds
  xread_nonblock: add functionality to read from fds without blocking
  strbuf: add strbuf_read_once to read without blocking
  sigchain: add command to pop all common signals
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: allow parallel fetching, add tests and documentation

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 git-compat-util.h               |   1 +
 run-command.c                   | 350 ++++++++++++++++++++++++++++++++++++++++
 run-command.h                   |  78 +++++++++
 sigchain.c                      |   9 ++
 sigchain.h                      |   1 +
 strbuf.c                        |  11 ++
 strbuf.h                        |   9 ++
 submodule.c                     | 144 ++++++++++++-----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  70 +++++---
 test-run-command.c              |  25 +++
 wrapper.c                       |  35 +++-
 16 files changed, 701 insertions(+), 73 deletions(-)

 $ git diff origin/sb/submodule-parallel-fetch

diff --git a/run-command.c b/run-command.c
index 28048a7..ef3da27 100644
--- a/run-command.c
+++ b/run-command.c
@@ -855,7 +855,7 @@ int capture_command(struct child_process *cmd, struct strbuf *buf, size_t hint)
 	return finish_command(cmd);
 }
 
-struct parallel_processes {
+static struct parallel_processes {
 	void *data;
 
 	int max_processes;
diff --git a/submodule.c b/submodule.c
index cf8bf5d..c21b265 100644
--- a/submodule.c
+++ b/submodule.c
@@ -628,68 +628,6 @@ struct submodule_parallel_fetch {
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0}
 
 static int get_next_submodule(void **task_cb, struct child_process *cp,
-			      struct strbuf *err, void *data);
-
-static int fetch_start_failure(struct child_process *cp,
-			       struct strbuf *err,
-			       void *cb, void *task_cb)
-{
-	struct submodule_parallel_fetch *spf = cb;
-
-	spf->result = 1;
-
-	return 0;
-}
-
-static int fetch_finish(int retvalue, struct child_process *cp,
-			struct strbuf *err, void *cb, void *task_cb)
-{
-	struct submodule_parallel_fetch *spf = cb;
-
-	if (retvalue)
-		spf->result = 1;
-
-	return 0;
-}
-
-int fetch_populated_submodules(const struct argv_array *options,
-			       const char *prefix, int command_line_option,
-			       int quiet, int max_parallel_jobs)
-{
-	int i;
-	struct submodule_parallel_fetch spf = SPF_INIT;
-
-	spf.work_tree = get_git_work_tree();
-	spf.command_line_option = command_line_option;
-	spf.quiet = quiet;
-	spf.prefix = prefix;
-
-	if (!spf.work_tree)
-		goto out;
-
-	if (read_cache() < 0)
-		die("index file corrupt");
-
-	argv_array_push(&spf.args, "fetch");
-	for (i = 0; i < options->argc; i++)
-		argv_array_push(&spf.args, options->argv[i]);
-	argv_array_push(&spf.args, "--recurse-submodules-default");
-	/* default value, "--submodule-prefix" and its value are added later */
-
-	calculate_changed_submodule_paths();
-	run_processes_parallel(max_parallel_jobs,
-			       get_next_submodule,
-			       fetch_start_failure,
-			       fetch_finish,
-			       &spf);
-
-	argv_array_clear(&spf.args);
-out:
-	string_list_clear(&changed_submodule_paths, 1);
-	return spf.result;
-}
-
-static int get_next_submodule(void **task_cb, struct child_process *cp,
 			      struct strbuf *err, void *data)
 {
 	int ret = 0;
@@ -775,6 +713,65 @@ static int get_next_submodule(void **task_cb, struct child_process *cp,
 	return 0;
 }
 
+static int fetch_start_failure(struct child_process *cp,
+			       struct strbuf *err,
+			       void *cb, void *task_cb)
+{
+	struct submodule_parallel_fetch *spf = cb;
+
+	spf->result = 1;
+
+	return 0;
+}
+
+static int fetch_finish(int retvalue, struct child_process *cp,
+			struct strbuf *err, void *cb, void *task_cb)
+{
+	struct submodule_parallel_fetch *spf = cb;
+
+	if (retvalue)
+		spf->result = 1;
+
+	return 0;
+}
+
+int fetch_populated_submodules(const struct argv_array *options,
+			       const char *prefix, int command_line_option,
+			       int quiet, int max_parallel_jobs)
+{
+	int i;
+	struct submodule_parallel_fetch spf = SPF_INIT;
+
+	spf.work_tree = get_git_work_tree();
+	spf.command_line_option = command_line_option;
+	spf.quiet = quiet;
+	spf.prefix = prefix;
+
+	if (!spf.work_tree)
+		goto out;
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	argv_array_push(&spf.args, "fetch");
+	for (i = 0; i < options->argc; i++)
+		argv_array_push(&spf.args, options->argv[i]);
+	argv_array_push(&spf.args, "--recurse-submodules-default");
+	/* default value, "--submodule-prefix" and its value are added later */
+
+	calculate_changed_submodule_paths();
+	run_processes_parallel(max_parallel_jobs,
+			       get_next_submodule,
+			       fetch_start_failure,
+			       fetch_finish,
+			       &spf);
+
+	argv_array_clear(&spf.args);
+out:
+	string_list_clear(&changed_submodule_paths, 1);
+	return spf.result;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;

-- 
2.5.0.268.g453a26a
