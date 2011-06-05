From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] grep: fix coloring of hunk marks between files
Date: Sun, 05 Jun 2011 17:24:15 +0200
Message-ID: <4DEB9F9F.7040704@lsrfire.ath.cx>
References: <4DEB9F07.1070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 17:24:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTFBp-0008NY-NN
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 17:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab1FEPY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 11:24:28 -0400
Received: from india601.server4you.de ([85.25.151.105]:46531 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab1FEPY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 11:24:28 -0400
Received: from [192.168.2.106] (p4FFD8E69.dip.t-dialin.net [79.253.142.105])
	by india601.server4you.de (Postfix) with ESMTPSA id 1AD732F8003;
	Sun,  5 Jun 2011 17:24:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEB9F07.1070006@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175078>

Commit 431d6e7b (grep: enable threading for context line printing)
split the printing of the "--\n" mark between results from different
files out into two places: show_line() in grep.c for the non-threaded
case and work_done() in builtin/grep.c for the threaded case.  Commit
55f638bd (grep: Colorize filename, line number, and separator) updated
the former, but not the latter, so the separators between files are
not colored if threads are used.

This patch merges the two.  In the threaded case, hunk marks are now
printed by show_line() for every file, including the first one, and the
very first mark is simply skipped in work_done().  This ensures that the
output is properly colored and works just as well.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/grep.c  |   23 ++++++++++++++++-------
 grep.c          |   15 ++++++++++++---
 t/t7810-grep.sh |   30 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 871afaa..0d5a90b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -93,8 +93,7 @@ static pthread_cond_t cond_write;
 /* Signalled when we are finished with everything. */
 static pthread_cond_t cond_result;
 
-static int print_hunk_marks_between_files;
-static int printed_something;
+static int skip_first_line;
 
 static void add_work(enum work_type type, char *name, void *id)
 {
@@ -160,10 +159,20 @@ static void work_done(struct work_item *w)
 	    todo_done = (todo_done+1) % ARRAY_SIZE(todo)) {
 		w = &todo[todo_done];
 		if (w->out.len) {
-			if (print_hunk_marks_between_files && printed_something)
-				write_or_die(1, "--\n", 3);
-			write_or_die(1, w->out.buf, w->out.len);
-			printed_something = 1;
+			const char *p = w->out.buf;
+			size_t len = w->out.len;
+
+			/* Skip the leading hunk mark of the first file. */
+			if (skip_first_line) {
+				while (len) {
+					len--;
+					if (*p++ == '\n')
+						break;
+				}
+				skip_first_line = 0;
+			}
+
+			write_or_die(1, p, len);
 		}
 		free(w->name);
 		free(w->identifier);
@@ -968,7 +977,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (use_threads) {
 		if (opt.pre_context || opt.post_context)
-			print_hunk_marks_between_files = 1;
+			skip_first_line = 1;
 		start_threads(&opt);
 	}
 #else
diff --git a/grep.c b/grep.c
index d03d9e2..3f15085 100644
--- a/grep.c
+++ b/grep.c
@@ -941,9 +941,18 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	if (!opt->output)
 		opt->output = std_output;
 
-	if (opt->last_shown && (opt->pre_context || opt->post_context) &&
-	    opt->output == std_output)
-		opt->show_hunk_mark = 1;
+	if (opt->pre_context || opt->post_context) {
+		/* Show hunk marks, except for the first file. */
+		if (opt->last_shown)
+			opt->show_hunk_mark = 1;
+		/*
+		 * If we're using threads then we can't easily identify
+		 * the first file.  Always put hunk marks in that case
+		 * and skip the very first one later in work_done().
+		 */
+		if (opt->output != std_output)
+			opt->show_hunk_mark = 1;
+	}
 	opt->last_shown = 0;
 
 	switch (opt->binary) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 69bd576..539a8fe 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -716,4 +716,34 @@ test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
 	test_cmp expected actual
 '
 
+test_config() {
+	git config "$1" "$2" &&
+	test_when_finished "git config --unset $1"
+}
+
+cat >expected <<EOF
+hello.c<RED>:<RESET>int main(int argc, const char **argv)
+hello.c<RED>-<RESET>{
+<RED>--<RESET>
+hello.c<RED>:<RESET>	/* char ?? */
+hello.c<RED>-<RESET>}
+<RED>--<RESET>
+hello_world<RED>:<RESET>Hello_world
+hello_world<RED>-<RESET>HeLLo_world
+EOF
+
+test_expect_success 'grep --color, separator' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		normal &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	red &&
+
+	git grep --color=always -A1 -e char -e lo_w hello.c hello_world |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.6.rc0.3.ga805ac
