From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] grep: add --heading
Date: Sun, 05 Jun 2011 17:24:36 +0200
Message-ID: <4DEB9FB4.8020904@lsrfire.ath.cx>
References: <4DEB9F07.1070006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 17:24:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTFCA-0008Ut-5g
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 17:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1FEPYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 11:24:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:46537 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1FEPYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 11:24:49 -0400
Received: from [192.168.2.106] (p4FFD8E69.dip.t-dialin.net [79.253.142.105])
	by india601.server4you.de (Postfix) with ESMTPSA id 7E2EC2F8003;
	Sun,  5 Jun 2011 17:24:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DEB9F07.1070006@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175080>

With --heading, the filename is printed once before matches from that
file instead of at the start of each line, giving more screen space to
the actual search results.

This option is taken from ack (http://betterthangrep.com/).  And now
git grep can dress up like it:

	$ git config alias.ack "grep --break --heading --line-number"

	$ git ack -e --heading
	Documentation/git-grep.txt
	154:--heading::
	
	t/t7810-grep.sh
	785:test_expect_success 'grep --heading' '
	786:    git grep --heading -e char -e lo_w hello.c hello_world >actual &&
	808:    git grep --break --heading -n --color \

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |    4 ++++
 builtin/grep.c             |    2 ++
 grep.c                     |    6 +++++-
 grep.h                     |    1 +
 t/t7810-grep.sh            |   37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dea7cad..07b3c6a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -151,6 +151,10 @@ OPTIONS
 --break::
 	Print an empty line between matches from different files.
 
+--heading::
+	Show the filename above the matches in that file instead of
+	at the start of each shown line.
+
 -[ABC] <context>::
 	Show `context` trailing (`A` -- after), or leading (`B`
 	-- before), or both (`C` -- context) lines, and place a
diff --git a/builtin/grep.c b/builtin/grep.c
index 42bb87f..cccf8da 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -824,6 +824,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT__COLOR(&opt.color, "highlight matches"),
 		OPT_BOOLEAN(0, "break", &opt.file_break,
 			"print empty line between matches from different files"),
+		OPT_BOOLEAN(0, "heading", &opt.heading,
+			"show filename only once above matches from same file"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', NULL, &opt, "n",
 			"show <n> context lines before and after matches",
diff --git a/grep.c b/grep.c
index b0b860a..04e9ba4 100644
--- a/grep.c
+++ b/grep.c
@@ -735,9 +735,13 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			opt->output(opt, "\n", 1);
 		}
 	}
+	if (opt->heading && opt->last_shown == 0) {
+		output_color(opt, name, strlen(name), opt->color_filename);
+		opt->output(opt, "\n", 1);
+	}
 	opt->last_shown = lno;
 
-	if (opt->pathname) {
+	if (!opt->heading && opt->pathname) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		output_sep(opt, sign);
 	}
diff --git a/grep.h b/grep.h
index 638bee8..c568297 100644
--- a/grep.h
+++ b/grep.h
@@ -111,6 +111,7 @@ struct grep_opt {
 	unsigned last_shown;
 	int show_hunk_mark;
 	int file_break;
+	int heading;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f55793e..1227fa6 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -774,4 +774,41 @@ test_expect_success 'grep --break with context' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+hello.c
+int main(int argc, const char **argv)
+	/* char ?? */
+hello_world
+Hello_world
+EOF
+
+test_expect_success 'grep --heading' '
+	git grep --heading -e char -e lo_w hello.c hello_world >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+<BOLD;GREEN>hello.c<RESET>
+2:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
+6:	/* <BLACK;BYELLOW>char<RESET> ?? */
+
+<BOLD;GREEN>hello_world<RESET>
+3:Hel<BLACK;BYELLOW>lo_w<RESET>orld
+EOF
+
+test_expect_success 'mimic ack-grep --group' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		"bold green" &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		"black yellow" &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --break --heading -n --color \
+		-e char -e lo_w hello.c hello_world |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.6.rc0.3.ga805ac
