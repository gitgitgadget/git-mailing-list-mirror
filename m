From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] archive: don't allow negation of --remote-request
Date: Tue, 15 Nov 2011 16:43:18 -0500
Message-ID: <20111115214317.GA20624@sigill.intra.peff.net>
References: <20111115214159.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 22:43:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQQms-0007lC-7w
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 22:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504Ab1KOVnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 16:43:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42813
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab1KOVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 16:43:20 -0500
Received: (qmail 10323 invoked by uid 107); 15 Nov 2011 21:43:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 16:43:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 16:43:18 -0500
Content-Disposition: inline
In-Reply-To: <20111115214159.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185490>

The remote-request flag is a security feature, telling the
spawned git-archive that certain formats should be turned
off. We always place it at the front of the command line
when serving a remote request. Of course, this doesn't do us
any good if the client can simply ask us politely to turn it
off.

This bug was introduced in c09cd77 (upload-archive: use
start_command instead of fork, 2011-10-24), but hasn't yet
been released.

Signed-off-by: Jeff King <peff@peff.net>
---
The other option would be recognizing and disallowing this when reading
arguments from the remote.

 builtin/archive.c   |    2 +-
 t/t5000-tar-tree.sh |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index e405566..fce20a1 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -97,7 +97,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 			"path to the remote git-upload-archive command"),
 		{ OPTION_BOOLEAN, 0, "remote-request", &is_remote, NULL,
 			"indicate we are serving a remote request",
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN | PARSE_OPT_NONEG },
 		OPT_END()
 	};
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 889842e..723b54e 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -305,6 +305,18 @@ test_expect_success 'only enabled filters are available remotely' '
 	test_cmp remote.bar config.bar
 '
 
+# We have to hand-craft this, since the local "git archive" will
+# eat our "--no-remote-request" argument otherwise.
+test_expect_success 'malicious clients cannot un-remote themselves' '
+	{
+		echo "0021argument --no-remote-request" &&
+		echo "001eargument --format=tar.foo" &&
+		echo "0012argument HEAD" &&
+		printf "0000"
+	} >evil-request &&
+	test_must_fail git upload-archive . <evil-request >remote.tar.foo
+'
+
 if $GZIP --version >/dev/null 2>&1; then
 	test_set_prereq GZIP
 else
-- 
1.7.7.3.8.g38efa
