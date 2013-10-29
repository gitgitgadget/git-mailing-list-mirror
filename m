From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t: provide a perl() function which uses $PERL_PATH
Date: Mon, 28 Oct 2013 21:22:07 -0400
Message-ID: <20131029012207.GB27738@sigill.intra.peff.net>
References: <20131029011859.GA22140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vay0f-0005ic-98
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843Ab3J2BWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 21:22:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:57401 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757763Ab3J2BWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:22:10 -0400
Received: (qmail 28936 invoked by uid 102); 29 Oct 2013 01:22:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:22:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:22:07 -0400
Content-Disposition: inline
In-Reply-To: <20131029011859.GA22140@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236881>

Once upon a time, we assumed that calling a bare "perl" in
the test scripts was OK, because we would find the perl from
the user's PATH, and we were only asking that perl to do
basic operations that work even on old versions of perl.

Later, we found that some systems really prefer to use
$PERL_PATH even for these basic cases, because the system
perl misbehaves in some way (e.g., by handling line endings
differently). We then switched "perl" invocations to
"$PERL_PATH" to respect the user's choice.

Having to use "$PERL_PATH" is ugly and cumbersome, though.
Instead, let's provide a perl() shell function that tests
can use, which will transparently do the right thing.

Unfortunately, test writers still have to use $PERL_PATH in
certain situations, so we still need to keep the advice in
the README.

Note that this may fix test failures in t5004, t5503, t6002,
t6003, t6300, t8001, and t8002, depending on your system's
perl setup. All of these can be detected by running:

  ln -s /bin/false bin-wrappers/perl
  make test

which fails before this patch, and passes after.

Signed-off-by: Jeff King <peff@peff.net>
---
We could always "pollute" bin-wrappers with a broken perl to catch
errors like these, but I think that would also pollute people who put
bin-wrappers into their $PATH. I think we'd need a separate
"test-wrappers" directory, and then put both it and bin-wrappers into
the PATH. I don't know if that is worth it or not.

 t/README                | 12 ++++++++----
 t/test-lib-functions.sh |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 2167125..06bc5ed 100644
--- a/t/README
+++ b/t/README
@@ -340,7 +340,11 @@ Don't:
  - use perl without spelling it as "$PERL_PATH". This is to help our
    friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that
-   does not do so, whose path is specified with $PERL_PATH.
+   does not do so, whose path is specified with $PERL_PATH. Note that we
+   provide a "perl" function which uses $PERL_PATH under the hood, so
+   you do not need to worry when simply running perl in the test scripts
+   (but you do, for example, on a shebang line or in a sub script
+   created via "write_script").
 
  - use sh without spelling it as "$SHELL_PATH", when the script can
    be misinterpreted by broken platform shell (e.g. Solaris).
@@ -387,7 +391,7 @@ of the test_* functions (see the "Test harness library" section
 below), e.g.:
 
     test_expect_success PERL 'I need Perl' '
-        "$PERL_PATH" -e "hlagh() if unf_unf()"
+        perl -e "hlagh() if unf_unf()"
     '
 
 The advantage of skipping tests like this is that platforms that don't
@@ -520,7 +524,7 @@ library for your script to use.
 
 	test_external \
 	    'GitwebCache::*FileCache*' \
-	    "$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
+	    perl "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
 
    If the test is outputting its own TAP you should set the
    test_external_has_tap variable somewhere before calling the first
@@ -536,7 +540,7 @@ library for your script to use.
 
 	test_external_without_stderr \
 	    'Perl API' \
-	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+	    perl "$TEST_DIRECTORY"/t9700/test.pl
 
  - test_expect_code <exit-code> <command>
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a7e9aac..53af452 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -710,3 +710,7 @@ test_ln_s_add () {
 		git update-index --add --cacheinfo 120000 $ln_s_obj "$2"
 	fi
 }
+
+perl () {
+	command "$PERL_PATH" "$@"
+}
-- 
1.8.4.1.898.g8bf8a41.dirty
