From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] test-lib: allow negation of prerequisites
Date: Wed, 28 Nov 2012 13:25:59 -0500
Message-ID: <20121128182559.GA17122@sigill.intra.peff.net>
References: <20121128182534.GA21020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdmKv-0002FL-Of
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab2K1S0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:26:02 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33884 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755779Ab2K1S0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:26:01 -0500
Received: (qmail 9794 invoked by uid 107); 28 Nov 2012 18:26:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Nov 2012 13:26:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2012 13:25:59 -0500
Content-Disposition: inline
In-Reply-To: <20121128182534.GA21020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210750>

You can set and test a prerequisite like this:

  test_set_prereq FOO
  test_have_prereq FOO && echo yes

You can negate the test in the shell like this:

  ! test_have_prereq && echo no

However, when you are using the automatic prerequisite
checking in test_expect_*, there is no opportunity to use
the shell negation.  This patch introduces the syntax "!FOO"
to indicate that the test should only run if a prerequisite
is not meant.

One alternative is to set an explicit negative prerequisite,
like:

  if system_has_foo; then
	  test_set_prereq FOO
  else
	  test_set_prereq NO_FOO
  fi

However, this doesn't work for lazy prerequisites, which
associate a single test with a single name. We could teach
the lazy prereq evaluator to set both forms, but the code
change ends up quite similar to this one (because we still
need to convert NO_FOO into FOO to find the correct lazy
script).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0000-basic.sh        | 32 ++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh | 21 ++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 08677df..562cf41 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -115,6 +115,38 @@ then
 	exit 1
 fi
 
+test_lazy_prereq LAZY_TRUE true
+havetrue=no
+test_expect_success LAZY_TRUE 'test runs if lazy prereq is satisfied' '
+	havetrue=yes
+'
+donthavetrue=yes
+test_expect_success !LAZY_TRUE 'missing lazy prereqs skip tests' '
+	donthavetrue=no
+'
+
+if test "$havetrue$donthavetrue" != yesyes
+then
+	say 'bug in test framework: lazy prerequisites do not work'
+	exit 1
+fi
+
+test_lazy_prereq LAZY_FALSE false
+nothavefalse=no
+test_expect_success !LAZY_FALSE 'negative lazy prereqs checked' '
+	nothavefalse=yes
+'
+havefalse=yes
+test_expect_success LAZY_FALSE 'missing negative lazy prereqs will skip' '
+	havefalse=no
+'
+
+if test "$nothavefalse$havefalse" != yesyes
+then
+	say 'bug in test framework: negative lazy prerequisites do not work'
+	exit 1
+fi
+
 clean=no
 test_expect_success 'tests clean up after themselves' '
 	test_when_finished clean=yes
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8889ba5..22a4f8f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -275,6 +275,15 @@ test_have_prereq () {
 
 	for prerequisite
 	do
+		case "$prerequisite" in
+		!*)
+			negative_prereq=t
+			prerequisite=${prerequisite#!}
+			;;
+		*)
+			negative_prereq=
+		esac
+
 		case " $lazily_tested_prereq " in
 		*" $prerequisite "*)
 			;;
@@ -294,10 +303,20 @@ test_have_prereq () {
 		total_prereq=$(($total_prereq + 1))
 		case "$satisfied_prereq" in
 		*" $prerequisite "*)
+			satisfied_this_prereq=t
+			;;
+		*)
+			satisfied_this_prereq=
+		esac
+
+		case "$satisfied_this_prereq,$negative_prereq" in
+		t,|,t)
 			ok_prereq=$(($ok_prereq + 1))
 			;;
 		*)
-			# Keep a list of missing prerequisites
+			# Keep a list of missing prerequisites; restore
+			# the negative marker if necessary.
+			prerequisite=${negative_prereq:+!}$prerequisite
 			if test -z "$missing_prereq"
 			then
 				missing_prereq=$prerequisite
-- 
1.8.0.207.gdf2154c
