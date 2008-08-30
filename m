From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git apply: do not match beginning in special unidiff-zero
	case
Date: Sat, 30 Aug 2008 21:03:02 +0200
Message-ID: <20080830190302.GA29851@localhost>
References: <20080830164527.GA25370@localhost> <20080830165600.GB25370@localhost> <7vhc92ie44.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:04:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVjo-0001x1-PI
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 21:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYH3TCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 15:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYH3TCt
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 15:02:49 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:29894 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbYH3TCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 15:02:49 -0400
Received: from darc.dyndns.org ([84.154.72.105]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 Aug 2008 21:02:46 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KZViw-0003Hb-CK; Sat, 30 Aug 2008 21:03:02 +0200
Content-Disposition: inline
In-Reply-To: <7vhc92ie44.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 Aug 2008 19:02:47.0115 (UTC) FILETIME=[FD9DB1B0:01C90AD2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94408>

If a unidiff patch without any context modifies the second line, it does
not match the beginning, even though oldpos == 1.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Aug 30, 2008 at 10:53:15AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > echo a > victim
> > git add victim
> > echo b >> victim
> > git diff -U0 | git apply --cached --unidiff-zero
> > git diff
> 
> I think "diff -U0" there would say "@@ -1,0 +2 @@", iow "add this one line
> after the first line", and "apply" has an off-by-one in this case.

Indeed. This appears to fix problems with staging hunks in git gui, even
with zero context lines. Staging individual lines still doesn't work,
though.

Clemens

 builtin-apply.c           |    9 ++++-----
 t/t4104-apply-boundary.sh |   15 ++++++++++++---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2216a0b..8402f9d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1994,16 +1994,15 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	trailing = frag->trailing;
 
 	/*
-	 * A hunk to change lines at the beginning would begin with
+	 * Unless the patch was generated with unidiff without any context, a
+	 * hunk to change lines at the beginning would begin with
 	 * @@ -1,L +N,M @@
 	 *
 	 * And a hunk to add to an empty file would begin with
 	 * @@ -0,0 +N,M @@
-	 *
-	 * In other words, a hunk that is (frag->oldpos <= 1) with or
-	 * without leading context must match at the beginning.
 	 */
-	match_beginning = frag->oldpos <= 1;
+	match_beginning = frag->oldpos == 0 ||
+		(!unidiff_zero && frag->oldpos == 1);
 
 	/*
 	 * A hunk without trailing lines must match at the end.
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index e7e2913..0e3ce36 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -27,6 +27,15 @@ test_expect_success setup '
 	git diff victim >add-a-patch.with &&
 	git diff --unified=0 >add-a-patch.without &&
 
+	: insert at line two
+	for i in b a '"$L"' y
+	do
+		echo $i
+	done >victim &&
+	cat victim >insert-a-expect &&
+	git diff victim >insert-a-patch.with &&
+	git diff --unified=0 >insert-a-patch.without &&
+
 	: modify at the head
 	for i in a '"$L"' y
 	do
@@ -55,7 +64,7 @@ test_expect_success setup '
 	git diff --unified=0 >add-z-patch.without &&
 
 	: modify at the tail
-	for i in a '"$L"' y
+	for i in b '"$L"' z
 	do
 		echo $i
 	done >victim &&
@@ -81,7 +90,7 @@ do
 	with) u= ;;
 	without) u='--unidiff-zero ' ;;
 	esac
-	for kind in add-a add-z mod-a mod-z del-a del-z
+	for kind in add-a add-z insert-a mod-a mod-z del-a del-z
 	do
 		test_expect_success "apply $kind-patch $with context" '
 			cat original >victim &&
@@ -95,7 +104,7 @@ do
 	done
 done
 
-for kind in add-a add-z mod-a mod-z del-a del-z
+for kind in add-a add-z insert-a mod-a mod-z del-a del-z
 do
 	rm -f $kind-ng.without
 	sed	-e "s/^diff --git /diff /" \
-- 
1.6.0
