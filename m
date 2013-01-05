From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 10/10] log: add log.mailmap configuration option
Date: Sat,  5 Jan 2013 22:26:46 +0100
Message-ID: <1357421206-5014-11-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHb-0000ix-5h
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab3AEV1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:36 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:51950 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab3AEV1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:25 -0500
Received: by mail-we0-f170.google.com with SMTP id r1so8670345wey.15
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bbTSqZIHWsP0ZPtF+canxmLL5eBDAq5Nm/L7fOKLu4M=;
        b=OIve+6l0JHG3UyiG5k1oVvdNsM6wxZOtQrd2xkK//ireQv6eMyYMhmVbu22Rf+Iaah
         vWPWszQF3trSA5bjTUluoIfr/pPR1qd7FhNG/5qqmkdQSLN3L7TKxvVNeY61PSa6rC9q
         7nwslFTsqSXapTBSWACmi7ubFb8DOF9n8YBKmAFsglD5StATUj8YseZGvYKFivjJ3lCW
         UrwcEmBxKLzyOYIaQZ1rbhstr9jp00Y0hdIVsygAanloTiBGNohZWX3/l8MMuuq6tD4e
         OUl9KtVNYE5VCK0DjiV0Qyh/Vq9WHDJkulkt+y8XbW1FAU9UAVjAYMR4RLvVc49lTEYE
         fuJQ==
X-Received: by 10.180.14.10 with SMTP id l10mr3194570wic.7.1357421244167;
        Sat, 05 Jan 2013 13:27:24 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:23 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212726>

Teach "log.mailmap" configuration variable to turn "--use-mailmap"
option on to "git log", "git show" and "git whatchanged".

The "--no-use-mailmap" option from the command line can countermand
the setting.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/config.txt |  4 ++++
 builtin/log.c            |  7 +++++++
 t/t4203-mailmap.sh       | 24 ++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

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
index d2bd8ce..16e6520 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
+static int use_mailmap_config;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -106,6 +107,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
+	mailmap = use_mailmap_config;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
@@ -358,6 +360,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	}
 	if (!prefixcmp(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
+	if (!strcmp(var, "log.mailmap")) {
+		use_mailmap_config = git_config_bool(var, value);
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
1.7.12.4.3.g2036a08.dirty
