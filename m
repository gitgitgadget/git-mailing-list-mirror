Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53101F461
	for <e@80x24.org>; Tue,  2 Jul 2019 05:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfGBFQw (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 01:16:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725775AbfGBFQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 01:16:51 -0400
Received: (qmail 30621 invoked by uid 109); 2 Jul 2019 05:16:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jul 2019 05:16:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11794 invoked by uid 111); 2 Jul 2019 05:17:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Jul 2019 01:17:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2019 01:16:49 -0400
Date:   Tue, 2 Jul 2019 01:16:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] test-lib: introduce test_commit_bulk
Message-ID: <20190702051649.GA16344@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
 <20190629045322.GA8155@sigill.intra.peff.net>
 <xmqq7e915r6k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7e915r6k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 03:24:35PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Here's a re-roll of just the first patch of this series, since that was
> > the one that got all the comments (and the others are textually
> > independent).
> 
> OK, will replace and then queue an adjustment for 6200 which used to
> use \$n but now must use %s instead.  Let's see if people spot things
> worth pointing out in the remainder of the series (or this one, of
> course, but I found this step quite sensible).

Urgh, I forgot I did have to tweak that later test. Thanks for noticing.

I do have one more update based on the comments from Elijah: using
"from" in the initial commit lets us simplify a few things (I posted the
incremental earlier in the thread, but here it is as a complete
replacement for patch 1).

-- >8 --
Subject: [PATCH v3] test-lib: introduce test_commit_bulk

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
 t/test-lib-functions.sh | 123 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 12 deletions(-)

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
index 0367cec5fd..6083cf483a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -233,6 +233,129 @@ test_merge () {
 	git tag "$1"
 }
 
+# Efficiently create <nr> commits, each with a unique number (from 1 to <nr>
+# by default) in the commit message.
+#
+# Usage: test_commit_bulk [options] <nr>
+#   -C <dir>:
+#	Run all git commands in directory <dir>
+#   --ref=<n>:
+#	ref on which to create commits (default: HEAD)
+#   --start=<n>:
+#	number commit messages from <n> (default: 1)
+#   --message=<msg>:
+#	use <msg> as the commit mesasge (default: "commit %s")
+#   --filename=<fn>:
+#	modify <fn> in each commit (default: %s.t)
+#   --contents=<string>:
+#	place <string> in each file (default: "content %s")
+#   --id=<string>:
+#	shorthand to use <string> and %s in message, filename, and contents
+#
+# The message, filename, and contents strings are evaluated by printf, with the
+# first "%s" replaced by the current commit number. So you can do:
+#
+#   test_commit_bulk --filename=file --contents="modification %s"
+#
+# to have every commit touch the same file, but with unique content.
+#
+test_commit_bulk () {
+	tmpfile=.bulk-commit.input
+	indir=.
+	ref=HEAD
+	n=1
+	message='commit %s'
+	filename='%s.t'
+	contents='content %s'
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
+			message="${1#--*=} %s"
+			filename="${1#--*=}-%s.t"
+			contents="${1#--*=} %s"
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
+	add_from=
+	if git -C "$indir" rev-parse --verify "$ref"
+	then
+		add_from=t
+	fi
+
+	while test "$total" -gt 0
+	do
+		test_tick &&
+		echo "commit $ref"
+		printf 'author %s <%s> %s\n' \
+			"$GIT_AUTHOR_NAME" \
+			"$GIT_AUTHOR_EMAIL" \
+			"$GIT_AUTHOR_DATE"
+		printf 'committer %s <%s> %s\n' \
+			"$GIT_COMMITTER_NAME" \
+			"$GIT_COMMITTER_EMAIL" \
+			"$GIT_COMMITTER_DATE"
+		echo "data <<EOF"
+		printf "$message\n" $n
+		echo "EOF"
+		if test -n "$add_from"
+		then
+			echo "from $ref^0"
+			add_from=
+		fi
+		printf "M 644 inline $filename\n" $n
+		echo "data <<EOF"
+		printf "$contents\n" $n
+		echo "EOF"
+		echo
+		n=$((n + 1))
+		total=$((total - 1))
+	done >"$tmpfile"
+
+	git -C "$indir" \
+	    -c fastimport.unpacklimit=0 \
+	    fast-import <"$tmpfile" || return 1
+
+	# This will be left in place on failure, which may aid debugging.
+	rm -f "$tmpfile"
+
+	# If we updated HEAD, then be nice and update the index and working
+	# tree, too.
+	if test "$ref" = "HEAD"
+	then
+		git -C "$indir" checkout -f HEAD || return 1
+	fi
+
+}
+
 # This function helps systems where core.filemode=false is set.
 # Use it instead of plain 'chmod +x' to set or unset the executable bit
 # of a file in the working directory and add it to the index.
-- 
2.22.0.776.g16867c022c

