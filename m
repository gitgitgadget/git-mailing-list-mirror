From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH] difftool: Change prompt to display the number of files in the diff queue
Date: Thu, 28 Nov 2013 11:49:54 +1100
Message-ID: <1385599794-6002-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 02:03:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlq0R-0005uR-PR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 02:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab3K1BC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 20:02:56 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35345 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3K1BCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 20:02:54 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so10956856pdj.22
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 17:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MZkc8d+ArLd+0OKZ7PmqSNKTm84CMBP6Kbz/XfDtg0U=;
        b=Vvj/zLE+k+kG0ySP9KS1wSTOwsXNchJKof6j/2p8RWk44cL+lRyZrHzSvk1Ffz14dY
         gkp8B8xazBf8xCK4gPHy9o7vgDj/AgbTmiY3PyD1gtyDQKrCCz4ASeJzIr9Tf6xNUp/K
         YCyR1/4zlDcZNnwhitPXqPBMN88bSVTEvx4PGyWeqjM1tcwbcJHGzB8qtR7JmFsdJHoN
         u00TXONxNlTzKjqD099y5AaWig4h8XLBMARGnHQZ6iBcSKy+cu02o09hp7RzqUunTGHI
         IyhYpuD2zw5SXuHP1KmPipIQlZE1M7IdEFWg9xRwvHlo0PfMQibx/1yK2LWbbL83GXTt
         ZTzg==
X-Received: by 10.68.191.106 with SMTP id gx10mr7932629pbc.47.1385600574106;
        Wed, 27 Nov 2013 17:02:54 -0800 (PST)
Received: from localhost.localdomain (202-129-81-152.perm.iinet.net.au. [202.129.81.152])
        by mx.google.com with ESMTPSA id b3sm40427694pbu.38.2013.11.27.17.02.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Nov 2013 17:02:53 -0800 (PST)
X-Mailer: git-send-email 1.8.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238471>

When --prompt option is set, git-difftool displays a prompt for each
modified file to be viewed in an external diff program. At that point it
could be useful to display a counter and the total number of files in
the diff queue.

Below is the current difftool prompt for the first of 5 modified files:
Viewing: 'diff.c'
Launch 'vimdiff' [Y/n]:

Consider the modified prompt:
Viewing (1/5): 'diff.c'
Launch 'vimdiff' [Y/n]:

(1) Modify run_external_diff() function in diff.c to pass a counter and
the total number of files in the diff queue to the external program.

(2) Modify git-difftool--helper.sh script to display the counter and the
diff queue count values in the difftool prompt.

(3) Update git.txt documentation

(4) Update t4020-diff-external.sh test script

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---
 Documentation/git.txt    |  6 +++++-
 diff.c                   | 14 +++++++++++++-
 git-difftool--helper.sh  |  8 +++++---
 t/t4020-diff-external.sh | 27 +++++++++++++++++++++------
 4 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b73a24a..d8241bb 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -785,9 +785,10 @@ Git Diffs
 	When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
 	program named by it is called, instead of the diff invocation
 	described above.  For a path that is added, removed, or modified,
-        'GIT_EXTERNAL_DIFF' is called with 7 parameters:
+	'GIT_EXTERNAL_DIFF' is called with 9 parameters:
 
 	path old-file old-hex old-mode new-file new-hex new-mode
+	counter total
 +
 where:
 
@@ -795,6 +796,9 @@ where:
                          contents of <old|new>,
 	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
+	counter:: is a numeric value incremented by one for every modified
+				file
+	total:: is the total number of modified files
 +
 The file parameters can point at the user's working file
 (e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
diff --git a/diff.c b/diff.c
index e34bf97..938f00a 100644
--- a/diff.c
+++ b/diff.c
@@ -37,6 +37,7 @@ static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
+static int diff_display_counter = 1;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -2901,9 +2902,16 @@ static void run_external_diff(const char *pgm,
 			      const char *xfrm_msg,
 			      int complete_rewrite)
 {
-	const char *spawn_arg[10];
+	const char *spawn_arg[12];
 	int retval;
 	const char **arg = &spawn_arg[0];
+	struct diff_queue_struct *q = &diff_queued_diff;
+
+	struct strbuf counterstr = STRBUF_INIT;
+	struct strbuf totalstr = STRBUF_INIT;
+	strbuf_addf(&counterstr, "%d", diff_display_counter++);
+	strbuf_addf(&totalstr, "%d", q->nr);
+
 
 	if (one && two) {
 		struct diff_tempfile *temp_one, *temp_two;
@@ -2918,6 +2926,8 @@ static void run_external_diff(const char *pgm,
 		*arg++ = temp_two->name;
 		*arg++ = temp_two->hex;
 		*arg++ = temp_two->mode;
+		*arg++ = counterstr.buf;
+		*arg++ = totalstr.buf;
 		if (other) {
 			*arg++ = other;
 			*arg++ = xfrm_msg;
@@ -2930,6 +2940,8 @@ static void run_external_diff(const char *pgm,
 	fflush(NULL);
 	retval = run_command_v_opt(spawn_arg, RUN_USING_SHELL);
 	remove_tempfile();
+	strbuf_release(&counterstr);
+	strbuf_release(&totalstr);
 	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
 		exit(1);
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index b00ed95..4444c26 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -35,12 +35,14 @@ launch_merge_tool () {
 	LOCAL="$2"
 	REMOTE="$3"
 	BASE="$1"
+	COUNTER="$4"
+	TOTAL="$5"
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
-		printf "\nViewing: '%s'\n" "$MERGED"
+		printf "\nViewing (%s/%s): '%s'\n" "$COUNTER" "$TOTAL" "$MERGED"
 		if use_ext_cmd
 		then
 			printf "Launch '%s' [Y/n]: " \
@@ -82,7 +84,7 @@ else
 	# Launch the merge tool on each path provided by 'git diff'
 	while test $# -gt 6
 	do
-		launch_merge_tool "$1" "$2" "$5"
-		shift 7
+		launch_merge_tool "$1" "$2" "$5" "$8" "$9"
+		shift 9
 	done
 fi
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 8a30979..a8cf9c6 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -8,7 +8,9 @@ test_expect_success setup '
 
 	test_tick &&
 	echo initial >file &&
-	git add file &&
+	echo foo >file2 &&
+	echo bar >file3 &&
+	git add file file2 file3 &&
 	git commit -m initial &&
 
 	test_tick &&
@@ -18,16 +20,20 @@ test_expect_success setup '
 
 	test_tick &&
 	echo third >file
+	echo quux >file2
+	echo quux >file3
 '
 
 test_expect_success 'GIT_EXTERNAL_DIFF environment' '
 
 	GIT_EXTERNAL_DIFF=echo git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
+		read path oldfile oldhex oldmode newfile newhex newmode counter total &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
 		test "z$newhex" = "z$_z40" &&
 		test "z$newmode" = z100644 &&
+		test "z$counter" = z1 &&
+		test "z$total" = z3 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
 	}
@@ -49,14 +55,17 @@ test_expect_success 'GIT_EXTERNAL_DIFF environment and --no-ext-diff' '
 '
 
 test_expect_success SYMLINKS 'typechange diff' '
+	git checkout -- file2 file3 &&
 	rm -f file &&
 	ln -s elif file &&
 	GIT_EXTERNAL_DIFF=echo git diff  | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
+		read path oldfile oldhex oldmode newfile newhex newmode counter total &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
 		test "z$newhex" = "z$_z40" &&
 		test "z$newmode" = z120000 &&
+		test "z$counter" = z1 &&
+		test "z$total" = z1 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
 	} &&
@@ -70,11 +79,13 @@ test_expect_success 'diff.external' '
 	echo third >file &&
 	test_config diff.external echo &&
 	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
+		read path oldfile oldhex oldmode newfile newhex newmode counter total &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
 		test "z$newhex" = "z$_z40" &&
 		test "z$newmode" = z100644 &&
+		test "z$counter" = z1 &&
+		test "z$total" = z1 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
 	}
@@ -101,11 +112,13 @@ test_expect_success 'diff attribute' '
 	echo >.gitattributes "file diff=parrot" &&
 
 	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
+		read path oldfile oldhex oldmode newfile newhex newmode counter total &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
 		test "z$newhex" = "z$_z40" &&
 		test "z$newmode" = z100644 &&
+		test "z$counter" = z1 &&
+		test "z$total" = z1 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
 	}
@@ -134,11 +147,13 @@ test_expect_success 'diff attribute' '
 	echo >.gitattributes "file diff=color" &&
 
 	git diff | {
-		read path oldfile oldhex oldmode newfile newhex newmode &&
+		read path oldfile oldhex oldmode newfile newhex newmode counter total &&
 		test "z$path" = zfile &&
 		test "z$oldmode" = z100644 &&
 		test "z$newhex" = "z$_z40" &&
 		test "z$newmode" = z100644 &&
+		test "z$counter" = z1 &&
+		test "z$total" = z1 &&
 		oh=$(git rev-parse --verify HEAD:file) &&
 		test "z$oh" = "z$oldhex"
 	}
-- 
1.8.4.4
