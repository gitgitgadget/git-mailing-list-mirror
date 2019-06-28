Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E17D1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF1JjN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:39:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:53712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbfF1JjN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:39:13 -0400
Received: (qmail 14445 invoked by uid 109); 28 Jun 2019 09:39:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 09:39:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16081 invoked by uid 111); 28 Jun 2019 09:40:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 05:40:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 05:39:11 -0400
Date:   Fri, 28 Jun 2019 05:39:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190628093911.GA27329@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628093751.GA3569@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests need to create a string of commits. Doing this with
test_commit is very heavy-weight, as it needs at least one process per
commit (and in fact, uses several).

For bulk creation, we can do much better by using fast-import, but it's
often a pain to generate the input. Let's provide a helper to do so.

We'll use t5310 as a guinea pig, as it has three 10-commit loops. Here
are hyperfine results before and after:

  [before]
  Benchmark #1: ./t5310-pack-bitmaps.sh --root=/var/ram/git-tests
    Time (mean ± σ):      2.846 s ±  0.305 s    [User: 3.042 s, System: 0.919 s]
    Range (min … max):    2.250 s …  3.210 s    10 runs

  [after]
  Benchmark #1: ./t5310-pack-bitmaps.sh --root=/var/ram/git-tests
    Time (mean ± σ):      2.210 s ±  0.174 s    [User: 2.570 s, System: 0.604 s]
    Range (min … max):    1.999 s …  2.590 s    10 runs

So we're over 20% faster, while making the callers slightly shorter. We
added a lot more lines in test-lib-function.sh, of course, and the
helper is way more featureful than we need here. But my hope is that it
will be flexible enough to use in more places.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5310-pack-bitmaps.sh |  15 +----
 t/test-lib-functions.sh | 131 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 12 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a26c8ba9a2..3aab7024ca 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -21,15 +21,9 @@ has_any () {
 }
 
 test_expect_success 'setup repo with moderate-sized history' '
-	for i in $(test_seq 1 10)
-	do
-		test_commit $i
-	done &&
+	test_commit_bulk --id=file 10 &&
 	git checkout -b other HEAD~5 &&
-	for i in $(test_seq 1 10)
-	do
-		test_commit side-$i
-	done &&
+	test_commit_bulk --id=side 10 &&
 	git checkout master &&
 	bitmaptip=$(git rev-parse master) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
@@ -106,10 +100,7 @@ test_expect_success 'clone from bitmapped repository' '
 '
 
 test_expect_success 'setup further non-bitmapped commits' '
-	for i in $(test_seq 1 10)
-	do
-		test_commit further-$i
-	done
+	test_commit_bulk --id=further 10
 '
 
 rev_list_tests 'partial bitmap'
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0367cec5fd..32a1db81a3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -233,6 +233,137 @@ test_merge () {
 	git tag "$1"
 }
 
+# Similar to test_commit, but efficiently create <nr> commits, each with a
+# unique number $n (from 1 to <nr> by default) in the commit message.
+#
+# Usage: test_commit_bulk [options] <nr>
+#   -C <dir>:
+#	Run all git commands in directory <dir>
+#   --ref=<n>:
+#	ref on which to create commits (default: HEAD)
+#   --start=<n>:
+#	number commit messages from <n> (default: 1)
+#   --message=<msg>:
+#	use <msg> as the commit mesasge (default: "commit $n")
+#   --filename=<fn>:
+#	modify <fn> in each commit (default: $n.t)
+#   --contents=<string>:
+#	place <string> in each file (default: "content $n")
+#   --id=<string>:
+#	shorthand to use <string> and $n in message, filename, and contents
+#
+# The message, filename, and contents strings are evaluated by the shell inside
+# double-quotes, with $n set to the current commit number. So you can do:
+#
+#   test_commit_bulk --filename=file --contents='modification $n'
+#
+# to have every commit touch the same file, but with unique content. Spaces are
+# OK, but you must escape any metacharacters (like backslashes or
+# double-quotes) you do not want expanded.
+#
+test_commit_bulk () {
+	indir=
+	ref=HEAD
+	n=1
+	message='commit $n'
+	filename='$n.t'
+	contents='content $n'
+	while test $# -gt 0
+	do
+		case "$1" in
+		-C)
+			indir=$2
+			shift
+			;;
+		--ref=*)
+			ref=${1#--*=}
+			;;
+		--start=*)
+			n=${1#--*=}
+			;;
+		--message=*)
+			message=${1#--*=}
+			;;
+		--filename=*)
+			filename=${1#--*=}
+			;;
+		--contents=*)
+			contents=${1#--*=}
+			;;
+		--id=*)
+			message="${1#--*=} \$n"
+			filename="${1#--*=}-\$n.t"
+			contents="${1#--*=} \$n"
+			;;
+		-*)
+			BUG "invalid test_commit_bulk option: $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	total=$1
+
+	in_dir=${indir:+-C "$indir"}
+
+	# Any test_tick calls inside the loop will not affect our outer
+	# timestamp, since it's on the left-hand side of a pipe. So start with
+	# a known value now, increment in the loop, and then do the matching
+	# math here. The final test_tick updates the $GIT_* variables
+	test_tick
+	cur_time=$test_tick
+	test_tick=$((test_tick + total))
+	test_tick
+
+
+	{
+		# A "reset ... from" instructs fastimport to build on an
+		# existing branch tip rather than trying to overwrite.
+		if tip=$(git ${indir:+ -C "$indir"} \
+			 rev-parse --verify "$ref" 2>/dev/null)
+		then
+			echo "reset $ref"
+			echo "from $tip"
+		fi
+
+		while test "$total" -gt 0
+		do
+			echo "commit $ref" &&
+			printf 'author %s <%s> %s\n' \
+				"$GIT_AUTHOR_NAME" \
+				"$GIT_AUTHOR_EMAIL" \
+				"$cur_time -0700" &&
+			printf 'committer %s <%s> %s\n' \
+				"$GIT_COMMITTER_NAME" \
+				"$GIT_COMMITTER_EMAIL" \
+				"$cur_time -0700" &&
+			echo "data <<EOF" &&
+			eval "echo \"$message\"" &&
+			echo "EOF" &&
+			eval "echo \"M 644 inline $filename\"" &&
+			echo "data <<EOF" &&
+			eval "echo \"$contents\"" &&
+			echo "EOF" &&
+			echo &&
+			n=$((n + 1)) &&
+			cur_time=$((cur_time + 1)) &&
+			total=$((total - 1)) ||
+			echo "poison fast-import stream"
+		done
+	} | git ${indir:+ -C "$indir"} \
+		-c fastimport.unpacklimit=0 \
+		fast-import || return 1
+
+	# If we updated HEAD, then be nice and update the index and working
+	# tree, too.
+	if test "$ref" = "HEAD"
+	then
+		git ${indir:+ -C "$indir"} checkout -f HEAD || return 1
+	fi
+}
+
 # This function helps systems where core.filemode=false is set.
 # Use it instead of plain 'chmod +x' to set or unset the executable bit
 # of a file in the working directory and add it to the index.
-- 
2.22.0.768.gd89de1e449

