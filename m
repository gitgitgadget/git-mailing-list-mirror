From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Fri, 30 Mar 2012 03:01:30 -0400
Message-ID: <20120330070130.GA30656@sigill.intra.peff.net>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
 <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
 <20120329222230.GB1413@sigill.intra.peff.net>
 <20120329222632.GC1413@sigill.intra.peff.net>
 <7vk422q2ho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Strecker-Kellogg <willsk@bnl.gov>,
	Git List <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 09:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDVqK-000369-99
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 09:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab2C3HBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 03:01:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40939
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060Ab2C3HBd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 03:01:33 -0400
Received: (qmail 11852 invoked by uid 107); 30 Mar 2012 07:01:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 03:01:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 03:01:30 -0400
Content-Disposition: inline
In-Reply-To: <7vk422q2ho.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194333>

On Thu, Mar 29, 2012 at 06:52:35PM -0700, Junio C Hamano wrote:

> It would regress for somebody who is running the CGI program while
> exporting these environment variables pointing at himself and relying on
> the fact that these are canceled by REMOTE_USER/ADDR (perhaps a web-based
> editor can write into some repository and commits made by that editor
> takes the ident information from COMMITTER variables, while another part
> of the webserver takes a push by spawning the http backend???).
> 
> Which is very unlikely.

Yeah, I agree that is not worth worrying too much about.

> But I think this is the right thing to do, even though it is not related
> to the issue William wanted to address with his patch.
> 
> Care to sign it off?

Updated patch is below. In addition to a commit message and signoff, I
tweaked two things:

  1. The original I posted failed to update the free() calls at the end
     of the function (and since we now have a variable number of env
     variables, we can't just free all elements). I ended up just
     converting this to use argv_array, which handles the memory
     management for us and is way shorter and easier to read.

  2. I added tests, both for the default behavior and for the new one.
     The "127.0.0.1" is hard-coded in the expected output (but comes
     from apache's setting of REMOTE_ADDR). I think this is OK. The
     lib-httpd setup code always listens on 127.0.0.1, so short of some
     insane loopback routing setup, the REMOTE_ADDR should also be
     127.0.0.1.

-- >8 --
Subject: http-backend: respect existing GIT_COMMITTER_* variables

The http-backend program sets default GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL variables based on the REMOTE_USER and
REMOTE_ADDR variables provided by the webserver. However, it
unconditionally overwrites any existing GIT_COMMITTER
variables, which may have been customized by site-specific
code in the webserver (or in a script wrapping http-backend).

Let's leave those variables intact if they already exist,
assuming that any such configuration was intentional. There
is a slight chance of a regression if somebody has set
GIT_COMMITTER_* for the entire webserver, not intending it
to leak through http-backend. We could protect against this
by passing the information in alternate variables.  However,
it seems unlikely that anyone will care about that
regression, and there is value in the simplicity of using
the common variable names that are used elsewhere in git.

While we're tweaking the environment-handling in
http-backend, let's switch it to use argv_array to handle
the list of variables. That makes the memory management much
simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-backend.c          |   22 +++++++++-------------
 t/lib-httpd/apache.conf |    7 +++++++
 t/t5541-http-push.sh    |   21 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 869d515..f50e77f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -7,6 +7,7 @@
 #include "run-command.h"
 #include "string-list.h"
 #include "url.h"
+#include "argv-array.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
@@ -317,8 +318,7 @@ static void run_service(const char **argv)
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
 	const char *user = getenv("REMOTE_USER");
 	const char *host = getenv("REMOTE_ADDR");
-	char *env[3];
-	struct strbuf buf = STRBUF_INIT;
+	struct argv_array env = ARGV_ARRAY_INIT;
 	int gzipped_request = 0;
 	struct child_process cld;
 
@@ -332,17 +332,15 @@ static void run_service(const char **argv)
 	if (!host || !*host)
 		host = "(none)";
 
-	memset(&env, 0, sizeof(env));
-	strbuf_addf(&buf, "GIT_COMMITTER_NAME=%s", user);
-	env[0] = strbuf_detach(&buf, NULL);
-
-	strbuf_addf(&buf, "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
-	env[1] = strbuf_detach(&buf, NULL);
-	env[2] = NULL;
+	if (!getenv("GIT_COMMITTER_NAME"))
+		argv_array_pushf(&env, "GIT_COMMITTER_NAME=%s", user);
+	if (!getenv("GIT_COMMITTER_EMAIL"))
+		argv_array_pushf(&env, "GIT_COMMITTER_EMAIL=%s@http.%s",
+				 user, host);
 
 	memset(&cld, 0, sizeof(cld));
 	cld.argv = argv;
-	cld.env = (const char *const *)env;
+	cld.env = env.argv;
 	if (gzipped_request)
 		cld.in = -1;
 	cld.git_cmd = 1;
@@ -357,9 +355,7 @@ static void run_service(const char **argv)
 
 	if (finish_command(&cld))
 		exit(1);
-	free(env[0]);
-	free(env[1]);
-	strbuf_release(&buf);
+	argv_array_clear(&env);
 }
 
 static int show_text_ref(const char *name, const unsigned char *sha1,
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 3c12b05..de3762e 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -52,8 +52,15 @@ Alias /auth/ www/auth/
 <Location /smart_noexport/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 </Location>
+<Location /smart_custom_env/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_COMMITTER_NAME "Custom User"
+	SetEnv GIT_COMMITTER_EMAIL custom@example.com
+</Location>
 ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
 ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
+ScriptAlias /smart_custom_env/ ${GIT_EXEC_PATH}/git-http-backend/
 <Directory ${GIT_EXEC_PATH}>
 	Options None
 </Directory>
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index cc6f081..d7964c7 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -30,6 +30,7 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git config http.receivepack true &&
+	git config core.logallrefupdates true &&
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
@@ -222,5 +223,25 @@ test_expect_success TTY 'quiet push' '
 	test_cmp /dev/null output
 '
 
+test_expect_success 'http push gives sane defaults to reflog' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit reflog-test &&
+	git push "$HTTPD_URL"/smart/test_repo.git &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
+		log -g -1 --format="%gn <%ge>" >actual &&
+	echo "anonymous <anonymous@http.127.0.0.1>" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'http push respects GIT_COMMITTER_* in reflog' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit custom-reflog-test &&
+	git push "$HTTPD_URL"/smart_custom_env/test_repo.git &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" \
+		log -g -1 --format="%gn <%ge>" >actual &&
+	echo "Custom User <custom@example.com>" >expect &&
+	test_cmp expect actual
+'
+
 stop_httpd
 test_done
-- 
1.7.9.5.7.g11b89
