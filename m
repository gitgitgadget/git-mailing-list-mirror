Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B561FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbcFQUYB (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:01 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60072 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932065AbcFQUYB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:01 -0400
Received: (qmail 21439 invoked from network); 17 Jun 2016 20:23:58 -0000
Received: (qmail 32553 invoked from network); 17 Jun 2016 20:23:58 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:23:53 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 03/38] i18n: advice: internationalize message for conflicts
Date:	Fri, 17 Jun 2016 20:20:52 +0000
Message-Id: <1466194887-18236-4-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark message for translation telling the user she has conflicts to
resolve. Expose each particular use case, in order to enable translating
entire sentences which would facilitate translating into other
languages.

Change "Pull" to lowercase to match other instances. Update test
t5520-pull.sh, that relied on the old error message, to use the new one.

Although we loose in source code conciseness, we would gain better
translations because translators can 1) translate the entire sentence,
including those terms concerning Git (committing, merging, etc) 2) have
leeway to adapt to their languages.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 advice.c        | 17 +++++++++++++++--
 builtin/pull.c  |  2 +-
 t/t5520-pull.sh |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index cb445a7..b84ae49 100644
--- a/advice.c
+++ b/advice.c
@@ -79,7 +79,20 @@ int git_default_advice_config(const char *var, const char *value)
 
 int error_resolve_conflict(const char *me)
 {
-	error("%s is not possible because you have unmerged files.", me);
+	if (!strcmp(me, "cherry-pick"))
+		error(_("Cherry-picking is not possible because you have unmerged files."));
+	else if (!strcmp(me, "commit"))
+		error(_("Committing is not possible because you have unmerged files."));
+	else if (!strcmp(me, "merge"))
+		error(_("Merging is not possible because you have unmerged files."));
+	else if (!strcmp(me, "pull"))
+		error(_("Pulling is not possible because you have unmerged files."));
+	else if (!strcmp(me, "revert"))
+		error(_("Reverting is not possible because you have unmerged files."));
+	else
+		error(_("It is not possible to %s because you have unmerged files."),
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
index 739c089..45e44ca 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -211,7 +211,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test -n "$(git ls-files -u)" &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "Pull is not possible because you have unmerged files" err &&
+	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
 	test_cmp expected file &&
 	git add file &&
 	test -z "$(git ls-files -u)" &&
-- 
2.6.6

