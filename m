Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C67D3F5
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600492; cv=none; b=eUSP66R5C7enJSk10WbtMMN0zZa3A8gwbHP1InVycO5+tKtc9WinFP89je430YWfRAnQSEtEXLfZsJ/MSb4UHdiBBHfmL6T2ATuuXzoNeIZcatGKH3/ZGmh6KV2V3vXZQADKzUOYlBZh9SO0bNtLPdQZCrSN3gzoFG+14JyfVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600492; c=relaxed/simple;
	bh=bapUPVx9Ik3xZnpCyZs+g0sFUxHvnXPlqZVZvarjQVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ1v2D0pRXu9fzzqEgaygK8A2aPAZ3X7c4aSSMsIW/AoXgCgpaA8NtUCYnt0REZlrqyY2nTkoMUcEvhiQ9j0k415joJUQtE4pi5bwVS20S5tt3ZkVEPal7lE/hGCq6z8JuRlYPa2JMJm46hfOTui4O1RX0bv6rnK+Jz3em5pupU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1626 invoked by uid 109); 10 Jul 2024 08:34:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:34:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10386 invoked by uid 111); 10 Jul 2024 08:34:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:34:46 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:34:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 1/9] chainlint.pl: add test_expect_success call to test
 snippets
Message-ID: <20240710083448.GA2060601@coredump.intra.peff.net>
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

The chainlint tests are a series of individual files, each holding a
test body. The "make check-chainlint" target assembles them into a
single file, adding a "test_expect_success" function call around each.
Let's instead include that function call in the files themselves. This
is a little more boilerplate, but has several advantages:

  1. You can now run chainlint manually on snippets with just "perl
     chainlint.perl chainlint/foo.test". This can make developing and
     debugging a little easier.

  2. Many of the tests implicitly relied on the syntax of the lines
     added by the Makefile (in particular the use of single-quotes).
     This assumption is much easier to see when the single-quotes are
     alongside the test body.

  3. We had no way to test how the chainlint program handled
     various test_expect_success lines themselves. Now we'll be able to
     check variations.

The change to the .test files was done mechanically, using the same
test names they would have been assigned by the Makefile (this is
important to match the expected output). The Makefile has the minimal
change to drop the extra lines; there are more cleanups possible but a
future patch in this series will rewrite this substantially anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/Makefile                                              | 4 +---
 t/chainlint/arithmetic-expansion.test                   | 2 ++
 t/chainlint/bash-array.test                             | 2 ++
 t/chainlint/blank-line-before-esac.test                 | 2 ++
 t/chainlint/blank-line.test                             | 2 ++
 t/chainlint/block-comment.test                          | 2 ++
 t/chainlint/block.test                                  | 2 ++
 t/chainlint/broken-chain.test                           | 2 ++
 t/chainlint/case-comment.test                           | 2 ++
 t/chainlint/case.test                                   | 2 ++
 t/chainlint/chain-break-background.test                 | 2 ++
 t/chainlint/chain-break-continue.test                   | 2 ++
 t/chainlint/chain-break-false.test                      | 2 ++
 t/chainlint/chain-break-return-exit.test                | 2 ++
 t/chainlint/chain-break-status.test                     | 2 ++
 t/chainlint/chained-block.test                          | 2 ++
 t/chainlint/chained-subshell.test                       | 2 ++
 t/chainlint/close-nested-and-parent-together.test       | 2 ++
 t/chainlint/close-subshell.test                         | 2 ++
 t/chainlint/command-substitution-subsubshell.test       | 2 ++
 t/chainlint/command-substitution.test                   | 2 ++
 t/chainlint/comment.test                                | 2 ++
 t/chainlint/complex-if-in-cuddled-loop.test             | 2 ++
 t/chainlint/cuddled-if-then-else.test                   | 2 ++
 t/chainlint/cuddled-loop.test                           | 2 ++
 t/chainlint/cuddled.test                                | 2 ++
 t/chainlint/double-here-doc.test                        | 2 ++
 t/chainlint/dqstring-line-splice.test                   | 2 ++
 t/chainlint/dqstring-no-interpolate.test                | 2 ++
 t/chainlint/empty-here-doc.test                         | 2 ++
 t/chainlint/exclamation.test                            | 2 ++
 t/chainlint/exit-loop.test                              | 2 ++
 t/chainlint/exit-subshell.test                          | 2 ++
 t/chainlint/for-loop-abbreviated.test                   | 2 ++
 t/chainlint/for-loop.test                               | 2 ++
 t/chainlint/function.test                               | 2 ++
 t/chainlint/here-doc-close-subshell.test                | 2 ++
 t/chainlint/here-doc-indent-operator.test               | 2 ++
 t/chainlint/here-doc-multi-line-command-subst.test      | 2 ++
 t/chainlint/here-doc-multi-line-string.test             | 2 ++
 t/chainlint/here-doc.test                               | 2 ++
 t/chainlint/if-condition-split.test                     | 2 ++
 t/chainlint/if-in-loop.test                             | 2 ++
 t/chainlint/if-then-else.test                           | 2 ++
 t/chainlint/incomplete-line.test                        | 2 ++
 t/chainlint/inline-comment.test                         | 2 ++
 t/chainlint/loop-detect-failure.test                    | 2 ++
 t/chainlint/loop-detect-status.test                     | 2 ++
 t/chainlint/loop-in-if.test                             | 2 ++
 t/chainlint/loop-upstream-pipe.test                     | 2 ++
 t/chainlint/multi-line-nested-command-substitution.test | 2 ++
 t/chainlint/multi-line-string.test                      | 2 ++
 t/chainlint/negated-one-liner.test                      | 2 ++
 t/chainlint/nested-cuddled-subshell.test                | 2 ++
 t/chainlint/nested-here-doc.test                        | 2 ++
 t/chainlint/nested-loop-detect-failure.test             | 2 ++
 t/chainlint/nested-subshell-comment.test                | 2 ++
 t/chainlint/nested-subshell.test                        | 2 ++
 t/chainlint/not-heredoc.test                            | 2 ++
 t/chainlint/one-liner-for-loop.test                     | 2 ++
 t/chainlint/one-liner.test                              | 2 ++
 t/chainlint/p4-filespec.test                            | 2 ++
 t/chainlint/pipe.test                                   | 2 ++
 t/chainlint/return-loop.test                            | 2 ++
 t/chainlint/semicolon.test                              | 2 ++
 t/chainlint/sqstring-in-sqstring.test                   | 2 ++
 t/chainlint/subshell-here-doc.test                      | 2 ++
 t/chainlint/subshell-one-liner.test                     | 2 ++
 t/chainlint/t7900-subtree.test                          | 2 ++
 t/chainlint/token-pasting.test                          | 2 ++
 t/chainlint/unclosed-here-doc-indent.test               | 2 ++
 t/chainlint/unclosed-here-doc.test                      | 2 ++
 t/chainlint/while-loop.test                             | 2 ++
 73 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index b2eb9f770b..e7a476966e 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -109,9 +109,7 @@ clean-chainlint:
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
 	for i in $(CHAINLINTTESTS); do \
-		echo "test_expect_success '$$i' '" && \
-		sed -e '/^# LINT: /d' chainlint/$$i.test && \
-		echo "'"; \
+		sed -e '/^# LINT: /d' chainlint/$$i.test; \
 	done >'$(CHAINLINTTMP_SQ)'/tests && \
 	{ \
 		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
diff --git a/t/chainlint/arithmetic-expansion.test b/t/chainlint/arithmetic-expansion.test
index 16206960d8..7b4c5c9a41 100644
--- a/t/chainlint/arithmetic-expansion.test
+++ b/t/chainlint/arithmetic-expansion.test
@@ -1,3 +1,4 @@
+test_expect_success 'arithmetic-expansion' '
 (
 	foo &&
 # LINT: closing ")" of $((...)) not misinterpreted as subshell-closing ")"
@@ -9,3 +10,4 @@
 	bar=$((42 + 1))
 	baz
 )
+'
diff --git a/t/chainlint/bash-array.test b/t/chainlint/bash-array.test
index 92bbb777b8..4ca977d299 100644
--- a/t/chainlint/bash-array.test
+++ b/t/chainlint/bash-array.test
@@ -1,3 +1,4 @@
+test_expect_success 'bash-array' '
 (
 	foo &&
 # LINT: ")" in Bash array assignment not misinterpreted as subshell-closing ")"
@@ -10,3 +11,4 @@
 	bar=${#bar[@]} &&
 	baz
 )
+'
diff --git a/t/chainlint/blank-line-before-esac.test b/t/chainlint/blank-line-before-esac.test
index cecccad19f..51f02ea0c5 100644
--- a/t/chainlint/blank-line-before-esac.test
+++ b/t/chainlint/blank-line-before-esac.test
@@ -1,3 +1,4 @@
+test_expect_success 'blank-line-before-esac' '
 # LINT: blank line before "esac"
 test_done () {
 	case "$test_failure" in
@@ -17,3 +18,4 @@ test_done () {
 
 	esac
 }
+'
diff --git a/t/chainlint/blank-line.test b/t/chainlint/blank-line.test
index 0fdf15b3e1..6f29a491de 100644
--- a/t/chainlint/blank-line.test
+++ b/t/chainlint/blank-line.test
@@ -1,3 +1,4 @@
+test_expect_success 'blank-line' '
 (
 
 	nothing &&
@@ -8,3 +9,4 @@
 
 
 )
+'
diff --git a/t/chainlint/block-comment.test b/t/chainlint/block-comment.test
index df2beea888..934ef4113a 100644
--- a/t/chainlint/block-comment.test
+++ b/t/chainlint/block-comment.test
@@ -1,3 +1,4 @@
+test_expect_success 'block-comment' '
 (
 	{
 		# show a
@@ -6,3 +7,4 @@
 		echo b
 	}
 )
+'
diff --git a/t/chainlint/block.test b/t/chainlint/block.test
index 4ab69a4afc..a1b6b4dd32 100644
--- a/t/chainlint/block.test
+++ b/t/chainlint/block.test
@@ -1,3 +1,4 @@
+test_expect_success 'block' '
 (
 # LINT: missing "&&" after first "echo"
 	foo &&
@@ -25,3 +26,4 @@
 	echo "done"
 } &&
 finis
+'
diff --git a/t/chainlint/broken-chain.test b/t/chainlint/broken-chain.test
index 2a44aa73b7..1966499ef9 100644
--- a/t/chainlint/broken-chain.test
+++ b/t/chainlint/broken-chain.test
@@ -1,3 +1,4 @@
+test_expect_success 'broken-chain' '
 (
 	foo &&
 # LINT: missing "&&" from "bar"
@@ -6,3 +7,4 @@
 # LINT: final statement before closing ")" legitimately lacks "&&"
 	wop
 )
+'
diff --git a/t/chainlint/case-comment.test b/t/chainlint/case-comment.test
index 641c157b98..3f31ae9010 100644
--- a/t/chainlint/case-comment.test
+++ b/t/chainlint/case-comment.test
@@ -1,3 +1,4 @@
+test_expect_success 'case-comment' '
 (
 	case "$x" in
 	# found foo
@@ -9,3 +10,4 @@
 		;;
 	esac
 )
+'
diff --git a/t/chainlint/case.test b/t/chainlint/case.test
index 4cb086bf87..bea21fee4f 100644
--- a/t/chainlint/case.test
+++ b/t/chainlint/case.test
@@ -1,3 +1,4 @@
+test_expect_success 'case' '
 (
 # LINT: "...)" arms in "case" not misinterpreted as subshell-closing ")"
 	case "$x" in
@@ -21,3 +22,4 @@
 	case "$y" in 2) false;; esac
 	foobar
 )
+'
diff --git a/t/chainlint/chain-break-background.test b/t/chainlint/chain-break-background.test
index e10f656b05..c68e1b04d5 100644
--- a/t/chainlint/chain-break-background.test
+++ b/t/chainlint/chain-break-background.test
@@ -1,3 +1,4 @@
+test_expect_success 'chain-break-background' '
 JGIT_DAEMON_PID= &&
 git init --bare empty.git &&
 >empty.git/git-daemon-export-ok &&
@@ -8,3 +9,4 @@ mkfifo jgit_daemon_output &&
 	JGIT_DAEMON_PID=$!
 } &&
 test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+'
diff --git a/t/chainlint/chain-break-continue.test b/t/chainlint/chain-break-continue.test
index f0af71d8bd..de8119b204 100644
--- a/t/chainlint/chain-break-continue.test
+++ b/t/chainlint/chain-break-continue.test
@@ -1,3 +1,4 @@
+test_expect_success 'chain-break-continue' '
 git ls-tree --name-only -r refs/notes/many_notes |
 while read path
 do
@@ -11,3 +12,4 @@ do
 		return 1
 	fi
 done
+'
diff --git a/t/chainlint/chain-break-false.test b/t/chainlint/chain-break-false.test
index a5aaff8c8a..f78ad911fc 100644
--- a/t/chainlint/chain-break-false.test
+++ b/t/chainlint/chain-break-false.test
@@ -1,3 +1,4 @@
+test_expect_success 'chain-break-false' '
 # LINT: broken &&-chain okay if explicit "false" signals failure
 if condition not satisified
 then
@@ -8,3 +9,4 @@ else
 	echo it went okay
 	congratulate user
 fi
+'
diff --git a/t/chainlint/chain-break-return-exit.test b/t/chainlint/chain-break-return-exit.test
index 46542edf88..b6f519bb4d 100644
--- a/t/chainlint/chain-break-return-exit.test
+++ b/t/chainlint/chain-break-return-exit.test
@@ -1,3 +1,4 @@
+test_expect_success 'chain-break-return-exit' '
 case "$(git ls-files)" in
 one) echo pass one ;;
 # LINT: broken &&-chain okay if explicit "return 1" signals failuire
@@ -21,3 +22,4 @@ for i in 1 2 3 4 ; do
 	git checkout main -b $i || return $?
 	test_commit $i $i $i tag$i || return $?
 done
+'
diff --git a/t/chainlint/chain-break-status.test b/t/chainlint/chain-break-status.test
index a6602a7b99..d9fee190d9 100644
--- a/t/chainlint/chain-break-status.test
+++ b/t/chainlint/chain-break-status.test
@@ -1,3 +1,4 @@
+test_expect_success 'chain-break-status' '
 # LINT: broken &&-chain okay if next command handles "$?" explicitly
 OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
 test_match_signal 13 "$OUT" &&
@@ -9,3 +10,4 @@ test_match_signal 13 "$OUT" &&
 	test "$ret" = 3
 } &&
 test_cmp expect actual
+'
diff --git a/t/chainlint/chained-block.test b/t/chainlint/chained-block.test
index 86f81ece63..71ef1d0b7f 100644
--- a/t/chainlint/chained-block.test
+++ b/t/chainlint/chained-block.test
@@ -1,3 +1,4 @@
+test_expect_success 'chained-block' '
 # LINT: start of block chained to preceding command
 echo nobody home && {
 	test the doohicky
@@ -9,3 +10,4 @@ GIT_EXTERNAL_DIFF=echo git diff | {
 	read path oldfile oldhex oldmode newfile newhex newmode &&
 	test "z$oh" = "z$oldhex"
 }
+'
diff --git a/t/chainlint/chained-subshell.test b/t/chainlint/chained-subshell.test
index 4ff6ddd8cb..1f11f65398 100644
--- a/t/chainlint/chained-subshell.test
+++ b/t/chainlint/chained-subshell.test
@@ -1,3 +1,4 @@
+test_expect_success 'chained-subshell' '
 # LINT: start of subshell chained to preceding command
 mkdir sub && (
 	cd sub &&
@@ -11,3 +12,4 @@ test -f $s1
 test $(cat $s2) = tree2path1 &&
 # LINT: closing subshell ")" correctly detected on same line as "$(...)"
 test $(cat $s3) = tree3path1)
+'
diff --git a/t/chainlint/close-nested-and-parent-together.test b/t/chainlint/close-nested-and-parent-together.test
index 72d482f76d..56b28b186b 100644
--- a/t/chainlint/close-nested-and-parent-together.test
+++ b/t/chainlint/close-nested-and-parent-together.test
@@ -1,3 +1,5 @@
+test_expect_success 'close-nested-and-parent-together' '
 (cd foo &&
 	(bar &&
 		baz))
+'
diff --git a/t/chainlint/close-subshell.test b/t/chainlint/close-subshell.test
index 508ca447fd..b99f80569d 100644
--- a/t/chainlint/close-subshell.test
+++ b/t/chainlint/close-subshell.test
@@ -1,3 +1,4 @@
+test_expect_success 'close-subshell' '
 # LINT: closing ")" with various decorations ("&&", ">", "|", etc.)
 (
 	foo
@@ -25,3 +26,4 @@ fuzzle &&
 (
 	yop
 )
+'
diff --git a/t/chainlint/command-substitution-subsubshell.test b/t/chainlint/command-substitution-subsubshell.test
index 321de2951c..4ea772d60a 100644
--- a/t/chainlint/command-substitution-subsubshell.test
+++ b/t/chainlint/command-substitution-subsubshell.test
@@ -1,3 +1,5 @@
+test_expect_success 'command-substitution-subsubshell' '
 # LINT: subshell nested in subshell nested in command substitution
 OUT=$( ((large_git 1>&3) | :) 3>&1 ) &&
 test_match_signal 13 "$OUT"
+'
diff --git a/t/chainlint/command-substitution.test b/t/chainlint/command-substitution.test
index 3bbb002a4c..494d671e80 100644
--- a/t/chainlint/command-substitution.test
+++ b/t/chainlint/command-substitution.test
@@ -1,3 +1,4 @@
+test_expect_success 'command-substitution' '
 (
 	foo &&
 # LINT: closing ")" of $(...) not misinterpreted as subshell-closing ")"
@@ -9,3 +10,4 @@
 	bar=$(gobble blocks)
 	baz
 )
+'
diff --git a/t/chainlint/comment.test b/t/chainlint/comment.test
index 113c0c466f..c488beac0d 100644
--- a/t/chainlint/comment.test
+++ b/t/chainlint/comment.test
@@ -1,3 +1,4 @@
+test_expect_success 'comment' '
 (
 # LINT: swallow comment lines
 	# comment 1
@@ -9,3 +10,4 @@
 	# comment 3
 	# comment 4
 )
+'
diff --git a/t/chainlint/complex-if-in-cuddled-loop.test b/t/chainlint/complex-if-in-cuddled-loop.test
index 5efeda58b2..f98ae4c42d 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.test
+++ b/t/chainlint/complex-if-in-cuddled-loop.test
@@ -1,3 +1,4 @@
+test_expect_success 'complex-if-in-cuddled-loop' '
 # LINT: "for" loop cuddled with "(" and ")" and nested "if" with complex
 # LINT: multi-line condition; indented with spaces, not tabs
 (for i in a b c; do
@@ -9,3 +10,4 @@
    fi
  done) &&
 test ! -f file
+'
diff --git a/t/chainlint/cuddled-if-then-else.test b/t/chainlint/cuddled-if-then-else.test
index 7c53f4efe3..b1b42e1aac 100644
--- a/t/chainlint/cuddled-if-then-else.test
+++ b/t/chainlint/cuddled-if-then-else.test
@@ -1,7 +1,9 @@
+test_expect_success 'cuddled-if-then-else' '
 # LINT: "if" cuddled with "(" and ")"; indented with spaces, not tabs
 (if test -z ""; then
     echo empty
  else
     echo bizzy
  fi) &&
 echo foobar
+'
diff --git a/t/chainlint/cuddled-loop.test b/t/chainlint/cuddled-loop.test
index 3c2a62f751..6fccb6ac22 100644
--- a/t/chainlint/cuddled-loop.test
+++ b/t/chainlint/cuddled-loop.test
@@ -1,7 +1,9 @@
+test_expect_success 'cuddled-loop' '
 # LINT: "while" loop cuddled with "(" and ")", with embedded (allowed)
 # LINT: "|| exit {n}" to exit loop early, and using redirection "<" to feed
 # LINT: loop; indented with spaces, not tabs
 ( while read x
   do foobar bop || exit 1
   done <file ) &&
 outside subshell
+'
diff --git a/t/chainlint/cuddled.test b/t/chainlint/cuddled.test
index 257b5b5eed..5a6ef7a4a6 100644
--- a/t/chainlint/cuddled.test
+++ b/t/chainlint/cuddled.test
@@ -1,3 +1,4 @@
+test_expect_success 'cuddled' '
 # LINT: first subshell statement cuddled with opening "("
 (cd foo &&
 	bar
@@ -20,3 +21,4 @@
 # LINT: same with missing "&&"
 (cd foo
 	bar)
+'
diff --git a/t/chainlint/double-here-doc.test b/t/chainlint/double-here-doc.test
index cd584a4357..1b69b7a651 100644
--- a/t/chainlint/double-here-doc.test
+++ b/t/chainlint/double-here-doc.test
@@ -1,3 +1,4 @@
+test_expect_success 'double-here-doc' '
 run_sub_test_lib_test_err run-inv-range-start \
 	"--run invalid range start" \
 	--run="a-5" <<-\EOF &&
@@ -10,3 +11,4 @@ check_sub_test_lib_test_err run-inv-range-start \
 EOF_OUT
 > error: --run: invalid non-numeric in range start: ${SQ}a-5${SQ}
 EOF_ERR
+'
diff --git a/t/chainlint/dqstring-line-splice.test b/t/chainlint/dqstring-line-splice.test
index b40714439f..f6aa637be8 100644
--- a/t/chainlint/dqstring-line-splice.test
+++ b/t/chainlint/dqstring-line-splice.test
@@ -1,7 +1,9 @@
+test_expect_success 'dqstring-line-splice' '
 # LINT: line-splice within DQ-string
 '"
 echo 'fatal: reword option of --fixup is mutually exclusive with'\
 	'--patch/--interactive/--all/--include/--only' >expect &&
 test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
 test_cmp expect actual
 "'
+'
diff --git a/t/chainlint/dqstring-no-interpolate.test b/t/chainlint/dqstring-no-interpolate.test
index d2f4219cbb..7ae079b558 100644
--- a/t/chainlint/dqstring-no-interpolate.test
+++ b/t/chainlint/dqstring-no-interpolate.test
@@ -1,3 +1,4 @@
+test_expect_success 'dqstring-no-interpolate' '
 # LINT: regex dollar-sign eol anchor in double-quoted string not special
 grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" out &&
 
@@ -13,3 +14,4 @@ grep "^\\.git\$" output.txt &&
 	cut -d ' ' -f 2 <output | sort >actual &&
 	test_cmp expect actual
 "'
+'
diff --git a/t/chainlint/empty-here-doc.test b/t/chainlint/empty-here-doc.test
index 24fc165de3..8b7ab6eb5f 100644
--- a/t/chainlint/empty-here-doc.test
+++ b/t/chainlint/empty-here-doc.test
@@ -1,5 +1,7 @@
+test_expect_success 'empty-here-doc' '
 git ls-tree $tree path >current &&
 # LINT: empty here-doc
 cat >expected <<\EOF &&
 EOF
 test_output
+'
diff --git a/t/chainlint/exclamation.test b/t/chainlint/exclamation.test
index 323595b5bd..796de21b7c 100644
--- a/t/chainlint/exclamation.test
+++ b/t/chainlint/exclamation.test
@@ -1,3 +1,4 @@
+test_expect_success 'exclamation' '
 # LINT: "! word" is two tokens
 if ! condition; then echo nope; else yep; fi &&
 # LINT: "!word" is single token, not two tokens "!" and "word"
@@ -6,3 +7,4 @@ test_prerequisite !MINGW &&
 mail uucp!address &&
 # LINT: "!word!" is single token, not three tokens "!", "word", and "!"
 echo !whatever!
+'
diff --git a/t/chainlint/exit-loop.test b/t/chainlint/exit-loop.test
index 2f038207e1..7e8b68b465 100644
--- a/t/chainlint/exit-loop.test
+++ b/t/chainlint/exit-loop.test
@@ -1,3 +1,4 @@
+test_expect_success 'exit-loop' '
 (
 	for i in a b c
 	do
@@ -25,3 +26,4 @@
 		i=$(($i + 1))
 	done
 )
+'
diff --git a/t/chainlint/exit-subshell.test b/t/chainlint/exit-subshell.test
index 4e6ab69b88..05dff55cd7 100644
--- a/t/chainlint/exit-subshell.test
+++ b/t/chainlint/exit-subshell.test
@@ -1,6 +1,8 @@
+test_expect_success 'exit-subshell' '
 (
 # LINT: "|| exit {n}" valid subshell escape without hurting &&-chain
 	foo || exit 1
 	bar &&
 	baz
 )
+'
diff --git a/t/chainlint/for-loop-abbreviated.test b/t/chainlint/for-loop-abbreviated.test
index 1084eccb89..1dd14f2a44 100644
--- a/t/chainlint/for-loop-abbreviated.test
+++ b/t/chainlint/for-loop-abbreviated.test
@@ -1,6 +1,8 @@
+test_expect_success 'for-loop-abbreviated' '
 # LINT: for-loop lacking optional "in [word...]" before "do"
 for it
 do
 	path=$(expr "$it" : '\([^:]*\)') &&
 	git update-index --add "$path" || exit
 done
+'
diff --git a/t/chainlint/for-loop.test b/t/chainlint/for-loop.test
index 6cb3428158..6f2489eb19 100644
--- a/t/chainlint/for-loop.test
+++ b/t/chainlint/for-loop.test
@@ -1,3 +1,4 @@
+test_expect_success 'for-loop' '
 (
 # LINT: "for", "do", "done" do not need "&&"
 	for i in a b c
@@ -17,3 +18,4 @@
 		cat $i
 	done
 )
+'
diff --git a/t/chainlint/function.test b/t/chainlint/function.test
index 5ee59562c9..763fcf3f87 100644
--- a/t/chainlint/function.test
+++ b/t/chainlint/function.test
@@ -1,3 +1,4 @@
+test_expect_success 'function' '
 # LINT: "()" in function definition not mistaken for subshell
 sha1_file() {
 	echo "$*" | sed "s#..#.git/objects/&/#"
@@ -11,3 +12,4 @@ remove_object() {
 }
 
 sha1_file arg && remove_object arg
+'
diff --git a/t/chainlint/here-doc-close-subshell.test b/t/chainlint/here-doc-close-subshell.test
index b857ff5467..2458f3323b 100644
--- a/t/chainlint/here-doc-close-subshell.test
+++ b/t/chainlint/here-doc-close-subshell.test
@@ -1,5 +1,7 @@
+test_expect_success 'here-doc-close-subshell' '
 (
 # LINT: line contains here-doc and closes nested subshell
 	cat <<-\INPUT)
 	fizz
 	INPUT
+'
diff --git a/t/chainlint/here-doc-indent-operator.test b/t/chainlint/here-doc-indent-operator.test
index c8a6f18eb4..a2656f47c1 100644
--- a/t/chainlint/here-doc-indent-operator.test
+++ b/t/chainlint/here-doc-indent-operator.test
@@ -1,3 +1,4 @@
+test_expect_success 'here-doc-indent-operator' '
 # LINT: whitespace between operator "<<-" and tag legal
 cat >expect <<- EOF &&
 header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
@@ -11,3 +12,4 @@ this is not indented
 -EOF
 
 cleanup
+'
diff --git a/t/chainlint/here-doc-multi-line-command-subst.test b/t/chainlint/here-doc-multi-line-command-subst.test
index 899bc5de8b..8710a8c483 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.test
+++ b/t/chainlint/here-doc-multi-line-command-subst.test
@@ -1,3 +1,4 @@
+test_expect_success 'here-doc-multi-line-command-subst' '
 (
 # LINT: line contains here-doc and opens multi-line $(...)
 	x=$(bobble <<-\END &&
@@ -7,3 +8,4 @@
 		wiffle)
 	echo $x
 )
+'
diff --git a/t/chainlint/here-doc-multi-line-string.test b/t/chainlint/here-doc-multi-line-string.test
index a53edbcc8d..2f496002fd 100644
--- a/t/chainlint/here-doc-multi-line-string.test
+++ b/t/chainlint/here-doc-multi-line-string.test
@@ -1,3 +1,4 @@
+test_expect_success 'here-doc-multi-line-string' '
 (
 # LINT: line contains here-doc and opens multi-line string
 	cat <<-\TXT && echo "multi-line
@@ -6,3 +7,4 @@
 	TXT
 	bap
 )
+'
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index 3f5f92cad3..c91b695319 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -1,3 +1,4 @@
+test_expect_success 'here-doc' '
 # LINT: stitch together incomplete \-ending lines
 # LINT: swallow here-doc to avoid false positives in content
 boodle wobba \
@@ -28,3 +29,4 @@ morticia
 wednesday
 pugsly
 EOF
+'
diff --git a/t/chainlint/if-condition-split.test b/t/chainlint/if-condition-split.test
index 240daa9fd5..9a3b3ed04a 100644
--- a/t/chainlint/if-condition-split.test
+++ b/t/chainlint/if-condition-split.test
@@ -1,3 +1,4 @@
+test_expect_success 'if-condition-split' '
 # LINT: "if" condition split across multiple lines at "&&" or "||"
 if bob &&
    marcia ||
@@ -6,3 +7,4 @@ then
 	echo "nomads"
 	echo "for sure"
 fi
+'
diff --git a/t/chainlint/if-in-loop.test b/t/chainlint/if-in-loop.test
index 90c23976fe..5be9d1cfa5 100644
--- a/t/chainlint/if-in-loop.test
+++ b/t/chainlint/if-in-loop.test
@@ -1,3 +1,4 @@
+test_expect_success 'if-in-loop' '
 (
 	for i in a b c
 	do
@@ -13,3 +14,4 @@
 	done
 	bar
 )
+'
diff --git a/t/chainlint/if-then-else.test b/t/chainlint/if-then-else.test
index 2055336c2b..6582a7f440 100644
--- a/t/chainlint/if-then-else.test
+++ b/t/chainlint/if-then-else.test
@@ -1,3 +1,4 @@
+test_expect_success 'if-then-else' '
 (
 # LINT: "if", "then", "elif", "else", "fi" do not need "&&"
 	if test -n ""
@@ -27,3 +28,4 @@
 		echo empty
 	fi
 )
+'
diff --git a/t/chainlint/incomplete-line.test b/t/chainlint/incomplete-line.test
index d856658083..74a93021eb 100644
--- a/t/chainlint/incomplete-line.test
+++ b/t/chainlint/incomplete-line.test
@@ -1,3 +1,4 @@
+test_expect_success 'incomplete-line' '
 # LINT: stitch together all incomplete \-ending lines
 line 1 \
 line 2 \
@@ -10,3 +11,4 @@ line 4 &&
 	line 7 \
 	line 8
 )
+'
diff --git a/t/chainlint/inline-comment.test b/t/chainlint/inline-comment.test
index 8f26856e77..4fbbf1058a 100644
--- a/t/chainlint/inline-comment.test
+++ b/t/chainlint/inline-comment.test
@@ -1,3 +1,4 @@
+test_expect_success 'inline-comment' '
 (
 # LINT: swallow inline comment (leaving command intact)
 	foobar && # comment 1
@@ -10,3 +11,4 @@
 # LINT: "#" in string in cuddled subshell not misinterpreted as comment
 (cd foo &&
 	flibble "not a # comment")
+'
diff --git a/t/chainlint/loop-detect-failure.test b/t/chainlint/loop-detect-failure.test
index b9791cc802..44673aa394 100644
--- a/t/chainlint/loop-detect-failure.test
+++ b/t/chainlint/loop-detect-failure.test
@@ -1,3 +1,4 @@
+test_expect_success 'loop-detect-failure' '
 git init r1 &&
 # LINT: loop handles failure explicitly with "|| return 1"
 for n in 1 2 3 4 5
@@ -15,3 +16,4 @@ do
 	git -C r2 add large.$n &&
 	git -C r2 commit -m "$n"
 done
+'
diff --git a/t/chainlint/loop-detect-status.test b/t/chainlint/loop-detect-status.test
index 1c6c23cfc9..8b639be073 100644
--- a/t/chainlint/loop-detect-status.test
+++ b/t/chainlint/loop-detect-status.test
@@ -1,3 +1,4 @@
+test_expect_success 'loop-detect-status' '
 # LINT: "$?" handled explicitly within loop body
 (while test $i -le $blobcount
  do
@@ -17,3 +18,4 @@
  cat commit) |
 git fast-import --big-file-threshold=2 &&
 test ! -f exit-status
+'
diff --git a/t/chainlint/loop-in-if.test b/t/chainlint/loop-in-if.test
index dfcc3f98fb..b0d0d393cf 100644
--- a/t/chainlint/loop-in-if.test
+++ b/t/chainlint/loop-in-if.test
@@ -1,3 +1,4 @@
+test_expect_success 'loop-in-if' '
 (
 	if true
 	then
@@ -13,3 +14,4 @@
 	fi
 	bar
 )
+'
diff --git a/t/chainlint/loop-upstream-pipe.test b/t/chainlint/loop-upstream-pipe.test
index efb77da897..8415a4db27 100644
--- a/t/chainlint/loop-upstream-pipe.test
+++ b/t/chainlint/loop-upstream-pipe.test
@@ -1,3 +1,4 @@
+test_expect_success 'loop-upstream-pipe' '
 (
 	git rev-list --objects --no-object-names base..loose |
 	while read oid
@@ -9,3 +10,4 @@
 	done |
 	sort -k1
 ) >expect &&
+'
diff --git a/t/chainlint/multi-line-nested-command-substitution.test b/t/chainlint/multi-line-nested-command-substitution.test
index 300058341b..e811c63f2b 100644
--- a/t/chainlint/multi-line-nested-command-substitution.test
+++ b/t/chainlint/multi-line-nested-command-substitution.test
@@ -1,3 +1,4 @@
+test_expect_success 'multi-line-nested-command-substitution' '
 (
 	foo &&
 	x=$(
@@ -16,3 +17,4 @@ sort &&
 		fip) &&
 	echo fail
 )
+'
diff --git a/t/chainlint/multi-line-string.test b/t/chainlint/multi-line-string.test
index 4a0af2107d..7b5048d2ea 100644
--- a/t/chainlint/multi-line-string.test
+++ b/t/chainlint/multi-line-string.test
@@ -1,3 +1,4 @@
+test_expect_success 'multi-line-string' '
 (
 	x="line 1
 		line 2
@@ -13,3 +14,4 @@
 		ghi" &&
 	barfoo
 )
+'
diff --git a/t/chainlint/negated-one-liner.test b/t/chainlint/negated-one-liner.test
index c9598e9153..30f4cc5a9b 100644
--- a/t/chainlint/negated-one-liner.test
+++ b/t/chainlint/negated-one-liner.test
@@ -1,7 +1,9 @@
+test_expect_success 'negated-one-liner' '
 # LINT: top-level one-liner subshell
 ! (foo && bar) &&
 ! (foo && bar) >baz &&
 
 # LINT: top-level one-liner subshell missing internal "&&"
 ! (foo; bar) &&
 ! (foo; bar) >baz
+'
diff --git a/t/chainlint/nested-cuddled-subshell.test b/t/chainlint/nested-cuddled-subshell.test
index 8fd656c7b5..31e92d3be4 100644
--- a/t/chainlint/nested-cuddled-subshell.test
+++ b/t/chainlint/nested-cuddled-subshell.test
@@ -1,3 +1,4 @@
+test_expect_success 'nested-cuddled-subshell' '
 (
 # LINT: opening "(" cuddled with first nested subshell statement
 	(cd foo &&
@@ -29,3 +30,4 @@
 
 	foobar
 )
+'
diff --git a/t/chainlint/nested-here-doc.test b/t/chainlint/nested-here-doc.test
index f35404bf0f..9505c47a34 100644
--- a/t/chainlint/nested-here-doc.test
+++ b/t/chainlint/nested-here-doc.test
@@ -1,3 +1,4 @@
+test_expect_success 'nested-here-doc' '
 # LINT: inner "EOF" not misintrepreted as closing ARBITRARY here-doc
 cat <<ARBITRARY >foop &&
 naddle
@@ -31,3 +32,4 @@ ARBITRARY
 
 	foobar
 )
+'
diff --git a/t/chainlint/nested-loop-detect-failure.test b/t/chainlint/nested-loop-detect-failure.test
index e6f0c1acfb..3d4b657412 100644
--- a/t/chainlint/nested-loop-detect-failure.test
+++ b/t/chainlint/nested-loop-detect-failure.test
@@ -1,3 +1,4 @@
+test_expect_success 'nested-loop-detect-failure' '
 # LINT: neither loop handles failure explicitly with "|| return 1"
 for i in 0 1 2 3 4 5 6 7 8 9;
 do
@@ -33,3 +34,4 @@ do
 		echo "$i$j" >"path$i$j" || return 1
 	done || return 1
 done
+'
diff --git a/t/chainlint/nested-subshell-comment.test b/t/chainlint/nested-subshell-comment.test
index 0215cdb192..b430580ce0 100644
--- a/t/chainlint/nested-subshell-comment.test
+++ b/t/chainlint/nested-subshell-comment.test
@@ -1,3 +1,4 @@
+test_expect_success 'nested-subshell-comment' '
 (
 	foo &&
 	(
@@ -11,3 +12,4 @@
 	)
 	fuzzy
 )
+'
diff --git a/t/chainlint/nested-subshell.test b/t/chainlint/nested-subshell.test
index 440ee9992d..c31da34b73 100644
--- a/t/chainlint/nested-subshell.test
+++ b/t/chainlint/nested-subshell.test
@@ -1,3 +1,4 @@
+test_expect_success 'nested-subshell' '
 (
 	cd foo &&
 	(
@@ -11,3 +12,4 @@
 		echo b
 	) >file
 )
+'
diff --git a/t/chainlint/not-heredoc.test b/t/chainlint/not-heredoc.test
index 9aa57346cd..09711e45e0 100644
--- a/t/chainlint/not-heredoc.test
+++ b/t/chainlint/not-heredoc.test
@@ -1,3 +1,4 @@
+test_expect_success 'not-heredoc' '
 # LINT: "<< ours" inside string is not here-doc
 echo "<<<<<<< ours" &&
 echo ourside &&
@@ -14,3 +15,4 @@ echo ">>>>>>> theirs" &&
 	echo ">>>>>>> theirs"
 	poodle
 ) >merged
+'
diff --git a/t/chainlint/one-liner-for-loop.test b/t/chainlint/one-liner-for-loop.test
index 4bd8c066c7..00afd7ef76 100644
--- a/t/chainlint/one-liner-for-loop.test
+++ b/t/chainlint/one-liner-for-loop.test
@@ -1,3 +1,4 @@
+test_expect_success 'one-liner-for-loop' '
 git init dir-rename-and-content &&
 (
 	cd dir-rename-and-content &&
@@ -8,3 +9,4 @@ git init dir-rename-and-content &&
 	git add foo olddir &&
 	git commit -m "original" &&
 )
+'
diff --git a/t/chainlint/one-liner.test b/t/chainlint/one-liner.test
index be9858fa29..6e42ee1b5e 100644
--- a/t/chainlint/one-liner.test
+++ b/t/chainlint/one-liner.test
@@ -1,3 +1,4 @@
+test_expect_success 'one-liner' '
 # LINT: top-level one-liner subshell
 (foo && bar) &&
 (foo && bar) |
@@ -10,3 +11,4 @@
 
 # LINT: ";" in string not misinterpreted as broken &&-chain
 (foo "bar; baz")
+'
diff --git a/t/chainlint/p4-filespec.test b/t/chainlint/p4-filespec.test
index 4fd2d6e2b8..8ba6b911dc 100644
--- a/t/chainlint/p4-filespec.test
+++ b/t/chainlint/p4-filespec.test
@@ -1,5 +1,7 @@
+test_expect_success 'p4-filespec' '
 (
 # LINT: Perforce revspec in filespec not misinterpreted as in-line comment
 	p4 print -1 //depot/fiddle#42 >file &&
 	foobar
 )
+'
diff --git a/t/chainlint/pipe.test b/t/chainlint/pipe.test
index dd82534c66..1af81c243b 100644
--- a/t/chainlint/pipe.test
+++ b/t/chainlint/pipe.test
@@ -1,3 +1,4 @@
+test_expect_success 'pipe' '
 (
 # LINT: no "&&" needed on line ending with "|"
 	foo |
@@ -10,3 +11,4 @@
 
 	sunder
 )
+'
diff --git a/t/chainlint/return-loop.test b/t/chainlint/return-loop.test
index f90b171300..ea76c3593a 100644
--- a/t/chainlint/return-loop.test
+++ b/t/chainlint/return-loop.test
@@ -1,6 +1,8 @@
+test_expect_success 'return-loop' '
 while test $i -lt $((num - 5))
 do
 # LINT: "|| return {n}" valid loop escape outside subshell; no "&&" needed
 	git notes add -m "notes for commit$i" HEAD~$i || return 1
 	i=$((i + 1))
 done
+'
diff --git a/t/chainlint/semicolon.test b/t/chainlint/semicolon.test
index 67e1192c50..fc0ba1b539 100644
--- a/t/chainlint/semicolon.test
+++ b/t/chainlint/semicolon.test
@@ -1,3 +1,4 @@
+test_expect_success 'semicolon' '
 (
 # LINT: missing internal "&&" and ending "&&"
 	cat foo ; echo bar
@@ -23,3 +24,4 @@
 # LINT: semicolon unnecessary but legitimate
 		echo;
 	done)
+'
diff --git a/t/chainlint/sqstring-in-sqstring.test b/t/chainlint/sqstring-in-sqstring.test
index 77a425e0c7..24169724a5 100644
--- a/t/chainlint/sqstring-in-sqstring.test
+++ b/t/chainlint/sqstring-in-sqstring.test
@@ -1,5 +1,7 @@
+test_expect_success 'sqstring-in-sqstring' '
 # LINT: SQ-string Perl code fragment within SQ-string
 perl -e '\''
 	defined($_ = -s $_) or die for @ARGV;
 	exit 1 if $ARGV[0] <= $ARGV[1];
 '\'' test-2-$packname_2.pack test-3-$packname_3.pack
+'
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index d40eb65583..4a38f47f01 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -1,3 +1,4 @@
+test_expect_success 'subshell-here-doc' '
 (
 # LINT: stitch together incomplete \-ending lines
 # LINT: swallow here-doc to avoid false positives in content
@@ -33,3 +34,4 @@ EOF
 	ARBITRARY3
 	meep
 )
+'
diff --git a/t/chainlint/subshell-one-liner.test b/t/chainlint/subshell-one-liner.test
index 37fa643c20..dac536afcc 100644
--- a/t/chainlint/subshell-one-liner.test
+++ b/t/chainlint/subshell-one-liner.test
@@ -1,3 +1,4 @@
+test_expect_success 'subshell-one-liner' '
 (
 # LINT: nested one-liner subshell
 	(foo && bar) &&
@@ -22,3 +23,4 @@
 
 	foobar
 )
+'
diff --git a/t/chainlint/t7900-subtree.test b/t/chainlint/t7900-subtree.test
index 02f3129232..1f4f03300f 100644
--- a/t/chainlint/t7900-subtree.test
+++ b/t/chainlint/t7900-subtree.test
@@ -1,3 +1,4 @@
+test_expect_success 't7900-subtree' '
 (
 	chks="sub1
 sub2
@@ -20,3 +21,4 @@ TXT
 	check_equal "$subfiles" "$chkms
 $chks"
 )
+'
diff --git a/t/chainlint/token-pasting.test b/t/chainlint/token-pasting.test
index b4610ce815..590914b733 100644
--- a/t/chainlint/token-pasting.test
+++ b/t/chainlint/token-pasting.test
@@ -1,3 +1,4 @@
+test_expect_success 'token-pasting' '
 # LINT: single token; composite of multiple strings
 git config filter.rot13.smudge ./rot13.sh &&
 git config filter.rot13.clean ./rot13.sh &&
@@ -30,3 +31,4 @@ downstream_url_for_sed=$(
 # LINT: exit/enter string context; "&" inside string not command terminator
 	sed -e '\''s/\\/\\\\/g'\'' -e '\''s/[[/.*^$]/\\&/g'\''
 )
+'
diff --git a/t/chainlint/unclosed-here-doc-indent.test b/t/chainlint/unclosed-here-doc-indent.test
index 5c841a9dfd..7ac9d0f7d7 100644
--- a/t/chainlint/unclosed-here-doc-indent.test
+++ b/t/chainlint/unclosed-here-doc-indent.test
@@ -1,4 +1,6 @@
+test_expect_success 'unclosed-here-doc-indent' '
 command_which_is_run &&
 cat >expect <<-\EOF &&
 we forget to end the here-doc
 command_which_is_gobbled
+'
diff --git a/t/chainlint/unclosed-here-doc.test b/t/chainlint/unclosed-here-doc.test
index 69d3786c34..68e78f06f3 100644
--- a/t/chainlint/unclosed-here-doc.test
+++ b/t/chainlint/unclosed-here-doc.test
@@ -1,7 +1,9 @@
+test_expect_success 'unclosed-here-doc' '
 command_which_is_run &&
 cat >expect <<\EOF &&
 	we try to end the here-doc below,
 	but the indentation throws us off
 	since the operator is not "<<-".
 	EOF
 command_which_is_gobbled
+'
diff --git a/t/chainlint/while-loop.test b/t/chainlint/while-loop.test
index d09fb016e4..33a201906a 100644
--- a/t/chainlint/while-loop.test
+++ b/t/chainlint/while-loop.test
@@ -1,3 +1,4 @@
+test_expect_success 'while-loop' '
 (
 # LINT: "while", "do", "done" do not need "&&"
 	while true
@@ -17,3 +18,4 @@
 		cat bar
 	done
 )
+'
-- 
2.45.2.1249.gb036353db5

