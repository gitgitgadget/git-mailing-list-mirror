From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/2] git-p4: test sync new branch
Date: Wed, 16 Mar 2011 16:53:53 -0400
Message-ID: <20110316205353.GB23387@arf.padd.com>
References: <20110316205008.GA22702@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Horowitz <michael.horowitz@ieee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:54:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzxjI-0008LL-PQ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab1CPUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:54:00 -0400
Received: from honk.padd.com ([74.3.171.149]:52775 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab1CPUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:53:59 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 1BA2D20B9;
	Wed, 16 Mar 2011 13:53:58 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1FD005AB92; Wed, 16 Mar 2011 16:53:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110316205008.GA22702@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169197>

Add two new unit tests.  One to test the feature that that
was added in e32e00d, and another to test the regression
that was fixed in the parent to this commit.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index abe7c64..a523473 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -61,6 +61,29 @@ test_expect_success 'git-p4 clone @all' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+test_expect_success 'git-p4 sync uninitialized repo' '
+	test_create_repo "$git" &&
+	cd "$git" &&
+	test_must_fail "$GITP4" sync &&
+	rm -rf "$git" && mkdir "$git"
+'
+
+#
+# Create a git repo by hand.  Add a commit so that HEAD is valid.
+# Test imports a new p4 repository into a new git branch.
+#
+test_expect_success 'git-p4 sync new branch' '
+	test_create_repo "$git" &&
+	cd "$git" &&
+	test_commit head &&
+	"$GITP4" sync --branch=refs/remotes/p4/depot //depot@all &&
+	git log --oneline p4/depot >lines &&
+	cat lines &&
+	test_line_count = 2 lines &&
+	cd .. &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'exit when p4 fails to produce marshaled output' '
 	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
 	mkdir -p "$badp4dir" &&
-- 
1.7.4.1
