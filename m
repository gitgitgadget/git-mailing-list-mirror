Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522AE20401
	for <e@80x24.org>; Thu, 15 Jun 2017 16:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdFOQa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 12:30:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:40881 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdFOQa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 12:30:57 -0400
Received: (qmail 7207 invoked by uid 109); 15 Jun 2017 16:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 16:30:57 +0000
Received: (qmail 26505 invoked by uid 111); 15 Jun 2017 16:30:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 12:30:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 12:30:55 -0400
Date:   Thu, 15 Jun 2017 12:30:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Scott Baker <scott@perturb.org>
Subject: [PATCH] diff-highlight: split code into module
Message-ID: <20170615163055.b63hcivjogafkerq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diff-so-fancy project is also written in perl, and most
of its users pipe diffs through both diff-highlight and
diff-so-fancy. It would be nice if this could be done in a
single script. So let's pull most of diff-highlight's code
into its own module which can be used by diff-so-fancy.

In addition, we'll abstract a few basic items like reading
from stdio so that a script using the module can do more
processing before or after diff-highlight handles the lines.
See the README update for more details.

One small downside is that the diff-highlight script must
now be built using the Makefile. There are ways around this,
but it quickly gets into perl arcana. Let's go with the
simple solution. As a bonus, our Makefile now respects the
PERL_PATH variable if it is set.

Signed-off-by: Jeff King <peff@peff.net>
---
Scott and I discussed this off-list, and this was the least-gross
solution I came up with.  The plan would be for diff-so-fancy to pull in
this copy of diff-highlight from git.git and have a wrapper script
similar to the diff-highlight.perl found here.

 contrib/diff-highlight/.gitignore                  |  2 ++
 .../{diff-highlight => DiffHighlight.pm}           | 40 +++++++++++++---------
 contrib/diff-highlight/Makefile                    | 21 ++++++++++--
 contrib/diff-highlight/README                      | 30 ++++++++++++++++
 contrib/diff-highlight/diff-highlight.perl         |  8 +++++
 5 files changed, 82 insertions(+), 19 deletions(-)
 create mode 100644 contrib/diff-highlight/.gitignore
 rename contrib/diff-highlight/{diff-highlight => DiffHighlight.pm} (91%)
 mode change 100755 => 100644
 create mode 100644 contrib/diff-highlight/diff-highlight.perl

diff --git a/contrib/diff-highlight/.gitignore b/contrib/diff-highlight/.gitignore
new file mode 100644
index 000000000..c07454824
--- /dev/null
+++ b/contrib/diff-highlight/.gitignore
@@ -0,0 +1,2 @@
+shebang.perl
+diff-highlight
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/DiffHighlight.pm
old mode 100755
new mode 100644
similarity index 91%
rename from contrib/diff-highlight/diff-highlight
rename to contrib/diff-highlight/DiffHighlight.pm
index 81bd8040e..663992e53
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+package DiffHighlight;
 
 use 5.008;
 use warnings FATAL => 'all';
@@ -29,13 +29,14 @@ my @removed;
 my @added;
 my $in_hunk;
 
-# Some scripts may not realize that SIGPIPE is being ignored when launching the
-# pager--for instance scripts written in Python.
-$SIG{PIPE} = 'DEFAULT';
+our $line_cb = sub { print @_ };
+our $flush_cb = sub { local $| = 1 };
+
+sub handle_line {
+	local $_ = shift;
 
-while (<>) {
 	if (!$in_hunk) {
-		print;
+		$line_cb->($_);
 		$in_hunk = /^$GRAPH*$COLOR*\@\@ /;
 	}
 	elsif (/^$GRAPH*$COLOR*-/) {
@@ -49,7 +50,7 @@ while (<>) {
 		@removed = ();
 		@added = ();
 
-		print;
+		$line_cb->($_);
 		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
 	}
 
@@ -62,15 +63,22 @@ while (<>) {
 	# place to flush. Flushing on a blank line is a heuristic that
 	# happens to match git-log output.
 	if (!length) {
-		local $| = 1;
+		$flush_cb->();
 	}
 }
 
-# Flush any queued hunk (this can happen when there is no trailing context in
-# the final diff of the input).
-show_hunk(\@removed, \@added);
+sub flush {
+	# Flush any queued hunk (this can happen when there is no trailing
+	# context in the final diff of the input).
+	show_hunk(\@removed, \@added);
+}
 
-exit 0;
+sub highlight_stdin {
+	while (<STDIN>) {
+		handle_line($_);
+	}
+	flush();
+}
 
 # Ideally we would feed the default as a human-readable color to
 # git-config as the fallback value. But diff-highlight does
@@ -88,7 +96,7 @@ sub show_hunk {
 
 	# If one side is empty, then there is nothing to compare or highlight.
 	if (!@$a || !@$b) {
-		print @$a, @$b;
+		$line_cb->(@$a, @$b);
 		return;
 	}
 
@@ -97,17 +105,17 @@ sub show_hunk {
 	# stupid, and only handle multi-line hunks that remove and add the same
 	# number of lines.
 	if (@$a != @$b) {
-		print @$a, @$b;
+		$line_cb->(@$a, @$b);
 		return;
 	}
 
 	my @queue;
 	for (my $i = 0; $i < @$a; $i++) {
 		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
+		$line_cb->($rm);
 		push @queue, $add;
 	}
-	print @queue;
+	$line_cb->(@queue);
 }
 
 sub highlight_pair {
diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
index 901872452..fbf5c5824 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -1,5 +1,20 @@
-# nothing to build
-all:
+all: diff-highlight
 
-test:
+PERL_PATH = /usr/bin/perl
+-include ../../config.mak
+
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+
+diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
+	cat $^ >$@+
+	chmod +x $@+
+	mv $@+ $@
+
+shebang.perl: FORCE
+	@echo '#!$(PERL_PATH_SQ)' >$@+
+	@cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@
+
+test: all
 	$(MAKE) -C t
+
+.PHONY: FORCE
diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 836b97a73..d4c234317 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -99,6 +99,36 @@ newHighlight = "black #aaffaa"
 ---------------------------------------------
 
 
+Using diff-highlight as a module
+--------------------------------
+
+If you want to pre- or post- process the highlighted lines as part of
+another perl script, you can use the DiffHighlight module. You can
+either "require" it or just cat the module together with your script (to
+avoid run-time dependencies).
+
+Your script may set up one or more of the following variables:
+
+  - $DiffHighlight::line_cb - this should point to a function which is
+    called whenever DiffHighlight has lines (which may contain
+    highlights) to output. The default function prints each line to
+    stdout. Note that the function may be called with multiple lines.
+
+  - $DiffHighlight::flush_cb - this should point to a function which
+    flushes the output (because DiffHighlight believes it has completed
+    processing a logical chunk of input). The default function flushes
+    stdout.
+
+The script may then feed lines, one at a time, to DiffHighlight::handle_line().
+When lines are done processing, they will be fed to $line_cb. Note that
+DiffHighlight may queue up many input lines (to analyze a whole hunk)
+before calling $line_cb. After providing all lines, call
+DiffHighlight::flush() to flush any unprocessed lines.
+
+If you just want to process stdin, DiffHighlight::highlight_stdin()
+is a convenience helper which will loop and flush for you.
+
+
 Bugs
 ----
 
diff --git a/contrib/diff-highlight/diff-highlight.perl b/contrib/diff-highlight/diff-highlight.perl
new file mode 100644
index 000000000..9b3e9c1f4
--- /dev/null
+++ b/contrib/diff-highlight/diff-highlight.perl
@@ -0,0 +1,8 @@
+package main;
+
+# Some scripts may not realize that SIGPIPE is being ignored when launching the
+# pager--for instance scripts written in Python.
+$SIG{PIPE} = 'DEFAULT';
+
+DiffHighlight::highlight_stdin();
+exit 0;
-- 
2.13.1.766.g6bea926c5
