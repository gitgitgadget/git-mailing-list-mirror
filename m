From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] diffcore-rename: don't consider unmerged path as source
Date: Wed, 23 Mar 2011 22:41:01 -0400
Message-ID: <1300934461-28867-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 03:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2aVG-0007vb-2C
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 03:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab1CXCmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 22:42:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62562 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab1CXCmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 22:42:04 -0400
Received: by vws1 with SMTP id 1so6164743vws.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Iyv1fg6PZVqHyaEHwocDRo1/mi+WODyu9lm/iKRkT9Q=;
        b=OE5Zz77j9veXlWXga5wL5mCJcTM9K+sTbhABIoKiTk+iftZ0bG8301YcJvF/B3DFb/
         IWf79elwL5tQbLJsekDZLFFKqCea5dRuj1Q3vdU5HVvgYbAGu3toTygw0mZIazFoYfT6
         ct4lilo6T6/t51x/2Xgkgtc+kxz6p8vJYPTFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JUyJ1NKr5UrgkVIphWKVHR1kyJMcdsLM7A7cl+R/UzWPGUeujpsupeHZzhB5VKNfke
         O0cZbxPIDWJs77NraeERUR48z6ZjDXPjKrRaLzGjUPTaNNiyxXoRSYInDshV9lhPAXT4
         CmvmY8ZUEoOUeDicsSmyckfY6WnFLNYRKwVS8=
Received: by 10.52.88.136 with SMTP id bg8mr388822vdb.78.1300934507912;
        Wed, 23 Mar 2011 19:41:47 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id w26sm1908239vcf.21.2011.03.23.19.41.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 19:41:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1300412548-1724-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169887>

Since e9c8409 (diff-index --cached --raw: show tree entry on the LHS for
unmerged entries., 2007-01-05), an unmerged entry should be detected by
using DIFF_PAIR_UNMERGED(p), not by noticing both one and two sides of
the filepair records mode=0 entries. However, it forgot to update some
parts of the rename detection logic.

This only makes difference in the "diff --cached" codepath where an
unmerged filepair carries information on the entries that came from the
tree.  It probably hasn't been noticed for a long time because nobody
would run "diff -M" during a conflict resolution, but "git status" uses
rename detection when it internally runs "diff-index" and "diff-files"
and gives nonsense results.

In an unmerged pair, "one" side can have a valid filespec to record the
tree entry (e.g. what's in HEAD) when running "diff --cached". This can
be used as a rename source to other paths in the index that are not
unmerged. The path that is unmerged by definition does not have the
final content yet (i.e. "two" side cannot have a valid filespec), so it
can never be a rename destination.

Use the DIFF_PAIR_UNMERGED() to detect unmerged filepair correctly, and
allow the valid "one" side of an unmerged filepair to be considered a
potential rename source, but never to be considered a rename destination.

Commit message and first two test cases by Junio, the rest by Martin.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
I think I mean something slightly different when I say "don't consider
unmerged path as source" than you do when you say "allow the valid
"one" side of an unmerged filepair to be considered a potential rename
source". I mean that they shouldn't show up on the LHS of a "copied: A
-> B" line in git-status output. I think you mean that they should be
registered as rename sources, even though the destination will always
be the file itself, so other files will only end up having status
COPIED. I didn't know how phrase the subject line in a better way, but
feel free to change it as you like.


 diffcore-rename.c   |    7 ++++-
 t/t7060-wtstatus.sh |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0cd4c13..c53ca36 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -464,7 +464,7 @@ void diffcore_rename(struct diff_options *options)
 			else
 				locate_rename_dst(p->two, 1);
 		}
-		else if (!DIFF_FILE_VALID(p->two)) {
+		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
 			 * If the source is a broken "delete", and
 			 * they did not really want to get broken,
@@ -575,7 +575,10 @@ void diffcore_rename(struct diff_options *options)
 		struct diff_filepair *p = q->queue[i];
 		struct diff_filepair *pair_to_free = NULL;
 
-		if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
+		if (DIFF_PAIR_UNMERGED(p)) {
+			diff_q(&outq, p);
+		}
+		else if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			/*
 			 * Creation
 			 *
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index fcac472..48b751e 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -56,4 +56,63 @@ test_expect_success 'M/D conflict does not segfault' '
 	)
 '
 
+test_expect_success 'rename & unmerged setup' '
+	git rm -f -r . &&
+	cat "$TEST_DIRECTORY/README" >ONE &&
+	git add ONE &&
+	test_tick &&
+	git commit -m "One commit with ONE" &&
+
+	echo Modified >TWO &&
+	cat ONE >>TWO &&
+	cat ONE >>THREE &&
+	git add TWO THREE &&
+	sha1=$(git rev-parse :ONE) &&
+	git rm --cached ONE &&
+	(
+		echo "100644 $sha1 1	ONE" &&
+		echo "100644 $sha1 2	ONE" &&
+		echo "100644 $sha1 3	ONE"
+	) | git update-index --index-info &&
+	echo Further >>THREE
+'
+
+test_expect_success 'rename & unmerged status' '
+	git status -suno >actual &&
+	cat >expect <<-EOF &&
+	UU ONE
+	AM THREE
+	A  TWO
+	EOF
+	test_cmp expect actual
+'
+
+cat >expected <<\EOF
+U	ONE
+A	THREE
+A	TWO
+EOF
+
+test_expect_success 'git diff-index --cached shows 2 added + 1 unmerged' '
+	git diff-index --cached --name-status HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git diff-index --cached -M shows 2 added + 1 unmerged' '
+	git diff-index --cached --name-status HEAD >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+U	ONE
+C	ONE	THREE
+C	ONE	TWO
+EOF
+
+test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
+	git diff-index --cached -C --name-status HEAD |
+		sed "s/^C[0-9]*/C/g" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.4.79.gcbe20
