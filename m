From: Jeff King <peff@peff.net>
Subject: [PATCH] merge-file: clamp exit code to maximum 127
Date: Wed, 28 Oct 2015 18:44:21 -0400
Message-ID: <20151028224421.GA14911@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:44:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZSL-0001n7-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbbJ1WoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:44:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:49581 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751234AbbJ1WoY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:44:24 -0400
Received: (qmail 17976 invoked by uid 102); 28 Oct 2015 22:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 17:44:23 -0500
Received: (qmail 7652 invoked by uid 107); 28 Oct 2015 22:44:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 18:44:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2015 18:44:21 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280420>

Git-merge-file is documented to return one of three exit
codes:

  - zero means the merge was successful

  - a negative number means an error occurred

  - a positive number indicates the number of conflicts

Unfortunately, this all gets stuffed into an 8-bit return
code. Which means that if you have 256 conflicts, this wraps
to zero, and the merge appears to succeed (and commits a
blob full of conflict-marker cruft!).

This patch clamps the return value to a maximum of 127,
which we should be able to safely represent everywhere. This
also leaves 128-255 for other values. Shells (and some parts
of git) will typically represent signal death as 128 plus
the signal number. And negative values are typically coerced
to an 8-bit unsigned value (so "return -1" ends up as 255).

Technically negative returns have the same problem (e.g.,
"-256" wraps back to 0), but this is not a problem in
practice, as the only negative value we use is "-1".

Signed-off-by: Jeff King <peff@peff.net>
---
This can be triggered when using the "resolve" strategy, though I found
it when comparing the results of git-merge-index with libgit2's merge
driver across a large number of GitHub merges (git claimed to
successfully merge but libgit2 correctly identified the conflict). The
real world case that triggered it had exactly 768 conflicts.

 Documentation/git-merge-file.txt |  3 ++-
 builtin/merge-file.c             |  3 +++
 t/t7600-merge.sh                 | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index d2fc12e..f856032 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -41,7 +41,8 @@ lines from `<other-file>`, or lines from both respectively.  The length of the
 conflict markers can be given with the `--marker-size` option.
 
 The exit value of this program is negative on error, and the number of
-conflicts otherwise. If the merge was clean, the exit value is 0.
+conflicts otherwise (truncated to 127 if there are more than that many
+conflicts). If the merge was clean, the exit value is 0.
 
 'git merge-file' is designed to be a minimal clone of RCS 'merge'; that is, it
 implements all of RCS 'merge''s functionality which is needed by
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 50d0bc8..5544705 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -104,5 +104,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		free(result.ptr);
 	}
 
+	if (ret > 127)
+		ret = 127;
+
 	return ret;
 }
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 75c50ee..302e238 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -692,4 +692,37 @@ test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	test_cmp actual expect
 '
 
+test_expect_success 'set up mod-256 conflict scenario' '
+	# 256 near-identical stanzas...
+	for i in $(test_seq 1 256); do
+		for j in 1 2 3 4 5; do
+			echo $i-$j
+		done
+	done >file &&
+	git add file &&
+	git commit -m base &&
+
+	# one side changes the first line of each to "master"
+	sed s/-1/-master/ <file >tmp &&
+	mv tmp file &&
+	git commit -am master &&
+
+	# and the other to "side"; merging the two will
+	# yield 256 separate conflicts
+	git checkout -b side HEAD^ &&
+	sed s/-1/-side/ <file >tmp &&
+	mv tmp file &&
+	git commit -am side
+'
+
+test_expect_success 'merge detects mod-256 conflicts (recursive)' '
+	git reset --hard &&
+	test_must_fail git merge -s recursive master
+'
+
+test_expect_success 'merge detects mod-256 conflicts (resolve)' '
+	git reset --hard &&
+	test_must_fail git merge -s resolve master
+'
+
 test_done
-- 
2.6.2.572.g6ed22dd
