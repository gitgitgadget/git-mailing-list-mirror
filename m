From: Jeff King <peff@peff.net>
Subject: [PATCH 4/3] clone: send diagnostic messages to stderr
Date: Sat, 26 May 2012 00:11:35 -0400
Message-ID: <20120526041135.GA28957@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Haack <phil@github.com>,
	Emeric Fermas <emeric.fermas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 06:11:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY8Lu-0005pz-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 06:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab2EZELi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 00:11:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56362
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868Ab2EZELh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 00:11:37 -0400
Received: (qmail 16583 invoked by uid 107); 26 May 2012 04:12:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 May 2012 00:12:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2012 00:11:35 -0400
Content-Disposition: inline
In-Reply-To: <20120526034226.GA14287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198540>

Putting messages like "Cloning into.." and "done" on stdout
is un-Unix and uselessly clutters the stdout channel. Send
them to stderr.

We have to tweak two tests to accommodate this:

  1. t5601 checks for doubled output due to forking, and
     doesn't actually care where the output goes; adjust it
     to check stderr.

  2. t5702 is trying to test whether progress output was
     sent to stderr, but naively does so by checking
     whether stderr produced any output. Instead, have it
     look for "%", a token found in progress output but not
     elsewhere (and which lets us avoid hard-coding the
     progress text in the test).

Signed-off-by: Jeff King <peff@peff.net>
---
This one isn't really related to the other patches in the series, but
while we're on the subject of extremely minor git-clone annoyances, I
thought I'd throw it in as a bonus round.

Arguably the test in t5601 should just go away entirely. stderr tends to
be line-buffered anyway, so the thing it is testing for wouldn't happen.
Not to mention that according to 2c3766f, which introduced it, the
problem was due to start_async() not flushing output before forking.
But we long ago switched start_async to use pthreads, so the bug it is
testing for wouldn't even be detectable on any modern platform.

 builtin/clone.c          | 6 +++---
 t/t5601-clone.sh         | 2 +-
 t/t5702-clone-options.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d004abb..08470ed 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -371,7 +371,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 	}
 
 	if (0 <= option_verbosity)
-		printf(_("done.\n"));
+		fprintf(stderr, _("done.\n"));
 }
 
 static const char *junk_work_tree;
@@ -751,9 +751,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (0 <= option_verbosity) {
 		if (option_bare)
-			printf(_("Cloning into bare repository '%s'...\n"), dir);
+			fprintf(stderr, _("Cloning into bare repository '%s'...\n"), dir);
 		else
-			printf(_("Cloning into '%s'...\n"), dir);
+			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 67869b4..aa9f991 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -36,7 +36,7 @@ test_expect_success 'clone with excess parameters (2)' '
 
 test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	rm -fr dst &&
-	git clone -n "file://$(pwd)/src" dst >output &&
+	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) = 1
 '
 
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 02cb024..67e170e 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -22,14 +22,14 @@ test_expect_success 'clone -o' '
 test_expect_success 'redirected clone' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-	test ! -s err
+	! grep % err
 
 '
 test_expect_success 'redirected clone -v' '
 
 	git clone --progress "file://$(pwd)/parent" clone-redirected-progress \
 		>out 2>err &&
-	test -s err
+	grep % err
 
 '
 
-- 
1.7.10.1.21.g62fda49.dirty
