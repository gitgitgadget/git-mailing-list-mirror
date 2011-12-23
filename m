From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Fri, 23 Dec 2011 07:42:27 +0100
Message-ID: <4EF422D3.2050802@viscovery.net>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org> <4EF2D436.3080303@viscovery.net> <7vaa6ldpk6.fsf@alter.siamese.dyndns.org> <4EF2E824.7020509@viscovery.net> <7v39cceay0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 07:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdypz-0001Yp-Hp
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 07:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab1LWGmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 01:42:35 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5241 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320Ab1LWGmd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 01:42:33 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Rdypo-0006Vz-1k; Fri, 23 Dec 2011 07:42:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9DCCA1660F;
	Fri, 23 Dec 2011 07:42:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7v39cceay0.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187621>

Am 12/22/2011 19:08, schrieb Junio C Hamano:
> I _think_ I liked the simplicity of having the logic to
> 
>  - format localized message to a multi-line buffer; and
>  - split the contents of that buffer into lines and add prefix in an
>    i18n friendly way
> 
> in vreportf(), but there are many problems in this approach, it seems.  We
> may need to limit the message length for error()/die() codepath, but we do
> not want to be limited in others, definitely not from advise().
> 
> Also some calls to error() are meant to produce plumbing error message and
> should never be localized. The approach to localize the prefix in vreportf()
> will not work for this reason.

IMO the solution to not translate plumbing messages is to omit the
initialization of the gettext machinery.

Anyway, here is a patch that modifies vreportf() in an i18n friendly way
(I think). It is not necessarily meant for inclusion. Notably, the
changes to the test suite indicate one problem in a class of error()
messages: A list of file names is produced that are indented by a tab.
But with the "error: " prefix, the visible indentation shrinks to two
spaces (the minimum possible). We may want to do something about it.

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Put a prefix on all lines of multi-line hint, warning,
 error messages

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 advice.c                             |    2 +-
 git-compat-util.h                    |    2 +-
 http-backend.c                       |    2 +-
 run-command.c                        |    2 +-
 t/t1011-read-tree-sparse-checkout.sh |    6 ++--
 t/t1506-rev-parse-diagnosis.sh       |    2 +-
 t/t7607-merge-overwrite.sh           |    6 ++--
 t/t7609-merge-co-error-msgs.sh       |   40 +++++++++++++++++-----------------
 usage.c                              |   19 +++++++++++-----
 9 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/advice.c b/advice.c
index e02e632..38b55b6 100644
--- a/advice.c
+++ b/advice.c
@@ -24,7 +24,7 @@ void advise(const char *advice, ...)
 	va_list params;
 
 	va_start(params, advice);
-	vreportf("hint: ", advice, params);
+	vreportf("hint: %s\n", advice, params);
 	va_end(params);
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 8f3972c..26b7d19 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -239,7 +239,7 @@ extern char *gitbasename(char *);
 #include "compat/bswap.h"
 
 /* General helper functions */
-extern void vreportf(const char *prefix, const char *err, va_list params);
+extern void vreportf(const char *line_fmt, const char *err, va_list params);
 extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/http-backend.c b/http-backend.c
index 869d515..fb91742 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -490,7 +490,7 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 		hdr_nocache();
 		end_headers();
 
-		vreportf("fatal: ", err, params);
+		vreportf("fatal: %s\n", err, params);
 	}
 	exit(0); /* we successfully reported a failure ;-) */
 }
diff --git a/run-command.c b/run-command.c
index 1c51043..664c215 100644
--- a/run-command.c
+++ b/run-command.c
@@ -466,7 +466,7 @@ static void *run_thread(void *data)
 
 static NORETURN void die_async(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf("fatal: %s\n", err, params);
 
 	if (!pthread_equal(main_thread, pthread_self())) {
 		struct async *async = pthread_getspecific(async_key);
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 5c0053a..22b6a20 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -242,9 +242,9 @@ test_expect_success 'print errors when failed to update worktree' '
 	test_must_fail git checkout top 2>actual &&
 	cat >expected <<\EOF &&
 error: The following untracked working tree files would be overwritten by checkout:
-	sub/added
-	sub/addedtoo
-Please move or remove them before you can switch branches.
+error: 	sub/added
+error: 	sub/addedtoo
+error: Please move or remove them before you can switch branches.
 Aborting
 EOF
 	test_cmp expected actual
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 0843a1c..292f2fb 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -11,7 +11,7 @@ test_did_you_mean ()
 	sq="'" &&
 	cat >expected <<-EOF &&
 	fatal: Path '$2$3' $4, but not ${5:-$sq$3$sq}.
-	Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
+	fatal: Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
 	EOF
 	test_cmp expected error
 }
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index aa74184..7d6498d 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -104,9 +104,9 @@ test_expect_success 'will not overwrite untracked subtree' '
 
 cat >expect <<\EOF
 error: The following untracked working tree files would be overwritten by merge:
-	sub
-	sub2
-Please move or remove them before you can merge.
+error: 	sub
+error: 	sub2
+error: Please move or remove them before you can merge.
 Aborting
 EOF
 
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index 0e4a682..653eb7e 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -27,11 +27,11 @@ test_expect_success 'setup' '
 
 cat >expect <<\EOF
 error: The following untracked working tree files would be overwritten by merge:
-	five
-	four
-	three
-	two
-Please move or remove them before you can merge.
+error: 	five
+error: 	four
+error: 	three
+error: 	two
+error: Please move or remove them before you can merge.
 Aborting
 EOF
 
@@ -50,13 +50,13 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by merge:
-	four
-	three
-	two
-Please, commit your changes or stash them before you can merge.
+error: 	four
+error: 	three
+error: 	two
+error: Please, commit your changes or stash them before you can merge.
 error: The following untracked working tree files would be overwritten by merge:
-	five
-Please move or remove them before you can merge.
+error: 	five
+error: Please move or remove them before you can merge.
 Aborting
 EOF
 
@@ -70,9 +70,9 @@ test_expect_success 'untracked files or local changes ovewritten by merge' '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
-	rep/one
-	rep/two
-Please, commit your changes or stash them before you can switch branches.
+error: 	rep/one
+error: 	rep/two
+error: Please, commit your changes or stash them before you can switch branches.
 Aborting
 EOF
 
@@ -92,9 +92,9 @@ test_expect_success 'cannot switch branches because of local changes' '
 
 cat >expect <<\EOF
 error: Your local changes to the following files would be overwritten by checkout:
-	rep/one
-	rep/two
-Please, commit your changes or stash them before you can switch branches.
+error: 	rep/one
+error: 	rep/two
+error: Please, commit your changes or stash them before you can switch branches.
 Aborting
 EOF
 
@@ -106,9 +106,9 @@ test_expect_success 'not uptodate file porcelain checkout error' '
 
 cat >expect <<\EOF
 error: Updating the following directories would lose untracked files in it:
-	rep
-	rep2
-
+error: 	rep
+error: 	rep2
+error: 
 Aborting
 EOF
 
diff --git a/usage.c b/usage.c
index a2a6678..1b55afd 100644
--- a/usage.c
+++ b/usage.c
@@ -6,11 +6,18 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-void vreportf(const char *prefix, const char *err, va_list params)
+void vreportf(const char *line_fmt, const char *err, va_list params)
 {
 	char msg[4096];
+	char *line, *end;
+
 	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
+
+	for (line = msg; (end = strchr(line, '\n')); line = end) {
+		*end++ = 0;
+		fprintf(stderr, line_fmt, line);
+	}
+	fprintf(stderr, line_fmt, line);
 }
 
 void vwritef(int fd, const char *prefix, const char *err, va_list params)
@@ -27,24 +34,24 @@ void vwritef(int fd, const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf("usage: %s\n", err, params);
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf("fatal: %s\n", err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
-	vreportf("error: ", err, params);
+	vreportf("error: %s\n", err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	vreportf("warning: ", warn, params);
+	vreportf("warning: %s\n", warn, params);
 }
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
-- 
1.7.8.rc0.126.gd15506
