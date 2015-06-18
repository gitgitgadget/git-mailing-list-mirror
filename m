From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Thu, 18 Jun 2015 17:18:00 +0600
Message-ID: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xpm-0005cN-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbbFRLSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:18:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33557 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbbFRLSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:18:07 -0400
Received: by laka10 with SMTP id a10so52171357lak.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Y4NDo58UmQIf3mlYTjBdQ0GD2q/aWAq17h/HTENk5WI=;
        b=0IBZBOnIzDrpPHMYgtnoVI/rBiyv6JOC7RhIaYSf4y7rOz6g2HkKNetX990siDMGRa
         EmCPlBejj+f2PSGpK1CApRa1SMlQACqrz6zE2tR4fvlOO6eLkAk4e08yraIUAqlwqgFT
         hGDm2EMAscumLTA7qUemxZIThYoRyniSVAR2Ai/O6ng1euo/3A4fzeZ/0q5fUX7nfhbm
         L1iYiLS1Or4suVfwehJhpDzdh0Rgu9aEOaoIltjoQTKe5QgER2tK7KpaPsqUE4P9qHRL
         Hx/Aayk9Pk0Cj8BOzcuScvneSAkq71ZbjdPt1/sVztq+hB6PU4DjfesYTP3IsAAgTIkh
         PCnA==
X-Received: by 10.152.170.165 with SMTP id an5mr12653517lac.100.1434626286060;
        Thu, 18 Jun 2015 04:18:06 -0700 (PDT)
Received: from localhost.localdomain ([37.151.32.43])
        by mx.google.com with ESMTPSA id ox10sm1699780lbc.30.2015.06.18.04.18.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:18:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.383.gded6615.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271963>

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
 Documentation/config.txt |  4 ++++
 builtin/log.c            | 14 ++++++++++++--
 t/t4014-format-patch.sh  |  9 +++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd2036c..8f6f7ed 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1247,6 +1247,10 @@ format.coverLetter::
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
 
+format.outputDirectory::
+	Set a custom directory to store the resulting files instead of the
+	current working directory.
+
 filter.<driver>.clean::
 	The command which is used to convert the content of a worktree
 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
diff --git a/builtin/log.c b/builtin/log.c
index dfb351e..22c1e46 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -687,6 +687,8 @@ enum {
 	COVER_AUTO
 };
 
+static const char *config_output_directory = NULL;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -757,6 +759,9 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
 		return 0;
 	}
+	if (!strcmp(var, "format.outputdirectory")) {
+		return git_config_string(&config_output_directory, var, value);
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1006,7 +1011,8 @@ static const char *clean_message_id(const char *msg_id)
 	return xmemdupz(a, z - a);
 }
 
-static const char *set_outdir(const char *prefix, const char *output_directory)
+static const char *set_outdir(const char *prefix, const char *output_directory,
+			      const char *config_output_directory)
 {
 	if (output_directory && is_absolute_path(output_directory))
 		return output_directory;
@@ -1014,6 +1020,9 @@ static const char *set_outdir(const char *prefix, const char *output_directory)
 	if (!prefix || !*prefix) {
 		if (output_directory)
 			return output_directory;
+
+		if (config_output_directory)
+			return config_output_directory;
 		/* The user did not explicitly ask for "./" */
 		outdir_offset = 2;
 		return "./";
@@ -1368,7 +1377,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		init_display_notes(&rev.notes_opt);
 
 	if (!use_stdout)
-		output_directory = set_outdir(prefix, output_directory);
+		output_directory = set_outdir(prefix, output_directory,
+					      config_output_directory);
 	else
 		setup_pager();
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c39e500..a4b18b5 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -40,6 +40,15 @@ test_expect_success setup '
 
 '
 
+test_expect_success "format-patch format.outputDirectory option" '
+	git config format.outputDirectory "patches/" &&
+	git format-patch master..side &&
+	cnt=$(ls | wc -l) &&
+	echo $cnt &&
+	test $cnt = 3 &&
+	git config --unset format.outputDirectory
+'
+
 test_expect_success "format-patch --ignore-if-in-upstream" '
 
 	git format-patch --stdout master..side >patch0 &&
-- 
2.4.0.383.gded6615.dirty
