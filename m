From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] transport-helper: report errors properly
Date: Wed, 10 Apr 2013 17:15:52 -0400
Message-ID: <20130410211552.GA3256@sigill.intra.peff.net>
References: <20130410211311.GA24277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 23:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2NA-0005w2-0B
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab3DJVP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:15:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39226 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab3DJVP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:15:58 -0400
Received: (qmail 7519 invoked by uid 107); 10 Apr 2013 21:17:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:17:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:15:52 -0400
Content-Disposition: inline
In-Reply-To: <20130410211311.GA24277@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220766>

From: Felipe Contreras <felipe.contreras@gmail.com>

If a push fails because the remote-helper died (with
fast-export), the user does not see any error message. We do
correctly die with a failed exit code, as we notice that the
helper has died while reading back the ref status from the
helper. However, we don't print any message.  This is OK if
the helper itself printed a useful error message, but we
cannot count on that; let's let the user know that the
helper failed.

In the long run, it may make more sense to propagate the
error back up to push, so that it can present the usual
status table and give a nicer message. But this is a much
simpler fix that can help immediately.

While we're adding tests, let's also confirm that the
remote-helper dying is also detect when importing refs. We
currently do so robustly when the helper uses the "done"
feature (and that is what we test).  We cannot do so
reliably when the helper does not use the "done" feature,
but it is not even worth testing; the right solution is for
the helper to start using "done".

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Felipe,

Can you acknowledge that it's OK to stick your name on this, as it's not
exactly what you submitted before?

 git-remote-testgit        | 19 +++++++++++++++++++
 t/t5801-remote-helpers.sh | 20 ++++++++++++++++++++
 transport-helper.c        |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index b395c8d..5fd09f9 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -61,12 +61,31 @@ do
 			echo "feature import-marks=$gitmarks"
 			echo "feature export-marks=$gitmarks"
 		fi
+
+		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
+		then
+			echo "feature done"
+			exit 1
+		fi
+
 		echo "feature done"
 		git fast-export "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		echo "done"
 		;;
 	export)
+		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
+		then
+			# consume input so fast-export doesn't get SIGPIPE;
+			# git would also notice that case, but we want
+			# to make sure we are exercising the later
+			# error checks
+			while read line; do
+				test "done" = "$line" && break
+			done
+			exit 1
+		fi
+
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..aafc46a 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -166,4 +166,24 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success 'proper failure checks for fetching' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git fetch 2> error &&
+	cat error &&
+	grep -q "Error while running fast-import" error
+	)
+'
+
+test_expect_success 'proper failure checks for pushing' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git push --all 2> error &&
+	cat error &&
+	grep -q "Reading from remote helper failed" error
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index cb3ef7d..96081cc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		exit(128);
+		die("Reading from remote helper failed");
 	}
 
 	if (debug)
-- 
1.8.2.rc0.33.gd915649
