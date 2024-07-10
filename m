Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7D8120F
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600680; cv=none; b=ic4D/Fht26xaOY7fcVrKsIczIip99Rjbm22VFbNVi5dcennRe9AqpTig4l+6YwdepAsIvng8ALD8Ebbh7zz837xC2kduTI0L7DJmMUatW2KGOlf7e1uQW8uj2Xw2GG1ohARnPLDvlSdNW87OkUxYGPBZ7CpfnKZl4y1xIbj+ZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600680; c=relaxed/simple;
	bh=HHXB+fJkJEQdUWeGYB3lqHVclw42D7o+3C5AKBGB7D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkuIp5lu92s+bdfWi81/A+a8rGgrksd9nf7btDREqp9BMMZhEW5CjVnth3faTsoOCwYGaQHdfzvpl+AzSnQ1SS/Ibt0HbzEL9K17DEacYe66hnoqM8FBqyZUzUMz/mc+FoS6xkUaGkNp1lEPMIPA3cvR9FKlIZfFj06C5P6+B70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1677 invoked by uid 109); 10 Jul 2024 08:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:37:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10446 invoked by uid 111); 10 Jul 2024 08:37:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:37:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:37:55 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 5/9] chainlint.pl: check line numbers in expected output
Message-ID: <20240710083755.GE2060601@coredump.intra.peff.net>
References: <20240710083416.GA2060328@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710083416.GA2060328@coredump.intra.peff.net>

While working on chainlint.pl recently, we introduced some bugs that
showed incorrect line numbers in the output. But it was hard to notice,
since we sanitize the output by removing all of the line numbers! It
would be nice to retain these so we can catch any regressions.

The main reason we sanitize is for maintainability: we concatenate all
of the test snippets into a single file, so it's hard for each ".expect"
file to know at which offset its test input will be found. We can handle
that by storing the per-test line numbers in the ".expect" files, and
then dynamically offsetting them as we build the concatenated test and
expect files together.

The changes to the ".expect" files look like tedious boilerplate, but it
actually makes adding new tests easier. You can now just run:

  perl chainlint.pl chainlint/foo.test |
  tail -n +2 >chainlint/foo.expect

to save the output of the script minus the comment headers (after
checking that it is correct, of course). Whereas before you had to strip
the line numbers. The conversions here were done mechanically using
something like the script above, and then spot-checked manually.

It would be possible to do all of this in shell via the Makefile, but it
gets a bit complicated (and requires a lot of extra processes). Instead,
I've written a short perl script that generates the concatenated files
(we already depend on perl, since chainlint.pl uses it). Incidentally,
this improves a few other things:

  - we incorrectly used $(CHAINLINTTMP_SQ) inside a double-quoted
    string. So if your test directory required quoting, like:

       make "TEST_OUTPUT_DIRECTORY=/tmp/h'orrible"

    we'd fail the chainlint tests.

  - the shell in the Makefile didn't handle &&-chaining correctly in its
    loops (though in practice the "sed" and "cat" invocations are not
    likely to fail).

  - likewise, the sed invocation to strip numbers was hiding the exit
    code of chainlint.pl itself. In practice this isn't a big deal;
    since there are linter violations in the test files, we expect it to
    exit non-zero. But we could later use exit codes to distinguish
    serious errors from expected ones.

  - we now use a constant number of processes, instead of scaling with
    the number of test scripts. So it should be a little faster (on my
    machine, "make check-chainlint" goes from 133ms to 73ms).

There are some alternatives to this approach, but I think this is still
a good intermediate step:

  1. We could invoke chainlint.pl individually on each test file, and
     compare it to the expected output (and possibly using "make" to
     avoid repeating already-done checks). This is a much bigger change
     (and we'd have to figure out what to do with the "# LINT" lines in
     the inputs). But in this case we'd still want the "expect" files to
     be annotated with line numbers. So most of what's in this patch
     would be needed anyway.

  2. Likewise, we could run a single chainlint.pl and feed it all of the
     scripts (with "--jobs=1" to get deterministic output). But we'd
     still need to annotate the scripts as we did here, and we'd still
     need to either assemble the "expect" file, or break apart the
     script output to compare to each individual ".expect" file.

So we may pursue those in the long run, but this patch gives us more
robust tests without too much extra work or moving in a useless
direction.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/Makefile                                    | 14 +----
 t/chainlint-cat.pl                            | 29 +++++++++
 t/chainlint/arithmetic-expansion.expect       | 18 +++---
 t/chainlint/bash-array.expect                 | 20 +++---
 t/chainlint/blank-line-before-esac.expect     | 36 +++++------
 t/chainlint/blank-line.expect                 | 16 ++---
 t/chainlint/block-comment.expect              | 16 ++---
 t/chainlint/block.expect                      | 46 +++++++-------
 t/chainlint/broken-chain.expect               | 12 ++--
 t/chainlint/case-comment.expect               | 22 +++----
 t/chainlint/case.expect                       | 38 ++++++------
 t/chainlint/chain-break-background.expect     | 18 +++---
 t/chainlint/chain-break-continue.expect       | 24 +++----
 t/chainlint/chain-break-false.expect          | 18 +++---
 t/chainlint/chain-break-return-exit.expect    | 38 ++++++------
 t/chainlint/chain-break-status.expect         | 18 +++---
 t/chainlint/chained-block.expect              | 18 +++---
 t/chainlint/chained-subshell.expect           | 20 +++---
 .../close-nested-and-parent-together.expect   |  6 +-
 t/chainlint/close-subshell.expect             | 52 ++++++++--------
 .../command-substitution-subsubshell.expect   |  4 +-
 t/chainlint/command-substitution.expect       | 18 +++---
 t/chainlint/comment.expect                    | 16 ++---
 t/chainlint/complex-if-in-cuddled-loop.expect | 18 +++---
 t/chainlint/cuddled-if-then-else.expect       | 12 ++--
 t/chainlint/cuddled-loop.expect               |  8 +--
 t/chainlint/cuddled.expect                    | 34 +++++-----
 t/chainlint/double-here-doc.expect            | 24 +++----
 t/chainlint/dqstring-line-splice.expect       | 10 +--
 t/chainlint/dqstring-no-interpolate.expect    | 24 +++----
 t/chainlint/empty-here-doc.expect             |  8 +--
 t/chainlint/exclamation.expect                |  8 +--
 t/chainlint/exit-loop.expect                  | 48 +++++++-------
 t/chainlint/exit-subshell.expect              | 10 +--
 t/chainlint/for-loop-abbreviated.expect       | 10 +--
 t/chainlint/for-loop.expect                   | 28 ++++-----
 t/chainlint/function.expect                   | 22 +++----
 t/chainlint/here-doc-close-subshell.expect    |  8 +--
 t/chainlint/here-doc-indent-operator.expect   | 22 +++----
 .../here-doc-multi-line-command-subst.expect  | 16 ++---
 t/chainlint/here-doc-multi-line-string.expect | 14 ++---
 t/chainlint/here-doc.expect                   | 50 +++++++--------
 t/chainlint/if-condition-split.expect         | 14 ++---
 t/chainlint/if-in-loop.expect                 | 24 +++----
 t/chainlint/if-then-else.expect               | 44 ++++++-------
 t/chainlint/incomplete-line.expect            | 20 +++---
 t/chainlint/inline-comment.expect             | 16 ++---
 t/chainlint/loop-detect-failure.expect        | 30 ++++-----
 t/chainlint/loop-detect-status.expect         | 36 +++++------
 t/chainlint/loop-in-if.expect                 | 24 +++----
 t/chainlint/loop-upstream-pipe.expect         | 20 +++---
 ...ti-line-nested-command-substitution.expect | 36 +++++------
 t/chainlint/multi-line-string.expect          | 28 ++++-----
 t/chainlint/negated-one-liner.expect          | 10 +--
 t/chainlint/nested-cuddled-subshell.expect    | 50 +++++++--------
 t/chainlint/nested-here-doc.expect            | 60 +++++++++---------
 t/chainlint/nested-loop-detect-failure.expect | 62 +++++++++----------
 t/chainlint/nested-subshell-comment.expect    | 22 +++----
 t/chainlint/nested-subshell.expect            | 26 ++++----
 t/chainlint/not-heredoc.expect                | 28 ++++-----
 t/chainlint/one-liner-for-loop.expect         | 18 +++---
 t/chainlint/one-liner.expect                  | 18 +++---
 t/chainlint/p4-filespec.expect                |  8 +--
 t/chainlint/pipe.expect                       | 20 +++---
 t/chainlint/return-loop.expect                | 10 +--
 t/chainlint/semicolon.expect                  | 38 ++++++------
 t/chainlint/sqstring-in-sqstring.expect       |  8 +--
 t/chainlint/subshell-here-doc.expect          | 60 +++++++++---------
 t/chainlint/subshell-one-liner.expect         | 38 ++++++------
 t/chainlint/t7900-subtree.expect              | 44 ++++++-------
 t/chainlint/token-pasting.expect              | 54 ++++++++--------
 t/chainlint/unclosed-here-doc-indent.expect   |  8 +--
 t/chainlint/unclosed-here-doc.expect          | 14 ++---
 t/chainlint/while-loop.expect                 | 28 ++++-----
 74 files changed, 913 insertions(+), 894 deletions(-)
 create mode 100644 t/chainlint-cat.pl

diff --git a/t/Makefile b/t/Makefile
index e7a476966e..4c30e7c06f 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -108,18 +108,8 @@ clean-chainlint:
 
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
-	for i in $(CHAINLINTTESTS); do \
-		sed -e '/^# LINT: /d' chainlint/$$i.test; \
-	done >'$(CHAINLINTTMP_SQ)'/tests && \
-	{ \
-		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
-		for i in $(CHAINLINTTESTS); do \
-			echo "# chainlint: $$i" && \
-			cat chainlint/$$i.expect; \
-		done \
-	} >'$(CHAINLINTTMP_SQ)'/expect && \
-	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
-		sed -e 's/^[1-9][0-9]* //' >'$(CHAINLINTTMP_SQ)'/actual && \
+	'$(PERL_PATH_SQ)' chainlint-cat.pl '$(CHAINLINTTMP_SQ)' $(CHAINLINTTESTS) && \
+	{ $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual || true; } && \
 	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
diff --git a/t/chainlint-cat.pl b/t/chainlint-cat.pl
new file mode 100644
index 0000000000..388f6e1e41
--- /dev/null
+++ b/t/chainlint-cat.pl
@@ -0,0 +1,29 @@
+#!/usr/bin/env perl
+
+my $outdir = shift;
+open(my $tests, '>', "$outdir/tests")
+	or die "unable to open $outdir/tests: $!";
+open(my $expect, '>', "$outdir/expect")
+	or die "unable to open $outdir/expect: $!";
+
+print $expect "# chainlint: $outdir/tests\n";
+
+my $offset = 0;
+for my $script (@ARGV) {
+	print $expect "# chainlint: $script\n";
+
+	open(my $expect_in, '<', "chainlint/$script.expect")
+		or die "unable to open chainlint/$script.expect: $!";
+	while (<$expect_in>) {
+		s/^\d+/$& + $offset/e;
+		print $expect $_;
+	}
+
+	open(my $test_in, '<', "chainlint/$script.test")
+		or die "unable to open chainlint/$script.test: $!";
+	while (<$test_in>) {
+		/^# LINT: / and next;
+		print $tests $_;
+		$offset++;
+	}
+}
diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
index 46ee1046af..338ecd5861 100644
--- a/t/chainlint/arithmetic-expansion.expect
+++ b/t/chainlint/arithmetic-expansion.expect
@@ -1,9 +1,9 @@
-(
-	foo &&
-	bar=$((42 + 1)) &&
-	baz
-) &&
-(
-	bar=$((42 + 1)) ?!AMP?!
-	baz
-)
+2 (
+3 	foo &&
+4 	bar=$((42 + 1)) &&
+5 	baz
+6 ) &&
+7 (
+8 	bar=$((42 + 1)) ?!AMP?!
+9 	baz
+10 )
diff --git a/t/chainlint/bash-array.expect b/t/chainlint/bash-array.expect
index 4c34eaee45..435dc8bdc8 100644
--- a/t/chainlint/bash-array.expect
+++ b/t/chainlint/bash-array.expect
@@ -1,10 +1,10 @@
-(
-	foo &&
-	bar=(gumbo stumbo wumbo) &&
-	baz
-) &&
-(
-	foo &&
-	bar=${#bar[@]} &&
-	baz
-)
+2 (
+3 	foo &&
+4 	bar=(gumbo stumbo wumbo) &&
+5 	baz
+6 ) &&
+7 (
+8 	foo &&
+9 	bar=${#bar[@]} &&
+10 	baz
+11 )
diff --git a/t/chainlint/blank-line-before-esac.expect b/t/chainlint/blank-line-before-esac.expect
index 056e03003d..b88ba919eb 100644
--- a/t/chainlint/blank-line-before-esac.expect
+++ b/t/chainlint/blank-line-before-esac.expect
@@ -1,18 +1,18 @@
-test_done () {
-	case "$test_failure" in
-	0)
-		test_at_end_hook_
-
-		exit 0 ;;
-
-	*)
-		if test $test_external_has_tap -eq 0
-		then
-			say_color error "# failed $test_failure among $msg"
-			say "1..$test_count"
-		fi
-
-		exit 1 ;;
-
-	esac
-}
+2 test_done () {
+3 	case "$test_failure" in
+4 	0)
+5 		test_at_end_hook_
+6 
+7 		exit 0 ;;
+8 
+9 	*)
+10 		if test $test_external_has_tap -eq 0
+11 		then
+12 			say_color error "# failed $test_failure among $msg"
+13 			say "1..$test_count"
+14 		fi
+15 
+16 		exit 1 ;;
+17 
+18 	esac
+19 }
diff --git a/t/chainlint/blank-line.expect b/t/chainlint/blank-line.expect
index b47827d749..6ae39dd174 100644
--- a/t/chainlint/blank-line.expect
+++ b/t/chainlint/blank-line.expect
@@ -1,8 +1,8 @@
-(
-
-	nothing &&
-
-	something
-
-
-)
+2 (
+3 
+4 	nothing &&
+5 
+6 	something
+7 
+8 
+9 )
diff --git a/t/chainlint/block-comment.expect b/t/chainlint/block-comment.expect
index df2beea888..7926936c18 100644
--- a/t/chainlint/block-comment.expect
+++ b/t/chainlint/block-comment.expect
@@ -1,8 +1,8 @@
-(
-	{
-		# show a
-		echo a &&
-		# show b
-		echo b
-	}
-)
+2 (
+3 	{
+4 		# show a
+5 		echo a &&
+6 		# show b
+7 		echo b
+8 	}
+9 )
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index 1c87326364..b62e3d58c3 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -1,23 +1,23 @@
-(
-	foo &&
-	{
-		echo a ?!AMP?!
-		echo b
-	} &&
-	bar &&
-	{
-		echo c
-	} ?!AMP?!
-	baz
-) &&
-
-{
-	echo a; ?!AMP?! echo b
-} &&
-{ echo a; ?!AMP?! echo b; } &&
-
-{
-	echo "${var}9" &&
-	echo "done"
-} &&
-finis
+2 (
+3 	foo &&
+4 	{
+5 		echo a ?!AMP?!
+6 		echo b
+7 	} &&
+8 	bar &&
+9 	{
+10 		echo c
+11 	} ?!AMP?!
+12 	baz
+13 ) &&
+14 
+15 {
+16 	echo a; ?!AMP?! echo b
+17 } &&
+18 { echo a; ?!AMP?! echo b; } &&
+19 
+20 {
+21 	echo "${var}9" &&
+22 	echo "done"
+23 } &&
+24 finis
diff --git a/t/chainlint/broken-chain.expect b/t/chainlint/broken-chain.expect
index cfb58fb6b9..9a1838736f 100644
--- a/t/chainlint/broken-chain.expect
+++ b/t/chainlint/broken-chain.expect
@@ -1,6 +1,6 @@
-(
-	foo &&
-	bar ?!AMP?!
-	baz &&
-	wop
-)
+2 (
+3 	foo &&
+4 	bar ?!AMP?!
+5 	baz &&
+6 	wop
+7 )
diff --git a/t/chainlint/case-comment.expect b/t/chainlint/case-comment.expect
index 641c157b98..2442dd5f25 100644
--- a/t/chainlint/case-comment.expect
+++ b/t/chainlint/case-comment.expect
@@ -1,11 +1,11 @@
-(
-	case "$x" in
-	# found foo
-	x) foo ;;
-	# found other
-	*)
-		# treat it as bar
-		bar
-		;;
-	esac
-)
+2 (
+3 	case "$x" in
+4 	# found foo
+5 	x) foo ;;
+6 	# found other
+7 	*)
+8 		# treat it as bar
+9 		bar
+10 		;;
+11 	esac
+12 )
diff --git a/t/chainlint/case.expect b/t/chainlint/case.expect
index 31f280d8ce..c04c61ff36 100644
--- a/t/chainlint/case.expect
+++ b/t/chainlint/case.expect
@@ -1,19 +1,19 @@
-(
-	case "$x" in
-	x) foo ;;
-	*) bar ;;
-	esac &&
-	foobar
-) &&
-(
-	case "$x" in
-	x) foo ;;
-	*) bar ;;
-	esac ?!AMP?!
-	foobar
-) &&
-(
-	case "$x" in 1) true;; esac &&
-	case "$y" in 2) false;; esac ?!AMP?!
-	foobar
-)
+2 (
+3 	case "$x" in
+4 	x) foo ;;
+5 	*) bar ;;
+6 	esac &&
+7 	foobar
+8 ) &&
+9 (
+10 	case "$x" in
+11 	x) foo ;;
+12 	*) bar ;;
+13 	esac ?!AMP?!
+14 	foobar
+15 ) &&
+16 (
+17 	case "$x" in 1) true;; esac &&
+18 	case "$y" in 2) false;; esac ?!AMP?!
+19 	foobar
+20 )
diff --git a/t/chainlint/chain-break-background.expect b/t/chainlint/chain-break-background.expect
index 20d0bb5333..d06deadae7 100644
--- a/t/chainlint/chain-break-background.expect
+++ b/t/chainlint/chain-break-background.expect
@@ -1,9 +1,9 @@
-JGIT_DAEMON_PID= &&
-git init --bare empty.git &&
->empty.git/git-daemon-export-ok &&
-mkfifo jgit_daemon_output &&
-{
-	jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
-	JGIT_DAEMON_PID=$!
-} &&
-test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+2 JGIT_DAEMON_PID= &&
+3 git init --bare empty.git &&
+4 >empty.git/git-daemon-export-ok &&
+5 mkfifo jgit_daemon_output &&
+6 {
+7 	jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
+8 	JGIT_DAEMON_PID=$!
+9 } &&
+10 test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
diff --git a/t/chainlint/chain-break-continue.expect b/t/chainlint/chain-break-continue.expect
index 47a3457710..4bb60aae25 100644
--- a/t/chainlint/chain-break-continue.expect
+++ b/t/chainlint/chain-break-continue.expect
@@ -1,12 +1,12 @@
-git ls-tree --name-only -r refs/notes/many_notes |
-while read path
-do
-	test "$path" = "foobar/non-note.txt" && continue
-	test "$path" = "deadbeef" && continue
-	test "$path" = "de/adbeef" && continue
-
-	if test $(expr length "$path") -ne $hexsz
-	then
-		return 1
-	fi
-done
+2 git ls-tree --name-only -r refs/notes/many_notes |
+3 while read path
+4 do
+5 	test "$path" = "foobar/non-note.txt" && continue
+6 	test "$path" = "deadbeef" && continue
+7 	test "$path" = "de/adbeef" && continue
+8 
+9 	if test $(expr length "$path") -ne $hexsz
+10 	then
+11 		return 1
+12 	fi
+13 done
diff --git a/t/chainlint/chain-break-false.expect b/t/chainlint/chain-break-false.expect
index 989766fb85..4f815f8e14 100644
--- a/t/chainlint/chain-break-false.expect
+++ b/t/chainlint/chain-break-false.expect
@@ -1,9 +1,9 @@
-if condition not satisified
-then
-	echo it did not work...
-	echo failed!
-	false
-else
-	echo it went okay ?!AMP?!
-	congratulate user
-fi
+2 if condition not satisified
+3 then
+4 	echo it did not work...
+5 	echo failed!
+6 	false
+7 else
+8 	echo it went okay ?!AMP?!
+9 	congratulate user
+10 fi
diff --git a/t/chainlint/chain-break-return-exit.expect b/t/chainlint/chain-break-return-exit.expect
index 4cd18e2edf..ba0ec51aa0 100644
--- a/t/chainlint/chain-break-return-exit.expect
+++ b/t/chainlint/chain-break-return-exit.expect
@@ -1,19 +1,19 @@
-case "$(git ls-files)" in
-one) echo pass one ;;
-*) echo bad one; return 1 ;;
-esac &&
-(
-	case "$(git ls-files)" in
-	two) echo pass two ;;
-	*) echo bad two; exit 1 ;;
-	esac
-) &&
-case "$(git ls-files)" in
-dir/two"$LF"one) echo pass both ;;
-*) echo bad; return 1 ;;
-esac &&
-
-for i in 1 2 3 4 ; do
-	git checkout main -b $i || return $?
-	test_commit $i $i $i tag$i || return $?
-done
+2 case "$(git ls-files)" in
+3 one) echo pass one ;;
+4 *) echo bad one; return 1 ;;
+5 esac &&
+6 (
+7 	case "$(git ls-files)" in
+8 	two) echo pass two ;;
+9 	*) echo bad two; exit 1 ;;
+10 	esac
+11 ) &&
+12 case "$(git ls-files)" in
+13 dir/two"$LF"one) echo pass both ;;
+14 *) echo bad; return 1 ;;
+15 esac &&
+16 
+17 for i in 1 2 3 4 ; do
+18 	git checkout main -b $i || return $?
+19 	test_commit $i $i $i tag$i || return $?
+20 done
diff --git a/t/chainlint/chain-break-status.expect b/t/chainlint/chain-break-status.expect
index e6b3b2193e..23c0caa7d8 100644
--- a/t/chainlint/chain-break-status.expect
+++ b/t/chainlint/chain-break-status.expect
@@ -1,9 +1,9 @@
-OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
-test_match_signal 13 "$OUT" &&
-
-{ test-tool sigchain >actual; ret=$?; } &&
-{
-	test_match_signal 15 "$ret" ||
-	test "$ret" = 3
-} &&
-test_cmp expect actual
+2 OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+3 test_match_signal 13 "$OUT" &&
+4 
+5 { test-tool sigchain >actual; ret=$?; } &&
+6 {
+7 	test_match_signal 15 "$ret" ||
+8 	test "$ret" = 3
+9 } &&
+10 test_cmp expect actual
diff --git a/t/chainlint/chained-block.expect b/t/chainlint/chained-block.expect
index 574cdceb07..a546b714a6 100644
--- a/t/chainlint/chained-block.expect
+++ b/t/chainlint/chained-block.expect
@@ -1,9 +1,9 @@
-echo nobody home && {
-	test the doohicky ?!AMP?!
-	right now
-} &&
-
-GIT_EXTERNAL_DIFF=echo git diff | {
-	read path oldfile oldhex oldmode newfile newhex newmode &&
-	test "z$oh" = "z$oldhex"
-}
+2 echo nobody home && {
+3 	test the doohicky ?!AMP?!
+4 	right now
+5 } &&
+6 
+7 GIT_EXTERNAL_DIFF=echo git diff | {
+8 	read path oldfile oldhex oldmode newfile newhex newmode &&
+9 	test "z$oh" = "z$oldhex"
+10 }
diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subshell.expect
index 83810ea7ec..f78b268291 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -1,10 +1,10 @@
-mkdir sub && (
-	cd sub &&
-	foo the bar ?!AMP?!
-	nuff said
-) &&
-
-cut "-d " -f actual | (read s1 s2 s3 &&
-test -f $s1 ?!AMP?!
-test $(cat $s2) = tree2path1 &&
-test $(cat $s3) = tree3path1)
+2 mkdir sub && (
+3 	cd sub &&
+4 	foo the bar ?!AMP?!
+5 	nuff said
+6 ) &&
+7 
+8 cut "-d " -f actual | (read s1 s2 s3 &&
+9 test -f $s1 ?!AMP?!
+10 test $(cat $s2) = tree2path1 &&
+11 test $(cat $s3) = tree3path1)
diff --git a/t/chainlint/close-nested-and-parent-together.expect b/t/chainlint/close-nested-and-parent-together.expect
index 72d482f76d..4167e54a59 100644
--- a/t/chainlint/close-nested-and-parent-together.expect
+++ b/t/chainlint/close-nested-and-parent-together.expect
@@ -1,3 +1,3 @@
-(cd foo &&
-	(bar &&
-		baz))
+2 (cd foo &&
+3 	(bar &&
+4 		baz))
diff --git a/t/chainlint/close-subshell.expect b/t/chainlint/close-subshell.expect
index 2192a2870a..a272cfe72e 100644
--- a/t/chainlint/close-subshell.expect
+++ b/t/chainlint/close-subshell.expect
@@ -1,26 +1,26 @@
-(
-	foo
-) &&
-(
-	bar
-) >out &&
-(
-	baz
-) 2>err &&
-(
-	boo
-) <input &&
-(
-	bip
-) | wuzzle &&
-(
-	bop
-) | fazz \
-	fozz &&
-(
-	bup
-) |
-fuzzle &&
-(
-	yop
-)
+2 (
+3 	foo
+4 ) &&
+5 (
+6 	bar
+7 ) >out &&
+8 (
+9 	baz
+10 ) 2>err &&
+11 (
+12 	boo
+13 ) <input &&
+14 (
+15 	bip
+16 ) | wuzzle &&
+17 (
+18 	bop
+19 ) | fazz \
+20 	fozz &&
+21 (
+22 	bup
+23 ) |
+24 fuzzle &&
+25 (
+26 	yop
+27 )
diff --git a/t/chainlint/command-substitution-subsubshell.expect b/t/chainlint/command-substitution-subsubshell.expect
index ec42f2c30c..f2a9312dc8 100644
--- a/t/chainlint/command-substitution-subsubshell.expect
+++ b/t/chainlint/command-substitution-subsubshell.expect
@@ -1,2 +1,2 @@
-OUT=$( ((large_git 1>&3) | :) 3>&1 ) &&
-test_match_signal 13 "$OUT"
+2 OUT=$( ((large_git 1>&3) | :) 3>&1 ) &&
+3 test_match_signal 13 "$OUT"
diff --git a/t/chainlint/command-substitution.expect b/t/chainlint/command-substitution.expect
index c72e4df9e7..5e31b36db6 100644
--- a/t/chainlint/command-substitution.expect
+++ b/t/chainlint/command-substitution.expect
@@ -1,9 +1,9 @@
-(
-	foo &&
-	bar=$(gobble) &&
-	baz
-) &&
-(
-	bar=$(gobble blocks) ?!AMP?!
-	baz
-)
+2 (
+3 	foo &&
+4 	bar=$(gobble) &&
+5 	baz
+6 ) &&
+7 (
+8 	bar=$(gobble blocks) ?!AMP?!
+9 	baz
+10 )
diff --git a/t/chainlint/comment.expect b/t/chainlint/comment.expect
index a68f1f9d7c..584098d6ba 100644
--- a/t/chainlint/comment.expect
+++ b/t/chainlint/comment.expect
@@ -1,8 +1,8 @@
-(
-	# comment 1
-	nothing &&
-	# comment 2
-	something
-	# comment 3
-	# comment 4
-)
+2 (
+3 	# comment 1
+4 	nothing &&
+5 	# comment 2
+6 	something
+7 	# comment 3
+8 	# comment 4
+9 )
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
index dac2d0fd1d..3a740103db 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.expect
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -1,9 +1,9 @@
-(for i in a b c; do
-   if test "$(echo $(waffle bat))" = "eleventeen" &&
-     test "$x" = "$y"; then
-     :
-   else
-     echo >file
-   fi ?!LOOP?!
- done) &&
-test ! -f file
+2 (for i in a b c; do
+3    if test "$(echo $(waffle bat))" = "eleventeen" &&
+4      test "$x" = "$y"; then
+5      :
+6    else
+7      echo >file
+8    fi ?!LOOP?!
+9  done) &&
+10 test ! -f file
diff --git a/t/chainlint/cuddled-if-then-else.expect b/t/chainlint/cuddled-if-then-else.expect
index 1d8ed58c49..72da8794cb 100644
--- a/t/chainlint/cuddled-if-then-else.expect
+++ b/t/chainlint/cuddled-if-then-else.expect
@@ -1,6 +1,6 @@
-(if test -z ""; then
-    echo empty
- else
-    echo bizzy
- fi) &&
-echo foobar
+2 (if test -z ""; then
+3     echo empty
+4  else
+5     echo bizzy
+6  fi) &&
+7 echo foobar
diff --git a/t/chainlint/cuddled-loop.expect b/t/chainlint/cuddled-loop.expect
index 9cf260708e..c38585c756 100644
--- a/t/chainlint/cuddled-loop.expect
+++ b/t/chainlint/cuddled-loop.expect
@@ -1,4 +1,4 @@
-( while read x
-  do foobar bop || exit 1
-  done <file ) &&
-outside subshell
+2 ( while read x
+3   do foobar bop || exit 1
+4   done <file ) &&
+5 outside subshell
diff --git a/t/chainlint/cuddled.expect b/t/chainlint/cuddled.expect
index c3e0be4047..b06d638311 100644
--- a/t/chainlint/cuddled.expect
+++ b/t/chainlint/cuddled.expect
@@ -1,17 +1,17 @@
-(cd foo &&
-	bar
-) &&
-
-(cd foo ?!AMP?!
-	bar
-) &&
-
-(
-	cd foo &&
-	bar) &&
-
-(cd foo &&
-	bar) &&
-
-(cd foo ?!AMP?!
-	bar)
+2 (cd foo &&
+3 	bar
+4 ) &&
+5 
+6 (cd foo ?!AMP?!
+7 	bar
+8 ) &&
+9 
+10 (
+11 	cd foo &&
+12 	bar) &&
+13 
+14 (cd foo &&
+15 	bar) &&
+16 
+17 (cd foo ?!AMP?!
+18 	bar)
diff --git a/t/chainlint/double-here-doc.expect b/t/chainlint/double-here-doc.expect
index cd584a4357..48c04ecd58 100644
--- a/t/chainlint/double-here-doc.expect
+++ b/t/chainlint/double-here-doc.expect
@@ -1,12 +1,12 @@
-run_sub_test_lib_test_err run-inv-range-start \
-	"--run invalid range start" \
-	--run="a-5" <<-\EOF &&
-test_expect_success "passing test #1" "true"
-test_done
-EOF
-check_sub_test_lib_test_err run-inv-range-start \
-	<<-\EOF_OUT 3<<-EOF_ERR
-> FATAL: Unexpected exit with code 1
-EOF_OUT
-> error: --run: invalid non-numeric in range start: ${SQ}a-5${SQ}
-EOF_ERR
+2 run_sub_test_lib_test_err run-inv-range-start \
+3 	"--run invalid range start" \
+4 	--run="a-5" <<-\EOF &&
+5 test_expect_success "passing test #1" "true"
+6 test_done
+7 EOF
+8 check_sub_test_lib_test_err run-inv-range-start \
+9 	<<-\EOF_OUT 3<<-EOF_ERR
+10 > FATAL: Unexpected exit with code 1
+11 EOF_OUT
+12 > error: --run: invalid non-numeric in range start: ${SQ}a-5${SQ}
+13 EOF_ERR
diff --git a/t/chainlint/dqstring-line-splice.expect b/t/chainlint/dqstring-line-splice.expect
index 37eab80738..2ca1c92cd6 100644
--- a/t/chainlint/dqstring-line-splice.expect
+++ b/t/chainlint/dqstring-line-splice.expect
@@ -1,5 +1,5 @@
-
-echo 'fatal: reword option of --fixup is mutually exclusive with'	'--patch/--interactive/--all/--include/--only' >expect &&
-test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
-test_cmp expect actual
-
+2 
+3 echo 'fatal: reword option of --fixup is mutually exclusive with'	'--patch/--interactive/--all/--include/--only' >expect &&
+4 test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
+5 test_cmp expect actual
+6 
diff --git a/t/chainlint/dqstring-no-interpolate.expect b/t/chainlint/dqstring-no-interpolate.expect
index 087eda15e4..c9f75849c5 100644
--- a/t/chainlint/dqstring-no-interpolate.expect
+++ b/t/chainlint/dqstring-no-interpolate.expect
@@ -1,12 +1,12 @@
-grep "^ ! [rejected][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" out &&
-
-grep "^\.git$" output.txt &&
-
-
-(
-	cd client$version &&
-	GIT_TEST_PROTOCOL_VERSION=$version git fetch-pack --no-progress .. $(cat ../input)
-) >output &&
-	cut -d ' ' -f 2 <output | sort >actual &&
-	test_cmp expect actual
-
+2 grep "^ ! [rejected][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" out &&
+3 
+4 grep "^\.git$" output.txt &&
+5 
+6 
+7 (
+8 	cd client$version &&
+9 	GIT_TEST_PROTOCOL_VERSION=$version git fetch-pack --no-progress .. $(cat ../input)
+10 ) >output &&
+11 	cut -d ' ' -f 2 <output | sort >actual &&
+12 	test_cmp expect actual
+13 
diff --git a/t/chainlint/empty-here-doc.expect b/t/chainlint/empty-here-doc.expect
index 8507721192..54b33f823a 100644
--- a/t/chainlint/empty-here-doc.expect
+++ b/t/chainlint/empty-here-doc.expect
@@ -1,4 +1,4 @@
-git ls-tree $tree path >current &&
-cat >expected <<\EOF &&
-EOF
-test_output
+2 git ls-tree $tree path >current &&
+3 cat >expected <<\EOF &&
+4 EOF
+5 test_output
diff --git a/t/chainlint/exclamation.expect b/t/chainlint/exclamation.expect
index 765a35bb4c..078744b61b 100644
--- a/t/chainlint/exclamation.expect
+++ b/t/chainlint/exclamation.expect
@@ -1,4 +1,4 @@
-if ! condition; then echo nope; else yep; fi &&
-test_prerequisite !MINGW &&
-mail uucp!address &&
-echo !whatever!
+2 if ! condition; then echo nope; else yep; fi &&
+3 test_prerequisite !MINGW &&
+4 mail uucp!address &&
+5 echo !whatever!
diff --git a/t/chainlint/exit-loop.expect b/t/chainlint/exit-loop.expect
index f76aa60466..407278094c 100644
--- a/t/chainlint/exit-loop.expect
+++ b/t/chainlint/exit-loop.expect
@@ -1,24 +1,24 @@
-(
-	for i in a b c
-	do
-		foo || exit 1
-		bar &&
-		baz
-	done
-) &&
-(
-	while true
-	do
-		foo || exit 1
-		bar &&
-		baz
-	done
-) &&
-(
-	i=0 &&
-	while test $i -lt 10
-	do
-		echo $i || exit
-		i=$(($i + 1))
-	done
-)
+2 (
+3 	for i in a b c
+4 	do
+5 		foo || exit 1
+6 		bar &&
+7 		baz
+8 	done
+9 ) &&
+10 (
+11 	while true
+12 	do
+13 		foo || exit 1
+14 		bar &&
+15 		baz
+16 	done
+17 ) &&
+18 (
+19 	i=0 &&
+20 	while test $i -lt 10
+21 	do
+22 		echo $i || exit
+23 		i=$(($i + 1))
+24 	done
+25 )
diff --git a/t/chainlint/exit-subshell.expect b/t/chainlint/exit-subshell.expect
index da80339f78..793db12453 100644
--- a/t/chainlint/exit-subshell.expect
+++ b/t/chainlint/exit-subshell.expect
@@ -1,5 +1,5 @@
-(
-	foo || exit 1
-	bar &&
-	baz
-)
+2 (
+3 	foo || exit 1
+4 	bar &&
+5 	baz
+6 )
diff --git a/t/chainlint/for-loop-abbreviated.expect b/t/chainlint/for-loop-abbreviated.expect
index 02c0d15cca..5574831976 100644
--- a/t/chainlint/for-loop-abbreviated.expect
+++ b/t/chainlint/for-loop-abbreviated.expect
@@ -1,5 +1,5 @@
-for it
-do
-	path=$(expr "$it" : ([^:]*)) &&
-	git update-index --add "$path" || exit
-done
+2 for it
+3 do
+4 	path=$(expr "$it" : ([^:]*)) &&
+5 	git update-index --add "$path" || exit
+6 done
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index d2237f1e38..908aeedf96 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -1,14 +1,14 @@
-(
-	for i in a b c
-	do
-		echo $i ?!AMP?!
-		cat <<-\EOF ?!LOOP?!
-		bar
-		EOF
-	done ?!AMP?!
-
-	for i in a b c; do
-		echo $i &&
-		cat $i ?!LOOP?!
-	done
-)
+2 (
+3 	for i in a b c
+4 	do
+5 		echo $i ?!AMP?!
+6 		cat <<-\EOF ?!LOOP?!
+7 		bar
+8 		EOF
+9 	done ?!AMP?!
+10 
+11 	for i in a b c; do
+12 		echo $i &&
+13 		cat $i ?!LOOP?!
+14 	done
+15 )
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
index dd7c997a3c..c226246b25 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -1,11 +1,11 @@
-sha1_file() {
-	echo "$*" | sed "s#..#.git/objects/&/#"
-} &&
-
-remove_object() {
-	file=$(sha1_file "$*") &&
-	test -e "$file" ?!AMP?!
-	rm -f "$file"
-} ?!AMP?!
-
-sha1_file arg && remove_object arg
+2 sha1_file() {
+3 	echo "$*" | sed "s#..#.git/objects/&/#"
+4 } &&
+5 
+6 remove_object() {
+7 	file=$(sha1_file "$*") &&
+8 	test -e "$file" ?!AMP?!
+9 	rm -f "$file"
+10 } ?!AMP?!
+11 
+12 sha1_file arg && remove_object arg
diff --git a/t/chainlint/here-doc-close-subshell.expect b/t/chainlint/here-doc-close-subshell.expect
index 7d9c2b5607..965813f463 100644
--- a/t/chainlint/here-doc-close-subshell.expect
+++ b/t/chainlint/here-doc-close-subshell.expect
@@ -1,4 +1,4 @@
-(
-	cat <<-\INPUT)
-	fizz
-	INPUT
+2 (
+3 	cat <<-\INPUT)
+4 	fizz
+5 	INPUT
diff --git a/t/chainlint/here-doc-indent-operator.expect b/t/chainlint/here-doc-indent-operator.expect
index f92a7ce999..277a11202d 100644
--- a/t/chainlint/here-doc-indent-operator.expect
+++ b/t/chainlint/here-doc-indent-operator.expect
@@ -1,11 +1,11 @@
-cat >expect <<- EOF &&
-header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
-num_commits: $1
-chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
-EOF
-
-cat >expect << -EOF ?!AMP?!
-this is not indented
--EOF
-
-cleanup
+2 cat >expect <<- EOF &&
+3 header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
+4 num_commits: $1
+5 chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
+6 EOF
+7 
+8 cat >expect << -EOF ?!AMP?!
+9 this is not indented
+10 -EOF
+11 
+12 cleanup
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index b7364c82c8..41b55f6437 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -1,8 +1,8 @@
-(
-	x=$(bobble <<-\END &&
-		fossil
-		vegetable
-		END
-		wiffle) ?!AMP?!
-	echo $x
-)
+2 (
+3 	x=$(bobble <<-\END &&
+4 		fossil
+5 		vegetable
+6 		END
+7 		wiffle) ?!AMP?!
+8 	echo $x
+9 )
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index 6c13bdcbfb..c71828589e 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,7 +1,7 @@
-(
-	cat <<-\TXT && echo "multi-line
-	string" ?!AMP?!
-	fizzle
-	TXT
-	bap
-)
+2 (
+3 	cat <<-\TXT && echo "multi-line
+4 	string" ?!AMP?!
+5 	fizzle
+6 	TXT
+7 	bap
+8 )
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 91b961242a..2c382dd8eb 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -1,25 +1,25 @@
-boodle wobba \
-       gorgo snoot \
-       wafta snurb <<EOF &&
-quoth the raven,
-nevermore...
-EOF
-
-cat <<-Arbitrary_Tag_42 >foo &&
-snoz
-boz
-woz
-Arbitrary_Tag_42
-
-cat <<"zump" >boo &&
-snoz
-boz
-woz
-zump
-
-horticulture <<\EOF
-gomez
-morticia
-wednesday
-pugsly
-EOF
+2 boodle wobba \
+3        gorgo snoot \
+4        wafta snurb <<EOF &&
+5 quoth the raven,
+6 nevermore...
+7 EOF
+8 
+9 cat <<-Arbitrary_Tag_42 >foo &&
+10 snoz
+11 boz
+12 woz
+13 Arbitrary_Tag_42
+14 
+15 cat <<"zump" >boo &&
+16 snoz
+17 boz
+18 woz
+19 zump
+20 
+21 horticulture <<\EOF
+22 gomez
+23 morticia
+24 wednesday
+25 pugsly
+26 EOF
diff --git a/t/chainlint/if-condition-split.expect b/t/chainlint/if-condition-split.expect
index ee745ef8d7..9daf3d294a 100644
--- a/t/chainlint/if-condition-split.expect
+++ b/t/chainlint/if-condition-split.expect
@@ -1,7 +1,7 @@
-if bob &&
-   marcia ||
-   kevin
-then
-	echo "nomads" ?!AMP?!
-	echo "for sure"
-fi
+2 if bob &&
+3    marcia ||
+4    kevin
+5 then
+6 	echo "nomads" ?!AMP?!
+7 	echo "for sure"
+8 fi
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
index d6514ae749..ff8c60dbdb 100644
--- a/t/chainlint/if-in-loop.expect
+++ b/t/chainlint/if-in-loop.expect
@@ -1,12 +1,12 @@
-(
-	for i in a b c
-	do
-		if false
-		then
-			echo "err"
-			exit 1
-		fi ?!AMP?!
-		foo
-	done ?!AMP?!
-	bar
-)
+2 (
+3 	for i in a b c
+4 	do
+5 		if false
+6 		then
+7 			echo "err"
+8 			exit 1
+9 		fi ?!AMP?!
+10 		foo
+11 	done ?!AMP?!
+12 	bar
+13 )
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index cbaaf857d4..965d7e41a2 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -1,22 +1,22 @@
-(
-	if test -n ""
-	then
-		echo very ?!AMP?!
-		echo empty
-	elif test -z ""
-	then
-		echo foo
-	else
-		echo foo &&
-		cat <<-\EOF
-		bar
-		EOF
-	fi ?!AMP?!
-	echo poodle
-) &&
-(
-	if test -n ""; then
-		echo very &&
-		echo empty
-	fi
-)
+2 (
+3 	if test -n ""
+4 	then
+5 		echo very ?!AMP?!
+6 		echo empty
+7 	elif test -z ""
+8 	then
+9 		echo foo
+10 	else
+11 		echo foo &&
+12 		cat <<-\EOF
+13 		bar
+14 		EOF
+15 	fi ?!AMP?!
+16 	echo poodle
+17 ) &&
+18 (
+19 	if test -n ""; then
+20 		echo very &&
+21 		echo empty
+22 	fi
+23 )
diff --git a/t/chainlint/incomplete-line.expect b/t/chainlint/incomplete-line.expect
index 134d3a14f5..b15e00b901 100644
--- a/t/chainlint/incomplete-line.expect
+++ b/t/chainlint/incomplete-line.expect
@@ -1,10 +1,10 @@
-line 1 \
-line 2 \
-line 3 \
-line 4 &&
-(
-	line 5 \
-	line 6 \
-	line 7 \
-	line 8
-)
+2 line 1 \
+3 line 2 \
+4 line 3 \
+5 line 4 &&
+6 (
+7 	line 5 \
+8 	line 6 \
+9 	line 7 \
+10 	line 8
+11 )
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
index 6bad218530..0285c0b22c 100644
--- a/t/chainlint/inline-comment.expect
+++ b/t/chainlint/inline-comment.expect
@@ -1,8 +1,8 @@
-(
-	foobar && # comment 1
-	barfoo ?!AMP?! # wrong position for &&
-	flibble "not a # comment"
-) &&
-
-(cd foo &&
-	flibble "not a # comment")
+2 (
+3 	foobar && # comment 1
+4 	barfoo ?!AMP?! # wrong position for &&
+5 	flibble "not a # comment"
+6 ) &&
+7 
+8 (cd foo &&
+9 	flibble "not a # comment")
diff --git a/t/chainlint/loop-detect-failure.expect b/t/chainlint/loop-detect-failure.expect
index a66025c39d..40c06f0d53 100644
--- a/t/chainlint/loop-detect-failure.expect
+++ b/t/chainlint/loop-detect-failure.expect
@@ -1,15 +1,15 @@
-git init r1 &&
-for n in 1 2 3 4 5
-do
-	echo "This is file: $n" > r1/file.$n &&
-	git -C r1 add file.$n &&
-	git -C r1 commit -m "$n" || return 1
-done &&
-
-git init r2 &&
-for n in 1000 10000
-do
-	printf "%"$n"s" X > r2/large.$n &&
-	git -C r2 add large.$n &&
-	git -C r2 commit -m "$n" ?!LOOP?!
-done
+2 git init r1 &&
+3 for n in 1 2 3 4 5
+4 do
+5 	echo "This is file: $n" > r1/file.$n &&
+6 	git -C r1 add file.$n &&
+7 	git -C r1 commit -m "$n" || return 1
+8 done &&
+9 
+10 git init r2 &&
+11 for n in 1000 10000
+12 do
+13 	printf "%"$n"s" X > r2/large.$n &&
+14 	git -C r2 add large.$n &&
+15 	git -C r2 commit -m "$n" ?!LOOP?!
+16 done
diff --git a/t/chainlint/loop-detect-status.expect b/t/chainlint/loop-detect-status.expect
index 7ce3a34806..0f180b08de 100644
--- a/t/chainlint/loop-detect-status.expect
+++ b/t/chainlint/loop-detect-status.expect
@@ -1,18 +1,18 @@
-(while test $i -le $blobcount
- do
-	printf "Generating blob $i/$blobcount\r" >&2 &&
-	printf "blob\nmark :$i\ndata $blobsize\n" &&
-	#test-tool genrandom $i $blobsize &&
-	printf "%-${blobsize}s" $i &&
-	echo "M 100644 :$i $i" >> commit &&
-	i=$(($i+1)) ||
-	echo $? > exit-status
- done &&
- echo "commit refs/heads/main" &&
- echo "author A U Thor <author@email.com> 123456789 +0000" &&
- echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
- echo "data 5" &&
- echo ">2gb" &&
- cat commit) |
-git fast-import --big-file-threshold=2 &&
-test ! -f exit-status
+2 (while test $i -le $blobcount
+3  do
+4 	printf "Generating blob $i/$blobcount\r" >&2 &&
+5 	printf "blob\nmark :$i\ndata $blobsize\n" &&
+6 	#test-tool genrandom $i $blobsize &&
+7 	printf "%-${blobsize}s" $i &&
+8 	echo "M 100644 :$i $i" >> commit &&
+9 	i=$(($i+1)) ||
+10 	echo $? > exit-status
+11  done &&
+12  echo "commit refs/heads/main" &&
+13  echo "author A U Thor <author@email.com> 123456789 +0000" &&
+14  echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
+15  echo "data 5" &&
+16  echo ">2gb" &&
+17  cat commit) |
+18 git fast-import --big-file-threshold=2 &&
+19 test ! -f exit-status
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
index 6c5d6e5b24..4e8c67c914 100644
--- a/t/chainlint/loop-in-if.expect
+++ b/t/chainlint/loop-in-if.expect
@@ -1,12 +1,12 @@
-(
-	if true
-	then
-		while true
-		do
-			echo "pop" ?!AMP?!
-			echo "glup" ?!LOOP?!
-		done ?!AMP?!
-		foo
-	fi ?!AMP?!
-	bar
-)
+2 (
+3 	if true
+4 	then
+5 		while true
+6 		do
+7 			echo "pop" ?!AMP?!
+8 			echo "glup" ?!LOOP?!
+9 		done ?!AMP?!
+10 		foo
+11 	fi ?!AMP?!
+12 	bar
+13 )
diff --git a/t/chainlint/loop-upstream-pipe.expect b/t/chainlint/loop-upstream-pipe.expect
index 0b82ecc4b9..bef82479ca 100644
--- a/t/chainlint/loop-upstream-pipe.expect
+++ b/t/chainlint/loop-upstream-pipe.expect
@@ -1,10 +1,10 @@
-(
-	git rev-list --objects --no-object-names base..loose |
-	while read oid
-	do
-		path="$objdir/$(test_oid_to_path "$oid")" &&
-		printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
-		echo "object list generation failed for $oid"
-	done |
-	sort -k1
-) >expect &&
+2 (
+3 	git rev-list --objects --no-object-names base..loose |
+4 	while read oid
+5 	do
+6 		path="$objdir/$(test_oid_to_path "$oid")" &&
+7 		printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
+8 		echo "object list generation failed for $oid"
+9 	done |
+10 	sort -k1
+11 ) >expect &&
diff --git a/t/chainlint/multi-line-nested-command-substitution.expect b/t/chainlint/multi-line-nested-command-substitution.expect
index 300058341b..ad27e43e05 100644
--- a/t/chainlint/multi-line-nested-command-substitution.expect
+++ b/t/chainlint/multi-line-nested-command-substitution.expect
@@ -1,18 +1,18 @@
-(
-	foo &&
-	x=$(
-		echo bar |
-		cat
-	) &&
-	echo ok
-) |
-sort &&
-(
-	bar &&
-	x=$(echo bar |
-		cat
-	) &&
-	y=$(echo baz |
-		fip) &&
-	echo fail
-)
+2 (
+3 	foo &&
+4 	x=$(
+5 		echo bar |
+6 		cat
+7 	) &&
+8 	echo ok
+9 ) |
+10 sort &&
+11 (
+12 	bar &&
+13 	x=$(echo bar |
+14 		cat
+15 	) &&
+16 	y=$(echo baz |
+17 		fip) &&
+18 	echo fail
+19 )
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index 27ff95218e..62c54e3a5e 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -1,14 +1,14 @@
-(
-	x="line 1
-		line 2
-		line 3" &&
-	y="line 1
-		line2" ?!AMP?!
-	foobar
-) &&
-(
-	echo "xyz" "abc
-		def
-		ghi" &&
-	barfoo
-)
+2 (
+3 	x="line 1
+4 		line 2
+5 		line 3" &&
+6 	y="line 1
+7 		line2" ?!AMP?!
+8 	foobar
+9 ) &&
+10 (
+11 	echo "xyz" "abc
+12 		def
+13 		ghi" &&
+14 	barfoo
+15 )
diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one-liner.expect
index ad4c2d949e..a6ce52a1da 100644
--- a/t/chainlint/negated-one-liner.expect
+++ b/t/chainlint/negated-one-liner.expect
@@ -1,5 +1,5 @@
-! (foo && bar) &&
-! (foo && bar) >baz &&
-
-! (foo; ?!AMP?! bar) &&
-! (foo; ?!AMP?! bar) >baz
+2 ! (foo && bar) &&
+3 ! (foo && bar) >baz &&
+4 
+5 ! (foo; ?!AMP?! bar) &&
+6 ! (foo; ?!AMP?! bar) >baz
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/nested-cuddled-subshell.expect
index 3836049cc4..0191c9c294 100644
--- a/t/chainlint/nested-cuddled-subshell.expect
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -1,25 +1,25 @@
-(
-	(cd foo &&
-		bar
-	) &&
-
-	(cd foo &&
-		bar
-	) ?!AMP?!
-
-	(
-		cd foo &&
-		bar) &&
-
-	(
-		cd foo &&
-		bar) ?!AMP?!
-
-	(cd foo &&
-		bar) &&
-
-	(cd foo &&
-		bar) ?!AMP?!
-
-	foobar
-)
+2 (
+3 	(cd foo &&
+4 		bar
+5 	) &&
+6 
+7 	(cd foo &&
+8 		bar
+9 	) ?!AMP?!
+10 
+11 	(
+12 		cd foo &&
+13 		bar) &&
+14 
+15 	(
+16 		cd foo &&
+17 		bar) ?!AMP?!
+18 
+19 	(cd foo &&
+20 		bar) &&
+21 
+22 	(cd foo &&
+23 		bar) ?!AMP?!
+24 
+25 	foobar
+26 )
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index 29b3832a98..70d9b68dc9 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -1,30 +1,30 @@
-cat <<ARBITRARY >foop &&
-naddle
-fub <<EOF
-	nozzle
-	noodle
-EOF
-formp
-ARBITRARY
-
-(
-	cat <<-\INPUT_END &&
-	fish are mice
-	but geese go slow
-	data <<EOF
-		perl is lerp
-		and nothing else
-	EOF
-	toink
-	INPUT_END
-
-	cat <<-\EOT ?!AMP?!
-	text goes here
-	data <<EOF
-		data goes here
-	EOF
-	more test here
-	EOT
-
-	foobar
-)
+2 cat <<ARBITRARY >foop &&
+3 naddle
+4 fub <<EOF
+5 	nozzle
+6 	noodle
+7 EOF
+8 formp
+9 ARBITRARY
+10 
+11 (
+12 	cat <<-\INPUT_END &&
+13 	fish are mice
+14 	but geese go slow
+15 	data <<EOF
+16 		perl is lerp
+17 		and nothing else
+18 	EOF
+19 	toink
+20 	INPUT_END
+21 
+22 	cat <<-\EOT ?!AMP?!
+23 	text goes here
+24 	data <<EOF
+25 		data goes here
+26 	EOF
+27 	more test here
+28 	EOT
+29 
+30 	foobar
+31 )
diff --git a/t/chainlint/nested-loop-detect-failure.expect b/t/chainlint/nested-loop-detect-failure.expect
index 3461df40e5..c13c4d2f90 100644
--- a/t/chainlint/nested-loop-detect-failure.expect
+++ b/t/chainlint/nested-loop-detect-failure.expect
@@ -1,31 +1,31 @@
-for i in 0 1 2 3 4 5 6 7 8 9;
-do
-	for j in 0 1 2 3 4 5 6 7 8 9;
-	do
-		echo "$i$j" >"path$i$j" ?!LOOP?!
-	done ?!LOOP?!
-done &&
-
-for i in 0 1 2 3 4 5 6 7 8 9;
-do
-	for j in 0 1 2 3 4 5 6 7 8 9;
-	do
-		echo "$i$j" >"path$i$j" || return 1
-	done
-done &&
-
-for i in 0 1 2 3 4 5 6 7 8 9;
-do
-	for j in 0 1 2 3 4 5 6 7 8 9;
-	do
-		echo "$i$j" >"path$i$j" ?!LOOP?!
-	done || return 1
-done &&
-
-for i in 0 1 2 3 4 5 6 7 8 9;
-do
-	for j in 0 1 2 3 4 5 6 7 8 9;
-	do
-		echo "$i$j" >"path$i$j" || return 1
-	done || return 1
-done
+2 for i in 0 1 2 3 4 5 6 7 8 9;
+3 do
+4 	for j in 0 1 2 3 4 5 6 7 8 9;
+5 	do
+6 		echo "$i$j" >"path$i$j" ?!LOOP?!
+7 	done ?!LOOP?!
+8 done &&
+9 
+10 for i in 0 1 2 3 4 5 6 7 8 9;
+11 do
+12 	for j in 0 1 2 3 4 5 6 7 8 9;
+13 	do
+14 		echo "$i$j" >"path$i$j" || return 1
+15 	done
+16 done &&
+17 
+18 for i in 0 1 2 3 4 5 6 7 8 9;
+19 do
+20 	for j in 0 1 2 3 4 5 6 7 8 9;
+21 	do
+22 		echo "$i$j" >"path$i$j" ?!LOOP?!
+23 	done || return 1
+24 done &&
+25 
+26 for i in 0 1 2 3 4 5 6 7 8 9;
+27 do
+28 	for j in 0 1 2 3 4 5 6 7 8 9;
+29 	do
+30 		echo "$i$j" >"path$i$j" || return 1
+31 	done || return 1
+32 done
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
index 9138cf386d..f89a8d03a8 100644
--- a/t/chainlint/nested-subshell-comment.expect
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -1,11 +1,11 @@
-(
-	foo &&
-	(
-		bar &&
-		# bottles wobble while fiddles gobble
-		# minor numbers of cows (or do they?)
-		baz &&
-		snaff
-	) ?!AMP?!
-	fuzzy
-)
+2 (
+3 	foo &&
+4 	(
+5 		bar &&
+6 		# bottles wobble while fiddles gobble
+7 		# minor numbers of cows (or do they?)
+8 		baz &&
+9 		snaff
+10 	) ?!AMP?!
+11 	fuzzy
+12 )
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshell.expect
index 73ff28546a..811e8a7912 100644
--- a/t/chainlint/nested-subshell.expect
+++ b/t/chainlint/nested-subshell.expect
@@ -1,13 +1,13 @@
-(
-	cd foo &&
-	(
-		echo a &&
-		echo b
-	) >file &&
-
-	cd foo &&
-	(
-		echo a ?!AMP?!
-		echo b
-	) >file
-)
+2 (
+3 	cd foo &&
+4 	(
+5 		echo a &&
+6 		echo b
+7 	) >file &&
+8 
+9 	cd foo &&
+10 	(
+11 		echo a ?!AMP?!
+12 		echo b
+13 	) >file
+14 )
diff --git a/t/chainlint/not-heredoc.expect b/t/chainlint/not-heredoc.expect
index 2e9bb135fe..611b7b75cb 100644
--- a/t/chainlint/not-heredoc.expect
+++ b/t/chainlint/not-heredoc.expect
@@ -1,14 +1,14 @@
-echo "<<<<<<< ours" &&
-echo ourside &&
-echo "=======" &&
-echo theirside &&
-echo ">>>>>>> theirs" &&
-
-(
-	echo "<<<<<<< ours" &&
-	echo ourside &&
-	echo "=======" &&
-	echo theirside &&
-	echo ">>>>>>> theirs" ?!AMP?!
-	poodle
-) >merged
+2 echo "<<<<<<< ours" &&
+3 echo ourside &&
+4 echo "=======" &&
+5 echo theirside &&
+6 echo ">>>>>>> theirs" &&
+7 
+8 (
+9 	echo "<<<<<<< ours" &&
+10 	echo ourside &&
+11 	echo "=======" &&
+12 	echo theirside &&
+13 	echo ">>>>>>> theirs" ?!AMP?!
+14 	poodle
+15 ) >merged
diff --git a/t/chainlint/one-liner-for-loop.expect b/t/chainlint/one-liner-for-loop.expect
index 51a3dc7c54..49dcf065ef 100644
--- a/t/chainlint/one-liner-for-loop.expect
+++ b/t/chainlint/one-liner-for-loop.expect
@@ -1,9 +1,9 @@
-git init dir-rename-and-content &&
-(
-	cd dir-rename-and-content &&
-	test_write_lines 1 2 3 4 5 >foo &&
-	mkdir olddir &&
-	for i in a b c; do echo $i >olddir/$i; ?!LOOP?! done ?!AMP?!
-	git add foo olddir &&
-	git commit -m "original" &&
-)
+2 git init dir-rename-and-content &&
+3 (
+4 	cd dir-rename-and-content &&
+5 	test_write_lines 1 2 3 4 5 >foo &&
+6 	mkdir olddir &&
+7 	for i in a b c; do echo $i >olddir/$i; ?!LOOP?! done ?!AMP?!
+8 	git add foo olddir &&
+9 	git commit -m "original" &&
+10 )
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index 57a7a444c1..9861811283 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -1,9 +1,9 @@
-(foo && bar) &&
-(foo && bar) |
-(foo && bar) >baz &&
-
-(foo; ?!AMP?! bar) &&
-(foo; ?!AMP?! bar) |
-(foo; ?!AMP?! bar) >baz &&
-
-(foo "bar; baz")
+2 (foo && bar) &&
+3 (foo && bar) |
+4 (foo && bar) >baz &&
+5 
+6 (foo; ?!AMP?! bar) &&
+7 (foo; ?!AMP?! bar) |
+8 (foo; ?!AMP?! bar) >baz &&
+9 
+10 (foo "bar; baz")
diff --git a/t/chainlint/p4-filespec.expect b/t/chainlint/p4-filespec.expect
index 1290fd1ff2..cff3e4e3d1 100644
--- a/t/chainlint/p4-filespec.expect
+++ b/t/chainlint/p4-filespec.expect
@@ -1,4 +1,4 @@
-(
-	p4 print -1 //depot/fiddle#42 >file &&
-	foobar
-)
+2 (
+3 	p4 print -1 //depot/fiddle#42 >file &&
+4 	foobar
+5 )
diff --git a/t/chainlint/pipe.expect b/t/chainlint/pipe.expect
index 811971b1a3..1bbe5a2ce1 100644
--- a/t/chainlint/pipe.expect
+++ b/t/chainlint/pipe.expect
@@ -1,10 +1,10 @@
-(
-	foo |
-	bar |
-	baz &&
-
-	fish |
-	cow ?!AMP?!
-
-	sunder
-)
+2 (
+3 	foo |
+4 	bar |
+5 	baz &&
+6 
+7 	fish |
+8 	cow ?!AMP?!
+9 
+10 	sunder
+11 )
diff --git a/t/chainlint/return-loop.expect b/t/chainlint/return-loop.expect
index cfc0549bef..da8f9abea3 100644
--- a/t/chainlint/return-loop.expect
+++ b/t/chainlint/return-loop.expect
@@ -1,5 +1,5 @@
-while test $i -lt $((num - 5))
-do
-	git notes add -m "notes for commit$i" HEAD~$i || return 1
-	i=$((i + 1))
-done
+2 while test $i -lt $((num - 5))
+3 do
+4 	git notes add -m "notes for commit$i" HEAD~$i || return 1
+5 	i=$((i + 1))
+6 done
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index 3aa2259f36..866438310c 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,19 +1,19 @@
-(
-	cat foo ; ?!AMP?! echo bar ?!AMP?!
-	cat foo ; ?!AMP?! echo bar
-) &&
-(
-	cat foo ; ?!AMP?! echo bar &&
-	cat foo ; ?!AMP?! echo bar
-) &&
-(
-	echo "foo; bar" &&
-	cat foo; ?!AMP?! echo bar
-) &&
-(
-	foo;
-) &&
-(cd foo &&
-	for i in a b c; do
-		echo; ?!LOOP?!
-	done)
+2 (
+3 	cat foo ; ?!AMP?! echo bar ?!AMP?!
+4 	cat foo ; ?!AMP?! echo bar
+5 ) &&
+6 (
+7 	cat foo ; ?!AMP?! echo bar &&
+8 	cat foo ; ?!AMP?! echo bar
+9 ) &&
+10 (
+11 	echo "foo; bar" &&
+12 	cat foo; ?!AMP?! echo bar
+13 ) &&
+14 (
+15 	foo;
+16 ) &&
+17 (cd foo &&
+18 	for i in a b c; do
+19 		echo; ?!LOOP?!
+20 	done)
diff --git a/t/chainlint/sqstring-in-sqstring.expect b/t/chainlint/sqstring-in-sqstring.expect
index cf0b591cf7..ba5d3c3a6d 100644
--- a/t/chainlint/sqstring-in-sqstring.expect
+++ b/t/chainlint/sqstring-in-sqstring.expect
@@ -1,4 +1,4 @@
-perl -e '
-	defined($_ = -s $_) or die for @ARGV;
-	exit 1 if $ARGV[0] <= $ARGV[1];
-' test-2-$packname_2.pack test-3-$packname_3.pack
+2 perl -e '
+3 	defined($_ = -s $_) or die for @ARGV;
+4 	exit 1 if $ARGV[0] <= $ARGV[1];
+5 ' test-2-$packname_2.pack test-3-$packname_3.pack
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 75d6f607e2..5647500c82 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -1,30 +1,30 @@
-(
-	echo wobba \
-	       gorgo snoot \
-	       wafta snurb <<-EOF &&
-	quoth the raven,
-	nevermore...
-	EOF
-
-	cat <<EOF >bip ?!AMP?!
-	fish fly high
-EOF
-
-	echo <<-\EOF >bop
-	gomez
-	morticia
-	wednesday
-	pugsly
-	EOF
-) &&
-(
-	cat <<-\ARBITRARY >bup &&
-	glink
-	FIZZ
-	ARBITRARY
-	cat <<-"ARBITRARY3" >bup3 &&
-	glink
-	FIZZ
-	ARBITRARY3
-	meep
-)
+2 (
+3 	echo wobba \
+4 	       gorgo snoot \
+5 	       wafta snurb <<-EOF &&
+6 	quoth the raven,
+7 	nevermore...
+8 	EOF
+9 
+10 	cat <<EOF >bip ?!AMP?!
+11 	fish fly high
+12 EOF
+13 
+14 	echo <<-\EOF >bop
+15 	gomez
+16 	morticia
+17 	wednesday
+18 	pugsly
+19 	EOF
+20 ) &&
+21 (
+22 	cat <<-\ARBITRARY >bup &&
+23 	glink
+24 	FIZZ
+25 	ARBITRARY
+26 	cat <<-"ARBITRARY3" >bup3 &&
+27 	glink
+28 	FIZZ
+29 	ARBITRARY3
+30 	meep
+31 )
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index 8f694990e8..214316c6a0 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -1,19 +1,19 @@
-(
-	(foo && bar) &&
-	(foo && bar) |
-	(foo && bar) >baz &&
-
-	(foo; ?!AMP?! bar) &&
-	(foo; ?!AMP?! bar) |
-	(foo; ?!AMP?! bar) >baz &&
-
-	(foo || exit 1) &&
-	(foo || exit 1) |
-	(foo || exit 1) >baz &&
-
-	(foo && bar) ?!AMP?!
-
-	(foo && bar; ?!AMP?! baz) ?!AMP?!
-
-	foobar
-)
+2 (
+3 	(foo && bar) &&
+4 	(foo && bar) |
+5 	(foo && bar) >baz &&
+6 
+7 	(foo; ?!AMP?! bar) &&
+8 	(foo; ?!AMP?! bar) |
+9 	(foo; ?!AMP?! bar) >baz &&
+10 
+11 	(foo || exit 1) &&
+12 	(foo || exit 1) |
+13 	(foo || exit 1) >baz &&
+14 
+15 	(foo && bar) ?!AMP?!
+16 
+17 	(foo && bar; ?!AMP?! baz) ?!AMP?!
+18 
+19 	foobar
+20 )
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
index 02f3129232..9e60338bcf 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -1,22 +1,22 @@
-(
-	chks="sub1
-sub2
-sub3
-sub4" &&
-	chks_sub=$(cat <<TXT | sed "s,^,sub dir/,"
-$chks
-TXT
-) &&
-	chkms="main-sub1
-main-sub2
-main-sub3
-main-sub4" &&
-	chkms_sub=$(cat <<TXT | sed "s,^,sub dir/,"
-$chkms
-TXT
-) &&
-
-	subfiles=$(git ls-files) &&
-	check_equal "$subfiles" "$chkms
-$chks"
-)
+2 (
+3 	chks="sub1
+4 sub2
+5 sub3
+6 sub4" &&
+7 	chks_sub=$(cat <<TXT | sed "s,^,sub dir/,"
+8 $chks
+9 TXT
+10 ) &&
+11 	chkms="main-sub1
+12 main-sub2
+13 main-sub3
+14 main-sub4" &&
+15 	chkms_sub=$(cat <<TXT | sed "s,^,sub dir/,"
+16 $chkms
+17 TXT
+18 ) &&
+19 
+20 	subfiles=$(git ls-files) &&
+21 	check_equal "$subfiles" "$chkms
+22 $chks"
+23 )
diff --git a/t/chainlint/token-pasting.expect b/t/chainlint/token-pasting.expect
index 6a387917a7..64f3235d26 100644
--- a/t/chainlint/token-pasting.expect
+++ b/t/chainlint/token-pasting.expect
@@ -1,27 +1,27 @@
-git config filter.rot13.smudge ./rot13.sh &&
-git config filter.rot13.clean ./rot13.sh &&
-
-{
-    echo "*.t filter=rot13" ?!AMP?!
-    echo "*.i ident"
-} >.gitattributes &&
-
-{
-    echo a b c d e f g h i j k l m ?!AMP?!
-    echo n o p q r s t u v w x y z ?!AMP?!
-    echo '$Id$'
-} >test &&
-cat test >test.t &&
-cat test >test.o &&
-cat test >test.i &&
-git add test test.t test.i &&
-rm -f test test.t test.i &&
-git checkout -- test test.t test.i &&
-
-echo "content-test2" >test2.o &&
-echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!AMP?!
-
-downstream_url_for_sed=$(
-	printf "%sn" "$downstream_url" |
-	sed -e 's/\/\\/g' -e 's/[[/.*^$]/\&/g'
-)
+2 git config filter.rot13.smudge ./rot13.sh &&
+3 git config filter.rot13.clean ./rot13.sh &&
+4 
+5 {
+6     echo "*.t filter=rot13" ?!AMP?!
+7     echo "*.i ident"
+8 } >.gitattributes &&
+9 
+10 {
+11     echo a b c d e f g h i j k l m ?!AMP?!
+12     echo n o p q r s t u v w x y z ?!AMP?!
+13     echo '$Id$'
+14 } >test &&
+15 cat test >test.t &&
+16 cat test >test.o &&
+17 cat test >test.i &&
+18 git add test test.t test.i &&
+19 rm -f test test.t test.i &&
+20 git checkout -- test test.t test.i &&
+21 
+22 echo "content-test2" >test2.o &&
+23 echo "content-test3 - filename with special characters" >"test3 'sq',$x=.o" ?!AMP?!
+24 
+25 downstream_url_for_sed=$(
+26 	printf "%sn" "$downstream_url" |
+27 	sed -e 's/\/\\/g' -e 's/[[/.*^$]/\&/g'
+28 )
diff --git a/t/chainlint/unclosed-here-doc-indent.expect b/t/chainlint/unclosed-here-doc-indent.expect
index 7c30a1a024..f78e23cb63 100644
--- a/t/chainlint/unclosed-here-doc-indent.expect
+++ b/t/chainlint/unclosed-here-doc-indent.expect
@@ -1,4 +1,4 @@
-command_which_is_run &&
-cat >expect <<-\EOF ?!UNCLOSED-HEREDOC?! &&
-we forget to end the here-doc
-command_which_is_gobbled
+2 command_which_is_run &&
+3 cat >expect <<-\EOF ?!UNCLOSED-HEREDOC?! &&
+4 we forget to end the here-doc
+5 command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.expect b/t/chainlint/unclosed-here-doc.expect
index d65e50f78d..51304672cf 100644
--- a/t/chainlint/unclosed-here-doc.expect
+++ b/t/chainlint/unclosed-here-doc.expect
@@ -1,7 +1,7 @@
-command_which_is_run &&
-cat >expect <<\EOF ?!UNCLOSED-HEREDOC?! &&
-	we try to end the here-doc below,
-	but the indentation throws us off
-	since the operator is not "<<-".
-	EOF
-command_which_is_gobbled
+2 command_which_is_run &&
+3 cat >expect <<\EOF ?!UNCLOSED-HEREDOC?! &&
+4 	we try to end the here-doc below,
+5 	but the indentation throws us off
+6 	since the operator is not "<<-".
+7 	EOF
+8 command_which_is_gobbled
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index 06c1567f48..5ffabd5a93 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -1,14 +1,14 @@
-(
-	while true
-	do
-		echo foo ?!AMP?!
-		cat <<-\EOF ?!LOOP?!
-		bar
-		EOF
-	done ?!AMP?!
-
-	while true; do
-		echo foo &&
-		cat bar ?!LOOP?!
-	done
-)
+2 (
+3 	while true
+4 	do
+5 		echo foo ?!AMP?!
+6 		cat <<-\EOF ?!LOOP?!
+7 		bar
+8 		EOF
+9 	done ?!AMP?!
+10 
+11 	while true; do
+12 		echo foo &&
+13 		cat bar ?!LOOP?!
+14 	done
+15 )
-- 
2.45.2.1249.gb036353db5

