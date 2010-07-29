From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC] tests: WIP Infrastructure for Git smoke testing
Date: Thu, 29 Jul 2010 21:20:55 +0000
Message-ID: <1280438455-16255-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 23:21:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeaXa-0005aB-MW
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 23:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab0G2VVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 17:21:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39105 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab0G2VVK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 17:21:10 -0400
Received: by wwj40 with SMTP id 40so849274wwj.1
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=oMcsZRwe075eUZBZOzKvUtoV2HALHHthWTfGvHgyLkc=;
        b=kp/MFEjTOJPmIMLu8FO4nQr2a2dHwgh86kZM9Rk/EeVu1lzh5RS+abK1OjTyiIkq7u
         LKnoCahQUuIIo0+wl+IEJ9lh3TDJ4WfRrbOgi1b9LHr/+Zokm2eqT0rJpaIsvzBrWjUu
         41Twqqv/IlRdQn51edUZKNvnbSHA9jkhW0ZCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HvhuVRoHGuyj22vmUJDb+obfvLvYJGPreG4sEmUzZ+c/hjVm3usnJH3l5WdoKYUoRn
         P9YUd66QlY0Nib6CU8vF+64tTZunFYWzuYOEuQk/nPrBjg/VL7fklFqo2TFIqhzKq7+U
         s05Y+ApScoKsmyC5qgE7l4iFxSmDRjK6jDfv8=
Received: by 10.216.93.16 with SMTP id k16mr698707wef.78.1280438467913;
        Thu, 29 Jul 2010 14:21:07 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h37sm770168wej.23.2010.07.29.14.21.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 14:21:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152199>

Add the capability to send smoke reports to the Git test suite.

Currently we only notice bugs in the test suite when it's run
manually. Bugs in Git that only occur on obscure platforms or setups
that the core developers aren't using may thus go unnoticed until the
bug makes it into a release.

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

The smoker might want to compile git with non-default flags. A script
which does that is outside the scope of this patch. But it's something
we'll want to include eventually.

What this does now is add smoke and smoke_report targets to
t/Makefile:

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

A test report, this could also include --verbose output:

    $ cat t0005-signals.sh
    ok 1 - sigchain works
    # passed all 1 test(s)
    1..1

A metadata file:

    ---
    extra_properties:
      git:
        version: 1.7.2.1.173.gc9b40
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

The "extra_properties" hash is where we'd stick Git-specific info,
like whether Git was compiled with gettext or the fallback regex
engine.

The entire tarball is then submitted to a central smoke
aggregator. Currently this is done with curl over HTTP, but could also
be done e.g. via E-Mail:

    curl \
        -F architecture=3Damd64 \
        -F platform=3Dlinux \
        -F revision=3D"$(GIT_VERSION)" \
        -F report_file=3D@test-results/git-smoke.tar.gz \
        http://git.smoke.example.net/submit_report

The aggregator would make both the raw test reports available, and
might format them with a web interface. Smolder (on CPAN) is one
example of the latter. Here are smoke reports for the Rakudo project
on Smolder:

    http://smolder.plusthree.com/app/projects/smoke_reports/18

TODO:

  - Is this worthwhile. Are there developers / packagers / other
    interested parties here who'd be interested in actually running
    smoke testers? It should be really easy to set one up.

  - How do I get things like PERL_PATH and uname_M from the top-level
    Makefile? Currently I just hardcode e.g. "perl" and
    "architecture=3Damd64". Maybe this needs to be a top-level target
    instead?

  - Set up the smoke aggregator. I was running into some issues with
    smolder, but those are solvable given some time. I can run and
    maintain the smoke aggregator if this gets accepted.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/Makefile |   20 ++++++++++++++++++++
 t/harness  |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100755 t/harness

diff --git a/t/Makefile b/t/Makefile
index 819b936..459a667 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -49,4 +49,24 @@ full-svn-test:
 valgrind:
 	GIT_TEST_OPTS=3D--valgrind $(MAKE)
=20
+test-results:
+	mkdir -p test-results
+
+-include ../GIT-VERSION-FILE
+test-results/git-smoke.tar.gz:
+	perl ./harness --git-version=3D"$(GIT_VERSION)" \
+		--no-verbose \
+		--archive=3D"test-results/git-smoke.tar.gz" \
+		$(wildcard t000[0-9]-*.sh)
+
+smoke: test-results/git-smoke.tar.gz
+
+smoke_report: smoke
+	curl \
+		-F architecture=3Damd64 \
+		-F platform=3Dlinux \
+		-F revision=3D"$(GIT_VERSION)" \
+		-F report_file=3D@test-results/git-smoke.tar.gz \
+		http://git.smoke.example.net/submit_report
+
 .PHONY: pre-clean $(T) aggregate-results clean valgrind
diff --git a/t/harness b/t/harness
new file mode 100755
index 0000000..72b4af6
--- /dev/null
+++ b/t/harness
@@ -0,0 +1,36 @@
+#!/usr/bin/perl
+use 5.010;
+use strict;
+use warnings;
+use Pod::Usage ();
+use Getopt::Long ();
+use TAP::Harness::Archive;
+
+Getopt::Long::Parser->new(
+    config =3D> [ qw/ pass_through / ],
+)->getoptions(
+    'h|help'        =3D> \my $help,
+    'jobs:1'        =3D> \my $jobs,
+    'verbose!'      =3D> \(my $verbose =3D 1),
+    'git-version=3Ds' =3D> \my $git_version,
+    'archive=3Ds'     =3D> \my $archive,
+) or die "$0: Couldn't getoptions()";
+
+my @tests =3D @ARGV;
+
+my $harness =3D TAP::Harness::Archive->new({
+    verbosity =3D> 0,
+    jobs      =3D> $ENV{TEST_JOBS} || $jobs || 1,
+    test_args =3D> [
+        ($verbose
+         ? qw/ --verbose /
+         : ())
+    ],
+    archive   =3D> $archive,
+    extra_properties =3D> {
+        git =3D> {
+            version =3D> $git_version,
+        },
+    }
+});
+$harness->runtests(@tests);
--=20
1.7.1
