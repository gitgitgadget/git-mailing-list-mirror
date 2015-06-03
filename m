From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 11/19] pull: check if in unresolved merge state
Date: Wed,  3 Jun 2015 14:48:55 +0800
Message-ID: <1433314143-4478-12-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VT-0004oQ-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbbFCGuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35713 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbFCGuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:18 -0400
Received: by padjw17 with SMTP id jw17so698304pad.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQzPEDmAlcIkz2J6FWRPC1V1M1W5zncmU/uy2IXKKo8=;
        b=FtpImMQQ0CeM9RKMRn1eYbfuh5JfSP0R5dZ+xk5qtUeJwmnf78YBJOGGzMUtgWdCpg
         AbRGvEvO26PTL0PGtCwnMa82mXtQL0EFi+z/i6SN/vPZTLO2E8DHVAjqkDHx0CWObZch
         y3iSiS0ZZrtRnlP2ERLKoIL2vt0ObPbyzlE7HYalxvZLktili9KWAJwKsAh5THmTrUsE
         m4KjC7iIURG8kjJRDy2kxoOOHhwtVoNT/81nFrbu+sI3D8L4s3neTQtAvkZ5iIfCByc3
         1rojdKX0T5exdbI4woLfbA0WEIv3kJGx88RyNTqYJJI34B8QqmhpSR0gOi546iNVlDf7
         ZJHA==
X-Received: by 10.66.250.106 with SMTP id zb10mr57209927pac.36.1433314217616;
        Tue, 02 Jun 2015 23:50:17 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:16 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270650>

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
index 1c1883d..703fc1d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "sha1-array.h"
 #include "remote.h"
+#include "dir.h"
 
 static const char * const pull_usage[] = {
 	N_("git pull [options] [<repository> [<refspec>...]]"),
@@ -422,6 +423,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	git_config(git_default_config, NULL);
+
+	if (read_cache_unmerged())
+		die_resolve_conflict("Pull");
+
+	if (file_exists(git_path("MERGE_HEAD")))
+		die_conclude_merge();
+
 	if (!opt_ff.len)
 		config_get_ff(&opt_ff);
 
-- 
2.1.4
