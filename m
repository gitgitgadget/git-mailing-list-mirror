From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 2/2] log: add log.mailmap configuration option
Date: Sat, 22 Dec 2012 17:58:32 +0100
Message-ID: <1356195512-4846-3-git-send-email-apelisse@gmail.com>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 18:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmSXW-0003FR-OL
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 18:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab2LVRGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 12:06:51 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37221 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2LVRGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 12:06:50 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so2556685wgb.26
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZUrJqdYz8Px0bLnBKeZTF3gmlTEfRSXBZZ0KaKLRTME=;
        b=qvcS0bymziVgWUto8VSO87XStPIoic50qwznpg6giwhg26zwSfh6c8Xv3fSoCK+uJJ
         sfADBD1i2P1SBhRtIi+yqAyu/VUwlzHwITw+D7ovTbY0YcvbX8qeJurGD54FkjoPLdEJ
         aNvGbnJ6nGXEPQvk9bwj1QRlD8AJQw1T+vWPvtPEr1NLDypuWnM+PRSOriHKbP90+7aZ
         NCJvr/gxfgukM8a/Ke/OzpQ0DaCIjdg68xi2g3XFeFklGWO5vG5FVBC930+o3/a5VMUU
         ZgtBWyxhq/vj+DmjcCrlhCUV5O9npPXI1tjSLV3FqszX0gAPf+WQn/D+D1SqpWW3gJHV
         vB2w==
X-Received: by 10.194.61.105 with SMTP id o9mr29234932wjr.8.1356195522151;
        Sat, 22 Dec 2012 08:58:42 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id s10sm24125843wiw.4.2012.12.22.08.58.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Dec 2012 08:58:41 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.39.g9092a12
In-Reply-To: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212059>

This patch provides a new configuration option 'log.mailmap' to
automatically use the --use-mailmap option from git-show, git-log and
git-whatchanged commands.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
I'm wondering if it would be needed to add a no-use-mailmap option to
log command so that it can cancel this configuration option.

 Documentation/config.txt |    4 ++++
 builtin/log.c            |    8 +++++++-
 t/t4203-mailmap.sh       |   24 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..226362a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1509,6 +1509,10 @@ log.showroot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.

+log.mailmap::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+
 mailmap.file::
 	The location of an augmenting mailmap file. The default
 	mailmap, located in the root of the repository, is loaded
diff --git a/builtin/log.c b/builtin/log.c
index d2bd8ce..f6936ff 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
+static int use_mailmap;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;

@@ -138,7 +139,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;

-	if (mailmap) {
+	if (mailmap || use_mailmap) {
 		rev->mailmap = xcalloc(1, sizeof(struct string_list));
 		read_mailmap(rev->mailmap, NULL);
 	}
@@ -358,6 +359,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
+	if (!strcmp(var, "log.mailmap")) {
+		use_mailmap = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (grep_config(var, value, cb) < 0)
 		return -1;
 	return git_diff_ui_config(var, value, cb);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index e16187f..7d4d31c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -255,6 +255,21 @@ test_expect_success 'Log output with --use-mailmap' '
 '

 cat >expect <<\EOF
+Author: CTO <cto@company.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Other Author <other@author.xx>
+Author: Other Author <other@author.xx>
+Author: Some Dude <some@dude.xx>
+Author: A U Thor <author@example.com>
+EOF
+
+test_expect_success 'Log output with log.mailmap' '
+	git -c log.mailmap=True log | grep Author >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
 Author: Santa Claus <santa.claus@northpole.xx>
 Author: Santa Claus <santa.claus@northpole.xx>
 EOF
@@ -263,6 +278,15 @@ test_expect_success 'Grep author with --use-mailmap' '
 	git log --use-mailmap --author Santa | grep Author >actual &&
 	test_cmp expect actual
 '
+cat >expect <<\EOF
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+EOF
+
+test_expect_success 'Grep author with log.mailmap' '
+	git -c log.mailmap=True log --author Santa | grep Author >actual &&
+	test_cmp expect actual
+'

 >expect

--
1.7.9.5
