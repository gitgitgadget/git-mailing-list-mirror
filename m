From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] grep: add --break
Date: Sun, 05 Jun 2011 17:24:25 +0200
Message-ID: <4DEB9FA9.1050602@lsrfire.ath.cx>
References: <4DEB9F07.1070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 17:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTFBy-0008Qj-No
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 17:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1FEPYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 11:24:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:46533 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab1FEPYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 11:24:37 -0400
Received: from [192.168.2.106] (p4FFD8E69.dip.t-dialin.net [79.253.142.105])
	by india601.server4you.de (Postfix) with ESMTPSA id D9BA82F8003;
	Sun,  5 Jun 2011 17:24:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEB9F07.1070006@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175079>

With --break, an empty line is printed between matches from different
files, increasing readability.  This option is taken from ack
(http://betterthangrep.com/).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |    3 +++
 builtin/grep.c             |    4 +++-
 grep.c                     |    7 +++++--
 grep.h                     |    1 +
 t/t7810-grep.sh            |   28 ++++++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index e150c77..dea7cad 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -148,6 +148,9 @@ OPTIONS
 	gives the default to color output.
 	Same as `--color=never`.
 
+--break::
+	Print an empty line between matches from different files.
+
 -[ABC] <context>::
 	Show `context` trailing (`A` -- after), or leading (`B`
 	-- before), or both (`C` -- context) lines, and place a
diff --git a/builtin/grep.c b/builtin/grep.c
index 0d5a90b..42bb87f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -822,6 +822,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('c', "count", &opt.count,
 			"show the number of matches instead of matching lines"),
 		OPT__COLOR(&opt.color, "highlight matches"),
+		OPT_BOOLEAN(0, "break", &opt.file_break,
+			"print empty line between matches from different files"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', NULL, &opt, "n",
 			"show <n> context lines before and after matches",
@@ -976,7 +978,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		use_threads = 0;
 
 	if (use_threads) {
-		if (opt.pre_context || opt.post_context)
+		if (opt.pre_context || opt.post_context || opt.file_break)
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
diff --git a/grep.c b/grep.c
index 3f15085..b0b860a 100644
--- a/grep.c
+++ b/grep.c
@@ -721,7 +721,10 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	int rest = eol - bol;
 	char *line_color = NULL;
 
-	if (opt->pre_context || opt->post_context) {
+	if (opt->file_break && opt->last_shown == 0) {
+		if (opt->show_hunk_mark)
+			opt->output(opt, "\n", 1);
+	} else if (opt->pre_context || opt->post_context) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark) {
 				output_color(opt, "--", 2, opt->color_sep);
@@ -941,7 +944,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	if (!opt->output)
 		opt->output = std_output;
 
-	if (opt->pre_context || opt->post_context) {
+	if (opt->pre_context || opt->post_context || opt->file_break) {
 		/* Show hunk marks, except for the first file. */
 		if (opt->last_shown)
 			opt->show_hunk_mark = 1;
diff --git a/grep.h b/grep.h
index cd055cd..638bee8 100644
--- a/grep.h
+++ b/grep.h
@@ -110,6 +110,7 @@ struct grep_opt {
 	unsigned post_context;
 	unsigned last_shown;
 	int show_hunk_mark;
+	int file_break;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 539a8fe..f55793e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -746,4 +746,32 @@ test_expect_success 'grep --color, separator' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+hello.c:int main(int argc, const char **argv)
+hello.c:	/* char ?? */
+
+hello_world:Hello_world
+EOF
+
+test_expect_success 'grep --break' '
+	git grep --break -e char -e lo_w hello.c hello_world >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c:int main(int argc, const char **argv)
+hello.c-{
+--
+hello.c:	/* char ?? */
+hello.c-}
+
+hello_world:Hello_world
+hello_world-HeLLo_world
+EOF
+
+test_expect_success 'grep --break with context' '
+	git grep --break -A1 -e char -e lo_w hello.c hello_world >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.6.rc0.3.ga805ac
