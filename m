Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E023205C9
	for <e@80x24.org>; Fri,  6 Jan 2017 04:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937819AbdAFEU4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 23:20:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:35828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936925AbdAFEUy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 23:20:54 -0500
Received: (qmail 13060 invoked by uid 109); 6 Jan 2017 04:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 04:20:54 +0000
Received: (qmail 14352 invoked by uid 111); 6 Jan 2017 04:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 23:21:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2017 23:20:51 -0500
Date:   Thu, 5 Jan 2017 23:20:51 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] blame: output porcelain "previous" header for each file
Message-ID: <20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net>
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible for content currently found in one file to
have originated in two separate files, each of which may
have been modified in some single older commit.  The
--porcelain output generates an incorrect "previous" header
in this case, whereas --line-porcelain gets it right.  The
problem is that the porcelain output tries to omit repeated
details of commits, and treats "previous" as a property of
the commit, when it is really a property of the blamed block
of lines.

Let's look at an example. In a case like this, you might see
this output from --line-porcelain:

  SOME_SHA1 1 1 1
  author ...
  committer ...
  previous SOME_SHA1^ file_one
  filename file_one
          ...some line content...
  SOME_SHA1 2 1 1
  author ...
  committer ...
  previous SOME_SHA1^ file_two
  filename file_two
          ...some different content....

The "filename" fields tell us that the two lines are from
two different files. But notice that the filename also
appears in the "previous" field, which tells us where to
start a re-blame. The second content line never appeared in
file_one at all, so we would obviously need to re-blame from
file_two (or possibly even some other file, if had just been
renamed to file_two in SOME_SHA1).

So far so good. Now here's what --porcelain looks like:

  SOME_SHA1 1 1 1
  author ...
  committer ...
  previous SOME_SHA1^ file_one
  filename file_one
          ...some line content...
  SOME_SHA1 2 1 1
  filename file_two
          ...some different content....

We've dropped the author and committer fields from the
second line, as they would just be repeats.  But we can't
omit "filename", because it depends on the actual block of
blamed lines, not just the commit. This is handled by
emit_porcelain_details(), which will show the filename
either if it is the first mention of the commit _or_ if the
commit has multiple paths in it.

But we don't give "previous" the same handling. It's written
inside emit_one_suspect_detail(), which bails early if we've
already seen that commit. And so the output above is wrong;
a reader would assume that the correct place to re-blame
line two is from file_one, but that's obviously nonsense.

Let's treat "previous" the same as "filename", and show it
fresh whenever we know we are in a confusing case like this.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm assuming that the parent sha1 for a "previous" field will always be
the same for a given commit. So we really only need to care about
reprinting when we know there are multiple paths, as this patch does
(i.e., treat it exactly the same as "filename"). If I'm wrong, then
there's probably another corner case that this doesn't handle. I
couldn't think of a way to trigger such a setup, though.

 builtin/blame.c             |  23 +++++----
 t/t8011-blame-split-file.sh | 117 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 9 deletions(-)
 create mode 100755 t/t8011-blame-split-file.sh

diff --git a/builtin/blame.c b/builtin/blame.c
index c6170fed81..3aae19a0f9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1700,13 +1700,23 @@ static void get_commit_info(struct commit *commit,
 }
 
 /*
+ * Write out any suspect information which depends on the path. This must be
+ * handled separately from emit_one_suspect_detail(), because a given commit
+ * may have changes in multiple paths. So this needs to appear each time
+ * we mention a new group.
+ *
  * To allow LF and other nonportable characters in pathnames,
  * they are c-style quoted as needed.
  */
-static void write_filename_info(const char *path)
+static void write_filename_info(struct origin *suspect)
 {
+	if (suspect->previous) {
+		struct origin *prev = suspect->previous;
+		printf("previous %s ", oid_to_hex(&prev->commit->object.oid));
+		write_name_quoted(prev->path, stdout, '\n');
+	}
 	printf("filename ");
-	write_name_quoted(path, stdout, '\n');
+	write_name_quoted(suspect->path, stdout, '\n');
 }
 
 /*
@@ -1735,11 +1745,6 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 	printf("summary %s\n", ci.summary.buf);
 	if (suspect->commit->object.flags & UNINTERESTING)
 		printf("boundary\n");
-	if (suspect->previous) {
-		struct origin *prev = suspect->previous;
-		printf("previous %s ", oid_to_hex(&prev->commit->object.oid));
-		write_name_quoted(prev->path, stdout, '\n');
-	}
 
 	commit_info_destroy(&ci);
 
@@ -1760,7 +1765,7 @@ static void found_guilty_entry(struct blame_entry *ent,
 		       oid_to_hex(&suspect->commit->object.oid),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
 		emit_one_suspect_detail(suspect, 0);
-		write_filename_info(suspect->path);
+		write_filename_info(suspect);
 		maybe_flush_or_die(stdout, "stdout");
 	}
 	pi->blamed_lines += ent->num_lines;
@@ -1884,7 +1889,7 @@ static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
 	if (emit_one_suspect_detail(suspect, repeat) ||
 	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
-		write_filename_info(suspect->path);
+		write_filename_info(suspect);
 }
 
 static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
new file mode 100755
index 0000000000..831125047b
--- /dev/null
+++ b/t/t8011-blame-split-file.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+
+test_description='
+The general idea is that we have a single file whose lines come from
+multiple other files, and those individual files were modified in the same
+commits. That means that we will see the same commit in multiple contexts,
+and each one should be attributed to the correct file.
+
+Note that we need to use "blame -C" to find the commit for all lines. We will
+not bother testing that the non-C case fails to find it. That is how blame
+behaves now, but it is not a property we want to make sure is retained.
+'
+. ./test-lib.sh
+
+# help avoid typing and reading long strings of similar lines
+# in the tests below
+generate_expect () {
+	while read nr data
+	do
+		i=0
+		while test $i -lt $nr
+		do
+			echo $data
+			i=$((i + 1))
+		done
+	done
+}
+
+test_expect_success 'setup split file case' '
+	# use lines long enough to trigger content detection
+	test_seq 1000 1010 >one &&
+	test_seq 2000 2010 >two &&
+	git add one two &&
+	test_commit base &&
+
+	sed "6s/^/modified /" <one >one.tmp &&
+	mv one.tmp one &&
+	sed "6s/^/modified /" <two >two.tmp &&
+	mv two.tmp two &&
+	git add -u &&
+	test_commit modified &&
+
+	cat one two >combined &&
+	git add combined &&
+	git rm one two &&
+	test_commit combined
+'
+
+test_expect_success 'setup simulated porcelain' '
+	# This just reads porcelain-ish output and tries
+	# to output the value of a given field for each line (either by
+	# reading the field that accompanies this line, or referencing
+	# the information found last time the commit was mentioned).
+	cat >read-porcelain.pl <<-\EOF
+	my $field = shift;
+	while (<>) {
+		if (/^[0-9a-f]{40} /) {
+			flush();
+			$hash = $&;
+		} elsif (/^$field (.*)/) {
+			$cache{$hash} = $1;
+		}
+	}
+	flush();
+
+	sub flush {
+		return unless defined $hash;
+		if (defined $cache{$hash}) {
+			print "$cache{$hash}\n";
+		} else {
+			print "NONE\n";
+		}
+	}
+	EOF
+'
+
+for output in porcelain line-porcelain
+do
+	test_expect_success "generate --$output output" '
+		git blame --root -C --$output combined >output
+	'
+
+	test_expect_success "$output output finds correct commits" '
+		generate_expect >expect <<-\EOF &&
+		5 base
+		1 modified
+		10 base
+		1 modified
+		5 base
+		EOF
+		perl read-porcelain.pl summary <output >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$output output shows correct filenames" '
+		generate_expect >expect <<-\EOF &&
+		11 one
+		11 two
+		EOF
+		perl read-porcelain.pl filename <output >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$output output shows correct previous pointer" '
+		generate_expect >expect <<-EOF &&
+		5 NONE
+		1 $(git rev-parse modified^) one
+		10 NONE
+		1 $(git rev-parse modified^) two
+		5 NONE
+		EOF
+		perl read-porcelain.pl previous <output >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_done
-- 
2.11.0.519.g31435224cf
