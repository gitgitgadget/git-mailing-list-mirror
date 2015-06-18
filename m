From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 11/19] pull: check if in unresolved merge state
Date: Thu, 18 Jun 2015 18:54:04 +0800
Message-ID: <1434624852-6869-12-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xco-0001tV-KT
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbbFRK4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:56:00 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36730 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbbFRKzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:15 -0400
Received: by paceq1 with SMTP id eq1so34540304pac.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YTDIDvBMm/zE0iT02K0y7OcA1yvsjgW3m0kimFg+JTg=;
        b=RLWQOASBSCPeGa3WMoLiHhH6yqvZPY0GPII3ZU+Ud5AYxTVuDMDo7NmKNfLP+wnU2E
         6rfGXusaYExZUAWGVg6kkWNIG51HeHv0SjnPLZq0QxB7gvKWLOwWPQqWouwGyjQqvPhw
         AMMcRNzvynAxlZHrPh0jBai+9ejqI8iuhTRe5H26m9T6WTcJfWgMJx6Jw2j3B0kRx9UL
         ejTEXsnPjuJW9s9/cnjRQEjjII4P6vBKAxQB1dxLgQHodUMCA+Bo59I3zm/4pt3Byu/7
         jqKuXnX0+jSIxZ8DiK/ES+ra5S8E/kD+qBkDhO1VECtob/kuoU45hUbmmzb01fJ4Vzv3
         5q1A==
X-Received: by 10.68.69.37 with SMTP id b5mr20255004pbu.35.1434624915120;
        Thu, 18 Jun 2015 03:55:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:13 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271956>

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
index b61cff5..1e688be 100644
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
