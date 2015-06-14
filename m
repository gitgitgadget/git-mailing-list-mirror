From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 11/19] pull: check if in unresolved merge state
Date: Sun, 14 Jun 2015 16:41:58 +0800
Message-ID: <1434271326-11349-12-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Vo-0006Uq-37
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbbFNInV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:21 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33310 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbFNInA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:00 -0400
Received: by pdjn11 with SMTP id n11so51430846pdj.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i0h/Wvut2fUJfxD/sRsAg0sWNpwqQGFYUiD31do43tw=;
        b=X239J6+AaXU6X0bVh0rfYdaRdWcyPRtyWQ9WxeuIuO+xg9UhqZgQmYhbeiSVnOnxh2
         JJd+53B5ITh81aweRze2b56iESKmRj13+yVuf9khCzRPW/7FYihBt3fICTSV33x4/aby
         s9P0QJCLeboh19W+o/G8HVpkcEoFKnBD9M6OEfdBMqrfwAvA5puLObgQft+7eb8zeaYT
         LHGDM/qkdW5PusIB+IrfetzPCFqUqeRYnY5f+N3/U/bLzLt/TQcoFg2d2DMbrjnddDvD
         u6Dq0bYrXdnOMwr77A4S5b12usDKtNXDH0uoBSZo32cVppf2KcW1t89UbeyFapNYC2IA
         XOfg==
X-Received: by 10.70.130.35 with SMTP id ob3mr16544982pdb.64.1434271379676;
        Sun, 14 Jun 2015 01:42:59 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:58 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271623>

Since d38a30d (Be more user-friendly when refusing to do something
because of conflict., 2010-01-12), git-pull will error out with
user-friendly advices if the user is in the middle of a merge or has
unmerged files.

Re-implement this behavior. While the "has unmerged files" case can be
handled by die_resolve_conflict(), we introduce a new function
die_conclude_merge() for printing a different error message for when
there are no unmerged files but the merge has not been finished.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 advice.c       | 8 ++++++++
 advice.h       | 1 +
 builtin/pull.c | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/advice.c b/advice.c
index 575bec2..4965686 100644
--- a/advice.c
+++ b/advice.c
@@ -96,6 +96,14 @@ void NORETURN die_resolve_conflict(const char *me)
 	die("Exiting because of an unresolved conflict.");
 }
 
+void NORETURN die_conclude_merge(void)
+{
+	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
+	if (advice_resolve_conflict)
+		advise(_("Please, commit your changes before you can merge."));
+	die(_("Exiting because of unfinished merge."));
+}
+
 void detach_advice(const char *new_name)
 {
 	const char fmt[] =
diff --git a/advice.h b/advice.h
index 5ecc6c1..b341a55 100644
--- a/advice.h
+++ b/advice.h
@@ -24,6 +24,7 @@ __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
+void NORETURN die_conclude_merge(void);
 void detach_advice(const char *new_name);
 
 #endif /* ADVICE_H */
diff --git a/builtin/pull.c b/builtin/pull.c
index 0ddb964..cb5898a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "sha1-array.h"
 #include "remote.h"
+#include "dir.h"
 
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repository> [<refspec>...]]"),
@@ -426,6 +427,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
+	git_config(git_default_config, NULL);
+
+	if (read_cache_unmerged())
+		die_resolve_conflict("Pull");
+
+	if (file_exists(git_path("MERGE_HEAD")))
+		die_conclude_merge();
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
-- 
2.1.4
