From: Jeff King <peff@peff.net>
Subject: [PATCH] for_each_reflog_ent_reverse: fix newlines on block boundaries
Date: Thu, 4 Dec 2014 20:28:54 -0500
Message-ID: <20141205012854.GA16590@peff.net>
References: <547C8610.8080301@cs.uni-saarland.de>
 <20141201233515.GV6527@google.com>
 <xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
 <5480C60E.3070903@cs.uni-saarland.de>
 <20141204215805.GD19953@peff.net>
 <xmqq388vrrj9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christoph Mallon <mallon@cs.uni-saarland.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 02:29:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwhhf-00022x-8g
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 02:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbaLEB26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 20:28:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:48694 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751824AbaLEB25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 20:28:57 -0500
Received: (qmail 31949 invoked by uid 102); 5 Dec 2014 01:28:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 19:28:57 -0600
Received: (qmail 11210 invoked by uid 107); 5 Dec 2014 01:28:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 20:28:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 20:28:54 -0500
Content-Disposition: inline
In-Reply-To: <xmqq388vrrj9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260849>

On Thu, Dec 04, 2014 at 02:14:50PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the bug is in the reverse-reflog reader in
> > for_each_reflog_ent_reverse. It reads BUFSIZ chunks of the file in
> > reverse order, and then parses them individually. If the trailing
> > newline for a line falls directly on the block boundary, we may not have
> > it in our current block, and pass the line to show_one_reflog_ent
> > without a trailing newline.
> 
> Ahh, thanks for helping spot it.  A code that uses BUFSIZ explains
> why a single reproduction recipe is platform dependent.

It also makes writing portable tests annoying, but I think I managed it
in the patch below. :)

> > So this is a long-standing bug in for_each_reflog_ent_reverse. It just
> > showed up recently because we started using that function for
> > read_ref_at_ent.
> > ...
> > The above is a workaround. I think the right solution is probably to
> > teach for_each_reflog_ent_reverse to makes sure the trailing newline is
> > included (either by tweaking the reverse code, or conditionally adding
> > it to the parsed buffer).
> 
> Sounds correct.  Unfortunately I no longer remember how I decided to
> deal with a line that spans the block boundary in that piece of code
> X-<.

Here's my proposed fix.

-- >8 --
When we read a reflog file in reverse, we read whole chunks
of BUFSIZ bytes, then loop over the buffer, parsing any
lines we find. We find the beginning of each line by looking
for the newline from the previous line. If we don't find
one, we know that we are either at the beginning of
the file, or that we have to read another block.

In the latter case, we stuff away what we have into a
strbuf, read another block, and continue our parse. But we
missed one case here. If we did find a newline, and it is at
the beginning of the block, we must also stuff that newline
into the strbuf, as it belongs to the block we are about to
read.

The minimal fix here would be to add this special case to
the conditional that checks whether we found a newline.
But we can make the flow a little clearer by rearranging a
bit: we first handle lines that we are going to show, and
then at the end of each loop, stuff away any leftovers if
necessary. That lets us fold this special-case in with the
more common "we ended in the middle of a line" case.

Signed-off-by: Jeff King <peff@peff.net>
---
I really needed this rearranging to figure out what the fix
_should_ be. Now that I did that, I was able to write the above
paragraph explaining what the minimal fix would be. And I can do that if
we prefer. But I think the fact that I had to go through the untangling
step first is an indication that maybe the end result is better. Of
course that's all subjective. :)

I waffled on the test script between generating it on the fly (as
below), and just including a complete 8K example that provokes the
failure. I don't care about the size that much, but rather on which is
more readable. My goal with showing the generation steps was to make it
clear how we arrived there, but I fear it may have ended up too
convoluted to do anyone any good. Opinions welcome.

 refs.c            | 47 ++++++++++++++++++++++++++++++++++++-----------
 t/t1410-reflog.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..ccb8834 100644
--- a/refs.c
+++ b/refs.c
@@ -3404,24 +3404,49 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 
 			bp = find_beginning_of_line(buf, scanp);
 
-			if (*bp != '\n') {
-				strbuf_splice(&sb, 0, 0, buf, endp - buf);
-				if (pos)
-					break; /* need to fill another block */
-				scanp = buf - 1; /* leave loop */
-			} else {
+			if (*bp == '\n') {
 				/*
-				 * (bp + 1) thru endp is the beginning of the
-				 * current line we have in sb
+				 * The newline is the end of the previous line,
+				 * so we know we have complete line starting
+				 * at (bp + 1). Prefix it onto any prior data
+				 * we collected for the line and process it.
 				 */
 				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
 				scanp = bp;
 				endp = bp + 1;
+				ret = show_one_reflog_ent(&sb, fn, cb_data);
+				strbuf_reset(&sb);
+				if (ret)
+					break;
+			} else if (!pos) {
+				/*
+				 * We are at the start of the buffer, and the
+				 * start of the file; there is no previous
+				 * line, and we have everything for this one.
+				 * Process it, and we can end the loop.
+				 */
+				strbuf_splice(&sb, 0, 0, buf, endp - buf);
+				ret = show_one_reflog_ent(&sb, fn, cb_data);
+				strbuf_reset(&sb);
+				break;
 			}
-			ret = show_one_reflog_ent(&sb, fn, cb_data);
-			strbuf_reset(&sb);
-			if (ret)
+
+			if (bp == buf) {
+				/*
+				 * We are at the start of the buffer, and there
+				 * is more file to read backwards. Which means
+				 * we are in the middle of a line. Note that we
+				 * may get here even if *bp was a newline; that
+				 * just means we are at the exact end of the
+				 * previous line, rather than some spot in the
+				 * middle.
+				 *
+				 * Save away what we have to be combined with
+				 * the data from the next read.
+				 */
+				strbuf_splice(&sb, 0, 0, buf, endp - buf);
 				break;
+			}
 		}
 
 	}
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8cf4461..779d4e3 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -287,4 +287,34 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 	test_cmp expect actual
 '
 
+# Triggering the bug detected by this test requires a newline to fall
+# exactly BUFSIZ-1 bytes from the end of the file. We don't know
+# what that value is, since it's platform dependent. However, if
+# we choose some value N, we also catch any D which divides N evenly
+# (since we will read backwards in chunks of D). So we choose 8K,
+# which catches glibc (with an 8K BUFSIZ) and *BSD (1K).
+#
+# Each line is 114 characters, so we need 75 to still have a few before the
+# last 8K. The 89-character padding on the final entry lines up our
+# newline exactly.
+test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
+	git checkout -b reflogskip &&
+	z38=00000000000000000000000000000000000000 &&
+	ident="abc <xyz> 0000000001 +0000" &&
+	for i in $(test_seq 1 75); do
+		printf "$z38%02d $z38%02d %s\t" $i $(($i+1)) "$ident" &&
+		if test $i = 75; then
+			for j in $(test_seq 1 89); do
+				printf X
+			done
+		else
+			printf X
+		fi &&
+		printf "\n"
+	done >.git/logs/refs/heads/reflogskip &&
+	git rev-parse reflogskip@{73} >actual &&
+	echo ${z38}03 >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.2.0.390.gf60752d
