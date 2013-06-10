From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 16:22:07 +0200
Message-ID: <1370874127-4326-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
References: <1370874127-4326-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 16:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um2zJ-00031O-43
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab3FJOWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 10:22:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59410 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab3FJOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:22:20 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEMG5l020993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:22:16 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AEMHpA015612;
	Mon, 10 Jun 2013 16:22:17 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5AEMHoV002860;
	Mon, 10 Jun 2013 16:22:17 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5AEMH5T002859;
	Mon, 10 Jun 2013 16:22:17 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370874127-4326-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 16:22:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227286>

Introduce advice.rmHints to choose whether to display advice or not
when git rm fails. Defaults to true, in order to preserve current behavior.

As an example, the message:
	error: 'foo.txt' has changes staged in the index
	(use --cached to keep the file, or -f to force removal)

would look like, with advice.rmHints=false:
	error: 'foo.txt' has changes staged in the index

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

Changes since v1:
 -corrected the commit message where "rmHints=true" was supposed to be "false"
 -better use of English tenses in the commit message

 Documentation/config.txt |    3 +++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin/rm.c             |   11 +++++++----
 t/t3600-rm.sh            |   29 +++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e53fc5..eb04479 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -199,6 +199,9 @@ advice.*::
 	amWorkDir::
 		Advice that shows the location of the patch file when
 		linkgit:git-am[1] fails to apply it.
+	rmHints::
+		In case of failure in the output of linkgit:git-rm[1],
+		show directions on how to proceed from the current state.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index a8deee6..a4c169c 100644
--- a/advice.c
+++ b/advice.c
@@ -14,6 +14,7 @@ int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
+int advice_rm_hints = 1;
 
 static struct {
 	const char *name;
@@ -33,6 +34,7 @@ static struct {
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
 	{ "setupstreamfailure", &advice_set_upstream_failure },
+	{ "rmhints", &advice_rm_hints },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 94caa32..36104c4 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
 extern int advice_set_upstream_failure;
+extern int advice_rm_hints;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/builtin/rm.c b/builtin/rm.c
index 76dfc5b..2226037 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -62,9 +62,11 @@ static int check_submodules_use_gitfiles(void)
 
 		if (!submodule_uses_gitfile(name))
 			errs = error(_("submodule '%s' (or one of its nested "
-				     "submodules) uses a .git directory\n"
-				     "(use 'rm -rf' if you really want to remove "
-				     "it including all of its history)"), name);
+				       "submodules) uses a .git directory%s"), name,
+				       advice_rm_hints
+				       ? "\n(use 'rm -rf' if you really want to remove "
+				       "it including all of its history)"
+				       : "");
 	}
 
 	return errs;
@@ -85,7 +87,8 @@ static int print_error_files(struct string_list *files_list,
 		strbuf_addf(&err_msg,
 			    "\n    %s",
 			    files_list->items[i].string);
-	strbuf_addstr(&err_msg, hints_msg);
+	if (advice_rm_hints)
+		strbuf_addstr(&err_msg, hints_msg);
 	errs = error("%s", err_msg.buf);
 
 	return errs;
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 08bc9bb..92f6146 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -707,6 +707,18 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'rm files with different staged content without hints' '
+	cat >expect << EOF &&
+error: the following files have staged content different from both the
+file and the HEAD:
+    bar.txt
+    foo.txt
+EOF
+	echo content2 >foo.txt &&
+	echo content2 >bar.txt &&
+	test_must_fail git -c advice.rmhints=false rm foo.txt bar.txt 2>actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'rm file with local modification' '
 	cat >expect << EOF &&
@@ -720,6 +732,15 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'rm file with local modification without hints' '
+	cat >expect << EOF &&
+error: the following files have local modifications:
+    bar.txt
+EOF
+	echo content4 >bar.txt &&
+	test_must_fail git -c advice.rmhints=false rm bar.txt 2>actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'rm file with changes in the index' '
     cat >expect << EOF &&
@@ -734,5 +755,13 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'rm file with changes in the index without hints' '
+	cat >expect << EOF &&
+error: the following files have changes staged in the index:
+    foo.txt
+EOF
+	test_must_fail git -c advice.rmhints=false rm foo.txt 2>actual &&
+	test_cmp expect actual
+'
 
 test_done
-- 
1.7.8
