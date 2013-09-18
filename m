From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] clone: send diagnostic messages to stderr
Date: Wed, 18 Sep 2013 16:05:13 -0400
Message-ID: <20130918200513.GA731@sigill.intra.peff.net>
References: <20130918200152.GA17074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 22:05:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMO06-0004V7-A0
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 22:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab3IRUFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 16:05:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:56946 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab3IRUFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 16:05:22 -0400
Received: (qmail 25334 invoked by uid 102); 18 Sep 2013 20:05:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 15:05:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 16:05:13 -0400
Content-Disposition: inline
In-Reply-To: <20130918200152.GA17074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234990>

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

This should not regress any scripts that try to parse the
current output, as the output is already internationalized
and therefore unstable.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c          | 10 +++++-----
 t/t5601-clone.sh         |  2 +-
 t/t5702-clone-options.sh |  9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ca3eb68..8723a3a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -379,7 +379,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 	}
 
 	if (0 <= option_verbosity)
-		printf(_("done.\n"));
+		fprintf(stderr, _("done.\n"));
 }
 
 static const char *junk_work_tree;
@@ -551,12 +551,12 @@ static void update_remote_refs(const struct ref *refs,
 
 	if (check_connectivity) {
 		if (0 <= option_verbosity)
-			printf(_("Checking connectivity... "));
+			fprintf(stderr, _("Checking connectivity... "));
 		if (check_everything_connected_with_transport(iterate_ref_map,
 							      0, &rm, transport))
 			die(_("remote did not send all necessary objects"));
 		if (0 <= option_verbosity)
-			printf(_("done\n"));
+			fprintf(stderr, _("done\n"));
 	}
 
 	if (refs) {
@@ -849,9 +849,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
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
index 0629149..b3b11e6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -36,7 +36,7 @@ test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 
 test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	rm -fr dst &&
-	git clone -n "file://$(pwd)/src" dst >output &&
+	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) = 1
 '
 
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 85cadfa..d3dbdfe 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -19,17 +19,18 @@ test_expect_success 'redirected clone -v' '
 
 '
 
-test_expect_success 'redirected clone' '
+test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-	test_must_be_empty err
+	! grep % err
 
 '
-test_expect_success 'redirected clone -v' '
+
+test_expect_success 'redirected clone -v does show progress' '
 
 	git clone --progress "file://$(pwd)/parent" clone-redirected-progress \
 		>out 2>err &&
-	test -s err
+	grep % err
 
 '
 
-- 
1.8.4.rc4.16.g228394f
