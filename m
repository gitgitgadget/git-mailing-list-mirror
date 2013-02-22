From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] add: allow users to silence Git 2.0 warnings about "add -u"
Date: Thu, 21 Feb 2013 22:07:04 -0800
Message-ID: <1361513224-34550-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 07:07:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8lnQ-0000LN-3J
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 07:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab3BVGHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 01:07:17 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:59924 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab3BVGHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 01:07:15 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so212049pbc.40
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 22:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=UYvFs+4a7MRSH5ZpGz6w+TcjjgUJ2X4+8zlulCod/AI=;
        b=elOT9rJLy9TZ8XO7h1saweEZovrAX2sQ54plGlXP4guU5rtwPVEowlOeibfqdRHHIO
         Pa9XcVsfs8aBwt/VEHOW/ZBMRMGr4cwQ78B5SqEShbT6f6LPJPiVg1oDKNPQTWw9rZ3P
         JMFD+IiNEr6/bd4hSN5D0sCQ8xh167HVQ7rfyFLYiYtY8UIFtDgWvrhlq4Qsbjz2kUHy
         JHpQWW8wYXXQ3Ap5K6F3PmOsf9rQzTDVCDAqPc8kYsGmbOatMCcRIRJYyj3GhOMhxeok
         Zm1qcIg7mGiL2Q5Aw3XexaSVWBYIpTTPAbtLJFzp4XHbXxIKiFgxbf1G6OA9hVicaPT6
         Hwdg==
X-Received: by 10.66.163.166 with SMTP id yj6mr2201162pab.130.1361513235249;
        Thu, 21 Feb 2013 22:07:15 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ub1sm1376866pbc.5.2013.02.21.22.07.13
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 Feb 2013 22:07:14 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.22.gb3600c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216818>

When "git add -u" is invoked from a subdirectory it prints a
loud warning message about an upcoming Git 2.0 behavior change.
Some users do not care to be warned.  Accomodate them.

The "add.silence-pathless-warnings" configuration variable can
now be used to silence this warning.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
I found the warning a informative but also a little annoying.
I can imagine others might as well.

I would also like to change the warning message to mention what the Git 2.0
behavior will be (which it does not mention), but I realize that the string
has already been translated.  That can be a follow-on patch if this is seen as
a worthwhile change, but might not be worth the trouble since it's a problem
which will go away in 2.0.

 Documentation/config.txt |  7 +++++++
 builtin/add.c            |  8 +++++++-
 t/t2200-add-update.sh    | 11 +++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3bb53da..b6ed859 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -648,6 +648,13 @@ core.abbrev::
 	for abbreviated object names to stay unique for sufficiently long
 	time.
 
+add.silence-pathless-warnings::
+	Tells 'git add' to silence warnings when 'git add -u' is used in
+	a subdirectory without specifying a path.  Git 2.0 updates the
+	whole tree.  Git 1.x updates the current directory only, and warns
+	about the upcoming change unless this variable is set to true.
+	False by default, and ignored by Git 2.0.
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/builtin/add.c b/builtin/add.c
index 0dd014e..01b9cac 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -272,6 +272,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
+static int silence_pathless_warnings;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -296,6 +297,8 @@ static int add_config(const char *var, const char *value, void *cb)
 	    !strcmp(var, "add.ignore-errors")) {
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
+	} else if (!strcmp(var, "add.silence-pathless-warnings")) {
+		silence_pathless_warnings = git_config_bool(var, value);
 	}
 	return git_default_config(var, value, cb);
 }
@@ -321,7 +324,8 @@ static int add_files(struct dir_struct *dir, int flags)
 	return exit_status;
 }
 
-static void warn_pathless_add(const char *option_name, const char *short_name) {
+static void warn_pathless_add(const char *option_name, const char *short_name)
+{
 	/*
 	 * To be consistent with "git add -p" and most Git
 	 * commands, we should default to being tree-wide, but
@@ -332,6 +336,8 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
 	 * turned into a die(...), and eventually we may
 	 * reallow the command with a new behavior.
 	 */
+	if (silence_pathless_warnings)
+		return;
 	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
 		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
 		  "To add content for the whole tree, run:\n"
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 4cdebda..779dbe7 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -171,4 +171,15 @@ test_expect_success '"add -u non-existent" should fail' '
 	! (git ls-files | grep "non-existent")
 '
 
+test_expect_success 'add.silence-pathless-warnings configuration variable' '
+	: >expect &&
+	test_config add.silence-pathless-warnings true &&
+	(
+		cd dir1 &&
+		echo more >>sub2 &&
+		git add -u
+	) >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.2.rc0.22.gb3600c3.dirty
