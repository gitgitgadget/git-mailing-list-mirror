From: Ivan Ukhov <ivan.ukhov@gmail.com>
Subject: [PATCH] commit: add -f to force creation when no changes or an empty message
Date: Sun, 29 Mar 2015 17:34:19 +0200
Message-ID: <E2201BDB-4441-4BD0-B0ED-2F39A2838A7F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2093\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 29 17:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcFFe-00029I-Gs
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 17:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbbC2PeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 11:34:24 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:35290 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbC2PeX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2015 11:34:23 -0400
Received: by lahp7 with SMTP id p7so82208945lah.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=55L25eBO9xH1Z2eOEF4PaczvcetrwqzV6eF5U1pxO9s=;
        b=Aet07HmuW8NTyhopi3IeVbCbx51/uQEG3CQf7/ypPch4RkhWvV+6zmEFF0nYz8hq+3
         yjjaFudzXDTCBtC3VDSTHJkx/abda0OdlOG5w+TsVsnMhVgzok9QGRkYiYI+GUU0LVuY
         /eoFV83nssWFA6wa03ErQaONfl79uWt/P1/iJiLhg/FA/ji3yB6VaQuTotIMaL6iYIMN
         Ez4AmxaapdcIvcY/yblL0NCyaLL9iRICxurQarp1UrUA+6rL45gnz+gKkzTXxRkbGaAn
         maK4DpH5MRkKGb3IIWTzsxk52iHDPHdI9WBUTZk8/tz964L8lo1L2b+noLU0dcfDfJeS
         mv9Q==
X-Received: by 10.112.44.132 with SMTP id e4mr25558173lbm.66.1427643261534;
        Sun, 29 Mar 2015 08:34:21 -0700 (PDT)
Received: from c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se (c-15c6e455.011-537-6c6b701.cust.bredbandsbolaget.se. [85.228.198.21])
        by mx.google.com with ESMTPSA id j6sm1528331laf.5.2015.03.29.08.34.20
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Mar 2015 08:34:20 -0700 (PDT)
X-Mailer: Apple Mail (2.2093)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266437>

An attempt to commit gets rejected if there are no changes staged or there is no
message given. In such a case, the --allow-empty and --allow-empty-message flags
can be used to force the action. The standard approach to force an action,
however, is the -f/--force flag, as used in other built-ins.

Signed-off-by: Ivan Ukhov <ivan.ukhov@gmail.com>
---
 builtin/commit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index da79ac4..fb76aee 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -113,7 +113,7 @@ static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
-static int no_post_rewrite, allow_empty_message;
+static int no_post_rewrite, allow_empty_message, force;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;

@@ -1614,6 +1614,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT__FORCE(&force, N_("force creation when no changes or an empty message")),
 		/* end commit contents options */

 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
@@ -1653,6 +1654,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	allow_empty += force;
+	allow_empty_message += force;
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
--
2.3.4
