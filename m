From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] pull: do not clobber untracked files on initial pull
Date: Fri, 25 Mar 2011 14:13:31 -0400
Message-ID: <20110325181331.GD14898@sigill.intra.peff.net>
References: <20110325180644.GA30838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "igor.mikushkin" <igor.mikushkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:13:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BVy-00083f-Oa
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab1CYSNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 14:13:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36842
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab1CYSNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 14:13:33 -0400
Received: (qmail 16328 invoked by uid 107); 25 Mar 2011 18:14:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 14:14:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 14:13:31 -0400
Content-Disposition: inline
In-Reply-To: <20110325180644.GA30838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170011>

For a pull into an unborn branch, we do not use "git merge"
at all. Instead, we call read-tree directly. However, we
used the --reset parameter instead of "-m", which turns off
the safety features.

Signed-off-by: Jeff King <peff@peff.net>
---
This blames all the way back to d09e79c (git-pull: allow pulling into an
empty repository, 2006-11-16) by Linus. I couldn't think of a good
reason to use "--reset" instead of "-m".

 git-pull.sh     |    2 +-
 t/t5520-pull.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 63b063a..e31226b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -274,7 +274,7 @@ esac
 if test -z "$orig_head"
 then
 	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
-	git read-tree --reset -u HEAD || exit 1
+	git read-tree -m -u HEAD || exit 1
 	exit
 fi
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0470a81..0e5eb67 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -46,6 +46,17 @@ test_expect_success 'pulling into void using master:master' '
 	test_cmp file cloned-uho/file
 '
 
+test_expect_success 'pulling into void does not overwrite untracked files' '
+	git init cloned-untracked &&
+	(
+		cd cloned-untracked &&
+		echo untracked >file &&
+		test_must_fail git pull .. master &&
+		echo untracked >expect &&
+		test_cmp expect file
+	)
+'
+
 test_expect_success 'test . as a remote' '
 
 	git branch copy master &&
-- 
1.7.4.33.gb8855.dirty
