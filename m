From: David Turner <dturner@twopensource.com>
Subject: [PATCH] log: add log.follow config option
Date: Wed,  1 Jul 2015 15:03:59 -0400
Message-ID: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 21:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANJ7-0005qY-S0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbbGATEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:04:24 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35250 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbbGATEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:04:15 -0400
Received: by qget71 with SMTP id t71so23146924qge.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3vkJqlaiAbjpN6uddweo0zAnNw0kfRRZs72abvgb0hE=;
        b=lNlr2CmOYNoOyTiGcTPIDCGyHEhH4kcRhaE9+CQMug/v/7tI5TxKOW3zfCPBcCqcgw
         XTRqyQhwy6Dtr9r61mMMuo3u1Nu8yhP58I/Zf5imeqpORd67lQyf3nJqiN3eYpFctchg
         AHcVfd+rHYPVICfXILzx1Sli4jzrx7GnjWUEjvRSLLd/Yoexqr3CiW/tOPRQotjTt6E2
         7j6FV3Ui9uhoEckWE+jv72dB15/2+KzjZFHTMfkcGvMnTwrrMzT9ECwqCEw93Jm/ThRB
         TqudkjCWSqEJhhOQyXsJ+G1MK/e1Hr3hiqaEXNeyqcFtmTNRB8PEm84rCwtPeEyw0A9V
         j0ug==
X-Gm-Message-State: ALoCoQktZE/SIFv+js73AbCluHhE0KlK7wOkcuuokQHValNXZKtghkyBib0iIkFSZvRWsmleImD3
X-Received: by 10.140.150.198 with SMTP id 189mr38225670qhw.88.1435777454177;
        Wed, 01 Jul 2015 12:04:14 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id w67sm1467588qgw.41.2015.07.01.12.04.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 12:04:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273184>

Many users prefer to always use --follow with logs.  Rather than
aliasing the command, an option might be more convenient for some.

Signed-off-by: David Turner <dturner@twopensource.com>
---

Why not just alias log=log --follow?

At Twitter, we manage git config centrally, but we also allow users to
add their own aliases.  We would like to turn log.follow on globally,
while not messing up any aliases users already have for log.

Also, some users might have different log aliases for different
repositories, but want to manage --follow globally.

And in the future, we might want to make log --follow the default (it
is what I usually want), so it would be nice to provide a way for
users to turn that off globally from a config option.

 builtin/log.c                       |  7 +++++++
 t/t4206-log-follow-harder-copies.sh | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8781049..11b8d82 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
 
 static int default_abbrev_commit;
 static int default_show_root = 1;
+static int default_follow = 0;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -102,6 +103,8 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 {
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
+	if (default_follow)
+		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->diffopt.stat_width = -1; /* use full terminal width */
@@ -390,6 +393,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.follow")) {
+		default_follow = git_config_bool(var, value);
+		return 0;
+	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index ad29e65..6b2f3b9 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -53,4 +53,27 @@ test_expect_success \
     'validate the output.' \
     'compare_diff_patch current expected'
 
+test_expect_success \
+    'git config log.follow works like --follow' \
+    'test_config log.follow true &&
+     git log --name-status --pretty="format:%s"  path1 > current'
+
+test_expect_success \
+    'validate the output.' \
+    'compare_diff_patch current expected'
+
+test_expect_success \
+    'git config log.follow is overridden by --no-follow' \
+    'test_config log.follow true &&
+     git log --no-follow --name-status --pretty="format:%s"  path1 > current'
+
+cat >expected <<\EOF
+Copy path1 from path0
+A	path1
+EOF
+
+test_expect_success \
+    'validate the output.' \
+    'compare_diff_patch current expected'
+
 test_done
-- 
2.0.5.499.g01f6352.dirty-twtrsrc
