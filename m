From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] format-patch: introduce format.outputDirectory configuration
Date: Sat, 20 Jun 2015 00:28:39 +0600
Message-ID: <1434738519-28093-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z612J-0002ot-JS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbbFSS3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 14:29:02 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33404 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbbFSS3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:29:00 -0400
Received: by laka10 with SMTP id a10so79187757lak.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LIsfBnZDLeIqC6SN4ZU7AR7gScwxoIGLF2nFLUjhD9U=;
        b=pjhSqvltcxvCL1vf0bIAcAUMf5bntTC/abUaOhrs6Lovg+pRDZmjGEc6Yy5wmtBogX
         EdiSNpJ0wkxe0YD7ogwF6WXr3KkUEuprw0RNmagg4Ac0ZuzziVTg43Lu6xv8/Rz6pkPs
         HEzhCd34oTQxfULhC1Y0z4B3YJQNrTTOSU6wA7dZ2y9u/wzGmkBWfnxYXDc/yejtG8AX
         qeSdWt2rOoIKQApN0reaMWfDqUzpLIcUiUKHcdNIpuzIM1WBpcjDntWu40rR8DOpkmU7
         LBKw9/t+BJBHjU8M3dhdPYKKxoZc654Ts1o1h3nm1fZXqx/UJ0yZBh/69IurEkops6IC
         8Afg==
X-Received: by 10.152.27.1 with SMTP id p1mr18783939lag.112.1434738538661;
        Fri, 19 Jun 2015 11:28:58 -0700 (PDT)
Received: from localhost.localdomain ([147.30.48.77])
        by mx.google.com with ESMTPSA id g3sm2656752lam.28.2015.06.19.11.28.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jun 2015 11:28:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.4.727.g5c3049e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272180>

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
---
 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  6 +++++-
 builtin/log.c                      |  8 ++++++++
 t/t4014-format-patch.sh            | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e159fe5..4f991b6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1262,6 +1262,10 @@ format.coverLetter::
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
index 0dac4e9..38ddd76 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -57,7 +57,11 @@ The names of the output files are printed to standard
 output, unless the `--stdout` option is specified.
 
 If `-o` is specified, output files are created in <dir>.  Otherwise
-they are created in the current working directory.
+they are created in the current working directory. The default path
+can be set with the seting 'format.outputDirectory' configuration option.
+If `-o` is specified and 'format.outputDirectory' is set, output files
+will be stored in a <dir> that passed to `-o`. When 'format.outputDirectory'
+is set to get default behaviour back is to pass './' to the `-o`.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index 78b3e2c..fc26360 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -688,6 +688,8 @@ enum {
 	COVER_AUTO
 };
 
+static const char *config_output_directory = NULL;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -758,6 +760,9 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.outputdirectory")) {
+		return git_config_string(&config_output_directory, var, value);
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1368,6 +1373,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
 
+	if (!output_directory && !use_stdout)
+		output_directory = config_output_directory;
+
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
 	else
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 890db11..613e2cc 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -40,6 +40,24 @@ test_expect_success setup '
 
 '
 
+test_expect_success "format-patch format.outputDirectory option" '
+	git config format.outputDirectory "patches/" &&
+	git format-patch master..side &&
+	cnt=$(ls | wc -l) &&
+	test $cnt = 3 &&
+	test_config format.outputDirectory "patches/" &&
+	git config --unset format.outputDirectory
+'
+
+test_expect_success "format-patch format.outputDirectory overwritten with -o" '
+	rm -rf "patches" &&
+	git config format.outputDirectory "patches/" &&
+	git format-patch master..side -o "." &&
+	test_must_fail ls patches/ &&
+	test_config format.outputDirectory "patches/" &&
+	git config --unset format.outputDirectory
+'
+
 test_expect_success "format-patch --ignore-if-in-upstream" '
 
 	git format-patch --stdout master..side >patch0 &&
-- 
2.4.4.727.g5c3049e.dirty
