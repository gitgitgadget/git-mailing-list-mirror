From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/3] Introduce a performance testing framework
Date: Fri, 17 Feb 2012 11:25:09 +0100
Message-ID: <c862838275745584956bfd57c8c91f3048f8113c.1329472405.git.trast@student.ethz.ch>
References: <cover.1329472405.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 11:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyL0W-0003kV-72
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 11:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab2BQKZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 05:25:30 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:33856 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2BQKZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 05:25:17 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 11:25:08 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 11:25:11 +0100
X-Mailer: git-send-email 1.7.9.1.365.ge223f
In-Reply-To: <cover.1329472405.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190946>

This introduces a performance testing framework under t/perf/.  It
tries to be as close to the test-lib.sh infrastructure as possible,
and thus should be easy to get used to for git developers.

The following points were considered for the implementation:

1. You usually want to compare arbitrary revisions/build trees against
   each other.  They may not have the performance test under
   consideration, or even the perf-lib.sh infrastructure.

   To cope with this, the 'run' script lets you specify arbitrary
   build dirs and revisions.  It even automatically builds the revisions
   if it doesn't have them at hand yet.

2. Usually you would not want to run all tests.  It would take too
   long anyway.  The 'run' script lets you specify which tests to run;
   or you can also do it manually.  There is a Makefile for
   discoverability and 'make clean', but it is not meant for
   real-world use.

3. Creating test repos from scratch in every test is extremely
   time-consuming, and shipping or downloading such large/weird repos
   is out of the question.

   We leave this decision to the user.  Two different sizes of test
   repos can be configured, and the scripts just copy one or more of
   those (using hardlinks for the object store).  By default it tries
   to use the build tree's git.git repository.

   This is fairly fast and versatile.  Using a copy instead of a clone
   preserves many properties that the user may want to test for, such
   as lots of loose objects, unpacked refs, etc.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Makefile                        |   22 ++++-
 t/Makefile                      |   43 ++++++++-
 t/perf/.gitignore               |    2 +
 t/perf/Makefile                 |   15 +++
 t/perf/README                   |  146 +++++++++++++++++++++++++++++
 t/perf/aggregate.perl           |  166 ++++++++++++++++++++++++++++++++
 t/perf/min_time.perl            |   21 +++++
 t/perf/p0000-perf-lib-sanity.sh |   41 ++++++++
 t/perf/p0001-rev-list.sh        |   17 ++++
 t/perf/perf-lib.sh              |  198 +++++++++++++++++++++++++++++++++++++++
 t/perf/run                      |   82 ++++++++++++++++
 t/test-lib.sh                   |   26 ++++-
 12 files changed, 774 insertions(+), 5 deletions(-)
 create mode 100644 t/perf/.gitignore
 create mode 100644 t/perf/Makefile
 create mode 100644 t/perf/README
 create mode 100755 t/perf/aggregate.perl
 create mode 100755 t/perf/min_time.perl
 create mode 100755 t/perf/p0000-perf-lib-sanity.sh
 create mode 100755 t/perf/p0001-rev-list.sh
 create mode 100644 t/perf/perf-lib.sh
 create mode 100755 t/perf/run

diff --git a/Makefile b/Makefile
index a0de4e9..1fb1705 100644
--- a/Makefile
+++ b/Makefile
@@ -2361,6 +2361,10 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
+	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+ifdef GIT_TEST_OPTS
+	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@
+endif
 ifdef GIT_TEST_CMP
 	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@
 endif
@@ -2369,7 +2373,18 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@
 	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@
-	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+ifdef GIT_PERF_REPEAT_COUNT
+	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@
+endif
+ifdef GIT_PERF_REPO
+	@echo GIT_PERF_REPO=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPO)))'\' >>$@
+endif
+ifdef GIT_PERF_LARGE_REPO
+	@echo GIT_PERF_LARGE_REPO=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_LARGE_REPO)))'\' >>$@
+endif
+ifdef GIT_PERF_MAKE_OPTS
+	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
+endif
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
@@ -2405,6 +2420,11 @@ export NO_SVN_TESTS
 test: all
 	$(MAKE) -C t/ all
 
+perf: all
+	$(MAKE) -C t/perf/ all
+
+.PHONY: test perf
+
 test-ctype$X: ctype.o
 
 test-date$X: date.o ctype.o
diff --git a/t/Makefile b/t/Makefile
index b5048ab..6091211 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -73,4 +73,45 @@ gitweb-test:
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
 
-.PHONY: pre-clean $(T) aggregate-results clean valgrind
+perf:
+	$(MAKE) -C perf/ all
+
+# Smoke testing targets
+-include ../GIT-VERSION-FILE
+uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo unknown')
+uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo unknown')
+
+test-results:
+	mkdir -p test-results
+
+test-results/git-smoke.tar.gz: test-results
+	$(PERL_PATH) ./harness \
+		--archive="test-results/git-smoke.tar.gz" \
+		$(T)
+
+smoke: test-results/git-smoke.tar.gz
+
+SMOKE_UPLOAD_FLAGS =
+ifdef SMOKE_USERNAME
+	SMOKE_UPLOAD_FLAGS += -F username="$(SMOKE_USERNAME)" -F password="$(SMOKE_PASSWORD)"
+endif
+ifdef SMOKE_COMMENT
+	SMOKE_UPLOAD_FLAGS += -F comments="$(SMOKE_COMMENT)"
+endif
+ifdef SMOKE_TAGS
+	SMOKE_UPLOAD_FLAGS += -F tags="$(SMOKE_TAGS)"
+endif
+
+smoke_report: smoke
+	curl \
+		-H "Expect: " \
+		-F project=Git \
+		-F architecture="$(uname_M)" \
+		-F platform="$(uname_S)" \
+		-F revision="$(GIT_VERSION)" \
+		-F report_file=@test-results/git-smoke.tar.gz \
+		$(SMOKE_UPLOAD_FLAGS) \
+		http://smoke.git.nix.is/app/projects/process_add_report/1 \
+	| grep -v ^Redirecting
+
+.PHONY: pre-clean $(T) aggregate-results clean valgrind perf
diff --git a/t/perf/.gitignore b/t/perf/.gitignore
new file mode 100644
index 0000000..50f5cc1
--- /dev/null
+++ b/t/perf/.gitignore
@@ -0,0 +1,2 @@
+build/
+test-results/
diff --git a/t/perf/Makefile b/t/perf/Makefile
new file mode 100644
index 0000000..8c47155
--- /dev/null
+++ b/t/perf/Makefile
@@ -0,0 +1,15 @@
+-include ../../config.mak
+export GIT_TEST_OPTIONS
+
+all: perf
+
+perf: pre-clean
+	./run
+
+pre-clean:
+	rm -rf test-results
+
+clean:
+	rm -rf build "trash directory".* test-results
+
+.PHONY: all perf pre-clean clean
diff --git a/t/perf/README b/t/perf/README
new file mode 100644
index 0000000..fdf974a
--- /dev/null
+++ b/t/perf/README
@@ -0,0 +1,146 @@
+Git performance tests
+=====================
+
+This directory holds performance testing scripts for git tools.  The
+first part of this document describes the various ways in which you
+can run them.
+
+When fixing the tools or adding enhancements, you are strongly
+encouraged to add tests in this directory to cover what you are
+trying to fix or enhance.  The later part of this short document
+describes how your test scripts should be organized.
+
+
+Running Tests
+-------------
+
+The easiest way to run tests is to say "make".  This runs all
+the tests on the current git repository.
+
+    === Running 2 tests in this tree ===
+    [...]
+    Test                                     this tree       
+    ---------------------------------------------------------
+    0001.1: rev-list --all                   0.54(0.51+0.02) 
+    0001.2: rev-list --all --objects         6.14(5.99+0.11) 
+    7810.1: grep worktree, cheap regex       0.16(0.16+0.35) 
+    7810.2: grep worktree, expensive regex   7.90(29.75+0.37)
+    7810.3: grep --cached, cheap regex       3.07(3.02+0.25) 
+    7810.4: grep --cached, expensive regex   9.39(30.57+0.24)
+
+You can compare multiple repositories and even git revisions with the
+'run' script:
+
+    $ ./run . origin/next /path/to/git-tree p0001-rev-list.sh
+
+where . stands for the current git tree.  The full invocation is
+
+    ./run [<revision|directory>...] [--] [<test-script>...]
+
+A '.' argument is implied if you do not pass any other
+revisions/directories.
+
+You can also manually test this or another git build tree, and then
+call the aggregation script to summarize the results:
+
+    $ ./p0001-rev-list.sh
+    [...]
+    $ GIT_BUILD_DIR=/path/to/other/git ./p0001-rev-list.sh
+    [...]
+    $ ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
+
+aggregate.perl has the same invocation as 'run', it just does not run
+anything beforehand.
+
+You can set the following variables (also in your config.mak):
+
+    GIT_PERF_REPEAT_COUNT
+	Number of times a test should be repeated for best-of-N
+	measurements.  Defaults to 5.
+
+    GIT_PERF_MAKE_OPTS
+	Options to use when automatically building a git tree for
+	performance testing.  E.g., -j6 would be useful.
+
+    GIT_PERF_REPO
+    GIT_PERF_LARGE_REPO
+	Repositories to copy for the performance tests.  The normal
+	repo should be at least git.git size.  The large repo should
+	probably be about linux-2.6.git size for optimal results.
+	Both default to the git.git you are running from.
+
+You can also pass the options taken by ordinary git tests; the most
+useful one is:
+
+--root=<directory>::
+	Create "trash" directories used to store all temporary data during
+	testing under <directory>, instead of the t/ directory.
+	Using this option with a RAM-based filesystem (such as tmpfs)
+	can massively speed up the test suite.
+
+
+Naming Tests
+------------
+
+The performance test files are named as:
+
+	pNNNN-commandname-details.sh
+
+where N is a decimal digit.  The same conventions for choosing NNNN as
+for normal tests apply.
+
+
+Writing Tests
+-------------
+
+The perf script starts much like a normal test script, except it
+sources perf-lib.sh:
+
+	#!/bin/sh
+	#
+	# Copyright (c) 2005 Junio C Hamano
+	#
+
+	test_description='xxx performance test'
+	. ./perf-lib.sh
+
+After that you will want to use some of the following:
+
+	test_perf_default_repo  # sets up a "normal" repository
+	test_perf_large_repo    # sets up a "large" repository
+
+	test_perf_default_repo sub  # ditto, in a subdir "sub"
+
+        test_checkout_worktree  # if you need the worktree too
+
+At least one of the first two is required!
+
+You can use test_expect_success as usual.  For actual performance
+tests, use
+
+	test_perf 'descriptive string' '
+		command1 &&
+		command2
+	'
+
+test_perf spawns a subshell, for lack of better options.  This means
+that
+
+* you _must_ export all variables that you need in the subshell
+
+* you _must_ flag all variables that you want to persist from the
+  subshell with 'test_export':
+
+	test_perf 'descriptive string' '
+		foo=$(git rev-parse HEAD) &&
+		test_export foo
+	'
+
+  The so-exported variables are automatically marked for export in the
+  shell executing the perf test.  For your convenience, test_export is
+  the same as export in the main shell.
+
+  This feature relies on a bit of magic using 'set' and 'source'.
+  While we have tried to make sure that it can cope with embedded
+  whitespace and other special characters, it will not work with
+  multi-line data.
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
new file mode 100755
index 0000000..15f7fc1
--- /dev/null
+++ b/t/perf/aggregate.perl
@@ -0,0 +1,166 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use Git;
+
+sub get_times {
+	my $name = shift;
+	open my $fh, "<", $name or return undef;
+	my $line = <$fh>;
+	return undef if not defined $line;
+	close $fh or die "cannot close $name: $!";
+	$line =~ /^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
+		or die "bad input line: $line";
+	my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
+	return ($rt, $4, $5);
+}
+
+sub format_times {
+	my ($r, $u, $s, $firstr) = @_;
+	if (!defined $r) {
+		return "<missing>";
+	}
+	my $out = sprintf "%.2f(%.2f+%.2f)", $r, $u, $s;
+	if (defined $firstr) {
+		if ($firstr > 0) {
+			$out .= sprintf " %+.1f%%", 100.0*($r-$firstr)/$firstr;
+		} elsif ($r == 0) {
+			$out .= " =";
+		} else {
+			$out .= " +inf";
+		}
+	}
+	return $out;
+}
+
+my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests);
+while (scalar @ARGV) {
+	my $arg = $ARGV[0];
+	my $dir;
+	last if -f $arg or $arg eq "--";
+	if (! -d $arg) {
+		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
+		$dir = "build/".$rev;
+	} else {
+		$arg =~ s{/*$}{};
+		$dir = $arg;
+		$dirabbrevs{$dir} = $dir;
+	}
+	push @dirs, $dir;
+	$dirnames{$dir} = $arg;
+	my $prefix = $dir;
+	$prefix =~ tr/^a-zA-Z0-9/_/c;
+	$prefixes{$dir} = $prefix . '.';
+	shift @ARGV;
+}
+
+if (not @dirs) {
+	@dirs = ('.');
+}
+$dirnames{'.'} = $dirabbrevs{'.'} = "this tree";
+$prefixes{'.'} = '';
+
+shift @ARGV if scalar @ARGV and $ARGV[0] eq "--";
+
+@tests = @ARGV;
+if (not @tests) {
+	@tests = glob "p????-*.sh";
+}
+
+my @subtests;
+my %shorttests;
+for my $t (@tests) {
+	$t =~ s{(?:.*/)?(p(\d+)-[^/]+)\.sh$}{$1} or die "bad test name: $t";
+	my $n = $2;
+	my $fname = "test-results/$t.subtests";
+	open my $fp, "<", $fname or die "cannot open $fname: $!";
+	for (<$fp>) {
+		chomp;
+		/^(\d+)$/ or die "malformed subtest line: $_";
+		push @subtests, "$t.$1";
+		$shorttests{"$t.$1"} = "$n.$1";
+	}
+	close $fp or die "cannot close $fname: $!";
+}
+
+sub read_descr {
+	my $name = shift;
+	open my $fh, "<", $name or return "<error reading description>";
+	my $line = <$fh>;
+	close $fh or die "cannot close $name";
+	chomp $line;
+	return $line;
+}
+
+my %descrs;
+my $descrlen = 4; # "Test"
+for my $t (@subtests) {
+	$descrs{$t} = $shorttests{$t}.": ".read_descr("test-results/$t.descr");
+	$descrlen = length $descrs{$t} if length $descrs{$t}>$descrlen;
+}
+
+sub have_duplicate {
+	my %seen;
+	for (@_) {
+		return 1 if exists $seen{$_};
+		$seen{$_} = 1;
+	}
+	return 0;
+}
+sub have_slash {
+	for (@_) {
+		return 1 if m{/};
+	}
+	return 0;
+}
+
+my %newdirabbrevs = %dirabbrevs;
+while (!have_duplicate(values %newdirabbrevs)) {
+	%dirabbrevs = %newdirabbrevs;
+	last if !have_slash(values %dirabbrevs);
+	%newdirabbrevs = %dirabbrevs;
+	for (values %newdirabbrevs) {
+		s{^[^/]*/}{};
+	}
+}
+
+my %times;
+my @colwidth = ((0)x@dirs);
+for my $i (0..$#dirs) {
+	my $d = $dirs[$i];
+	my $w = length (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
+	$colwidth[$i] = $w if $w > $colwidth[$i];
+}
+for my $t (@subtests) {
+	my $firstr;
+	for my $i (0..$#dirs) {
+		my $d = $dirs[$i];
+		$times{$prefixes{$d}.$t} = [get_times("test-results/$prefixes{$d}$t.times")];
+		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+		my $w = length format_times($r,$u,$s,$firstr);
+		$colwidth[$i] = $w if $w > $colwidth[$i];
+		$firstr = $r unless defined $firstr;
+	}
+}
+my $totalwidth = 3*@dirs+$descrlen;
+$totalwidth += $_ for (@colwidth);
+
+printf "%-${descrlen}s", "Test";
+for my $i (0..$#dirs) {
+	my $d = $dirs[$i];
+	printf "   %-$colwidth[$i]s", (exists $dirabbrevs{$d} ? $dirabbrevs{$d} : $dirnames{$d});
+}
+print "\n";
+print "-"x$totalwidth, "\n";
+for my $t (@subtests) {
+	printf "%-${descrlen}s", $descrs{$t};
+	my $firstr;
+	for my $i (0..$#dirs) {
+		my $d = $dirs[$i];
+		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
+		printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
+		$firstr = $r unless defined $firstr;
+	}
+	print "\n";
+}
diff --git a/t/perf/min_time.perl b/t/perf/min_time.perl
new file mode 100755
index 0000000..c1a2717
--- /dev/null
+++ b/t/perf/min_time.perl
@@ -0,0 +1,21 @@
+#!/usr/bin/perl
+
+my $minrt = 1e100;
+my $min;
+
+while (<>) {
+	# [h:]m:s.xx U.xx S.xx
+	/^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
+		or die "bad input line: $_";
+	my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
+	if ($rt < $minrt) {
+		$min = $_;
+		$minrt = $rt;
+	}
+}
+
+if (!defined $min) {
+	die "no input found";
+}
+
+print $min;
diff --git a/t/perf/p0000-perf-lib-sanity.sh b/t/perf/p0000-perf-lib-sanity.sh
new file mode 100755
index 0000000..2ca4aac
--- /dev/null
+++ b/t/perf/p0000-perf-lib-sanity.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Tests whether perf-lib facilities work'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_perf 'test_perf_default_repo works' '
+	foo=$(git rev-parse HEAD) &&
+	test_export foo
+'
+
+test_checkout_worktree
+
+test_perf 'test_checkout_worktree works' '
+	wt=$(find . | wc -l) &&
+	idx=$(git ls-files | wc -l) &&
+	test $wt -gt $idx
+'
+
+baz=baz
+test_export baz
+
+test_expect_success 'test_export works' '
+	echo "$foo" &&
+	test "$foo" = "$(git rev-parse HEAD)" &&
+	echo "$baz" &&
+	test "$baz" = baz
+'
+
+test_perf 'export a weird var' '
+	bar="weird # variable" &&
+	test_export bar
+'
+
+test_expect_success 'test_export works with weird vars' '
+	echo "$bar" &&
+	test "$bar" = "weird # variable"
+'
+
+test_done
diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
new file mode 100755
index 0000000..4f71a63
--- /dev/null
+++ b/t/perf/p0001-rev-list.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Tests history walking performance"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_perf 'rev-list --all' '
+	git rev-list --all >/dev/null
+'
+
+test_perf 'rev-list --all --objects' '
+	git rev-list --all --objects >/dev/null
+'
+
+test_done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
new file mode 100644
index 0000000..07e9b09
--- /dev/null
+++ b/t/perf/perf-lib.sh
@@ -0,0 +1,198 @@
+#!/bin/bash
+#
+# Copyright (c) 2011 Thomas Rast
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see http://www.gnu.org/licenses/ .
+
+# do the --tee work early; it otherwise confuses our careful
+# GIT_BUILD_DIR mangling
+case "$GIT_TEST_TEE_STARTED, $* " in
+done,*)
+	# do not redirect again
+	;;
+*' --tee '*|*' --va'*)
+	mkdir -p test-results
+	BASE=test-results/$(basename "$0" .sh)
+	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
+	 echo $? > $BASE.exit) | tee $BASE.out
+	test "$(cat $BASE.exit)" = 0
+	exit
+	;;
+esac
+
+TEST_DIRECTORY=$(pwd)/..
+TEST_OUTPUT_DIRECTORY=$(pwd)
+if test -z "$GIT_TEST_INSTALLED"; then
+	perf_results_prefix=
+else
+	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
+	# make the tested dir absolute
+	GIT_TEST_INSTALLED=$(cd "$GIT_TEST_INSTALLED" && pwd)
+fi
+
+TEST_NO_CREATE_REPO=t
+
+. ../test-lib.sh
+
+perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
+mkdir -p "$perf_results_dir"
+rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
+
+if test -z "$GIT_PERF_REPEAT_COUNT"; then
+	GIT_PERF_REPEAT_COUNT=3
+fi
+die_if_build_dir_not_repo () {
+	if ! ( cd "$TEST_DIRECTORY/.." &&
+		    git rev-parse --build-dir >/dev/null 2>&1 ); then
+		error "No $1 defined, and your build directory is not a repo"
+	fi
+}
+
+if test -z "$GIT_PERF_REPO"; then
+	die_if_build_dir_not_repo '$GIT_PERF_REPO'
+	GIT_PERF_REPO=$TEST_DIRECTORY/..
+fi
+if test -z "$GIT_PERF_LARGE_REPO"; then
+	die_if_build_dir_not_repo '$GIT_PERF_LARGE_REPO'
+	GIT_PERF_LARGE_REPO=$TEST_DIRECTORY/..
+fi
+
+test_perf_create_repo_from () {
+	test "$#" = 2 ||
+	error "bug in the test script: not 2 parameters to test-create-repo"
+	repo="$1"
+	source="$2"
+	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
+	mkdir -p "$repo/.git"
+	(
+		cd "$repo/.git" &&
+		{ cp -Rl "$source_git/objects" . 2>/dev/null ||
+			cp -R "$source_git/objects" .; } &&
+		for stuff in "$source_git"/*; do
+			case "$stuff" in
+				*/objects|*/hooks|*/config)
+					;;
+				*)
+					cp -R "$stuff" . || break
+					;;
+			esac
+		done &&
+		cd .. &&
+		git init -q &&
+		mv .git/hooks .git/hooks-disabled 2>/dev/null
+	) || error "failed to copy repository '$source' to '$repo'"
+}
+
+# call at least one of these to establish an appropriately-sized repository
+test_perf_default_repo () {
+	test_perf_create_repo_from "${1:-$TRASH_DIRECTORY}" "$GIT_PERF_REPO"
+}
+test_perf_large_repo () {
+	if test "$GIT_PERF_LARGE_REPO" = "$GIT_BUILD_DIR"; then
+		echo "warning: \$GIT_PERF_LARGE_REPO is \$GIT_BUILD_DIR." >&2
+		echo "warning: This will work, but may not be a sufficiently large repo" >&2
+		echo "warning: for representative measurements." >&2
+	fi
+	test_perf_create_repo_from "${1:-$TRASH_DIRECTORY}" "$GIT_PERF_LARGE_REPO"
+}
+test_checkout_worktree () {
+	git checkout-index -u -a ||
+	error "git checkout-index failed"
+}
+
+# Performance tests should never fail.  If they do, stop immediately
+immediate=t
+
+test_run_perf_ () {
+	test_cleanup=:
+	test_export_="test_cleanup"
+	export test_cleanup test_export_
+	/usr/bin/time -f "%E %U %S" -o test_time.$i "$SHELL" -c '
+. '"$TEST_DIRECTORY"/../test-lib-functions.sh'
+test_export () {
+	[ $# != 0 ] || return 0
+	test_export_="$test_export_\\|$1"
+	shift
+	test_export "$@"
+}
+'"$1"'
+ret=$?
+set | sed -n "s'"/'/'\\\\''/g"';s/^\\($test_export_\\)/export '"'&'"'/p" >test_vars
+exit $ret' >&3 2>&4
+	eval_ret=$?
+
+	if test $eval_ret = 0 || test -n "$expecting_failure"
+	then
+		test_eval_ "$test_cleanup"
+		source ./test_vars || error "failed to load updated environment"
+	fi
+	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
+		echo ""
+	fi
+	return "$eval_ret"
+}
+
+
+test_perf () {
+	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
+	test "$#" = 2 ||
+	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
+	export test_prereq
+	if ! test_skip "$@"
+	then
+		base=$(basename "$0" .sh)
+		echo "$test_count" >>"$perf_results_dir"/$base.subtests
+		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
+		if test -z "$verbose"; then
+			echo -n "perf $test_count - $1:"
+		else
+			echo "perf $test_count - $1:"
+		fi
+		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
+			say >&3 "running: $2"
+			if test_run_perf_ "$2"
+			then
+				if test -z "$verbose"; then
+					echo -n " $i"
+				else
+					echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
+				fi
+			else
+				test -z "$verbose" && echo
+				test_failure_ "$@"
+				break
+			fi
+		done
+		if test -z "$verbose"; then
+			echo " ok"
+		else
+			test_ok_ "$1"
+		fi
+		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
+		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
+	fi
+	echo >&3 ""
+}
+
+# We extend test_done to print timings at the end (./run disables this
+# and does it after running everything)
+test_at_end_hook_ () {
+	if test -z "$GIT_PERF_AGGREGATING_LATER"; then
+		( cd "$TEST_DIRECTORY"/perf && ./aggregate.perl $(basename "$0") )
+	fi
+}
+
+test_export () {
+	export "$@"
+}
diff --git a/t/perf/run b/t/perf/run
new file mode 100755
index 0000000..cfd7012
--- /dev/null
+++ b/t/perf/run
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+case "$1" in
+	--help)
+		echo "usage: $0 [other_git_tree...] [--] [test_scripts]"
+		exit 0
+		;;
+esac
+
+die () {
+	echo >&2 "error: $*"
+	exit 1
+}
+
+run_one_dir () {
+	if test $# -eq 0; then
+		set -- p????-*.sh
+	fi
+	echo "=== Running $# tests in ${GIT_TEST_INSTALLED:-this tree} ==="
+	for t in "$@"; do
+		./$t $GIT_TEST_OPTS
+	done
+}
+
+unpack_git_rev () {
+	rev=$1
+	mkdir -p build/$rev
+	(cd "$(git rev-parse --show-cdup)" && git archive --format=tar $rev) |
+	(cd build/$rev && tar x)
+}
+build_git_rev () {
+	rev=$1
+	cp ../../config.mak build/$rev/config.mak
+	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
+	die "failed to build revision '$mydir'"
+}
+
+run_dirs_helper () {
+	mydir=${1%/}
+	shift
+	while test $# -gt 0 -a "$1" != -- -a ! -f "$1"; do
+		shift
+	done
+	if test $# -gt 0 -a "$1" = --; then
+		shift
+	fi
+	if [ ! -d "$mydir" ]; then
+		rev=$(git rev-parse --verify "$mydir" 2>/dev/null) ||
+		die "'$mydir' is neither a directory nor a valid revision"
+		if [ ! -d build/$rev ]; then
+			unpack_git_rev $rev
+		fi
+		build_git_rev $rev
+		mydir=build/$rev
+	fi
+	if test "$mydir" = .; then
+		unset GIT_TEST_INSTALLED
+	else
+		GIT_TEST_INSTALLED="$mydir/bin-wrappers"
+		export GIT_TEST_INSTALLED
+	fi
+	run_one_dir "$@"
+}
+
+run_dirs () {
+	while test $# -gt 0 -a "$1" != -- -a ! -f "$1"; do
+		run_dirs_helper "$@"
+		shift
+	done
+}
+
+GIT_PERF_AGGREGATING_LATER=t
+export GIT_PERF_AGGREGATING_LATER
+
+cd "$(dirname $0)"
+. ../../GIT-BUILD-OPTIONS
+
+if test $# = 0 -o "$1" = -- -o -f "$1"; then
+	set -- . "$@"
+fi
+run_dirs "$@"
+./aggregate.perl "$@"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1da3f40..d75766a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -55,6 +55,7 @@ unset $(perl -e '
 		.*_TEST
 		PROVE
 		VALGRIND
+		PERF_AGGREGATING_LATER
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
@@ -98,6 +99,8 @@ _z40=0000000000000000000000000000000000000000
 LF='
 '
 
+export _x05 _x40 _z40 LF
+
 # Each test should start with something like this, after copyright notices:
 #
 # test_description='Description of this test...
@@ -313,11 +316,16 @@ test_skip () {
 	esac
 }
 
+# stub; perf-lib overrides it
+test_at_end_hook_ () {
+	:
+}
+
 test_done () {
 	GIT_EXIT_OK=t
 
 	if test -z "$HARNESS_ACTIVE"; then
-		test_results_dir="$TEST_DIRECTORY/test-results"
+		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
 		mkdir -p "$test_results_dir"
 		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
 
@@ -356,6 +364,8 @@ test_done () {
 		cd "$(dirname "$remove_trash")" &&
 		rm -rf "$(basename "$remove_trash")"
 
+		test_at_end_hook_
+
 		exit 0 ;;
 
 	*)
@@ -378,6 +388,12 @@ then
 	# itself.
 	TEST_DIRECTORY=$(pwd)
 fi
+if test -z "$TEST_OUTPUT_DIRECTORY"
+then
+	# Similarly, override this to store the test-results subdir
+	# elsewhere
+	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
+fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
 if test -n "$valgrind"
@@ -513,7 +529,7 @@ test="trash directory.$(basename "$0" .sh)"
 test -n "$root" && test="$root/$test"
 case "$test" in
 /*) TRASH_DIRECTORY="$test" ;;
- *) TRASH_DIRECTORY="$TEST_DIRECTORY/$test" ;;
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$test" ;;
 esac
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
@@ -525,7 +541,11 @@ rm -fr "$test" || {
 HOME="$TRASH_DIRECTORY"
 export HOME
 
-test_create_repo "$test"
+if test -z "$TEST_NO_CREATE_REPO"; then
+	test_create_repo "$test"
+else
+	mkdir -p "$test"
+fi
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
-- 
1.7.9.1.365.ge223f
