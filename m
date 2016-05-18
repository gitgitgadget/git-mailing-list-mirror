From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 03/21] i18n: advice: internationalize message for conflicts
Date: Wed, 18 May 2016 15:27:36 +0000
Message-ID: <1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:29:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33Pp-0000ma-B2
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbcERP3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:29:36 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:41187 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932098AbcERP3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:29:35 -0400
Received: (qmail 7947 invoked from network); 18 May 2016 15:29:27 -0000
Received: (qmail 13810 invoked from network); 18 May 2016 15:29:27 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:29:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294948>

Mark message for translation telling the user she has conflicts to
resolve. Expose each particular use case, in order to enable translating
entire sentences which would facilitate translating into other
languages.

Change "Pull" to lowercase to match other messages.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 advice.c        | 17 +++++++++++++++--
 builtin/pull.c  |  2 +-
 t/t5520-pull.sh |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 703a847..bc531fc 100644
--- a/advice.c
+++ b/advice.c
@@ -79,7 +79,20 @@ int git_default_advice_config(const char *var, const char *value)
 
 int error_resolve_conflict(const char *me)
 {
-	error("%s is not possible because you have unmerged files.", me);
+	if (!strcmp(me, "cherry-pick"))
+		error(_("cherry-pick is not possible because you have unmerged files."));
+	else if (!strcmp(me, "commit"))
+		error(_("commit is not possible because you have unmerged files."));
+	else if (!strcmp(me, "merge"))
+		error(_("merge is not possible because you have unmerged files."));
+	else if (!strcmp(me, "pull"))
+		error(_("pull is not possible because you have unmerged files."));
+	else if (!strcmp(me, "revert"))
+		error(_("revert is not possible because you have unmerged files."));
+	else
+		error(_("%s is not possible because you have unmerged files."),
+			me);
+
 	if (advice_resolve_conflict)
 		/*
 		 * Message used both when 'git commit' fails and when
@@ -93,7 +106,7 @@ int error_resolve_conflict(const char *me)
 void NORETURN die_resolve_conflict(const char *me)
 {
 	error_resolve_conflict(me);
-	die("Exiting because of an unresolved conflict.");
+	die(_("Exiting because of an unresolved conflict."));
 }
 
 void NORETURN die_conclude_merge(void)
diff --git a/builtin/pull.c b/builtin/pull.c
index 1d7333c..a980dcf 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -852,7 +852,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	git_config(git_pull_config, NULL);
 
 	if (read_cache_unmerged())
-		die_resolve_conflict("Pull");
+		die_resolve_conflict("pull");
 
 	if (file_exists(git_path("MERGE_HEAD")))
 		die_conclude_merge();
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 739c089..61beff6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -211,7 +211,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test -n "$(git ls-files -u)" &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "Pull is not possible because you have unmerged files" err &&
+	test_i18ngrep "pull is not possible because you have unmerged files" err &&
 	test_cmp expected file &&
 	git add file &&
 	test -z "$(git ls-files -u)" &&
-- 
2.7.3
