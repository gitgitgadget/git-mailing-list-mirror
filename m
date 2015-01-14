From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] init-db: use OPT__QUIET macro instead OPT_BIT
Date: Wed, 14 Jan 2015 23:32:42 +0600
Message-ID: <1421256762-26765-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:33:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRoS-00064m-B4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbbANRcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:32:55 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:43645 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbbANRcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:32:53 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so9119627lbv.11
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 09:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QKFSmiDpEjw5GDbP2+OM3ajPP43yuPkX2bpZG/YTG8s=;
        b=Ku9BJpW90EzjVp/0vh6nLpYJ9Jj/nrz5Jkq/ImYQxqcrkDSX3RwdPjPuuheivOXmst
         mt3WQ0lnZOjCvgKLJY7BlwC5ise8xDIrSpGTRrqyJRjv/RsTp4D3Mne2B9g6rgWJaJSw
         fQgAxZ607bVuwMFSdPAmOoY6tYGGMfBk8aJr3V5sFV8+SMkyMy+N21C/5/ztH/mN+uj5
         ANt8L7+SbXMPy0qAS0+lpnD4njUBdhszYJqSCbtMs/TuTESMdVwqzEZ8PJe2CD+M7w95
         1dU2PWlgcRsNk3Pcg1PBQfjax+6XQGLkjYeCbJ9pqVQDWm6HG4oHCNeUSechY44XYSHc
         Zfeg==
X-Received: by 10.112.62.194 with SMTP id a2mr5141424lbs.73.1421256771870;
        Wed, 14 Jan 2015 09:32:51 -0800 (PST)
Received: from localhost.localdomain ([178.89.21.160])
        by mx.google.com with ESMTPSA id kw10sm1937160lac.45.2015.01.14.09.32.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jan 2015 09:32:50 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.256.g17f147e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262397>

There is OPT__QUIET macro for easily -q/--quiet option defenition,
let's use it instead OPT_BIT

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/init-db.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 280454a..a89343b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -368,7 +368,7 @@ static void separate_git_dir(const char *git_dir)
 	write_file(git_link, 1, "gitdir: %s\n", git_dir);
 }
 
-int init_db(const char *template_dir, unsigned int flags)
+int init_db(const char *template_dir, unsigned int quiet)
 {
 	int reinit;
 	const char *git_dir = get_git_dir();
@@ -411,8 +411,7 @@ int init_db(const char *template_dir, unsigned int flags)
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
-	if (!(flags & INIT_DB_QUIET)) {
+	if (!(quiet & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
 		/* TRANSLATORS: The first '%s' is either "Reinitialized
@@ -483,7 +482,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
-	unsigned int flags = 0;
+	unsigned int quiet = 0;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
@@ -493,7 +492,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			N_("permissions"),
 			N_("specify that the git repository is to be shared amongst several users"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
-		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
+		OPT__QUIET(&quiet, N_("suppress progress reporting")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
 		OPT_END()
@@ -593,5 +592,5 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	set_git_dir_init(git_dir, real_git_dir, 1);
 
-	return init_db(template_dir, flags);
+	return init_db(template_dir, quiet);
 }
-- 
2.3.0.rc0.256.g17f147e
