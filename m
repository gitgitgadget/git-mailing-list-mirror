From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Sun, 28 Oct 2012 08:01:04 -0400
Message-ID: <20121028120104.GE11434@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 13:01:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSRYP-0006a4-GW
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 13:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab2J1MBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 08:01:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41289 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2J1MBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 08:01:06 -0400
Received: (qmail 8150 invoked by uid 107); 28 Oct 2012 12:01:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 08:01:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 08:01:04 -0400
Content-Disposition: inline
In-Reply-To: <508C29E4.5000801@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208540>

On Sat, Oct 27, 2012 at 08:37:24PM +0200, Peter Oberndorfer wrote:

> It seems "git diff-tree -Ganything <tree>" crashes[1] with a null
> pointer dereference
> when run on a commit that adds a file (pdf) with a textconv filter.
> 
> It can be reproduced with vanilla git by having a commit on top that
> adds a file with a textconv filter and executing git diff-tree
> -Ganything HEAD
> But running git log -Ganything still works without a crash.
> This problem seems to exist since the feature was first added in f506b8e8b5.

Thanks for a thorough bug report. I didn't reproduce the crash, but I
can see how it happens (it happens with diff-tree because we will reuse
the working tree file in that instance; it could also happen if you
turned on textconv caching).

> While testing I also noticed the -S and -G act on the original file
> instead of the textconv munged data.
> Is this intentional or caused by accessing the wrong data?

Both, perhaps. :)

-G operates on the munged data; you can see it feed the munged data to
xdiff in diff_grep. But the optimization for handling added and removed
files accidentally fed the wrong pointer. Fixing that is a no-brainer,
since the optimization is inconsistent with the regular code path.

-S, however, predates the invention of textconv and has never used it.
It is a little less clear that textconv is the right thing here, because
it is not about grepping the diff, but about counting occurrences of the
string inside the file content. I tend to think that doing so on the
textconv'd data would be what people generally want, but it is a
behavior change.

> Wild guess: should we really access p->one->data and not mf1.ptr?

Precisely. Thanks for your wild guess; it made finding the bug very
easy. :)

> Is there some more information i should provide?

The patch below should fix it. I added tests, but please try your
real-world test case on it to double-check.

-- >8 --
Subject: [PATCH] diff_grep: use textconv buffers for add/deleted files

If you use "-G" to grep a diff, we will apply a configured
textconv filter to the data before generating the diff.
However, if the diff is an addition or deletion, we do not
bother running the diff at all, and just look for the token
in the added (or removed) content. This works because we
know that the diff must contain every line of content.

However, while we used the textconv-derived buffers in the
regular diff, we accidentally passed the original unmodified
buffers to regexec when checking the added or removed
content. This could lead to an incorrect answer.

Worse, in some cases we might have a textconv buffer but no
original buffer (e.g., if we pulled the textconv data from
cache, or if we reused a working tree file when generating
it). In that case, we could actually feed NULL to regexec
and segfault.

Reported-by: Peter Oberndorfer <kumbayo84@arcor.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 diffcore-pickaxe.c       |  4 ++--
 t/t4030-diff-textconv.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index ed23eb4..a209376 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -104,10 +104,10 @@ static int diff_grep(struct diff_filepair *p, struct diff_options *o,
 		if (!mf2.ptr)
 			return 0; /* ignore unmerged */
 		/* created "two" -- does it have what we are looking for? */
-		hit = !regexec(regexp, p->two->data, 1, &regmatch, 0);
+		hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
 	} else if (!mf2.ptr) {
 		/* removed "one" -- did it have what we are looking for? */
-		hit = !regexec(regexp, p->one->data, 1, &regmatch, 0);
+		hit = !regexec(regexp, mf1.ptr, 1, &regmatch, 0);
 	} else {
 		/*
 		 * We have both sides; need to run textual diff and see if
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index eebb1ee..461d27a 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -84,6 +84,18 @@ test_expect_success 'status -v produces text' '
 	git reset --soft HEAD@{1}
 '
 
+test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
+	echo one >expect &&
+	git log --root --format=%s -G0 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep-diff (-G) operates on textconv data (modification)' '
+	echo two >expect &&
+	git log --root --format=%s -G1 >actual &&
+	test_cmp expect actual
+'
+
 cat >expect.stat <<'EOF'
  file | Bin 2 -> 4 bytes
  1 file changed, 0 insertions(+), 0 deletions(-)
-- 
1.8.0.3.g3456896
