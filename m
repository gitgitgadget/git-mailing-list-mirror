From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] Demonstrate git-show is broken with ranges
Date: Tue, 19 Jun 2012 22:04:57 +0200
Message-ID: <d3e839101b031a7208e74a0b6e22d343d5a093e9.1340136145.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:05:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4fn-0005WZ-LA
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 22:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab2FSUFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 16:05:06 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:2232 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab2FSUFE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 16:05:04 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 22:04:57 +0200
Received: from thomas.inf.ethz.ch (129.132.211.105) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Jun
 2012 22:04:59 +0200
X-Mailer: git-send-email 1.7.11.266.g2b10bc0
X-Originating-IP: [129.132.211.105]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200236>

The logic of git-show has remained largely unchanged since around
5d7eeee (git-show: grok blobs, trees and tags, too, 2006-12-14): start
a revision walker with no_walk=1, look at its pending objects and
handle them one-by-one.  For commits, this means stuffing them into a
new queue all alone, and running the walker.

Then Linus's f222abd (Make 'git show' more useful, 2009-07-13) came
along and set no_walk=0 whenever the user specifies a range.  Which
appears to work fine, until you actually prod it hard enough, as the
preceding commit shows: UNINTERESTING commits will be marked as such,
but not walked further to propagate the marks.

Demonstrate this with the main tests of this patch: 'showing a range
walks (Y shape)'.  The Y shape of history ensures that propagating the
UNINTERESTING marks is necessary to correctly exclude the main1
commit.  The only example I could find actually requires that the
negative revisions are listed later, and in this scenario a dotted
range actually works.  However, it is easy to find examples in git.git
where a dotted range is wrong, e.g.

  $ git show v1.7.0..v1.7.1 | grep ^commit | wc -l
  1297
  $ git rev-list v1.7.0..v1.7.1 | wc -l
  702

While there, also test a few other things that are not covered so far:
the -N way of triggering a range (added in 5853cae, DWIM 'git show -5'
to 'git show --do-walk -5', 2010-06-01), and the interactions of tags,
commits and ranges.

Pointed out by Dr_Memory on #git.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t7007-show.sh | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index cce222f..1c43963 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -17,4 +17,96 @@ test_expect_success 'showing a tag that point at a missing object' '
 	test_must_fail git --no-pager show foo-tag
 '
 
+test_expect_success 'set up a bit of history' '
+	test_commit main1 &&
+	test_commit main2 &&
+	test_commit main3 &&
+	git tag -m "annotated tag" annotated &&
+	git checkout -b side HEAD^^ &&
+	test_commit side2 &&
+	test_commit side3
+'
+
+test_expect_success 'showing two commits' '
+	cat >expect <<EOF &&
+commit $(git rev-parse main2)
+commit $(git rev-parse main3)
+EOF
+	git show main2 main3 >actual &&
+	grep ^commit actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_success 'showing a range walks (linear)' '
+	cat >expect <<EOF &&
+commit $(git rev-parse main3)
+commit $(git rev-parse main2)
+EOF
+	git show main1..main3 >actual &&
+	grep ^commit actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_success 'showing a range walks (Y shape, ^ first)' '
+	cat >expect <<EOF &&
+commit $(git rev-parse main3)
+commit $(git rev-parse main2)
+EOF
+	git show ^side3 main3 >actual &&
+	grep ^commit actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_failure 'showing a range walks (Y shape, ^ last)' '
+	cat >expect <<EOF &&
+commit $(git rev-parse main3)
+commit $(git rev-parse main2)
+EOF
+	git show main3 ^side3 >actual &&
+	grep ^commit actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_success 'showing with -N walks' '
+	cat >expect <<EOF &&
+commit $(git rev-parse main3)
+commit $(git rev-parse main2)
+EOF
+	git show -2 main3 >actual &&
+	grep ^commit actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_success 'showing annotated tag' '
+	cat >expect <<EOF &&
+tag annotated
+commit $(git rev-parse annotated^{commit})
+EOF
+	git show annotated >actual &&
+	grep -E "^(commit|tag)" actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_success 'showing annotated tag plus commit' '
+	cat >expect <<EOF &&
+tag annotated
+commit $(git rev-parse annotated^{commit})
+commit $(git rev-parse side3)
+EOF
+	git show annotated side3 >actual &&
+	grep -E "^(commit|tag)" actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
+test_expect_success 'showing annotated tag in range' '
+	cat >expect <<EOF &&
+tag annotated
+commit $(git rev-parse main3)
+commit $(git rev-parse main2)
+EOF
+	git show ^side3 annotated >actual &&
+	grep -E "^(commit|tag)" actual >actual.filtered &&
+	test_cmp expect actual.filtered
+'
+
 test_done
-- 
1.7.11.266.g2b10bc0
