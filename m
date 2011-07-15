From: Phil Hord <hordp@cisco.com>
Subject: [PATCH/RFC] Add two basic tests for "rerere remaining"
Date: Fri, 15 Jul 2011 17:05:05 -0400
Message-ID: <4E20AB81.3050005@cisco.com>
References: <4E1F22DF.7060209@cisco.com> <4E20A0D9.4030404@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Bryan Larsen <bryan@larsen.st>,
	Eric Wong <normalperson@yhbt.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Olivier Marin <dkr@freesurf.fr>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhpZW-00086h-9F
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab1GOVFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:05:12 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:59648 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab1GOVFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2768; q=dns/txt;
  s=iport; t=1310763910; x=1311973510;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=6TTt9eWI001nARj9ULeL3zPqzlW9rr1BuBUH9F4D0LM=;
  b=Zh5nRBFl9EA47U21gvSVMkXweXYP4aEtFfomalaHxkti2a9xyPwdPl1X
   Vw0oBlRwCupkwQu0rE64r6z/1zfQLgmeLuulZNJxrhxqHFUFnSgQE2wIZ
   iTDz2pxjE7kdbZcAHXMahguwIj+80sKHuQEiiLQCEdU0zKqYobXCN/LmC
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqEFACeqIE6rRDoJ/2dsb2JhbABUp29wB60qniKGOgSSZoUBi24
X-IronPort-AV: E=Sophos;i="4.67,210,1309737600"; 
   d="scan'208";a="3431352"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by rcdn-iport-2.cisco.com with ESMTP; 15 Jul 2011 21:05:08 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p6FL55f3023907;
	Fri, 15 Jul 2011 21:05:06 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <4E20A0D9.4030404@cisco.com>
X-TagToolbar-Keys: D20110715170505416
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177231>

After a 'git stash apply' which results in a conflicted file,
git mergetool can be used to work on the conflicts.  However,
when rerere.enabled=true, git mergetool determines the list
of unresolved file conflicts by asking 'git rerere remaining'.

There is a problem with this because rerere does not record
the 'git stash apply' conflicts and so 'git rerere remaining'
does not report them.

Demonstrate this failing so it can be studied and addressed.

Also add a very basic test for 'git rerere remaining' after
a normal merge conflict.

Signed-off-by: Phil Hord <hordp@cisco.com>
---

This patch adds one failing test and one working test.

The working test is very limited and just repeats the
same test as the 'rerere status' one for 'rerere remaining'.
A better test should probably be added, one that demonstrates
and confirms the differences between 'rerere status' and
'rerere remaining'.  I don't understand this difference
well enough to code that test, though.
 
 t/t4200-rerere.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 36255d6..a96ebad 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -96,10 +96,42 @@ test_expect_success 'rerere.enabled works, too' '
 	grep ^=======$ $rr/preimage
 '
 
+test_expect_success 'set up conflicted stash apply' '
+	rm -rf .git/rr-cache &&
+	git config rerere.enabled true &&
+
+	git reset --hard &&
+	git checkout master &&
+	git show second:a1 >a1 &&
+
+	# should be 1 modified file and no unmerged files
+	test $(git ls-files -m |wc -l) = 1 &&
+	test $(git ls-files -u |wc -l) = 0 &&
+
+	git stash save &&
+	git checkout first &&
+
+	test_must_fail git stash apply &&
+
+	# there should be three states for one unresolved file
+	cnt=$(git ls-files -u | wc -l) &&
+	echo $cnt &&
+	test $cnt = 3
+'
+
+test_expect_failure 'rerere-remaining correctly reports stash-apply conflicts' '
+	echo a1 >expect &&
+	git rerere status >out &&
+	test_cmp expect out &&
+	git rerere remaining >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'set up rr-cache' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled true &&
 	git reset --hard &&
+	git checkout second &&
 	test_must_fail git merge first &&
 	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1
@@ -160,6 +192,12 @@ test_expect_success 'rerere status' '
 	test_cmp expect out
 '
 
+test_expect_success 'rerere remaining' '
+	echo a1 >expect &&
+	git rerere remaining >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'first postimage wins' '
 	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
-- 
1.7.6.8.gd2879
