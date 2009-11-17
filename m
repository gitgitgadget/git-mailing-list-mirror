From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] Make sure $PERL_PATH is defined when the test suite is run.
Date: Tue, 17 Nov 2009 01:20:06 +0100
Message-ID: <1258417206-5406-1-git-send-email-book@cpan.org>
References: <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 01:20:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABoA-0003ah-0q
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbZKQAUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbZKQAUD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:20:03 -0500
Received: from mail-out3.booking.com ([91.195.237.20]:55551 "EHLO
	mail-out3.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbZKQAUB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:20:01 -0500
Received: from corpds-102.ams4.corp.booking.com ([10.196.68.83])
	by mtx-101.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABni-0002jz-MM; Tue, 17 Nov 2009 01:20:06 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-102.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABni-0002tb-KI; Tue, 17 Nov 2009 01:20:06 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id 6FDBAEF8005;
	Tue, 17 Nov 2009 01:20:06 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABni-0001Q9-6X; Tue, 17 Nov 2009 01:20:06 +0100
X-Mailer: git-send-email 1.6.0.3.517.g759a
In-Reply-To: <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133046>

Some test scripts run Perl scripts as if they were git-* scripts, and
thus need to use the same perl that will be put in the shebang line of
git*.perl commands. $PERL_PATH therefore needs to be used instead of
a bare "perl".

The tests can fail if another perl is found in $PATH before the one
defined in $PERL_PATH.

Example test failure caused by this: the perl defined in $PERL_PATH has
Error.pm installed, and therefore the Git.pm's Makefile.PL doesn't install
the private copy. The perl from $PATH doesn't have Error.pm installed, and
all git*.perl scripts invoked during the test will fail loading Error.pm.

Makefile patch by Jeff King <peff@peff.net>.

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 Makefile                        |    1 +
 t/t9400-git-cvsserver-server.sh |    2 +-
 t/t9401-git-cvsserver-crlf.sh   |    2 +-
 t/t9700-perl-git.sh             |    4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 35f5294..8e8f981 100644
--- a/Makefile
+++ b/Makefile
@@ -1633,6 +1633,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 # and the first level quoting from the shell that runs "echo".
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@
+	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >$@
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 64f947d..c2ec3cb 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -20,7 +20,7 @@ then
     say 'skipping git-cvsserver tests, cvs not found'
     test_done
 fi
-perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+"$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
 }
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index aca40c1..40637d6 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -57,7 +57,7 @@ then
     say 'skipping git-cvsserver tests, perl not available'
     test_done
 fi
-perl -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
+"$PERL_PATH" -e 'use DBI; use DBD::SQLite' >/dev/null 2>&1 || {
     say 'skipping git-cvsserver tests, Perl SQLite interface unavailable'
     test_done
 }
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 4eb7d3f..96a2e55 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -11,7 +11,7 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-perl -MTest::More -e 0 2>/dev/null || {
+"$PERL_PATH" -MTest::More -e 0 2>/dev/null || {
 	say "Perl Test::More unavailable, skipping test"
 	test_done
 }
@@ -48,6 +48,6 @@ test_expect_success \
 
 test_external_without_stderr \
     'Perl API' \
-    perl "$TEST_DIRECTORY"/t9700/test.pl
+    $PERL_PATH "$TEST_DIRECTORY"/t9700/test.pl
 
 test_done
-- 
1.6.0.3.517.g759a
