From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Remove Git's support for smoke testing
Date: Fri, 23 Dec 2011 17:08:18 +0000
Message-ID: <1324660098-26666-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 18:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re8bU-0003wn-9C
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 18:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507Ab1LWRIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 12:08:18 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57551 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab1LWRIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 12:08:14 -0500
Received: by eekc4 with SMTP id c4so9477688eek.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QP4nO6J9/dwOtZcgf9/7GgfIYFfD8xz52KjBeDj3EU4=;
        b=XRs/7l8EPQq0mPYDL8k2V50s1LEf65IIdHFwmbvX9b3tRg3C/OKmrA3GNJh1nFF8LV
         xTv5spxqyzNnPWicE9Aws7zGD2/6fssY5UB663frnFgZzgF/CeYI+rl4jZeklBNcOUpx
         ODMkh6/mBVSFpMdzGeemJWLc7Ps6MbteQzceo=
Received: by 10.213.98.74 with SMTP id p10mr3145474ebn.131.1324660092633;
        Fri, 23 Dec 2011 09:08:12 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id t59sm50594065eeh.10.2011.12.23.09.08.11
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Dec 2011 09:08:12 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187635>

I'm no longer running the Git smoke testing service at
smoke.git.nix.is due to Smolder being a fragile piece of software not
having time to follow through on making it easy for third parties to
run and submit their own smoke tests.

So remove the support in Git for sending smoke tests to
smoke.git.nix.is, it's still easy to modify the test suite to submit
smokes somewhere else.

This reverts the following commits:

    Revert "t/README: Add SMOKE_{COMMENT,TAGS}=3D to smoke_report targe=
t" -- e38efac87d
    Revert "t/README: Document the Smoke testing" -- d15e9ebc5c
    Revert "t/Makefile: Create test-results dir for smoke target" -- 61=
7344d77b
    Revert "tests: Infrastructure for Git smoke testing" -- b6b84d1b74

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/Makefile |   40 +--------------------------------
 t/README   |   73 ----------------------------------------------------=
--------
 t/harness  |   21 -----------------
 3 files changed, 1 insertions(+), 133 deletions(-)
 delete mode 100755 t/harness

diff --git a/t/Makefile b/t/Makefile
index 9046ec9..52a23ff 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -73,42 +73,4 @@ gitweb-test:
 valgrind:
 	$(MAKE) GIT_TEST_OPTS=3D"$(GIT_TEST_OPTS) --valgrind"
=20
-# Smoke testing targets
--include ../GIT-VERSION-FILE
-uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo unknown')
-uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo unknown')
-
-test-results:
-	mkdir -p test-results
-
-test-results/git-smoke.tar.gz: test-results
-	$(PERL_PATH) ./harness \
-		--archive=3D"test-results/git-smoke.tar.gz" \
-		$(T)
-
-smoke: test-results/git-smoke.tar.gz
-
-SMOKE_UPLOAD_FLAGS =3D
-ifdef SMOKE_USERNAME
-	SMOKE_UPLOAD_FLAGS +=3D -F username=3D"$(SMOKE_USERNAME)" -F password=
=3D"$(SMOKE_PASSWORD)"
-endif
-ifdef SMOKE_COMMENT
-	SMOKE_UPLOAD_FLAGS +=3D -F comments=3D"$(SMOKE_COMMENT)"
-endif
-ifdef SMOKE_TAGS
-	SMOKE_UPLOAD_FLAGS +=3D -F tags=3D"$(SMOKE_TAGS)"
-endif
-
-smoke_report: smoke
-	curl \
-		-H "Expect: " \
-		-F project=3DGit \
-		-F architecture=3D"$(uname_M)" \
-		-F platform=3D"$(uname_S)" \
-		-F revision=3D"$(GIT_VERSION)" \
-		-F report_file=3D@test-results/git-smoke.tar.gz \
-		$(SMOKE_UPLOAD_FLAGS) \
-		http://smoke.git.nix.is/app/projects/process_add_report/1 \
-	| grep -v ^Redirecting
-
-.PHONY: pre-clean $(T) aggregate-results clean valgrind smoke smoke_re=
port
+.PHONY: pre-clean $(T) aggregate-results clean valgrind
diff --git a/t/README b/t/README
index c85abaf..681e8b4 100644
--- a/t/README
+++ b/t/README
@@ -658,76 +658,3 @@ Then, at the top-level:
 That'll generate a detailed cover report in the "cover_db_html"
 directory, which you can then copy to a webserver, or inspect locally
 in a browser.
-
-Smoke testing
--------------
-
-The Git test suite has support for smoke testing. Smoke testing is
-when you submit the results of a test run to a central server for
-analysis and aggregation.
-
-Running a smoke tester is an easy and valuable way of contributing to
-Git development, particularly if you have access to an uncommon OS on
-obscure hardware.
-
-After building Git you can generate a smoke report like this in the
-"t" directory:
-
-    make clean smoke
-
-You can also pass arguments via the environment. This should make it
-faster:
-
-    GIT_TEST_OPTS=3D'--root=3D/dev/shm' TEST_JOBS=3D10 make clean smok=
e
-
-The "smoke" target will run the Git test suite with Perl's
-"TAP::Harness" module, and package up the results in a .tar.gz archive
-with "TAP::Harness::Archive". The former is included with Perl v5.10.1
-or later, but you'll need to install the latter from the CPAN. See the
-"Test coverage" section above for how you might do that.
-
-Once the "smoke" target finishes you'll see a message like this:
-
-    TAP Archive created at <path to git>/t/test-results/git-smoke.tar.=
gz
-
-To upload the smoke report you need to have curl(1) installed, then
-do:
-
-    make smoke_report
-
-To upload the report anonymously. Hopefully that'll return something
-like "Reported #7 added.".
-
-If you're going to be uploading reports frequently please request a
-user account by E-Mailing gitsmoke@v.nix.is. Once you have a username
-and password you'll be able to do:
-
-    SMOKE_USERNAME=3D<username> SMOKE_PASSWORD=3D<password> make smoke=
_report
-
-You can also add an additional comment to attach to the report, and/or
-a comma separated list of tags:
-
-    SMOKE_USERNAME=3D<username> SMOKE_PASSWORD=3D<password> \
-        SMOKE_COMMENT=3D<comment> SMOKE_TAGS=3D<tags> \
-        make smoke_report
-
-Once the report is uploaded it'll be made available at
-http://smoke.git.nix.is, here's an overview of Recent Smoke Reports
-for Git:
-
-    http://smoke.git.nix.is/app/projects/smoke_reports/1
-
-The reports will also be mirrored to GitHub every few hours:
-
-    http://github.com/gitsmoke/smoke-reports
-
-The Smolder SQLite database is also mirrored and made available for
-download:
-
-    http://github.com/gitsmoke/smoke-database
-
-Note that the database includes hashed (with crypt()) user passwords
-and E-Mail addresses. Don't use a valuable password for the smoke
-service if you have an account, or an E-Mail address you don't want to
-be publicly known. The user accounts are just meant to be convenient
-labels, they're not meant to be secure.
diff --git a/t/harness b/t/harness
deleted file mode 100755
index f5c02f4..0000000
--- a/t/harness
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/usr/bin/perl
-use strict;
-use warnings;
-use Getopt::Long ();
-use TAP::Harness::Archive;
-
-Getopt::Long::Parser->new(
-	config =3D> [ qw/ pass_through / ],
-)->getoptions(
-	'jobs:1'    =3D> \(my $jobs =3D $ENV{TEST_JOBS}),
-	'archive=3Ds' =3D> \my $archive,
-) or die "$0: Couldn't getoptions()";
-
-TAP::Harness::Archive->new({
-	jobs             =3D> $jobs,
-	archive          =3D> $archive,
-	($ENV{GIT_TEST_OPTS}
-	 ? (test_args    =3D> [ split /\s+/, $ENV{GIT_TEST_OPTS} ])
-	 : ()),
-	extra_properties =3D> {},
-})->runtests(@ARGV);
--=20
1.7.7.3
