From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH v6] format-patch: introduce format.outputDirectory configuration
Date: Wed, 13 Jan 2016 06:20:11 -0700
Message-ID: <1452691211-15347-1-git-send-email-ischis2@cox.net>
References: <CAPig+cTCRq9VCT7t8E9yjk4QcHYB2_qeBwGB_31keB4nTjkLkA@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	"Stephen P . Smith" <ischis2@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLLd-0004ZI-BU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbcAMNUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:20:17 -0500
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:38862 "EHLO
	fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbcAMNUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:20:15 -0500
Received: from fed1rmimpo109 ([68.230.241.158]) by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160113132013.DLOE26406.fed1rmfepo203.cox.net@fed1rmimpo109>
          for <git@vger.kernel.org>; Wed, 13 Jan 2016 08:20:13 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo109 with cox
	id 5RLD1s0052tqoqC01RLDrc; Wed, 13 Jan 2016 08:20:13 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.56964F0D.0170,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LaPiHEji c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8 a=JSNQmZlDd7ZuTQoTR7oA:9
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 9A0FD13F628;
	Wed, 13 Jan 2016 06:20:15 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <CAPig+cTCRq9VCT7t8E9yjk4QcHYB2_qeBwGB_31keB4nTjkLkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283913>

From: Alexander Kuleshov <kuleshovmail@gmail.com>

We can pass -o/--output-directory to the format-patch command to store
patches in some place other than the working directory. This patch
introduces format.outputDirectory configuration option for same
purpose.

The case of usage of this configuration option can be convenience
to not pass every time -o/--output-directory if an user has pattern
to store all patches in the /patches directory for example.

The format.outputDirectory has lower priority than command line
option, so if user will set format.outputDirectory and pass the
command line option, a result will be stored in a directory that
passed to command line option.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    Fixed s/convinience/convenience/
    
    Moved 'static const char *config_output_directory;' to be with othe
    similarly typed variables.
    
    The full set of attempts is here [1].
    
    [1]: http://thread.gmane.org/gmane.comp.version-control.git/272180

 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  6 +++++-
 builtin/log.c                      |  6 ++++++
 t/t4014-format-patch.sh            | 15 +++++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

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
index e3cdaeb..64c2803 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -57,7 +57,11 @@ The names of the output files are printed to standard
 output, unless the `--stdout` option is specified.
 
 If `-o` is specified, output files are created in <dir>.  Otherwise
-they are created in the current working directory.
+they are created in the current working directory. The default path
+can be set with the 'format.outputDirectory' configuration option.
+The `-o` option takes precedence over `format.outputDirectory`.
+To store patches in the current working directory even when
+`format.outputDirectory` points elsewhere, use `-o .`.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index e00cea7..0d738d6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -699,6 +699,7 @@ static int do_signoff;
 static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
+static const char *config_output_directory;
 
 enum {
 	COVER_UNSET,
@@ -777,6 +778,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.outputdirectory"))
+		return git_config_string(&config_output_directory, var, value);
 
 	return git_log_config(var, value, cb);
 }
@@ -1391,6 +1394,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
 
+	if (!output_directory && !use_stdout)
+		output_directory = config_output_directory;
+
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
 	else
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 646c475..3b99434 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1445,4 +1445,19 @@ test_expect_success 'From line has expected format' '
 	test_cmp from filtered
 '
 
+test_expect_success 'format-patch format.outputDirectory option' '
+	test_config format.outputDirectory patches &&
+	rm -fr patches &&
+	git format-patch master..side &&
+	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
+'
+
+test_expect_success 'format-patch -o overrides format.outputDirectory' '
+	test_config format.outputDirectory patches &&
+	rm -fr patches patchset &&
+	git format-patch master..side -o patchset &&
+	test_path_is_missing patches &&
+	test_path_is_dir patchset
+'
+
 test_done
-- 
2.7.0-rc2
