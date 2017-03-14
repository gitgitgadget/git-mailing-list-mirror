Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A991201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750788AbdCNQa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 12:30:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:43992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbdCNQa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 12:30:28 -0400
Received: (qmail 14576 invoked by uid 109); 14 Mar 2017 16:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 16:30:27 +0000
Received: (qmail 32633 invoked by uid 111); 14 Mar 2017 16:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 12:30:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 12:30:24 -0400
Date:   Tue, 14 Mar 2017 12:30:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Wincent Colaiuta <win@wincent.com>,
        Mislav =?utf-8?B?TWFyb2huacSH?= <mislav.marohnic@gmail.com>
Subject: [PATCH] add--interactive: do not expand pathspecs with ls-files
Message-ID: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we want to get the list of modified files, we first
expand any user-provided pathspecs with "ls-files", and then
feed the resulting list of paths as arguments to
"diff-index" and "diff-files". If your pathspec expands into
a large number of paths, you may run into one of two
problems:

  1. The OS may complain about the size of the argument
     list, and refuse to run. For example:

       $ (ulimit -s 128 && git add -p drivers)
       Can't exec "git": Argument list too long at .../git-add--interactive line 177.
       Died at .../git-add--interactive line 177.

     That's on the linux.git repository, which has about 20K
     files in the "drivers" directory (none of them modified
     in this case). The "ulimit -s" trick is necessary to
     show the problem on Linux even for such a gigantic set
     of paths. Other operating systems have much smaller
     limits (e.g., a real-world case was seen with only 5K
     files on OS X).

  2. Even when it does work, it's really slow. The pathspec
     code is not optimized for huge numbers of paths. Here's
     the same case without the ulimit:

       $ time git add -p drivers
       No changes.

       real	0m16.559s
       user	0m53.140s
       sys	0m0.220s

We can improve this by skipping "ls-files" completely, and
just feeding the original pathspecs to the diff commands.
This solution was discussed in 2010:

  http://public-inbox.org/git/20100105041438.GB12574@coredump.intra.peff.net/

but at the time the diff code's pathspecs were more
primitive than those used by ls-files (e.g., they did not
support globs). Making the change would have caused a
user-visible regression, so we didn't.

Since then, the pathspec code has been unified, and the diff
commands natively understand pathspecs like '*.c'.

This patch implements that solution. That skips the
argument-list limits, and the result runs much faster:

  $ time git add -p drivers
  No changes.

  real	0m0.149s
  user	0m0.116s
  sys	0m0.080s

There are two new tests. The first just exercises the
globbing behavior to confirm that we are not causing a
regression there. The second checks the actual argument
behavior using GIT_TRACE. We _could_ do it with the "ulimit
-s" trick, as above. But that would mean the test could only
run where "ulimit -s" works. And tests of that sort are
expensive, because we have to come up with enough files to
actually bust the limit (we can't just shrink the "128" down
infinitely, since it is also the in-program stack size).

Finally, two caveats and possibilities for future work:

  a. This fixes one argument-list expansion, but there may
     be others. In fact, it's very likely that if you run
     "git add -i" and select a large number of modified
     files that the script would try to feed them all to a
     single git command.

     In practice this is probably fine. The real issue here
     is that the argument list was growing with the _total_
     number of files, not the number of modified or selected
     files.

  b. If the repository contains filenames with literal wildcard
     characters (e.g., "foo*"), the original code expanded
     them via "ls-files" and then fed those wildcard names
     to "diff-index", which would have treated them as
     wildcards. This was a bug, which is now fixed (though
     unless you really go through some contortions with
     ":(literal)", it's likely that your original pathspec
     would match whatever the accidentally-expanded wildcard
     would anyway).

     So this takes us one step closer to working correctly
     with files whose names contain wildcard characters, but
     it's likely that others remain (e.g., if "git add -i"
     feeds the selected paths to "git add").

Reported-by: Wincent Colaiuta <win@wincent.com>
Reported-by: Mislav Marohnić <mislav.marohnic@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I credited Wincent for reporting it in 2010. Hopefully his email still
works. :)

 git-add--interactive.perl  | 13 ++-----------
 t/t3701-add-interactive.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index f5c816e27..77b4ed53a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -275,20 +275,11 @@ sub list_modified {
 	my ($only) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
-	my @tracked = ();
-
-	if (@ARGV) {
-		@tracked = map {
-			chomp $_;
-			unquote_path($_);
-		} run_cmd_pipe(qw(git ls-files --), @ARGV);
-		return if (!@tracked);
-	}
 
 	my $reference = get_diff_reference($patch_mode_revision);
 	for (run_cmd_pipe(qw(git diff-index --cached
 			     --numstat --summary), $reference,
-			     '--', @tracked)) {
+			     '--', @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -313,7 +304,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @tracked)) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			$file = unquote_path($file);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index aaa258daa..f9528fa00 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -412,4 +412,47 @@ test_expect_success 'patch-mode via -i prompts for files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -p handles globs' '
+	git reset --hard &&
+
+	mkdir -p subdir &&
+	echo base >one.c &&
+	echo base >subdir/two.c &&
+	git add "*.c" &&
+	git commit -m base &&
+
+	echo change >one.c &&
+	echo change >subdir/two.c &&
+	git add -p "*.c" <<-\EOF &&
+	y
+	y
+	EOF
+
+	cat >expect <<-\EOF &&
+	one.c
+	subdir/two.c
+	EOF
+	git diff --cached --name-only >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'add -p does not expand argument lists' '
+	git reset --hard &&
+
+	echo content >not-changed &&
+	git add not-changed &&
+	git commit -m "add not-changed file" &&
+
+	echo change >file &&
+	GIT_TRACE=$(pwd)/trace.out git add -p . <<-\EOF &&
+	y
+	EOF
+
+	# we know that "file" must be mentioned since we actually
+	# update it, but we want to be sure that our "." pathspec
+	# was not expanded into the argument list of any command.
+	# So look only for "not-changed".
+	! grep not-changed trace.out
+'
+
 test_done
-- 
2.12.0.550.g163ff0384.dirty
