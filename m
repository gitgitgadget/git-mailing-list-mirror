From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] merge: detect delete/modechange conflict
Date: Mon, 26 Oct 2015 17:39:39 -0400
Message-ID: <20151026213939.GC17373@sigill.intra.peff.net>
References: <20151026213502.GA17244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 22:40:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpVW-0004yK-HS
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbbJZVjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:39:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:48149 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752043AbbJZVjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:39:42 -0400
Received: (qmail 9524 invoked by uid 102); 26 Oct 2015 21:39:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 16:39:41 -0500
Received: (qmail 18085 invoked by uid 107); 26 Oct 2015 21:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 17:40:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 17:39:39 -0400
Content-Disposition: inline
In-Reply-To: <20151026213502.GA17244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280229>

If one side deletes a file and the other changes its
content, we notice and report a conflict. However, if
instead of changing the content, we change only the mode,
the merge does not notice (and the mode change is silently
dropped).

The trivial index merge notices the problem and correctly
leaves the conflict in the index, but both merge-recursive
and merge-one-file will silently resolve this in favor of
the deletion.  In many cases that is a sane resolution, but
we should be punting to the user whenever there is any
question. So let's detect and treat this as a conflict (in
both strategies).

Signed-off-by: Jeff King <peff@peff.net>
---
The text for merge-one-file looks really gross and unlike
our usual error messages, but it matches the similar add/add
case lower in the script. I don't know if its worth cleaning
those messages up, as I doubt many people use "-s resolve"
these days. But even if we do, that should be a separate
series.

 git-merge-one-file.sh     |  8 ++++++++
 merge-recursive.c         |  8 ++++++--
 t/t6031-merge-filemode.sh | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 07dfeb8..cdc02af 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -38,6 +38,14 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Deleted in both or deleted in one and unchanged in the other
 #
 "$1.." | "$1.$1" | "$1$1.")
+	if { test -z "$6" && test "$5" != "$7"; } ||
+	   { test -z "$7" && test "$5" != "$6"; }
+	then
+		echo "ERROR: File $4 deleted on one branch but had its" >&2
+		echo "ERROR: permissions changed on the other." >&2
+		exit 1
+	fi
+
 	if test -n "$2"
 	then
 		echo "Removing $4"
diff --git a/merge-recursive.c b/merge-recursive.c
index a5e74d8..21e680a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1530,13 +1530,17 @@ static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
 }
 
 static int blob_unchanged(const unsigned char *o_sha,
+			  unsigned o_mode,
 			  const unsigned char *a_sha,
+			  unsigned a_mode,
 			  int renormalize, const char *path)
 {
 	struct strbuf o = STRBUF_INIT;
 	struct strbuf a = STRBUF_INIT;
 	int ret = 0; /* assume changed for safety */
 
+	if (a_mode != o_mode)
+		return 0;
 	if (sha_eq(o_sha, a_sha))
 		return 1;
 	if (!renormalize)
@@ -1722,8 +1726,8 @@ static int process_entry(struct merge_options *o,
 	} else if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
-		    (!b_sha && blob_unchanged(o_sha, a_sha, normalize, path)) ||
-		    (!a_sha && blob_unchanged(o_sha, b_sha, normalize, path))) {
+		    (!b_sha && blob_unchanged(o_sha, o_mode, a_sha, a_mode, normalize, path)) ||
+		    (!a_sha && blob_unchanged(o_sha, o_mode, b_sha, b_mode, normalize, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
diff --git a/t/t6031-merge-filemode.sh b/t/t6031-merge-filemode.sh
index c6896e6..7d06461 100755
--- a/t/t6031-merge-filemode.sh
+++ b/t/t6031-merge-filemode.sh
@@ -74,4 +74,27 @@ do_both_modes () {
 do_both_modes recursive
 do_both_modes resolve
 
+test_expect_success 'set up delete/modechange scenario' '
+	git reset --hard &&
+	git checkout -b deletion master &&
+	git rm file1 &&
+	git commit -m deletion
+'
+
+do_delete_modechange () {
+	strategy=$1
+	us=$2
+	them=$3
+	test_expect_success "detect delete/modechange conflict ($strategy, $us)" '
+		git reset --hard &&
+		git checkout $us &&
+		test_must_fail git merge -s $strategy $them
+	'
+}
+
+do_delete_modechange recursive b1 deletion
+do_delete_modechange recursive deletion b1
+do_delete_modechange resolve b1 deletion
+do_delete_modechange resolve deletion b1
+
 test_done
-- 
2.6.2.481.g6ca35c3
