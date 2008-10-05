From: Jeff King <peff@peff.net>
Subject: [PATCH] fix bogus "diff --git" header from "diff --no-index"
Date: Sun, 5 Oct 2008 15:35:15 -0400
Message-ID: <20081005193515.GA29022@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZP6-00030O-B1
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbYJETfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbYJETfT
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:35:19 -0400
Received: from peff.net ([208.65.91.99]:1514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbYJETfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:35:18 -0400
Received: (qmail 17192 invoked by uid 111); 5 Oct 2008 19:35:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 15:35:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 15:35:15 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97527>

From: Linus Torvalds <torvalds@linux-foundation.org>

When "git diff --no-index" is given an absolute pathname, it
would generate a diff header with the absolute path
prepended by the prefix, like:

  diff --git a/dev/null b/foo

Not only is this nonsensical, and not only does it violate
the description of diffs given in git-diff(1), but it would
produce broken binary diffs. Unlike text diffs, the binary
diffs don't contain the filenames anywhere else, and so "git
apply" relies on this header to figure out the filename.

This patch just refuses to use an invalid name for anything
visible in the diff.

Now, this fixes the "git diff --no-index --binary a
/dev/null" kind of case (and we'll end up using "a" as the
basename), but some other insane cases are impossible to
handle. If you do

	git diff --no-index --binary a /bin/echo

you'll still get a patch like

	diff --git a/a b/bin/echo
	old mode 100644
	new mode 100755
	index ...

and "git apply" will refuse to apply it for a couple of
reasons, and the diff is simply bogus.

And that, btw, is no longer a bug, I think. It's impossible
to know whethe the user meant for the patch to be a rename
or not. And as such, refusing to apply it because you don't
know what name you should use is probably _exactly_ the
right thing to do!

Original problem reported by Imre Deak. Test script and problem
description by Jeff King.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                 |    4 ++++
 t/t4012-diff-binary.sh |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 4e4e439..02e948c 100644
--- a/diff.c
+++ b/diff.c
@@ -1509,6 +1509,10 @@ static void builtin_diff(const char *name_a,
 		b_prefix = o->b_prefix;
 	}
 
+	/* Never use a non-valid filename anywhere if at all possible */
+	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
+	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
+
 	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index b8ec6e9..421f4bb 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -77,4 +77,25 @@ test_expect_success 'apply binary patch' \
 	 tree1=`git write-tree` &&
 	 test "$tree1" = "$tree0"'
 
+q_to_nul() {
+	perl -pe 'y/Q/\000/'
+}
+
+nul_to_q() {
+	perl -pe 'y/\000/Q/'
+}
+
+test_expect_success 'diff --no-index with binary creation' '
+	echo Q | q_to_nul >binary &&
+	(:# hide error code from diff, which just indicates differences
+	 git diff --binary --no-index /dev/null binary >current ||
+	 true
+	) &&
+	rm binary &&
+	git apply --binary <current &&
+	echo Q >expected &&
+	nul_to_q <binary >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.6.0.2.638.g50eb2
