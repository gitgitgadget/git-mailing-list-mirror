From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] demonstrate breakage of detached checkout with symbolic
 link HEAD
Date: Fri, 17 Oct 2008 16:10:00 -0700
Message-ID: <7vbpxihl87.fsf_-_@gitster.siamese.dyndns.org>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <20081016203916.GB9487@coredump.intra.peff.net>
 <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Draisey <matt@draisey.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:11:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqyTb-0000d7-RH
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbYJQXKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756588AbYJQXKL
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:10:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbYJQXKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:10:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAE6D70D84;
	Fri, 17 Oct 2008 19:10:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5C83770D81; Fri, 17 Oct 2008 19:10:03 -0400 (EDT)
In-Reply-To: <7vfxmuhlad.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 17 Oct 2008 16:08:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDF856FE-9CA0-11DD-9153-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98496>

When core.prefersymlinkrefs is in use, detaching the HEAD by
checkout incorrectly clobbers the tip of the current branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7201-co.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ee2cab6..01304d7 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -339,6 +339,18 @@ test_expect_success 'checkout w/--track from non-branch HEAD fails' '
     test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
 '
 
+test_expect_failure 'detch a symbolic link HEAD' '
+    git checkout master &&
+    git config --bool core.prefersymlinkrefs yes &&
+    git checkout side &&
+    git checkout master &&
+    it=$(git symbolic-ref HEAD) &&
+    test "z$it" = zrefs/heads/master &&
+    here=$(git rev-parse --verify refs/heads/master) &&
+    git checkout side^ &&
+    test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
+'
+
 test_expect_success 'checkout an unmerged path should fail' '
 	rm -f .git/index &&
 	O=$(echo original | git hash-object -w --stdin) &&
-- 
1.6.0.2.734.gae0be
