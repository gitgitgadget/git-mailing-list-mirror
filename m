From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 43/45] builtin-am: implement legacy -b/--binary option
Date: Mon, 20 Jul 2015 00:10:35 +0800
Message-ID: <1437322237-29863-44-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrCp-0006qN-8e
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbbGSQMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:12:43 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33820 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbbGSQMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:12:37 -0400
Received: by pdbbh15 with SMTP id bh15so44250129pdb.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5r8MYA9E70odoig3+jT8wBuVC5R+3YTQGM/k8N2AnVQ=;
        b=t8jm3GRj9dsiZWmfflFy5O3HU9j0PtXcZx1A5DbxBQCttcx0rSrHMlhxAtuZMK7xkf
         qPRs9oz3LWHa4G50LIXQAGwZdFLc4umzMr/MO6M1ofzfvcuBXmYg3GvcCVdxTFrlW0Wm
         xl+bHmQ2cgFK5UquvTvhD1Jk38a9iwYULsqsKnc9OZUrNa6aZp+HWo9paBCn0DHINLPx
         GeBWk7zKtOqasVvZkc1jmthAcWtj8kxXZ3aocG6BwC5YG5ybv7mVphEOO3KxwpXh1ktA
         P1b5UBxKjYD7TP5Zxw3qIFLTOwyGu+z+xFLc0FfI7X+lPSNlNzoc50RHHN+63XGLQI70
         khVA==
X-Received: by 10.69.27.33 with SMTP id jd1mr49588697pbd.34.1437322356625;
        Sun, 19 Jul 2015 09:12:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.12.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:12:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274260>

The -b/--binary option was initially implemented in 087b674 (git-am:
--binary; document --resume and --binary., 2005-11-16). The option will
pass the --binary flag to git-apply to allow it to apply binary patches.

However, in 2b6eef9 (Make apply --binary a no-op., 2006-09-06), --binary
was been made a no-op in git-apply. Following that, since cb3a160
(git-am: ignore --binary option, 2008-08-09), the --binary option in
git-am is ignored as well.

In 6c15a1c (am: officially deprecate -b/--binary option, 2012-03-13),
the --binary option was tweaked to its present behavior: when set, the
message:

	The -b/--binary option has been a no-op for long time, and it
	will be removed. Please do not use it anymore.

will be printed.

Re-implement this in builtin/am.c.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 39ea3c7..6a2b887 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2127,6 +2127,7 @@ enum resume_mode {
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
+	int binary = -1;
 	int keep_cr = -1;
 	int patch_format = PATCH_FORMAT_UNKNOWN;
 	enum resume_mode resume = RESUME_FALSE;
@@ -2140,6 +2141,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('i', "interactive", &state.interactive,
 			N_("run interactively")),
+		OPT_HIDDEN_BOOL('b', "binary", &binary,
+			N_("(historical option -- no-op")),
 		OPT_BOOL('3', "3way", &state.threeway,
 			N_("allow fall back on 3way merging if needed")),
 		OPT__QUIET(&state.quiet, N_("be quiet")),
@@ -2240,6 +2243,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
+	if (binary >= 0)
+		fprintf_ln(stderr, _("The -b/--binary option has been a no-op for long time, and\n"
+				"it will be removed. Please do not use it anymore."));
+
 	if (read_index_preload(&the_index, NULL) < 0)
 		die(_("failed to read the index"));
 
-- 
2.5.0.rc2.110.gb39b692
