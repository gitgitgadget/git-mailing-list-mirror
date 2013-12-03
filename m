From: Jeff King <peff@peff.net>
Subject: [PATCH] t5000: simplify gzip prerequisite checks
Date: Tue, 3 Dec 2013 08:21:40 -0500
Message-ID: <20131203132140.GA31722@sigill.intra.peff.net>
References: <20131203131812.GC26667@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Hesse <mail@eworm.de>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 14:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnpv9-00034T-2t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 14:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab3LCNVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 08:21:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:49641 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753139Ab3LCNVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 08:21:42 -0500
Received: (qmail 25271 invoked by uid 102); 3 Dec 2013 13:21:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Dec 2013 07:21:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Dec 2013 08:21:40 -0500
Content-Disposition: inline
In-Reply-To: <20131203131812.GC26667@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238691>

In t5000, we test the built-in ".tar.gz" config for
git-archive. To make our tests portable, we check that we
have a way to both gzip and gunzip, and we respected
environment variables to point to alternate commands for
doing these operations.

However, the $GZIP variable did not actually do anything, as
changing it would not affect the baked-in value in
archive-tar.c. Moreover, setting the variable $GZIP
influences gzip itself. From the gzip man page:

  The environment variable GZIP can hold a set of default
  options for gzip. These options are interpreted first and
  can be overwritten by explicit command line parameters.

We could rename this variable, and use it to set up custom
config (or even have a Makefile knob to affect the built
binary), but it is not worth the trouble; nobody has ever
reported a problem with the baked-in default, and they can
always change it via config if they need to. Let's just drop
the variable and use "gzip" in the test (keeping the
prerequisite, of course).

While we're at it, we can drop the GUNZIP variable and
prerequisite; it uses "gzip -d", so if we have GZIP, we
will have both.

We can also use test_lazy_prereq for the gzip prerequisite,
which is simpler and behaves more consistently with the rest
of git (e.g., by making output available when the test is
run with "-v").

Noticed-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5000-tar-tree.sh | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c2023b1..519cc34 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,8 +25,6 @@ commit id embedding:
 '
 
 . ./test-lib.sh
-GZIP=${GZIP:-gzip}
-GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
 
@@ -39,6 +37,8 @@ test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
 	)
 '
 
+test_lazy_prereq GZIP 'gzip --version'
+
 get_pax_header() {
 	file=$1
 	header=$2=
@@ -275,12 +275,6 @@ test_expect_success 'only enabled filters are available remotely' '
 	test_cmp remote.bar config.bar
 '
 
-if $GZIP --version >/dev/null 2>&1; then
-	test_set_prereq GZIP
-else
-	say "Skipping some tar.gz tests because gzip not found"
-fi
-
 test_expect_success GZIP 'git archive --format=tgz' '
 	git archive --format=tgz HEAD >j.tgz
 '
@@ -300,14 +294,8 @@ test_expect_success GZIP 'infer tgz from .tar.gz filename' '
 	test_cmp j.tgz j3.tar.gz
 '
 
-if $GUNZIP --version >/dev/null 2>&1; then
-	test_set_prereq GUNZIP
-else
-	say "Skipping some tar.gz tests because gunzip was not found"
-fi
-
-test_expect_success GZIP,GUNZIP 'extract tgz file' '
-	$GUNZIP -c <j.tgz >j.tar &&
+test_expect_success GZIP 'extract tgz file' '
+	gzip -d -c <j.tgz >j.tar &&
 	test_cmp b.tar j.tar
 '
 
-- 
1.8.5.rc3.493.g965953d
