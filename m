From: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Subject: [PATCH v4 2/2] rm: introduce advice.rmHints to shorten messages
Date: Tue, 11 Jun 2013 16:56:01 +0200
Message-ID: <1370962561-12519-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
References: <1370962561-12519-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 16:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPzb-0002QW-T8
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab3FKO4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:56:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38433 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab3FKO4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 10:56:08 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5BEu4uW022087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 16:56:04 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BEu5GD015930;
	Tue, 11 Jun 2013 16:56:05 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BEu5B5006401;
	Tue, 11 Jun 2013 16:56:05 +0200
Received: (from lienardm@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5BEu5pW006400;
	Tue, 11 Jun 2013 16:56:05 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370962561-12519-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Jun 2013 16:56:04 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227450>

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

Changes since v3:
 - removal of spaces after redirection <<
 - use of -\EOF to indent tests better

 Documentation/config.txt |    3 +++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin/rm.c             |    3 ++-
 t/t3600-rm.sh            |   29 +++++++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 1 deletions(-)

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
index e284db3..70df77c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -49,7 +49,8 @@ static void print_error_files(struct string_list *files_list,
 			strbuf_addf(&err_msg,
 				    "\n    %s",
 				    files_list->items[i].string);
-		strbuf_addstr(&err_msg, hints_msg);
+		if (advice_rm_hints)
+			strbuf_addstr(&err_msg, hints_msg);
 		*errs = error("%s", err_msg.buf);
 		strbuf_release(&err_msg);
 	}
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 902993b..5c87b55 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -707,6 +707,18 @@ test_expect_success 'rm files with different staged content' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'rm files with different staged content without hints' '
+	cat >expect <<-\EOF &&
+	error: the following files have staged content different from both the
+	file and the HEAD:
+	    bar.txt
+	    foo.txt
+	EOF
+	echo content2 >foo.txt &&
+	echo content2 >bar.txt &&
+	test_must_fail git -c advice.rmhints=false rm foo.txt bar.txt 2>actual &&
+	test_i18ncmp expect actual
+'
 
 test_expect_success 'rm file with local modification' '
 	cat >expect <<-\EOF &&
@@ -720,6 +732,15 @@ test_expect_success 'rm file with local modification' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'rm file with local modification without hints' '
+	cat >expect <<-\EOF &&
+	error: the following file has local modifications:
+	    bar.txt
+	EOF
+	echo content4 >bar.txt &&
+	test_must_fail git -c advice.rmhints=false rm bar.txt 2>actual &&
+	test_i18ncmp expect actual
+'
 
 test_expect_success 'rm file with changes in the index' '
 	cat >expect <<-\EOF &&
@@ -734,6 +755,14 @@ test_expect_success 'rm file with changes in the index' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'rm file with changes in the index without hints' '
+	cat >expect <<-\EOF &&
+	error: the following file has changes staged in the index:
+	    foo.txt
+	EOF
+	test_must_fail git -c advice.rmhints=false rm foo.txt 2>actual &&
+	test_i18ncmp expect actual
+'
 
 test_expect_success 'rm files with two different errors' '
 	cat >expect <<-\EOF &&
-- 
1.7.8
