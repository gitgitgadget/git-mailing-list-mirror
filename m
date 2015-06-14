From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 18/19] pull --rebase: error on no merge candidate cases
Date: Sun, 14 Jun 2015 16:42:05 +0800
Message-ID: <1434271326-11349-19-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:44:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43WI-0006jy-0N
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbFNInx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:53 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33452 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbFNInV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:21 -0400
Received: by pdjn11 with SMTP id n11so51434002pdj.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C++9veg7Rwj02IJwm4GlnMKZ5ISxj9sS9IRsEbTLj7I=;
        b=ZoModWU6Aqvh6DSQuRYhxftWtuI2eDsoKyfvQuJZsI4nQEs/R6y7rvSf3lF9sFcDXB
         D2bYQBFKtANfL8bAweqEDsOx1U/2Z6I8YqEjHPfJnO5wes5vTxHPLaQwgH7ebJcUNidM
         nDenXnKwIXStj8bGfLkF69GUaS8afdsY/yraPkOyqKJMdVeIBkHWSN9huPvDuQBSWJrI
         B/7wM0ab2X/tqCqgMDeY5Bu0xvVkDZmXT/XQruNsdmUQ/hh2bur7uPEra0eWionjqGvV
         ++ZRECZtP4seA2F4ci4MuAUMCtRI8E7ZGMLxhY2maXuTCM4xgvU1fhstRpJdS+o++s9N
         Kxgw==
X-Received: by 10.70.52.103 with SMTP id s7mr37385568pdo.117.1434271401486;
        Sun, 14 Jun 2015 01:43:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:19 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271632>

Tweak the error messages printed by die_no_merge_candidates() to take
into account that we may be "rebasing against" rather than "merging
with".

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a379c1f..b78c67c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -430,7 +430,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
+		if (opt_rebase)
+			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
+		else
+			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
 		fprintf_ln(stderr, _("Generally this means that you provided a wildcard refspec which had no\n"
 					"matches on the remote end."));
 	} else if (repo && curr_branch && (!remote || strcmp(repo, remote))) {
@@ -440,7 +443,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
+		if (opt_rebase)
+			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
+		else
+			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git pull <remote> <branch>");
@@ -452,7 +458,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = "<remote>";
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
+		if (opt_rebase)
+			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
+		else
+			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
 		fprintf_ln(stderr, _("See git-pull(1) for details."));
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git pull <remote> <branch>");
-- 
2.1.4
