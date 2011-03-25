From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] t7607: clean up stray untracked file
Date: Fri, 25 Mar 2011 14:09:03 -0400
Message-ID: <20110325180903.GB14898@sigill.intra.peff.net>
References: <20110325180644.GA30838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "igor.mikushkin" <igor.mikushkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BRj-0005IS-3S
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab1CYSJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 14:09:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50408
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172Ab1CYSJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 14:09:05 -0400
Received: (qmail 16249 invoked by uid 107); 25 Mar 2011 18:09:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 14:09:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 14:09:03 -0400
Content-Disposition: inline
In-Reply-To: <20110325180644.GA30838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170009>

This file ends up conflicting with the test just after it
(causing the "git merge" to fail).  Neither test is to blame
for the bug, though. It looks like the merge in 1a9fe45
(Merge branch 'tr/merge-unborn-clobber', 2011-02-09) is what
caused the conflict.

We didn't notice because the follow-on test is already
marked as expect_failure (even though it has since been
fixed, and now succeeds once the untracked file is moved out
of the way).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7607-merge-overwrite.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 691c5fd..c86e298 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -150,6 +150,7 @@ test_expect_success 'will not overwrite untracked file on unborn branch' '
 	git rm -fr . &&
 	git checkout --orphan new &&
 	cp important c0.c &&
+	test_when_finished "rm c0.c" &&
 	test_must_fail git merge c0 2>out &&
 	test_cmp out expect &&
 	test_path_is_missing .git/MERGE_HEAD &&
@@ -164,7 +165,7 @@ test_expect_success 'set up unborn branch and content' '
 	echo bar > untracked-file
 '
 
-test_expect_failure 'will not clobber WT/index when merging into unborn' '
+test_expect_success 'will not clobber WT/index when merging into unborn' '
 	git merge master &&
 	grep foo tracked-file &&
 	git show :tracked-file >expect &&
-- 
1.7.4.33.gb8855.dirty
