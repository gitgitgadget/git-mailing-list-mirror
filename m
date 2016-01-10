From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH v3] format-patch: introduce format.outputDirectory configuration
Date: Sat,  9 Jan 2016 19:30:19 -0700
Message-ID: <1452393019-2852-1-git-send-email-ischis2@cox.net>
References: <CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	"Stephen P . Smith" <ischis2@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 03:30:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI5m3-0007Cf-6J
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 03:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699AbcAJC3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 21:29:47 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:48725 "EHLO
	fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668AbcAJC3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 21:29:45 -0500
Received: from fed1rmimpo305 ([68.230.241.173]) by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160110022945.WYJL11111.fed1rmfepo103.cox.net@fed1rmimpo305>
          for <git@vger.kernel.org>; Sat, 9 Jan 2016 21:29:45 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo305 with cox
	id 42Vk1s0062tqoqC012VkqX; Sat, 09 Jan 2016 21:29:44 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.5691C218.00BD,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=f8aW8pOM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8 a=JSNQmZlDd7ZuTQoTR7oA:9
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 8A19F13F7BB;
	Sat,  9 Jan 2016 19:30:32 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283612>

From: Alexander Kuleshov <kuleshovmail@gmail.com>

We can pass -o/--output-directory to the format-patch command to
store patches not in the working directory. This patch introduces
format.outputDirectory configuration option for same purpose.

The case of usage of this configuration option can be convinience
to not pass everytime -o/--output-directory if an user has pattern
to store all patches in the /patches directory for example.

The format.outputDirectory has lower priority than command line
option, so if user will set format.outputDirectory and pass the
command line option, a result will be stored in a directory that
passed to command line option.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    Re-rolled patch by following review comments in:
    
    http://article.gmane.org/gmane.comp.version-control.git/272199
    http://article.gmane.org/gmane.comp.version-control.git/278354
    http://article.gmane.org/gmane.comp.version-control.git/278365
    
    Changes include:
    * Specifying the patches directory as an argument to ls
    * Not initialize config_output_directory  to NULL
    * Grammar fixes in documentation
    * Use test_config rather than git config

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  6 +++++-
 builtin/log.c                      |  7 +++++++
 t/t4014-format-patch.sh            | 13 +++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..e92a0ee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1243,6 +1243,10 @@ format.coverLetter::
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
 
+format.outputDirectory::
+	Set a custom directory to store the resulting files instead of the
+	current working directory.
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index e3cdaeb..7a76594 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -57,7 +57,11 @@ The names of the output files are printed to standard
 output, unless the `--stdout` option is specified.
 
 If `-o` is specified, output files are created in <dir>.  Otherwise
-they are created in the current working directory.
+they are created in the current working directory. The default path
+can be set with the setting 'format.outputDirectory' configuration option.
+If `-o` is specified and 'format.outputDirectory' is set, output files
+will be stored in a <dir> that passed to `-o`. When 'format.outputDirectory'
+is set, to get default behaviour back is to pass './' to the `-o`.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index e00cea7..679ff76 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -707,6 +707,8 @@ enum {
 	COVER_AUTO
 };
 
+static const char *config_output_directory;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -777,6 +779,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.outputdirectory"))
+		return git_config_string(&config_output_directory, var, value);
 
 	return git_log_config(var, value, cb);
 }
@@ -1391,6 +1395,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
 
+	if (!output_directory && !use_stdout)
+		output_directory = config_output_directory;
+
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
 	else
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 646c475..5c6f128 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -40,6 +40,19 @@ test_expect_success setup '
 
 '
 
+test_expect_success "format-patch format.outputDirectory option" '
+	test_config format.outputDirectory "patches/" &&
+	git format-patch master..side &&
+	cnt=$(ls patches | wc -l) &&
+	test $cnt = 3
+'
+
+test_expect_success "format-patch format.outputDirectory overwritten with -o" '
+	test_config format.outputDirectory "patches/" &&
+	git format-patch master..side -o "." &&
+	test_path_is_missing patches/
+'
+
 test_expect_success "format-patch --ignore-if-in-upstream" '
 
 	git format-patch --stdout master..side >patch0 &&
-- 
2.7.0-rc2
