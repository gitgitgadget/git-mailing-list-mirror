From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH v2] difftool: Change prompt to display the number of files in the diff queue
Date: Wed,  4 Dec 2013 12:26:27 +1100
Message-ID: <1386120387-25300-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 02:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo1Ez-0005CE-35
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 02:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab3LDB05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 20:26:57 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:36860 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab3LDB04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 20:26:56 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so22220106pbc.40
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 17:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/yL+CITMwbNcb10G0j3e1N0vwQCobYe8+VxKPp4juhE=;
        b=B9v++VsaRQRzNLoDvkqX6CQHG9SdMedHhm2EWBbVhh9JD5b0QToYS6vDHUWqbaZgrb
         U33Vt3At1R2bJI7pGTF3XUQzdpQg2fyVIIbyH8lI6/Fg3VQsy/MdRUJW0oFWqfjedB1m
         RNZmlATyE/SytZo4gNYT3O4hK3Xt438Skrg5c3fbmHG8S/Rm2JEEsQ6IWXWtCG9UFwvi
         mleK/C9oOuo60oNU+NTKRW0qDgOUgfsBeWG7RKVx0+mbgIjUQQyKZxnOFyOiB5mxHqwj
         EAYSG6/KgHuf7iq2tSiB0wR8IzMqxjSk0jQJ1HWU+fFvmu9v1K72lW+XVMzPlyiOpWQ5
         p7nw==
X-Received: by 10.67.22.67 with SMTP id hq3mr53832672pad.132.1386120415635;
        Tue, 03 Dec 2013 17:26:55 -0800 (PST)
Received: from localhost.localdomain (202-129-81-152.perm.iinet.net.au. [202.129.81.152])
        by mx.google.com with ESMTPSA id uf2sm133147028pbc.28.2013.12.03.17.26.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 17:26:55 -0800 (PST)
X-Mailer: git-send-email 1.8.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238749>

When --prompt option is set, git-difftool displays a prompt for each modified
file to be viewed in an external diff program. At that point it could be useful
to display a counter and the total number of files in the diff queue.

Below is the current difftool prompt for the first of 5 modified files:
Viewing: 'diff.c'
Launch 'vimdiff' [Y/n]:

Consider the modified prompt:
Viewing (1/5): 'diff.c'
Launch 'vimdiff' [Y/n]:

The current GIT_EXTERNAL_DIFF mechanism does not tell the number of
paths in the diff queue nor the current counter. To make this
"counter/total" info available for GIT_EXTERNAL_DIFF programs without
breaking existing ones:

(1) Modify run_external_diff() function in diff.c to set one environment
variable for a counter and one for the total number of files in the diff
queue. The size of the diff queue is already available in the
diff_queue_struct. For the counter define a new variable in the
diff_options struct and reset it to zero in diff_setup_done() function.
Pre-increment the counter inside the run_external_diff() function.

(2) Modify git-difftool--helper.sh script to display the counter and the diff
queue count values in the difftool prompt.

(3) Update git.txt documentation

(4) Update t4020-diff-external.sh test script

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---

Reworked the patch to use environment variables instead of command line
arguments for making the counter and total values available to external
scripts. This way existing scripts will still work and can be updated 
later if they want to make use of these two new values.

 Documentation/git.txt    |  9 +++++++++
 diff.c                   | 19 +++++++++++++++++--
 diff.h                   |  2 ++
 git-difftool--helper.sh  |  3 ++-
 t/t4020-diff-external.sh | 16 ++++++++++++++++
 5 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4448ce2..10939ac 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -806,6 +806,15 @@ temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
 +
 For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
 parameter, <path>.
++
+For each path 'GIT_EXTERNAL_DIFF' is called, two environment variables,
+'GIT_DIFF_PATH_COUNTER' and 'GIT_DIFF_PATH_TOTAL' are set.
+
+'GIT_DIFF_PATH_COUNTER'::
+	A 1-based counter incremented by one for every path.
+
+'GIT_DIFF_PATH_TOTAL'::
+	The total number of paths.
 
 other
 ~~~~~
diff --git a/diff.c b/diff.c
index e34bf97..c4078af 100644
--- a/diff.c
+++ b/diff.c
@@ -2899,11 +2899,18 @@ static void run_external_diff(const char *pgm,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
 			      const char *xfrm_msg,
-			      int complete_rewrite)
+			      int complete_rewrite,
+			      struct diff_options *o)
 {
 	const char *spawn_arg[10];
 	int retval;
 	const char **arg = &spawn_arg[0];
+	struct diff_queue_struct *q = &diff_queued_diff;
+
+	struct strbuf counterstr = STRBUF_INIT;
+	struct strbuf totalstr = STRBUF_INIT;
+	strbuf_addf(&counterstr, "%d", ++o->diff_path_counter);
+	strbuf_addf(&totalstr, "%d", q->nr);
 
 	if (one && two) {
 		struct diff_tempfile *temp_one, *temp_two;
@@ -2928,8 +2935,14 @@ static void run_external_diff(const char *pgm,
 	}
 	*arg = NULL;
 	fflush(NULL);
+
+	setenv ("GIT_DIFF_PATH_COUNTER", counterstr.buf, 1);
+	setenv ("GIT_DIFF_PATH_TOTAL", totalstr.buf, 1);
+
 	retval = run_command_v_opt(spawn_arg, RUN_USING_SHELL);
 	remove_tempfile();
+	strbuf_release(&counterstr);
+	strbuf_release(&totalstr);
 	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
 		exit(1);
@@ -3042,7 +3055,7 @@ static void run_diff_cmd(const char *pgm,
 
 	if (pgm) {
 		run_external_diff(pgm, name, other, one, two, xfrm_msg,
-				  complete_rewrite);
+				  complete_rewrite, o);
 		return;
 	}
 	if (one && two)
@@ -3317,6 +3330,8 @@ void diff_setup_done(struct diff_options *options)
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
+
+    options->diff_path_counter = 0;
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
diff --git a/diff.h b/diff.h
index e342325..42bd34c 100644
--- a/diff.h
+++ b/diff.h
@@ -164,6 +164,8 @@ struct diff_options {
 	diff_prefix_fn_t output_prefix;
 	int output_prefix_length;
 	void *output_prefix_data;
+
+	int diff_path_counter;
 };
 
 enum color_diff {
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index b00ed95..7ef36b9 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -40,7 +40,8 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
-		printf "\nViewing: '%s'\n" "$MERGED"
+		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
+			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
 		if use_ext_cmd
 		then
 			printf "Launch '%s' [Y/n]: " \
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 8a30979..4935fc4 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -193,6 +193,22 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
 	GIT_EXTERNAL_DIFF=echo git diff
 '
 
+echo "#!$SHELL_PATH" >external-diff.sh
+cat >> external-diff.sh <<\EOF
+echo $GIT_DIFF_PATH_COUNTER of $GIT_DIFF_PATH_TOTAL >>counter.txt
+EOF
+chmod a+x external-diff.sh
+
+test_expect_success 'GIT_EXTERNAL_DIFF path counter/total' '
+	GIT_EXTERNAL_DIFF=./external-diff.sh git diff &&
+	echo "1 of 2" >expect &&
+	head -n 1 counter.txt >actual &&
+	test_cmp expect actual &&
+	echo "2 of 2" >expect &&
+	tail -n 1 counter.txt >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
 	touch file.ext &&
 	git add file.ext &&
-- 
1.8.4.4
