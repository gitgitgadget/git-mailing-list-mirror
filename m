From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/8] t7502: factor out autoident prerequisite
Date: Wed, 14 Nov 2012 16:33:40 -0800
Message-ID: <20121115003340.GB17819@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 01:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnP4-0002gv-8m
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423179Ab2KOAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:33:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497Ab2KOAdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:33:43 -0500
Received: (qmail 9033 invoked by uid 107); 15 Nov 2012 00:34:32 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 19:34:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 16:33:40 -0800
Content-Disposition: inline
In-Reply-To: <20121115003029.GA17550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209768>

t7502 checks the behavior of commit when we can and cannot
determine a valid committer ident. Let's move that into
test-lib as a lazy prerequisite so other scripts can use it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7502-commit.sh | 12 +-----------
 t/test-lib.sh     |  6 ++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index deb187e..1a5cb69 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -243,16 +243,6 @@ test_expect_success 'message shows author when it is not equal to committer' '
 	  .git/COMMIT_EDITMSG
 '
 
-test_expect_success 'setup auto-ident prerequisite' '
-	if (sane_unset GIT_COMMITTER_EMAIL &&
-	    sane_unset GIT_COMMITTER_NAME &&
-	    git var GIT_COMMITTER_IDENT); then
-		test_set_prereq AUTOIDENT
-	else
-		test_set_prereq NOAUTOIDENT
-	fi
-'
-
 test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 
 	echo >>negative &&
@@ -271,7 +261,7 @@ echo editor started > "$(pwd)/.git/result"
 exit 0
 EOF
 
-test_expect_success NOAUTOIDENT 'do not fire editor when committer is bogus' '
+test_expect_success !AUTOIDENT 'do not fire editor when committer is bogus' '
 	>.git/result
 	>expect &&
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 489bc80..0334a9e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -738,6 +738,12 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
 	esac
 '
 
+test_lazy_prereq AUTOIDENT '
+	sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	git var GIT_AUTHOR_IDENT
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
1.8.0.207.gdf2154c
