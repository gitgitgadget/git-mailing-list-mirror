From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/2] tests: Infrastructure for Git smoke testing
Date: Mon,  2 Aug 2010 20:24:43 +0000
Message-ID: <1280780684-26344-2-git-send-email-avarab@gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 02 22:25:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1ZU-000317-0c
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab0HBUZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 16:25:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47650 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0HBUZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:25:03 -0400
Received: by wyb39 with SMTP id 39so3672287wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OGKxtTyUfIeZX3lltM3R+1/pe4JqdRhb3NU8MnpL1AY=;
        b=OqIQgBPxC/N9EMJPxobdJZKxvx4UA9Kx4Fuml2Tc+6yfuY1KUXARCFN+xp5qp84pbb
         Ycez0Xu+fRCLOuD2j5JkvdmRDUgE79pHBTpfLIIGkiIdcj+OqAUAIEK/j7vgzEY+SqrZ
         bXXMc1Ep5nUFpIGHcjpspCf9cJ//28zi2TAUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Cn15ExJFUc62BKVwM3GMfzFf61ONeJkgmzQH2IxHRfV13bhW9oOKwzqfQj1cO2My4W
         Kscpq0lP7mVNay3o29RdcmzKkDe5h+7br7ml2LfbqyvmvPVCAGHBTjT3CEE5HTzjUUqe
         aUJBnjloXmV7YmQdwnlca7Q0x6SW/jF8MQapc=
Received: by 10.227.129.14 with SMTP id m14mr4922193wbs.71.1280780702282;
        Mon, 02 Aug 2010 13:25:02 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id 2sm3109811wey.0.2010.08.02.13.25.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 13:25:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1280780684-26344-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152453>

Add the capability to send smoke reports from the Git test suite.

Currently we only notice bugs in the test suite when it's run
manually. Bugs in Git that only occur on obscure platforms or setups
that the core developers aren't using can thus go unnoticed.

This series aims to change that. With it anyone that's interested in
avoiding bitrot in Git can volunteer to run a smoke tester. A smoke
tester periodically compiles the latest version of Git, runs the test
suite, and submits a report to a central server indicating how the
test run went.

A smoke tester might run something like this in cron:

    #!/bin/sh
    cd ~/g/git
    git fetch
    for branch in maint master next pu; do
        git checkout origin/$i &&
        make clean all &&
        cd t &&
        make smoke_report
    done

The smoker might want to compile git with non-default flags, include
bisecting functionality or run the tests under valgrind. Doing that is
outside the scope of this patch, this just adds a report submission
mechanism. But including a canonical smoke runner is something we'll
want to include eventually.

What this does now is add smoke and smoke_report targets to t/Makefile
(this example only uses a few tests for demonstration):

    $ make clean smoke
    rm -f -r 'trash directory'.* test-results
    rm -f t????/cvsroot/CVSROOT/?*
    rm -f -r valgrind/bin
    rm -f .prove
    perl ./harness --git-version=3D"1.7.2.1.173.gc9b40" \
                    --no-verbose \
                    --archive=3D"test-results/git-smoke.tar.gz" \
                    t0000-basic.sh t0001-init.sh t0002-gitfile.sh t0003=
-attributes.sh t0004-unwritable.sh t0005-signals.sh t0006-date.sh
    t0000-basic.sh ....... ok
    t0001-init.sh ........ ok
    t0002-gitfile.sh ..... ok
    t0003-attributes.sh .. ok
    t0004-unwritable.sh .. ok
    t0005-signals.sh ..... ok
    t0006-date.sh ........ ok
    All tests successful.

    Test Summary Report
    -------------------
    t0000-basic.sh     (Wstat: 0 Tests: 46 Failed: 0)
      TODO passed:   5
    Files=3D7, Tests=3D134,  3 wallclock secs ( 0.06 usr  0.05 sys +  0=
=2E23 cusr  1.33 csys =3D  1.67 CPU)
    Result: PASS

    TAP Archive created at /home/avar/g/git/t/test-results/git-smoke.ta=
r.gz

The smoke target uses TAP::Harness::Archive to aggregate the test
results into a tarball. The tarball contains two things, the output of
every test file that was run, and a metadata file:

Tarball contents:

    $ tar xzvf git-smoke.tar.gz
    t0004-unwritable.sh
    t0001-init.sh
    t0002-gitfile.sh
    t0005-signals.sh
    t0000-basic.sh
    t0003-attributes.sh
    t0006-date.sh
    meta.yml

A test report:

    $ cat t0005-signals.sh
    ok 1 - sigchain works
    # passed all 1 test(s)
    1..1

A metadata file:

    ---
    extra_properties:
    file_attributes:
      -
        description: t0000-basic.sh
        end_time: 1280437324.61398
        start_time: 1280437324.22186
      -
        description: t0001-init.sh
        end_time: 1280437325.12346
        start_time: 1280437324.62393
      -
        description: t0002-gitfile.sh
        end_time: 1280437325.29428
        start_time: 1280437325.13646
      -
        description: t0003-attributes.sh
        end_time: 1280437325.59678
        start_time: 1280437325.30565
      -
        description: t0004-unwritable.sh
        end_time: 1280437325.77376
        start_time: 1280437325.61003
      -
        description: t0005-signals.sh
        end_time: 1280437325.85426
        start_time: 1280437325.78727
      -
        description: t0006-date.sh
        end_time: 1280437326.2362
        start_time: 1280437325.86768
    file_order:
      - t0000-basic.sh
      - t0001-init.sh
      - t0002-gitfile.sh
      - t0003-attributes.sh
      - t0004-unwritable.sh
      - t0005-signals.sh
      - t0006-date.sh
    start_time: 1280437324
    stop_time: 1280437326

The "extra_properties" hash is where we'll stick Git-specific info,
like whether Git was compiled with gettext or the fallback regex
engine, and what branch we're compiling. Currently no metadata like
this is included.

The entire tarball is then submitted to a central smokebox at
smoke.git.nix.is. This is done with curl(1) via the "smoke_report"
target:

    $ make smoke_report
    curl \
                    -H "Expect: " \
                    -F project=3DGit \
                    -F architecture=3Dx86_64 \
                    -F platform=3DLinux \
                    -F revision=3D"1.7.2.1.173.gc9b40" \
                    -F report_file=3D@test-results/git-smoke.tar.gz \
                    http://smoke.git.nix.is/app/projects/process_add_re=
port/1 \
            | grep -v ^Redirecting
      % Total    % Received % Xferd  Average Speed   Time    Time     T=
ime  Current
                                     Dload  Upload   Total   Spent    L=
eft  Speed
    100  117k  100    63  100  117k      3   6430  0:00:21  0:00:18  0:=
00:03     0
    Reported #8 added.

Reports are then made available on the smokebox via a web interface:

    http://smoke.git.nix.is/app/projects/smoke_reports/1

The smoke reports are also mirrored to a Git repository hosted on
GitHub:

    http://github.com/gitsmoke/smoke-reports

The Smolder SQLite database that contains metadata about the reports
is also made available:

    http://github.com/gitsmoke/smoke-database

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/Makefile |   35 ++++++++++++++++++++++++++++++++++-
 t/harness  |   21 +++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletions(-)
 create mode 100755 t/harness

diff --git a/t/Makefile b/t/Makefile
index 819b936..169097d 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -49,4 +49,37 @@ full-svn-test:
 valgrind:
 	GIT_TEST_OPTS=3D--valgrind $(MAKE)
=20
-.PHONY: pre-clean $(T) aggregate-results clean valgrind
+# Smoke testing targets
+-include ../GIT-BUILD-OPTIONS
+-include ../GIT-VERSION-FILE
+uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo unknown')
+uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo unknown')
+
+test-results:
+	mkdir -p test-results
+
+test-results/git-smoke.tar.gz:
+	$(PERL_PATH) ./harness \
+		--archive=3D"test-results/git-smoke.tar.gz" \
+		$(T)
+
+smoke: test-results/git-smoke.tar.gz
+
+SMOKE_UPLOAD_FLAGS =3D
+ifdef SMOKE_USERNAME
+	SMOKE_UPLOAD_FLAGS +=3D -F username=3D$(SMOKE_USERNAME) -F password=3D=
$(SMOKE_PASSWORD)
+endif
+
+smoke_report: smoke
+	curl \
+		-H "Expect: " \
+		-F project=3DGit \
+		-F architecture=3D$(uname_M) \
+		-F platform=3D$(uname_S) \
+		-F revision=3D"$(GIT_VERSION)" \
+		-F report_file=3D@test-results/git-smoke.tar.gz \
+		$(SMOKE_UPLOAD_FLAGS) \
+		http://smoke.git.nix.is/app/projects/process_add_report/1 \
+	| grep -v ^Redirecting
+
+.PHONY: pre-clean $(T) aggregate-results clean valgrind smoke smoke_re=
port
diff --git a/t/harness b/t/harness
new file mode 100755
index 0000000..f5c02f4
--- /dev/null
+++ b/t/harness
@@ -0,0 +1,21 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use Getopt::Long ();
+use TAP::Harness::Archive;
+
+Getopt::Long::Parser->new(
+	config =3D> [ qw/ pass_through / ],
+)->getoptions(
+	'jobs:1'    =3D> \(my $jobs =3D $ENV{TEST_JOBS}),
+	'archive=3Ds' =3D> \my $archive,
+) or die "$0: Couldn't getoptions()";
+
+TAP::Harness::Archive->new({
+	jobs             =3D> $jobs,
+	archive          =3D> $archive,
+	($ENV{GIT_TEST_OPTS}
+	 ? (test_args    =3D> [ split /\s+/, $ENV{GIT_TEST_OPTS} ])
+	 : ()),
+	extra_properties =3D> {},
+})->runtests(@ARGV);
--=20
1.7.1
