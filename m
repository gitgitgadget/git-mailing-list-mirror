From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] reset: allow --keep with --stage
Date: Thu, 29 Aug 2013 13:19:56 -0500
Message-ID: <1377800397-5434-3-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6uF-00083W-8z
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab3H2SZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:25:12 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:50299 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab3H2SZL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:25:11 -0400
Received: by mail-oa0-f44.google.com with SMTP id l17so1076878oag.17
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3+oVgeYwGrwMweYjMi8Zq27EiMSe+K6cbeCM+Huxe0=;
        b=l/j9/F45HovAjKziVj+mb6M9Meuq4cJYc3CfoOf5LCTZNQPcyJlXUyVc170G/zGHiC
         2AamULCTMjOYHi9o5E+ZWEutm04WEsHOH9nbpQ1qcLuw1jBpZnRst/sNXQ9XTurT4uA7
         PhBgc7l7V98IYJGKkm8VllzlvTI2c3Z3DbwOMJpcFN1kG5UbsNdJ1dBJwlqVI2vclrhS
         +SaxgpZ7l3nxXMrPc0rop7UZzUB9bZZuH4HcCQzNtBKkJl1TPd5tmsms6YBgtsQ1S+Gq
         RVemK+qZx5/b+rpiBCOHeQrpU/0bUPvmoahUja4T8NCV3HtG/nlG2cJuHMdzIECCbkQ4
         UFLQ==
X-Received: by 10.60.47.129 with SMTP id d1mr1237432oen.84.1377800710729;
        Thu, 29 Aug 2013 11:25:10 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm33780540oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:25:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233322>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-reset.txt |  2 +-
 builtin/reset.c             | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 5cd75a8..a1419c9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git reset' [-q] [<tree-ish>] [--] <paths>...
 'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
-'git reset' [--stage | --work] [-q] [<commit>]
+'git reset' [--stage | --work | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/reset.c b/builtin/reset.c
index fbc1abc..dde03a7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,7 +23,7 @@
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
-	N_("git reset [--stage | --work] [-q] [<commit>]"),
+	N_("git reset [--stage | --work | --keep] [-q] [<commit>]"),
 	N_("git reset [-q] <tree-ish> [--] <paths>..."),
 	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),
 	NULL
@@ -295,8 +295,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	}
 
 	if (stage >= 0 || working_tree >= 0) {
-		if (reset_type != NONE)
+		int keep = 0;
+
+		if (reset_type == KEEP) {
+			if (working_tree == 1)
+				die(_("--keep is incompatible with --work"));
+			keep = 1;
+		} else if (reset_type != NONE) {
 			die(_("--{stage,work} are incompatible with --{hard,mixed,soft,merge}"));
+		}
 
 		if (working_tree == 1) {
 			if (stage == 0)
@@ -304,7 +311,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			reset_type = HARD;
 		} else {
 			if (stage == 1)
-				reset_type = NONE;
+				reset_type = keep ? KEEP : NONE;
 			else
 				reset_type = SOFT;
 		}
-- 
1.8.4-fc
